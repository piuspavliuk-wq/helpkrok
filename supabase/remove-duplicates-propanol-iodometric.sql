-- Видалити дублікати з теми tema3:
-- 1) Другий дубль «Бензальдегід в умовах реакції Канніццаро утворює:» (order_index 94).
-- 2) Другий варіант питання про пропанол-2 з ацетону (order_index 15: «пропанолу - 2 з ацетону»).
-- 3) Дубль того ж питання (order_index 102).
-- 4) Дубль питання про йодиметричне визначення формальдегіду (order_index 103).
-- 5) Другий дубль «Вкажіть порядок реакції розкладання ацетону:» (order_index 112).

WITH topic AS (
  SELECT t.id AS topic_id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  LIMIT 1
)
DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q, topic
  WHERE q.topic_id = topic.topic_id AND q.order_index IN (94, 15, 102, 103, 112)
);

DELETE FROM questions
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки')
  AND order_index IN (94, 15, 102, 103, 112);
