import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Конфігурація мов для тестів
const LANGUAGE_CONFIG = {
  '2024': {
    'medical': 'english',
    'pharmaceutical': 'ukrainian'
  },
  '2025': {
    'medical': 'ukrainian',
    'pharmaceutical': 'ukrainian'
  },
  '2023': {
    'medical': 'ukrainian',
    'pharmaceutical': 'ukrainian'
  },
  '2022': {
    'medical': 'ukrainian',
    'pharmaceutical': 'ukrainian'
  },
  '2021': {
    'medical': 'ukrainian',
    'pharmaceutical': 'ukrainian'
  },
  '2020': {
    'medical': 'ukrainian',
    'pharmaceutical': 'ukrainian'
  }
};

const TEST_IDENTIFIER_LANGUAGE = {
  '2024-microbiology-english': 'english',
  '2025-foreigners': 'english',
  '2024-day2': 'ukrainian'
};

// Кеш для буклетів (в пам'яті)
const brochuresCache = new Map<string, { data: any; timestamp: number }>();
const CACHE_DURATION = 5 * 60 * 1000; // 5 хвилин

export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);
  try {
    const { searchParams } = new URL(request.url);
    const faculty = searchParams.get('faculty') || 'medical';
    const year = searchParams.get('year');
    const userId = searchParams.get('userId') || 'test-user-123'; // Для тестування

    // Перевіряємо кеш
    const cacheKey = `brochures_${faculty}_${year || 'all'}`;
    const cached = brochuresCache.get(cacheKey);
    
    if (cached && (Date.now() - cached.timestamp) < CACHE_DURATION) {
      console.log('📦 Returning cached brochures data');
      return NextResponse.json(cached.data);
    }

    // Отримуємо роки та кількість питань через групування
    let yearGroups: any = {};

    try {
      // Використовуємо RPC для отримання років, потім деталі окремо
      const { data: yearData, error } = await supabase
        .rpc('get_krok_years', { p_faculty: faculty });

      if (error || !yearData || yearData.length === 0) {
        console.error('RPC Error:', error);
        return NextResponse.json({ error: 'Failed to fetch years' }, { status: 500 });
      }

      // Отримуємо роки з RPC
      const uniqueYears = yearData.map((item: any) => item.year).sort((a: number, b: number) => b - a);
      console.log('Found years from RPC:', uniqueYears);
      
      // Для кожного року отримуємо детальні дані з test_identifier
      const allTests: any[] = [];
      for (const year of uniqueYears) {
        const { data: yearTests, error: yearTestsError } = await supabase
          .from('krok_questions_unified')
          .select('year, test_identifier, title, description, category')
          .eq('faculty', faculty)
          .eq('is_active', true)
          .eq('year', year);

        if (!yearTestsError && yearTests) {
          allTests.push(...yearTests);
        }
      }

      const fallbackData = allTests;
      const fallbackError = null;

        if (fallbackError) {
          console.error('Fallback error:', fallbackError);
          return NextResponse.json(
            { error: 'Failed to fetch years' },
            { status: 500 }
          );
        }

        // Групуємо fallback дані за роком та test_identifier
        const testGroupsMap: any = {};
        fallbackData.forEach((question: any) => {
          const key = question.test_identifier || `${question.year}-${question.faculty}`;
          if (!testGroupsMap[key]) {
        testGroupsMap[key] = {
          year: question.year,
          faculty: question.faculty,
          test_identifier: question.test_identifier,
          category: question.category,
          title: question.title,
          description: question.description,
          count: 0
        };
          }
          testGroupsMap[key].count++;
        });

        // Встановлюємо мову за замовчуванням як українська
        Object.values(testGroupsMap).forEach((group: any) => {
          group.is_english = false; // За замовчуванням українська мова
        });

        // Конвертуємо в yearGroups для сумісності
        yearGroups = {};
        Object.values(testGroupsMap).forEach((group: any) => {
          const yearKey = group.year;
          if (!yearGroups[yearKey]) {
            yearGroups[yearKey] = [];
          }
          yearGroups[yearKey].push(group);
        });

        console.log('Using fallback data, year groups:', yearGroups);
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

    const booklets: any[] = [];
    
    // Обробляємо кожен рік
    Object.entries(yearGroups).forEach(([year, tests]: [string, any]) => {
      const yearNum = parseInt(year);
      
      if (Array.isArray(tests)) {
        // Якщо є кілька тестів на рік
        tests.forEach((test, index) => {
          const progressKey = `${year}_${faculty}_${test.test_identifier || 'default'}`;
          const progress = userProgress[progressKey];
          const totalQuestions = test.count;
          
          // Використовуємо title з бази даних або генеруємо
          let title = test.title || `${year}р`;
          
          // Спеціальна логіка для 2024р без test_identifier - робимо його англійським
          if (year === '2024' && !(test as any).test_identifier && !(test as any).title) {
            title = '2024р (Eng)';
          }
          
          // Якщо title не встановлено, генеруємо як раніше
          if (!test.title && test.test_identifier) {
            const identifier = test.test_identifier.replace(`${year}-`, '');
            
            if (identifier === 'microbiology-english') {
              title = `${year}р (Eng)`;  // Змінено з "2 день (Eng)" на просто "(Eng)"
            } else if (identifier === 'foreigners') {
              title = `${year}р іноземці`;
            } else if (identifier === 'day2') {
              title = `${year}р 2 день`;
            } else if (identifier === 'text') {
              title = `${year}р (TEXT)`;
            } else if (identifier === 'day2-text') {
              title = `${year}р 2 д (ТЕХТ)`;
            } else {
              title = `${year}р ${identifier}`;
            }
          } else if (!test.title && index > 0) {
            title = `${year}р ${index + 1}`;
          }
          
          booklets.push({
            id: `krok-${year}-${test.test_identifier || index}`,
            year: yearNum,
            faculty: faculty,
            test_identifier: test.test_identifier,
            title: title,
            description: test.description || null,
            totalQuestions: totalQuestions,
            completedQuestions: progress ? progress.completed_questions : 0,
            hasProgress: true,
            isCompleted: progress ? progress.completed_questions >= totalQuestions : false,
            is_active: true,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
          });
        });
      } else {
        // Якщо один тест на рік (стара логіка)
        const test = tests as any;
        const count = typeof test === 'number' ? test : test.count;
        const progressKey = `${year}_${faculty}`;
        const progress = userProgress[progressKey];
        
        // Використовуємо title з бази даних або генеруємо
        let title = (test && test.title) || `${year}р`;
        
        // Спеціальна логіка для 2024р - робимо його англійським
        if (year === '2024') {
          title = '2024р (Eng)';
        }
        
        booklets.push({
          id: `krok-${year}-${faculty}`,
          year: yearNum,
          faculty: faculty,
          test_identifier: null,
          title: title,
          description: null,
          totalQuestions: count,
          completedQuestions: progress ? progress.completed_questions : 0,
          hasProgress: true,
          isCompleted: progress ? progress.completed_questions >= count : false,
          is_active: true,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        });
      }
    });

    // Сортуємо за роком (найновіші спочатку), потім по test_identifier
    booklets.sort((a, b) => {
      if (b.year !== a.year) {
        return b.year - a.year;
      }
      // Якщо рік однаковий, сортуємо по test_identifier
      const aId = a.test_identifier || '';
      const bId = b.test_identifier || '';
      return aId.localeCompare(bId);
    });

    // Зберігаємо в кеш
    const responseData = { booklets };
    brochuresCache.set(cacheKey, {
      data: responseData,
      timestamp: Date.now()
    });
    
    console.log('💾 Cached brochures data for key:', cacheKey);

    return NextResponse.json(responseData);
  } catch (error) {
    console.error('Error in brochures API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

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
