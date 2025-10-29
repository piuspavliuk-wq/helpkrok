const fs = require('fs');
const path = require('path');

class Day2TextToKrokUnifiedCopier {
  constructor() {
    this.outputDir = './data';
    this.ensureOutputDir();
  }

  ensureOutputDir() {
    if (!fs.existsSync(this.outputDir)) {
      fs.mkdirSync(this.outputDir, { recursive: true });
    }
  }

  // Читаємо дані з JSON файлу 2025-day2-text
  async readDay2TextData() {
    try {
      // Читаємо останній JSON файл з 2025-day2-text
      const files = fs.readdirSync(this.outputDir)
        .filter(file => file.includes('2025-day2-text') && file.endsWith('.json'))
        .sort()
        .reverse();

      if (files.length === 0) {
        throw new Error('Не знайдено JSON файлів з 2025-day2-text');
      }

      const latestFile = files[0];
      console.log(`Читаємо дані з файлу: ${latestFile}`);
      
      const filePath = path.join(this.outputDir, latestFile);
      const content = fs.readFileSync(filePath, 'utf8');
      
      // Парсимо JSON
      const data = JSON.parse(content);
      
      if (!data.questions || !Array.isArray(data.questions)) {
        throw new Error('Некоректний формат JSON файлу');
      }

      console.log(`Знайдено ${data.questions.length} питань`);
      console.log(`Метадані:`, data.metadata);
      
      return data.questions;
    } catch (error) {
      console.error('Помилка при читанні даних:', error);
      throw error;
    }
  }

  // Генеруємо SQL для копіювання в krok_questions_unified
  generateCopySQL(questions) {
    const timestamp = Date.now();
    const filename = `copy-2025-day2-text-to-krok-unified-${timestamp}.sql`;
    const filepath = path.join(this.outputDir, filename);

    let sql = `-- ========================================
-- Копіювання даних з 2025-day2-text в krok_questions_unified
-- ========================================
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${questions.length}

-- Спочатку додаємо колонку test_identifier (якщо не існує)
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS test_identifier VARCHAR(100);

-- Додаємо колонку title (якщо не існує)
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS title VARCHAR(200);

-- Додаємо коментарі
COMMENT ON COLUMN krok_questions_unified.test_identifier IS 'Унікальний ідентифікатор тесту';
COMMENT ON COLUMN krok_questions_unified.title IS 'Назва тесту';

-- Створюємо індекси
CREATE INDEX IF NOT EXISTS idx_krok_unified_test_identifier ON krok_questions_unified(test_identifier);
CREATE INDEX IF NOT EXISTS idx_krok_unified_title ON krok_questions_unified(title);

-- Копіюємо дані з 2025-day2-text
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
    title,
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
    ${q.year || 2025}, -- Рік
    '${q.faculty || 'medical'}', -- Факультет
    '${q.category || 'Загальна медицина'}', -- Категорія
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
    '${q.test_identifier || '2025-day2-text'}', -- Унікальний ідентифікатор тесту
    '2025р 2 д (ТЕХТ)', -- Назва тесту
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
    COUNT(CASE WHEN test_identifier = '2025-day2-text' THEN 1 END) as day2_text_questions,
    COUNT(CASE WHEN option_a IS NOT NULL THEN 1 END) as questions_with_option_a,
    COUNT(CASE WHEN correct_answer IS NOT NULL THEN 1 END) as questions_with_correct_answer,
    COUNT(CASE WHEN title = '2025р 2 д (ТЕХТ)' THEN 1 END) as questions_with_title
FROM krok_questions_unified
WHERE test_identifier = '2025-day2-text';

-- Показуємо приклад записів
SELECT 
    id,
    LEFT(question_text, 100) as question_preview,
    year,
    faculty,
    test_identifier,
    title,
    correct_answer,
    CASE 
        WHEN option_a IS NOT NULL THEN 'A: ' || LEFT(option_a, 50) || '...'
        ELSE 'A: NULL'
    END as option_a_preview
FROM krok_questions_unified
WHERE test_identifier = '2025-day2-text'
ORDER BY id
LIMIT 5;

-- Перевіряємо унікальність test_identifier
SELECT 
    test_identifier,
    title,
    COUNT(*) as count
FROM krok_questions_unified
WHERE test_identifier LIKE '2025%'
GROUP BY test_identifier, title
ORDER BY test_identifier;
`;

    fs.writeFileSync(filepath, sql, 'utf8');
    console.log(`SQL файл створено: ${filepath}`);
    return filepath;
  }

  // Екрануємо SQL
  escapeSQL(str) {
    if (!str) return 'NULL';
    return `'${str.replace(/'/g, "''")}'`;
  }

  // Головний метод
  async copyData() {
    try {
      console.log('🚀 Починаємо копіювання даних з 2025-day2-text в krok_questions_unified...');
      
      // Читаємо дані
      const questions = await this.readDay2TextData();
      
      if (questions.length === 0) {
        throw new Error('Не знайдено питань для копіювання');
      }
      
      // Перевіряємо якість даних
      const questionsWithAnswers = questions.filter(q => q.correct_answer && q.correct_answer.trim());
      const questionsWithoutAnswers = questions.length - questionsWithAnswers.length;
      
      console.log(`📊 Статистика питань:`);
      console.log(`   - Загальна кількість: ${questions.length}`);
      console.log(`   - З правильними відповідями: ${questionsWithAnswers.length}`);
      console.log(`   - Без правильних відповідей: ${questionsWithoutAnswers.length}`);
      
      if (questionsWithoutAnswers > 0) {
        console.log(`⚠️  Увага: ${questionsWithoutAnswers} питань без правильних відповідей!`);
        console.log(`   Можливо потрібно повторно запустити скрапер з увімкненими відповідями.`);
      }
      
      // Генеруємо SQL
      const sqlFile = this.generateCopySQL(questions);
      
      console.log(`✅ Готово! Створено SQL файл: ${sqlFile}`);
      console.log(`📊 Кількість питань: ${questions.length}`);
      console.log(`🎯 Test identifier: 2025-day2-text`);
      console.log(`📝 Title: 2025р 2 д (ТЕХТ)`);
      console.log(`📝 Виконайте SQL файл в Supabase для копіювання даних`);
      
    } catch (error) {
      console.error('❌ Помилка при копіюванні:', error);
      throw error;
    }
  }
}

// Запускаємо копіювання
const copier = new Day2TextToKrokUnifiedCopier();
copier.copyData().catch(console.error);
