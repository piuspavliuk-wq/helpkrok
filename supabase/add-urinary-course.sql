-- Додати курс "Сечова система" (медичний факультет).
-- Запустити один раз після деплою.

INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Сечова система', 'Комплексний курс з сечової системи для майбутніх медиків.', 'medical', 9, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Сечова система');
