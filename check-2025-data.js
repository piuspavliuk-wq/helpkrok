require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function check2025Data() {
  console.log('🔍 Перевіряємо дані за 2025 рік...\n');

  try {
    // Всі записи за 2025 рік
    const { data: all2025, error: all2025Error } = await supabase
      .from('krok_questions_unified')
      .select('year, test_identifier, title, question_text')
      .eq('year', 2025)
      .eq('is_active', true);

    if (all2025Error) {
      console.error('❌ Помилка:', all2025Error);
      return;
    }

    console.log(`📊 Всього записів за 2025 рік: ${all2025.length}`);

    // Групуємо по test_identifier
    const groups = {};
    all2025.forEach(record => {
      const key = record.test_identifier || 'null';
      if (!groups[key]) {
        groups[key] = {
          test_identifier: record.test_identifier,
          title: record.title,
          count: 0,
          sample_questions: []
        };
      }
      groups[key].count++;
      
      if (groups[key].sample_questions.length < 3) {
        groups[key].sample_questions.push(record.question_text);
      }
    });

    console.log('\n📋 Групи за test_identifier:');
    Object.entries(groups).forEach(([key, group]) => {
      console.log(`  ${key}: ${group.title} (${group.count} питань)`);
      if (group.sample_questions.length > 0) {
        console.log(`    Приклад: "${group.sample_questions[0].substring(0, 50)}..."`);
      }
    });

    // Перевіряємо записи без test_identifier (основний тест)
    const { data: main2025, error: main2025Error } = await supabase
      .from('krok_questions_unified')
      .select('year, test_identifier, title, question_text')
      .eq('year', 2025)
      .eq('is_active', true)
      .is('test_identifier', null);

    if (main2025Error) {
      console.error('❌ Помилка основного тесту:', main2025Error);
      return;
    }

    console.log(`\n📊 Основний тест (test_identifier = null): ${main2025.length} питань`);

    // Перевіряємо записи з test_identifier
    const { data: withIdentifier, error: withIdentifierError } = await supabase
      .from('krok_questions_unified')
      .select('year, test_identifier, title, question_text')
      .eq('year', 2025)
      .eq('is_active', true)
      .not('test_identifier', 'is', null);

    if (withIdentifierError) {
      console.error('❌ Помилка тестів з identifier:', withIdentifierError);
      return;
    }

    console.log(`📊 Тести з test_identifier: ${withIdentifier.length} питань`);

    // Перевіряємо чи є дублікати
    const questionTexts = all2025.map(q => q.question_text);
    const uniqueTexts = [...new Set(questionTexts)];
    
    if (questionTexts.length !== uniqueTexts.length) {
      console.log(`\n⚠️  Знайдено дублікати: ${questionTexts.length} загальних, ${uniqueTexts.length} унікальних`);
    } else {
      console.log(`\n✅ Дублікатів не знайдено: ${questionTexts.length} унікальних питань`);
    }

  } catch (error) {
    console.error('❌ Помилка:', error);
  }
}

check2025Data();
