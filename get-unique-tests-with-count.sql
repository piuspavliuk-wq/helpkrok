-- SQL запит для отримання унікальних тестів з підрахунком питань
-- Це замінить RPC функцію get_krok_years

SELECT 
  year,
  faculty,
  test_identifier,
  MAX(title) as title,
  MAX(description) as description,
  MAX(category) as category,
  COUNT(*) as total_questions,
  is_active
FROM krok_questions_unified
WHERE faculty = 'medical' -- параметр
  AND is_active = true
GROUP BY year, faculty, test_identifier, is_active
ORDER BY year DESC;
