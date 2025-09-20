-- Додавання тестових даних для перевірки статистики
-- Виконайте цей скрипт, щоб додати тестові відповіді

-- 1. Спочатку перевіряємо, чи є користувачі
SELECT 'Користувачі в системі:' as info,
       COUNT(*) as total_users
FROM user_test_progress;

-- 2. Якщо немає даних, додаємо тестові відповіді
-- ЗАМІНІТЬ 'your-user-id' на реальний ID користувача з вашої системи аутентифікації
INSERT INTO user_test_progress (user_id, test_type, question_id, selected_answer, is_correct, answered_at)
VALUES 
    -- Анатомія - 10 правильних, 2 неправильних
    ('your-user-id', 'anatomy', 1, 'A', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 2, 'B', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 3, 'C', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 4, 'A', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 5, 'D', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 6, 'B', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 7, 'C', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 8, 'A', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 9, 'D', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 10, 'B', true, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 11, 'C', false, NOW() - INTERVAL '1 day'),
    ('your-user-id', 'anatomy', 12, 'A', false, NOW() - INTERVAL '1 day'),
    
    -- Гістологія - 5 правильних, 1 неправильна
    ('your-user-id', 'histology', 1, 'A', true, NOW() - INTERVAL '2 days'),
    ('your-user-id', 'histology', 2, 'B', true, NOW() - INTERVAL '2 days'),
    ('your-user-id', 'histology', 3, 'C', true, NOW() - INTERVAL '2 days'),
    ('your-user-id', 'histology', 4, 'A', true, NOW() - INTERVAL '2 days'),
    ('your-user-id', 'histology', 5, 'D', true, NOW() - INTERVAL '2 days'),
    ('your-user-id', 'histology', 6, 'B', false, NOW() - INTERVAL '2 days'),
    
    -- Фізіологія - 8 правильних, 2 неправильних
    ('your-user-id', 'physiology', 1, 'A', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 2, 'B', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 3, 'C', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 4, 'A', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 5, 'D', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 6, 'B', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 7, 'C', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 8, 'A', true, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 9, 'D', false, NOW() - INTERVAL '3 days'),
    ('your-user-id', 'physiology', 10, 'B', false, NOW() - INTERVAL '3 days')
ON CONFLICT (user_id, test_type, question_id) DO NOTHING;

-- 3. Показуємо додані дані
SELECT 'Додані тестові дані:' as info,
       test_type,
       COUNT(*) as total_answers,
       SUM(CASE WHEN is_correct THEN 1 ELSE 0 END) as correct_answers,
       SUM(CASE WHEN NOT is_correct THEN 1 ELSE 0 END) as incorrect_answers,
       ROUND(
           (SUM(CASE WHEN is_correct THEN 1 ELSE 0 END)::DECIMAL / COUNT(*)) * 100, 
           2
       ) as percentage
FROM user_test_progress 
WHERE user_id = 'your-user-id'
GROUP BY test_type
ORDER BY total_answers DESC;

-- 4. Оновлюємо статистику
SELECT update_user_statistics_simple('your-user-id');

-- 5. Показуємо оновлену статистику
SELECT 'Оновлена статистика:' as info,
       user_id,
       total_questions_answered,
       correct_answers,
       incorrect_answers,
       average_percentage,
       last_calculated_at
FROM user_statistics
WHERE user_id = 'your-user-id';

SELECT 'Тестові дані додані! Тепер статистика повинна показувати реальні числа.' as status;
