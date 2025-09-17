-- SQL код для створення нової таблиці users в Supabase
-- Виконайте цей код в SQL Editor в Supabase Dashboard

-- Спочатку видаляємо стару таблицю (якщо існує)
DROP TABLE IF EXISTS public.users CASCADE;

-- Створюємо нову таблицю users
CREATE TABLE public.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Створюємо індекси для кращої продуктивності
CREATE INDEX idx_users_email ON public.users(email);
CREATE INDEX idx_users_created_at ON public.users(created_at);

-- Створюємо функцію для автоматичного оновлення updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Створюємо тригер для автоматичного оновлення updated_at
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Встановлюємо RLS (Row Level Security)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Створюємо політики RLS для дозволу всіх операцій (для реєстрації)
CREATE POLICY "Allow all operations on users" ON public.users
    FOR ALL USING (true) WITH CHECK (true);

-- Додаємо коментарі до таблиці та колонок
COMMENT ON TABLE public.users IS 'Таблиця користувачів платформи Help Krok';
COMMENT ON COLUMN public.users.id IS 'Унікальний ідентифікатор користувача';
COMMENT ON COLUMN public.users.first_name IS 'Ім''я користувача';
COMMENT ON COLUMN public.users.last_name IS 'Прізвище користувача';
COMMENT ON COLUMN public.users.email IS 'Email адреса користувача (унікальна)';
COMMENT ON COLUMN public.users.password IS 'Хешований пароль користувача';
COMMENT ON COLUMN public.users.created_at IS 'Дата створення запису';
COMMENT ON COLUMN public.users.updated_at IS 'Дата останнього оновлення запису';

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
