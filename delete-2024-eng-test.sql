-- Видаляємо тест "2024р (Eng)" з 1 питанням
-- Це тестовий запис без test_identifier

DELETE FROM krok_questions_unified
WHERE faculty = 'medical'
  AND year = 2024
  AND test_identifier IS NULL
  AND title = '2024р (Eng)';

-- Перевіряємо результат
SELECT 
  year,
  test_identifier,
  title,
  COUNT(*) as questions_count
FROM krok_questions_unified
WHERE faculty = 'medical' AND year = 2024
GROUP BY year, test_identifier, title
ORDER BY test_identifier;
