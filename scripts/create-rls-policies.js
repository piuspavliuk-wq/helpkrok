#!/usr/bin/env node

/**
 * Скрипт для створення RLS політик в Supabase
 */

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://nttyhnbjlsnrxbcoxglw.supabase.co'
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'your_service_role_key_here'

const supabase = createClient(supabaseUrl, supabaseServiceKey)

async function createRLSPolicies() {
  try {
    console.log('🔐 Створюємо RLS політики для доступу до даних...')
    console.log('')

    // Політики для таблиці users
    console.log('1️⃣ Створюємо політики для таблиці users...')
    
    const usersPolicies = [
      {
        name: 'Enable read access for all users',
        sql: `CREATE POLICY "Enable read access for all users" ON "public"."users" FOR SELECT USING (true);`
      },
      {
        name: 'Enable insert for all users', 
        sql: `CREATE POLICY "Enable insert for all users" ON "public"."users" FOR INSERT WITH CHECK (true);`
      },
      {
        name: 'Enable update for all users',
        sql: `CREATE POLICY "Enable update for all users" ON "public"."users" FOR UPDATE USING (true);`
      },
      {
        name: 'Enable delete for all users',
        sql: `CREATE POLICY "Enable delete for all users" ON "public"."users" FOR DELETE USING (true);`
      }
    ]

    for (const policy of usersPolicies) {
      try {
        const { error } = await supabase.rpc('exec_sql', { sql: policy.sql })
        if (error) {
          console.log(`⚠️ Політика "${policy.name}": ${error.message}`)
        } else {
          console.log(`✅ Політика "${policy.name}" створена`)
        }
      } catch (err) {
        console.log(`❌ Помилка створення політики "${policy.name}": ${err.message}`)
      }
    }

    // Політики для таблиці user_subscriptions
    console.log('')
    console.log('2️⃣ Створюємо політики для таблиці user_subscriptions...')
    
    const subscriptionsPolicies = [
      {
        name: 'Enable read access for subscriptions',
        sql: `CREATE POLICY "Enable read access for subscriptions" ON "public"."user_subscriptions" FOR SELECT USING (true);`
      },
      {
        name: 'Enable insert for subscriptions',
        sql: `CREATE POLICY "Enable insert for subscriptions" ON "public"."user_subscriptions" FOR INSERT WITH CHECK (true);`
      },
      {
        name: 'Enable update for subscriptions',
        sql: `CREATE POLICY "Enable update for subscriptions" ON "public"."user_subscriptions" FOR UPDATE USING (true);`
      }
    ]

    for (const policy of subscriptionsPolicies) {
      try {
        const { error } = await supabase.rpc('exec_sql', { sql: policy.sql })
        if (error) {
          console.log(`⚠️ Політика "${policy.name}": ${error.message}`)
        } else {
          console.log(`✅ Політика "${policy.name}" створена`)
        }
      } catch (err) {
        console.log(`❌ Помилка створення політики "${policy.name}": ${err.message}`)
      }
    }

    console.log('')
    console.log('🎯 Альтернативний спосіб - через SQL Editor:')
    console.log('')
    console.log('Скопіюйте та виконайте в SQL Editor:')
    console.log('')
    console.log('-- Політики для users')
    console.log('CREATE POLICY "Enable read access for all users" ON "public"."users" FOR SELECT USING (true);')
    console.log('CREATE POLICY "Enable insert for all users" ON "public"."users" FOR INSERT WITH CHECK (true);')
    console.log('CREATE POLICY "Enable update for all users" ON "public"."users" FOR UPDATE USING (true);')
    console.log('CREATE POLICY "Enable delete for all users" ON "public"."users" FOR DELETE USING (true);')
    console.log('')
    console.log('-- Політики для user_subscriptions')
    console.log('CREATE POLICY "Enable read access for subscriptions" ON "public"."user_subscriptions" FOR SELECT USING (true);')
    console.log('CREATE POLICY "Enable insert for subscriptions" ON "public"."user_subscriptions" FOR INSERT WITH CHECK (true);')
    console.log('CREATE POLICY "Enable update for subscriptions" ON "public"."user_subscriptions" FOR UPDATE USING (true);')
    console.log('')
    console.log('📝 Після створення політик:')
    console.log('1. Перейдіть в Table Editor')
    console.log('2. Оберіть таблицю "users"')
    console.log('3. Користувачі мають з\'явитися')

  } catch (error) {
    console.error('❌ Критична помилка:', error)
  }
}

createRLSPolicies()
  .then(() => {
    console.log('✅ Створення політик завершено!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('💥 Створення політик не вдалося:', error)
    process.exit(1)
  })
