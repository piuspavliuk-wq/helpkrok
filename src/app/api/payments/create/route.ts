import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { supabase } from '@/lib/supabase'
import { prisma } from '@/lib/prisma'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { plan_type, payment_provider, amount, currency, attempts_count } = body

    if (!plan_type || !payment_provider || !amount || !currency) {
      return NextResponse.json(
        { error: 'Необхідні поля відсутні' },
        { status: 400 }
      )
    }

    // Отримуємо користувача з сесії
    const session = await getServerSession(authOptions)
    const userId = session?.user?.id || 'temp-user-id'

    // Визначаємо дати підписки
    const startDate = new Date()
    const endDate = new Date()
    endDate.setFullYear(endDate.getFullYear() + 1) // 1 рік підписки

    let subscriptionId: string
    let subscriptionRecord: {
      id: string
      paymentId: string
    } | null = null

    // Якщо це Randomizer PRO - створюємо запис спроб
    if (plan_type === 'randomizer' && attempts_count) {
      const randomizerAttempt = await prisma.randomizerAttempt.create({
        data: {
          userId: userId,
          totalAttempts: attempts_count,
          usedAttempts: 0,
          paymentId: `temp-payment-${Date.now()}`,
          expiresAt: null // Спроби не мають терміну дії
        }
      })
      subscriptionId = randomizerAttempt.id
    } else {
      // Створюємо підписку в Prisma (локальна база)
      const subscription = await prisma.userSubscription.create({
        data: {
          userId: userId,
          subscriptionType: plan_type,
          status: 'pending', // Спочатку pending, потім active після оплати
          startDate: startDate,
          endDate: endDate,
          paymentProvider: payment_provider,
          paymentId: `temp-payment-${Date.now()}`,
        }
      })
      subscriptionId = subscription.id
      subscriptionRecord = {
        id: subscription.id,
        paymentId: subscription.paymentId ?? ''
      }
    }

    // Синхронізація з Supabase
    try {
      if (!supabase) {
        console.warn('Supabase not available, skipping sync')
      } else {
        if (subscriptionRecord) {
          await supabase
            .from('user_subscriptions')
            .insert({
              id: subscriptionRecord.id,
              user_id: userId,
              subscription_type: plan_type,
              status: 'pending',
              start_date: startDate.toISOString(),
              end_date: endDate.toISOString(),
              payment_provider: payment_provider,
              payment_id: subscriptionRecord.paymentId,
              created_at: new Date().toISOString(),
              updated_at: new Date().toISOString()
            })
        }
      }
    } catch (supabaseError) {
      console.error('Supabase sync error:', supabaseError)
      // Продовжуємо роботу з локальною базою
    }

    if (payment_provider !== 'mono') {
      throw new Error('Підтримується лише Plata by mono')
    }

    return NextResponse.json({
      success: true,
      payment_url: await createMonoPayment(amount, currency, subscriptionId, plan_type, attempts_count),
      subscription_id: subscriptionId,
    })
  } catch (error) {
    console.error('Payment creation error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

async function createMonoPayment(
  amount: number, 
  currency: string, 
  subscriptionId: string,
  planType: string,
  attemptsCount?: number
): Promise<string> {
  const token = process.env.MONOBANK_API_TOKEN
  if (!token) {
    throw new Error('Plata by mono токен не налаштований')
  }

  const appUrl = process.env.NEXT_PUBLIC_APP_URL
  if (!appUrl) {
    throw new Error('NEXT_PUBLIC_APP_URL не налаштований')
  }

  const currencyToCcy: Record<string, number> = {
    UAH: 980,
    USD: 840,
    EUR: 978,
  }

  const normalizedCurrency = currency.toUpperCase()
  const ccy = currencyToCcy[normalizedCurrency]

  if (!ccy) {
    throw new Error(`Непідтримувана валюта для Plata by mono: ${currency}`)
  }

  let destination = 'Підписка Help Krok Platform'
  if (planType === 'randomizer' && attemptsCount) {
    destination = `Randomizer PRO - ${attemptsCount} ${attemptsCount === 1 ? 'спроба' : 'спроб'}`
  }

  const payload: Record<string, unknown> = {
    amount: Math.round(amount * 100),
    ccy,
    merchantPaymInfo: {
      reference: subscriptionId,
      destination,
    },
    redirectUrl: `${appUrl}/payment/success?provider=mono&subscription_id=${subscriptionId}&plan_type=${planType}${attemptsCount ? `&attempts=${attemptsCount}` : ''}`,
    validity: 15 * 60,
    paymentType: 'debit',
  }

  if (process.env.MONOBANK_WEBHOOK_URL) {
    payload.webHookUrl = process.env.MONOBANK_WEBHOOK_URL
  }

  const response = await fetch(
    process.env.MONOBANK_API_URL ?? 'https://api.monobank.ua/api/merchant/invoice/create',
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Token': token,
      },
      body: JSON.stringify(payload),
    }
  )

  if (!response.ok) {
    const errorText = await response.text()
    console.error('Plata by mono payment creation error:', errorText)
    throw new Error('Помилка при створенні платежу через Plata by mono')
  }

  const data = await response.json()

  if (!data?.pageUrl) {
    console.error('Plata by mono response без pageUrl:', data)
    throw new Error('Не отримано посилання на оплату від Plata by mono')
  }

  return data.pageUrl
}
