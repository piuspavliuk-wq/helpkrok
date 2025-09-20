-- Крок 1: Створення таблиці для питань з фізіології
CREATE TABLE IF NOT EXISTS physiology_questions (
    id BIGSERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    option_e TEXT NOT NULL,
    correct_answer CHAR(1) DEFAULT 'A',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Відключення RLS для імпорту (опціонально)
-- ALTER TABLE physiology_questions DISABLE ROW LEVEL SECURITY;

-- Перевірка створення таблиці
SELECT 'Table created successfully' as status;
