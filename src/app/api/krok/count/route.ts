import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';

export async function GET(request: NextRequest) {
  try {
    const supabase = createSupabaseClientForServer();
    
    // Отримуємо загальну кількість питань
    const { count: totalCount, error: totalError } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true })
      .eq('is_active', true);

    if (totalError) {
      console.error('Помилка підрахунку питань:', totalError);
      return NextResponse.json({ error: 'Помилка підрахунку питань' }, { status: 500 });
    }

    // Отримуємо кількість питань з варіантами відповідей
    const { count: validCount, error: validError } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true })
      .eq('is_active', true)
      .not('option_a', 'is', null)
      .not('option_b', 'is', null)
      .not('option_c', 'is', null)
      .not('option_d', 'is', null)
      .not('correct_answer', 'is', null);

    if (validError) {
      console.error('Помилка підрахунку валідних питань:', validError);
      return NextResponse.json({ error: 'Помилка підрахунку валідних питань' }, { status: 500 });
    }

    // Отримуємо статистику по роках
    const { data: yearStats, error: yearError } = await supabase
      .from('krok_questions_unified')
      .select('year')
      .eq('is_active', true)
      .not('option_a', 'is', null)
      .not('option_b', 'is', null)
      .not('option_c', 'is', null)
      .not('option_d', 'is', null)
      .not('correct_answer', 'is', null);

    if (yearError) {
      console.error('Помилка отримання статистики по роках:', yearError);
      return NextResponse.json({ error: 'Помилка отримання статистики по роках' }, { status: 500 });
    }

    // Групуємо по роках
    const yearCounts = yearStats?.reduce((acc: any, item: any) => {
      const year = item.year;
      acc[year] = (acc[year] || 0) + 1;
      return acc;
    }, {}) || {};

    // Отримуємо статистику по факультетах
    const { data: facultyStats, error: facultyError } = await supabase
      .from('krok_questions_unified')
      .select('faculty')
      .eq('is_active', true)
      .not('option_a', 'is', null)
      .not('option_b', 'is', null)
      .not('option_c', 'is', null)
      .not('option_d', 'is', null)
      .not('correct_answer', 'is', null);

    if (facultyError) {
      console.error('Помилка отримання статистики по факультетах:', facultyError);
      return NextResponse.json({ error: 'Помилка отримання статистики по факультетах' }, { status: 500 });
    }

    // Групуємо по факультетах
    const facultyCounts = facultyStats?.reduce((acc: any, item: any) => {
      const faculty = item.faculty;
      acc[faculty] = (acc[faculty] || 0) + 1;
      return acc;
    }, {}) || {};

    return NextResponse.json({
      success: true,
      statistics: {
        totalQuestions: totalCount || 0,
        validQuestions: validCount || 0,
        yearBreakdown: yearCounts,
        facultyBreakdown: facultyCounts
      }
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json({ error: 'Внутрішня помилка сервера' }, { status: 500 });
  }
}
