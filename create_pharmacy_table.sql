CREATE TABLE IF NOT EXISTS pharmacy_questions (
  id SERIAL PRIMARY KEY,
  question_number INTEGER,
  system VARCHAR(100) NOT NULL,
  question_text TEXT NOT NULL,
  situation TEXT DEFAULT '',
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer VARCHAR(50) NOT NULL,
  topic TEXT DEFAULT '',
  recommendation TEXT DEFAULT ''
);

-- Індекси для швидкого пошуку
CREATE INDEX IF NOT EXISTS idx_pharmacy_questions_number ON pharmacy_questions(question_number);
CREATE INDEX IF NOT EXISTS idx_pharmacy_questions_system ON pharmacy_questions(system);
