import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';

export async function GET(request: NextRequest) {
  try {
    const supabase = createSupabaseClientForServer();
    
    // Отримуємо всі питання через пагінацію для повної статистики
    const allQuestions = [];
    let from = 0;
    const pageSize = 1000;
    
    while (true) {
      const result = await supabase
        .from('krok_questions_unified')
        .select('*')
        .eq('is_active', true)
        .range(from, from + pageSize - 1);
      
      if (result.error) {
        console.error('Помилка отримання питань:', result.error);
        return NextResponse.json({ error: 'Помилка отримання питань' }, { status: 500 });
      }
      
      if (!result.data || result.data.length === 0) {
        break;
      }
      
      allQuestions.push(...result.data);
      from += pageSize;
      
      if (result.data.length < pageSize) {
        break;
      }
    }
    
    // Статистика по роках
    const yearStats = allQuestions.reduce((acc: any, question: any) => {
      const year = question.year;
      acc[year] = (acc[year] || 0) + 1;
      return acc;
    }, {});
    
    // Статистика по факультетах
    const facultyStats = allQuestions.reduce((acc: any, question: any) => {
      const faculty = question.faculty;
      acc[faculty] = (acc[faculty] || 0) + 1;
      return acc;
    }, {});
    
    // Статистика по категоріях
    const categoryStats = allQuestions.reduce((acc: any, question: any) => {
      const category = question.category;
      acc[category] = (acc[category] || 0) + 1;
      return acc;
    }, {});
    
    // Статистика по рівнях складності
    const difficultyStats = allQuestions.reduce((acc: any, question: any) => {
      const difficulty = question.difficulty;
      acc[difficulty] = (acc[difficulty] || 0) + 1;
      return acc;
    }, {});
    
    // Питання з повними варіантами відповідей
    const validQuestions = allQuestions.filter(q => 
      q.option_a && q.option_b && q.option_c && q.option_d && q.correct_answer
    );
    
    return NextResponse.json({
      success: true,
      statistics: {
        totalQuestions: allQuestions.length,
        validQuestions: validQuestions.length,
        yearBreakdown: yearStats,
        facultyBreakdown: facultyStats,
        categoryBreakdown: categoryStats,
        difficultyBreakdown: difficultyStats,
        topCategories: Object.entries(categoryStats)
          .sort(([,a], [,b]) => (b as number) - (a as number))
          .slice(0, 10)
          .map(([category, count]) => ({ category, count }))
      }
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json({ error: 'Внутрішня помилка сервера' }, { status: 500 });
  }
}
