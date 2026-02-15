-- Видалити другий дубль питання «Вкажіть порядок реакції розкладання ацетону:» (order_index = 112) з теми tema3.

DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
    AND q.order_index = 112
);

DELETE FROM questions
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки')
  AND order_index = 112;
