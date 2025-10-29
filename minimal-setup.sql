-- Мінімальний SQL скрипт тільки для реєстрації
-- Виконайте цей код в Supabase SQL Editor

-- ==============================================
-- 1. ДОДАВАННЯ КОЛОНКИ FACULTY ДО USERS
-- ==============================================

-- Додаємо колонку faculty до існуючої таблиці users
ALTER TABLE public.users 
ADD COLUMN IF NOT EXISTS faculty TEXT CHECK (faculty IN ('medical', 'pharmaceutical'));

-- Додаємо індекс для покращення продуктивності
CREATE INDEX IF NOT EXISTS idx_users_faculty ON public.users(faculty);

-- ==============================================
-- 2. ПЕРЕВІРКА РЕЗУЛЬТАТУ
-- ==============================================

-- Перевірка, що колонка faculty додана
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'users' 
    AND table_schema = 'public'
    AND column_name = 'faculty';

-- Перевірка всіх колонок таблиці users
SELECT 
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'users' 
    AND table_schema = 'public'
ORDER BY ordinal_position;
