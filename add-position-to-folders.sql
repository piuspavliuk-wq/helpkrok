-- Додаємо поле position до таблиці user_folders
ALTER TABLE user_folders 
ADD COLUMN IF NOT EXISTS position INTEGER DEFAULT 0;

-- Оновлюємо існуючі записи з позиціями
UPDATE user_folders 
SET position = EXTRACT(EPOCH FROM created_at)::INTEGER 
WHERE position = 0;

-- Створюємо індекс для швидкого сортування
CREATE INDEX IF NOT EXISTS idx_user_folders_position 
ON user_folders(user_id, position);

-- Оновлюємо RLS політики якщо потрібно
-- (політики вже існують, тому просто перевіряємо)
SELECT 'Position column added successfully' as status;
