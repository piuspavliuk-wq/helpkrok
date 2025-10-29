import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY!
const supabase = createClient(supabaseUrl, supabaseKey)

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const subject = searchParams.get('subject')
    const limit = parseInt(searchParams.get('limit') || '50')
    const offset = parseInt(searchParams.get('offset') || '0')

    if (!subject) {
      return NextResponse.json(
        { error: 'Параметр subject є обов\'язковим' },
        { status: 400 }
      )
    }

    // Отримуємо питання з патоморфології
    const { data: questions, error } = await supabase
      .from('pathomorphology_questions')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('id', { ascending: true })

    if (error) {
      console.error('Supabase error:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні питань' },
        { status: 500 }
      )
    }

    // Форматуємо питання для фронтенду
    const formattedQuestions = questions?.map(q => ({
      id: q.id,
      question_text: q.question_text,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      option_e: q.option_e,
      correct_answer: q.correct_answer,
      created_at: q.created_at
    })) || []

    return NextResponse.json({
      success: true,
      questions: formattedQuestions,
      total: formattedQuestions.length,
      subject: subject,
      faculty: 'medical'
    })

  } catch (error) {
    console.error('Pathomorphology questions API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
