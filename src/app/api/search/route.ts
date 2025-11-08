import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  console.log('Supabase config check:', { 
    hasUrl: !!supabaseUrl, 
    hasKey: !!supabaseKey,
    urlLength: supabaseUrl?.length || 0,
    keyLength: supabaseKey?.length || 0
  });

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ 
      error: 'Supabase configuration missing',
      hasUrl: !!supabaseUrl,
      hasKey: !!supabaseKey
    }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  const { searchParams } = new URL(request.url);
  const query = searchParams.get('q');

  try {
    const limit = searchParams.get('limit') ? parseInt(searchParams.get('limit')!) : 50;
    const faculty = searchParams.get('faculty');
    const year = searchParams.get('year');
    const sourceType = searchParams.get('sourceType');
    const difficulty = searchParams.get('difficulty');

    console.log('Search API called with:', { query, limit, faculty, year, sourceType, difficulty });

    if (!query || query.trim().length < 2) {
      return NextResponse.json({ 
        error: 'Search query must be at least 2 characters long',
        query: query,
        length: query?.length || 0
      }, { status: 400 });
    }

    const searchTerm = `%${query.toLowerCase()}%`;
    const results: any[] = [];

    // Список всіх таблиць з питаннями для пошуку
    const questionTables = [
      'krok_questions_unified',
      'anatomy_questions', 
      'biology_questions',
      'biochemistry_questions',
      'histology_questions',
      'microbiology_questions',
      'pathology_questions',
      'pathophysiology_questions',
      'pathomorphology_questions',
      'pharmacology_questions',
      'physiology_questions',
      'pharmaceutical_questions'
    ];

    // Пошук в кожній таблиці
    for (const tableName of questionTables) {
      try {
        let selectQuery = supabase
          .from(tableName)
          .select('*')
          .or(`question_text.ilike.${searchTerm},option_a.ilike.${searchTerm},option_b.ilike.${searchTerm},option_c.ilike.${searchTerm},option_d.ilike.${searchTerm},option_e.ilike.${searchTerm}`);

        // Застосовуємо фільтри
        if (faculty) {
          selectQuery = selectQuery.eq('faculty', faculty);
        }
        if (year) {
          selectQuery = selectQuery.eq('year', parseInt(year));
        }
        if (difficulty) {
          selectQuery = selectQuery.eq('difficulty', difficulty);
        }

        selectQuery = selectQuery.limit(limit);

        const { data, error } = await selectQuery;

        if (!error && data && data.length > 0) {
          // Додаємо метадані про таблицю до кожного результату
          const enrichedData = data.map(item => ({
            ...item,
            source_table: tableName,
            source_type: getSourceType(tableName),
            faculty: getFacultyFromTable(tableName),
            year: item.year || null,
            category: item.category || null
          }));

          // Фільтруємо за типом джерела, якщо вказано
          if (sourceType) {
            const filteredData = enrichedData.filter(item => item.source_type === sourceType);
            results.push(...filteredData);
          } else {
            results.push(...enrichedData);
          }
        }
      } catch (tableError) {
        console.warn(`Помилка пошуку в таблиці ${tableName}:`, tableError);
        // Продовжуємо пошук в інших таблицях
        continue;
      }
    }

    // Сортуємо результати за релевантністю
    const sortedResults = results
      .sort((a, b) => {
        // Пріоритет: точна відповідність в question_text
        const aScore = getRelevanceScore(a, query);
        const bScore = getRelevanceScore(b, query);
        return bScore - aScore;
      })
      .slice(0, limit);

    console.log(`Search completed: ${sortedResults.length} results found`);

    return NextResponse.json({
      query,
      results: sortedResults,
      total: sortedResults.length,
      sources: [...new Set(sortedResults.map(r => r.source_table))]
    });

  } catch (error) {
    console.error('Помилка пошуку:', error);
    return NextResponse.json({ 
      error: 'Internal server error',
      details: error instanceof Error ? error.message : 'Unknown error',
      query: query || null
    }, { status: 500 });
  }
}

// Функція для визначення типу джерела
function getSourceType(tableName: string): string {
  const typeMap: { [key: string]: string } = {
    'krok_questions_unified': 'КРОК тести',
    'anatomy_questions': 'Анатомія',
    'biology_questions': 'Біологія', 
    'biochemistry_questions': 'Біохімія',
    'histology_questions': 'Гістологія',
    'microbiology_questions': 'Мікробіологія',
    'pathology_questions': 'Патологія',
    'pathophysiology_questions': 'Патологічна фізіологія',
    'pathomorphology_questions': 'Патоморфологія',
    'pharmacology_questions': 'Фармакологія',
    'physiology_questions': 'Фізіологія',
    'pharmaceutical_questions': 'Фармацевтичні тести'
  };
  
  return typeMap[tableName] || 'Невідомо';
}

// Функція для визначення факультету
function getFacultyFromTable(tableName: string): string {
  if (tableName.includes('pharmaceutical') || tableName === 'pharmaceutical_questions') {
    return 'pharmaceutical';
  }
  return 'medical';
}

// Функція для оцінки релевантності
function getRelevanceScore(item: any, query: string): number {
  let score = 0;
  const queryLower = query.toLowerCase();
  
  // Перевіряємо question_text
  if (item.question_text) {
    const questionText = item.question_text.toLowerCase();
    if (questionText.includes(queryLower)) {
      score += 10;
      // Додаткові бали за точну відповідність
      if (questionText.startsWith(queryLower)) score += 5;
      if (questionText === queryLower) score += 10;
    }
  }
  
  // Перевіряємо варіанти відповідей
  ['option_a', 'option_b', 'option_c', 'option_d', 'option_e'].forEach(option => {
    if (item[option] && item[option].toLowerCase().includes(queryLower)) {
      score += 3;
    }
  });
  
  // Перевіряємо category
  if (item.category && item.category.toLowerCase().includes(queryLower)) {
    score += 5;
  }
  
  return score;
}
