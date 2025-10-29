require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

async function check2024Data() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('🔍 Перевіряємо дані 2024 року...');
    
    // Перевіряємо всі записи 2024 року
    const { data, error } = await supabase
      .from('krok_questions_unified')
      .select('year, faculty, test_identifier, title')
      .eq('year', 2024)
      .eq('faculty', 'medical');

    if (error) {
      console.error('❌ Помилка:', error);
      return;
    }

    console.log(`📊 Знайдено ${data.length} записів для 2024 року:`);
    data.forEach((row, index) => {
      console.log(`${index + 1}. title: "${row.title}" - test_identifier: "${row.test_identifier}"`);
    });

    // Перевіряємо чи є записи з title
    const withTitle = data.filter(row => row.title && row.title !== 'null');
    const withoutTitle = data.filter(row => !row.title || row.title === 'null');
    
    console.log(`\n📈 Статистика 2024:`);
    console.log(`- З title: ${withTitle.length}`);
    console.log(`- Без title: ${withoutTitle.length}`);

    if (withoutTitle.length > 0) {
      console.log('\n💡 Виконайте цей SQL:');
      console.log('UPDATE krok_questions_unified SET title = \'2024р (Eng)\' WHERE year = 2024 AND faculty = \'medical\';');
    }

    // Перевіряємо англійську мікробіологію
    console.log('\n🔍 Перевіряємо англійську мікробіологію...');
    const { data: microData, error: microError } = await supabase
      .from('krok_questions_unified')
      .select('year, faculty, test_identifier, title')
      .eq('test_identifier', '2024-microbiology-english');

    if (!microError && microData.length > 0) {
      console.log(`📊 Знайдено ${microData.length} записів англійської мікробіології:`);
      microData.forEach((row, index) => {
        console.log(`${index + 1}. title: "${row.title}" - test_identifier: "${row.test_identifier}"`);
      });
    } else {
      console.log('❌ Не знайдено записів з test_identifier = "2024-microbiology-english"');
    }

  } catch (err) {
    console.error('❌ Помилка:', err);
  }
}

check2024Data();
