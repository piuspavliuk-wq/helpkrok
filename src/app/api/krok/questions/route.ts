import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);
  try {
    const { searchParams } = new URL(request.url);
    const year = searchParams.get('year');
    const faculty = searchParams.get('faculty') || 'medical';
    const category = searchParams.get('category');
    const difficulty = searchParams.get('difficulty');
    const limit = searchParams.get('limit') ? parseInt(searchParams.get('limit')!) : 1000;
    const random = searchParams.get('random') === 'true';

    let query = supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact' })
      .eq('is_active', true);

    // Фільтри
    if (year) {
      query = query.eq('year', parseInt(year));
    }
    
    if (faculty) {
      query = query.eq('faculty', faculty);
    }
    
    if (category) {
      query = query.eq('category', category);
    }

    if (difficulty) {
      query = query.eq('difficulty', difficulty);
    }

    // Якщо потрібно справді випадковий набір питань — використовуємо SQL RPC або fallback по id
    if (random) {
      const requestLimit = limit || 150;
      let rawQuestions: any[] | null = null;

      const { data: rpcQuestions, error: rpcError } = await supabase.rpc('get_random_krok_questions_unified', {
        p_year: year ? parseInt(year) : null,
        p_faculty: faculty || 'medical',
        p_category: category || null,
        p_difficulty: difficulty || null,
        p_limit: requestLimit
      });

      if (!rpcError && rpcQuestions?.length) {
        rawQuestions = rpcQuestions;
      } else {
        if (rpcError) {
          console.warn('RPC get_random_krok_questions_unified failed, using id-based random sample:', rpcError.message);
        }
        // Fallback: отримуємо всі id з фільтрами, випадково вибираємо requestLimit, потім завантажуємо рядки
        const allIds: number[] = [];
        const pageSize = 1000;
        let from = 0;
        while (true) {
          let pageQuery = supabase
            .from('krok_questions_unified')
            .select('id')
            .eq('is_active', true)
            .eq('faculty', faculty || 'medical');
          if (year) pageQuery = pageQuery.eq('year', parseInt(year));
          if (category) pageQuery = pageQuery.eq('category', category);
          if (difficulty) pageQuery = pageQuery.eq('difficulty', difficulty);
          const { data: pageData, error: pageErr } = await pageQuery.range(from, from + pageSize - 1);
          if (pageErr || !pageData?.length) break;
          allIds.push(...pageData.map((r: { id: number }) => r.id));
          if (pageData.length < pageSize) break;
          from += pageSize;
        }
        const sampleSize = Math.min(requestLimit, allIds.length);
        const indices = [...Array(allIds.length).keys()];
        const pickedIds: number[] = [];
        for (let i = 0; i < sampleSize; i++) {
          const j = i + Math.floor(Math.random() * (indices.length - i));
          [indices[i], indices[j]] = [indices[j], indices[i]];
          pickedIds.push(allIds[indices[i]]);
        }
        if (pickedIds.length > 0) {
          const { data: byId } = await supabase
            .from('krok_questions_unified')
            .select('*')
            .in('id', pickedIds);
          const idToRow = new Map((byId || []).map((r: any) => [r.id, r]));
          rawQuestions = pickedIds.map(id => idToRow.get(id)).filter(Boolean);
        }
      }

      const shuffledQuestions = (rawQuestions || []).slice(0, requestLimit);

      const formattedQuestions = shuffledQuestions.map((q: any) => ({
        id: q.id,
        question_text: q.question_text,
        year: q.year,
        faculty: q.faculty,
        category: q.category,
        difficulty: q.difficulty,
        options: [
          { letter: 'A', text: q.option_a || '', is_correct: q.correct_answer === 'A' },
          { letter: 'B', text: q.option_b || '', is_correct: q.correct_answer === 'B' },
          { letter: 'C', text: q.option_c || '', is_correct: q.correct_answer === 'C' },
          { letter: 'D', text: q.option_d || '', is_correct: q.correct_answer === 'D' },
          { letter: 'E', text: q.option_e || '', is_correct: q.correct_answer === 'E' }
        ].filter(option => option.text.trim() !== ''),
        explanation_text: q.explanation_text,
        reference_text: q.reference_text,
        correct_answer: q.correct_answer
      }));

      const { count: totalInDatabase } = await supabase
        .from('krok_questions_unified')
        .select('*', { count: 'exact', head: true })
        .eq('is_active', true)
        .eq('faculty', faculty || 'medical');

      return NextResponse.json({
        questions: formattedQuestions,
        total: totalInDatabase || formattedQuestions.length,
        returned: formattedQuestions.length,
        filters: { year, faculty, category, difficulty, limit, random }
      });
    }

    // Звичайний запит без random — сортування по id
    query = query.order('id', { ascending: true });

    // Ліміт
    if (limit) {
      query = query.limit(limit);
    }

    // Якщо потрібно отримати більше 1000 питань, використовуємо пагінацію
    let questions, error;
    if (limit && limit > 1000) {
      // Отримуємо всі питання через пагінацію
      const allQuestions = [];
      let from = 0;
      const pageSize = 1000;
      
      while (allQuestions.length < limit) {
        const result = await supabase
          .from('krok_questions_unified')
          .select('*')
          .eq('is_active', true)
          .range(from, from + pageSize - 1);
        
        if (result.error) {
          error = result.error;
          break;
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
      
      questions = allQuestions.slice(0, limit);
    } else {
      const result = await query;
      questions = result.data;
      error = result.error;
    }

    if (error) {
      console.error('Error fetching questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch questions' },
        { status: 500 }
      );
    }

    // Форматуємо відповідь у формат, сумісний з існуючими компонентами
    const formattedQuestions = (questions || []).map(q => ({
      id: q.id,
      question_text: q.question_text,
      year: q.year,
      faculty: q.faculty,
      category: q.category,
      difficulty: q.difficulty,
      // Форматуємо варіанти відповідей у формат, очікуваний компонентами
      options: [
        { letter: 'A', text: q.option_a || '', is_correct: q.correct_answer === 'A' },
        { letter: 'B', text: q.option_b || '', is_correct: q.correct_answer === 'B' },
        { letter: 'C', text: q.option_c || '', is_correct: q.correct_answer === 'C' },
        { letter: 'D', text: q.option_d || '', is_correct: q.correct_answer === 'D' },
        { letter: 'E', text: q.option_e || '', is_correct: q.correct_answer === 'E' }
      ].filter(option => option.text.trim() !== ''), // Видаляємо порожні варіанти
      explanation_text: q.explanation_text,
      reference_text: q.reference_text,
      correct_answer: q.correct_answer
    }));

    // Отримуємо загальну кількість питань у базі для відображення
    const { count: totalInDatabase } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true })
      .eq('is_active', true)
      .eq('faculty', faculty || 'medical');

    return NextResponse.json({ 
      questions: formattedQuestions,
      total: totalInDatabase || formattedQuestions.length,
      returned: formattedQuestions.length,
      filters: {
        year,
        faculty,
        category,
        difficulty,
        limit,
        random
      }
    });
  } catch (error) {
    console.error('Error in questions API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// Функція для отримання випадкових питань через SQL функцію
export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const body = await request.json();
    const { 
      year = null, 
      faculty = 'medical', 
      category = null, 
      difficulty = null,
      limit = 10000 
    } = body;

    // Використовуємо SQL функцію для отримання випадкових питань
    const { data: questions, error } = await supabase
      .rpc('get_random_krok_questions_unified', {
        p_year: year,
        p_faculty: faculty,
        p_category: category,
        p_difficulty: difficulty,
        p_limit: limit
      });

    if (error) {
      console.error('Error fetching random questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch random questions' },
        { status: 500 }
      );
    }

    // Форматуємо відповідь у формат, сумісний з існуючими компонентами
    const formattedQuestions = questions?.map((q: any) => ({
      id: q.id,
      question_text: q.question_text,
      year: q.year,
      faculty: q.faculty,
      category: q.category,
      difficulty: q.difficulty,
      options: [
        { letter: 'A', text: q.option_a || '', is_correct: q.correct_answer === 'A' },
        { letter: 'B', text: q.option_b || '', is_correct: q.correct_answer === 'B' },
        { letter: 'C', text: q.option_c || '', is_correct: q.correct_answer === 'C' },
        { letter: 'D', text: q.option_d || '', is_correct: q.correct_answer === 'D' },
        { letter: 'E', text: q.option_e || '', is_correct: q.correct_answer === 'E' }
      ].filter(option => option.text.trim() !== ''),
      explanation_text: q.explanation_text,
      reference_text: q.reference_text,
      correct_answer: q.correct_answer
    })) || [];

    return NextResponse.json({ 
      questions: formattedQuestions,
      total: formattedQuestions.length,
      filters: { year, faculty, category, difficulty, limit }
    });
  } catch (error) {
    console.error('Error in questions POST API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}