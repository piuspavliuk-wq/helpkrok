-- Скрипт для видалення старої таблиці physiology_questions
-- ВАЖЛИВО: Це видалить ВСІ дані з таблиці!

-- Видаляємо всі записи з таблиці
DELETE FROM physiology_questions;

-- Або якщо хочете видалити всю таблицю повністю (включаючи структуру):
-- DROP TABLE IF EXISTS physiology_questions;

-- Перевіряємо що таблиця порожня
SELECT COUNT(*) as remaining_records FROM physiology_questions;

-- Показуємо структуру таблиці (якщо вона ще існує)
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'physiology_questions' 
ORDER BY ordinal_position;
