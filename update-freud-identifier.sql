-- Оновлюємо test_identifier з "2025-freud-dreams" на "2025-day2-text"
UPDATE krok_questions_unified 
SET test_identifier = '2025-day2-text'
WHERE test_identifier = '2025-freud-dreams';

-- Перевірка оновлення
SELECT COUNT(*) as updated_records 
FROM krok_questions_unified 
WHERE test_identifier = '2025-day2-text' 
AND title = '2025р 2 д (ТЕХТ)';
