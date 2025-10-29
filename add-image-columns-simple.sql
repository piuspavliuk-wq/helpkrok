-- Додаємо колонки для зображень до таблиці pharmaceutical_questions
-- Виконайте цей SQL в Supabase SQL Editor

ALTER TABLE pharmaceutical_questions 
ADD COLUMN IF NOT EXISTS question_image TEXT,
ADD COLUMN IF NOT EXISTS option_a_image TEXT,
ADD COLUMN IF NOT EXISTS option_b_image TEXT,
ADD COLUMN IF NOT EXISTS option_c_image TEXT,
ADD COLUMN IF NOT EXISTS option_d_image TEXT,
ADD COLUMN IF NOT EXISTS option_e_image TEXT;
