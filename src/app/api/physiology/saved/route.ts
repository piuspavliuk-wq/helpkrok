// API endpoint для збережених питань з фізіології
// Файл: /api/physiology/saved/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання з фізіології користувача
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
      .from('user_saved_questions')
      .select(`
        id,
        saved_at,
        notes,
        question_id,
        question_type
      `)
      .eq('user_id', session.user.id)
      .eq('question_type', 'physiology')
      .order('saved_at', { ascending: false });

    if (savedError) {
      console.error('Помилка отримання збережених питань з фізіології:', savedError);
      
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

// Зберегти питання з фізіології користувача
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
      .from('physiology_questions')
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
        question_type: 'physiology',
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

    // Видаляємо зі збережених
    const { error: deleteError } = await supabase
      .from('user_saved_questions')
      .delete()
      .eq('user_id', session.user.id)
      .eq('question_type', 'physiology')
      .eq('question_id', questionId);

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
