-- Help Krok Platform Database Schema
-- PostgreSQL/Supabase

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    telegram_id VARCHAR(50) UNIQUE,
    telegram_username VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User subscriptions table
CREATE TABLE user_subscriptions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    subscription_type VARCHAR(20) CHECK (subscription_type IN ('medical', 'pharmaceutical', 'premium', 'randomizer')),
    status VARCHAR(20) CHECK (status IN ('pending', 'active', 'expired', 'cancelled')) DEFAULT 'pending',
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    payment_provider VARCHAR(20) CHECK (payment_provider IN ('mono')),
    payment_id VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Randomizer attempts table (спроби Randomizer PRO)
CREATE TABLE randomizer_attempts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    total_attempts INTEGER NOT NULL DEFAULT 0,
    used_attempts INTEGER NOT NULL DEFAULT 0,
    remaining_attempts INTEGER GENERATED ALWAYS AS (total_attempts - used_attempts) STORED,
    purchase_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE,
    payment_id VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Randomizer test history (історія тестів)
CREATE TABLE randomizer_test_history (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    questions_count INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    score_percentage DECIMAL(5,2) NOT NULL,
    time_spent_seconds INTEGER,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Courses table
CREATE TABLE courses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Topics table
CREATE TABLE topics (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    video_url TEXT,
    lecture_notes TEXT,
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Questions table
CREATE TABLE questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    topic_id UUID REFERENCES topics(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    explanation TEXT,
    difficulty VARCHAR(10) CHECK (difficulty IN ('easy', 'medium', 'hard')) DEFAULT 'medium',
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Question options table
CREATE TABLE question_options (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT false,
    order_index INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User topic progress table
CREATE TABLE user_topic_progress (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    topic_id UUID REFERENCES topics(id) ON DELETE CASCADE,
    video_progress DECIMAL(5,2) DEFAULT 0 CHECK (video_progress >= 0 AND video_progress <= 100),
    video_completed BOOLEAN DEFAULT false,
    test_completed BOOLEAN DEFAULT false,
    test_score DECIMAL(5,2),
    last_accessed TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, topic_id)
);

-- Test attempts table
CREATE TABLE test_attempts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    topic_id UUID REFERENCES topics(id) ON DELETE SET NULL,
    attempt_type VARCHAR(20) CHECK (attempt_type IN ('topic_test', 'krok_simulation', 'year_booklet')) NOT NULL,
    total_questions INTEGER NOT NULL DEFAULT 0,
    correct_answers INTEGER NOT NULL DEFAULT 0,
    score DECIMAL(5,2) NOT NULL DEFAULT 0,
    time_spent INTEGER NOT NULL DEFAULT 0, -- in seconds
    completed_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User topic access table
CREATE TABLE user_topic_access (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    topic_id UUID REFERENCES topics(id) ON DELETE CASCADE,
    access_granted BOOLEAN DEFAULT false,
    granted_at TIMESTAMP WITH TIME ZONE,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, topic_id)
);

-- Test answers table (for detailed tracking)
CREATE TABLE test_answers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    attempt_id UUID REFERENCES test_attempts(id) ON DELETE CASCADE,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    selected_option_id UUID REFERENCES question_options(id) ON DELETE SET NULL,
    is_correct BOOLEAN NOT NULL,
    time_spent INTEGER NOT NULL DEFAULT 0, -- in seconds
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Year booklets table
CREATE TABLE year_booklets (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    year INTEGER NOT NULL,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    total_questions INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(year, faculty)
);

-- Year booklet questions table
CREATE TABLE year_booklet_questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    booklet_id UUID REFERENCES year_booklets(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    explanation TEXT,
    difficulty VARCHAR(10) CHECK (difficulty IN ('easy', 'medium', 'hard')) DEFAULT 'medium',
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Year booklet question options table
CREATE TABLE year_booklet_question_options (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    question_id UUID REFERENCES year_booklet_questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT false,
    order_index INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for better performance
CREATE INDEX idx_users_telegram_id ON users(telegram_id);
CREATE INDEX idx_user_subscriptions_user_id ON user_subscriptions(user_id);
CREATE INDEX idx_user_subscriptions_status ON user_subscriptions(status);
CREATE INDEX idx_topics_course_id ON topics(course_id);
CREATE INDEX idx_questions_topic_id ON questions(topic_id);
CREATE INDEX idx_question_options_question_id ON question_options(question_id);
CREATE INDEX idx_user_topic_progress_user_id ON user_topic_progress(user_id);
CREATE INDEX idx_user_topic_progress_topic_id ON user_topic_progress(topic_id);
CREATE INDEX idx_test_attempts_user_id ON test_attempts(user_id);
CREATE INDEX idx_test_attempts_type ON test_attempts(attempt_type);
CREATE INDEX idx_user_topic_access_user_id ON user_topic_access(user_id);
CREATE INDEX idx_user_topic_access_topic_id ON user_topic_access(topic_id);
CREATE INDEX idx_test_answers_attempt_id ON test_answers(attempt_id);
CREATE INDEX idx_year_booklets_year_faculty ON year_booklets(year, faculty);
CREATE INDEX idx_year_booklet_questions_booklet_id ON year_booklet_questions(booklet_id);

-- Functions for updating timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updating timestamps
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_subscriptions_updated_at BEFORE UPDATE ON user_subscriptions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_courses_updated_at BEFORE UPDATE ON courses FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_topics_updated_at BEFORE UPDATE ON topics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_questions_updated_at BEFORE UPDATE ON questions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_question_options_updated_at BEFORE UPDATE ON question_options FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_topic_progress_updated_at BEFORE UPDATE ON user_topic_progress FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_topic_access_updated_at BEFORE UPDATE ON user_topic_access FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_year_booklets_updated_at BEFORE UPDATE ON year_booklets FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_year_booklet_questions_updated_at BEFORE UPDATE ON year_booklet_questions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_year_booklet_question_options_updated_at BEFORE UPDATE ON year_booklet_question_options FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) policies
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_topic_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_topic_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_answers ENABLE ROW LEVEL SECURITY;

-- Sample data for testing
INSERT INTO courses (title, description, faculty, order_index) VALUES
('Анатомія людини', 'Основи анатомії та фізіології людини', 'medical', 1),
('Фізіологія', 'Функціональні процеси в організмі людини', 'medical', 2),
('Патологія', 'Патологічні процеси та захворювання', 'medical', 3),
('Фармакологія', 'Основи фармакології та лікування', 'pharmaceutical', 1),
('Фармацевтична хімія', 'Хімічні основи фармації', 'pharmaceutical', 2),
('Фармацевтична технологія', 'Технології виготовлення ліків', 'pharmaceutical', 3);

-- Sample topics
INSERT INTO topics (course_id, title, description, order_index) VALUES
((SELECT id FROM courses WHERE title = 'Анатомія людини'), 'Опорно-рухова система', 'Будова кісток, суглобів та м\'язів', 1),
((SELECT id FROM courses WHERE title = 'Анатомія людини'), 'Серцево-судинна система', 'Будова серця та судин', 2),
((SELECT id FROM courses WHERE title = 'Фізіологія'), 'Фізіологія дихання', 'Механізми дихання та газообміну', 1),
((SELECT id FROM courses WHERE title = 'Патологія'), 'Запальні процеси', 'Механізми розвитку запалення', 1),
((SELECT id FROM courses WHERE title = 'Фармакологія'), 'Основи фармакокінетики', 'Процеси всмоктування, розподілу та виведення ліків', 1),
((SELECT id FROM courses WHERE title = 'Фармацевтична хімія'), 'Органічна хімія', 'Основи органічної хімії для фармації', 1);

-- Sample year booklets
INSERT INTO year_booklets (year, faculty, title, total_questions) VALUES
(2024, 'medical', 'КРОК 2024 - Медичний факультет', 150),
(2024, 'pharmaceutical', 'КРОК 2024 - Фармацевтичний факультет', 150),
(2023, 'medical', 'КРОК 2023 - Медичний факультет', 150),
(2023, 'pharmaceutical', 'КРОК 2023 - Фармацевтичний факультет', 150);
