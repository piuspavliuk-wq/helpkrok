-- Створення таблиці для питань фізіології
CREATE TABLE IF NOT EXISTS physiology_questions (
  id SERIAL PRIMARY KEY,
  question_number INTEGER,
  system VARCHAR(100),
  question_text TEXT,
  option_a TEXT,
  option_b TEXT,
  option_c TEXT,
  option_d TEXT,
  correct_answer VARCHAR(10),
  topic VARCHAR(200),
  recommendation TEXT,
  faculty VARCHAR(50) DEFAULT 'medical',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Створення індексів для швидкого пошуку
CREATE INDEX IF NOT EXISTS idx_physiology_questions_system ON physiology_questions(system);
CREATE INDEX IF NOT EXISTS idx_physiology_questions_faculty ON physiology_questions(faculty);

-- Налаштування RLS (Row Level Security)
ALTER TABLE physiology_questions ENABLE ROW LEVEL SECURITY;

-- Політика для читання (всі можуть читати)
CREATE POLICY "Allow read access to physiology questions" ON physiology_questions
FOR SELECT USING (true);

-- Політика для запису (тільки аутентифіковані користувачі)
CREATE POLICY "Allow insert for authenticated users" ON physiology_questions
FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Політика для оновлення (тільки аутентифіковані користувачі)
CREATE POLICY "Allow update for authenticated users" ON physiology_questions
FOR UPDATE USING (auth.role() = 'authenticated');

-- Політика для видалення (тільки аутентифіковані користувачі)
CREATE POLICY "Allow delete for authenticated users" ON physiology_questions
FOR DELETE USING (auth.role() = 'authenticated');
