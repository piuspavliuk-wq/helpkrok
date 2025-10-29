const fs = require('fs');
const path = require('path');

// Читаємо CSV файл
const csvPath = '/Users/bohdanpavliuk/Downloads/Untitled spreadsheet - Sheet1.csv';
const csvContent = fs.readFileSync(csvPath, 'utf8');

// Парсимо CSV
const lines = csvContent.split('\n');
const questions = [];

let currentSystem = '';
let currentSection = '';

for (let i = 0; i < lines.length; i++) {
  const line = lines[i].trim();
  
  // Пропускаємо порожні рядки
  if (!line) continue;
  
  // Перевіряємо, чи це заголовок системи
  if (line.includes('система') && !line.includes('№')) {
    currentSystem = line.replace('система', '').trim();
    continue;
  }
  
  // Перевіряємо, чи це заголовок секції
  if (line.includes('№,Система,Рівень,Питання,A,B,C,D,Правильна,Тема,Рекомендація')) {
    currentSection = 'questions';
    continue;
  }
  
  // Парсимо питання
  if (currentSection === 'questions' && line.includes(',')) {
    // Парсимо CSV з урахуванням лапок
    const parts = [];
    let current = '';
    let inQuotes = false;
    
    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        inQuotes = !inQuotes;
      } else if (char === ',' && !inQuotes) {
        parts.push(current.trim());
        current = '';
      } else {
        current += char;
      }
    }
    parts.push(current.trim());
    
    // Перевіряємо, чи це дійсно питання (має номер)
    if (parts[0] && !isNaN(parts[0])) {
      const questionNumber = parseInt(parts[0]);
      const system = (parts[1] || currentSystem).replace(/"/g, '');
      const level = parts[2]; // Залишаємо рівень для перевірки, але не зберігаємо
      const questionText = parts[3].replace(/"/g, '');
      const optionA = parts[4].replace(/"/g, '');
      const optionB = parts[5].replace(/"/g, '');
      const optionC = parts[6].replace(/"/g, '');
      const optionD = parts[7].replace(/"/g, '');
      const correctAnswer = parts[8].replace(/"/g, '');
      const topic = parts[9].replace(/"/g, '');
      const recommendation = parts[10].replace(/"/g, '');
      
      // Перевіряємо, чи є всі необхідні дані
      if (questionText && optionA && optionB && optionC && optionD && correctAnswer) {
        questions.push({
          question_number: questionNumber,
          system: system,
          question_text: questionText,
          option_a: optionA,
          option_b: optionB,
          option_c: optionC,
          option_d: optionD,
          correct_answer: correctAnswer,
          topic: topic,
          recommendation: recommendation,
          faculty: 'medical'
        });
      }
    }
  }
}

console.log(`Знайдено ${questions.length} питань`);

// Функція для екранування SQL
function escapeSqlString(str) {
  if (!str) return '';
  return str.replace(/'/g, "''").replace(/\\/g, '\\\\');
}

// Створюємо SQL INSERT statements
const insertStatements = questions.map(q => {
  return `INSERT INTO physiology_questions (
  question_number, system, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  ${q.question_number}, 
  '${escapeSqlString(q.system)}', 
  '${escapeSqlString(q.question_text)}', 
  '${escapeSqlString(q.option_a)}', 
  '${escapeSqlString(q.option_b)}', 
  '${escapeSqlString(q.option_c)}', 
  '${escapeSqlString(q.option_d)}', 
  '${escapeSqlString(q.correct_answer)}', 
  '${escapeSqlString(q.topic)}', 
  '${escapeSqlString(q.recommendation)}', 
  '${escapeSqlString(q.faculty)}'
);`;
}).join('\n\n');

// Створюємо повний SQL скрипт
const fullSqlScript = `-- Очищення таблиці перед імпортом
DELETE FROM physiology_questions;

-- Вставка питань
${insertStatements}

-- Перевірка результатів
SELECT COUNT(*) as total_questions FROM physiology_questions;
SELECT system, COUNT(*) as count FROM physiology_questions GROUP BY system ORDER BY system;
`;

// Зберігаємо SQL скрипт
fs.writeFileSync('physiology_questions_insert.sql', fullSqlScript);

console.log('✅ SQL INSERT statements збережено в physiology_questions_insert.sql');
console.log('📊 Статистика:');
console.log(`   - Всього питань: ${questions.length}`);
console.log(`   - Системи: ${[...new Set(questions.map(q => q.system))].join(', ')}`);

// Показуємо перші 3 питання для перевірки
console.log('\n🔍 Перші 3 питання:');
questions.slice(0, 3).forEach((q, index) => {
  console.log(`${index + 1}. ${q.question_text}`);
  console.log(`   Відповіді: A) ${q.option_a}, B) ${q.option_b}, C) ${q.option_c}, D) ${q.option_d}`);
  console.log(`   Правильна: ${q.correct_answer}`);
  console.log(`   Система: ${q.system}`);
  console.log('');
});
