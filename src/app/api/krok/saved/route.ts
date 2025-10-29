import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання користувача
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    console.log('Session in /api/krok/saved:', session);
    console.log('User ID:', session?.user?.id);
    console.log('User email:', session?.user?.email);
    
    if (!session?.user?.id) {
      console.log('No session or user ID found');
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Supabase configuration missing' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);
    console.log('Supabase client created');

    // Отримуємо збережені питання користувача (спрощена версія без JOIN)
    console.log('Querying user_saved_krok_questions for user:', session.user.id);
    const { data: savedQuestions, error: savedError } = await supabase
      .from('user_saved_krok_questions')
      .select(`
        id,
        saved_at,
        notes,
        question_id
      `)
      .eq('user_id', session.user.id)
      .order('saved_at', { ascending: false });

    console.log('Query result:', { savedQuestions, savedError });

    if (savedError) {
      console.error('Помилка отримання збережених питань:', savedError);
      return NextResponse.json(
        { error: 'Помилка отримання збережених питань' },
        { status: 500 }
      );
    }

    // Форматуємо відповідь у формат, сумісний з існуючими компонентами
    const formattedSavedQuestions = savedQuestions?.map(sq => ({
      id: sq.id,
      saved_at: sq.saved_at,
      notes: sq.notes,
      question_id: sq.question_id
    })) || [];

    console.log('Saved questions:', formattedSavedQuestions.length);

    return NextResponse.json({
      success: true,
      savedQuestions: formattedSavedQuestions,
      totalSaved: formattedSavedQuestions.length
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

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Supabase configuration missing' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

    // Перевіряємо, чи існує питання в єдиній таблиці
    const { data: question, error: questionError } = await supabase
      .from('krok_questions_unified')
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

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Supabase configuration missing' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

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