const fs = require('fs');

// Джерело CSV
const csvPath = '/Users/bohdanpavliuk/Downloads/Фарм - Фарм.csv.csv';
const csvContent = fs.readFileSync(csvPath, 'utf8');
const lines = csvContent.split('\n');

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

const allQuestions = [];
const seen = new Set();

for (let i = 0; i < lines.length; i++) {
  const line = lines[i].trim();
  if (!line) continue;
  if (line.includes('№,Блок') || line.includes('№,Система')) continue;
  const columns = parseCSVLine(line);
  if (columns.length >= 10 && columns[0] && !isNaN(parseInt(columns[0]))) {
    const num = parseInt(columns[0]);
    if (seen.has(num)) continue;
    seen.add(num);
    const q = {
      number: num,
      system: columns[1] || 'Загальна фармація',
      situation: columns[3] || '',
      question: columns[4] || '',
      optionA: columns[5] || '',
      optionB: columns[6] || '',
      optionC: columns[7] || '',
      optionD: columns[8] || '',
      correct: columns[9] || '',
      topic: columns[1] || 'Загальна фармація'
    };
    if (q.question && q.optionA && q.correct) {
      allQuestions.push(q);
    }
  }
}

allQuestions.sort((a, b) => a.number - b.number);

let sql = `-- Питання для перевірки знань (окрема таблиця)\n-- Всього питань: ${allQuestions.length}\n\nDELETE FROM pharmacy_knowledge_questions;\n\nINSERT INTO pharmacy_knowledge_questions (\n  question_number, system, question_text, situation,\n  option_a, option_b, option_c, option_d,\n  correct_answer, topic, recommendation\n) VALUES\n`;

allQuestions.forEach((q, idx) => {
  const isLast = idx === allQuestions.length - 1;
  sql += `(\n  ${q.number},\n  '${q.system.replace(/'/g, "''")}',\n  '${q.question.replace(/'/g, "''")}',\n  '${q.situation.replace(/'/g, "''")}',\n  '${q.optionA.replace(/'/g, "''")}',\n  '${q.optionB.replace(/'/g, "''")}',\n  '${q.optionC.replace(/'/g, "''")}',\n  '${q.optionD.replace(/'/g, "''")}',\n  '${q.correct}',\n  '${q.topic.replace(/'/g, "''")}',\n  ''\n)${isLast ? ';' : ','}\n`;
});

sql += `\nSELECT COUNT(*) as total_questions FROM pharmacy_knowledge_questions;\n`;

const outputPath = '/Users/bohdanpavliuk/Desktop/help-krok-platform/pharmacy_knowledge_questions.sql';
fs.writeFileSync(outputPath, sql);
console.log(`✅ Створено: ${outputPath}`);
console.log(`Всого питань: ${allQuestions.length}`);
