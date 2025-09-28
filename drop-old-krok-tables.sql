-- ========================================
-- Видалення старих таблиць крок-питань
-- ========================================
-- ВИКОНАЙТЕ ЦЕЙ СКРИПТ ТІЛЬКИ ПІСЛЯ ТОГО, ЯК ПЕРЕКОНАЄТЕСЯ,
-- ЩО ВСІ ДАНІ УСПІШНО ПЕРЕНЕСЕНІ ДО krok_questions_unified

-- УВАГА: Ця операція незворотна! Створіть бекап перед виконанням!

-- 1. Спочатку видаляємо залежні таблиці (з foreign keys)
-- ========================================

-- Видаляємо таблицю результатів тестів (якщо вона використовує старі таблиці)
DROP TABLE IF EXISTS krok_test_results CASCADE;

-- Видаляємо таблицю відповідей
DROP TABLE IF EXISTS krok_answers CASCADE;

-- Видаляємо таблицю пояснень
DROP TABLE IF EXISTS krok_explanations CASCADE;

-- 2. Видаляємо основну таблицю питань
-- ========================================
DROP TABLE IF EXISTS krok_questions CASCADE;

-- 3. Перевіряємо, що таблиці видалені
-- ========================================
-- Виконайте цей запит, щоб переконатися, що таблиці видалені:
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name LIKE 'krok_%'
ORDER BY table_name;

-- Має залишитися тільки krok_questions_unified

-- 4. Очищуємо зайві функції та тригери (якщо є)
-- ========================================
DROP FUNCTION IF EXISTS update_krok_questions_updated_at() CASCADE;
DROP FUNCTION IF EXISTS update_krok_answers_updated_at() CASCADE;
DROP FUNCTION IF EXISTS update_krok_explanations_updated_at() CASCADE;

-- 5. Перевіряємо розмір єдиної таблиці
-- ========================================
SELECT 
    schemaname,
    tablename,
    attname,
    n_distinct,
    correlation
FROM pg_stats 
WHERE tablename = 'krok_questions_unified'
ORDER BY attname;

-- 6. Показуємо статистику єдиної таблиці
-- ========================================
SELECT 
    COUNT(*) as total_questions,
    COUNT(CASE WHEN option_a IS NOT NULL THEN 1 END) as questions_with_option_a,
    COUNT(CASE WHEN option_b IS NOT NULL THEN 1 END) as questions_with_option_b,
    COUNT(CASE WHEN option_c IS NOT NULL THEN 1 END) as questions_with_option_c,
    COUNT(CASE WHEN option_d IS NOT NULL THEN 1 END) as questions_with_option_d,
    COUNT(CASE WHEN option_e IS NOT NULL THEN 1 END) as questions_with_option_e,
    COUNT(CASE WHEN correct_answer IS NOT NULL THEN 1 END) as questions_with_correct_answer,
    COUNT(CASE WHEN explanation_text IS NOT NULL THEN 1 END) as questions_with_explanation,
    COUNT(CASE WHEN reference_text IS NOT NULL THEN 1 END) as questions_with_reference
FROM krok_questions_unified;

-- 7. Показуємо розмір таблиці
-- ========================================
SELECT 
    pg_size_pretty(pg_total_relation_size('krok_questions_unified')) as table_size;
