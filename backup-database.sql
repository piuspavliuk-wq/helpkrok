-- БЕК-АП БАЗИ ДАНИХ HELP KROK PLATFORM
-- Виконайте цей код в Supabase SQL Editor для створення повного бек-апу

-- ==============================================
-- 1. СТВОРЕННЯ ТАБЛИЦЬ
-- ==============================================

-- Таблиця користувачів
CREATE TABLE IF NOT EXISTS users_backup (
    id TEXT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    faculty TEXT CHECK (faculty IN ('medical', 'pharmaceutical')),
    university TEXT,
    role TEXT DEFAULT 'student',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Таблиця прогресу тестування
CREATE TABLE IF NOT EXISTS user_test_progress_backup (
    id SERIAL PRIMARY KEY,
    user_id TEXT NOT NULL,
    test_type VARCHAR(50) NOT NULL,
    question_id INTEGER NOT NULL,
    selected_answer VARCHAR(10),
    is_correct BOOLEAN,
    answered_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, test_type, question_id)
);

-- Таблиця статистики користувачів
CREATE TABLE IF NOT EXISTS user_statistics_backup (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT UNIQUE NOT NULL,
    total_questions_answered INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    incorrect_answers INTEGER DEFAULT 0,
    average_percentage DECIMAL(5,2) DEFAULT 0.0,
    ratio_percentage DECIMAL(5,2) DEFAULT 0.0,
    total_tests INTEGER DEFAULT 0,
    completed_tests INTEGER DEFAULT 0,
    last_calculated_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Таблиця тестових спроб
CREATE TABLE IF NOT EXISTS test_attempts_backup (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    topic_id TEXT,
    attempt_type VARCHAR(50) NOT NULL,
    total_questions INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    time_spent INTEGER NOT NULL,
    completed_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Таблиця токенів відновлення пароля
CREATE TABLE IF NOT EXISTS password_reset_tokens_backup (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Таблиця збережених питань
CREATE TABLE IF NOT EXISTS user_saved_questions_backup (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    test_type VARCHAR(50) NOT NULL,
    saved_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, question_id, test_type)
);

-- ==============================================
-- 2. ФУНКЦІЯ ДЛЯ СТВОРЕННЯ БЕК-АПУ
-- ==============================================

CREATE OR REPLACE FUNCTION create_database_backup()
RETURNS TEXT AS $$
DECLARE
    backup_timestamp TEXT;
    result_message TEXT := '';
BEGIN
    -- Генеруємо timestamp для бек-апу
    backup_timestamp := TO_CHAR(NOW(), 'YYYY-MM-DD_HH24-MI-SS');
    
    -- Очищуємо старі бек-апи (старіші за 7 днів)
    DELETE FROM users_backup WHERE created_at < NOW() - INTERVAL '7 days';
    DELETE FROM user_test_progress_backup WHERE created_at < NOW() - INTERVAL '7 days';
    DELETE FROM user_statistics_backup WHERE created_at < NOW() - INTERVAL '7 days';
    DELETE FROM test_attempts_backup WHERE created_at < NOW() - INTERVAL '7 days';
    DELETE FROM password_reset_tokens_backup WHERE created_at < NOW() - INTERVAL '7 days';
    DELETE FROM user_saved_questions_backup WHERE saved_at < NOW() - INTERVAL '7 days';
    
    -- Копіюємо дані з основних таблиць
    INSERT INTO users_backup (id, first_name, last_name, email, password, faculty, university, role, created_at, updated_at)
    SELECT id, first_name, last_name, email, password, faculty, university, role, created_at, updated_at
    FROM users
    ON CONFLICT (id) DO UPDATE SET
        first_name = EXCLUDED.first_name,
        last_name = EXCLUDED.last_name,
        email = EXCLUDED.email,
        password = EXCLUDED.password,
        faculty = EXCLUDED.faculty,
        university = EXCLUDED.university,
        role = EXCLUDED.role,
        updated_at = NOW();
    
    INSERT INTO user_test_progress_backup (user_id, test_type, question_id, selected_answer, is_correct, answered_at, created_at, updated_at)
    SELECT user_id, test_type, question_id, selected_answer, is_correct, answered_at, created_at, updated_at
    FROM user_test_progress
    ON CONFLICT (user_id, test_type, question_id) DO UPDATE SET
        selected_answer = EXCLUDED.selected_answer,
        is_correct = EXCLUDED.is_correct,
        answered_at = EXCLUDED.answered_at,
        updated_at = NOW();
    
    INSERT INTO user_statistics_backup (user_id, total_questions_answered, correct_answers, incorrect_answers, average_percentage, ratio_percentage, total_tests, completed_tests, last_calculated_at, created_at, updated_at)
    SELECT user_id, total_questions_answered, correct_answers, incorrect_answers, average_percentage, ratio_percentage, total_tests, completed_tests, last_calculated_at, created_at, updated_at
    FROM user_statistics
    ON CONFLICT (user_id) DO UPDATE SET
        total_questions_answered = EXCLUDED.total_questions_answered,
        correct_answers = EXCLUDED.correct_answers,
        incorrect_answers = EXCLUDED.incorrect_answers,
        average_percentage = EXCLUDED.average_percentage,
        ratio_percentage = EXCLUDED.ratio_percentage,
        total_tests = EXCLUDED.total_tests,
        completed_tests = EXCLUDED.completed_tests,
        last_calculated_at = EXCLUDED.last_calculated_at,
        updated_at = NOW();
    
    INSERT INTO test_attempts_backup (id, user_id, topic_id, attempt_type, total_questions, correct_answers, score, time_spent, completed_at, created_at)
    SELECT id, user_id, topic_id, attempt_type, total_questions, correct_answers, score, time_spent, completed_at, created_at
    FROM test_attempts
    ON CONFLICT (id) DO UPDATE SET
        user_id = EXCLUDED.user_id,
        topic_id = EXCLUDED.topic_id,
        attempt_type = EXCLUDED.attempt_type,
        total_questions = EXCLUDED.total_questions,
        correct_answers = EXCLUDED.correct_answers,
        score = EXCLUDED.score,
        time_spent = EXCLUDED.time_spent,
        completed_at = EXCLUDED.completed_at;
    
    INSERT INTO password_reset_tokens_backup (id, user_id, token, expires_at, used, created_at, updated_at)
    SELECT id, user_id, token, expires_at, used, created_at, updated_at
    FROM password_reset_tokens
    ON CONFLICT (id) DO UPDATE SET
        user_id = EXCLUDED.user_id,
        token = EXCLUDED.token,
        expires_at = EXCLUDED.expires_at,
        used = EXCLUDED.used,
        updated_at = NOW();
    
    -- Перевіряємо, чи існує таблиця user_saved_questions
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_saved_questions') THEN
        INSERT INTO user_saved_questions_backup (id, user_id, question_id, test_type, saved_at)
        SELECT id, user_id, question_id, test_type, saved_at
        FROM user_saved_questions
        ON CONFLICT (user_id, question_id, test_type) DO UPDATE SET
            saved_at = EXCLUDED.saved_at;
    END IF;
    
    result_message := 'Бек-ап створено успішно! Timestamp: ' || backup_timestamp;
    
    RETURN result_message;
END;
$$ LANGUAGE plpgsql;

-- ==============================================
-- 3. ФУНКЦІЯ ДЛЯ ВІДНОВЛЕННЯ З БЕК-АПУ
-- ==============================================

CREATE OR REPLACE FUNCTION restore_from_backup()
RETURNS TEXT AS $$
DECLARE
    result_message TEXT := '';
BEGIN
    -- Відновлюємо дані з бек-апу
    UPDATE users SET
        first_name = b.first_name,
        last_name = b.last_name,
        email = b.email,
        password = b.password,
        faculty = b.faculty,
        university = b.university,
        role = b.role,
        updated_at = NOW()
    FROM users_backup b
    WHERE users.id = b.id;
    
    -- Вставляємо нові записи, яких немає в основній таблиці
    INSERT INTO users (id, first_name, last_name, email, password, faculty, university, role, created_at, updated_at)
    SELECT id, first_name, last_name, email, password, faculty, university, role, created_at, updated_at
    FROM users_backup
    WHERE NOT EXISTS (SELECT 1 FROM users WHERE users.id = users_backup.id);
    
    -- Аналогічно для інших таблиць
    UPDATE user_test_progress SET
        selected_answer = b.selected_answer,
        is_correct = b.is_correct,
        answered_at = b.answered_at,
        updated_at = NOW()
    FROM user_test_progress_backup b
    WHERE user_test_progress.user_id = b.user_id 
      AND user_test_progress.test_type = b.test_type 
      AND user_test_progress.question_id = b.question_id;
    
    UPDATE user_statistics SET
        total_questions_answered = b.total_questions_answered,
        correct_answers = b.correct_answers,
        incorrect_answers = b.incorrect_answers,
        average_percentage = b.average_percentage,
        ratio_percentage = b.ratio_percentage,
        total_tests = b.total_tests,
        completed_tests = b.completed_tests,
        last_calculated_at = b.last_calculated_at,
        updated_at = NOW()
    FROM user_statistics_backup b
    WHERE user_statistics.user_id = b.user_id;
    
    result_message := 'Дані відновлено з бек-апу успішно!';
    
    RETURN result_message;
END;
$$ LANGUAGE plpgsql;

-- ==============================================
-- 4. ФУНКЦІЯ ДЛЯ ПЕРЕВІРКИ СТАТУСУ БЕК-АПУ
-- ==============================================

CREATE OR REPLACE FUNCTION check_backup_status()
RETURNS TABLE(
    table_name TEXT,
    main_count BIGINT,
    backup_count BIGINT,
    last_backup TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        'users'::TEXT as table_name,
        (SELECT COUNT(*) FROM users) as main_count,
        (SELECT COUNT(*) FROM users_backup) as backup_count,
        (SELECT MAX(created_at) FROM users_backup) as last_backup
    
    UNION ALL
    
    SELECT 
        'user_test_progress'::TEXT as table_name,
        (SELECT COUNT(*) FROM user_test_progress) as main_count,
        (SELECT COUNT(*) FROM user_test_progress_backup) as backup_count,
        (SELECT MAX(created_at) FROM user_test_progress_backup) as last_backup
    
    UNION ALL
    
    SELECT 
        'user_statistics'::TEXT as table_name,
        (SELECT COUNT(*) FROM user_statistics) as main_count,
        (SELECT COUNT(*) FROM user_statistics_backup) as backup_count,
        (SELECT MAX(created_at) FROM user_statistics_backup) as last_backup
    
    UNION ALL
    
    SELECT 
        'test_attempts'::TEXT as table_name,
        (SELECT COUNT(*) FROM test_attempts) as main_count,
        (SELECT COUNT(*) FROM test_attempts_backup) as backup_count,
        (SELECT MAX(created_at) FROM test_attempts_backup) as last_backup;
END;
$$ LANGUAGE plpgsql;

-- ==============================================
-- 5. ТЕСТУВАННЯ ФУНКЦІЙ
-- ==============================================

-- Створюємо бек-ап
SELECT create_database_backup();

-- Перевіряємо статус
SELECT * FROM check_backup_status();

SELECT 'Система бек-апу налаштована успішно!' as status;
