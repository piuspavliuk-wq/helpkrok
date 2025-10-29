require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

async function check2024All() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('🔍 Перевіряємо всі записи 2024 року...');
    
    // Перевіряємо всі записи 2024 року без фільтрів
    const { data: all2024, error: allError } = await supabase
      .from('krok_questions_unified')
      .select('year, faculty, test_identifier, title, is_active')
      .eq('year', 2024);

    if (allError) {
      console.error('❌ Помилка:', allError);
      return;
    }

    console.log(`📊 Знайдено ${all2024.length} записів 2024 року:`);
    
    // Групуємо по факультетах та активності
    const groups = {};
    all2024.forEach((row) => {
      const key = `${row.faculty}_${row.is_active}`;
      if (!groups[key]) {
        groups[key] = [];
      }
      groups[key].push(row);
    });

    Object.entries(groups).forEach(([key, rows]) => {
      const [faculty, isActive] = key.split('_');
      console.log(`\n📋 ${faculty} факультет, активний: ${isActive} (${rows.length} записів)`);
      if (rows.length > 0) {
        const sample = rows[0];
        console.log(`   Приклад: title="${sample.title}", test_identifier="${sample.test_identifier}"`);
      }
    });

    // Перевіряємо медичний факультет
    const medical2024 = all2024.filter(row => row.faculty === 'medical');
    console.log(`\n🏥 Медичний факультет 2024: ${medical2024.length} записів`);
    
    const activeMedical2024 = medical2024.filter(row => row.is_active === true);
    console.log(`✅ Активних медичних записів 2024: ${activeMedical2024.length}`);

    if (activeMedical2024.length > 0) {
      console.log('\n📊 Активні медичні записи 2024:');
      activeMedical2024.slice(0, 3).forEach((row, index) => {
        console.log(`${index + 1}. title: "${row.title}", test_identifier: "${row.test_identifier}"`);
      });
    }

  } catch (err) {
    console.error('❌ Помилка:', err);
  }
}

check2024All();
