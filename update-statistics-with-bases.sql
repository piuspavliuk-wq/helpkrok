-- Оновлення системи статистики для показу динамічної статистики по базах
-- Додаємо підтримку всіх баз (предметів) медичного факультету

-- Оновлюємо функцію розрахунку статистики для всіх баз
CREATE OR REPLACE FUNCTION calculate_user_statistics_with_bases(p_user_id TEXT)
RETURNS TABLE (
    total_questions_answered BIGINT,
    correct_answers BIGINT,
    incorrect_answers BIGINT,
    average_percentage DECIMAL(5,2),
    ratio_percentage DECIMAL(5,2),
    total_tests BIGINT,
    completed_tests BIGINT,
    -- Статистика по базах (предметах)
    anatomy_correct BIGINT,
    anatomy_incorrect BIGINT,
    anatomy_total BIGINT,
    histology_correct BIGINT,
    histology_incorrect BIGINT,
    histology_total BIGINT,
    physiology_correct BIGINT,
    physiology_incorrect BIGINT,
    physiology_total BIGINT,
    biochemistry_correct BIGINT,
    biochemistry_incorrect BIGINT,
    biochemistry_total BIGINT,
    microbiology_correct BIGINT,
    microbiology_incorrect BIGINT,
    microbiology_total BIGINT,
    pathology_correct BIGINT,
    pathology_incorrect BIGINT,
    pathology_total BIGINT,
    pathophysiology_correct BIGINT,
    pathophysiology_incorrect BIGINT,
    pathophysiology_total BIGINT,
    pharmacology_correct BIGINT,
    pharmacology_incorrect BIGINT,
    pharmacology_total BIGINT,
    biology_correct BIGINT,
    biology_incorrect BIGINT,
    biology_total BIGINT
) AS $$
BEGIN
    RETURN QUERY
    WITH progress_stats AS (
        -- Статистика з user_test_progress по всіх базах
        SELECT 
            COUNT(*) as total_answered,
            SUM(CASE WHEN is_correct THEN 1 ELSE 0 END) as correct,
            SUM(CASE WHEN NOT is_correct THEN 1 ELSE 0 END) as incorrect,
            
            -- Анатомія
            SUM(CASE WHEN test_type = 'anatomy' AND is_correct THEN 1 ELSE 0 END) as anatomy_correct,
            SUM(CASE WHEN test_type = 'anatomy' AND NOT is_correct THEN 1 ELSE 0 END) as anatomy_incorrect,
            SUM(CASE WHEN test_type = 'anatomy' THEN 1 ELSE 0 END) as anatomy_total,
            
            -- Гістологія
            SUM(CASE WHEN test_type = 'histology' AND is_correct THEN 1 ELSE 0 END) as histology_correct,
            SUM(CASE WHEN test_type = 'histology' AND NOT is_correct THEN 1 ELSE 0 END) as histology_incorrect,
            SUM(CASE WHEN test_type = 'histology' THEN 1 ELSE 0 END) as histology_total,
            
            -- Фізіологія
            SUM(CASE WHEN test_type = 'physiology' AND is_correct THEN 1 ELSE 0 END) as physiology_correct,
            SUM(CASE WHEN test_type = 'physiology' AND NOT is_correct THEN 1 ELSE 0 END) as physiology_incorrect,
            SUM(CASE WHEN test_type = 'physiology' THEN 1 ELSE 0 END) as physiology_total,
            
            -- Біохімія
            SUM(CASE WHEN test_type = 'biochemistry' AND is_correct THEN 1 ELSE 0 END) as biochemistry_correct,
            SUM(CASE WHEN test_type = 'biochemistry' AND NOT is_correct THEN 1 ELSE 0 END) as biochemistry_incorrect,
            SUM(CASE WHEN test_type = 'biochemistry' THEN 1 ELSE 0 END) as biochemistry_total,
            
            -- Мікробіологія
            SUM(CASE WHEN test_type = 'microbiology' AND is_correct THEN 1 ELSE 0 END) as microbiology_correct,
            SUM(CASE WHEN test_type = 'microbiology' AND NOT is_correct THEN 1 ELSE 0 END) as microbiology_incorrect,
            SUM(CASE WHEN test_type = 'microbiology' THEN 1 ELSE 0 END) as microbiology_total,
            
            -- Патологія
            SUM(CASE WHEN test_type = 'pathology' AND is_correct THEN 1 ELSE 0 END) as pathology_correct,
            SUM(CASE WHEN test_type = 'pathology' AND NOT is_correct THEN 1 ELSE 0 END) as pathology_incorrect,
            SUM(CASE WHEN test_type = 'pathology' THEN 1 ELSE 0 END) as pathology_total,
            
            -- Патофізіологія
            SUM(CASE WHEN test_type = 'pathophysiology' AND is_correct THEN 1 ELSE 0 END) as pathophysiology_correct,
            SUM(CASE WHEN test_type = 'pathophysiology' AND NOT is_correct THEN 1 ELSE 0 END) as pathophysiology_incorrect,
            SUM(CASE WHEN test_type = 'pathophysiology' THEN 1 ELSE 0 END) as pathophysiology_total,
            
            -- Фармакологія
            SUM(CASE WHEN test_type = 'pharmacology' AND is_correct THEN 1 ELSE 0 END) as pharmacology_correct,
            SUM(CASE WHEN test_type = 'pharmacology' AND NOT is_correct THEN 1 ELSE 0 END) as pharmacology_incorrect,
            SUM(CASE WHEN test_type = 'pharmacology' THEN 1 ELSE 0 END) as pharmacology_total,
            
            -- Біологія
            SUM(CASE WHEN test_type = 'biology' AND is_correct THEN 1 ELSE 0 END) as biology_correct,
            SUM(CASE WHEN test_type = 'biology' AND NOT is_correct THEN 1 ELSE 0 END) as biology_incorrect,
            SUM(CASE WHEN test_type = 'biology' THEN 1 ELSE 0 END) as biology_total
            
        FROM user_test_progress 
        WHERE user_id = p_user_id
    ),
    test_stats AS (
        -- Статистика з test_attempts (безпечна перевірка)
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
        
        -- Статистика по базах
        COALESCE(ps.anatomy_correct, 0)::BIGINT,
        COALESCE(ps.anatomy_incorrect, 0)::BIGINT,
        COALESCE(ps.anatomy_total, 0)::BIGINT,
        COALESCE(ps.histology_correct, 0)::BIGINT,
        COALESCE(ps.histology_incorrect, 0)::BIGINT,
        COALESCE(ps.histology_total, 0)::BIGINT,
        COALESCE(ps.physiology_correct, 0)::BIGINT,
        COALESCE(ps.physiology_incorrect, 0)::BIGINT,
        COALESCE(ps.physiology_total, 0)::BIGINT,
        COALESCE(ps.biochemistry_correct, 0)::BIGINT,
        COALESCE(ps.biochemistry_incorrect, 0)::BIGINT,
        COALESCE(ps.biochemistry_total, 0)::BIGINT,
        COALESCE(ps.microbiology_correct, 0)::BIGINT,
        COALESCE(ps.microbiology_incorrect, 0)::BIGINT,
        COALESCE(ps.microbiology_total, 0)::BIGINT,
        COALESCE(ps.pathology_correct, 0)::BIGINT,
        COALESCE(ps.pathology_incorrect, 0)::BIGINT,
        COALESCE(ps.pathology_total, 0)::BIGINT,
        COALESCE(ps.pathophysiology_correct, 0)::BIGINT,
        COALESCE(ps.pathophysiology_incorrect, 0)::BIGINT,
        COALESCE(ps.pathophysiology_total, 0)::BIGINT,
        COALESCE(ps.pharmacology_correct, 0)::BIGINT,
        COALESCE(ps.pharmacology_incorrect, 0)::BIGINT,
        COALESCE(ps.pharmacology_total, 0)::BIGINT,
        COALESCE(ps.biology_correct, 0)::BIGINT,
        COALESCE(ps.biology_incorrect, 0)::BIGINT,
        COALESCE(ps.biology_total, 0)::BIGINT
    FROM progress_stats ps
    CROSS JOIN test_stats ts;
END;
$$ LANGUAGE plpgsql;

-- Оновлюємо таблицю статистики для підтримки всіх баз
ALTER TABLE user_statistics 
ADD COLUMN IF NOT EXISTS anatomy_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS histology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS physiology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS biochemistry_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS microbiology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS pathology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS pathophysiology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS pharmacology_total INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS biology_total INTEGER DEFAULT 0;

-- Оновлюємо функцію оновлення статистики
CREATE OR REPLACE FUNCTION update_user_statistics_with_bases(p_user_id TEXT)
RETURNS VOID AS $$
DECLARE
    stats RECORD;
BEGIN
    -- Розраховуємо статистику
    SELECT * INTO stats FROM calculate_user_statistics_with_bases(p_user_id);
    
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
        anatomy_total,
        histology_correct,
        histology_incorrect,
        histology_total,
        physiology_correct,
        physiology_incorrect,
        physiology_total,
        biochemistry_correct,
        biochemistry_incorrect,
        biochemistry_total,
        microbiology_correct,
        microbiology_incorrect,
        microbiology_total,
        pathology_correct,
        pathology_incorrect,
        pathology_total,
        pathophysiology_correct,
        pathophysiology_incorrect,
        pathophysiology_total,
        pharmacology_correct,
        pharmacology_incorrect,
        pharmacology_total,
        biology_correct,
        biology_incorrect,
        biology_total,
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
        stats.anatomy_total,
        stats.histology_correct,
        stats.histology_incorrect,
        stats.histology_total,
        stats.physiology_correct,
        stats.physiology_incorrect,
        stats.physiology_total,
        stats.biochemistry_correct,
        stats.biochemistry_incorrect,
        stats.biochemistry_total,
        stats.microbiology_correct,
        stats.microbiology_incorrect,
        stats.microbiology_total,
        stats.pathology_correct,
        stats.pathology_incorrect,
        stats.pathology_total,
        stats.pathophysiology_correct,
        stats.pathophysiology_incorrect,
        stats.pathophysiology_total,
        stats.pharmacology_correct,
        stats.pharmacology_incorrect,
        stats.pharmacology_total,
        stats.biology_correct,
        stats.biology_incorrect,
        stats.biology_total,
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
        anatomy_total = EXCLUDED.anatomy_total,
        histology_correct = EXCLUDED.histology_correct,
        histology_incorrect = EXCLUDED.histology_incorrect,
        histology_total = EXCLUDED.histology_total,
        physiology_correct = EXCLUDED.physiology_correct,
        physiology_incorrect = EXCLUDED.physiology_incorrect,
        physiology_total = EXCLUDED.physiology_total,
        biochemistry_correct = EXCLUDED.biochemistry_correct,
        biochemistry_incorrect = EXCLUDED.biochemistry_incorrect,
        biochemistry_total = EXCLUDED.biochemistry_total,
        microbiology_correct = EXCLUDED.microbiology_correct,
        microbiology_incorrect = EXCLUDED.microbiology_incorrect,
        microbiology_total = EXCLUDED.microbiology_total,
        pathology_correct = EXCLUDED.pathology_correct,
        pathology_incorrect = EXCLUDED.pathology_incorrect,
        pathology_total = EXCLUDED.pathology_total,
        pathophysiology_correct = EXCLUDED.pathophysiology_correct,
        pathophysiology_incorrect = EXCLUDED.pathophysiology_incorrect,
        pathophysiology_total = EXCLUDED.pathophysiology_total,
        pharmacology_correct = EXCLUDED.pharmacology_correct,
        pharmacology_incorrect = EXCLUDED.pharmacology_incorrect,
        pharmacology_total = EXCLUDED.pharmacology_total,
        biology_correct = EXCLUDED.biology_correct,
        biology_incorrect = EXCLUDED.biology_incorrect,
        biology_total = EXCLUDED.biology_total,
        last_calculated_at = EXCLUDED.last_calculated_at,
        updated_at = EXCLUDED.updated_at;
END;
$$ LANGUAGE plpgsql;

-- Оновлюємо тригер для використання нової функції
CREATE OR REPLACE FUNCTION trigger_update_user_statistics_with_bases()
RETURNS TRIGGER AS $$
BEGIN
    -- Оновлюємо статистику для користувача
    PERFORM update_user_statistics_with_bases(NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Оновлюємо тригер
DROP TRIGGER IF EXISTS trg_update_statistics_on_progress ON user_test_progress;
CREATE TRIGGER trg_update_statistics_on_progress
    AFTER INSERT OR UPDATE OR DELETE ON user_test_progress
    FOR EACH ROW
    EXECUTE FUNCTION trigger_update_user_statistics_with_bases();

-- Функція для отримання статистики по базах
CREATE OR REPLACE FUNCTION get_user_bases_statistics(p_user_id TEXT)
RETURNS TABLE (
    base_name TEXT,
    base_title TEXT,
    total_questions BIGINT,
    correct_answers BIGINT,
    incorrect_answers BIGINT,
    percentage DECIMAL(5,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        'anatomy'::TEXT as base_name,
        'Анатомія'::TEXT as base_title,
        us.anatomy_total::BIGINT,
        us.anatomy_correct::BIGINT,
        us.anatomy_incorrect::BIGINT,
        CASE 
            WHEN us.anatomy_total > 0 THEN 
                ROUND((us.anatomy_correct::DECIMAL / us.anatomy_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'histology'::TEXT,
        'Гістологія'::TEXT,
        us.histology_total::BIGINT,
        us.histology_correct::BIGINT,
        us.histology_incorrect::BIGINT,
        CASE 
            WHEN us.histology_total > 0 THEN 
                ROUND((us.histology_correct::DECIMAL / us.histology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'physiology'::TEXT,
        'Фізіологія'::TEXT,
        us.physiology_total::BIGINT,
        us.physiology_correct::BIGINT,
        us.physiology_incorrect::BIGINT,
        CASE 
            WHEN us.physiology_total > 0 THEN 
                ROUND((us.physiology_correct::DECIMAL / us.physiology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'biochemistry'::TEXT,
        'Біохімія'::TEXT,
        us.biochemistry_total::BIGINT,
        us.biochemistry_correct::BIGINT,
        us.biochemistry_incorrect::BIGINT,
        CASE 
            WHEN us.biochemistry_total > 0 THEN 
                ROUND((us.biochemistry_correct::DECIMAL / us.biochemistry_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'microbiology'::TEXT,
        'Мікробіологія'::TEXT,
        us.microbiology_total::BIGINT,
        us.microbiology_correct::BIGINT,
        us.microbiology_incorrect::BIGINT,
        CASE 
            WHEN us.microbiology_total > 0 THEN 
                ROUND((us.microbiology_correct::DECIMAL / us.microbiology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'pathology'::TEXT,
        'Патологія'::TEXT,
        us.pathology_total::BIGINT,
        us.pathology_correct::BIGINT,
        us.pathology_incorrect::BIGINT,
        CASE 
            WHEN us.pathology_total > 0 THEN 
                ROUND((us.pathology_correct::DECIMAL / us.pathology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'pathophysiology'::TEXT,
        'Патологічна фізіологія'::TEXT,
        us.pathophysiology_total::BIGINT,
        us.pathophysiology_correct::BIGINT,
        us.pathophysiology_incorrect::BIGINT,
        CASE 
            WHEN us.pathophysiology_total > 0 THEN 
                ROUND((us.pathophysiology_correct::DECIMAL / us.pathophysiology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'pharmacology'::TEXT,
        'Фармакологія'::TEXT,
        us.pharmacology_total::BIGINT,
        us.pharmacology_correct::BIGINT,
        us.pharmacology_incorrect::BIGINT,
        CASE 
            WHEN us.pharmacology_total > 0 THEN 
                ROUND((us.pharmacology_correct::DECIMAL / us.pharmacology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    UNION ALL
    
    SELECT 
        'biology'::TEXT,
        'Біологія'::TEXT,
        us.biology_total::BIGINT,
        us.biology_correct::BIGINT,
        us.biology_incorrect::BIGINT,
        CASE 
            WHEN us.biology_total > 0 THEN 
                ROUND((us.biology_correct::DECIMAL / us.biology_total) * 100, 2)
            ELSE 0.0
        END
    FROM user_statistics us
    WHERE us.user_id = p_user_id
    
    ORDER BY total_questions DESC;
END;
$$ LANGUAGE plpgsql;

-- Перевірка
SELECT 'Система статистики по базах оновлена успішно!' as status;
