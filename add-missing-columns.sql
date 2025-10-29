-- SQL скрипт для додавання необхідних колонок до існуючих таблиць
-- Виконайте цей код в Supabase SQL Editor

-- ==============================================
-- 1. ДОДАВАННЯ КОЛОНКИ FACULTY ДО USERS
-- ==============================================

-- Додаємо колонку faculty до таблиці users
ALTER TABLE public.users 
ADD COLUMN IF NOT EXISTS faculty TEXT CHECK (faculty IN ('medical', 'pharmaceutical'));

-- Додаємо індекс для покращення продуктивності
CREATE INDEX IF NOT EXISTS idx_users_faculty ON public.users(faculty);

-- ==============================================
-- 2. СТВОРЕННЯ ТАБЛИЦІ USER_STATISTICS (якщо не існує)
-- ==============================================

CREATE TABLE IF NOT EXISTS public.user_statistics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    correct_answers INTEGER DEFAULT 0,
    completed_tests INTEGER DEFAULT 0,
    average_percentage DECIMAL(5,2) DEFAULT 0.0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Додаємо індекс
CREATE INDEX IF NOT EXISTS idx_user_statistics_user_id ON public.user_statistics(user_id);

-- ==============================================
-- 3. СТВОРЕННЯ ТАБЛИЦІ USER_RATINGS (якщо не існує)
-- ==============================================

CREATE TABLE IF NOT EXISTS public.user_ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    total_points INTEGER DEFAULT 0,
    rank INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Додаємо індекси
CREATE INDEX IF NOT EXISTS idx_user_ratings_user_id ON public.user_ratings(user_id);
CREATE INDEX IF NOT EXISTS idx_user_ratings_total_points ON public.user_ratings(total_points DESC);

-- ==============================================
-- 4. СТВОРЕННЯ ТАБЛИЦІ ACHIEVEMENTS (якщо не існує)
-- ==============================================

CREATE TABLE IF NOT EXISTS public.achievements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    points INTEGER DEFAULT 0,
    icon TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================
-- 5. СТВОРЕННЯ ТАБЛИЦІ USER_ACHIEVEMENTS (якщо не існує)
-- ==============================================

CREATE TABLE IF NOT EXISTS public.user_achievements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    achievement_id UUID REFERENCES public.achievements(id) ON DELETE CASCADE,
    earned_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, achievement_id)
);

-- ==============================================
-- 6. СТВОРЕННЯ ТАБЛИЦІ TEST_ATTEMPTS (якщо не існує)
-- ==============================================

CREATE TABLE IF NOT EXISTS public.test_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    topic_id UUID,
    attempt_type TEXT,
    total_questions INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    score DECIMAL(5,2) DEFAULT 0.0,
    time_spent INTEGER DEFAULT 0,
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Додаємо індекси
CREATE INDEX IF NOT EXISTS idx_test_attempts_user_id ON public.test_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_test_attempts_attempt_type ON public.test_attempts(attempt_type);

-- ==============================================
-- 7. СТВОРЕННЯ ФУНКЦІЇ ДЛЯ АВТОМАТИЧНОГО ОНОВЛЕННЯ UPDATED_AT
-- ==============================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- ==============================================
-- 8. СТВОРЕННЯ ТРИГЕРІВ ДЛЯ АВТОМАТИЧНОГО ОНОВЛЕННЯ
-- ==============================================

-- Тригер для users
DROP TRIGGER IF EXISTS update_users_updated_at ON public.users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Тригер для user_statistics
DROP TRIGGER IF EXISTS update_user_statistics_updated_at ON public.user_statistics;
CREATE TRIGGER update_user_statistics_updated_at
    BEFORE UPDATE ON public.user_statistics
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Тригер для user_ratings
DROP TRIGGER IF EXISTS update_user_ratings_updated_at ON public.user_ratings;
CREATE TRIGGER update_user_ratings_updated_at
    BEFORE UPDATE ON public.user_ratings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Тригер для achievements
DROP TRIGGER IF EXISTS update_achievements_updated_at ON public.achievements;
CREATE TRIGGER update_achievements_updated_at
    BEFORE UPDATE ON public.achievements
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ==============================================
-- 9. ВСТАНОВЛЕННЯ RLS (ROW LEVEL SECURITY)
-- ==============================================

-- RLS для users
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Політики для users
DROP POLICY IF EXISTS "Users can view own profile" ON public.users;
CREATE POLICY "Users can view own profile" ON public.users
    FOR SELECT USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can update own profile" ON public.users;
CREATE POLICY "Users can update own profile" ON public.users
    FOR UPDATE USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can insert own profile" ON public.users;
CREATE POLICY "Users can insert own profile" ON public.users
    FOR INSERT WITH CHECK (auth.uid() = id);

-- RLS для user_statistics
ALTER TABLE public.user_statistics ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own statistics" ON public.user_statistics;
CREATE POLICY "Users can view own statistics" ON public.user_statistics
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update own statistics" ON public.user_statistics;
CREATE POLICY "Users can update own statistics" ON public.user_statistics
    FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own statistics" ON public.user_statistics;
CREATE POLICY "Users can insert own statistics" ON public.user_statistics
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- RLS для user_ratings
ALTER TABLE public.user_ratings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own ratings" ON public.user_ratings;
CREATE POLICY "Users can view own ratings" ON public.user_ratings
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update own ratings" ON public.user_ratings;
CREATE POLICY "Users can update own ratings" ON public.user_ratings
    FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own ratings" ON public.user_ratings;
CREATE POLICY "Users can insert own ratings" ON public.user_ratings
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- RLS для user_achievements
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own achievements" ON public.user_achievements;
CREATE POLICY "Users can view own achievements" ON public.user_achievements
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own achievements" ON public.user_achievements;
CREATE POLICY "Users can insert own achievements" ON public.user_achievements
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- RLS для test_attempts
ALTER TABLE public.test_attempts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own test attempts" ON public.test_attempts;
CREATE POLICY "Users can view own test attempts" ON public.test_attempts
    FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own test attempts" ON public.test_attempts;
CREATE POLICY "Users can insert own test attempts" ON public.test_attempts
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ==============================================
-- 10. ВСТАВЛЕННЯ БАЗОВИХ ДОСЯГНЕНЬ
-- ==============================================

INSERT INTO public.achievements (title, description, points, icon) VALUES
('Перший крок', 'Пройдіть свій перший тест', 50, '🎯'),
('Тиждень навчання', 'Навчайтеся 7 днів поспіль', 75, '📅'),
('Ідеальний результат', 'Отримайте 100% в тесті', 100, '⭐'),
('Досвідчений', 'Пройдіть 10 тестів', 100, '🏆'),
('Тисячник', 'Наберіть 1000 очок', 150, '💎')
ON CONFLICT DO NOTHING;

-- ==============================================
-- 11. ПЕРЕВІРКА РЕЗУЛЬТАТУ
-- ==============================================

-- Перевірка структури таблиці users
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'users' 
    AND table_schema = 'public'
ORDER BY ordinal_position;

-- Перевірка створених таблиць
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
    AND table_name IN (
        'users', 'user_statistics', 'user_ratings', 
        'achievements', 'user_achievements', 'test_attempts'
    )
ORDER BY table_name;
