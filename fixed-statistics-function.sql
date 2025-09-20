-- Виправлена функція статистики, яка працює навіть якщо test_attempts не існує
-- Не чіпаємо user_test_progress - вона працює!

-- Спочатку створимо таблицю test_attempts (якщо не існує)
CREATE TABLE IF NOT EXISTS test_attempts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id TEXT NOT NULL,
    topic_id UUID,
    attempt_type VARCHAR(20) CHECK (attempt_type IN ('topic_test', 'krok_simulation', 'year_booklet')) NOT NULL,
    total_questions INTEGER NOT NULL DEFAULT 0,
    correct_answers INTEGER NOT NULL DEFAULT 0,
    score DECIMAL(5,2) NOT NULL DEFAULT 0,
    time_spent INTEGER NOT NULL DEFAULT 0,
    completed_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Створення таблиці статистики (якщо не існує)
CREATE TABLE IF NOT EXISTS user_statistics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id TEXT NOT NULL,
    
    -- Основна статистика
    total_questions_answered INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    incorrect_answers INTEGER DEFAULT 0,
    average_percentage DECIMAL(5,2) DEFAULT 0.0,
    ratio_percentage DECIMAL(5,2) DEFAULT 0.0,
    
    -- Статистика тестів
    total_tests INTEGER DEFAULT 0,
    completed_tests INTEGER DEFAULT 0,
    
    -- Статистика по предметах
    anatomy_correct INTEGER DEFAULT 0,
    anatomy_incorrect INTEGER DEFAULT 0,
    histology_correct INTEGER DEFAULT 0,
    histology_incorrect INTEGER DEFAULT 0,
    physiology_correct INTEGER DEFAULT 0,
    physiology_incorrect INTEGER DEFAULT 0,
    biochemistry_correct INTEGER DEFAULT 0,
    biochemistry_incorrect INTEGER DEFAULT 0,
    microbiology_correct INTEGER DEFAULT 0,
    microbiology_incorrect INTEGER DEFAULT 0,
    pathology_correct INTEGER DEFAULT 0,
    pathology_incorrect INTEGER DEFAULT 0,
    pathophysiology_correct INTEGER DEFAULT 0,
    pathophysiology_incorrect INTEGER DEFAULT 0,
    pharmacology_correct INTEGER DEFAULT 0,
    pharmacology_incorrect INTEGER DEFAULT 0,
    
    -- Метадані
    last_calculated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Унікальний індекс для користувача
    UNIQUE(user_id)
);

