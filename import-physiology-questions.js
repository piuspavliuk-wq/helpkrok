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
    const parts = line.split(',');
    
    // Перевіряємо, чи це дійсно питання (має номер)
    if (parts[0] && !isNaN(parts[0])) {
      const questionNumber = parseInt(parts[0]);
      const system = parts[1] || currentSystem;
      const level = parts[2];
      const questionText = parts[3];
      const optionA = parts[4];
      const optionB = parts[5];
      const optionC = parts[6];
      const optionD = parts[7];
      const correctAnswer = parts[8];
      const topic = parts[9];
      const recommendation = parts[10];
      
      // Перевіряємо, чи є всі необхідні дані
      if (questionText && optionA && optionB && optionC && optionD && correctAnswer) {
        questions.push({
          question_number: questionNumber,
          system: system,
          level: level,
          question_text: questionText,
          option_a: optionA,
          option_b: optionB,
          option_c: optionC,
          option_d: optionD,
          correct_answer: correctAnswer,
          topic: topic,
          recommendation: recommendation,
          faculty: 'medical' // За замовчуванням медичний факультет
        });
      }
    }
  }
}

console.log(`Знайдено ${questions.length} питань`);

// Створюємо SQL скрипт для імпорту
const sqlScript = `
-- Створення таблиці для питань фізіології
CREATE TABLE IF NOT EXISTS physiology_questions (
  id SERIAL PRIMARY KEY,
  question_number INTEGER,
  system VARCHAR(100),
  level VARCHAR(50),
  question_text TEXT,
  option_a TEXT,
  option_b TEXT,
  option_c TEXT,
  option_d TEXT,
  correct_answer VARCHAR(10),
  topic VARCHAR(200),
  recommendation TEXT,
  faculty VARCHAR(50) DEFAULT 'medical',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Очищення таблиці перед імпортом
DELETE FROM physiology_questions;

-- Вставка питань
${questions.map(q => `
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  ${q.question_number}, 
  '${q.system.replace(/'/g, "''")}', 
  '${q.level.replace(/'/g, "''")}', 
  '${q.question_text.replace(/'/g, "''")}', 
  '${q.option_a.replace(/'/g, "''")}', 
  '${q.option_b.replace(/'/g, "''")}', 
  '${q.option_c.replace(/'/g, "''")}', 
  '${q.option_d.replace(/'/g, "''")}', 
  '${q.correct_answer}', 
  '${q.topic.replace(/'/g, "''")}', 
  '${q.recommendation.replace(/'/g, "''")}', 
  '${q.faculty}'
);`).join('')}

-- Створення індексів для швидкого пошуку
CREATE INDEX IF NOT EXISTS idx_physiology_questions_system ON physiology_questions(system);
CREATE INDEX IF NOT EXISTS idx_physiology_questions_level ON physiology_questions(level);
CREATE INDEX IF NOT EXISTS idx_physiology_questions_faculty ON physiology_questions(faculty);
`;

// Зберігаємо SQL скрипт
fs.writeFileSync('physiology_questions_import.sql', sqlScript);

console.log('SQL скрипт збережено в physiology_questions_import.sql');
console.log('Перші 3 питання:');
console.log(JSON.stringify(questions.slice(0, 3), null, 2));
