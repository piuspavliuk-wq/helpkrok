const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища SUPABASE_URL або SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function importPharmacologyData() {
  try {
    console.log('🚀 Початок імпорту питань з фармакології...');
    
    // Читаємо файл з даними
    const fs = require('fs');
    const path = require('path');
    
    const dataFile = 'data/krok-lead-individual-clicks-1759591519911.json';
    const dataPath = path.join(__dirname, dataFile);
    
    if (!fs.existsSync(dataPath)) {
      console.error(`❌ Файл не знайдено: ${dataPath}`);
      return;
    }
    
    const rawData = fs.readFileSync(dataPath, 'utf8');
    const data = JSON.parse(rawData);
    
    console.log(`📊 Знайдено ${data.questions.length} питань для імпорту`);
    
    // Підготовка даних для вставки
    const questionsToInsert = data.questions.map((q, index) => {
      const options = q.options || {};
      
      return {
        question_text: q.question_text,
        year: 2025,
        faculty: 'pharmaceutical',
        subject: 'фармакологія',
        category: null,
        is_active: true,
        option_a: options.A || null,
        option_b: options.B || null,
        option_c: options.C || null,
        option_d: options.D || null,
        option_e: options.E || null,
        correct_answer: q.correct_answer || null,
        explanation_text: null,
        reference_text: null
      };
    });
    
    console.log('📝 Підготовлено дані для вставки');
    
    // Вставляємо дані в базу
    const { data: insertedData, error } = await supabase
      .from('pharmaceutical_questions')
      .insert(questionsToInsert);
    
    if (error) {
      console.error('❌ Помилка при вставці даних:', error);
      return;
    }
    
    console.log(`✅ Успішно імпортовано ${questionsToInsert.length} питань з фармакології`);
    
    // Перевіряємо кількість питань в базі
    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact', head: true })
      .eq('subject', 'фармакологія');
    
    if (countError) {
      console.error('❌ Помилка при підрахунку:', countError);
    } else {
      console.log(`📊 Загальна кількість питань з фармакології в базі: ${count}`);
    }
    
    // Показуємо статистику
    const correctAnswersCount = questionsToInsert.filter(q => q.correct_answer).length;
    console.log('\n📊 Статистика імпорту:');
    console.log(`- Всього питань: ${questionsToInsert.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${questionsToInsert.length - correctAnswersCount}`);
    
    console.log('\n🎉 Імпорт завершено успішно!');
    
  } catch (error) {
    console.error('❌ Помилка при імпорті:', error);
  }
}

// Запуск імпорту
importPharmacologyData();
