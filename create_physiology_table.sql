-- Створення таблиці для питань фізіології
CREATE TABLE IF NOT EXISTS physiology_questions (
  id SERIAL PRIMARY KEY,
  question_number INTEGER,
  system VARCHAR(100) NOT NULL,
  question_text TEXT NOT NULL,
  situation TEXT DEFAULT '', -- новий стовпець
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer VARCHAR(50) NOT NULL,
  topic TEXT DEFAULT '',
  recommendation TEXT DEFAULT '',
  faculty VARCHAR(30) DEFAULT 'medical'
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
