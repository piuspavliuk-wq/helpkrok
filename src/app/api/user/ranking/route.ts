import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Тимчасово повертаємо mock дані
    const mockRankingData = {
      currentUser: {
        id: session.user.id,
        name: session.user.name || 'Ви',
        avatar: session.user.image,
        faculty: 'medical',
        totalScore: 1250,
        testsCompleted: 12,
        averageScore: 78.5,
        rank: 15,
        points: 1250,
        achievements: 8
      },
      topUsers: [
        {
          id: '2',
          name: 'Олександр Петренко',
          faculty: 'medical',
          totalScore: 2450,
          testsCompleted: 25,
          averageScore: 92.5,
          rank: 1,
          points: 2450,
          achievements: 15
        },
        {
          id: '3',
          name: 'Марія Коваленко',
          faculty: 'medical',
          totalScore: 2380,
          testsCompleted: 23,
          averageScore: 91.2,
          rank: 2,
          points: 2380,
          achievements: 14
        },
        {
          id: '4',
          name: 'Дмитро Іваненко',
          faculty: 'pharmaceutical',
          totalScore: 2200,
          testsCompleted: 22,
          averageScore: 89.1,
          rank: 3,
          points: 2200,
          achievements: 12
        }
      ],
      facultyRanking: {
        medical: [
          {
            id: '2',
            name: 'Олександр Петренко',
            faculty: 'medical',
            totalScore: 2450,
            testsCompleted: 25,
            averageScore: 92.5,
            rank: 1,
            points: 2450,
            achievements: 15
          },
          {
            id: '3',
            name: 'Марія Коваленко',
            faculty: 'medical',
            totalScore: 2380,
            testsCompleted: 23,
            averageScore: 91.2,
            rank: 2,
            points: 2380,
            achievements: 14
          }
        ],
        pharmaceutical: [
          {
            id: '4',
            name: 'Дмитро Іваненко',
            faculty: 'pharmaceutical',
            totalScore: 2200,
            testsCompleted: 22,
            averageScore: 89.1,
            rank: 1,
            points: 2200,
            achievements: 12
          }
        ]
      },
      achievements: [
        {
          id: 'first_test',
          title: 'Перший крок',
          description: 'Пройдіть свій перший тест',
          icon: '🎯',
          points: 50,
          unlocked: true,
          unlockedAt: '2024-01-10T10:00:00Z'
        },
        {
          id: 'perfect_score',
          title: 'Ідеальний результат',
          description: 'Отримайте 100% в тесті',
          icon: '⭐',
          points: 100,
          unlocked: false
        },
        {
          id: 'streak_7',
          title: 'Тиждень навчання',
          description: 'Навчайтеся 7 днів поспіль',
          icon: '🔥',
          points: 75,
          unlocked: true,
          unlockedAt: '2024-01-15T10:00:00Z'
        },
        {
          id: 'top_10',
          title: 'Топ-10',
          description: 'Потрапте в топ-10 рейтингу',
          icon: '🏆',
          points: 200,
          unlocked: false
        }
      ]
    }

    return NextResponse.json({
      success: true,
      rankingData: mockRankingData,
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Ranking API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
