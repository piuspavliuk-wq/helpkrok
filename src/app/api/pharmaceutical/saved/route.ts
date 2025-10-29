// API endpoint для збережeniх питань з фармації
// Файл: /api/pharmaceutical/saved/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання з фармації користувача
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url);
    const subject = searchParams.get('subject'); // analytical_chemistry, organic_chemistry, etc.

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Supabase configuration missing' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

    let query = supabase
      .from('user_saved_questions')
      .select(`
        id,
        saved_at,
        notes,
        question_id,
        question_type
      `)
      .eq('user_id', session.user.id)
      .eq('question_type', 'pharmaceutical')
      .order('saved_at', { ascending: false });

    const { data: savedQuestions, error: savedError } = await query;

    if (savedError) {
      console.error('Помилка отримання збережених питань з фармації:', savedError);
      
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

    // Фільтруємо за предметом, якщо вказано
    let filteredQuestions = savedQuestions || [];
    if (subject) {
      // Отримуємо питання конкретного предмету з таблиці pharmaceutical_questions
      const { data: questionsIds } = await supabase
        .from('pharmaceutical_questions')
        .select('id')
        .eq('subject', subject);
      
      const validIds = questionsIds?.map(q => q.id.toString()) || []; // Конвертуємо UUID в рядки
      filteredQuestions = savedQuestions?.filter(sq => validIds.includes(sq.question_id)) || [];
    }

    return NextResponse.json({
      success: true,
      savedQuestions: filteredQuestions,
      totalSaved: filteredQuestions.length
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

// Зберегти питання з фармації користувача
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

    // Перевіряємо, чи існує питання в таблиці pharmaceutical_questions
    console.log('Checking if question exists:', questionId);
    const { data: question, error: questionError } = await supabase
      .from('pharmaceutical_questions')
      .select('id')
      .eq('id', questionId)
      .single();

    console.log('Question check result:', { question, questionError });

    if (questionError || !question) {
      console.error('Question not found:', questionError);
      return NextResponse.json(
        { error: 'Питання не знайдено в pharmaceutical_questions', details: questionError },
        { status: 404 }
      );
    }

    // Зберігаємо питання
    console.log('Saving question to user_saved_questions:', {
      user_id: session.user.id,
      question_type: 'pharmaceutical',
      question_id: questionId,
      notes: notes || null
    });

    // Для фармацевтичних питань використовуємо UUID як рядок
    const { data: savedQuestion, error: saveError } = await supabase
      .from('user_saved_questions')
      .insert({
        user_id: session.user.id,
        question_type: 'pharmaceutical',
        question_id: questionId.toString(), // Конвертуємо UUID в рядок
        notes: notes || null
      })
      .select()
      .single();

    console.log('Save result:', { savedQuestion, saveError });

    if (saveError) {
      // Якщо питання вже збережено, повертаємо успішну відповідь
      if (saveError.code === '23505') { // Unique constraint violation
        return NextResponse.json({
          success: true,
          message: 'Питання вже збережено',
          alreadySaved: true
        });
      }
      
      console.error('Помилка збереження питання з фармації:', saveError);
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

// Видалити збережене питання з фармації
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

    const { error: deleteError } = await supabase
      .from('user_saved_questions')
      .delete()
      .eq('user_id', session.user.id)
      .eq('question_type', 'pharmaceutical')
      .eq('question_id', questionId.toString()); // Конвертуємо UUID в рядок

    if (deleteError) {
      console.error('Помилка видалення збереженого питання з фармації:', deleteError);
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
