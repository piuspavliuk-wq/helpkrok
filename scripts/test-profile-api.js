const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

const supabase = createClient(supabaseUrl, supabaseKey)

async function testProfileAPI() {
  console.log('🧪 Тестування API профілю...')
  
  try {
    // Тестуємо GET запит
    console.log('📥 Тестування GET /api/user/profile...')
    const getResponse = await fetch('http://localhost:3000/api/user/profile')
    const getData = await getResponse.json()
    
    if (getResponse.status === 401) {
      console.log('✅ GET API працює (потребує авторизації)')
    } else {
      console.log('📊 GET Response:', getData)
    }

    // Тестуємо PUT запит
    console.log('📤 Тестування PUT /api/user/profile...')
    const putResponse = await fetch('http://localhost:3000/api/user/profile', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        firstName: 'Тест',
        lastName: 'Користувач',
        faculty: 'medical',
        university: 'Харківський національний університет імені В. Н. Каразіна',
        email: 'test@example.com',
        step: 'krok1'
      })
    })
    
    const putData = await putResponse.json()
    
    if (putResponse.status === 401) {
      console.log('✅ PUT API працює (потребує авторизації)')
    } else {
      console.log('📊 PUT Response:', putData)
    }

    console.log('🎉 API тестування завершено!')
    
  } catch (error) {
    console.error('❌ Помилка тестування API:', error)
  }
}

testProfileAPI()
