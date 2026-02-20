-- Додати курс "Травна система" (медичний факультет).
-- Запустити один раз після деплою.

INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Травна система', 'Комплексний курс з травної системи для майбутніх медиків.', 'medical', 8, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Травна система');
