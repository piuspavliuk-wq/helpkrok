-- Оновлюємо назву тесту з "Delving into dreams" на "2025р 2 д (ТЕХТ)"
UPDATE krok_questions_unified 
SET title = '2025р 2 д (ТЕХТ)'
WHERE test_identifier = '2025-freud-dreams';

-- Перевірка оновлення
SELECT COUNT(*) as updated_records 
FROM krok_questions_unified 
WHERE test_identifier = '2025-freud-dreams' 
AND title = '2025р 2 д (ТЕХТ)';
