-- ПРОСТИЙ SQL ЗАПИТ для надання доступу до курсу
-- Виконайте в SQL Editor в Supabase Dashboard
--
-- ⚠️ ВАЖЛИВО: Спочатку виконайте КРОК 1 (створення таблиці), потім КРОК 2

-- КРОК 1: Створення таблиці course_access (виконайте спочатку!)
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

-- Створення індексів
CREATE INDEX IF NOT EXISTS idx_course_access_user_id ON course_access(user_id);
CREATE INDEX IF NOT EXISTS idx_course_access_course_id ON course_access(course_id);

-- КРОК 2: Надайте доступ (замініть EMAIL_КОРИСТУВАЧА на реальний email)
INSERT INTO course_access (user_id, course_id, access_granted, granted_at)
SELECT 
    id,
    'central-nervous-system',
    true,
    NOW()
FROM users
WHERE email = 'EMAIL_КОРИСТУВАЧА'  -- ЗАМІНІТЬ НА РЕАЛЬНИЙ EMAIL
ON CONFLICT (user_id, course_id) DO NOTHING;

-- Перевірка: подивитися чи доступ надано
SELECT 
    ca.id,
    u.email,
    u.first_name,
    u.last_name,
    ca.course_id,
    ca.access_granted,
    ca.granted_at
FROM course_access ca
JOIN users u ON u.id = ca.user_id
WHERE ca.course_id = 'central-nervous-system'
ORDER BY ca.granted_at DESC;