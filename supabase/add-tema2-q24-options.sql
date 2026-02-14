-- Додати до питання 24 (Для якого класу органічних сполук характерна наявність -C≡N групи?)
-- три варіанти: Нітросполуки, Спирти, Альдегіди

INSERT INTO question_options (question_id, option_text, is_correct, order_index)
SELECT q.id, v.opt, false, v.idx
FROM questions q
JOIN topics t ON t.id = q.topic_id
JOIN courses c ON c.id = t.course_id
CROSS JOIN (
  VALUES ('Нітросполуки', 2), ('Спирти', 3), ('Альдегіди', 4)
) AS v(opt, idx)
WHERE c.title = 'Основи знань про органічні сполуки'
  AND t.title = 'Нітрогеновмісні органічні сполуки'
  AND q.order_index = 24;
