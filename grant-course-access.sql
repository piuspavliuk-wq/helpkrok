-- SQL скрипт для надання доступу до курсу "Центральна нервова система"
-- Виконайте цей скрипт в SQL Editor в Supabase Dashboard
-- 
-- ІНСТРУКЦІЯ:
-- 1. Замініть 'EMAIL_КОРИСТУВАЧА' на реальний email дівчини
-- 2. Виконайте запит в SQL Editor в Supabase Dashboard

-- Спочатку перевіряємо чи існує таблиця course_access
-- Якщо таблиця не існує, створюємо її
CREATE TABLE IF NOT EXISTS course_access (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    course_id TEXT NOT NULL,
    access_granted BOOLEAN DEFAULT true,
    granted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    payment_id UUID REFERENCES payments(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, course_id)
);

-- Створюємо індекс для швидшого пошуку
CREATE INDEX IF NOT EXISTS idx_course_access_user_id ON course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_course_access_course_id ON course_access(course_id);

-- Функція для надання доступу (використовуйте цю функцію)
-- Замініть 'EMAIL_КОРИСТУВАЧА' на реальний email
DO $$
DECLARE
    user_email TEXT := 'EMAIL_КОРИСТУВАЧА'; -- ЗМІНІТЬ НА РЕАЛЬНИЙ EMAIL
    course_id TEXT := 'central-nervous-system';
    user_uuid UUID;
    existing_access UUID;
BEGIN
    -- Знаходимо користувача за email
    SELECT id INTO user_uuid
    FROM users
    WHERE email = user_email;
    
    IF user_uuid IS NULL THEN
        RAISE EXCEPTION 'Користувач з email % не знайдений', user_email;
    END IF;
    
    -- Перевіряємо чи вже є доступ
    SELECT id INTO existing_access
    FROM course_access
    WHERE user_id = user_uuid AND course_id = course_id;
    
    IF existing_access IS NOT NULL THEN
        RAISE NOTICE 'Доступ вже надано користувачу з email %', user_email;
    ELSE
        -- Створюємо доступ
        INSERT INTO course_access (user_id, course_id, access_granted, granted_at)
        VALUES (user_uuid, course_id, true, NOW());
        
        RAISE NOTICE 'Доступ успішно надано користувачу з email % до курсу %', user_email, course_id;
    END IF;
END $$;

-- АЛЬТЕРНАТИВНИЙ СПОСІБ (простіший, якщо ви знаєте user_id):
-- Замініть 'USER_ID' на UUID користувача
/*
INSERT INTO course_access (user_id, course_id, access_granted, granted_at)
VALUES (
    'USER_ID'::UUID,  -- ЗМІНІТЬ НА РЕАЛЬНИЙ USER_ID
    'central-nervous-system',
    true,
    NOW()
)
ON CONFLICT (user_id, course_id) DO NOTHING;
*/

-- Якщо таблиця course_access не існує, можна створити фіктивний платіж:
-- (Використовуйте тільки якщо таблиця course_access не існує)
/*
INSERT INTO payments (
    user_id,
    payment_type,
    package_id,
    status,
    amount,
    currency,
    description
)
SELECT 
    id,
    'course',
    'central-nervous-system',
    'success',
    0,
    'UAH',
    'Надано доступ за виграш курсу'
FROM users
WHERE email = 'EMAIL_КОРИСТУВАЧА'
ON CONFLICT DO NOTHING;
*/

