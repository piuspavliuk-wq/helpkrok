#!/usr/bin/env node

/**
 * Простий скрипт для перевірки існуючих таблиць в Supabase
 */

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8'

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function checkTables() {
  try {
    console.log('🔍 Перевіряємо існуючі таблиці в Supabase...')

    // Список таблиць для перевірки
    const tables = ['users', 'user_subscriptions', 'courses', 'topics', 'questions']

    for (const tableName of tables) {
      try {
        const { data, error } = await supabase
          .from(tableName)
          .select('*')
          .limit(1)

        if (error) {
          console.log(`❌ Таблиця "${tableName}": ${error.message}`)
        } else {
          console.log(`✅ Таблиця "${tableName}": існує`)
        }
      } catch (err) {
        console.log(`❌ Таблиця "${tableName}": помилка підключення`)
      }
    }

    console.log('')
    console.log('📝 Інструкції для створення таблиць:')
    console.log('')
    console.log('1. Відкрийте Supabase Dashboard: https://supabase.com/dashboard')
    console.log('2. Оберіть ваш проект')
    console.log('3. Перейдіть в SQL Editor')
    console.log('4. Виконайте наступний SQL:')
    console.log('')
    console.log('-- Створення таблиці users')
    console.log('CREATE TABLE users (')
    console.log('  id TEXT PRIMARY KEY,')
    console.log('  telegram_id TEXT UNIQUE,')
    console.log('  telegram_username TEXT,')
    console.log('  first_name TEXT,')
    console.log('  last_name TEXT,')
    console.log('  email TEXT UNIQUE,')
    console.log('  faculty TEXT,')
    console.log('  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),')
    console.log('  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()')
    console.log(');')
    console.log('')
    console.log('-- Створення таблиці user_subscriptions')
    console.log('CREATE TABLE user_subscriptions (')
    console.log('  id TEXT PRIMARY KEY,')
    console.log('  user_id TEXT REFERENCES users(id) ON DELETE CASCADE,')
    console.log('  subscription_type TEXT,')
    console.log('  status TEXT DEFAULT \'pending\',')
    console.log('  start_date TIMESTAMP WITH TIME ZONE NOT NULL,')
    console.log('  end_date TIMESTAMP WITH TIME ZONE NOT NULL,')
    console.log('  payment_provider TEXT,')
    console.log('  payment_id TEXT,')
    console.log('  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),')
    console.log('  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()')
    console.log(');')

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

checkTables()
  .then(() => {
    console.log('✅ Перевірка завершена!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Перевірка не вдалася:', error)
    process.exit(1)
  })
