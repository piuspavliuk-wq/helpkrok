import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const topicId = searchParams.get('topic_id')
    const limit = parseInt(searchParams.get('limit') || '10')

    if (!topicId) {
      return NextResponse.json(
        { error: 'ID теми обов\'язковий' },
        { status: 400 }
      )
    }

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    // Отримуємо питання з опціями
    const { data: questions, error: questionsError } = await supabase
      .from('questions')
      .select(`
        *,
        question_options (*)
      `)
      .eq('topic_id', topicId)
      .eq('is_active', true)
      .order('order_index', { ascending: true })
      .limit(limit)

    if (questionsError) {
      console.error('Error fetching questions:', questionsError)
      return NextResponse.json(
        { error: 'Помилка при отриманні питань' },
        { status: 500 }
      )
    }

    // Форматуємо дані для фронтенду
    const formattedQuestions = (questions || []).map(question => ({
      id: question.id,
      question_text: question.question_text,
      explanation: question.explanation,
      difficulty: question.difficulty,
      image_url: question.image_url ?? null,
      options: (question.question_options || []).map((option: Record<string, unknown>) => ({
        id: option.id,
        option_text: option.option_text,
        is_correct: option.is_correct,
        order_index: option.order_index
      })).sort((a: Record<string, unknown>, b: Record<string, unknown>) => (a.order_index as number) - (b.order_index as number))
    }))

    return NextResponse.json({
      success: true,
      questions: formattedQuestions,
    })
  } catch (error) {
    console.error('Questions API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { topic_id, question_text, explanation, difficulty, options } = body

    if (!topic_id || !question_text || !options || options.length === 0) {
      return NextResponse.json(
        { error: 'Необхідні поля відсутні' },
        { status: 400 }
      )
    }

    // Перевіряємо чи є хоча б одна правильна відповідь
    const hasCorrectAnswer = options.some((option: Record<string, unknown>) => option.is_correct)
    if (!hasCorrectAnswer) {
      return NextResponse.json(
        { error: 'Повинна бути хоча б одна правильна відповідь' },
        { status: 400 }
      )
    }

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    // Створюємо питання
    const { data: question, error: questionError } = await supabase
      .from('questions')
      .insert({
        topic_id,
        question_text,
        explanation,
        difficulty: difficulty || 'medium',
        order_index: 0, // Буде оновлено пізніше
      })
      .select()
      .single()

    if (questionError) {
      console.error('Error creating question:', questionError)
      return NextResponse.json(
        { error: 'Помилка при створенні питання' },
        { status: 500 }
      )
    }

    // Створюємо опції відповідей
    const formattedOptions = options.map((option: Record<string, unknown>, index: number) => ({
      question_id: question.id,
      option_text: option.option_text,
      is_correct: option.is_correct,
      order_index: index
    }))

    const { data: questionOptions, error: optionsError } = await supabase
      .from('question_options')
      .insert(formattedOptions)
      .select()

    if (optionsError) {
      console.error('Error creating question options:', optionsError)
      return NextResponse.json(
        { error: 'Помилка при створенні опцій відповідей' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      question: {
        ...question,
        options: questionOptions
      },
    })
  } catch (error) {
    console.error('Question creation error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
