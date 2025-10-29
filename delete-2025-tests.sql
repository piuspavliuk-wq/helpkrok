-- Скрипт для видалення попередніх тестів 2025 року
-- Перед імпортом нових питань з Krok Lead

-- Перевіряємо скільки питань буде видалено
SELECT 
    COUNT(*) as total_questions_to_delete,
    faculty,
    year
FROM krok_questions_unified 
WHERE year = 2025 
GROUP BY faculty, year;

-- Видаляємо всі питання 2025 року
DELETE FROM krok_questions_unified 
WHERE year = 2025;

-- Перевіряємо результат
SELECT 
    COUNT(*) as remaining_questions,
    faculty,
    year
FROM krok_questions_unified 
GROUP BY faculty, year
ORDER BY year DESC, faculty;

-- Показуємо статистику після видалення
SELECT 
    'Після видалення' as status,
    COUNT(*) as total_questions,
    COUNT(CASE WHEN faculty = 'medical' THEN 1 END) as medical_questions,
    COUNT(CASE WHEN faculty = 'pharmaceutical' THEN 1 END) as pharmaceutical_questions
FROM krok_questions_unified;
