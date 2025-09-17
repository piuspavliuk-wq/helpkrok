#!/usr/bin/env node

/**
 * Скрипт для перевірки RLS та налаштувань Supabase
 */

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8'

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function checkRLS() {
  try {
    console.log('🔍 Перевіряємо RLS та налаштування Supabase...')
    console.log('')

    // Перевіряємо інформацію про проект
    console.log('📋 Інформація про проект:')
    console.log(`   URL: ${supabaseUrl}`)
    console.log(`   Project ID: nttyhnbjlsnrxbcoxglw`)
    console.log('')

    // Перевіряємо доступ до таблиці users
    console.log('1️⃣ Перевірка доступу до таблиці users...')
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('*')
      .limit(3)

    if (usersError) {
      console.log(`❌ Помилка: ${usersError.message}`)
      console.log(`   Код: ${usersError.code}`)
      
      if (usersError.code === 'PGRST301') {
        console.log('')
        console.log('🚨 ПРОБЛЕМА: RLS (Row Level Security) блокує доступ!')
        console.log('')
        console.log('💡 Рішення:')
        console.log('1. Відкрийте Supabase Dashboard')
        console.log('2. Перейдіть в Authentication → Policies')
        console.log('3. Знайдіть таблицю "users"')
        console.log('4. Або відключіть RLS, або створіть політику:')
        console.log('')
        console.log('   CREATE POLICY "Enable read access for all users" ON "public"."users"')
        console.log('   FOR SELECT USING (true);')
        console.log('')
        console.log('   CREATE POLICY "Enable insert for all users" ON "public"."users"')
        console.log('   FOR INSERT WITH CHECK (true);')
      }
    } else {
      console.log(`✅ Доступ працює! Знайдено ${users?.length || 0} користувачів`)
      
      if (users && users.length > 0) {
        console.log('')
        console.log('📋 Останні користувачі:')
        users.forEach((user, index) => {
          console.log(`${index + 1}. ${user.first_name} ${user.last_name} (${user.email})`)
        })
      }
    }

    // Перевіряємо можливість вставки
    console.log('')
    console.log('2️⃣ Перевірка можливості вставки...')
    const testData = {
      id: `debug-test-${Date.now()}`,
      first_name: 'Debug',
      last_name: 'Test',
      email: `debug-${Date.now()}@test.com`,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    }

    const { data: insertData, error: insertError } = await supabase
      .from('users')
      .insert(testData)
      .select()

    if (insertError) {
      console.log(`❌ Помилка вставки: ${insertError.message}`)
      console.log(`   Код: ${insertError.code}`)
    } else {
      console.log('✅ Вставка працює!')
      console.log(`   Створено користувача: ${insertData?.[0]?.email}`)
    }

    console.log('')
    console.log('🎯 Інструкції для Supabase Dashboard:')
    console.log('')
    console.log('1. Відкрийте: https://supabase.com/dashboard/project/nttyhnbjlsnrxbcoxglw')
    console.log('2. Перейдіть в Table Editor')
    console.log('3. Оберіть таблицю "users"')
    console.log('4. Якщо таблиця порожня, перевірте:')
    console.log('   - Authentication → Policies')
    console.log('   - Database → Tables → users → Settings')
    console.log('   - Відключіть RLS або налаштуйте політики')
    console.log('')
    console.log('5. Альтернативно, використайте SQL Editor:')
    console.log('   SELECT * FROM users ORDER BY created_at DESC LIMIT 10;')

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

checkRLS()
  .then(() => {
    console.log('✅ Перевірка завершена!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Перевірка не вдалася:', error)
    process.exit(1)
  })
