#!/usr/bin/env node

/**
 * Скрипт для тестування реєстрації та синхронізації з Supabase
 */

import { PrismaClient } from '@prisma/client'
import { createClient } from '@supabase/supabase-js'

const prisma = new PrismaClient()

// Supabase клієнт
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Відсутні змінні середовища для Supabase')
  console.error('Переконайтеся, що встановлені:')
  console.error('- NEXT_PUBLIC_SUPABASE_URL')
  console.error('- SUPABASE_SERVICE_ROLE_KEY')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey)

async function testRegistration() {
  try {
    console.log('🧪 Тестування реєстрації користувача...')

    // Створюємо тестового користувача
    const testUser = await prisma.user.create({
      data: {
        name: 'Тестовий Користувач',
        email: `test-${Date.now()}@example.com`,
        password: 'hashed_password_here', // В реальному додатку це має бути хеш
        faculty: 'medical'
      }
    })

    console.log(`✅ Користувач створений в Prisma: ${testUser.id}`)

    // Синхронізуємо з Supabase
    try {
      const { error: supabaseError } = await supabase
        .from('users')
        .insert({
          id: testUser.id,
          first_name: testUser.name?.split(' ')[0] || '',
          last_name: testUser.name?.split(' ').slice(1).join(' ') || '',
          email: testUser.email,
          faculty: testUser.faculty,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })

      if (supabaseError) {
        console.error('❌ Помилка синхронізації з Supabase:', supabaseError)
      } else {
        console.log('✅ Користувач синхронізований з Supabase')
      }
    } catch (supabaseError) {
      console.error('❌ Помилка підключення до Supabase:', supabaseError)
    }

    // Тестуємо створення підписки
    const subscription = await prisma.userSubscription.create({
      data: {
        userId: testUser.id,
        subscriptionType: 'medical',
        status: 'active',
        startDate: new Date(),
        endDate: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000), // +1 рік
        paymentProvider: 'stripe',
        paymentId: `test-payment-${Date.now()}`
      }
    })

    console.log(`✅ Підписка створена: ${subscription.id}`)

    // Синхронізуємо підписку з Supabase
    try {
      const { error: subError } = await supabase
        .from('user_subscriptions')
        .insert({
          id: subscription.id,
          user_id: testUser.id,
          subscription_type: subscription.subscriptionType,
          status: subscription.status,
          start_date: subscription.startDate.toISOString(),
          end_date: subscription.endDate.toISOString(),
          payment_provider: subscription.paymentProvider,
          payment_id: subscription.paymentId,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })

      if (subError) {
        console.error('❌ Помилка синхронізації підписки:', subError)
      } else {
        console.log('✅ Підписка синхронізована з Supabase')
      }
    } catch (subError) {
      console.error('❌ Помилка підключення до Supabase для підписки:', subError)
    }

    // Перевіряємо результати в Supabase
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('id, first_name, last_name, email, faculty')
      .eq('id', testUser.id)

    if (usersError) {
      console.error('❌ Помилка при перевірці користувачів:', usersError)
    } else {
      console.log('📋 Користувачі в Supabase:')
      users?.forEach(user => {
        console.log(`  - ${user.first_name} ${user.last_name} (${user.email}) - ${user.faculty}`)
      })
    }

    const { data: subscriptions, error: subsError } = await supabase
      .from('user_subscriptions')
      .select('id, subscription_type, status, payment_provider')
      .eq('user_id', testUser.id)

    if (subsError) {
      console.error('❌ Помилка при перевірці підписок:', subsError)
    } else {
      console.log('📋 Підписки в Supabase:')
      subscriptions?.forEach(sub => {
        console.log(`  - ${sub.subscription_type} (${sub.status}) - ${sub.payment_provider}`)
      })
    }

    console.log('🎉 Тест завершено!')
    console.log('')
    console.log('📝 Що перевірити в Supabase Dashboard:')
    console.log('1. Відкрийте таблицю "users" - має з\'явитися новий користувач')
    console.log('2. Відкрийте таблицю "user_subscriptions" - має з\'явитися нова підписка')
    console.log('3. Перевірте, що дані синхронізовані правильно')

  } catch (error) {
    console.error('❌ Критична помилка тесту:', error)
  } finally {
    await prisma.$disconnect()
  }
}

// Запуск тесту
testRegistration()
  .then(() => {
    console.log('✅ Тест завершено!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Тест не вдався:', error)
    process.exit(1)
  })
