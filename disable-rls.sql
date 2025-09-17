-- Простий SQL код для тимчасового відключення RLS
-- Виконайте цей код в SQL Editor в Supabase Dashboard

-- Тимчасово відключаємо RLS для таблиці users
ALTER TABLE public.users DISABLE ROW LEVEL SECURITY;

-- Перевіряємо статус RLS
SELECT schemaname, tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'users';

-- Після тестування можна знову увімкнути RLS:
-- ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
