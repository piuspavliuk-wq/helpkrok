-- Видалити всі картинки (image_url) у питань курсів органіки.
-- Після виконання можна вручну призначити зображення кожному питанню.

-- Тема 1: Вуглеводні та їх галогенопохідні
UPDATE questions
SET image_url = NULL
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);

-- Тема 2: Нітрогеновмісні органічні сполуки
UPDATE questions
SET image_url = NULL
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
);
