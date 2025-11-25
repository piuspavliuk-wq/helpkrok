-- =====================================================
-- Скрипт для ручного додавання спроб рандомайзеру через базу даних
-- Виконайте ці запити в SQL Editor в Supabase Dashboard
-- =====================================================

-- =====================================================
-- 1. ДОДАТИ СПРОБИ КОНКРЕТНОМУ КОРИСТУВАЧУ ПО EMAIL
-- =====================================================
-- Замініть 'user@example.com' на email користувача
-- Замініть 10 на кількість спроб, які хочете додати

DO $$
DECLARE
    v_user_id UUID;
    v_attempts_count INTEGER := 10; -- Кількість спроб для додавання
    v_existing_attempt UUID;
BEGIN
    -- Знаходимо ID користувача за email
    SELECT id INTO v_user_id 
    FROM users 
    WHERE email = 'user@example.com';
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Користувача з email % не знайдено', 'user@example.com';
    END IF;
    
    -- Перевіряємо, чи вже є запис спроб
    SELECT id INTO v_existing_attempt
    FROM randomizer_attempts
    WHERE user_id = v_user_id
    AND (expires_at IS NULL OR expires_at >= NOW())
    ORDER BY purchase_date DESC
    LIMIT 1;
    
    IF v_existing_attempt IS NOT NULL THEN
        -- Оновлюємо існуючий запис
        UPDATE randomizer_attempts
        SET total_attempts = total_attempts + v_attempts_count,
            updated_at = NOW()
        WHERE id = v_existing_attempt;
        RAISE NOTICE 'Додано % спроб користувачу. Новий баланс: %', 
            v_attempts_count, 
            (SELECT total_attempts FROM randomizer_attempts WHERE id = v_existing_attempt);
    ELSE
        -- Створюємо новий запис
        INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
        VALUES (v_user_id, v_attempts_count, 0, NULL);
        RAISE NOTICE 'Створено новий запис з % спробами для користувача', v_attempts_count;
    END IF;
END $$;

-- =====================================================
-- 2. ДОДАТИ СПРОБИ КОНКРЕТНОМУ КОРИСТУВАЧУ ПО ID
-- =====================================================
-- Замініть 'user-uuid-here' на UUID користувача
-- Замініть 10 на кількість спроб

DO $$
DECLARE
    v_user_id UUID := 'user-uuid-here'; -- UUID користувача
    v_attempts_count INTEGER := 10; -- Кількість спроб
    v_existing_attempt UUID;
BEGIN
    -- Перевіряємо, чи існує користувач
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = v_user_id) THEN
        RAISE EXCEPTION 'Користувача з ID % не знайдено', v_user_id;
    END IF;
    
    -- Перевіряємо, чи вже є запис спроб
    SELECT id INTO v_existing_attempt
    FROM randomizer_attempts
    WHERE user_id = v_user_id
    AND (expires_at IS NULL OR expires_at >= NOW())
    ORDER BY purchase_date DESC
    LIMIT 1;
    
    IF v_existing_attempt IS NOT NULL THEN
        UPDATE randomizer_attempts
        SET total_attempts = total_attempts + v_attempts_count,
            updated_at = NOW()
        WHERE id = v_existing_attempt;
    ELSE
        INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
        VALUES (v_user_id, v_attempts_count, 0, NULL);
    END IF;
    
    RAISE NOTICE 'Успішно додано % спроб', v_attempts_count;
END $$;

-- =====================================================
-- 3. ДОДАТИ СПРОБИ ВСІМ КОРИСТУВАЧАМ ОДРАЗУ
-- =====================================================
-- Додає вказану кількість спроб всім користувачам

DO $$
DECLARE
    v_attempts_count INTEGER := 5; -- Кількість спроб для кожного користувача
    v_user_record RECORD;
    v_added_count INTEGER := 0;
BEGIN
    FOR v_user_record IN SELECT id FROM users LOOP
        -- Перевіряємо, чи вже є активний запис
        IF NOT EXISTS (
            SELECT 1 FROM randomizer_attempts 
            WHERE user_id = v_user_record.id 
            AND (expires_at IS NULL OR expires_at >= NOW())
        ) THEN
            -- Створюємо новий запис
            INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
            VALUES (v_user_record.id, v_attempts_count, 0, NULL);
            v_added_count := v_added_count + 1;
        ELSE
            -- Оновлюємо існуючий запис
            UPDATE randomizer_attempts
            SET total_attempts = total_attempts + v_attempts_count,
                updated_at = NOW()
            WHERE user_id = v_user_record.id
            AND (expires_at IS NULL OR expires_at >= NOW())
            ORDER BY purchase_date DESC
            LIMIT 1;
            v_added_count := v_added_count + 1;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Додано % спроб для % користувачів', v_attempts_count, v_added_count;
END $$;

-- =====================================================
-- 4. ПЕРЕВІРИТИ СПРОБИ КОРИСТУВАЧА
-- =====================================================
-- Перевіряє, скільки спроб має користувач

-- По email:
SELECT 
    u.email,
    u.first_name,
    u.last_name,
    COALESCE(SUM(ra.total_attempts), 0) as total_attempts,
    COALESCE(SUM(ra.used_attempts), 0) as used_attempts,
    COALESCE(SUM(ra.total_attempts - ra.used_attempts), 0) as remaining_attempts
FROM users u
LEFT JOIN randomizer_attempts ra ON u.id = ra.user_id
    AND (ra.expires_at IS NULL OR ra.expires_at >= NOW())
