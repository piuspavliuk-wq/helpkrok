import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

// GET - отримати історію тестів
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const history = await prisma.randomizerTestHistory.findMany({
      where: {
        userId: session.user.id
      },
      orderBy: {
        completedAt: 'desc'
      },
      take: 50 // Останні 50 тестів
    })

    return NextResponse.json({ history })
  } catch (error) {
    console.error('Error fetching randomizer history:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

// POST - зберегти результат тесту
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { faculty, questionsCount, correctAnswers, scorePercentage, timeSpentSeconds } = body

    if (!faculty || !questionsCount || correctAnswers === undefined || !scorePercentage) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    const history = await prisma.randomizerTestHistory.create({
      data: {
        userId: session.user.id,
        faculty,
        questionsCount,
        correctAnswers,
        scorePercentage,
        timeSpentSeconds
      }
    })

    return NextResponse.json({ success: true, history })
  } catch (error) {
    console.error('Error saving randomizer history:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

