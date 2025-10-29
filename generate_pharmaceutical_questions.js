const fs = require('fs');

// Читаємо CSV файл
const csvPath = '/Users/bohdanpavliuk/Downloads/Фарм - Фарм.csv.csv';
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
  if (line.includes('№,Блок') || line.includes('№,Система')) {
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
        system: columns[1] || 'Загальна фармація', // Блок
        level: columns[2] || '', // Рівень
        situation: columns[3] || '', // Ситуація/Клінічний опис
        question: columns[4] || '', // Питання
        optionA: columns[5] || '', // Варіант A
        optionB: columns[6] || '', // Варіант B
        optionC: columns[7] || '', // Варіант C
        optionD: columns[8] || '', // Варіант D
        correct: columns[9] || '', // Правильна відповідь
        topic: columns[1] || 'Загальна фармація', // Використовуємо блок як тему
        recommendation: '' // Немає пояснень
      };
      
      // Перевіряємо чи є всі обов'язкові поля
      if (!questionData.question || !questionData.optionA || !questionData.correct) {
        console.log(`⚠️  Пропускаємо питання ${questionNumber} - не повні дані`);
      } else {
        allQuestions.push(questionData);
        console.log(`Додано питання ${questionData.number}: ${questionData.question.substring(0, 50)}...`);
      }
    } else {
      console.log(`⚠️  Дублікат номера: ${questionNumber}`);
    }
  }
}

// Сортуємо по номерах
allQuestions.sort((a, b) => a.number - b.number);

console.log(`\n📊 Статистика:`);
console.log(`   - Всього унікальних питань: ${allQuestions.length}`);

// Генеруємо SQL INSERT statements
let sqlContent = `-- Вставка питань з фармації
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
  
  // Формуємо повне питання тільки з питання (без ситуації)
  let fullQuestion = q.question;
  
  sqlContent += `(
  ${q.number},
  '${q.system.replace(/'/g, "''")}',
  '${fullQuestion.replace(/'/g, "''")}',
  '${q.optionA.replace(/'/g, "''")}',
  '${q.optionB.replace(/'/g, "''")}',
  '${q.optionC.replace(/'/g, "''")}',
  '${q.optionD.replace(/'/g, "''")}',
  '${q.correct}',
  '${q.topic.replace(/'/g, "''")}',
  '${q.recommendation.replace(/'/g, "''")}',
  'pharmaceutical'
)${isLast ? ';' : ','}
`;
});

sqlContent += `
-- Перевіряємо кількість питань
SELECT COUNT(*) as total_questions FROM physiology_questions WHERE faculty = 'pharmaceutical';
`;

// Зберігаємо SQL файл
const outputPath = '/Users/bohdanpavliuk/Desktop/help-krok-platform/pharmaceutical_questions.sql';
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

console.log(`\n📋 Розподіл по блокам:`);
Object.entries(systems).forEach(([system, count]) => {
  console.log(`   - ${system}: ${count} питань`);
});

console.log(`\n🎯 Перші 5 питань:`);
allQuestions.slice(0, 5).forEach((q, index) => {
  console.log(`${q.number}. ${q.system}`);
  console.log(`   Питання: ${q.question}`);
  console.log(`   Відповіді: A) ${q.optionA}, B) ${q.optionB}, C) ${q.optionC}, D) ${q.optionD}`);
  console.log(`   Правильна: ${q.correct}`);
  console.log('');
});
