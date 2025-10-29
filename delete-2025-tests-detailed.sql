-- Детальний скрипт для видалення тестів 2025 року
-- З урахуванням різних категорій та факультетів

-- 1. Перевіряємо що є в базі даних 2025 року
SELECT 
    'Перед видаленням' as status,
    COUNT(*) as total_questions,
    faculty,
    category,
    year
FROM krok_questions_unified 
WHERE year = 2025 
GROUP BY faculty, category, year
ORDER BY faculty, category;

-- 2. Показуємо детальну статистику
SELECT 
    'Детальна статистика 2025' as info,
    faculty,
    category,
    COUNT(*) as questions_count,
    MIN(created_at) as earliest_created,
    MAX(created_at) as latest_created
FROM krok_questions_unified 
WHERE year = 2025 
GROUP BY faculty, category
ORDER BY faculty, category;

-- 3. Видаляємо тести 2025 року по категоріях (можна запускати окремо)

-- Видаляємо тільки медичні тести 2025 року
-- DELETE FROM krok_questions_unified 
-- WHERE year = 2025 AND faculty = 'medical';

-- Видаляємо тільки фармацевтичні тести 2025 року  
-- DELETE FROM krok_questions_unified 
-- WHERE year = 2025 AND faculty = 'pharmaceutical';

-- Видаляємо тільки конкретну категорію (наприклад, анатомія)
-- DELETE FROM krok_questions_unified 
-- WHERE year = 2025 AND faculty = 'medical' AND category = 'анатомія';

-- Видаляємо ВСІ тести 2025 року (запускайте обережно!)
DELETE FROM krok_questions_unified 
WHERE year = 2025;

-- 4. Перевіряємо результат після видалення
SELECT 
    'Після видалення' as status,
    COUNT(*) as total_questions,
    faculty,
    year
FROM krok_questions_unified 
GROUP BY faculty, year
ORDER BY year DESC, faculty;

-- 5. Показуємо загальну статистику
SELECT 
    'Загальна статистика' as info,
    COUNT(*) as total_questions,
    COUNT(CASE WHEN faculty = 'medical' THEN 1 END) as medical_questions,
    COUNT(CASE WHEN faculty = 'pharmaceutical' THEN 1 END) as pharmaceutical_questions,
    MIN(year) as earliest_year,
    MAX(year) as latest_year
FROM krok_questions_unified;

-- 6. Показуємо розподіл по роках
SELECT 
    year,
    faculty,
    COUNT(*) as questions_count
FROM krok_questions_unified 
GROUP BY year, faculty
ORDER BY year DESC, faculty;
