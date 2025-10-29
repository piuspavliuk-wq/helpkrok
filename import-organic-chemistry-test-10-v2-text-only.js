require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function importOrganicChemistryTest10V2TextOnly() {
  try {
    console.log('🚀 Початок тестового імпорту питань з органічної хімії v2 (тільки текст)...');

    // Видаляємо старі питання з органічної хімії
    console.log('🗑️ Видалення старих питань з органічної хімії...');
    const { error: deleteError } = await supabase
      .from('pharmaceutical_questions')
      .delete()
      .eq('subject', 'органічна_хімія');

    if (deleteError) {
      console.error('❌ Помилка при видаленні старих питань:', deleteError);
      return;
    }
    console.log('✅ Старі питання видалено');

    // Знаходимо найновіший тестовий JSON файл v2
    const dataDir = path.join(__dirname, 'data');
    const files = await fs.promises.readdir(dataDir);
    const jsonFiles = files.filter(file => 
      file.startsWith('krok-lead-organic-chemistry-test-10-v2-') && 
      file.endsWith('.json')
    );
    
    if (jsonFiles.length === 0) {
      console.error('❌ Не знайдено жодного тестового JSON файлу v2 для імпорту.');
      return;
    }
    
    // Сортуємо за часом створення (найновіший перший)
    jsonFiles.sort((a, b) => {
      const aTime = parseInt(a.match(/(\d+)\.json$/)[1]);
      const bTime = parseInt(b.match(/(\d+)\.json$/)[1]);
      return bTime - aTime;
    });
    
    const latestJsonFile = jsonFiles[0];
    console.log(`📁 Використовуємо файл: ${latestJsonFile}`);
    
    const filePath = path.join(dataDir, latestJsonFile);
    const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    
    const questions = jsonData.questions;
    console.log(`📊 Знайдено ${questions.length} питань для імпорту`);
    
    if (questions.length === 0) {
      console.log('ℹ️ Немає питань з органічної хімії для імпорту. Завершення.');
      return;
    }

    // Підготовка даних для вставки (тільки текст, без зображень)
    const questionsToInsert = questions.map(q => {
      return {
        question_text: q.question_text,
        year: jsonData.page_info.year,
        faculty: jsonData.page_info.faculty,
        subject: 'органічна_хімія',
        category: null,
        option_a: q.options.A || null,
        option_b: q.options.B || null,
        option_c: q.options.C || null,
        option_d: q.options.D || null,
        option_e: q.options.E || null,
        correct_answer: q.correct_answer && q.correct_answer.trim() !== '' ? q.correct_answer : null,
        explanation_text: null,
        reference_text: null,
      };
    });

    console.log('📝 Підготовлено дані для вставки (тільки текст)');

    // Вставляємо дані
    const { data, error } = await supabase
      .from('pharmaceutical_questions')
      .insert(questionsToInsert);

    if (error) {
      console.error('❌ Помилка при імпорті питань:', error);
      return;
    }

    console.log(`✅ Успішно імпортовано ${questionsToInsert.length} питань з органічної хімії`);

    // Перевіряємо загальну кількість
    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact' })
      .eq('subject', 'органічна_хімія');

    if (countError) {
      console.error('❌ Помилка при отриманні загальної кількості питань:', countError);
      return;
    }

    console.log(`📊 Загальна кількість питань з органічної хімії в базі: ${count}`);

    // Статистика
    const correctAnswersCount = questionsToInsert.filter(q => q.correct_answer).length;
    const noCorrectAnswersCount = questionsToInsert.length - correctAnswersCount;
    const withImagesCount = questions.filter(q => q.has_images).length;
    const textOnlyCount = questions.length - withImagesCount;

    console.log(`\n📊 Статистика тестового імпорту:`);
    console.log(`- Всього питань: ${questionsToInsert.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${noCorrectAnswersCount}`);
    console.log(`- З зображеннями (в оригіналі): ${withImagesCount}`);
    console.log(`- Тільки текст (в оригіналі): ${textOnlyCount}`);

    console.log('🎉 Тестовий імпорт v2 (тільки текст) завершено успішно!');

  } catch (error) {
    console.error('🚨 Неочікувана помилка:', error);
  }
}

importOrganicChemistryTest10V2TextOnly();
