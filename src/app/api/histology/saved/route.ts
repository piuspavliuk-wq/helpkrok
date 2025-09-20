// API endpoint для збережених питань з гістології
// Файл: /api/histology/saved/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Отримати збережені питання з гістології користувача
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

    // Отримуємо збережені питання користувача
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
      .eq('question_type', 'histology')
      .order('saved_at', { ascending: false });

    if (savedError) {
      console.error('Помилка отримання збережених питань з гістології:', savedError);
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

// Зберегти питання з гістології користувача
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
      .from('histology_questions')
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
        question_type: 'histology',
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
      .eq('question_type', 'histology')
      .eq('question_id', questionId);

    if (deleteError) {
      console.error('Помилка видалення питання:', deleteError);
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
