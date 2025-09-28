-- Додавання foreign key constraint між folder_questions та user_folders
-- Спочатку перевіряємо, чи існує constraint
DO $$ 
BEGIN
    -- Перевіряємо, чи існує foreign key constraint
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.table_constraints 
        WHERE constraint_name = 'fk_folder_questions_folder_id'
        AND table_name = 'folder_questions'
    ) THEN
        -- Додаємо foreign key constraint
        ALTER TABLE folder_questions 
        ADD CONSTRAINT fk_folder_questions_folder_id 
        FOREIGN KEY (folder_id) REFERENCES user_folders(id) ON DELETE CASCADE;
        
        RAISE NOTICE 'Foreign key constraint added successfully';
    ELSE
        RAISE NOTICE 'Foreign key constraint already exists';
    END IF;
END $$;

-- Перевіряємо, чи constraint створений
SELECT 
    tc.constraint_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc 
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
AND tc.table_name = 'folder_questions';
