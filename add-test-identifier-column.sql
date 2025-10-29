-- ========================================
-- Додаємо колонку test_identifier до krok_questions_unified
-- ========================================
-- Це дозволить розділяти тести одного року на окремі групи

-- Додаємо колонку test_identifier
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS test_identifier VARCHAR(100);

-- Додаємо коментар
COMMENT ON COLUMN krok_questions_unified.test_identifier IS 'Унікальний ідентифікатор тесту (наприклад: "2025-foreigners", "2025-day2", "2024-text")';

-- Створюємо індекс для покращення продуктивності
CREATE INDEX IF NOT EXISTS idx_krok_unified_test_identifier ON krok_questions_unified(test_identifier);

-- Оновлюємо існуючі записи (якщо є)
-- Для існуючих записів встановлюємо test_identifier = year + faculty
UPDATE krok_questions_unified 
SET test_identifier = CONCAT(year, '-', faculty)
WHERE test_identifier IS NULL;

-- Робимо test_identifier NOT NULL після оновлення
ALTER TABLE krok_questions_unified 
ALTER COLUMN test_identifier SET NOT NULL;
