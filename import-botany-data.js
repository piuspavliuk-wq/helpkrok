require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function importBotanyQuestions() {
  try {
    console.log('🚀 Початок імпорту питань з ботаніки...');

    const latestJsonFile = await getLatestJsonFile('krok-lead-individual-clicks');
    if (!latestJsonFile) {
      console.error('❌ Не знайдено жодного JSON файлу для імпорту.');
      return;
    }

    const filePath = path.join(__dirname, 'data', latestJsonFile);
    const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));

    const botanyQuestions = jsonData.questions;

    console.log(`📊 Знайдено ${botanyQuestions.length} питань для імпорту`);

    if (botanyQuestions.length === 0) {
      console.log('ℹ️ Немає питань з ботаніки для імпорту. Завершення.');
      return;
    }

    const questionsToInsert = botanyQuestions.map(q => ({
      question_text: q.question_text,
      year: 2025,
      faculty: 'pharmaceutical',
      subject: 'ботаніка',
      category: null,
      option_a: q.options.A,
      option_b: q.options.B,
      option_c: q.options.C,
      option_d: q.options.D,
      option_e: q.options.E,
      correct_answer: q.correct_answer && q.correct_answer.trim() !== '' ? q.correct_answer : null,
      explanation_text: null,
      reference_text: null,
    }));

    console.log('📝 Підготовлено дані для вставки');

    const { data, error } = await supabase
      .from('pharmaceutical_questions')
      .insert(questionsToInsert);

    if (error) {
      console.error('❌ Помилка при імпорті питань:', error);
      return;
    }

    console.log(`✅ Успішно імпортовано ${questionsToInsert.length} питань з ботаніки`);

    const { count, error: countError } = await supabase
      .from('pharmaceutical_questions')
      .select('*', { count: 'exact' })
      .eq('subject', 'ботаніка');

    if (countError) {
      console.error('❌ Помилка при отриманні загальної кількості питань:', countError);
      return;
    }

    console.log(`📊 Загальна кількість питань з ботаніки в базі: ${count}`);

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

async function getLatestJsonFile(prefix) {
  const dataDir = path.join(__dirname, 'data');
  const files = await fs.promises.readdir(dataDir);
  const jsonFiles = files.filter(file => file.startsWith(prefix) && file.endsWith('.json'));
  if (jsonFiles.length === 0) {
    return null;
  }
  jsonFiles.sort((a, b) => {
    const aTime = parseInt(a.match(/(\d+)\.json$/)[1]);
    const bTime = parseInt(b.match(/(\d+)\.json$/)[1]);
    return bTime - aTime;
  });
  return jsonFiles[0];
}

importBotanyQuestions();
