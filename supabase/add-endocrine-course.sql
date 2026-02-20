-- Додати курс "Ендокринна система" (медичний факультет).
-- Запустити один раз після деплою.

INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Ендокринна система', 'Комплексний курс з ендокринної системи для майбутніх медиків.', 'medical', 11, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Ендокринна система');
