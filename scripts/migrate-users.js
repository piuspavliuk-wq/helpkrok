#!/usr/bin/env node

/**
 * Скрипт для міграції користувачів з SQLite (Prisma) в Supabase
 * Використовуйте цей скрипт для синхронізації існуючих користувачів
 */

import { PrismaClient } from '@prisma/client'
import { createClient } from '@supabase/supabase-js'

const prisma = new PrismaClient()

// Supabase клієнт
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Відсутні змінні середовища для Supabase')
  console.error('Переконайтеся, що встановлені:')
  console.error('- NEXT_PUBLIC_SUPABASE_URL')
  console.error('- SUPABASE_SERVICE_ROLE_KEY')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey)

async function migrateUsers() {
  try {
    console.log('🔄 Початок міграції користувачів...')

    // Отримуємо всіх користувачів з Prisma
    const users = await prisma.user.findMany({
      select: {
        id: true,
        name: true,
        email: true,
        telegramId: true,
        firstName: true,
        lastName: true,
        username: true,
        photoUrl: true,
        faculty: true,
        createdAt: true,
        updatedAt: true,
      }
    })

    console.log(`📊 Знайдено ${users.length} користувачів для міграції`)

    if (users.length === 0) {
      console.log('✅ Немає користувачів для міграції')
      return
    }

    // Підготовка даних для Supabase
    const supabaseUsers = users.map(user => ({
      id: user.id,
      telegram_id: user.telegramId,
      telegram_username: user.username,
      first_name: user.firstName || user.name?.split(' ')[0] || '',
      last_name: user.lastName || user.name?.split(' ').slice(1).join(' ') || '',
      faculty: user.faculty,
      created_at: user.createdAt.toISOString(),
      updated_at: user.updatedAt.toISOString()
    }))

    // Вставка користувачів в Supabase
    const { data, error } = await supabase
      .from('users')
      .upsert(supabaseUsers, { 
        onConflict: 'id',
        ignoreDuplicates: false 
      })

    if (error) {
      console.error('❌ Помилка при вставці користувачів:', error)
      return
    }

    console.log(`✅ Успішно мігровано ${supabaseUsers.length} користувачів в Supabase`)

    // Перевірка результатів
    const { data: insertedUsers, error: checkError } = await supabase
      .from('users')
      .select('id, first_name, last_name, telegram_id')
      .limit(5)

    if (checkError) {
      console.error('❌ Помилка при перевірці:', checkError)
    } else {
      console.log('📋 Приклад мігрованих користувачів:')
      insertedUsers?.forEach(user => {
        console.log(`  - ${user.first_name} ${user.last_name} (ID: ${user.id})`)
      })
    }

  } catch (error) {
    console.error('❌ Критична помилка міграції:', error)
  } finally {
    await prisma.$disconnect()
  }
}

// Запуск міграції
migrateUsers()
  .then(() => {
    console.log('🎉 Міграція завершена!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Міграція не вдалася:', error)
    process.exit(1)
  })
