import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

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
    const faculty = searchParams.get('faculty') || 'pharmacy';
    const test_identifier = searchParams.get('test_identifier');
    const limit = parseInt(searchParams.get('limit') || '200');
    const offset = parseInt(searchParams.get('offset') || '0');

    console.log('🔍 Pharmacy Questions API - Parameters:', { year, faculty, test_identifier, limit, offset });

    if (!year) {
      return NextResponse.json({ error: 'Year parameter is required' }, { status: 400 });
    }

    // Базовий запит
    let query = supabase
      .from('krok_questions_unified_pharmacy')
      .select('*')
      .eq('year', parseInt(year))
      .eq('faculty', faculty)
      .eq('is_active', true);

    // Додаємо фільтр по test_identifier якщо вказано
    if (test_identifier) {
      query = query.eq('test_identifier', test_identifier);
    } else {
      query = query.is('test_identifier', null);
    }

    // Додаємо пагінацію
    query = query.range(offset, offset + limit - 1);

    const { data: questions, error } = await query;

    if (error) {
      console.error('Error fetching pharmacy questions:', error);
      return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
    }

    if (!questions || questions.length === 0) {
      return NextResponse.json({ 
        questions: [], 
        total: 0, 
        message: 'No questions found for the specified criteria' 
      });
    }

    // Форматуємо питання для фронтенду
    const formattedQuestions = questions.map(q => ({
      id: q.id,
      question_text: q.question_text,
      year: q.year,
      faculty: q.faculty,
      category: q.category,
      difficulty: q.difficulty,
      title: q.title,
      test_identifier: q.test_identifier,
      description: q.description,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      option_e: q.option_e,
      options: {
        A: q.option_a,
        B: q.option_b,
        C: q.option_c,
        D: q.option_d,
        E: q.option_e
      },
      option_images: {
        A: q.option_a_image,
        B: q.option_b_image,
        C: q.option_c_image,
        D: q.option_d_image,
        E: q.option_e_image
      },
      question_image: q.question_image,
      correct_answer: q.correct_answer,
      question_type: q.question_type,
      explanation_text: q.explanation_text,
      reference_text: q.reference_text
    }));

    // Отримуємо загальну кількість питань для пагінації
    let countQuery = supabase
      .from('krok_questions_unified_pharmacy')
      .select('id', { count: 'exact' })
      .eq('year', parseInt(year))
      .eq('faculty', faculty)
      .eq('is_active', true);

    if (test_identifier) {
      countQuery = countQuery.eq('test_identifier', test_identifier);
    } else {
      countQuery = countQuery.is('test_identifier', null);
    }

    const { count, error: countError } = await countQuery;

    console.log('✅ Pharmacy questions fetched:', formattedQuestions.length, 'of', count);

    return NextResponse.json({
      success: true,
      questions: formattedQuestions,
      total: count || 0,
      year: parseInt(year),
      faculty: faculty,
      test_identifier: test_identifier,
      pagination: {
        limit,
        offset,
        hasMore: (offset + limit) < (count || 0)
      }
    });

  } catch (error) {
    console.error('Pharmacy Questions API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
