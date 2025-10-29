const fs = require('fs');
const path = require('path');

// Читаємо CSV файл
const csvPath = '/Users/bohdanpavliuk/Downloads/Untitled spreadsheet - Sheet1 (1).csv';
const csvContent = fs.readFileSync(csvPath, 'utf8');

// Розбиваємо на рядки
const lines = csvContent.split('\n');

// Масив для зберігання всіх питань
const allQuestions = [];
let currentSystem = '';
let questionNumber = 1;

// Обробляємо кожен рядок
for (let i = 0; i < lines.length; i++) {
  const line = lines[i].trim();
  
  // Пропускаємо порожні рядки
  if (!line) continue;
  
  // Перевіряємо чи це заголовок системи
  if (line.includes('система') && !line.includes('№')) {
    currentSystem = line.replace(',', '').trim();
    console.log(`Знайдено систему: ${currentSystem}`);
    continue;
  }
  
  // Пропускаємо заголовки таблиць
  if (line.includes('№,Система') || line.includes('№,Питання')) {
    continue;
  }
  
  // Розбиваємо рядок на колонки
  const columns = line.split(',');
  
  // Перевіряємо чи це питання (має номер)
  if (columns.length >= 10 && columns[0] && !isNaN(parseInt(columns[0]))) {
    const questionData = {
      number: parseInt(columns[0]),
      system: columns[1] || currentSystem,
      level: columns[2],
      question: columns[3],
      optionA: columns[4],
      optionB: columns[5],
      optionC: columns[6],
      optionD: columns[7],
      correct: columns[8],
      topic: columns[9],
      recommendation: columns[10]
    };
    
    // Додаємо питання до масиву
    allQuestions.push(questionData);
    console.log(`Додано питання ${questionData.number}: ${questionData.question.substring(0, 50)}...`);
  }
}

console.log(`\nВсього знайдено питань: ${allQuestions.length}`);

// Генеруємо SQL INSERT statements
let sqlContent = `-- Вставка всіх питань з новим CSV файлу
-- Всього питань: ${allQuestions.length}

INSERT INTO physiology_questions (
  question_number, system, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES
`;

// Додаємо кожне питання
allQuestions.forEach((q, index) => {
  const isLast = index === allQuestions.length - 1;
  
  sqlContent += `(
  ${q.number},
  '${q.system.replace(/'/g, "''")}',
  '${q.question.replace(/'/g, "''")}',
  '${q.optionA.replace(/'/g, "''")}',
  '${q.optionB.replace(/'/g, "''")}',
  '${q.optionC.replace(/'/g, "''")}',
  '${q.optionD.replace(/'/g, "''")}',
  '${q.correct}',
  '${q.topic.replace(/'/g, "''")}',
  '${q.recommendation.replace(/'/g, "''")}',
  'medical'
)${isLast ? ';' : ','}
`;
});

// Зберігаємо SQL файл
const outputPath = '/Users/bohdanpavliuk/Desktop/help-krok-platform/all_questions_insert.sql';
fs.writeFileSync(outputPath, sqlContent);

console.log(`\n✅ SQL файл створено: ${outputPath}`);
console.log(`📊 Статистика:`);
console.log(`   - Всього питань: ${allQuestions.length}`);

// Групуємо по системах
const systems = {};
allQuestions.forEach(q => {
  if (!systems[q.system]) {
    systems[q.system] = 0;
  }
  systems[q.system]++;
});

console.log(`\n📋 Розподіл по системах:`);
Object.entries(systems).forEach(([system, count]) => {
  console.log(`   - ${system}: ${count} питань`);
});

console.log(`\n🎯 Перші 3 питання:`);
allQuestions.slice(0, 3).forEach((q, index) => {
  console.log(`${index + 1}. ${q.system}`);
  console.log(`   Питання: ${q.question}`);
  console.log(`   Відповіді: A) ${q.optionA}, B) ${q.optionB}, C) ${q.optionC}, D) ${q.optionD}`);
  console.log(`   Правильна: ${q.correct}`);
  console.log(`   Тема: ${q.topic}`);
  console.log(`   Рекомендація: ${q.recommendation}`);
  console.log('');
});
