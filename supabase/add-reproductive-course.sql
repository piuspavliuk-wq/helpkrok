-- Додати курс "Репродуктивна система" (медичний факультет).
-- Запустити один раз після деплою.

INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Репродуктивна система', 'Комплексний курс з репродуктивної системи для майбутніх медиків.', 'medical', 10, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Репродуктивна система');
