import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const timeRange = searchParams.get('timeRange') || 'month'

    // Тимчасово повертаємо mock дані
    // Пізніше тут буде запит до бази даних
    const mockStatistics = {
      totalTests: 12,
      completedTests: 8,
      averageScore: 78.5,
      totalTimeSpent: 14400, // 4 hours in seconds
      bestScore: 95,
      testsByStep: { krok1: 5, krok2: 3, krok3: 0 },
      testsByFaculty: { medical: 7, pharmaceutical: 1 },
      recentAttempts: [
        {
          id: '1',
          testName: 'Анатомія',
          step: 'krok1',
          faculty: 'medical',
          score: 85,
          totalQuestions: 50,
          correctAnswers: 42,
          timeSpent: 1800,
          completedAt: '2024-01-15T10:30:00Z',
          isCompleted: true
        },
        {
          id: '2',
          testName: 'Фізіологія',
          step: 'krok1',
          faculty: 'medical',
          score: 72,
          totalQuestions: 50,
          correctAnswers: 36,
          timeSpent: 2100,
          completedAt: '2024-01-14T15:45:00Z',
          isCompleted: true
        }
      ],
      weeklyProgress: [
        { date: '2024-01-08', tests: 2, score: 80 },
        { date: '2024-01-09', tests: 1, score: 75 },
        { date: '2024-01-10', tests: 0, score: 0 },
        { date: '2024-01-11', tests: 3, score: 85 },
        { date: '2024-01-12', tests: 1, score: 90 },
        { date: '2024-01-13', tests: 0, score: 0 },
        { date: '2024-01-14', tests: 1, score: 72 }
      ]
    }

    return NextResponse.json({
      success: true,
      statistics: mockStatistics,
      timeRange,
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Statistics API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
