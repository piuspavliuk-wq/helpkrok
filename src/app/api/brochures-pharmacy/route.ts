import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

// Кеш для pharmacy буклетів (в пам'яті)
const pharmacyBrochuresCache = new Map<string, { data: any; timestamp: number }>();
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
    const faculty = searchParams.get('faculty') || 'pharmacy';
    const year = searchParams.get('year');
    const userId = searchParams.get('userId') || 'test-user-123';

    // Перевіряємо кеш
    const cacheKey = `pharmacy_brochures_${faculty}_${year || 'all'}`;
    const cached = pharmacyBrochuresCache.get(cacheKey);
    
    if (cached && (Date.now() - cached.timestamp) < CACHE_DURATION) {
      console.log('📦 Returning cached pharmacy brochures data');
      return NextResponse.json(cached.data);
    }

    console.log('🔍 Pharmacy Brochures API - Fetching data for faculty:', faculty);

    // Отримуємо унікальні роки з таблиці krok_questions_unified_pharmacy
    const { data: uniqueYearsData, error: yearsError } = await supabase
      .from('krok_questions_unified_pharmacy')
      .select('year')
      .eq('faculty', faculty)
      .eq('is_active', true);

    if (yearsError) {
      console.error('Error fetching years:', yearsError);
      return NextResponse.json({ error: 'Failed to fetch years' }, { status: 500 });
    }

    if (!uniqueYearsData || uniqueYearsData.length === 0) {
      console.log('No pharmacy data found');
      return NextResponse.json({ booklets: [] });
    }

    // Отримуємо унікальні роки
    const uniqueYears = [...new Set(uniqueYearsData.map(item => item.year))].sort((a, b) => b - a);
    console.log('Found pharmacy years:', uniqueYears);

    // Отримуємо унікальні тести для кожного року (групуємо по test_identifier)
    const allTests: any[] = [];
    for (const year of uniqueYears) {
      const { data: yearTests, error: yearTestsError } = await supabase
        .from('krok_questions_unified_pharmacy')
        .select('year, test_identifier, title, description, category')
        .eq('faculty', faculty)
        .eq('is_active', true)
        .eq('year', year);

      if (!yearTestsError && yearTests) {
        // Групуємо по test_identifier, щоб уникнути дублікатів
        const uniqueTests = new Map();
        yearTests.forEach(test => {
          const key = test.test_identifier || 'main';
          if (!uniqueTests.has(key)) {
            uniqueTests.set(key, test);
          }
        });
        allTests.push(...Array.from(uniqueTests.values()));
      }
    }

    console.log('All pharmacy tests:', allTests.length);

    // Отримуємо прогрес користувача
    let userProgress: Record<string, { completed_questions: number; total_questions: number }> = {};
    
    try {
      const { data: progressData, error: progressError } = await supabase
        .from('user_progress_test')
        .select('year, faculty, completed_questions, total_questions, test_identifier')
        .eq('user_id', userId)
        .eq('faculty', faculty);

      if (!progressError && progressData) {
        progressData.forEach((item: any) => {
          const key = item.test_identifier ? `${item.year}_${item.faculty}_${item.test_identifier}` : `${item.year}_${item.faculty}`;
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
    
    // Групуємо тести по роках
    const yearGroups: Record<number, any[]> = {};
    allTests.forEach(test => {
      if (!yearGroups[test.year]) {
        yearGroups[test.year] = [];
      }
      yearGroups[test.year].push(test);
    });

    // Обробляємо кожен рік
    for (const [year, tests] of Object.entries(yearGroups)) {
      const yearNum = parseInt(year);
      
      if (Array.isArray(tests)) {
        // Кілька тестів для одного року
        for (let index = 0; index < tests.length; index++) {
          const test = tests[index];
          let title = test.title;
          
          // Якщо title не встановлено, генеруємо
          if (!title && test.test_identifier) {
            const identifier = test.test_identifier.replace(`${year}-`, '');
            if (identifier === 'pharmacy') {
              title = `${year} рік`; // Прибираємо порядковий номер
            } else {
              title = `${year}р ${identifier}`;
            }
          } else if (!title && index > 0) {
            title = `${year}р`; // Прибираємо порядковий номер
          } else if (!title) {
            title = `${year}р`;
          }

          // Підраховуємо кількість питань
          const { count: totalQuestions, error: countError } = await supabase
            .from('krok_questions_unified_pharmacy')
            .select('*', { count: 'exact', head: true })
            .eq('year', yearNum)
            .eq('faculty', faculty)
            .eq('is_active', true)
            .eq('test_identifier', test.test_identifier);

          if (countError) {
            console.error(`Error counting questions for ${year}-${test.test_identifier}:`, countError);
          }

          // Шукаємо прогрес
          const progressKey = test.test_identifier ? `${year}_${faculty}_${test.test_identifier}` : `${year}_${faculty}`;
          const progress = userProgress[progressKey];

          booklets.push({
            id: `pharmacy-${year}-${test.test_identifier || 'main'}`,
            year: yearNum,
            faculty: faculty,
            title: title,
            description: test.description || null,
            totalQuestions: totalQuestions,
            test_identifier: test.test_identifier,
            progress: progress ? {
              completed: progress.completed_questions,
              total: progress.total_questions
            } : null
          });
        }
      } else {
        // Один тест для року
        const test = Array.isArray(tests) ? tests[0] : tests;
        let title = (test as any)?.title || `${year}р`;
        
        // Підраховуємо кількість питань
        const { data: countData, error: countError } = await supabase
          .from('krok_questions_unified_pharmacy')
          .select('id', { count: 'exact' })
          .eq('year', yearNum)
          .eq('faculty', faculty)
          .eq('is_active', true)
          .eq('test_identifier', (test as any)?.test_identifier);

        const totalQuestions = countData?.length || 0;

        // Шукаємо прогрес
        const progressKey = (test as any)?.test_identifier ? `${year}_${faculty}_${(test as any).test_identifier}` : `${year}_${faculty}`;
        const progress = userProgress[progressKey];

        booklets.push({
          id: `pharmacy-${year}-${(test as any)?.test_identifier || 'main'}`,
          year: yearNum,
          faculty: faculty,
          title: title,
          description: (test as any)?.description || null,
          totalQuestions: totalQuestions,
          test_identifier: (test as any)?.test_identifier,
          progress: progress ? {
            completed: progress.completed_questions,
            total: progress.total_questions
          } : null
        });
      }
    }

    // Сортуємо буклети по року (спочатку новіші)
    booklets.sort((a, b) => b.year - a.year);

    console.log('Pharmacy booklets created:', booklets.length);

    // Зберігаємо в кеш
    const responseData = {
      success: true,
      booklets: booklets,
      totalBooklets: booklets.length,
      faculty: faculty
    };
    
    pharmacyBrochuresCache.set(cacheKey, {
      data: responseData,
      timestamp: Date.now()
    });
    
    console.log('💾 Cached pharmacy brochures data for key:', cacheKey);

    return NextResponse.json(responseData);

  } catch (error) {
    console.error('Pharmacy Brochures API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
