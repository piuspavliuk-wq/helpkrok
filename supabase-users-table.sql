-- SQL код для створення таблиці users в Supabase
-- Виконайте цей код в SQL Editor в Supabase Dashboard

-- Створення таблиці users
CREATE TABLE IF NOT EXISTS public.users (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    faculty TEXT CHECK (faculty IN ('medical', 'pharmaceutical')),
    university TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Створення індексів для кращої продуктивності
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users(email);
CREATE INDEX IF NOT EXISTS idx_users_faculty ON public.users(faculty);
CREATE INDEX IF NOT EXISTS idx_users_university ON public.users(university);

-- Створення функції для автоматичного оновлення updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Створення тригера для автоматичного оновлення updated_at
DROP TRIGGER IF EXISTS update_users_updated_at ON public.users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Додавання коментарів до таблиці та колонок
COMMENT ON TABLE public.users IS 'Таблиця користувачів платформи Help Krok';
COMMENT ON COLUMN public.users.id IS 'Унікальний ідентифікатор користувача';
COMMENT ON COLUMN public.users.first_name IS 'Ім''я користувача';
COMMENT ON COLUMN public.users.last_name IS 'Прізвище користувача';
COMMENT ON COLUMN public.users.email IS 'Email адреса користувача (унікальна)';
COMMENT ON COLUMN public.users.faculty IS 'Факультет: medical або pharmaceutical';
COMMENT ON COLUMN public.users.university IS 'Назва університету';
COMMENT ON COLUMN public.users.created_at IS 'Дата створення запису';
COMMENT ON COLUMN public.users.updated_at IS 'Дата останнього оновлення запису';

-- Встановлення RLS (Row Level Security)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Створення політики RLS для користувачів
-- Користувачі можуть читати тільки свої дані
CREATE POLICY "Users can view own profile" ON public.users
    FOR SELECT USING (auth.uid()::text = id);

-- Користувачі можуть оновлювати тільки свої дані
CREATE POLICY "Users can update own profile" ON public.users
    FOR UPDATE USING (auth.uid()::text = id);

-- Користувачі можуть вставляти тільки свої дані
CREATE POLICY "Users can insert own profile" ON public.users
    FOR INSERT WITH CHECK (auth.uid()::text = id);

-- Перевірка створення таблиці
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'users' 
    AND table_schema = 'public'
ORDER BY ordinal_position;
