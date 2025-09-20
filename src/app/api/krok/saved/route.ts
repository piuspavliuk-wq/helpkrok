import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання користувача
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Отримуємо збережені питання користувача з повною інформацією
    const { data: savedQuestions, error: savedError } = await supabase
      .from('user_saved_krok_questions')
      .select(`
        id,
        saved_at,
        notes,
        krok_questions (
          id,
          question_number,
          question_text,
          category,
          difficulty_level
        )
      `)
      .eq('user_id', session.user.id)
      .order('saved_at', { ascending: false });

    if (savedError) {
      console.error('Помилка отримання збережених питань:', savedError);
      return NextResponse.json(
        { error: 'Помилка отримання збережених питань' },
        { status: 500 }
      );
    }

    // Отримуємо відповіді для збережених питань
    const questionIds = savedQuestions?.map(sq => sq.krok_questions?.id).filter(Boolean) || [];
    console.log('Saved questions:', savedQuestions?.length);
    console.log('Question IDs:', questionIds);
    let answers = [];
    
    if (questionIds.length > 0) {
      const { data: answersData, error: answersError } = await supabase
        .from('krok_answers')
        .select('*')
        .in('question_id', questionIds)
        .order('question_id, answer_option');

      if (answersError) {
        console.error('Помилка отримання відповідей:', answersError);
      } else {
        answers = answersData || [];
        console.log('Answers loaded:', answers.length);
      }
    }

    return NextResponse.json({
      success: true,
      savedQuestions: savedQuestions || [],
      answers: answers,
      totalSaved: savedQuestions?.length || 0
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

// Зберегти питання користувача
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { questionId, notes } = await request.json();

    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Перевіряємо, чи існує питання
    const { data: question, error: questionError } = await supabase
      .from('krok_questions')
      .select('id')
      .eq('id', questionId)
      .single();

    if (questionError || !question) {
      return NextResponse.json(
        { error: 'Питання не знайдено' },
        { status: 404 }
      );
    }

    // Зберігаємо питання
    const { data: savedQuestion, error: saveError } = await supabase
      .from('user_saved_krok_questions')
      .insert({
        user_id: session.user.id,
        question_id: questionId,
        notes: notes || null
      })
      .select()
      .single();

    if (saveError) {
      // Якщо питання вже збережено, повертаємо успішну відповідь
      if (saveError.code === '23505') { // Unique constraint violation
        return NextResponse.json({
          success: true,
          message: 'Питання вже збережено',
          alreadySaved: true
        });
      }
      
      console.error('Помилка збереження питання:', saveError);
      return NextResponse.json(
        { error: 'Помилка збереження питання' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: 'Питання успішно збережено',
      savedQuestion
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

// Видалити збережене питання
export async function DELETE(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url);
    const questionId = searchParams.get('questionId');

    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Видаляємо збережене питання
    const { error: deleteError } = await supabase
      .from('user_saved_krok_questions')
      .delete()
      .eq('user_id', session.user.id)
      .eq('question_id', questionId);

    if (deleteError) {
      console.error('Помилка видалення збереженого питання:', deleteError);
      return NextResponse.json(
        { error: 'Помилка видалення збереженого питання' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: 'Питання видалено зі збережених'
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
