require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkTestDescription() {
  console.log('🔍 Перевіряємо структуру таблиці krok_questions_unified...\n');

  try {
    // Перевіряємо структуру таблиці
    const { data: sampleData, error: sampleError } = await supabase
      .from('krok_questions_unified')
      .select('*')
      .eq('test_identifier', '2025-freud-dreams')
      .limit(1);

    if (sampleError) {
      console.error('❌ Помилка:', sampleError);
      return;
    }

    if (sampleData && sampleData.length > 0) {
      console.log('📋 Поля в таблиці krok_questions_unified:');
      Object.keys(sampleData[0]).forEach(field => {
        console.log(`  - ${field}`);
      });

      console.log('\n📝 Поточні значення для тесту Freud:');
      console.log(`  - title: ${sampleData[0].title}`);
      console.log(`  - explanation_text: ${sampleData[0].explanation_text}`);
      console.log(`  - reference_text: ${sampleData[0].reference_text}`);
    }

    // Перевіряємо чи є поле description
    const { data: allFields, error: allFieldsError } = await supabase
      .from('krok_questions_unified')
      .select('description')
      .limit(1);

    if (allFieldsError) {
      console.log('❌ Поле "description" не існує');
    } else {
      console.log('✅ Поле "description" існує');
    }

  } catch (error) {
    console.error('❌ Помилка:', error);
  }
}

checkTestDescription();
