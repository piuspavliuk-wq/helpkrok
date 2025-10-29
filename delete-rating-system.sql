-- Видалення рейтингової системи з бази даних
-- ВАЖЛИВО: Цей скрипт видалить всі рейтингові дані!

-- 1. Видаляємо тригери
DROP TRIGGER IF EXISTS trigger_update_rating ON user_test_progress;
DROP TRIGGER IF EXISTS trigger_update_rating ON test_attempts;

-- 2. Видаляємо функції
DROP FUNCTION IF EXISTS calculate_user_rating();
DROP FUNCTION IF EXISTS update_user_rating();
DROP FUNCTION IF EXISTS update_all_ratings();
DROP FUNCTION IF EXISTS check_user_achievements();

-- 3. Видаляємо таблиці (в правильному порядку через foreign keys)
DROP TABLE IF EXISTS user_achievements CASCADE;
DROP TABLE IF EXISTS user_ratings CASCADE;
DROP TABLE IF EXISTS user_statistics CASCADE;
DROP TABLE IF EXISTS achievements CASCADE;

-- 4. Видаляємо колонки з users таблиці (якщо потрібно)
-- ALTER TABLE users DROP COLUMN IF EXISTS faculty;
-- ALTER TABLE users DROP COLUMN IF EXISTS university;

-- Перевірка що видалено
SELECT 'Rating system tables deleted successfully' as status;
