const fs = require('fs');

// Правильні відповіді на основі тексту
const correctAnswers = {
  1: 'C', // Freud's relationship with his father could best be described as: Difficult and strained
  2: 'A', // According to Freud, what are dreams primarily an expression of? Subconscious wishes
  3: 'A', // Choose the correct statement: Freud proposed that dreams were a way to act out repressed urges
  4: 'A', // Freud believed that dreams were a way of: Fulfilling suppressed desires
  5: 'B', // Freud identified a deep-seated feeling of rivalry with his father and affection for his mother, concept later known as: Oedipus complex
  6: 'A', // According to Freud, what was necessary to achieve a cure for mental health issues? Probing the unconscious mind
  7: 'C', // In Freud's dream, what was his father's ghost accused of? Getting intoxicated and being held
  8: 'B', // Freud's theory emphasized that traumatic incidents during what period of life could lead to mental issues in adulthood? Childhood
  9: 'B', // Freud considered dreams to be: A gateway to understanding the unconscious
  10: 'D' // What event led Freud to start his self-examination through dreams? The death of his father
};

// Варіанти відповідей для кожного питання
const questionOptions = {
  1: {
    option_a: 'Easygoing',
    option_b: 'Loving and supportive', 
    option_c: 'Difficult and strained',
    option_d: 'Nonexistent',
    option_e: ''
  },
  2: {
    option_a: 'Subconscious wishes',
    option_b: 'Random thought',
    option_c: 'Logical reasoning',
    option_d: 'Daily experiences',
    option_e: ''
  },
  3: {
    option_a: 'Freud proposed that dreams were a way to act out repressed urges',
    option_b: 'Freud considered dreams as random and meaningless experiences',
    option_c: 'Freud believed dreams were unrelated to any psychological issues',
    option_d: 'Freud\'s Interpretation of Dreams was published in 1889',
    option_e: ''
  },
  4: {
    option_a: 'Fulfilling suppressed desires',
    option_b: 'Solving problems',
    option_c: 'Reliving past memories',
    option_d: 'Experiencing reality',
    option_e: ''
  },
  5: {
    option_a: 'Psychosexual development',
    option_b: 'Oedipus complex',
    option_c: 'Electra complex',
    option_d: 'Dream analysis',
    option_e: ''
  },
  6: {
    option_a: 'Probing the unconscious mind',
    option_b: 'Hypnotic treatment',
    option_c: 'Ignoring childhood memories',
    option_d: 'Medication',
    option_e: ''
  },
  7: {
    option_a: 'Inheriting money',
    option_b: 'Committing a crime',
    option_c: 'Getting intoxicated and being held',
    option_d: 'Leaving the family',
    option_e: ''
  },
  8: {
    option_a: 'Middle age',
    option_b: 'Childhood',
    option_c: 'Adolescence',
    option_d: 'Old age',
    option_e: ''
  },
  9: {
    option_a: 'Unrelated to any emotions',
    option_b: 'A gateway to understanding the unconscious',
    option_c: 'A reflection of conscious thoughts',
    option_d: 'An escape from reality',
    option_e: ''
  },
  10: {
    option_a: 'The birth of his first child',
    option_b: 'His marriage',
    option_c: 'A severe illness',
    option_d: 'The death of his father',
    option_e: ''
  }
};

// Читаємо останній JSON файл
const jsonFiles = fs.readdirSync('./data/').filter(f => f.startsWith('2025-day2-text-questions-') && f.endsWith('.json'));
const latestFile = jsonFiles.sort().pop();
const filePath = `./data/${latestFile}`;

console.log(`📖 Читаємо файл: ${filePath}`);

const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));

// Оновлюємо питання з правильними відповідями
data.questions.forEach((question, index) => {
  const questionNumber = index + 1;
  
  if (correctAnswers[questionNumber]) {
    question.correct_answer = correctAnswers[questionNumber];
    
    // Додаємо варіанти відповідей
    const options = questionOptions[questionNumber];
    if (options) {
      question.option_a = options.option_a;
      question.option_b = options.option_b;
      question.option_c = options.option_c;
      question.option_d = options.option_d;
      question.option_e = options.option_e;
    }
    
    console.log(`✅ Питання ${questionNumber}: ${question.correct_answer}`);
  }
});

// Оновлюємо метадані
data.metadata.title = 'Delving into dreams';
data.metadata.description = 'Freud\'s theory of dreams and unconscious mind';

// Зберігаємо виправлений файл
const fixedFilePath = filePath.replace('.json', '-fixed.json');
fs.writeFileSync(fixedFilePath, JSON.stringify(data, null, 2));

console.log(`\n💾 Виправлений файл збережено: ${fixedFilePath}`);

// Генеруємо SQL
const sqlContent = generateSQL(data.questions, '2025-freud-dreams', 2025, 'medical', '2025-freud-dreams', 'Delving into dreams');
const sqlFilePath = fixedFilePath.replace('.json', '.sql');
fs.writeFileSync(sqlFilePath, sqlContent);

console.log(`📄 SQL файл згенеровано: ${sqlFilePath}`);

function generateSQL(questions, filename, year, faculty, testIdentifier, title) {
  const timestamp = Date.now();
  const sqlFilename = `${filename}-${timestamp}.sql`;
  const filepath = `./data/${sqlFilename}`;
  
  let sql = `-- SQL для імпорту питань Freud Dreams
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${questions.length}

INSERT INTO krok_questions_unified (
  question_text, year, faculty, category, difficulty,
  option_a, option_b, option_c, option_d, option_e,
  correct_answer, explanation_text, reference_text,
  test_identifier, title, created_at, updated_at
) VALUES
`;

  questions.forEach((q, index) => {
    const isLast = index === questions.length - 1;
    const comma = isLast ? ';' : ',';
    
    sql += `(
  '${escapeSQL(q.question_text)}',
  ${year},
  '${faculty}',
  'Psychology',
  'medium',
  '${escapeSQL(q.option_a)}',
  '${escapeSQL(q.option_b)}',
  '${escapeSQL(q.option_c)}',
  '${escapeSQL(q.option_d)}',
  '${escapeSQL(q.option_e)}',
  '${q.correct_answer}',
  'Based on Freud\'s theory of dreams and unconscious mind',
  'Freud, S. (1899). The Interpretation of Dreams',
  '${testIdentifier}',
  '${title}',
  NOW(),
  NOW()
)${comma}
`;
  });

  sql += `

-- Перевірка кількості доданих записів
SELECT COUNT(*) as freud_dreams_questions FROM krok_questions_unified WHERE test_identifier = '${testIdentifier}';
`;

  return sql;
}

function escapeSQL(str) {
  if (!str) return '';
  return str.replace(/'/g, "''");
}
