// Перевірка змінних середовища та підключення до Supabase
// Запустіть: node check-env-and-connection.js

const { createClient } = require('@supabase/supabase-js');

console.log('🔍 Перевірка змінних середовища та підключення до Supabase...\n');

// Перевіряємо змінні середовища
console.log('1️⃣ Перевірка змінних середовища:');
console.log('NEXT_PUBLIC_SUPABASE_URL:', process.env.NEXT_PUBLIC_SUPABASE_URL ? '✅ Встановлено' : '❌ Не встановлено');
console.log('NEXT_PUBLIC_SUPABASE_ANON_KEY:', process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ? '✅ Встановлено' : '❌ Не встановлено');
console.log('SUPABASE_SERVICE_ROLE_KEY:', process.env.SUPABASE_SERVICE_ROLE_KEY ? '✅ Встановлено' : '❌ Не встановлено');
console.log('NEXTAUTH_SECRET:', process.env.NEXTAUTH_SECRET ? '✅ Встановлено' : '❌ Не встановлено');
console.log('');

// Перевіряємо підключення до Supabase
async function testSupabaseConnection() {
  console.log('2️⃣ Тестування підключення до Supabase:');
  
  try {
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
    const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseAnonKey) {
      console.log('❌ Відсутні змінні середовища для Supabase');
      return;
    }

    // Тестуємо з anon key
    console.log('Тестування з anon key...');
    const supabase = createClient(supabaseUrl, supabaseAnonKey);
    
    const { data: anonData, error: anonError } = await supabase
      .from('user_test_progress')
      .select('count')
      .limit(1);

    if (anonError) {
      console.log('❌ Помилка з anon key:', anonError.message);
    } else {
      console.log('✅ Підключення з anon key працює');
    }

    // Тестуємо з service key
    if (supabaseServiceKey) {
      console.log('Тестування з service key...');
      const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
        auth: {
          autoRefreshToken: false,
          persistSession: false
        }
      });

      const { data: adminData, error: adminError } = await supabaseAdmin
        .from('user_test_progress')
        .select('count')
        .limit(1);

      if (adminError) {
        console.log('❌ Помилка з service key:', adminError.message);
      } else {
        console.log('✅ Підключення з service key працює');
      }
    } else {
      console.log('⚠️  Service key не встановлено');
    }

  } catch (error) {
    console.log('❌ Критична помилка підключення:', error.message);
  }
}

// Перевіряємо API endpoint
async function testAPIEndpoint() {
  console.log('\n3️⃣ Тестування API endpoint:');
  
  try {
    const response = await fetch('http://localhost:3000/api/test-progress?testType=anatomy');
    console.log('Статус API:', response.status);
    
    if (response.status === 401) {
      console.log('⚠️  API повертає 401 - потрібна авторизація');
    } else if (response.status === 500) {
      console.log('❌ API повертає 500 - внутрішня помилка сервера');
      const errorData = await response.json();
      console.log('Помилка:', errorData);
    } else if (response.status === 200) {
      console.log('✅ API працює правильно');
    } else {
      console.log('⚠️  Неочікуваний статус:', response.status);
    }
  } catch (error) {
    console.log('❌ Помилка підключення до API:', error.message);
    console.log('Переконайтеся, що сервер запущений (npm run dev)');
  }
}

// Запускаємо перевірки
async function runChecks() {
  await testSupabaseConnection();
  await testAPIEndpoint();
  
  console.log('\n📋 Рекомендації:');
  console.log('1. Переконайтеся, що всі змінні середовища встановлені в .env.local');
  console.log('2. Перезапустіть сервер після зміни змінних середовища');
  console.log('3. Перевірте, що користувач увійшов в систему');
  console.log('4. Перевірте логи сервера на наявність помилок');
}

runChecks();
