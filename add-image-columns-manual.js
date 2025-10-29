require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function addImageColumns() {
  try {
    console.log('🔧 Додаємо колонки для зображень вручну...');
    
    // Перевіряємо, чи існують колонки
    const { data: columns, error: columnsError } = await supabase
      .from('information_schema.columns')
      .select('column_name')
      .eq('table_name', 'pharmaceutical_questions')
      .eq('table_schema', 'public');
    
    if (columnsError) {
      console.error('❌ Помилка при перевірці колонок:', columnsError);
      return;
    }
    
    const existingColumns = columns.map(col => col.column_name);
    console.log('📋 Існуючі колонки:', existingColumns);
    
    // Додаємо колонки по одній
    const newColumns = [
      'option_a_image',
      'option_b_image', 
      'option_c_image',
      'option_d_image',
      'option_e_image',
      'question_image'
    ];
    
    for (const column of newColumns) {
      if (!existingColumns.includes(column)) {
        console.log(`➕ Додаємо колонку: ${column}`);
        
        // Використовуємо SQL через rpc
        const { error } = await supabase.rpc('exec', {
          sql: `ALTER TABLE pharmaceutical_questions ADD COLUMN ${column} TEXT`
        });
        
        if (error) {
          console.log(`⚠️ Не вдалося додати колонку ${column}:`, error.message);
        } else {
          console.log(`✅ Колонка ${column} додана успішно`);
        }
      } else {
        console.log(`ℹ️ Колонка ${column} вже існує`);
      }
    }
    
    console.log('🎉 Процес додавання колонок завершено');
    
  } catch (error) {
    console.error('🚨 Неочікувана помилка:', error);
  }
}

addImageColumns();
