// API для роботи з прогресом користувача
import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// GET - отримати прогрес користувача
export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);
  try {
    const { searchParams } = new URL(request.url);
    const userId = searchParams.get('userId') || 'test-user-123'; // Для тестування
    const year = searchParams.get('year');
    const faculty = searchParams.get('faculty') || 'medical';

    let query = supabase
      .from('user_krok_progress')
      .select('*')
      .eq('user_id', userId);

    if (year) {
      query = query.eq('year', parseInt(year));
    }
    if (faculty) {
      query = query.eq('faculty', faculty);
    }

    const { data: progress, error } = await query;

    if (error) {
      console.error('Помилка отримання прогресу:', error);
      return NextResponse.json({ error: 'Помилка отримання прогресу' }, { status: 500 });
    }

    return NextResponse.json({
      success: true,
      progress: progress || []
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json({ error: 'Внутрішня помилка сервера' }, { status: 500 });
  }
}

// POST - оновити прогрес користувача
export async function POST(request: NextRequest) {
  try {
    const { userId, year, faculty, completedQuestions, totalQuestions } = await request.json();

    if (!userId || !year || !faculty || completedQuestions === undefined || !totalQuestions) {
      return NextResponse.json({ error: 'Відсутні обов\'язкові поля' }, { status: 400 });
    }

    // Перевіряємо чи існує запис
    const { data: existing } = await supabase
      .from('user_krok_progress')
      .select('id')
      .eq('user_id', userId)
      .eq('year', year)
      .eq('faculty', faculty)
      .single();

    let result;
    if (existing) {
      // Оновлюємо існуючий запис
      const { data, error } = await supabase
        .from('user_krok_progress')
        .update({
          completed_questions: completedQuestions,
          total_questions: totalQuestions,
          last_updated: new Date().toISOString()
        })
        .eq('id', existing.id)
        .select()
        .single();

      if (error) throw error;
      result = data;
    } else {
      // Створюємо новий запис
      const { data, error } = await supabase
        .from('user_krok_progress')
        .insert({
          user_id: userId,
          year: year,
          faculty: faculty,
          completed_questions: completedQuestions,
          total_questions: totalQuestions
        })
        .select()
        .single();

      if (error) throw error;
      result = data;
    }

    return NextResponse.json({
      success: true,
      progress: result
    });

  } catch (error) {
    console.error('Помилка оновлення прогресу:', error);
    return NextResponse.json({ error: 'Помилка оновлення прогресу' }, { status: 500 });
  }
}