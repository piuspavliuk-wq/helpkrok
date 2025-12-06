import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { createClient } from '@supabase/supabase-js'

async function getServerSession(request: NextRequest) {
  try {
    const token = await getToken({ 
      req: request,
      secret: process.env.NEXTAUTH_SECRET 
    })
    
    if (!token) {
      return null
    }

    return {
      user: {
        id: token.id as string,
        email: token.email as string,
        name: token.name as string,
        role: token.role as string,
      }
    }
  } catch (error) {
    console.error('Error getting session:', error)
    return null
  }
}

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(request)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

    const { searchParams } = new URL(request.url)
    const courseId = searchParams.get('course_id')

    if (!courseId) {
      return NextResponse.json(
        { error: 'course_id обов\'язковий' },
        { status: 400 }
      )
    }

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    const supabase = createClient(supabaseUrl, supabaseKey)

    // Перевіряємо чи є успішний платіж за курс
    const { data: payment, error: paymentError } = await supabase
      .from('payments')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('payment_type', 'course')
      .eq('package_id', courseId) // Використовуємо package_id для зберігання course_id
      .eq('status', 'success')
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle()

    if (paymentError && paymentError.code !== 'PGRST116') {
      console.error('Помилка перевірки платежу:', paymentError)
    }

    const hasPaymentAccess = !!payment

    // Також перевіряємо чи є успішний платіж за підписку (subscription)
    // Якщо користувач оплатив підписку, він має доступ до всіх курсів
    const { data: subscriptionPayment } = await supabase
      .from('payments')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('payment_type', 'subscription')
      .eq('status', 'success')
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle()

    const hasSubscriptionPayment = !!subscriptionPayment

    // Перевіряємо також через таблицю course_access якщо вона існує
    let courseAccess = null
    try {
      const { data: access, error: accessError } = await supabase
        .from('course_access')
        .select('*')
        .eq('user_id', session.user.id)
        .eq('course_id', courseId)
        .eq('access_granted', true)
        .maybeSingle()

      if (!accessError) {
        courseAccess = access
      }
    } catch (error) {
      // Таблиця може не існувати, це нормально
    }

    // Перевіряємо активні підписки для медичного факультету
    // Якщо курс належить до медичного факультету, перевіряємо підписки типу 'medical' або 'premium'
    let hasSubscriptionAccess = false
    try {
      const { data: subscriptions, error: subscriptionError } = await supabase
        .from('user_subscriptions')
        .select('*')
        .eq('user_id', session.user.id)
        .eq('status', 'active')
        .in('subscription_type', ['medical', 'premium'])
        .gte('end_date', new Date().toISOString()) // Підписка ще не закінчилася
        .order('created_at', { ascending: false })
        .limit(1)

      console.log('Перевірка підписок для користувача:', session.user.id, {
        subscriptions,
        subscriptionError,
        hasAccess: !subscriptionError && subscriptions && subscriptions.length > 0
      })

      if (!subscriptionError && subscriptions && subscriptions.length > 0) {
        hasSubscriptionAccess = true
      }
    } catch (error) {
      console.error('Помилка перевірки підписок:', error)
    }

    const finalAccess = hasPaymentAccess || !!courseAccess || hasSubscriptionAccess || hasSubscriptionPayment

    console.log('Перевірка доступу до курсу:', {
      courseId,
      userId: session.user.id,
      hasPaymentAccess,
      hasCourseAccess: !!courseAccess,
      hasSubscriptionAccess,
      finalAccess
    })

    return NextResponse.json({
      success: true,
      hasAccess: finalAccess,
      paymentId: payment?.id || null,
      grantedAt: courseAccess?.granted_at || payment?.created_at || null,
      accessType: hasSubscriptionAccess ? 'subscription' : (hasPaymentAccess ? 'payment' : (courseAccess ? 'access' : null)),
      debug: {
        hasPaymentAccess,
        hasCourseAccess: !!courseAccess,
        hasSubscriptionAccess,
        hasSubscriptionPayment
      }
    })
  } catch (error) {
    console.error('Check course access API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

