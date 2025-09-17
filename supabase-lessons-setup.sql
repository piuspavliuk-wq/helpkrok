-- Додаємо поле role до таблиці users
ALTER TABLE users ADD COLUMN role TEXT DEFAULT 'student';

-- Створюємо таблицю lessons
CREATE TABLE lessons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  subject TEXT NOT NULL,
  step TEXT NOT NULL CHECK (step IN ('krok1', 'krok2', 'krok3')),
  faculty TEXT NOT NULL CHECK (faculty IN ('medical', 'pharmaceutical')),
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  end_date TIMESTAMP WITH TIME ZONE NOT NULL,
  location TEXT,
  teacher_name TEXT,
  max_students INTEGER,
  is_online BOOLEAN DEFAULT FALSE,
  meeting_link TEXT,
  materials TEXT,
  status TEXT DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'ongoing', 'completed', 'cancelled')),
  calendar_event_id TEXT,
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Створюємо таблицю lesson_attendance
CREATE TABLE lesson_attendance (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'registered' CHECK (status IN ('registered', 'attended', 'absent', 'late')),
  joined_at TIMESTAMP WITH TIME ZONE,
  left_at TIMESTAMP WITH TIME ZONE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, lesson_id)
);

-- Створюємо індекси для кращої продуктивності
CREATE INDEX idx_lessons_start_date ON lessons(start_date);
CREATE INDEX idx_lessons_faculty ON lessons(faculty);
CREATE INDEX idx_lessons_step ON lessons(step);
CREATE INDEX idx_lessons_status ON lessons(status);
CREATE INDEX idx_lesson_attendance_user_id ON lesson_attendance(user_id);
CREATE INDEX idx_lesson_attendance_lesson_id ON lesson_attendance(lesson_id);

-- Створюємо функцію для автоматичного оновлення updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Створюємо тригери для автоматичного оновлення updated_at
CREATE TRIGGER update_lessons_updated_at BEFORE UPDATE ON lessons
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lesson_attendance_updated_at BEFORE UPDATE ON lesson_attendance
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Додаємо RLS (Row Level Security) політики
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_attendance ENABLE ROW LEVEL SECURITY;

-- Політика для lessons: всі можуть читати, тільки адміни можуть редагувати
CREATE POLICY "Lessons are viewable by everyone" ON lessons
    FOR SELECT USING (true);

CREATE POLICY "Only admins can insert lessons" ON lessons
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id = auth.uid() 
            AND users.role = 'admin'
        )
    );

CREATE POLICY "Only admins can update lessons" ON lessons
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id = auth.uid() 
            AND users.role = 'admin'
        )
    );

CREATE POLICY "Only admins can delete lessons" ON lessons
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id = auth.uid() 
            AND users.role = 'admin'
        )
    );

-- Політика для lesson_attendance: користувачі можуть бачити тільки свою відвідуваність
CREATE POLICY "Users can view their own attendance" ON lesson_attendance
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own attendance" ON lesson_attendance
    FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own attendance" ON lesson_attendance
    FOR UPDATE USING (user_id = auth.uid());

-- Адміни можуть бачити всю відвідуваність
CREATE POLICY "Admins can view all attendance" ON lesson_attendance
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id = auth.uid() 
            AND users.role = 'admin'
        )
    );

CREATE POLICY "Admins can update all attendance" ON lesson_attendance
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id = auth.uid() 
            AND users.role = 'admin'
        )
    );
