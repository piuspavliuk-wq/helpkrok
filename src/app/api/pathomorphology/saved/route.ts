import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY!
const supabase = createClient(supabaseUrl, supabaseKey)

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')

    if (!userId) {
      return NextResponse.json(
        { error: 'Параметр userId є обов\'язковим' },
        { status: 400 }
      )
    }

    // Отримуємо збережені питання з патоморфології
    const { data: savedQuestions, error } = await supabase
      .from('saved_questions')
      .select(`
        *,
        pathomorphology_questions!inner(*)
      `)
      .eq('user_id', userId)
      .eq('subject', 'pathomorphology')

    if (error) {
      console.error('Supabase error:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні збережених питань' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      savedQuestions: savedQuestions || [],
      total: savedQuestions?.length || 0
    })

  } catch (error) {
    console.error('Pathomorphology saved questions API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { userId, questionId, subject } = body

    if (!userId || !questionId || !subject) {
      return NextResponse.json(
        { error: 'Відсутні обов\'язкові параметри' },
        { status: 400 }
      )
    }

    // Зберігаємо питання
    const { data, error } = await supabase
      .from('saved_questions')
      .insert({
        user_id: userId,
        question_id: questionId,
        subject: subject,
        created_at: new Date().toISOString()
      })

    if (error) {
      console.error('Supabase error:', error)
      return NextResponse.json(
        { error: 'Помилка при збереженні питання' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Питання збережено'
    })

  } catch (error) {
    console.error('Pathomorphology save question API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    const questionId = searchParams.get('questionId')

    if (!userId || !questionId) {
      return NextResponse.json(
        { error: 'Відсутні обов\'язкові параметри' },
        { status: 400 }
      )
    }

    // Видаляємо збережене питання
    const { error } = await supabase
      .from('saved_questions')
      .delete()
      .eq('user_id', userId)
      .eq('question_id', questionId)

    if (error) {
      console.error('Supabase error:', error)
      return NextResponse.json(
        { error: 'Помилка при видаленні питання' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Питання видалено зі збережених'
    })

  } catch (error) {
    console.error('Pathomorphology delete question API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