WHERE u.email = 'user@example.com' -- Замініть на email користувача
GROUP BY u.id, u.email, u.first_name, u.last_name;

-- По ID:
SELECT 
    u.email,
    u.first_name,
    u.last_name,
    COALESCE(SUM(ra.total_attempts), 0) as total_attempts,
    COALESCE(SUM(ra.used_attempts), 0) as used_attempts,
    COALESCE(SUM(ra.total_attempts - ra.used_attempts), 0) as remaining_attempts
FROM users u
LEFT JOIN randomizer_attempts ra ON u.id = ra.user_id
    AND (ra.expires_at IS NULL OR ra.expires_at >= NOW())
WHERE u.id = 'user-uuid-here' -- Замініть на UUID користувача
GROUP BY u.id, u.email, u.first_name, u.last_name;

-- =====================================================
-- 5. ПЕРЕГЛЯНУТИ ВСІХ КОРИСТУВАЧІВ З ЇХ СПРОБАМИ
-- =====================================================
SELECT 
    u.id,
    u.email,
    u.first_name,
    u.last_name,
    COALESCE(SUM(ra.total_attempts), 0) as total_attempts,
    COALESCE(SUM(ra.used_attempts), 0) as used_attempts,
    COALESCE(SUM(ra.total_attempts - ra.used_attempts), 0) as remaining_attempts,
    COUNT(ra.id) as attempts_records_count
FROM users u
LEFT JOIN randomizer_attempts ra ON u.id = ra.user_id
    AND (ra.expires_at IS NULL OR ra.expires_at >= NOW())
GROUP BY u.id, u.email, u.first_name, u.last_name
ORDER BY remaining_attempts DESC;

-- =====================================================
-- 6. СКИНУТИ ВИКОРИСТАНІ СПРОБИ (ОБНУЛИТИ USED_ATTEMPTS)
-- =====================================================
-- ОБЕРЕЖНО! Це скине всі використані спроби користувача

-- Для конкретного користувача по email:
UPDATE randomizer_attempts ra
SET used_attempts = 0,
    updated_at = NOW()
FROM users u
WHERE ra.user_id = u.id
AND u.email = 'user@example.com'; -- Замініть на email

-- Для конкретного користувача по ID:
UPDATE randomizer_attempts
SET used_attempts = 0,
    updated_at = NOW()
WHERE user_id = 'user-uuid-here'; -- Замініть на UUID

-- =====================================================
-- 7. ВСТАНОВИТИ ТОЧНУ КІЛЬКІСТЬ СПРОБ
-- =====================================================
-- Встановлює точну кількість спроб (замість додавання)

DO $$
DECLARE
    v_user_id UUID;
    v_total_attempts INTEGER := 20; -- Нова кількість спроб
    v_existing_attempt UUID;
BEGIN
    -- Знаходимо користувача
    SELECT id INTO v_user_id 
    FROM users 
    WHERE email = 'user@example.com'; -- Замініть на email
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Користувача не знайдено';
    END IF;
    
    -- Знаходимо активний запис
    SELECT id INTO v_existing_attempt
    FROM randomizer_attempts
    WHERE user_id = v_user_id
    AND (expires_at IS NULL OR expires_at >= NOW())
    ORDER BY purchase_date DESC
    LIMIT 1;
    
    IF v_existing_attempt IS NOT NULL THEN
        -- Оновлюємо існуючий запис
        UPDATE randomizer_attempts
        SET total_attempts = v_total_attempts,
            used_attempts = 0,
            updated_at = NOW()
        WHERE id = v_existing_attempt;
    ELSE
        -- Створюємо новий запис
        INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
        VALUES (v_user_id, v_total_attempts, 0, NULL);
    END IF;
    
    RAISE NOTICE 'Встановлено % спроб для користувача', v_total_attempts;
END $$;

-- =====================================================
-- 8. ПРОСТИЙ СПОСІБ - ПРЯМА ВСТАВКА (Якщо немає запису)
-- =====================================================
-- Найпростіший спосіб, якщо впевнені, що у користувача немає запису

-- Знайдіть ID користувача:
SELECT id, email FROM users WHERE email = 'user@example.com';

-- Потім вставте спроби (замініть 'user-uuid-here' на реальний UUID):
INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
VALUES ('user-uuid-here', 10, 0, NULL);

-- Або якщо користувач вже має запис, оновіть його:
UPDATE randomizer_attempts
SET total_attempts = total_attempts + 10,
    updated_at = NOW()
WHERE user_id = 'user-uuid-here';

-- =====================================================
-- 9. ДОДАТИ СПРОБИ З ТЕРМІНОМ ДІЇ
-- =====================================================
-- Додає спроби, які автоматично закінчаться через певний час

INSERT INTO randomizer_attempts (user_id, total_attempts, used_attempts, expires_at)
VALUES (
    'user-uuid-here', -- UUID користувача
    10, -- Кількість спроб
    0, -- Використані спроби
    NOW() + INTERVAL '30 days' -- Термін дії (30 днів)
);

-- =====================================================
-- 10. ВИДАЛИТИ СПРОБИ (Якщо потрібно)
-- =====================================================
-- Видалити всі спроби користувача:
DELETE FROM randomizer_attempts 
WHERE user_id = 'user-uuid-here';

-- Видалити тільки прострочені спроби:
DELETE FROM randomizer_attempts 
WHERE expires_at IS NOT NULL 
AND expires_at < NOW();

