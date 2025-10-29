-- Міграція таблиці user_saved_questions для підтримки UUID
-- Цей скрипт потрібно виконати в Supabase Dashboard або через psql

-- 1. Створюємо нову таблицю з правильною структурою
CREATE TABLE user_saved_questions_new (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    question_id TEXT NOT NULL, -- Тепер підтримує як integer, так і UUID
    question_type VARCHAR(50) NOT NULL,
    notes TEXT,
    saved_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Копіюємо дані з старої таблиці
INSERT INTO user_saved_questions_new (user_id, question_id, question_type, notes, saved_at)
SELECT 
    user_id,
    question_id::text, -- Конвертуємо integer в text
    question_type,
    notes,
    saved_at
FROM user_saved_questions;

-- 3. Створюємо індекси
CREATE INDEX idx_user_saved_questions_new_user_id ON user_saved_questions_new(user_id);
CREATE INDEX idx_user_saved_questions_new_question_id ON user_saved_questions_new(question_id);
CREATE INDEX idx_user_saved_questions_new_question_type ON user_saved_questions_new(question_type);

-- 4. Створюємо унікальний індекс для запобігання дублікатів
CREATE UNIQUE INDEX idx_user_saved_questions_new_unique 
ON user_saved_questions_new(user_id, question_id, question_type);

-- 5. Видаляємо стару таблицю
DROP TABLE user_saved_questions;

-- 6. Перейменовуємо нову таблицю
ALTER TABLE user_saved_questions_new RENAME TO user_saved_questions;

-- 7. Додаємо коментарі
COMMENT ON TABLE user_saved_questions IS 'Таблиця збережених питань користувачів';
COMMENT ON COLUMN user_saved_questions.question_id IS 'ID питання (integer для медичних питань, UUID для фармацевтичних питань)';
COMMENT ON COLUMN user_saved_questions.question_type IS 'Тип питання: anatomy, physiology, pathology, pharmaceutical, etc.';
