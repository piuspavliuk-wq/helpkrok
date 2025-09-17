import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('user_id')
    const range = searchParams.get('range') || 'month'

    if (!userId) {
      return NextResponse.json(
        { error: 'ID користувача обов\'язковий' },
        { status: 400 }
      )
    }

    // Визначаємо дати для фільтрації
    const now = new Date()
    let startDate: Date

    switch (range) {
      case 'week':
        startDate = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000)
        break
      case 'month':
        startDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000)
        break
      case 'year':
        startDate = new Date(now.getTime() - 365 * 24 * 60 * 60 * 1000)
        break
      default:
        startDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000)
    }

    // Отримуємо прогрес користувача
    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }
    
    const { data: progress, error: progressError } = await supabase
      .from('user_topic_progress')
      .select(`
        *,
        topics (
          id,
          title,
          course_id,
          courses (
            faculty
          )
        )
      `)
      .eq('user_id', userId)
      .gte('last_accessed', startDate.toISOString())

    if (progressError) {
      console.error('Error fetching progress:', progressError)
      return NextResponse.json(
        { error: 'Помилка при отриманні прогресу' },
        { status: 500 }
      )
    }

    // Отримуємо результати тестів
    const { data: testAttempts, error: testsError } = await supabase
      .from('test_attempts')
      .select('*')
      .eq('user_id', userId)
      .gte('completed_at', startDate.toISOString())
      .order('completed_at', { ascending: false })

    if (testsError) {
      console.error('Error fetching test attempts:', testsError)
      return NextResponse.json(
        { error: 'Помилка при отриманні результатів тестів' },
        { status: 500 }
      )
    }

    // Обчислюємо аналітику
    const totalTopicsCompleted = progress?.filter(p => p.test_completed).length || 0
    const totalTestsTaken = testAttempts?.length || 0
    const averageScore = testAttempts?.length > 0 
      ? Math.round(testAttempts.reduce((sum, attempt) => sum + attempt.score, 0) / testAttempts.length)
      : 0

    // Обчислюємо час навчання (приблизно)
    const totalStudyTime = progress?.reduce((total, p) => {
      // Припускаємо, що кожна тема займає в середньому 30 хвилин
      return total + (p.video_completed ? 30 : p.video_progress * 0.3)
    }, 0) || 0

    // Прогрес по факультетах
    const progressByFaculty = {
      medical: 0,
      pharmaceutical: 0
    }

    if (progress) {
      const medicalProgress = progress.filter(p => 
        p.topics?.courses?.faculty === 'medical'
      )
      const pharmaceuticalProgress = progress.filter(p => 
        p.topics?.courses?.faculty === 'pharmaceutical'
      )

      progressByFaculty.medical = medicalProgress.length > 0 
        ? Math.round((medicalProgress.filter(p => p.test_completed).length / medicalProgress.length) * 100)
        : 0

      progressByFaculty.pharmaceutical = pharmaceuticalProgress.length > 0
        ? Math.round((pharmaceuticalProgress.filter(p => p.test_completed).length / pharmaceuticalProgress.length) * 100)
        : 0
    }

    // Сильні та слабкі сторони (на основі результатів тестів)
    const strongAreas: string[] = []
    const weakAreas: string[] = []

    if (testAttempts && testAttempts.length > 0) {
      const highScores = testAttempts.filter(attempt => attempt.score >= 80)
      const lowScores = testAttempts.filter(attempt => attempt.score < 60)

      // Тут має бути логіка для визначення тем на основі topic_id
      // Для демонстрації використовуємо заглушки
      if (highScores.length > 0) {
        strongAreas.push('Анатомія людини', 'Фізіологія')
      }
      if (lowScores.length > 0) {
        weakAreas.push('Патологія', 'Фармакологія')
      }
    }

    // Остання активність
    const recentActivity: Array<{
      id: string;
      type: string;
      title: string;
      timestamp: string;
      score?: number;
    }> = []
    
    if (progress) {
      progress.slice(0, 5).forEach(p => {
        if (p.test_completed) {
          recentActivity.push({
            id: `topic-${p.topic_id}`,
            type: 'topic_completed',
            title: `Завершено тему: ${p.topics?.title || 'Невідома тема'}`,
            timestamp: p.last_accessed,
            score: p.test_score
          })
        } else if (p.video_completed) {
          recentActivity.push({
            id: `video-${p.topic_id}`,
            type: 'video',
            title: `Переглянуто відео: ${p.topics?.title || 'Невідома тема'}`,
            timestamp: p.last_accessed
          })
        }
      })
    }

    if (testAttempts) {
      testAttempts.slice(0, 3).forEach(attempt => {
        recentActivity.push({
          id: `test-${attempt.id}`,
          type: 'test',
          title: `Пройдено тест (${attempt.attempt_type})`,
          timestamp: attempt.completed_at,
          score: attempt.score
        })
      })
    }

    // Сортуємо активність за часом
    recentActivity.sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime())

    // Тренд продуктивності (останні 7 днів)
    const performanceTrend = []
    for (let i = 6; i >= 0; i--) {
      const date = new Date(now.getTime() - i * 24 * 60 * 60 * 1000)
      const dayStart = new Date(date.setHours(0, 0, 0, 0))
      const dayEnd = new Date(date.setHours(23, 59, 59, 999))

      const dayTests = testAttempts?.filter(attempt => {
        const attemptDate = new Date(attempt.completed_at)
        return attemptDate >= dayStart && attemptDate <= dayEnd
      }) || []

      const dayProgress = progress?.filter(p => {
        const progressDate = new Date(p.last_accessed)
        return progressDate >= dayStart && progressDate <= dayEnd
      }) || []

      performanceTrend.push({
        date: dayStart.toISOString().split('T')[0],
        score: dayTests.length > 0 
          ? Math.round(dayTests.reduce((sum, test) => sum + test.score, 0) / dayTests.length)
          : 0,
        topics_completed: dayProgress.filter(p => p.test_completed).length
      })
    }

    const analytics = {
      total_topics_completed: totalTopicsCompleted,
      total_tests_taken: totalTestsTaken,
      average_score: averageScore,
      total_study_time: Math.round(totalStudyTime),
      weak_areas: weakAreas,
      strong_areas: strongAreas,
      progress_by_faculty: progressByFaculty,
      recent_activity: recentActivity.slice(0, 10),
      performance_trend: performanceTrend
    }

    return NextResponse.json({
      success: true,
      analytics,
    })
  } catch (error) {
    console.error('Analytics API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
