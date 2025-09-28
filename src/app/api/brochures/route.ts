import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const faculty = searchParams.get('faculty') || 'medical';
    const year = searchParams.get('year');
    const userId = searchParams.get('userId') || 'test-user-123'; // Для тестування

    // Отримуємо роки та кількість питань через групування
    let yearGroups: any = {};

    try {
      // Використовуємо RPC функцію для отримання всіх років
      const { data: yearData, error } = await supabase
        .rpc('get_krok_years', { p_faculty: faculty });

      if (error) {
        console.error('Error fetching years:', error);
        // Fallback до простого запиту з підтримкою категорій
        const { data: fallbackData, error: fallbackError } = await supabase
          .from('krok_questions_unified')
          .select('year, category')
          .eq('faculty', faculty)
          .eq('is_active', true)
          .limit(1000);

        if (fallbackError) {
          console.error('Fallback error:', fallbackError);
          return NextResponse.json(
            { error: 'Failed to fetch years' },
            { status: 500 }
          );
        }

        // Групуємо fallback дані за роком та категорією
        const categoryGroups: any = {};
        fallbackData.forEach((question: any) => {
          const key = `${question.year}_${question.category}`;
          if (!categoryGroups[key]) {
            categoryGroups[key] = {
              year: question.year,
              category: question.category,
              count: 0
            };
          }
          categoryGroups[key].count++;
        });

        // Конвертуємо в yearGroups для сумісності
        yearGroups = {};
        Object.values(categoryGroups).forEach((group: any) => {
          yearGroups[group.year] = (yearGroups[group.year] || 0) + group.count;
        });

        console.log('Using fallback data, year groups:', yearGroups);
      } else {
        // Створюємо об'єкт з роками та кількістю питань
        yearGroups = yearData.reduce((acc: any, item: any) => {
          acc[item.year] = item.question_count;
          return acc;
        }, {});

        console.log('Using RPC data, year groups:', yearGroups);
      }
    } catch (err) {
      console.error('Error in year fetching:', err);
      return NextResponse.json(
        { error: 'Failed to fetch years' },
        { status: 500 }
      );
    }


    // Отримуємо прогрес користувача з user_test_progress
    let userProgress: Record<string, { completed_questions: number; total_questions: number }> = {};
    
    try {
      console.log('Fetching progress for userId:', userId);
      
      // Отримуємо прогрес з user_progress_test (основні дані)
      const { data: progressData, error: progressError } = await supabase
        .from('user_progress_test')
        .select('year, faculty, completed_questions, total_questions')
        .eq('user_id', userId)
        .eq('faculty', faculty);

      console.log('Progress data from user_progress_test:', progressData);
      console.log('Progress error:', progressError);

      if (!progressError && progressData) {
        // Конвертуємо дані в потрібний формат
        progressData.forEach((item: any) => {
          const key = `${item.year}_${item.faculty}`;
          userProgress[key] = {
            completed_questions: item.completed_questions,
            total_questions: item.total_questions
          };
        });
      }
    } catch (error) {
      console.error('Error fetching user progress:', error);
    }

    const booklets = Object.entries(yearGroups).map(([year, count]) => {
      const progressKey = `${year}_${faculty}`;
      const progress = userProgress[progressKey];
      const totalQuestions = count as number;
      
      
      return {
        id: `krok-${year}-${faculty}`,
        year: parseInt(year),
        faculty: faculty,
        title: `КРОК ${year} - ${faculty === 'medical' ? 'Медичний' : 'Фармацевтичний'} факультет`,
        description: `Тест КРОК ${year} року для ${faculty === 'medical' ? 'медичного' : 'фармацевтичного'} факультету`,
        totalQuestions: totalQuestions,
        completedQuestions: progress ? progress.completed_questions : 0,
        hasProgress: true,
        isCompleted: progress ? progress.completed_questions >= totalQuestions : false,
        is_active: true,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };
    });

    // Сортуємо за роком (найновіші спочатку)
    booklets.sort((a, b) => b.year - a.year);

    return NextResponse.json({ booklets });
  } catch (error) {
    console.error('Error in brochures API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { year, faculty, title, description, total_questions } = body;

    const { data: booklet, error } = await supabase
      .from('year_booklets')
      .insert({
        year,
        faculty,
        title,
        description,
        total_questions,
        is_active: true
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating booklet:', error);
      return NextResponse.json(
        { error: 'Failed to create booklet' },
        { status: 500 }
      );
    }

    return NextResponse.json({ booklet });
  } catch (error) {
    console.error('Error in brochures POST API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
