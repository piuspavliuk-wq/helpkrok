import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';

export async function GET(request: NextRequest) {
  try {
    const supabase = createSupabaseClientForServer();
    
    // Отримуємо збережені питання (без авторизації для тесту)
    const { data: savedQuestions, error: savedError } = await supabase
      .from('user_saved_questions')
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
  try {
    const { questionId, questionType, notes } = await request.json();

    if (!questionId || !questionType) {
      return NextResponse.json(
        { error: 'ID питання та тип обов\'язкові' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Перевіряємо, чи існує питання
    const { data: question, error: questionError } = await supabase
      .from(`${questionType}_questions`)
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
      .from('user_saved_questions')
      .insert({
        user_id: 'test-user-123', // Тестовий ID
        question_type: questionType,
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