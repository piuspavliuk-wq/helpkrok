const fs = require('fs');
const path = require('path');

class UniversalKrokUnifiedCopier {
  constructor() {
    this.outputDir = './data';
    this.ensureOutputDir();
  }

  ensureOutputDir() {
    if (!fs.existsSync(this.outputDir)) {
      fs.mkdirSync(this.outputDir, { recursive: true });
    }
  }

  // Читаємо дані з будь-якого SQL файлу
  async readDataFromSQL(sqlFilePath, tableName) {
    try {
      console.log(`Читаємо дані з файлу: ${sqlFilePath}`);
      
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
          if (values.length >= 7) { // id, question_text, option_a, option_b, option_c, option_d, option_e, correct_answer
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

      console.log(`Знайдено ${questions.length} питань`);
      return questions;
    } catch (error) {
      console.error('Помилка при читанні даних:', error);
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

  // Генеруємо SQL для копіювання в krok_questions_unified
  generateCopySQL(questions, testIdentifier, year = 2024, faculty = 'medical', category = 'general') {
    const timestamp = Date.now();
    const filename = `copy-to-krok-unified-${testIdentifier}-${timestamp}.sql`;
    const filepath = path.join(this.outputDir, filename);

    let sql = `-- ========================================
-- Копіювання даних в krok_questions_unified
-- ========================================
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${questions.length}
-- Test identifier: ${testIdentifier}
-- Рік: ${year}
-- Факультет: ${faculty}
-- Категорія: ${category}

-- Спочатку додаємо колонку test_identifier (якщо не існує)
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS test_identifier VARCHAR(100);

-- Додаємо коментар
COMMENT ON COLUMN krok_questions_unified.test_identifier IS 'Унікальний ідентифікатор тесту';

-- Створюємо індекс
CREATE INDEX IF NOT EXISTS idx_krok_unified_test_identifier ON krok_questions_unified(test_identifier);

-- Копіюємо дані
INSERT INTO krok_questions_unified (
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
) VALUES
`;

    const values = questions.map((q, index) => {
      const questionText = this.escapeSQL(q.question_text);
      const optionA = q.option_a ? this.escapeSQL(q.option_a) : 'NULL';
      const optionB = q.option_b ? this.escapeSQL(q.option_b) : 'NULL';
      const optionC = q.option_c ? this.escapeSQL(q.option_c) : 'NULL';
      const optionD = q.option_d ? this.escapeSQL(q.option_d) : 'NULL';
      const optionE = q.option_e ? this.escapeSQL(q.option_e) : 'NULL';
      const correctAnswer = q.correct_answer ? `'${q.correct_answer}'` : 'NULL';
      
      return `(
    '${questionText}',
    ${year}, -- Рік
    '${faculty}', -- Факультет
    '${category}', -- Категорія
    'medium', -- Складність
    true, -- Активне
    ${optionA},
    ${optionB},
    ${optionC},
    ${optionD},
    ${optionE},
    ${correctAnswer},
    NULL, -- Пояснення
    NULL, -- Джерело
    '${testIdentifier}', -- Унікальний ідентифікатор тесту
    NOW(),
    NOW()
)${index < questions.length - 1 ? ',' : ';'}`;
    });

    sql += values.join('\n');

    // Додаємо перевірку
    sql += `

-- Перевіряємо результат
SELECT 
    COUNT(*) as total_questions,
    COUNT(CASE WHEN test_identifier = '${testIdentifier}' THEN 1 END) as ${testIdentifier.replace('-', '_')}_questions,
    COUNT(CASE WHEN option_a IS NOT NULL THEN 1 END) as questions_with_option_a,
    COUNT(CASE WHEN correct_answer IS NOT NULL THEN 1 END) as questions_with_correct_answer
FROM krok_questions_unified
WHERE test_identifier = '${testIdentifier}';

-- Показуємо приклад записів
SELECT 
    id,
    LEFT(question_text, 100) as question_preview,
    year,
    faculty,
    test_identifier,
    correct_answer,
    CASE 
        WHEN option_a IS NOT NULL THEN 'A: ' || LEFT(option_a, 50) || '...'
        ELSE 'A: NULL'
    END as option_a_preview
FROM krok_questions_unified
WHERE test_identifier = '${testIdentifier}'
ORDER BY id
LIMIT 5;
`;

    fs.writeFileSync(filepath, sql, 'utf8');
    console.log(`SQL файл створено: ${filepath}`);
    return filepath;
  }

  // Екрануємо SQL
  escapeSQL(str) {
    if (!str) return 'NULL';
    // Замінюємо одинарні лапки на подвійні одинарні для PostgreSQL
    return `'${str.replace(/'/g, "''")}'`;
  }

  // Головний метод
  async copyData(sqlFilePath, tableName, testIdentifier, year = 2024, faculty = 'medical', category = 'general') {
    try {
      console.log(`🚀 Починаємо копіювання даних з ${tableName} в krok_questions_unified...`);
      console.log(`📁 Файл: ${sqlFilePath}`);
      console.log(`🏷️ Test identifier: ${testIdentifier}`);
      
      // Читаємо дані
      const questions = await this.readDataFromSQL(sqlFilePath, tableName);
      
      if (questions.length === 0) {
        throw new Error('Не знайдено питань для копіювання');
      }
      
      // Генеруємо SQL
      const sqlFile = this.generateCopySQL(questions, testIdentifier, year, faculty, category);
      
      console.log(`✅ Готово! Створено SQL файл: ${sqlFile}`);
      console.log(`📊 Кількість питань: ${questions.length}`);
      console.log(`🎯 Test identifier: ${testIdentifier}`);
      console.log(`📝 Виконайте SQL файл в Supabase для копіювання даних`);
      
    } catch (error) {
      console.error('❌ Помилка при копіюванні:', error);
      throw error;
    }
  }
}

// Функція для запуску з параметрами
async function copyData(sqlFilePath, tableName, testIdentifier, year = 2024, faculty = 'medical', category = 'general') {
  const copier = new UniversalKrokUnifiedCopier();
  await copier.copyData(sqlFilePath, tableName, testIdentifier, year, faculty, category);
}

// Експортуємо для використання
module.exports = { UniversalKrokUnifiedCopier, copyData };

// Якщо запускаємо напряму
if (require.main === module) {
  // Приклад використання
  const args = process.argv.slice(2);
  
  if (args.length < 3) {
    console.log('Використання: node copy-any-data-to-krok-unified.js <sql_file> <table_name> <test_identifier> [year] [faculty] [category]');
    console.log('Приклад: node copy-any-data-to-krok-unified.js ./data/microbiology-questions-1759860451800.sql microbiology_questions 2024-microbiology-english 2024 medical microbiology');
    process.exit(1);
  }
  
  const [sqlFile, tableName, testIdentifier, year = 2024, faculty = 'medical', category = 'general'] = args;
  
  copyData(sqlFile, tableName, testIdentifier, year, faculty, category).catch(console.error);
}
