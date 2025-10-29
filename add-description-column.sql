-- Додаємо колонку description до таблиці krok_questions_unified
ALTER TABLE krok_questions_unified
ADD COLUMN IF NOT EXISTS description TEXT;

-- Коментар для колонки
COMMENT ON COLUMN krok_questions_unified.description IS 'Опис тесту або вступний текст';
