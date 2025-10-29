const fs = require('fs');
const path = require('path');

class SQLFixer {
  constructor() {
    this.outputDir = './data';
  }

  // Виправляємо екранування в SQL файлі
  fixSQLFile(inputFile, outputFile) {
    try {
      console.log(`🔧 Виправляємо SQL файл: ${inputFile}`);
      
      let content = fs.readFileSync(inputFile, 'utf8');
      
      // Замінюємо подвійні одинарні лапки на одинарні
      content = content.replace(/''/g, "'");
      
      // Видаляємо зайві екранування
      content = content.replace(/\\'/g, "'");
      content = content.replace(/\\"/g, '"');
      
      // Записуємо виправлений файл
      fs.writeFileSync(outputFile, content, 'utf8');
      
      console.log(`✅ Виправлений SQL файл: ${outputFile}`);
      return outputFile;
    } catch (error) {
      console.error('❌ Помилка при виправленні SQL:', error);
      throw error;
    }
  }

  // Створюємо простий SQL без складного екранування
  createSimpleSQL(questions, testIdentifier, year = 2024, faculty = 'medical', category = 'general') {
    const timestamp = Date.now();
    const filename = `simple-copy-to-krok-unified-${testIdentifier}-${timestamp}.sql`;
    const filepath = path.join(this.outputDir, filename);

    let sql = `-- ========================================
-- Простий SQL для копіювання даних в krok_questions_unified
-- ========================================
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${questions.length}
-- Test identifier: ${testIdentifier}

-- Копіюємо дані по одному запиту
`;

    questions.forEach((q, index) => {
      const questionText = this.escapeForSQL(q.question_text);
      const optionA = q.option_a ? this.escapeForSQL(q.option_a) : 'NULL';
      const optionB = q.option_b ? this.escapeForSQL(q.option_b) : 'NULL';
      const optionC = q.option_c ? this.escapeForSQL(q.option_c) : 'NULL';
      const optionD = q.option_d ? this.escapeForSQL(q.option_d) : 'NULL';
      const optionE = q.option_e ? this.escapeForSQL(q.option_e) : 'NULL';
      const correctAnswer = q.correct_answer ? `'${q.correct_answer}'` : 'NULL';
      
      sql += `INSERT INTO krok_questions_unified (
    question_text,
    year,
    faculty,
    category,
    difficulty,
    is_active,
    option_a,
    option_b,
    option_c,
    option_d,
    option_e,
    correct_answer,
    explanation_text,
    reference_text,
    test_identifier,
    created_at,
    updated_at
) VALUES (
    '${questionText}',
    ${year},
    '${faculty}',
    '${category}',
    'medium',
    true,
    ${optionA},
    ${optionB},
    ${optionC},
    ${optionD},
    ${optionE},
    ${correctAnswer},
    NULL,
    NULL,
    '${testIdentifier}',
    NOW(),
    NOW()
);

`;
    });

    // Додаємо перевірку
    sql += `
-- Перевіряємо результат
SELECT 
    COUNT(*) as total_questions,
    COUNT(CASE WHEN test_identifier = '${testIdentifier}' THEN 1 END) as ${testIdentifier.replace('-', '_')}_questions
FROM krok_questions_unified
WHERE test_identifier = '${testIdentifier}';
`;

    fs.writeFileSync(filepath, sql, 'utf8');
    console.log(`✅ Простий SQL файл створено: ${filepath}`);
    return filepath;
  }

  // Просте екранування для SQL
  escapeForSQL(str) {
    if (!str) return 'NULL';
    // Замінюємо одинарні лапки на подвійні одинарні
    const escaped = str.replace(/'/g, "''");
    return `'${escaped}'`;
  }

  // Читаємо дані з SQL файлу
  readDataFromSQL(sqlFilePath, tableName) {
    try {
      console.log(`📖 Читаємо дані з файлу: ${sqlFilePath}`);
      
      const content = fs.readFileSync(sqlFilePath, 'utf8');
      
      // Парсимо SQL INSERT запити
      const insertMatches = content.match(new RegExp(`INSERT INTO ${tableName}[^;]+;`, 'g'));
      
      if (!insertMatches) {
        throw new Error(`Не знайдено INSERT запитів для таблиці ${tableName}`);
      }

      const questions = [];
      
      insertMatches.forEach(insertQuery => {
        // Витягуємо VALUES частину
        const valuesMatch = insertQuery.match(/VALUES\s*\(([^)]+)\)/);
        if (valuesMatch) {
          const values = this.parseValues(valuesMatch[1]);
          if (values.length >= 7) {
            questions.push({
              id: values[0],
              question_text: values[1],
              option_a: values[2],
              option_b: values[3],
              option_c: values[4],
              option_d: values[5],
              option_e: values[6],
              correct_answer: values[7]
            });
          }
        }
      });

      console.log(`📊 Знайдено ${questions.length} питань`);
      return questions;
    } catch (error) {
      console.error('❌ Помилка при читанні даних:', error);
      throw error;
    }
  }

  // Парсимо VALUES рядок
  parseValues(valuesString) {
    const values = [];
    let current = '';
    let inQuotes = false;
    let quoteChar = '';
    
    for (let i = 0; i < valuesString.length; i++) {
      const char = valuesString[i];
      
      if (!inQuotes && (char === '"' || char === "'")) {
        inQuotes = true;
        quoteChar = char;
        current += char;
      } else if (inQuotes && char === quoteChar) {
        // Перевіряємо чи це не екранована лапка
        if (i + 1 < valuesString.length && valuesString[i + 1] === quoteChar) {
          current += char + char;
          i++; // Пропускаємо наступну лапку
        } else {
          inQuotes = false;
          quoteChar = '';
          current += char;
        }
      } else if (!inQuotes && char === ',') {
        values.push(this.cleanValue(current.trim()));
        current = '';
      } else {
        current += char;
      }
    }
    
    // Додаємо останнє значення
    if (current.trim()) {
      values.push(this.cleanValue(current.trim()));
    }
    
    return values;
  }

  // Очищуємо значення від лапок та екранування
  cleanValue(value) {
    value = value.trim();
    
    // Видаляємо зовнішні лапки
    if ((value.startsWith('"') && value.endsWith('"')) || 
        (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    
    // Замінюємо подвійні лапки на одинарні
    value = value.replace(/''/g, "'");
    value = value.replace(/""/g, '"');
    
    // Замінюємо NULL на null
    if (value.toUpperCase() === 'NULL') {
      return null;
    }
    
    return value;
  }
}

// Функція для створення простого SQL
async function createSimpleSQL(sqlFilePath, tableName, testIdentifier, year = 2024, faculty = 'medical', category = 'general') {
  const fixer = new SQLFixer();
  
  try {
    console.log(`🚀 Створюємо простий SQL для ${testIdentifier}...`);
    
    // Читаємо дані
    const questions = fixer.readDataFromSQL(sqlFilePath, tableName);
    
    if (questions.length === 0) {
      throw new Error('Не знайдено питань для копіювання');
    }
    
    // Створюємо простий SQL
    const sqlFile = fixer.createSimpleSQL(questions, testIdentifier, year, faculty, category);
    
    console.log(`✅ Готово! Створено простий SQL файл: ${sqlFile}`);
    console.log(`📊 Кількість питань: ${questions.length}`);
    console.log(`🎯 Test identifier: ${testIdentifier}`);
    
  } catch (error) {
    console.error('❌ Помилка:', error);
    throw error;
  }
}

// Експортуємо
module.exports = { SQLFixer, createSimpleSQL };

// Якщо запускаємо напряму
if (require.main === module) {
  const args = process.argv.slice(2);
  
  if (args.length < 3) {
    console.log('Використання: node fix-sql-escape.js <sql_file> <table_name> <test_identifier> [year] [faculty] [category]');
    process.exit(1);
  }
  
  const [sqlFile, tableName, testIdentifier, year = 2024, faculty = 'medical', category = 'general'] = args;
  
  createSimpleSQL(sqlFile, tableName, testIdentifier, year, faculty, category).catch(console.error);
}
