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
    } else {
      console.log(`⚠️  Дублікат номера: ${questionNumber}`);
    }
  }
}

console.log(`\n📊 Статистика:`);
console.log(`   - Всього унікальних питань: ${allQuestions.length}`);
console.log(`   - Номери питань: ${Array.from(questionNumbers).sort((a, b) => a - b).join(', ')}`);

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

console.log(`\n🎯 Останні 5 питань:`);
allQuestions.slice(-5).forEach((q, index) => {
  console.log(`${q.number}. ${q.system}`);
  console.log(`   Питання: ${q.question}`);
  console.log(`   Правильна: ${q.correct}`);
  console.log('');
});
