-- Тільки видалити всі питання та варіанти теми "Вуглеводні та їх галогенопохідні".
-- Після цього можна виконати vuhlevodni-from-untitled-document-1.sql для імпорту нових тестів.

BEGIN;

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
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);

COMMIT;
