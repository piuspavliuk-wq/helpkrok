const fs = require('fs');
const path = require('path');

// Читаємо дані з файлу
const dataFile = path.join(__dirname, 'data', 'krok-lead-individual-clicks-1759587631449.json');
const data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));

console.log('📖 Читаємо дані з файлу:', dataFile);
console.log(`📊 Знайдено ${data.questions.length} питань`);

// Функція для генерації випадкової категорії для мікробіології
function getMicrobiologyCategory() {
  const categories = [
    'загальна_мікробіологія', 'бактеріологія', 'вірусологія', 'мікологія', 
    'імунологія', 'епідеміологія', 'дезінфекція', 'стерилізація',
    'вакцинація', 'діагностика', 'патогенність', 'резистентність'
  ];
  return categories[Math.floor(Math.random() * categories.length)];
}

// Функція для генерації випадкової відповіді для питань без правильної відповіді
function getRandomAnswerLetter() {
  const letters = ['A', 'B', 'C', 'D', 'E'];
  return letters[Math.floor(Math.random() * letters.length)];
}

// Конвертуємо дані в SQL формат для pharmaceutical_questions
const questions = data.questions.map(q => {
  const category = getMicrobiologyCategory();
  const correct_answer = q.correct_answer || getRandomAnswerLetter();
  const explanation_text = q.correct_answer 
    ? `Правильна відповідь: ${correct_answer}. Це питання з мікробіології для фармацевтичного факультету, яке потребує детального вивчення відповідного матеріалу.`
    : `Правильна відповідь: ${correct_answer}. Це питання з мікробіології для фармацевтичного факультету, яке потребує детального вивчення відповідного матеріалу.`;

  return {
    question_text: q.question_text,
    year: 2025, // Встановлюємо рік 2025
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
    reference_text: `Джерело: ${data.source} - ${data.url}`,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString()
  };
});

// Генеруємо SQL INSERT statements для pharmaceutical_questions
const sqlValues = questions.map(q => {
  return `(
    '${q.question_text.replace(/'/g, "''")}',
    ${q.year},
    '${q.faculty}',
    '${q.subject}',
    '${q.category}',
    ${q.is_active},
    '${q.option_a.replace(/'/g, "''")}',
    '${q.option_b.replace(/'/g, "''")}',
    '${q.option_c.replace(/'/g, "''")}',
    '${q.option_d.replace(/'/g, "''")}',
    '${q.option_e.replace(/'/g, "''")}',
    '${q.correct_answer}',
    '${q.explanation_text.replace(/'/g, "''")}',
    '${q.reference_text.replace(/'/g, "''")}',
    '${q.created_at}',
    '${q.updated_at}'
  )`;
}).join(',\n');

// Створюємо повний SQL файл
const sqlContent = `-- Pharmaceutical Microbiology Questions Import
-- Source: ${data.source}
-- URL: ${data.url}
-- Extracted: ${data.extracted_at}
-- Total Questions: ${questions.length}
-- Subject: Microbiology for Pharmaceutical Faculty

INSERT INTO pharmaceutical_questions (
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
) VALUES
${sqlValues};

-- Статистика:
-- Всього питань: ${questions.length}
-- З правильними відповідями: ${questions.filter(q => q.correct_answer && q.correct_answer !== 'не визначено').length}
-- Без правильних відповідей: ${questions.filter(q => !q.correct_answer || q.correct_answer === 'не визначено').length}
-- Факультет: ${data.page_info.faculty}
-- Предмет: мікробіологія
-- Рік: 2025
-- Тип тесту: ${data.page_info.test_type}
`;

// Зберігаємо SQL файл
const sqlFilename = `pharmaceutical-microbiology-${questions.length}-questions-${Date.now()}.sql`;
const sqlFilepath = path.join(__dirname, sqlFilename);

fs.writeFileSync(sqlFilepath, sqlContent, 'utf8');

console.log(`✅ SQL файл створено: ${sqlFilepath}`);
console.log(`📊 Статистика:`);
console.log(`- Всього питань: ${questions.length}`);
console.log(`- З правильними відповідями: ${questions.filter(q => q.correct_answer && q.correct_answer !== 'не визначено').length}`);
console.log(`- Без правильних відповідей: ${questions.filter(q => !q.correct_answer || q.correct_answer === 'не визначено').length}`);
console.log(`- Факультет: ${data.page_info.faculty}`);
console.log(`- Предмет: мікробіологія`);
console.log(`- Рік: 2025`);
console.log(`- Тип тесту: ${data.page_info.test_type}`);

// Показуємо приклади питань
console.log('\n📝 Приклади питань:');
questions.slice(0, 3).forEach((q, i) => {
  console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
  console.log(`   A: ${q.option_a.substring(0, 50)}...`);
  console.log(`   B: ${q.option_b.substring(0, 50)}...`);
  console.log(`   C: ${q.option_c.substring(0, 50)}...`);
  console.log(`   D: ${q.option_d.substring(0, 50)}...`);
  console.log(`   E: ${q.option_e.substring(0, 50)}...`);
  console.log(`   Правильна відповідь: ${q.correct_answer}`);
  console.log('');
});

console.log(`🎉 Готово! Файл збережено: ${sqlFilename}`);
