require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function importPhysicalChemistryQuestions() {
  try {
    console.log('🚀 Початок імпорту питань з фізичної та колоїдної хімії...');

    // Знаходимо останній JSON файл
    const dataDir = path.join(__dirname, 'data');
    const files = await fs.promises.readdir(dataDir);
    const jsonFiles = files.filter(file => file.startsWith('krok-lead-individual-clicks') && file.endsWith('.json'));
    
    if (jsonFiles.length === 0) {
      console.error('❌ Не знайдено жодного JSON файлу для імпорту.');
      return;
    }

    // Сортуємо за часом створення (останній файл)
    jsonFiles.sort((a, b) => {
      const aTime = parseInt(a.match(/(\d+)\.json$/)[1]);
      const bTime = parseInt(b.match(/(\d+)\.json$/)[1]);
      return bTime - aTime;
    });

    const latestFile = jsonFiles[0];
    const filePath = path.join(dataDir, latestFile);
    console.log(`📁 Використовуємо файл: ${latestFile}`);

    const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    const questions = jsonData.questions;

    console.log(`📊 Знайдено ${questions.length} питань для імпорту`);

    if (questions.length === 0) {
      console.log('ℹ️ Немає питань для імпорту. Завершення.');
      return;
    }

    // Підготовка даних для вставки
    const questionsToInsert = questions.map(q => ({
      question_text: q.question_text,
      year: 2025,
      faculty: 'pharmaceutical',
      subject: 'фізична_та_колоїдна_хімія',
      category: null,
      option_a: q.options.A || null,
      option_b: q.options.B || null,
      option_c: q.options.C || null,
      option_d: q.options.D || null,
      option_e: q.options.E || null,
      correct_answer: q.correct_answer && q.correct_answer.trim() !== '' ? q.correct_answer : null,
      explanation_text: null,
      reference_text: null,
    }));

    console.log('📝 Підготовлено дані для вставки');

    // Вставляємо дані в базу
    const { data, error } = await supabase
      .from('pharmaceutical_questions')
      .insert(questionsToInsert);

    if (error) {
      console.error('❌ Помилка при імпорті питань:', error);
      return;
    }

    console.log(`✅ Успішно імпортовано ${questionsToInsert.length} питань з фізичної та колоїдної хімії`);

    // Перевіряємо загальну кількість питань в базі
    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact' })
      .eq('subject', 'фізична_та_колоїдна_хімія');

    if (countError) {
      console.error('❌ Помилка при отриманні загальної кількості питань:', countError);
      return;
    }

    console.log(`📊 Загальна кількість питань з фізичної та колоїдної хімії в базі: ${count}`);

    // Статистика імпорту
    const correctAnswersCount = questionsToInsert.filter(q => q.correct_answer).length;
    const noCorrectAnswersCount = questionsToInsert.length - correctAnswersCount;

    console.log(`\n📊 Статистика імпорту:`);
    console.log(`- Всього питань: ${questionsToInsert.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${noCorrectAnswersCount}`);

    console.log('🎉 Імпорт завершено успішно!');

  } catch (error) {
    console.error('🚨 Неочікувана помилка:', error);
  }
}

importPhysicalChemistryQuestions();
