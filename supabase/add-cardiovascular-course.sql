-- Додати курс "Серцево-судинна система" (медичний факультет).
-- Запустити один раз після деплою.

INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Серцево-судинна система', 'Комплексний курс з серцево-судинної системи для майбутніх медиків.', 'medical', 7, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Серцево-судинна система');
