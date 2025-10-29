require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkDescriptionInDB() {
  console.log('🔍 Перевіряємо чи є description в базі даних...\n');

  try {
    // Перевіряємо записи тесту Freud
    const { data: freudData, error: freudError } = await supabase
      .from('krok_questions_unified')
      .select('id, title, test_identifier, description')
      .eq('test_identifier', '2025-freud-dreams')
      .limit(3);

    if (freudError) {
      console.error('❌ Помилка:', freudError);
      return;
    }

    console.log(`📊 Знайдено ${freudData.length} записів тесту Freud:`);
    freudData.forEach((record, index) => {
      console.log(`  ${index + 1}. ID: ${record.id}`);
      console.log(`     Title: ${record.title}`);
      console.log(`     Test ID: ${record.test_identifier}`);
      console.log(`     Description: ${record.description ? 'Є' : 'Немає'}`);
      if (record.description) {
        console.log(`     Текст: "${record.description.substring(0, 100)}..."`);
      }
      console.log('');
    });

    // Перевіряємо структуру таблиці
    const { data: sampleData, error: sampleError } = await supabase
      .from('krok_questions_unified')
      .select('*')
      .limit(1);

    if (sampleError) {
      console.error('❌ Помилка структури:', sampleError);
      return;
    }

    if (sampleData && sampleData.length > 0) {
      console.log('📋 Поля в таблиці:');
      Object.keys(sampleData[0]).forEach(field => {
        console.log(`  - ${field}`);
      });
    }

  } catch (error) {
    console.error('❌ Помилка:', error);
  }
}

checkDescriptionInDB();
