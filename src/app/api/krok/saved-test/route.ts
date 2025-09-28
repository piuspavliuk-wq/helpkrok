import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Тестовий endpoint для збереження питань без авторизації
export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('Test API called - GET');
    
    // Отримуємо збережені питання (без авторизації для тесту)
    const { data: savedQuestions, error: savedError } = await supabase
      .from('user_saved_krok_questions')
      .select('*')
      .order('saved_at', { ascending: false })
      .limit(10);

    if (savedError) {
      console.error('Помилка отримання збережених питань:', savedError);
      return NextResponse.json(
        { error: 'Помилка отримання збережених питань', details: savedError },
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
      { error: 'Внутрішня помилка сервера', details: error },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('Test API called - POST');
    const { questionId, notes } = await request.json();

    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    // Перевіряємо, чи існує питання
    const { data: question, error: questionError } = await supabase
      .from('krok_questions_unified')
      .select('id')
      .eq('id', questionId)
      .single();

    if (questionError || !question) {
      return NextResponse.json(
        { error: 'Питання не знайдено', details: questionError },
        { status: 404 }
      );
    }

    // Зберігаємо питання з тестовим user_id
    const { data: savedQuestion, error: saveError } = await supabase
      .from('user_saved_krok_questions')
      .insert({
        user_id: 'test-user-123', // Тестовий ID
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
        { error: 'Помилка збереження питання', details: saveError },
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
      { error: 'Внутрішня помилка сервера', details: error },
      { status: 500 }
    );
  }
}

export async function DELETE(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('Test API called - DELETE');
    const { searchParams } = new URL(request.url);
    const questionId = searchParams.get('questionId');

    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    // Видаляємо збережене питання
    const { error: deleteError } = await supabase
      .from('user_saved_krok_questions')
      .delete()
      .eq('user_id', 'test-user-123')
      .eq('question_id', questionId);

    if (deleteError) {
      console.error('Помилка видалення збереженого питання:', deleteError);
      return NextResponse.json(
        { error: 'Помилка видалення збереженого питання', details: deleteError },
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
      { error: 'Внутрішня помилка сервера', details: error },
      { status: 500 }
    );
  }
}
