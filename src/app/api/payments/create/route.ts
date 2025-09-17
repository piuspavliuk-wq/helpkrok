import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'
import { prisma } from '@/lib/prisma'
import Stripe from 'stripe'

// Ініціалізуємо Stripe
const stripe = process.env.STRIPE_SECRET_KEY ? new Stripe(process.env.STRIPE_SECRET_KEY, {
  apiVersion: '2025-08-27.basil',
}) : null

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

    if (!stripe) {
      return NextResponse.json(
        { error: 'Stripe не налаштований' },
        { status: 500 }
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

    // Генеруємо URL для оплати залежно від провайдера
    let paymentUrl = ''

    switch (payment_provider) {
      case 'stripe':
        paymentUrl = await createStripePayment(amount, currency, subscription.id)
        break
      case 'liqpay':
        paymentUrl = await createLiqPayPayment(amount, currency, subscription.id)
        break
      case 'fondy':
        paymentUrl = await createFondyPayment(amount, currency, subscription.id)
        break
      default:
        throw new Error('Невідомий провайдер платежів')
    }

    return NextResponse.json({
      success: true,
      payment_url: paymentUrl,
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

async function createStripePayment(amount: number, currency: string, subscriptionId: string): Promise<string> {
  try {
    if (!stripe) {
      throw new Error('Stripe не налаштований')
    }

    // Створюємо Stripe Checkout Session
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: currency.toLowerCase(),
            product_data: {
              name: 'Help Krok Platform Subscription',
              description: 'Підписка на платформу підготовки до КРОК',
            },
            unit_amount: amount * 100, // Stripe працює з копійками
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: `${process.env.NEXT_PUBLIC_APP_URL}/payment/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/payment/cancel`,
      metadata: {
        subscription_id: subscriptionId,
      },
    })

    return session.url || ''
  } catch (error) {
    console.error('Stripe payment creation error:', error)
    throw new Error('Помилка при створенні Stripe платежу')
  }
}

async function createLiqPayPayment(amount: number, currency: string, subscriptionId: string): Promise<string> {
  // Тут має бути інтеграція з LiqPay
  // Для демонстрації повертаємо заглушку
  return `https://www.liqpay.ua/api/3/checkout?data=${subscriptionId}`
}

async function createFondyPayment(amount: number, currency: string, subscriptionId: string): Promise<string> {
  // Тут має бути інтеграція з Fondy
  // Для демонстрації повертаємо заглушку
  return `https://pay.fondy.eu/api/checkout?order_id=${subscriptionId}`
}
