const fs = require('fs');

// Читаємо CSV файл
const csvPath = '/Users/bohdanpavliuk/Downloads/Untitled spreadsheet - Sheet1 (1).csv';
const csvContent = fs.readFileSync(csvPath, 'utf8');

// Розбиваємо на рядки
const lines = csvContent.split('\n');

// Функція для парсингу CSV рядка з урахуванням лапок
function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;
  
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  
  result.push(current.trim());
  return result;
}

// Масив для зберігання всіх питань
const allQuestions = [];
const questionNumbers = new Set();

// Обробляємо кожен рядок
for (let i = 0; i < lines.length; i++) {
  const line = lines[i].trim();
  
  // Пропускаємо порожні рядки
  if (!line) continue;
  
  // Пропускаємо заголовки таблиць
  if (line.includes('№,Система') || line.includes('№,Питання')) {
    continue;
  }
  
  // Парсимо рядок
  const columns = parseCSVLine(line);
  
  // Перевіряємо чи це питання (має номер і достатньо колонок)
  if (columns.length >= 10 && columns[0] && !isNaN(parseInt(columns[0]))) {
    const questionNumber = parseInt(columns[0]);
    
    // Перевіряємо чи це унікальне питання
    if (!questionNumbers.has(questionNumber)) {
      questionNumbers.add(questionNumber);
      
      const questionData = {
        number: questionNumber,
        system: columns[1] || 'Невизначена',
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
      
      allQuestions.push(questionData);
    }
  }
}

// Сортуємо по номерах
allQuestions.sort((a, b) => a.number - b.number);

console.log(`\n📊 Статистика:`);
console.log(`   - Всього унікальних питань: ${allQuestions.length}`);

// Генеруємо SQL INSERT statements
let sqlContent = `-- Вставка всіх питань з новим CSV файлу
-- Всього питань: ${allQuestions.length}

DELETE FROM physiology_questions WHERE faculty = 'medical';

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

sqlContent += `
-- Перевіряємо кількість питань
SELECT COUNT(*) as total_questions FROM physiology_questions WHERE faculty = 'medical';
`;

// Зберігаємо SQL файл
const outputPath = '/Users/bohdanpavliuk/Desktop/help-krok-platform/correct_questions.sql';
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

console.log(`\n🎯 Останні 3 питання:`);
allQuestions.slice(-3).forEach((q, index) => {
  console.log(`${q.number}. ${q.system}`);
  console.log(`   Питання: ${q.question}`);
  console.log(`   Правильна: ${q.correct}`);
  console.log('');
});
