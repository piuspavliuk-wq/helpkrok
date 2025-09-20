import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { createSupabaseClientForServer } from '@/lib/supabase'

// Функція для отримання назви бази
function getBaseTitle(baseName: string): string {
  const baseTitles: { [key: string]: string } = {
    'anatomy': 'Анатомія',
    'histology': 'Гістологія',
    'physiology': 'Фізіологія',
    'biochemistry': 'Біохімія',
    'microbiology': 'Мікробіологія',
    'pathology': 'Патологія',
    'pathophysiology': 'Патологічна фізіологія',
    'pharmacology': 'Фармакологія',
    'biology': 'Біологія'
  }
  return baseTitles[baseName] || baseName
}

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }


    const { searchParams } = new URL(request.url)
    const timeRange = searchParams.get('timeRange') || 'month'

    const supabase = createSupabaseClientForServer()

    // Оновлюємо статистику користувача (проста версія)
    const { error: updateError } = await supabase.rpc('update_user_statistics_simple', {
      p_user_id: session.user.id
    })

    if (updateError) {
      console.error('Error updating user statistics:', updateError)
      // Якщо функція не працює, спробуємо оновити статистику вручну
      try {
        const { data: progressData } = await supabase
          .from('user_test_progress')
          .select('is_correct')
          .eq('user_id', session.user.id)
        
        if (progressData) {
          const totalAnswered = progressData.length
          const correctAnswers = progressData.filter(p => p.is_correct).length
          const incorrectAnswers = totalAnswered - correctAnswers
          const averagePercentage = totalAnswered > 0 ? Math.round((correctAnswers / totalAnswered) * 100 * 100) / 100 : 0
          
          // Оновлюємо статистику вручну
          await supabase
            .from('user_statistics')
            .upsert({
              user_id: session.user.id,
              total_questions_answered: totalAnswered,
              correct_answers: correctAnswers,
              incorrect_answers: incorrectAnswers,
              average_percentage: averagePercentage,
              ratio_percentage: averagePercentage,
              total_tests: 0,
              completed_tests: 0,
              last_calculated_at: new Date().toISOString(),
              updated_at: new Date().toISOString()
            }, {
              onConflict: 'user_id'
            })
        }
      } catch (manualError) {
        console.error('Error with manual statistics update:', manualError)
      }
    }

    // Отримуємо статистику користувача
    const { data: statistics, error: statsError } = await supabase
      .from('user_statistics')
      .select('*')
      .eq('user_id', session.user.id)
      .single()

    if (statsError) {
      console.error('Error fetching user statistics:', statsError)
      // Повертаємо пусту статистику замість помилки
      const emptyStats = {
        totalQuestionsAnswered: 0,
        correctAnswers: 0,
        incorrectAnswers: 0,
        averagePercentage: 0,
        ratioPercentage: 0,
        totalTests: 0,
        completedTests: 0,
        basesStatistics: [],
        recentAttempts: [],
        weeklyProgress: [],
        lastCalculated: null,
        timeRange
      }
      
      return NextResponse.json({
        success: true,
        statistics: emptyStats
      })
    }

    // Отримуємо останні спроби тестування
    const { data: recentAttempts, error: attemptsError } = await supabase
      .from('test_attempts')
      .select('*')
      .eq('user_id', session.user.id)
      .order('completed_at', { ascending: false })
      .limit(10)

    if (attemptsError) {
      console.error('Error fetching recent attempts:', attemptsError)
    }

    // Отримуємо тижневий прогрес
    const { data: weeklyProgress, error: progressError } = await supabase
      .from('test_attempts')
      .select('completed_at, score')
      .eq('user_id', session.user.id)
      .gte('completed_at', new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString())
      .order('completed_at', { ascending: true })

    if (progressError) {
      console.error('Error fetching weekly progress:', progressError)
    }

    // Отримуємо просту статистику по базах
    const { data: basesStatistics, error: basesError } = await supabase
      .from('user_test_progress')
      .select('test_type, is_correct')
      .eq('user_id', session.user.id)

    if (basesError) {
      console.error('Error fetching bases statistics:', basesError)
    }

    // Групуємо статистику по базах (простий підхід)
    const basesStats = basesStatistics?.reduce((acc: any, item: any) => {
      const baseName = item.test_type
      if (!acc[baseName]) {
        acc[baseName] = { correct: 0, incorrect: 0, total: 0 }
      }
      acc[baseName].total++
      if (item.is_correct) {
        acc[baseName].correct++
      } else {
        acc[baseName].incorrect++
      }
      return acc
    }, {}) || {}

    // Формуємо відповідь з безпечними значеннями
    const response = {
      // Основна статистика
      totalQuestionsAnswered: Number(statistics?.total_questions_answered) || 0,
      correctAnswers: Number(statistics?.correct_answers) || 0,
      incorrectAnswers: Number(statistics?.incorrect_answers) || 0,
      averagePercentage: Number(statistics?.average_percentage) || 0,
      ratioPercentage: Number(statistics?.ratio_percentage) || 0,
      totalTests: Number(statistics?.total_tests) || 0,
      completedTests: Number(statistics?.completed_tests) || 0,
      
      // Проста статистика по базах (тільки загальна)
      basesStatistics: Object.entries(basesStats).map(([baseName, stats]: [string, any]) => ({
        baseName: baseName,
        baseTitle: getBaseTitle(baseName),
        totalQuestions: stats.total,
        correctAnswers: stats.correct,
        incorrectAnswers: stats.incorrect,
        percentage: stats.total > 0 ? Math.round((stats.correct / stats.total) * 100 * 100) / 100 : 0
      })).sort((a, b) => b.totalQuestions - a.totalQuestions),

      // Останні спроби
      recentAttempts: recentAttempts?.map(attempt => ({
        id: attempt.id,
        testName: attempt.attempt_type === 'krok_simulation' ? 'Крок симуляція' : attempt.attempt_type,
        score: attempt.score,
        totalQuestions: attempt.total_questions,
        correctAnswers: attempt.correct_answers,
        timeSpent: attempt.time_spent,
        completedAt: attempt.completed_at,
        isCompleted: true
      })) || [],

      // Тижневий прогрес
      weeklyProgress: weeklyProgress?.reduce((acc, attempt) => {
        const date = new Date(attempt.completed_at).toISOString().split('T')[0]
        const existing = acc.find(item => item.date === date)
        if (existing) {
          existing.tests += 1
          existing.score = Math.round((existing.score + attempt.score) / 2)
        } else {
          acc.push({ date, tests: 1, score: attempt.score })
        }
        return acc
      }, [] as Array<{date: string, tests: number, score: number}>) || [],

      // Метадані
      lastCalculated: statistics?.last_calculated_at,
      timeRange
    }

    return NextResponse.json({
      success: true,
      statistics: response
    })

  } catch (error) {
    console.error('Statistics API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
