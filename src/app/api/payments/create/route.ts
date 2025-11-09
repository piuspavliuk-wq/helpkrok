import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import { prisma } from '@/lib/prisma'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { plan_type, payment_provider, amount, currency } = body

    if (!plan_type || !payment_provider || !amount || !currency) {
      return NextResponse.json(
        { error: 'Необхідні поля відсутні' },
        { status: 400 }
      )
    }

    // Отримуємо користувача з сесії (спрощена версія)
    const userId = 'temp-user-id' // В реальному додатку це має бути з NextAuth сесії

    // Визначаємо дати підписки
    const startDate = new Date()
    const endDate = new Date()
    endDate.setFullYear(endDate.getFullYear() + 1) // 1 рік підписки

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

    // Синхронізація з Supabase
    try {
      if (!supabase) {
        console.warn('Supabase not available, skipping sync')
      } else {
        await supabase
        .from('user_subscriptions')
        .insert({
          id: subscription.id,
          user_id: userId,
          subscription_type: plan_type,
          status: 'pending',
          start_date: startDate.toISOString(),
          end_date: endDate.toISOString(),
          payment_provider: payment_provider,
          payment_id: subscription.paymentId,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
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
      payment_url: await createMonoPayment(amount, currency, subscription.id),
      subscription_id: subscription.id,
    })
  } catch (error) {
    console.error('Payment creation error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

async function createMonoPayment(amount: number, currency: string, subscriptionId: string): Promise<string> {
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

  const payload: Record<string, unknown> = {
    amount: Math.round(amount * 100),
    ccy,
    merchantPaymInfo: {
      reference: subscriptionId,
      destination: 'Підписка Randomizer PRO',
    },
    redirectUrl: `${appUrl}/payment/success?provider=mono&subscription_id=${subscriptionId}`,
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
