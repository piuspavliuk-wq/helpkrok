-- Видалення старих даних щоб не було дублікатів
-- Видаляємо всі записи з таблиці physiology_questions

DELETE FROM physiology_questions;

-- Перевіряємо що таблиця порожня
SELECT COUNT(*) as total_records FROM physiology_questions;
