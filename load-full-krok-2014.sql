-- ========================================
-- КРОК 2014 - Завантаження повного тесту
-- ========================================
-- Виконайте цей код в SQL Editor в Supabase Dashboard

-- 1. Створюємо таблиці (якщо не існують)
-- ========================================

CREATE TABLE IF NOT EXISTS krok_questions (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    year INTEGER NOT NULL,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    category VARCHAR(100),
    difficulty VARCHAR(10) CHECK (difficulty IN ('easy', 'medium', 'hard')) DEFAULT 'medium',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS krok_answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES krok_questions(id) ON DELETE CASCADE,
    answer_option CHAR(1) NOT NULL CHECK (answer_option IN ('A', 'B', 'C', 'D', 'E')),
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE (question_id, answer_option)
);

-- Індекси
CREATE INDEX IF NOT EXISTS idx_krok_questions_year ON krok_questions(year);
CREATE INDEX IF NOT EXISTS idx_krok_questions_faculty ON krok_questions(faculty);
CREATE INDEX IF NOT EXISTS idx_krok_questions_category ON krok_questions(category);
CREATE INDEX IF NOT EXISTS idx_krok_questions_active ON krok_questions(is_active);
CREATE INDEX IF NOT EXISTS idx_krok_answers_question_id ON krok_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_krok_answers_correct ON krok_answers(is_correct);

-- 2. Очищуємо старі дані
-- ========================================
DELETE FROM krok_answers WHERE question_id IN (SELECT id FROM krok_questions WHERE year = 2014);
DELETE FROM krok_questions WHERE year = 2014;

-- 3. Завантажуємо повний файл з питань
-- ========================================
-- Скопіюйте весь вміст файлу krok-2014-questions.sql сюди
-- або виконайте його окремо

SELECT 'Таблиці створені! Тепер виконайте файл krok-2014-questions.sql для завантаження 200 питань.' as status;