-- Виправлена функція розрахунку статистики (безпечна для test_attempts)
CREATE OR REPLACE FUNCTION calculate_user_statistics_safe(p_user_id TEXT)
RETURNS TABLE (
    total_questions_answered BIGINT,
    correct_answers BIGINT,
    incorrect_answers BIGINT,
    average_percentage DECIMAL(5,2),
    ratio_percentage DECIMAL(5,2),
    total_tests BIGINT,
    completed_tests BIGINT,
    anatomy_correct BIGINT,
    anatomy_incorrect BIGINT,
    histology_correct BIGINT,
    histology_incorrect BIGINT,
    physiology_correct BIGINT,
    physiology_incorrect BIGINT,
    biochemistry_correct BIGINT,
    biochemistry_incorrect BIGINT,
    microbiology_correct BIGINT,
    microbiology_incorrect BIGINT,
    pathology_correct BIGINT,
    pathology_incorrect BIGINT,
    pathophysiology_correct BIGINT,
    pathophysiology_incorrect BIGINT,
    pharmacology_correct BIGINT,
    pharmacology_incorrect BIGINT
) AS $$
BEGIN
    RETURN QUERY
    WITH progress_stats AS (
        -- Статистика з user_test_progress (не чіпаємо!)
        SELECT 
            COUNT(*) as total_answered,
            SUM(CASE WHEN is_correct THEN 1 ELSE 0 END) as correct,
            SUM(CASE WHEN NOT is_correct THEN 1 ELSE 0 END) as incorrect,
            -- Статистика по предметах
            SUM(CASE WHEN test_type = 'anatomy' AND is_correct THEN 1 ELSE 0 END) as anatomy_correct,
            SUM(CASE WHEN test_type = 'anatomy' AND NOT is_correct THEN 1 ELSE 0 END) as anatomy_incorrect,
            SUM(CASE WHEN test_type = 'histology' AND is_correct THEN 1 ELSE 0 END) as histology_correct,
            SUM(CASE WHEN test_type = 'histology' AND NOT is_correct THEN 1 ELSE 0 END) as histology_incorrect,
            SUM(CASE WHEN test_type = 'physiology' AND is_correct THEN 1 ELSE 0 END) as physiology_correct,
            SUM(CASE WHEN test_type = 'physiology' AND NOT is_correct THEN 1 ELSE 0 END) as physiology_incorrect,
            SUM(CASE WHEN test_type = 'biochemistry' AND is_correct THEN 1 ELSE 0 END) as biochemistry_correct,
            SUM(CASE WHEN test_type = 'biochemistry' AND NOT is_correct THEN 1 ELSE 0 END) as biochemistry_incorrect,
            SUM(CASE WHEN test_type = 'microbiology' AND is_correct THEN 1 ELSE 0 END) as microbiology_correct,
            SUM(CASE WHEN test_type = 'microbiology' AND NOT is_correct THEN 1 ELSE 0 END) as microbiology_incorrect,
            SUM(CASE WHEN test_type = 'pathology' AND is_correct THEN 1 ELSE 0 END) as pathology_correct,
            SUM(CASE WHEN test_type = 'pathology' AND NOT is_correct THEN 1 ELSE 0 END) as pathology_incorrect,
            SUM(CASE WHEN test_type = 'pathophysiology' AND is_correct THEN 1 ELSE 0 END) as pathophysiology_correct,
            SUM(CASE WHEN test_type = 'pathophysiology' AND NOT is_correct THEN 1 ELSE 0 END) as pathophysiology_incorrect,
            SUM(CASE WHEN test_type = 'pharmacology' AND is_correct THEN 1 ELSE 0 END) as pharmacology_correct,
            SUM(CASE WHEN test_type = 'pharmacology' AND NOT is_correct THEN 1 ELSE 0 END) as pharmacology_incorrect
        FROM user_test_progress 
        WHERE user_id = p_user_id
    ),
    test_stats AS (
        -- Безпечна перевірка існування таблиці test_attempts
        SELECT 
            COALESCE(COUNT(*), 0) as total_tests,
            COALESCE(SUM(CASE WHEN completed_at IS NOT NULL THEN 1 ELSE 0 END), 0) as completed_tests
        FROM test_attempts 
        WHERE user_id = p_user_id
        AND EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'test_attempts')
    )
    SELECT 
        COALESCE(ps.total_answered, 0)::BIGINT,
        COALESCE(ps.correct, 0)::BIGINT,
        COALESCE(ps.incorrect, 0)::BIGINT,
        CASE 
            WHEN ps.total_answered > 0 THEN 
                ROUND((ps.correct::DECIMAL / ps.total_answered) * 100, 2)
            ELSE 0.0
        END,
        CASE 
            WHEN ps.total_answered > 0 THEN 
                ROUND((ps.correct::DECIMAL / ps.total_answered) * 100, 2)
            ELSE 0.0
        END,
        COALESCE(ts.total_tests, 0)::BIGINT,
        COALESCE(ts.completed_tests, 0)::BIGINT,
        COALESCE(ps.anatomy_correct, 0)::BIGINT,
        COALESCE(ps.anatomy_incorrect, 0)::BIGINT,
        COALESCE(ps.histology_correct, 0)::BIGINT,
        COALESCE(ps.histology_incorrect, 0)::BIGINT,
        COALESCE(ps.physiology_correct, 0)::BIGINT,
        COALESCE(ps.physiology_incorrect, 0)::BIGINT,
        COALESCE(ps.biochemistry_correct, 0)::BIGINT,
        COALESCE(ps.biochemistry_incorrect, 0)::BIGINT,
        COALESCE(ps.microbiology_correct, 0)::BIGINT,
        COALESCE(ps.microbiology_incorrect, 0)::BIGINT,
        COALESCE(ps.pathology_correct, 0)::BIGINT,
        COALESCE(ps.pathology_incorrect, 0)::BIGINT,
        COALESCE(ps.pathophysiology_correct, 0)::BIGINT,
        COALESCE(ps.pathophysiology_incorrect, 0)::BIGINT,
        COALESCE(ps.pharmacology_correct, 0)::BIGINT,
        COALESCE(ps.pharmacology_incorrect, 0)::BIGINT
    FROM progress_stats ps
    CROSS JOIN test_stats ts;
END;
$$ LANGUAGE plpgsql;

-- Виправлена функція оновлення статистики
CREATE OR REPLACE FUNCTION update_user_statistics_safe(p_user_id TEXT)
RETURNS VOID AS $$
DECLARE
    stats RECORD;
