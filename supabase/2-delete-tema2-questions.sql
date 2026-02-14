-- Видалити всі питання теми "Нітрогеновмісні органічні сполуки" (щоб імпортувати заново з виправленим парсером)
-- Виконати в Supabase SQL Editor перед виконанням tema2-with-images.sql

DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
);

DELETE FROM questions
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
);
