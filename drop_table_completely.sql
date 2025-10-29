-- ПОВНЕ ВИДАЛЕННЯ ТАБЛИЦІ
-- ВАЖЛИВО: Це видалить таблицю та ВСІ дані назавжди!

-- Спочатку видаляємо всі політики RLS
DROP POLICY IF EXISTS "Users can view physiology questions" ON physiology_questions;
DROP POLICY IF EXISTS "Users can insert physiology questions" ON physiology_questions;
DROP POLICY IF EXISTS "Users can update physiology questions" ON physiology_questions;
DROP POLICY IF EXISTS "Users can delete physiology questions" ON physiology_questions;

-- Видаляємо всі індекси
DROP INDEX IF EXISTS idx_physiology_questions_system;
DROP INDEX IF EXISTS idx_physiology_questions_faculty;
DROP INDEX IF EXISTS idx_physiology_questions_question_number;

-- Видаляємо саму таблицю
DROP TABLE IF EXISTS physiology_questions;

-- Перевіряємо що таблиця видалена
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'physiology_questions';
