#!/usr/bin/env node

/**
 * Детальний тест підключення до Supabase
 */

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8'

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function detailedTest() {
  try {
    console.log('🔍 Детальний тест підключення до Supabase...')
    console.log('')

    // Тест 1: Перевірка підключення
    console.log('1️⃣ Тестуємо підключення...')
    const { data: connectionTest, error: connectionError } = await supabase
      .from('users')
      .select('count')
      .limit(1)

    if (connectionError) {
      console.log(`❌ Помилка підключення: ${connectionError.message}`)
      console.log(`   Код помилки: ${connectionError.code}`)
      console.log(`   Деталі: ${connectionError.details}`)
      console.log(`   Підказка: ${connectionError.hint}`)
    } else {
      console.log('✅ Підключення працює')
    }

    // Тест 2: Спробуємо отримати всіх користувачів
    console.log('')
    console.log('2️⃣ Отримуємо всіх користувачів...')
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('*')

    if (usersError) {
      console.log(`❌ Помилка при отриманні користувачів: ${usersError.message}`)
      console.log(`   Код помилки: ${usersError.code}`)
    } else {
      console.log(`✅ Отримано ${users?.length || 0} користувачів`)
      if (users && users.length > 0) {
        console.log('')
        console.log('📋 Список користувачів:')
        users.forEach((user, index) => {
          console.log(`${index + 1}. ${user.first_name} ${user.last_name} (${user.email})`)
          console.log(`   ID: ${user.id}`)
          console.log(`   Створено: ${new Date(user.created_at).toLocaleString('uk-UA')}`)
          console.log('')
        })
      }
    }

    // Тест 3: Спробуємо вставити тестового користувача
    console.log('3️⃣ Тестуємо вставку користувача...')
    const testUserId = `test-${Date.now()}`
    const { data: insertData, error: insertError } = await supabase
      .from('users')
      .insert({
        id: testUserId,
        first_name: 'Тестовий',
        last_name: 'Користувач',
        email: `test-${Date.now()}@example.com`,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()

    if (insertError) {
      console.log(`❌ Помилка при вставці: ${insertError.message}`)
      console.log(`   Код помилки: ${insertError.code}`)
    } else {
      console.log('✅ Тестовий користувач створений')
      console.log(`   ID: ${insertData?.[0]?.id}`)
    }

    // Тест 4: Перевірка структури таблиці
    console.log('')
    console.log('4️⃣ Перевірка структури таблиці...')
    const { data: structureTest, error: structureError } = await supabase
      .from('users')
      .select('*')
      .limit(1)

    if (structureError) {
      console.log(`❌ Помилка структури: ${structureError.message}`)
    } else {
      console.log('✅ Структура таблиці доступна')
      if (structureTest && structureTest.length > 0) {
        console.log('📋 Поля таблиці:')
        Object.keys(structureTest[0]).forEach(field => {
          console.log(`   - ${field}`)
        })
      }
    }

    console.log('')
    console.log('🎯 Висновки:')
    if (usersError && usersError.code === 'PGRST301') {
      console.log('❌ Проблема: RLS (Row Level Security) блокує доступ')
      console.log('💡 Рішення: Відключіть RLS або налаштуйте політики доступу')
    } else if (usersError && usersError.code === 'PGRST205') {
      console.log('❌ Проблема: Таблиця не існує')
      console.log('💡 Рішення: Створіть таблицю в Supabase Dashboard')
    } else if (users && users.length > 0) {
      console.log('✅ Все працює правильно!')
    } else {
      console.log('⚠️ Неочікувана ситуація')
    }

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

detailedTest()
  .then(() => {
    console.log('✅ Тест завершено!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Тест не вдався:', error)
    process.exit(1)
  })
