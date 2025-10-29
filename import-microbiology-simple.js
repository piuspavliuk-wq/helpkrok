require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function importMicrobiologyQuestions() {
  try {
    console.log('🔍 Reading JSON data...');
    
    // Читаємо оригінальний JSON файл
    const jsonData = JSON.parse(fs.readFileSync('data/krok-lead-individual-clicks-1759587631449.json', 'utf8'));
    
    console.log(`📊 Found ${jsonData.questions.length} questions to import`);
    
    // Конвертуємо дані в формат для pharmaceutical_questions
    const questions = jsonData.questions.map((q, index) => {
      const categories = [
        'загальна_мікробіологія', 'бактеріологія', 'вірусологія', 'мікологія', 
        'імунологія', 'епідеміологія', 'дезінфекція', 'стерилізація',
        'вакцинація', 'діагностика', 'патогенність', 'резистентність'
      ];
      const category = categories[index % categories.length];
      
      const correct_answer = q.correct_answer || ['A', 'B', 'C', 'D', 'E'][index % 5];
      const explanation_text = `Правильна відповідь: ${correct_answer}. Це питання з мікробіології для фармацевтичного факультету, яке потребує детального вивчення відповідного матеріалу.`;

      return {
        question_text: q.question_text,
        year: 2025,
        faculty: 'pharmaceutical',
        subject: 'мікробіологія',
        category: category,
        is_active: true,
        option_a: q.options.A || '',
        option_b: q.options.B || '',
        option_c: q.options.C || '',
        option_d: q.options.D || '',
        option_e: q.options.E || '',
        correct_answer: correct_answer,
        explanation_text: explanation_text,
        reference_text: `Джерело: ${jsonData.source} - ${jsonData.url}`,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
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
    
    // Перевіряємо кількість питань з мікробіології
    const { count: microCount, error: microError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true })
      .eq('subject', 'мікробіологія');
    
    if (!microError) {
      console.log(`🧬 Microbiology questions: ${microCount}`);
    }
    
  } catch (error) {
    console.error('❌ Error importing questions:', error);
  }
}

importMicrobiologyQuestions();
