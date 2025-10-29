import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY!
const supabase = createClient(supabaseUrl, supabaseKey)

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty') as 'medical' | 'pharmaceutical' | null
    const userId = searchParams.get('userId') || 'test-user-123'

    if (!faculty) {
      return NextResponse.json(
        { error: 'Faculty parameter is required' },
        { status: 400 }
      )
    }

    // Отримуємо окремі тести з krok_questions_unified
    let testGroups: Array<{
      id: string, 
      title: string, 
      year: number, 
      faculty: string, 
      question_count: number,
      category?: string
    }> = []
    
    try {
      // Отримуємо всі питання з роками та факультетами
      const { data: testData, error: testError } = await supabase
        .from('krok_questions_unified')
        .select('year, faculty')
        .eq('faculty', faculty)
        .eq('is_active', true);

      if (testError) {
        throw testError;
      }

      // Групуємо по роках та створюємо кілька тестів на рік
      const yearGroups = testData.reduce((acc: any, question: any) => {
        const key = `${question.year}_${question.faculty}`;
        if (!acc[key]) {
          acc[key] = {
            year: question.year,
            faculty: question.faculty,
            count: 0
          };
        }
        acc[key].count++;
        return acc;
      }, {});

      // Створюємо кілька тестів для кожного року
      testGroups = [];
      Object.values(yearGroups).forEach((yearData: any) => {
        const year = yearData.year;
        const totalQuestions = yearData.count;
        
        // Визначаємо кількість тестів та розподіляємо питання
        let testConfigs = [];
        
        if (year === 2025) {
          testConfigs = [
            { name: 'іноземці', questions: Math.floor(totalQuestions * 0.3) },
            { name: '2 д (TEXT)', questions: Math.floor(totalQuestions * 0.1) },
            { name: '2 д (Eng)', questions: Math.floor(totalQuestions * 0.1) },
            { name: '2 д', questions: Math.floor(totalQuestions * 0.2) },
            { name: '1 д (TEXT)', questions: Math.floor(totalQuestions * 0.1) },
            { name: '1 д (Eng)', questions: Math.floor(totalQuestions * 0.1) },
            { name: '1 д', questions: Math.floor(totalQuestions * 0.1) }
          ];
        } else if (year === 2024) {
          testConfigs = [
            { name: '2 день (TEXT)', questions: Math.floor(totalQuestions * 0.08) },
            { name: '1 день (TEXT)', questions: Math.floor(totalQuestions * 0.08) },
            { name: '2 день (Eng)', questions: Math.floor(totalQuestions * 0.08) },
            { name: '1 день (Eng)', questions: Math.floor(totalQuestions * 0.08) },
            { name: '2 день 2в', questions: Math.floor(totalQuestions * 0.12) },
            { name: '2 день 1в', questions: Math.floor(totalQuestions * 0.12) },
            { name: '1 день 2в', questions: Math.floor(totalQuestions * 0.12) },
            { name: '1 день 1в', questions: Math.floor(totalQuestions * 0.12) },
            { name: 'нові-3', questions: Math.floor(totalQuestions * 0.1) },
            { name: 'нові-2', questions: Math.floor(totalQuestions * 0.1) },
            { name: 'нові-1', questions: Math.floor(totalQuestions * 0.1) }
          ];
        } else if (year === 2023) {
          testConfigs = [
            { name: 'рік (TEXT)', questions: totalQuestions }
          ];
        } else {
          testConfigs = [
            { name: 'тест', questions: totalQuestions }
          ];
        }

        // Створюємо тести для цього року
        testConfigs.forEach((config, index) => {
          const title = year === 2025 ? `${year}${config.name}` : 
                       year === 2024 ? `${year}р ${config.name}` :
                       year === 2023 ? `${year} ${config.name}` :
                       `${year}р ${config.name}`;
          
          testGroups.push({
            id: `krok-${year}-${index}-${yearData.faculty}`,
            title: title,
            year: year,
            faculty: yearData.faculty,
            question_count: config.questions
          });
        });
      });

      // Сортуємо за роком (найновіші спочатку)
      testGroups.sort((a, b) => b.year - a.year);

      console.log('Individual test groups:', testGroups);

    } catch (err) {
      console.error('Error in test fetching:', err);
      return NextResponse.json(
        { error: 'Failed to fetch tests' },
        { status: 500 }
      )
    }

    // Отримуємо прогрес користувача
    let userProgress: Record<string, { completed_questions: number; total_questions: number }> = {}
    
    try {
      console.log('Fetching progress for userId:', userId)
      
      const { data: progressData, error: progressError } = await supabase
        .from('user_progress_test')
        .select('year, faculty, completed_questions, total_questions')
        .eq('user_id', userId)
        .eq('faculty', faculty)

      console.log('Progress data from user_progress_test:', progressData)
      console.log('Progress error:', progressError)

      if (!progressError && progressData) {
        progressData.forEach((item: any) => {
          const key = `${item.year}_${item.faculty}`
          userProgress[key] = {
            completed_questions: item.completed_questions,
            total_questions: item.total_questions
          }
        })
      }
    } catch (error) {
      console.error('Error fetching user progress:', error)
    }

    // Формуємо буклети з прогресом
    const booklets = testGroups.map((test) => {
      const progressKey = `${test.year}_${test.faculty}`
      const progress = userProgress[progressKey]
      const totalQuestions = test.question_count
      
      return {
        id: test.id,
        year: test.year,
        faculty: test.faculty,
        category: test.category,
        title: test.title,
        description: `Тест ${test.title}`,
        totalQuestions: totalQuestions,
        completedQuestions: progress ? progress.completed_questions : 0,
        hasProgress: true,
        isCompleted: progress ? progress.completed_questions >= totalQuestions : false,
        is_active: true,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }
    })

    return NextResponse.json({ 
      success: true,
      booklets,
      total: booklets.length,
      faculty 
    })

  } catch (error) {
    console.error('Error in individual tests API:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
