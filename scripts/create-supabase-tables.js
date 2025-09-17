#!/usr/bin/env node

/**
 * Скрипт для створення таблиць в Supabase
 * Використовує правильні типи для сумісності з Prisma
 */

import { createClient } from '@supabase/supabase-js'

// Supabase клієнт з service role key
const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8'

const supabase = createClient(supabaseUrl, supabaseServiceKey)

async function createTables() {
  try {
    console.log('🏗️ Створюємо таблиці в Supabase...')

    // SQL для створення таблиць
    const createUsersTable = `
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        telegram_id TEXT UNIQUE,
        telegram_username TEXT,
        first_name TEXT,
        last_name TEXT,
        email TEXT UNIQUE,
        faculty TEXT CHECK (faculty IN ('medical', 'pharmaceutical')),
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      );
    `

    const createSubscriptionsTable = `
      CREATE TABLE IF NOT EXISTS user_subscriptions (
        id TEXT PRIMARY KEY,
        user_id TEXT REFERENCES users(id) ON DELETE CASCADE,
        subscription_type TEXT CHECK (subscription_type IN ('medical', 'pharmaceutical', 'premium')),
        status TEXT CHECK (status IN ('pending', 'active', 'expired', 'cancelled')) DEFAULT 'pending',
        start_date TIMESTAMP WITH TIME ZONE NOT NULL,
        end_date TIMESTAMP WITH TIME ZONE NOT NULL,
        payment_provider TEXT CHECK (payment_provider IN ('stripe', 'liqpay', 'fondy')),
        payment_id TEXT,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      );
    `

    // Створюємо таблиці
    console.log('📋 Створюємо таблицю users...')
    const { error: usersError } = await supabase.rpc('exec_sql', { sql: createUsersTable })
    
    if (usersError) {
      console.error('❌ Помилка при створенні таблиці users:', usersError)
    } else {
      console.log('✅ Таблиця users створена')
    }

    console.log('📋 Створюємо таблицю user_subscriptions...')
    const { error: subsError } = await supabase.rpc('exec_sql', { sql: createSubscriptionsTable })
    
    if (subsError) {
      console.error('❌ Помилка при створенні таблиці user_subscriptions:', subsError)
    } else {
      console.log('✅ Таблиця user_subscriptions створена')
    }

    // Перевіряємо, чи таблиці створені
    console.log('🔍 Перевіряємо створені таблиці...')
    
    const { data: users, error: usersCheckError } = await supabase
      .from('users')
      .select('*')
      .limit(1)

    if (usersCheckError) {
      console.error('❌ Таблиця users не доступна:', usersCheckError)
    } else {
      console.log('✅ Таблиця users доступна')
    }

    const { data: subscriptions, error: subsCheckError } = await supabase
      .from('user_subscriptions')
      .select('*')
      .limit(1)

    if (subsCheckError) {
      console.error('❌ Таблиця user_subscriptions не доступна:', subsCheckError)
    } else {
      console.log('✅ Таблиця user_subscriptions доступна')
    }

    console.log('')
    console.log('🎉 Створення таблиць завершено!')
    console.log('')
    console.log('📝 Що далі:')
    console.log('1. Перевірте таблиці в Supabase Dashboard')
    console.log('2. Запустіть: npm run check:supabase')
    console.log('3. Протестуйте реєстрацію користувача')

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

// Запуск створення таблиць
createTables()
  .then(() => {
    console.log('✅ Створення таблиць завершено!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Створення таблиць не вдалося:', error)
    process.exit(1)
  })