BEGIN
    -- Розраховуємо статистику
    SELECT * INTO stats FROM calculate_user_statistics_safe(p_user_id);
    
    -- Вставляємо або оновлюємо статистику
    INSERT INTO user_statistics (
        user_id,
        total_questions_answered,
        correct_answers,
        incorrect_answers,
        average_percentage,
        ratio_percentage,
        total_tests,
        completed_tests,
        anatomy_correct,
        anatomy_incorrect,
        histology_correct,
        histology_incorrect,
        physiology_correct,
        physiology_incorrect,
        biochemistry_correct,
        biochemistry_incorrect,
        microbiology_correct,
        microbiology_incorrect,
        pathology_correct,
        pathology_incorrect,
        pathophysiology_correct,
        pathophysiology_incorrect,
        pharmacology_correct,
        pharmacology_incorrect,
        last_calculated_at,
        updated_at
    ) VALUES (
        p_user_id,
        stats.total_questions_answered,
        stats.correct_answers,
        stats.incorrect_answers,
        stats.average_percentage,
        stats.ratio_percentage,
        stats.total_tests,
        stats.completed_tests,
        stats.anatomy_correct,
        stats.anatomy_incorrect,
        stats.histology_correct,
        stats.histology_incorrect,
        stats.physiology_correct,
        stats.physiology_incorrect,
        stats.biochemistry_correct,
        stats.biochemistry_incorrect,
        stats.microbiology_correct,
        stats.microbiology_incorrect,
        stats.pathology_correct,
        stats.pathology_incorrect,
        stats.pathophysiology_correct,
        stats.pathophysiology_incorrect,
        stats.pharmacology_correct,
        stats.pharmacology_incorrect,
        NOW(),
        NOW()
    )
    ON CONFLICT (user_id) DO UPDATE SET
        total_questions_answered = EXCLUDED.total_questions_answered,
        correct_answers = EXCLUDED.correct_answers,
        incorrect_answers = EXCLUDED.incorrect_answers,
        average_percentage = EXCLUDED.average_percentage,
        ratio_percentage = EXCLUDED.ratio_percentage,
        total_tests = EXCLUDED.total_tests,
        completed_tests = EXCLUDED.completed_tests,
        anatomy_correct = EXCLUDED.anatomy_correct,
        anatomy_incorrect = EXCLUDED.anatomy_incorrect,
        histology_correct = EXCLUDED.histology_correct,
        histology_incorrect = EXCLUDED.histology_incorrect,
        physiology_correct = EXCLUDED.physiology_correct,
        physiology_incorrect = EXCLUDED.physiology_incorrect,
        biochemistry_correct = EXCLUDED.biochemistry_correct,
        biochemistry_incorrect = EXCLUDED.biochemistry_incorrect,
        microbiology_correct = EXCLUDED.microbiology_correct,
        microbiology_incorrect = EXCLUDED.microbiology_incorrect,
        pathology_correct = EXCLUDED.pathology_correct,
        pathology_incorrect = EXCLUDED.pathology_incorrect,
        pathophysiology_correct = EXCLUDED.pathophysiology_correct,
        pathophysiology_incorrect = EXCLUDED.pathophysiology_incorrect,
        pharmacology_correct = EXCLUDED.pharmacology_correct,
        pharmacology_incorrect = EXCLUDED.pharmacology_incorrect,
        last_calculated_at = EXCLUDED.last_calculated_at,
        updated_at = EXCLUDED.updated_at;
END;
$$ LANGUAGE plpgsql;

-- Безпечний тригер (тільки для user_test_progress)
CREATE OR REPLACE FUNCTION trigger_update_user_statistics_safe()
RETURNS TRIGGER AS $$
BEGIN
    -- Оновлюємо статистику для користувача
    PERFORM update_user_statistics_safe(NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Тригер тільки для user_test_progress (не чіпаємо!)
DROP TRIGGER IF EXISTS trg_update_statistics_on_progress ON user_test_progress;
CREATE TRIGGER trg_update_statistics_on_progress
    AFTER INSERT OR UPDATE OR DELETE ON user_test_progress
    FOR EACH ROW
    EXECUTE FUNCTION trigger_update_user_statistics_safe();

-- Індекси
CREATE INDEX IF NOT EXISTS idx_user_statistics_user_id ON user_statistics(user_id);
CREATE INDEX IF NOT EXISTS idx_test_attempts_user_id ON test_attempts(user_id);

-- Перевірка
SELECT 'Система статистики створена безпечно! user_test_progress не чіпали!' as status;
