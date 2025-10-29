require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища SUPABASE_URL або SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkFreudTest() {
  console.log('🔍 Перевіряємо тест "Delving into dreams"...\n');

  try {
    // Перевіряємо чи є записи з test_identifier '2025-freud-dreams'
    const { data: freudData, error: freudError } = await supabase
      .from('krok_questions_unified')
      .select('*')
      .eq('test_identifier', '2025-freud-dreams');

    if (freudError) {
      console.error('❌ Помилка при перевірці freud тесту:', freudError);
      return;
    }

    console.log(`📊 Знайдено записів з test_identifier '2025-freud-dreams': ${freudData.length}`);
    
    if (freudData.length > 0) {
      console.log('✅ Тест знайдено в базі даних!');
      console.log(`📝 Назва: ${freudData[0].title}`);
      console.log(`📅 Рік: ${freudData[0].year}`);
      console.log(`🏥 Факультет: ${freudData[0].faculty}`);
      console.log(`🆔 Test ID: ${freudData[0].test_identifier}`);
    } else {
      console.log('❌ Тест НЕ знайдено в базі даних!');
    }

    // Перевіряємо всі записи за 2025 рік
    const { data: all2025Data, error: all2025Error } = await supabase
      .from('krok_questions_unified')
      .select('test_identifier, title, year, faculty')
      .eq('year', 2025);

    if (all2025Error) {
      console.error('❌ Помилка при перевірці 2025 року:', all2025Error);
      return;
    }

    console.log(`\n📊 Всі записи за 2025 рік (${all2025Data.length}):`);
    all2025Data.forEach((record, index) => {
      console.log(`${index + 1}. ${record.title} (${record.test_identifier}) - ${record.faculty}`);
    });

    // Перевіряємо API endpoint
    console.log('\n🌐 Тестуємо API endpoint...');
    const response = await fetch('http://localhost:3001/api/brochures');
    if (response.ok) {
      const apiData = await response.json();
      console.log('✅ API працює');
      
      // Шукаємо 2025 рік в API відповіді
      const year2025 = apiData.find(item => item.year === 2025);
      if (year2025) {
        console.log('✅ 2025 рік знайдено в API');
        console.log(`📋 Тести в 2025: ${year2025.booklets.length}`);
        year2025.booklets.forEach((booklet, index) => {
          console.log(`  ${index + 1}. ${booklet.title} (${booklet.test_identifier})`);
        });
      } else {
        console.log('❌ 2025 рік НЕ знайдено в API відповіді');
      }
    } else {
      console.log('❌ API не працює:', response.status);
    }

  } catch (error) {
    console.error('❌ Помилка:', error);
  }
}

checkFreudTest();
