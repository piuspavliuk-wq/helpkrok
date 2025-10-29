-- Змінюємо назву тесту "2025р 2 д (ТЕХТ)" на "2025 іноземці"

UPDATE krok_questions_unified
SET title = '2025 іноземці'
WHERE faculty = 'medical'
  AND year = 2025
  AND test_identifier = '2025-day2-text';

-- Перевіряємо результат
SELECT 
  year,
  test_identifier,
  title,
  COUNT(*) as questions_count
FROM krok_questions_unified
WHERE faculty = 'medical' AND year = 2025
GROUP BY year, test_identifier, title
ORDER BY test_identifier;
