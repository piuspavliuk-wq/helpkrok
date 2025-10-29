import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання з анатомії користувача
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    console.log('GET Session in /api/anatomy/saved:', session);
    console.log('GET User ID:', session?.user?.id);
    console.log('GET User email:', session?.user?.email);
    
    if (!session?.user?.id) {
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

    // Отримуємо збережені питання користувача з повною інформацією
    console.log('Querying saved questions for user:', session.user.id, 'type: anatomy');
    const { data: savedQuestions, error: savedError } = await supabase
      .from('user_saved_questions')
      .select(`
        id,
        saved_at,
        notes,
        question_id,
        question_type
      `)
      .eq('user_id', session.user.id)
      .eq('question_type', 'anatomy')
      .order('saved_at', { ascending: false });

    console.log('Query result:', { savedQuestions, savedError });

    if (savedError) {
      console.error('Помилка отримання збережених питань з анатомії:', savedError);
      
      // Якщо таблиця не існує, повертаємо порожній список
      if (savedError.code === '42P01') { // Table doesn't exist
        return NextResponse.json({
          success: true,
          savedQuestions: [],
          totalSaved: 0,
          message: 'Таблиця збережених питань ще не створена'
        });
      }
      
      return NextResponse.json(
        { error: 'Помилка отримання збережених питань' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      savedQuestions: savedQuestions || [],
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

// Зберегти питання з анатомії користувача
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    console.log('POST Session in /api/anatomy/saved:', session);
    console.log('POST User ID:', session?.user?.id);
    console.log('POST User email:', session?.user?.email);
    
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

    // Перевіряємо, чи існує питання
    const { data: question, error: questionError } = await supabase
      .from('anatomy_questions')
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
      .from('user_saved_questions')
      .insert({
        user_id: session.user.id,
        question_type: 'anatomy',
        question_id: questionId,
        notes: notes || null
      })
      .select()
      .single();

    if (saveError) {
      // Якщо таблиця не існує, повертаємо помилку
      if (saveError.code === '42P01') { // Table doesn't exist
        return NextResponse.json(
          { error: 'Таблиця збережених питань ще не створена. Зверніться до адміністратора.' },
          { status: 503 }
        );
      }
      
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

// Видалити питання зі збережених
export async function DELETE(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    console.log('DELETE Session in /api/anatomy/saved:', session);
    console.log('DELETE User ID:', session?.user?.id);
    console.log('DELETE User email:', session?.user?.email);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url);
    const questionId = searchParams.get('questionId');
    const savedQuestionId = searchParams.get('savedQuestionId'); // ID запису в таблиці збережених питань
    console.log('DELETE questionId:', questionId);
    console.log('DELETE savedQuestionId:', savedQuestionId);

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

    // Видаляємо зі збережених
    console.log('Attempting to delete question:', {
      user_id: session.user.id,
      question_type: 'anatomy',
      question_id: questionId,
      saved_question_id: savedQuestionId
    });
    
    let deleteQuery = supabase
      .from('user_saved_questions')
      .delete()
      .eq('user_id', session.user.id)
      .eq('question_type', 'anatomy');

    // Якщо є savedQuestionId, видаляємо конкретний запис
    if (savedQuestionId) {
      deleteQuery = deleteQuery.eq('id', savedQuestionId);
    } else {
      // Інакше видаляємо по question_id (стара логіка)
      deleteQuery = deleteQuery.eq('question_id', questionId);
    }

    const { error: deleteError } = await deleteQuery;

    console.log('Delete result:', { deleteError });

    if (deleteError) {
      console.error('Помилка видалення питання:', deleteError);
      
      // Якщо таблиця не існує, повертаємо помилку
      if (deleteError.code === '42P01') { // Table doesn't exist
        return NextResponse.json(
          { error: 'Таблиця збережених питань ще не створена. Зверніться до адміністратора.' },
          { status: 503 }
        );
      }
      
      return NextResponse.json(
        { error: 'Помилка видалення питання' },
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
