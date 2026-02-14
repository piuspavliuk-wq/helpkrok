-- Очистити картинки (image_url) у всіх питань теми "Вуглеводні та їх галогенопохідні"
-- Виконати в Supabase SQL Editor

UPDATE questions
SET image_url = NULL
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);

-- ---------------------------------------------------------------------------
-- Якщо потрібно повністю видалити питання цієї теми (перед переімпортом з PDF):
-- спочатку видалити опції, потім питання (через foreign key).
-- Розкоментуйте і виконайте окремо.
-- ---------------------------------------------------------------------------
/*
DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);

DELETE FROM questions
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);
*/
