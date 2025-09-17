#!/usr/bin/env node

/**
 * Простий скрипт для перевірки користувачів в Supabase
 */

import { createClient } from '@supabase/supabase-js'

// Supabase клієнт з публічними ключами
const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8'

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function checkUsers() {
  try {
    console.log('🔍 Перевіряємо користувачів в Supabase...')

    // Перевіряємо користувачів
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('id, first_name, last_name, email, faculty, created_at')
      .order('created_at', { ascending: false })
      .limit(10)

    if (usersError) {
      console.error('❌ Помилка при отриманні користувачів:', usersError)
      return
    }

    if (!users || users.length === 0) {
      console.log('📭 Користувачів не знайдено в Supabase')
      console.log('')
      console.log('💡 Можливі причини:')
      console.log('1. Таблиця "users" не існує в Supabase')
      console.log('2. RLS (Row Level Security) блокує доступ')
      console.log('3. Синхронізація не працює')
      return
    }

    console.log(`✅ Знайдено ${users.length} користувачів в Supabase:`)
    console.log('')
    
    users.forEach((user, index) => {
      console.log(`${index + 1}. ${user.first_name} ${user.last_name}`)
      console.log(`   Email: ${user.email}`)
      console.log(`   Faculty: ${user.faculty || 'Не вказано'}`)
      console.log(`   Created: ${new Date(user.created_at).toLocaleString('uk-UA')}`)
      console.log(`   ID: ${user.id}`)
      console.log('')
    })

    // Перевіряємо підписки
    const { data: subscriptions, error: subsError } = await supabase
      .from('user_subscriptions')
      .select('id, user_id, subscription_type, status, payment_provider, created_at')
      .order('created_at', { ascending: false })
      .limit(5)

    if (subsError) {
      console.log('⚠️ Не вдалося отримати підписки (можливо таблиця не існує)')
    } else if (subscriptions && subscriptions.length > 0) {
      console.log(`📋 Знайдено ${subscriptions.length} підписок:`)
      subscriptions.forEach((sub, index) => {
        console.log(`${index + 1}. ${sub.subscription_type} (${sub.status}) - ${sub.payment_provider}`)
        console.log(`   User ID: ${sub.user_id}`)
        console.log(`   Created: ${new Date(sub.created_at).toLocaleString('uk-UA')}`)
        console.log('')
      })
    } else {
      console.log('📭 Підписок не знайдено')
    }

    console.log('🎉 Перевірка завершена!')
    console.log('')
    console.log('📝 Що перевірити в Supabase Dashboard:')
    console.log('1. Відкрийте https://supabase.com/dashboard')
    console.log('2. Оберіть ваш проект')
    console.log('3. Перейдіть в Table Editor')
    console.log('4. Перевірте таблиці "users" та "user_subscriptions"')

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

// Запуск перевірки
checkUsers()
  .then(() => {
    console.log('✅ Перевірка завершена!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Перевірка не вдалася:', error)
    process.exit(1)
  })
