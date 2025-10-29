require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function importOrganicChemistryWithImages() {
  try {
    console.log('🚀 Початок імпорту питань з органічної хімії (з підтримкою зображень)...');

    // Спочатку видаляємо старі питання
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

    // Знаходимо найновіший JSON файл
    const dataDir = path.join(__dirname, 'data');
    const files = await fs.promises.readdir(dataDir);
    const jsonFiles = files.filter(file => file.startsWith('krok-lead-organic-chemistry-with-images-') && file.endsWith('.json'));
    
    if (jsonFiles.length === 0) {
      console.error('❌ Не знайдено жодного JSON файлу для імпорту.');
      return;
    }
    
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

    // Підготовка даних для вставки
    const questionsToInsert = questions.map(q => ({
      question_text: q.question_text,
      year: 2025,
      faculty: 'pharmaceutical',
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
      // Додаємо зображення якщо вони є
      question_image: q.question_image || null,
      option_a_image: q.option_images && q.option_images.A ? q.option_images.A : null,
      option_b_image: q.option_images && q.option_images.B ? q.option_images.B : null,
      option_c_image: q.option_images && q.option_images.C ? q.option_images.C : null,
      option_d_image: q.option_images && q.option_images.D ? q.option_images.D : null,
      option_e_image: q.option_images && q.option_images.E ? q.option_images.E : null,
    }));

    console.log('📝 Підготовлено дані для вставки');

    // Вставка питань
    const { data, error } = await supabase
      .from('pharmaceutical_questions')
      .insert(questionsToInsert);

    if (error) {
      console.error('❌ Помилка при імпорті питань:', error);
      return;
    }

    console.log(`✅ Успішно імпортовано ${questionsToInsert.length} питань з органічної хімії`);

    // Перевірка загальної кількості
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
    const withImagesCount = questionsToInsert.filter(q => 
      q.question_image || 
      q.option_a_image || 
      q.option_b_image || 
      q.option_c_image || 
      q.option_d_image || 
      q.option_e_image
    ).length;

    console.log(`\n📊 Статистика імпорту:`);
    console.log(`- Всього питань: ${questionsToInsert.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${noCorrectAnswersCount}`);
    console.log(`- З зображеннями: ${withImagesCount}`);

    console.log('🎉 Імпорт завершено успішно!');

  } catch (error) {
    console.error('🚨 Неочікувана помилка:', error);
  }
}

importOrganicChemistryWithImages();
