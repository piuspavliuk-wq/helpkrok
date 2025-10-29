-- ========================================
-- Додаємо колонку title до krok_questions_unified
-- ========================================
-- Це дозволить встановити власний заголовок для кожного тесту

-- Додаємо колонку title
ALTER TABLE krok_questions_unified 
ADD COLUMN IF NOT EXISTS title VARCHAR(200);

-- Додаємо коментар
COMMENT ON COLUMN krok_questions_unified.title IS 'Власний заголовок тесту (наприклад: "2024р (Eng)", "2025р іноземці")';

-- Створюємо індекс
CREATE INDEX IF NOT EXISTS idx_krok_unified_title ON krok_questions_unified(title);

-- Оновлюємо існуючі записи з заголовками
-- Для 2024 року встановлюємо "2024р (Eng)"
UPDATE krok_questions_unified 
SET title = '2024р (Eng)'
WHERE year = 2024 AND faculty = 'medical' AND test_identifier IS NULL;

-- Для 2024-microbiology-english встановлюємо "2024р 2 день (Eng)"
UPDATE krok_questions_unified 
SET title = '2024р 2 день (Eng)'
WHERE test_identifier = '2024-microbiology-english';

-- Для інших років встановлюємо стандартні заголовки
UPDATE krok_questions_unified 
SET title = CONCAT(year, 'р')
WHERE title IS NULL;

-- Показуємо статистику
SELECT 
    year,
    faculty,
    test_identifier,
    title,
    COUNT(*) as questions_count
FROM krok_questions_unified
GROUP BY year, faculty, test_identifier, title
ORDER BY year DESC, faculty, test_identifier;
