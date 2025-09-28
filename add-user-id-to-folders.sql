-- Додавання колонки user_id до таблиці user_folders
ALTER TABLE user_folders 
ADD COLUMN IF NOT EXISTS user_id UUID;

-- Створення індексу для user_id
CREATE INDEX IF NOT EXISTS idx_user_folders_user_id ON user_folders(user_id);

-- Оновлення RLS політик для user_folders
ALTER TABLE user_folders ENABLE ROW LEVEL SECURITY;

-- Видалення старих політик
DROP POLICY IF EXISTS "Users can view their own folders" ON user_folders;
DROP POLICY IF EXISTS "Users can insert their own folders" ON user_folders;
DROP POLICY IF EXISTS "Users can update their own folders" ON user_folders;
DROP POLICY IF EXISTS "Users can delete their own folders" ON user_folders;
DROP POLICY IF EXISTS "NextAuth users can view folders" ON user_folders;
DROP POLICY IF EXISTS "NextAuth users can insert folders" ON user_folders;
DROP POLICY IF EXISTS "NextAuth users can update folders" ON user_folders;
DROP POLICY IF EXISTS "NextAuth users can delete folders" ON user_folders;

-- Створення нових політик
CREATE POLICY "Users can view their own folders" ON user_folders
    FOR SELECT USING (user_id::text = current_setting('request.jwt.claims', true)::json->>'sub');

CREATE POLICY "Users can insert their own folders" ON user_folders
    FOR INSERT WITH CHECK (user_id::text = current_setting('request.jwt.claims', true)::json->>'sub');

CREATE POLICY "Users can update their own folders" ON user_folders
    FOR UPDATE USING (user_id::text = current_setting('request.jwt.claims', true)::json->>'sub');

CREATE POLICY "Users can delete their own folders" ON user_folders
    FOR DELETE USING (user_id::text = current_setting('request.jwt.claims', true)::json->>'sub');

-- Альтернативні політики для NextAuth (якщо перші не працюють)
CREATE POLICY "NextAuth users can view folders" ON user_folders
    FOR SELECT USING (true);

CREATE POLICY "NextAuth users can insert folders" ON user_folders
    FOR INSERT WITH CHECK (true);

CREATE POLICY "NextAuth users can update folders" ON user_folders
    FOR UPDATE USING (true);

CREATE POLICY "NextAuth users can delete folders" ON user_folders
    FOR DELETE USING (true);
