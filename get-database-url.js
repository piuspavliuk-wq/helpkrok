// Скрипт для отримання правильного DATABASE_URL з Supabase
const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

async function getDatabaseUrl() {
  try {
    console.log('🔍 Отримання DATABASE_URL з Supabase...')
    
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY
    
    if (!supabaseUrl || !supabaseKey) {
      console.error('❌ Відсутні змінні середовища')
      return
    }
    
    const supabase = createClient(supabaseUrl, supabaseKey)
    
    // Отримуємо інформацію про проект
    const { data, error } = await supabase
      .from('users')
      .select('id')
      .limit(1)
    
    if (error) {
      console.error('❌ Помилка підключення:', error.message)
      return
    }
    
    console.log('✅ Підключення працює!')
    console.log('📋 Ваші налаштування:')
    console.log('NEXT_PUBLIC_SUPABASE_URL:', supabaseUrl)
    console.log('')
    console.log('🔗 Для отримання DATABASE_URL:')
    console.log('1. Відкрийте Supabase Dashboard')
    console.log('2. Перейдіть до Settings → Database')
    console.log('3. Скопіюйте "Connection string" з секції "Connection pooling"')
    console.log('4. Замініть [YOUR-PASSWORD] на ваш пароль')
    console.log('')
    console.log('📝 Приклад правильного DATABASE_URL:')
    console.log('DATABASE_URL="postgresql://postgres.nttyhnbjlsnrxbcoxglw:[YOUR-PASSWORD]@aws-0-eu-central-1.pooler.supabase.com:6543/postgres"')
    
  } catch (error) {
    console.error('❌ Помилка:', error.message)
  }
}

getDatabaseUrl()
