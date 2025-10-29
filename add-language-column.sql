-- ========================================
-- Додаємо колонку language до krok_questions_unified
-- ========================================
-- Це дозволить вручну вказати мову тесту

-- Додаємо колонку language
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS language VARCHAR(20) DEFAULT 'ukrainian';

-- Додаємо коментар
COMMENT ON COLUMN krok_questions_unified.language IS 'Мова тесту: ukrainian, english, mixed';

-- Створюємо індекс
CREATE INDEX IF NOT EXISTS idx_krok_unified_language ON krok_questions_unified(language);

-- Оновлюємо існуючі записи (якщо є)
-- Для 2024 року встановлюємо english
UPDATE krok_questions_unified 
SET language = 'english'
WHERE year = 2024 AND faculty = 'medical';

-- Показуємо статистику
SELECT 
    year,
    language,
    COUNT(*) as questions_count
FROM krok_questions_unified
GROUP BY year, language
ORDER BY year DESC, language;
