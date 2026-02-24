import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// GET - Отримання фармацевтичних питань
export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const { searchParams } = new URL(request.url);
    const year = searchParams.get('year');
    const subject = searchParams.get('subject'); // Не встановлюємо значення за замовчуванням для randomizer
    const category = searchParams.get('category');
    const limit = searchParams.get('limit') ? parseInt(searchParams.get('limit')!) : 1000;
    const random = searchParams.get('random') === 'true';

    let query = supabase
      .from('pharmaceutical_questions')
      .select('*')
      .eq('is_active', true)
      .eq('faculty', 'pharmaceutical');

    // Фільтри
    if (year) {
      query = query.eq('year', parseInt(year));
    }
    
    if (subject) {
      query = query.eq('subject', subject);
    }
    
    if (category) {
      query = query.eq('category', category);
    }

    // Справді випадковий набір питань: спочатку отримуємо id (з фільтрами), випадково вибираємо limit, потім завантажуємо повні рядки
    if (random && limit) {
      const allIds: number[] = [];
      const pageSize = 1000;
      let from = 0;
      while (true) {
        let pageQuery = supabase
          .from('pharmaceutical_questions')
          .select('id')
          .eq('is_active', true)
          .eq('faculty', 'pharmaceutical');
        if (year) pageQuery = pageQuery.eq('year', parseInt(year));
        if (subject) pageQuery = pageQuery.eq('subject', subject);
        if (category) pageQuery = pageQuery.eq('category', category);
        const { data: pageData, error: pageErr } = await pageQuery.range(from, from + pageSize - 1);
        if (pageErr || !pageData?.length) break;
        allIds.push(...pageData.map((r: { id: number }) => r.id));
        if (pageData.length < pageSize) break;
        from += pageSize;
      }

      // Fisher-Yates: випадково вибираємо limit id з усіх
      const sampleSize = Math.min(limit, allIds.length);
      const pickedIds: number[] = [];
      const indices = [...Array(allIds.length).keys()];
      for (let i = 0; i < sampleSize; i++) {
        const j = i + Math.floor(Math.random() * (indices.length - i));
        [indices[i], indices[j]] = [indices[j], indices[i]];
        pickedIds.push(allIds[indices[i]]);
      }

      if (pickedIds.length === 0) {
        return NextResponse.json({
          questions: [],
          total: 0,
          returned: 0
        });
      }

      const { data: questions, error } = await supabase
        .from('pharmaceutical_questions')
        .select('*')
        .in('id', pickedIds);

      if (error) {
        console.error('Error fetching pharmaceutical questions by ids:', error);
        return NextResponse.json(
          { error: 'Failed to fetch questions' },
          { status: 500 }
        );
      }

      // Зберігаємо порядок як у pickedIds (вже випадковий)
      const idToRow = new Map((questions || []).map((q: any) => [q.id, q]));
      const orderedQuestions = pickedIds.map(id => idToRow.get(id)).filter(Boolean);

      const formattedQuestions = orderedQuestions.map((q: any) => ({
        id: q.id,
        question_text: q.question_text,
        question_image: q.question_image,
        option_a: q.option_a,
        option_a_image: q.option_a_image,
        option_b: q.option_b,
        option_b_image: q.option_b_image,
        option_c: q.option_c,
        option_c_image: q.option_c_image,
        option_d: q.option_d,
        option_d_image: q.option_d_image,
        option_e: q.option_e,
        option_e_image: q.option_e_image,
        correct_answer: q.correct_answer,
        explanation: q.explanation_text,
        year: q.year,
        faculty: q.faculty,
        subject: q.subject,
        category: q.category,
        question_type: q.question_type,
        created_at: q.created_at
      }));

      const { count: totalCount } = await supabase
        .from('pharmaceutical_questions')
        .select('*', { count: 'exact', head: true })
        .eq('is_active', true)
        .eq('faculty', 'pharmaceutical');

      return NextResponse.json({
        questions: formattedQuestions,
        total: totalCount ?? formattedQuestions.length,
        returned: formattedQuestions.length
      });
    }

    // Звичайний запит: сортування по id

    // Ліміт
    if (limit) {
      query = query.limit(limit);
    }

    const { data: questions, error } = await query;

    if (error) {
      console.error('Error fetching pharmaceutical questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch questions' },
        { status: 500 }
      );
    }

    // Корректируемо структуру відповіді для сумісності з існуючими компонентами
    const formattedQuestions = questions?.map(q => ({
      id: q.id,
      question_text: q.question_text,
      question_image: q.question_image,
      option_a: q.option_a,
      option_a_image: q.option_a_image,
      option_b: q.option_b,
      option_b_image: q.option_b_image,
      option_c: q.option_c,
      option_c_image: q.option_c_image,
      option_d: q.option_d,
      option_d_image: q.option_d_image,
      option_e: q.option_e,
      option_e_image: q.option_e_image,
      correct_answer: q.correct_answer,
      explanation: q.explanation_text,
      year: q.year,
      faculty: q.faculty,
      subject: q.subject,
      category: q.category,
      question_type: q.question_type,
      created_at: q.created_at
    })) || [];

    // Отримуємо загальну кількість питань в базі
    const { count: totalCount, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true })
      .eq('is_active', true)
      .eq('faculty', 'pharmaceutical');

    return NextResponse.json({ 
      questions: formattedQuestions,
      total: totalCount || formattedQuestions.length,
      returned: formattedQuestions.length
    });

  } catch (error) {
    console.error('Error in GET /api/pharmaceutical/questions:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// POST - Створення нового фармацевтичного питання
export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const body = await request.json();
    const {
      question_text,
      year,
      subject = 'analytical_chemistry',
      category,
      option_a,
      option_b,
      option_c,
      option_d,
      option_e,
      correct_answer,
      explanation_text,
      reference_text
    } = body;

    // Валідація обов'язкових полів
    if (!question_text || !year || !correct_answer) {
      return NextResponse.json(
        { error: 'Missing required fields: question_text, year, correct_answer' },
        { status: 400 }
      );
    }

    // Валідація правильної відповіді
    if (!['A', 'B', 'C', 'D', 'E'].includes(correct_answer)) {
      return NextResponse.json(
        { error: 'correct_answer must be A, B, C, D, or E' },
        { status: 400 }
      );
    }

    const { data: question, error } = await supabase
      .from('pharmaceutical_questions')
      .insert({
        question_text,
        year: parseInt(year),
        faculty: 'pharmaceutical',
        subject,
        category: category || 'general',
        is_active: true,
        option_a: option_a || '',
        option_b: option_b || '',
        option_c: option_c || '',
        option_d: option_d || '',
        option_e: option_e || '',
        correct_answer,
        explanation_text: explanation_text || '',
        reference_text: reference_text || '',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating pharmaceutical question:', error);
      return NextResponse.json(
        { error: 'Failed to create question' },
        { status: 500 }
      );
    }

    return NextResponse.json({ question }, { status: 201 });

  } catch (error) {
    console.error('Error in POST /api/pharmaceutical/questions:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
