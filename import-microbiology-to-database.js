require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function importMicrobiologyQuestions() {
  try {
    console.log('🔍 Reading SQL file...');
    
    // Читаємо SQL файл
    const fs = require('fs');
    const sqlContent = fs.readFileSync('pharmaceutical-microbiology-269-questions-1759587657935.sql', 'utf8');
    
    // Парсимо SQL для отримання даних
    const insertMatch = sqlContent.match(/INSERT INTO pharmaceutical_questions \(([\s\S]*?)\) VALUES([\s\S]*?);/);
    if (!insertMatch) {
      console.error('❌ Could not parse SQL file');
      return;
    }
    
    // Витягуємо VALUES частину
    const valuesSection = insertMatch[2];
    const valuesMatches = valuesSection.match(/\(([\s\S]*?)\)/g);
    
    if (!valuesMatches) {
      console.error('❌ Could not extract values from SQL');
      return;
    }
    
    console.log(`📊 Found ${valuesMatches.length} questions to import`);
    
    // Конвертуємо SQL VALUES в об'єкти
    const questions = valuesMatches.map((valueMatch, index) => {
      const values = valueMatch.match(/\(([\s\S]*?)\)/)[1];
      const parts = values.split(',').map(part => part.trim());
      
      // Парсимо кожне значення
      const question_text = parts[0].replace(/^'|'$/g, '').replace(/''/g, "'");
      const year = parseInt(parts[1]);
      const faculty = parts[2].replace(/^'|'$/g, '');
      const subject = parts[3].replace(/^'|'$/g, '');
      const category = parts[4].replace(/^'|'$/g, '');
      const is_active = parts[5] === 'true';
      const option_a = parts[6].replace(/^'|'$/g, '').replace(/''/g, "'");
      const option_b = parts[7].replace(/^'|'$/g, '').replace(/''/g, "'");
      const option_c = parts[8].replace(/^'|'$/g, '').replace(/''/g, "'");
      const option_d = parts[9].replace(/^'|'$/g, '').replace(/''/g, "'");
      const option_e = parts[10].replace(/^'|'$/g, '').replace(/''/g, "'");
      const correct_answer = parts[11].replace(/^'|'$/g, '');
      const explanation_text = parts[12].replace(/^'|'$/g, '').replace(/''/g, "'");
      const reference_text = parts[13].replace(/^'|'$/g, '').replace(/''/g, "'");
      const created_at = parts[14].replace(/^'|'$/g, '');
      const updated_at = parts[15].replace(/^'|'$/g, '');
      
      return {
        question_text,
        year,
        faculty,
        subject,
        category,
        is_active,
        option_a,
        option_b,
        option_c,
        option_d,
        option_e,
        correct_answer,
        explanation_text,
        reference_text,
        created_at,
        updated_at
      };
    });
    
    console.log(`📝 Sample question: ${questions[0].question_text.substring(0, 100)}...`);
    console.log(`📊 Subject: ${questions[0].subject}, Category: ${questions[0].category}`);
    
    // Імпортуємо по 50 питань за раз
    const batchSize = 50;
    let imported = 0;
    
    for (let i = 0; i < questions.length; i += batchSize) {
      const batch = questions.slice(i, i + batchSize);
      
      console.log(`📦 Importing batch ${Math.floor(i/batchSize) + 1}/${Math.ceil(questions.length/batchSize)} (${batch.length} questions)...`);
      
      const { data, error } = await supabase
        .from('pharmaceutical_questions')
        .insert(batch);
      
      if (error) {
        console.error(`❌ Error importing batch ${Math.floor(i/batchSize) + 1}:`, error);
        continue;
      }
      
      imported += batch.length;
      console.log(`✅ Imported ${batch.length} questions (Total: ${imported}/${questions.length})`);
      
      // Невелика пауза між батчами
      await new Promise(resolve => setTimeout(resolve, 100));
    }
    
    console.log(`🎉 Successfully imported ${imported} microbiology questions!`);
    
    // Перевіряємо загальну кількість питань
    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true });
    
    if (!countError) {
      console.log(`📊 Total questions in pharmaceutical_questions: ${count}`);
    }
    
  } catch (error) {
    console.error('❌ Error importing questions:', error);
  }
}

importMicrobiologyQuestions();
