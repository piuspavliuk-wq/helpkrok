require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkTotalRecords() {
  console.log('🔍 Перевіряємо загальну кількість записів...\n');

  try {
    // Загальна кількість записів
    const { count: totalCount, error: totalError } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true });

    if (totalError) {
      console.error('❌ Помилка підрахунку:', totalError);
      return;
    }

    console.log(`📊 Загальна кількість записів: ${totalCount}`);

    // Записи за 2025 рік
    const { count: count2025, error: error2025 } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true })
      .eq('year', 2025);

    if (error2025) {
      console.error('❌ Помилка підрахунку 2025:', error2025);
      return;
    }

    console.log(`📅 Записів за 2025 рік: ${count2025}`);

    // Записи з is_active = true
    const { count: activeCount, error: activeError } = await supabase
      .from('krok_questions_unified')
      .select('*', { count: 'exact', head: true })
      .eq('is_active', true);

    if (activeError) {
      console.error('❌ Помилка підрахунку активних:', activeError);
      return;
    }

    console.log(`✅ Активних записів: ${activeCount}`);

    // Перевіряємо чи є 2025 рік в активних
    const { data: active2025, error: active2025Error } = await supabase
      .from('krok_questions_unified')
      .select('year, test_identifier, title')
      .eq('year', 2025)
      .eq('is_active', true)
      .limit(5);

    if (active2025Error) {
      console.error('❌ Помилка активних 2025:', active2025Error);
      return;
    }

    console.log(`📋 Активних записів за 2025: ${active2025.length}`);
    if (active2025.length > 0) {
      console.log('✅ 2025 рік є в активних записах!');
      active2025.forEach((record, index) => {
        console.log(`  ${index + 1}. ${record.title} (${record.test_identifier})`);
      });
    } else {
      console.log('❌ 2025 рік НЕ знайдено в активних записах!');
    }

    // Перевіряємо перші 10 записів за 2025 рік
    const { data: first2025, error: first2025Error } = await supabase
      .from('krok_questions_unified')
      .select('year, test_identifier, title, is_active')
      .eq('year', 2025)
      .limit(10);

    if (first2025Error) {
      console.error('❌ Помилка перших 2025:', first2025Error);
      return;
    }

    console.log(`\n📋 Перші 10 записів за 2025 рік:`);
    first2025.forEach((record, index) => {
      console.log(`  ${index + 1}. ${record.title} (${record.test_identifier}) - active: ${record.is_active}`);
    });

  } catch (error) {
    console.error('❌ Помилка:', error);
  }
}

checkTotalRecords();
