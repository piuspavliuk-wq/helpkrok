import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

// GET - отримати залишок спроб користувача
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    // Отримуємо всі активні спроби користувача
    const attempts = await prisma.randomizerAttempt.findMany({
      where: {
        userId: session.user.id,
        OR: [
          { expiresAt: null },
          { expiresAt: { gte: new Date() } }
        ]
      },
      orderBy: {
        purchaseDate: 'desc'
      }
    })

    const totalAttempts = attempts.reduce((sum, a) => sum + a.totalAttempts, 0)
    const usedAttempts = attempts.reduce((sum, a) => sum + a.usedAttempts, 0)
    const remainingAttempts = totalAttempts - usedAttempts

    return NextResponse.json({
      totalAttempts,
      usedAttempts,
      remainingAttempts,
      attempts
    })
  } catch (error) {
    console.error('Error fetching randomizer attempts:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

// POST - використати одну спробу
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    // Знаходимо першу доступну спробу
    const attempt = await prisma.randomizerAttempt.findFirst({
      where: {
        userId: session.user.id,
        usedAttempts: { lt: prisma.randomizerAttempt.fields.totalAttempts },
        OR: [
          { expiresAt: null },
          { expiresAt: { gte: new Date() } }
        ]
      },
      orderBy: {
        purchaseDate: 'asc' // Використовуємо найстаріші спочатку
      }
    })

    if (!attempt) {
      return NextResponse.json(
        { error: 'No attempts remaining. Please purchase more attempts.' },
        { status: 403 }
      )
    }

    // Збільшуємо лічильник використаних спроб
    const updated = await prisma.randomizerAttempt.update({
      where: { id: attempt.id },
      data: {
        usedAttempts: attempt.usedAttempts + 1
      }
    })

    return NextResponse.json({
      success: true,
      remainingAttempts: updated.totalAttempts - updated.usedAttempts
    })
  } catch (error) {
    console.error('Error using randomizer attempt:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

