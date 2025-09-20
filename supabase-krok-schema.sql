-- Схема бази даних для питання Крок 1 медицини
-- Створення таблиць для Supabase

-- Таблиця для зберігання питань
CREATE TABLE IF NOT EXISTS krok_questions (
    id SERIAL PRIMARY KEY,
    question_number INTEGER NOT NULL UNIQUE,
    question_text TEXT NOT NULL,
    category VARCHAR(100),
    difficulty_level VARCHAR(20) DEFAULT 'medium',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблиця для зберігання варіантів відповідей
CREATE TABLE IF NOT EXISTS krok_answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES krok_questions(id) ON DELETE CASCADE,
    answer_option CHAR(1) NOT NULL CHECK (answer_option IN ('A', 'B', 'C', 'D', 'E')),
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE (question_id, answer_option)
);

-- Таблиця для зберігання пояснень до правильних відповідей
CREATE TABLE IF NOT EXISTS krok_explanations (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES krok_questions(id) ON DELETE CASCADE,
    explanation_text TEXT NOT NULL,
    reference_text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE (question_id)
);

-- Таблиця для зберігання статистики проходження тестів
CREATE TABLE IF NOT EXISTS krok_test_results (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    question_id INTEGER REFERENCES krok_questions(id) ON DELETE CASCADE,
    selected_answer CHAR(1) CHECK (selected_answer IN ('A', 'B', 'C', 'D', 'E')),
    is_correct BOOLEAN,
    time_spent INTEGER, -- в секундах
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Індекси для покращення продуктивності
CREATE INDEX IF NOT EXISTS idx_krok_questions_number ON krok_questions(question_number);
CREATE INDEX IF NOT EXISTS idx_krok_questions_category ON krok_questions(category);
CREATE INDEX IF NOT EXISTS idx_krok_answers_question_id ON krok_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_krok_answers_correct ON krok_answers(is_correct);
CREATE INDEX IF NOT EXISTS idx_krok_test_results_user_id ON krok_test_results(user_id);
CREATE INDEX IF NOT EXISTS idx_krok_test_results_question_id ON krok_test_results(question_id);

-- Функція для автоматичного оновлення updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Тригер для автоматичного оновлення updated_at
CREATE TRIGGER update_krok_questions_updated_at 
    BEFORE UPDATE ON krok_questions 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- RLS (Row Level Security) політики
ALTER TABLE krok_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE krok_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE krok_explanations ENABLE ROW LEVEL SECURITY;
ALTER TABLE krok_test_results ENABLE ROW LEVEL SECURITY;

-- Політики для читання (всі можуть читати питання)
CREATE POLICY "Anyone can read questions" ON krok_questions FOR SELECT USING (true);
CREATE POLICY "Anyone can read answers" ON krok_answers FOR SELECT USING (true);
CREATE POLICY "Anyone can read explanations" ON krok_explanations FOR SELECT USING (true);

-- Політики для запису результатів тестів (тільки авторизовані користувачі)
CREATE POLICY "Users can insert their test results" ON krok_test_results 
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own test results" ON krok_test_results 
    FOR SELECT USING (auth.uid() = user_id);

-- Політики для адміністраторів (повний доступ)
CREATE POLICY "Admins can manage questions" ON krok_questions 
    FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Admins can manage answers" ON krok_answers 
    FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Admins can manage explanations" ON krok_explanations 
    FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Admins can view all test results" ON krok_test_results 
    FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Коментарі до таблиць
COMMENT ON TABLE krok_questions IS 'Таблиця питань Крок 1 медицини';
COMMENT ON TABLE krok_answers IS 'Таблиця варіантів відповідей до питань';
COMMENT ON TABLE krok_explanations IS 'Таблиця пояснень до правильних відповідей';
COMMENT ON COLUMN krok_explanations.reference_text IS 'Посилання на джерела для пояснення';
COMMENT ON TABLE krok_test_results IS 'Таблиця результатів проходження тестів користувачами';
