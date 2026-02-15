-- Додати питання «При взаємодії ацетилену з водою утворюється:» в кінець теми «Оксигено- та сульфуровмісні органічні сполуки».
-- Правильна відповідь: Оцтовий альдегід.

WITH topic_found AS (
  SELECT t.id AS topic_id, (SELECT COALESCE(MAX(q.order_index), 0) + 1 FROM questions q WHERE q.topic_id = t.id) AS next_order
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  LIMIT 1
),
new_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT topic_id, 'При взаємодії ацетилену з водою утворюється:', NULL, 'medium', next_order, true, NULL
  FROM topic_found
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
SELECT nq.id, v.option_text, v.is_correct, v.ord
FROM new_question nq
CROSS JOIN (
  VALUES
    ('Бензиловий спирт', false, 0),
    ('Етиленгліколь', false, 1),
    ('Етиловий спирт', false, 2),
    ('Оцтовий альдегід', true, 3),
    ('Щавлева кислота', false, 4)
) AS v(option_text, is_correct, ord);
