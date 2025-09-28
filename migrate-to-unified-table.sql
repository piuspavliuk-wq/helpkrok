-- ========================================
-- Міграція даних з існуючих таблиць до єдиної таблиці
-- ========================================
-- Цей скрипт переносить дані з krok_questions, krok_answers, krok_explanations
-- до нової таблиці krok_questions_unified

-- Спочатку очищуємо нову таблицю (якщо вона не порожня)
TRUNCATE TABLE krok_questions_unified RESTART IDENTITY;

-- Мігруємо дані з існуючих таблиць
INSERT INTO krok_questions_unified (
    question_text,
    year,
    faculty,
    category,
    difficulty,
    is_active,
    option_a,
    option_b,
    option_c,
    option_d,
    option_e,
    correct_answer,
    explanation_text,
    reference_text,
    created_at,
    updated_at
)
SELECT 
    q.question_text,
    q.year,
    q.faculty,
    q.category,
    q.difficulty,
    q.is_active,
    
    -- Отримуємо варіанти відповідей через CASE WHEN
    MAX(CASE WHEN a.answer_option = 'A' THEN a.answer_text END) as option_a,
    MAX(CASE WHEN a.answer_option = 'B' THEN a.answer_text END) as option_b,
    MAX(CASE WHEN a.answer_option = 'C' THEN a.answer_text END) as option_c,
    MAX(CASE WHEN a.answer_option = 'D' THEN a.answer_text END) as option_d,
    MAX(CASE WHEN a.answer_option = 'E' THEN a.answer_text END) as option_e,
    
    -- Знаходимо правильну відповідь
    MAX(CASE WHEN a.is_correct = true THEN a.answer_option END) as correct_answer,
    
    -- Отримуємо пояснення
    e.explanation_text,
    e.reference_text,
    
    -- Метадані
    q.created_at,
    q.updated_at

FROM krok_questions q
LEFT JOIN krok_answers a ON q.id = a.question_id
LEFT JOIN krok_explanations e ON q.id = e.question_id
WHERE q.is_active = true
GROUP BY 
    q.id,
    q.question_text,
    q.year,
    q.faculty,
    q.category,
    q.difficulty,
    q.is_active,
    e.explanation_text,
    e.reference_text,
    q.created_at,
    q.updated_at
ORDER BY q.id;

-- Перевіряємо результат міграції
SELECT 
    COUNT(*) as total_questions,
    COUNT(option_a) as questions_with_option_a,
    COUNT(option_b) as questions_with_option_b,
    COUNT(option_c) as questions_with_option_c,
    COUNT(option_d) as questions_with_option_d,
    COUNT(option_e) as questions_with_option_e,
    COUNT(correct_answer) as questions_with_correct_answer,
    COUNT(explanation_text) as questions_with_explanation
FROM krok_questions_unified;

-- Показуємо приклад записів для перевірки
SELECT 
    id,
    LEFT(question_text, 100) as question_preview,
    year,
    faculty,
    category,
    difficulty,
    correct_answer,
    CASE 
        WHEN option_a IS NOT NULL THEN 'A: ' || LEFT(option_a, 50) || '...'
        ELSE 'A: NULL'
    END as option_a_preview,
    CASE 
        WHEN option_b IS NOT NULL THEN 'B: ' || LEFT(option_b, 50) || '...'
        ELSE 'B: NULL'
    END as option_b_preview,
    CASE 
        WHEN explanation_text IS NOT NULL THEN 'Has explanation'
        ELSE 'No explanation'
    END as has_explanation
FROM krok_questions_unified
ORDER BY id
LIMIT 10;
