const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Supabase configuration missing');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkPharmaceuticalData() {
  try {
    console.log('🔍 Checking pharmaceutical_questions table...');
    
    // Перевіряємо загальну кількість питань
    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true });
    
    if (countError) {
      console.error('❌ Error checking count:', countError);
      return;
    }
    
    console.log(`📊 Total questions in pharmaceutical_questions: ${count || 0}`);
    
    // Перевіряємо конкретно аналітичну хімію
    const { count: analyticalCount, error: analyticalError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true })
      .eq('subject', 'analytical_chemistry');
    
    if (analyticalError) {
      console.error('❌ Error checking analytical chemistry:', analyticalError);
      return;
    }
    
    console.log(`🧪 Analytical chemistry questions: ${analyticalCount || 0}`);
    
    // Перевіряємо структуру таблиці - отримуємо один запис
    const { data: sampleData, error: sampleError } = await supabase
      .from('pharmaceutical_questions')
      .select('*')
      .limit(1);
    
    if (sampleError) {
      console.error('❌ Error getting sample data:', sampleError);
      return;
    }
    
    if (sampleData && sampleData.length > 0) {
      console.log('✅ Table has data. Sample record:');
      console.log(JSON.stringify(sampleData[0], null, 2));
    } else {
      console.log('⚠️  Table exists but is empty - need to import data');
      
      // Показуємо схему таблиці
      const { data: columns } = await supabase.rpc('get_table_columns', {
        table_name: 'pharmaceutical_questions'
      });
      
      console.log('📋 Table schema:');
      console.log(columns);
    }
    
    // Перевіряємо user_saved_questions таблицю для фармації
    const { count: savedCount, error: savedError } = await supabase
      .from('user_saved_questions')
      .select('*', { count: 'exact', head: true })
      .eq('question_type', 'pharmaceutical');
    
    if (savedError) {
      console.error('❌ Error checking saved pharmaceutical questions:', savedError);
    } else {
      console.log(`💾 Saved pharmaceutical questions: ${savedCount || 0}`);
    }
    
  } catch (error) {
    console.error('❌ Unexpected error:', error);
  }
}

checkPharmaceuticalData();
