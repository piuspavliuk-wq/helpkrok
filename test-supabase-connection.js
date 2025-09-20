// Тест з'єднання з Supabase
const SUPABASE_URL = 'https://nttyhnbjlsnrxbcoxglw.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8';

async function testSupabaseConnection() {
  console.log('🔍 Тестування з\'єднання з Supabase...');
  console.log('─'.repeat(50));
  console.log('🌐 URL:', SUPABASE_URL);
  console.log('🔑 Key:', SUPABASE_ANON_KEY.substring(0, 20) + '...');
  
  try {
    // Тест 1: Перевірка доступності API
    console.log('\n📡 Тест 1: Перевірка доступності API...');
    const healthResponse = await fetch(`${SUPABASE_URL}/rest/v1/`, {
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    });
    
    console.log('📊 Статус API:', healthResponse.status);
    if (healthResponse.ok) {
      console.log('✅ Supabase API доступний');
    } else {
      console.log('❌ Supabase API недоступний');
      return;
    }

    // Тест 2: Перевірка таблиць
    console.log('\n📡 Тест 2: Перевірка таблиць...');
    const tablesResponse = await fetch(`${SUPABASE_URL}/rest/v1/`, {
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    });
    
    console.log('📊 Статус таблиць:', tablesResponse.status);

    // Тест 3: Спроба отримати дані з таблиці users
    console.log('\n📡 Тест 3: Перевірка таблиці users...');
    try {
      const usersResponse = await fetch(`${SUPABASE_URL}/rest/v1/users?select=id&limit=1`, {
        headers: {
          'apikey': SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
          'Content-Type': 'application/json'
        }
      });
      
      console.log('📊 Статус users:', usersResponse.status);
      
      if (usersResponse.ok) {
        const usersData = await usersResponse.json();
        console.log('✅ Таблиця users доступна, записів:', usersData.length);
      } else {
        const errorText = await usersResponse.text();
        console.log('❌ Помилка таблиці users:', errorText);
      }
    } catch (error) {
      console.log('❌ Помилка запиту до users:', error.message);
    }

    // Тест 4: Спроба отримати дані з таблиці anatomy_questions
    console.log('\n📡 Тест 4: Перевірка таблиці anatomy_questions...');
    try {
      const questionsResponse = await fetch(`${SUPABASE_URL}/rest/v1/anatomy_questions?select=id&limit=1`, {
        headers: {
          'apikey': SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
          'Content-Type': 'application/json'
        }
      });
      
      console.log('📊 Статус anatomy_questions:', questionsResponse.status);
      
      if (questionsResponse.ok) {
        const questionsData = await questionsResponse.json();
        console.log('✅ Таблиця anatomy_questions доступна, записів:', questionsData.length);
      } else {
        const errorText = await questionsResponse.text();
        console.log('❌ Помилка таблиці anatomy_questions:', errorText);
      }
    } catch (error) {
      console.log('❌ Помилка запиту до anatomy_questions:', error.message);
    }

  } catch (error) {
    console.error('❌ Загальна помилка з\'єднання:', error.message);
  }
  
  console.log('\n─'.repeat(50));
  console.log('💡 Можливі причини проблем:');
  console.log('1. Supabase проект призупинений');
  console.log('2. Неправильні API ключі');
  console.log('3. Проблеми з мережею');
  console.log('4. RLS (Row Level Security) блокує доступ');
}

// Запуск тесту
testSupabaseConnection();