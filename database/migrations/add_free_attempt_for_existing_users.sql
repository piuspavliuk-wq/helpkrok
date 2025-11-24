-- Migration: Add one free randomizer attempt for existing users
-- Date: 2025-01-XX
-- Description: Надає одну безкоштовну спробу для всіх існуючих користувачів, які ще не мають записів у randomizer_attempts
--               Також створює тригер для автоматичного надання безкоштовної спроби новим користувачам

-- Додаємо одну безкоштовну спробу для всіх існуючих користувачів, які ще не мають спроб
INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, purchase_date, expires_at)
SELECT 
    u.id,
    1 as total_attempts,
    0 as used_attempts,
    NOW() as purchase_date,
    NULL as expires_at -- Безкоштовна спроба не має терміну дії
FROM users u
WHERE NOT EXISTS (
    -- Перевіряємо, чи користувач вже має спроби
    SELECT 1 
    FROM randomizer_attempts ra 
    WHERE ra.user_id = u.id
)
ON CONFLICT DO NOTHING; -- Захист від дублікатів (якщо є unique constraint)

-- Створюємо функцію для автоматичного надання безкоштовної спроби новим користувачам
CREATE OR REPLACE FUNCTION give_free_randomizer_attempt()
RETURNS TRIGGER AS $$
BEGIN
    -- Перевіряємо, чи користувач ще не має спроб (захист від дублікатів)
    IF NOT EXISTS (
        SELECT 1 
        FROM randomizer_attempts 
        WHERE user_id = NEW.id
    ) THEN
        -- Надаємо одну безкоштовну спробу
        INSERT INTO randomizer_attempts (
            user_id, 
            total_attempts, 
            used_attempts, 
            purchase_date, 
            expires_at
        ) VALUES (
            NEW.id,
            1,
            0,
            NOW(),
            NULL -- Безкоштовна спроба не має терміну дії
        );
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Створюємо тригер, який спрацьовує після вставки нового користувача
DROP TRIGGER IF EXISTS trigger_give_free_randomizer_attempt ON users;
CREATE TRIGGER trigger_give_free_randomizer_attempt
    AFTER INSERT ON users
    FOR EACH ROW
    EXECUTE FUNCTION give_free_randomizer_attempt();

-- Логування кількості доданих спроб для існуючих користувачів
DO $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM randomizer_attempts
    WHERE total_attempts = 1 
    AND used_attempts = 0 
    AND expires_at IS NULL
    AND purchase_date >= NOW() - INTERVAL '1 minute';
    
    RAISE NOTICE 'Додано безкоштовних спроб для % користувачів', v_count;
    RAISE NOTICE 'Тригер для автоматичного надання безкоштовної спроби новим користувачам створено';
END $$;
