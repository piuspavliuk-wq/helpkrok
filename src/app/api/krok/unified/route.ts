import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// GET - Отримання питань з єдиної таблиці
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const year = searchParams.get('year');
    const faculty = searchParams.get('faculty') || 'medical';
    const category = searchParams.get('category');
    const difficulty = searchParams.get('difficulty');
    const limit = searchParams.get('limit') ? parseInt(searchParams.get('limit')!) : 10000;
    const random = searchParams.get('random') === 'true';

    let query = supabase
      .from('krok_questions_unified')
      .select('*')
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

    // Сортування
    if (random) {
      query = query.order('id', { ascending: false }); // Використовуємо RANDOM() в SQL
    } else {
      query = query.order('id', { ascending: true });
    }

    // Ліміт
    if (limit) {
      query = query.limit(limit);
    }

    const { data: questions, error } = await query;

    if (error) {
      console.error('Error fetching unified questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch questions' },
        { status: 500 }
      );
    }

    // Якщо потрібно випадковий порядок, перемішуємо в JavaScript
    let shuffledQuestions = questions || [];
    if (random) {
      shuffledQuestions = questions?.sort(() => Math.random() - 0.5) || [];
    }

    // Форматуємо відповідь у формат, сумісний з існуючими компонентами
    const formattedQuestions = shuffledQuestions.map(q => ({
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

    return NextResponse.json({ 
      questions: formattedQuestions,
      total: formattedQuestions.length,
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
    console.error('Error in unified questions API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// POST - Створення нового питання
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      question_text,
      year,
      faculty = 'medical',
      category,
      difficulty = 'medium',
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
    if (!question_text || !year || !faculty || !correct_answer) {
      return NextResponse.json(
        { error: 'Missing required fields: question_text, year, faculty, correct_answer' },
        { status: 400 }
      );
    }

    // Валідація правильної відповіді
    if (!['A', 'B', 'C', 'D', 'E'].includes(correct_answer)) {
      return NextResponse.json(
        { error: 'correct_answer must be one of: A, B, C, D, E' },
        { status: 400 }
      );
    }

    const { data, error } = await supabase
      .from('krok_questions_unified')
      .insert({
        question_text,
        year,
        faculty,
        category,
        difficulty,
        option_a,
        option_b,
        option_c,
        option_d,
        option_e,
        correct_answer,
        explanation_text,
        reference_text
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating question:', error);
      return NextResponse.json(
        { error: 'Failed to create question' },
        { status: 500 }
      );
    }

    return NextResponse.json({ 
      message: 'Question created successfully',
      question: data
    }, { status: 201 });

  } catch (error) {
    console.error('Error in create question API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// PUT - Оновлення питання
export async function PUT(request: NextRequest) {
  try {
    const body = await request.json();
    const { id, ...updateData } = body;

    if (!id) {
      return NextResponse.json(
        { error: 'Question ID is required' },
        { status: 400 }
      );
    }

    const { data, error } = await supabase
      .from('krok_questions_unified')
      .update(updateData)
      .eq('id', id)
      .select()
      .single();

    if (error) {
      console.error('Error updating question:', error);
      return NextResponse.json(
        { error: 'Failed to update question' },
        { status: 500 }
      );
    }

    return NextResponse.json({ 
      message: 'Question updated successfully',
      question: data
    });

  } catch (error) {
    console.error('Error in update question API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// DELETE - Видалення питання
export async function DELETE(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');

    if (!id) {
      return NextResponse.json(
        { error: 'Question ID is required' },
        { status: 400 }
      );
    }

    const { error } = await supabase
      .from('krok_questions_unified')
      .delete()
      .eq('id', id);

    if (error) {
      console.error('Error deleting question:', error);
      return NextResponse.json(
        { error: 'Failed to delete question' },
        { status: 500 }
      );
    }

    return NextResponse.json({ 
      message: 'Question deleted successfully'
    });

  } catch (error) {
    console.error('Error in delete question API:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
