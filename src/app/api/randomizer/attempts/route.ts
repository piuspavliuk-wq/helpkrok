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

    // Перевіряємо чи є активна підписка з необмеженими спробами
    const { data: subscriptions } = await supabase
      .from('user_subscriptions')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('status', 'active')
      .gte('end_date', new Date().toISOString())

    const hasUnlimitedSubscription = subscriptions?.some(sub => {
      // Перевіряємо через payment_id, чи це VIP Premium або Premium Standard
      // Потрібно перевірити через payments таблицю
      return true // Тимчасово, потім додамо перевірку через payments
    })

    // Спочатку отримуємо спроби з бази
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
    
    // Якщо totalAttempts >= 999999, це означає необмежені спроби
    let isUnlimited = totalAttempts >= 999999
    
    // Також перевіряємо через активні підписки
    if (subscriptions && subscriptions.length > 0 && !isUnlimited) {
      for (const sub of subscriptions) {
        if (sub.payment_id) {
          const { data: payment } = await supabase
            .from('payments')
            .select('metadata')
            .eq('id', sub.payment_id)
            .eq('payment_type', 'subscription')
            .eq('status', 'success')
            .maybeSingle()

          if (payment?.metadata) {
            try {
              const metadata = JSON.parse(payment.metadata)
              const subscriptionId = metadata.subscriptionId
              if (subscriptionId === 'vip-premium' || subscriptionId === 'premium-standard') {
                isUnlimited = true
                break
              }
            } catch (e) {
              // Ігноруємо помилки парсингу
            }
          }
        }
      }
    }
    
    const calculatedRemainingAttempts = totalAttempts - usedAttempts
    
    const remainingAttempts = isUnlimited ? 999999 : calculatedRemainingAttempts

    console.log('Randomizer attempts check:', {
      userId: session.user.id,
      totalAttempts,
      usedAttempts,
      calculatedRemainingAttempts,
      isUnlimited,
      remainingAttempts
    })

    return NextResponse.json({
      totalAttempts: isUnlimited ? 999999 : totalAttempts,
      usedAttempts,
      remainingAttempts,
      isUnlimited,
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

    // Перевіряємо чи є активна підписка з необмеженими спробами
    const { data: subscriptions } = await supabase
      .from('user_subscriptions')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('status', 'active')
      .gte('end_date', new Date().toISOString())

    let isUnlimited = false
    if (subscriptions && subscriptions.length > 0) {
      for (const sub of subscriptions) {
        const { data: payment } = await supabase
          .from('payments')
          .select('metadata')
          .eq('id', sub.payment_id)
          .eq('payment_type', 'subscription')
          .eq('status', 'success')
          .maybeSingle()

        if (payment?.metadata) {
          try {
            const metadata = JSON.parse(payment.metadata)
            const subscriptionId = metadata.subscriptionId
            if (subscriptionId === 'vip-premium' || subscriptionId === 'premium-standard') {
              isUnlimited = true
              break
            }
          } catch (e) {
            // Ігноруємо помилки парсингу
          }
        }
      }
    }

    // Якщо є необмежена підписка, не віднімаємо спроби
    if (isUnlimited) {
      return NextResponse.json({
        success: true,
        remainingAttempts: 999999,
        isUnlimited: true
      })
    }

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

