const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Supabase configuration missing');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function importPharmaceuticalQuestions() {
  try {
    console.log('🧪 Importing pharmaceutical questions...');
    
    // Перевіряємо SQL файл
    const sqlFile = 'pharmaceutical-analytical_chemistry-375-questions-1759524020554.sql';
    if (!fs.existsSync(sqlFile)) {
      console.error(`❌ SQL file not found: ${sqlFile}`);
      return;
    }
    
    console.log(`📁 Found SQL file: ${sqlFile}`);
    
    // Читаємо SQL файл
    const sqlContent = fs.readFileSync(sqlFile, 'utf8');
    console.log(`📄 SQL file size: ${sqlContent.length} characters`);
    
    // Ділимо на окремі INSERT запити
    const insertStatements = sqlContent
      .split('\n')
      .filter(line => line.trim().startsWith('INSERT INTO'))
      .filter(line => line.includes('pharmaceutical_questions'));
    
    console.log(`📝 Found ${insertStatements.length} INSERT statements`);
    
    // Видаляємо старі дані (приклад)
    console.log('🗑️ Clearing old example data...');
    const { error: deleteError } = await supabase
      .from('pharmaceutical_questions')
      .delete()
      .eq('subject', 'analytical_chemistry');
    
    if (deleteError) {
      console.error('❌ Error clearing old data:', deleteError);
    } else {
      console.log('✅ Cleared old data');
    }
    
    // Імпортуємо кільком порціями
    const batchSize = 50;
    let imported = 0;
    
    for (let i = 0; i < insertStatements.length; i += batchSize) {
      const batch = insertStatements.slice(i, i + batchSize);
      
      for (const statement of batch) {
        try {
          // Виділяємо дані з INSERT statement
          const match = statement.match(/INSERT INTO pharmaceutical_questions \(([^)]+)\) VALUES ([^;]+);/);
          if (!match) {
            console.warn('⚠️ Skipping invalid statement');
            continue;
          }
          
          const [columns, valuesPart] = [match[1], match[2]];
          
          // Парсимо values
          const values = valuesPart.replace(/'([^']*)'/g, (match, content) => `"${content}"`);
          
          // Конвертуємо в JSON для bulk insert
          const rows = [];
          const valuesArray = values.split('),(').map(v => v.replace(/[()]/g, ''));
          
          for (const valueString of valuesArray) {
            const parts = valueString.split(',');
            if (parts.length >= 11) {
              rows.push({
                question_text: parts[1]?.replace(/"/g, '') || '',
                year: parseInt(parts[2]) || 2025,
                faculty: 'pharmaceutical',
                subject: 'analytical_chemistry',
                category: parts[4]?.replace(/"/g, '') || null,
                is_active: true,
                option_a: parts[5]?.replace(/"/g, '') || null,
                option_b: parts[6]?.replace(/"/g, '') || null,
                option_c: parts[7]?.replace(/"/g, '') || null,
                option_d: parts[8]?.replace(/"/g, '') || null,
                option_e: parts[9]?.replace(/"/g, '') || null,
                correct_answer: parts[10]?.replace(/"/g, '') || null,
                explanation_text: parts[11]?.replace(/"/g, '') || null,
                reference_text: parts[12]?.replace(/"/g, '') || null
              });
            }
          }
          
          if (rows.length > 0) {
            const { error: insertError } = await supabase
              .from('pharmaceutical_questions')
              .insert(rows);
            
            if (insertError) {
              console.error(`❌ Error inserting batch ${Math.floor(i/batchSize) + 1}:`, insertError);
            } else {
              imported += rows.length;
              console.log(`✅ Imported ${rows.length} questions (Total: ${imported})`);
            }
          }
          
        } catch (error) {
          console.error('❌ Error processing statement:', error);
        }
      }
      
      // Невелика пауза між порціями
      await new Promise(resolve => setTimeout(resolve, 100));
    }
    
    console.log(`🎉 Import completed! Total imported: ${imported}`);
    
    // Перевіряємо результат
    const { count } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true })
      .eq('subject', 'analytical_chemistry');
    
    console.log(`📊 Final count in database: ${count}`);
    
  } catch (error) {
    console.error('❌ Import error:', error);
  }
}

importPharmaceuticalQuestions();