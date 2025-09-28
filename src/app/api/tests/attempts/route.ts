import { NextRequest, NextResponse } from 'next/server'
import { createSupabaseClientForServer } from '@/lib/supabase/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

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

    const supabase = createSupabaseClientForServer()
    const userId = session.user.id

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

    // Оновлюємо статистику користувача після завершення тесту
    try {
      await updateUserStatistics(userId, supabase)
    } catch (statsError) {
      console.error('Error updating user statistics:', statsError)
      // Не зупиняємо процес, якщо статистика не оновилася
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
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

    const { searchParams } = new URL(request.url)
    const topicId = searchParams.get('topic_id')
    const attemptType = searchParams.get('attempt_type')
    const limit = parseInt(searchParams.get('limit') || '10')

    const supabase = createSupabaseClientForServer()
    const userId = session.user.id

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

// Функція для оновлення статистики користувача
async function updateUserStatistics(userId: string, supabase: any) {
  try {
    // Отримуємо статистику з user_test_progress
    const { data: progressData } = await supabase
      .from('user_test_progress')
      .select('is_correct')
      .eq('user_id', userId)
    
    if (progressData) {
      const totalAnswered = progressData.length
      const correctAnswers = progressData.filter((p: { is_correct: boolean }) => p.is_correct).length
      const incorrectAnswers = totalAnswered - correctAnswers
      const averagePercentage = totalAnswered > 0 ? Math.round((correctAnswers / totalAnswered) * 100 * 100) / 100 : 0
      
      // Отримуємо кількість завершених тестів
      const { data: testAttempts } = await supabase
        .from('test_attempts')
        .select('id')
        .eq('user_id', userId)
        .not('completed_at', 'is', null)
      
      const completedTests = testAttempts?.length || 0
      
      // Оновлюємо статистику
      await supabase
        .from('user_statistics')
        .upsert({
          user_id: userId,
          total_questions_answered: totalAnswered,
          correct_answers: correctAnswers,
          incorrect_answers: incorrectAnswers,
          average_percentage: averagePercentage,
          ratio_percentage: averagePercentage,
          total_tests: completedTests,
          completed_tests: completedTests,
          last_calculated_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }, {
          onConflict: 'user_id'
        })
    }
  } catch (error) {
    console.error('Error updating user statistics:', error)
    throw error
  }
}
