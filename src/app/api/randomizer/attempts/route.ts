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
      console.error('Supabase env vars missing for GET randomizer attempts')
      return NextResponse.json(
        { error: 'Database configuration error' },
        { status: 500 }
      )
    }

    const supabase = createClient(supabaseUrl, supabaseKey)

    const { data: attempts, error } = await supabase
      .from('randomizer_attempts')
      .select('*')
      .eq('user_id', session.user.id)
      .or('expires_at.is.null,expires_at.gte.' + new Date().toISOString())
      .order('purchase_date', { ascending: false })

    if (error) {
      console.error('Error fetching randomizer attempts:', error)
      return NextResponse.json(
        { error: 'Failed to fetch attempts' },
        { status: 500 }
      )
    }

    const totalAttempts = attempts?.reduce((sum, a) => sum + (a.total_attempts ?? 0), 0) ?? 0
    const usedAttempts = attempts?.reduce((sum, a) => sum + (a.used_attempts ?? 0), 0) ?? 0
    const remainingAttempts = totalAttempts - usedAttempts

    return NextResponse.json({
      totalAttempts,
      usedAttempts,
      remainingAttempts,
      attempts: attempts ?? []
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

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

    if (!supabaseUrl || !supabaseKey) {
      console.error('Supabase env vars missing for POST randomizer attempts')
      return NextResponse.json(
        { error: 'Database configuration error' },
        { status: 500 }
      )
    }

    const supabase = createClient(supabaseUrl, supabaseKey)

    const { data: attempts, error: fetchError } = await supabase
      .from('randomizer_attempts')
      .select('*')
      .eq('user_id', session.user.id)
      .or('expires_at.is.null,expires_at.gte.' + new Date().toISOString())
      .order('purchase_date', { ascending: true })

    if (fetchError) {
      console.error('Error fetching attempts before consume:', fetchError)
      return NextResponse.json(
        { error: 'Failed to fetch attempts' },
        { status: 500 }
      )
    }

    const attempt = attempts?.find(a => (a.used_attempts ?? 0) < (a.total_attempts ?? 0))

    if (!attempt) {
      return NextResponse.json(
        { error: 'No attempts remaining. Please purchase more attempts.' },
        { status: 403 }
      )
    }

    const newUsed = (attempt.used_attempts ?? 0) + 1
    const { data: updated, error: updateError } = await supabase
      .from('randomizer_attempts')
      .update({
        used_attempts: newUsed,
        updated_at: new Date().toISOString()
      })
      .eq('id', attempt.id)
      .select()
      .single()

    if (updateError || !updated) {
      console.error('Error updating attempt:', updateError)
      return NextResponse.json(
        { error: 'Failed to update attempt' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      remainingAttempts: (updated.total_attempts ?? 0) - (updated.used_attempts ?? 0)
    })
  } catch (error) {
    console.error('Error using randomizer attempt:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

