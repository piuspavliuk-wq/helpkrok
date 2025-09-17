import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { 
      topic_id, 
      attempt_type, 
      total_questions, 
      correct_answers, 
      score, 
      time_spent, 
      completed_at 
    } = body

    if (!attempt_type || !total_questions || correct_answers === undefined || !score || !time_spent || !completed_at) {
      return NextResponse.json(
        { error: 'Необхідні поля відсутні' },
        { status: 400 }
      )
    }

    // Отримуємо токен з cookies
    const token = request.cookies.get('auth-token')?.value
    
    if (!token) {
      return NextResponse.json(
        { error: 'Не автентифікований' },
        { status: 401 }
      )
    }

    // Тут має бути логіка валідації токена та отримання user_id
    const userId = 'temp-user-id' // В реальному додатку це має бути з токена

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    // Створюємо запис про спробу тесту
    const { data: attempt, error: attemptError } = await supabase
      .from('test_attempts')
      .insert({
        user_id: userId,
        topic_id: topic_id || null,
        attempt_type,
        total_questions,
        correct_answers,
        score,
        time_spent,
        completed_at,
      })
      .select()
      .single()

    if (attemptError) {
      console.error('Error creating test attempt:', attemptError)
      return NextResponse.json(
        { error: 'Помилка при збереженні результату тесту' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      attempt,
    })
  } catch (error) {
    console.error('Test attempt error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const topicId = searchParams.get('topic_id')
    const attemptType = searchParams.get('attempt_type')
    const limit = parseInt(searchParams.get('limit') || '10')

    // Отримуємо токен з cookies
    const token = request.cookies.get('auth-token')?.value
    
    if (!token) {
      return NextResponse.json(
        { error: 'Не автентифікований' },
        { status: 401 }
      )
    }

    // Тут має бути логіка валідації токена та отримання user_id
    const userId = 'temp-user-id' // В реальному додатку це має бути з токена

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    let query = supabase
      .from('test_attempts')
      .select('*')
      .eq('user_id', userId)
      .order('completed_at', { ascending: false })
      .limit(limit)

    if (topicId) {
      query = query.eq('topic_id', topicId)
    }

    if (attemptType) {
      query = query.eq('attempt_type', attemptType)
    }

    const { data: attempts, error } = await query

    if (error) {
      console.error('Error fetching test attempts:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні результатів тестів' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      attempts: attempts || [],
    })
  } catch (error) {
    console.error('Test attempts fetch error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
