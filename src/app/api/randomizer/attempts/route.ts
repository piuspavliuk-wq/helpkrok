import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { createClient } from '@supabase/supabase-js'

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

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Database configuration error' },
        { status: 500 }
      )
    }

    const supabase = createClient(supabaseUrl, supabaseKey)

    // Отримуємо всі активні спроби користувача
    const { data: attempts, error } = await supabase
      .from('randomizer_attempts')
      .select('*')
      .eq('user_id', session.user.id)
      .or('expires_at.is.null,expires_at.gte.' + new Date().toISOString())
      .order('purchase_date', { ascending: false })

    if (error) {
      console.error('Error fetching attempts:', error)
      return NextResponse.json(
        { error: 'Failed to fetch attempts' },
        { status: 500 }
      )
    }

    const totalAttempts = attempts?.reduce((sum, a) => sum + (a.total_attempts || 0), 0) || 0
    const usedAttempts = attempts?.reduce((sum, a) => sum + (a.used_attempts || 0), 0) || 0
    const remainingAttempts = totalAttempts - usedAttempts

    return NextResponse.json({
      totalAttempts,
      usedAttempts,
      remainingAttempts,
      attempts: attempts || []
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

