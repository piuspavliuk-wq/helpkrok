-- Крок 1: Повністю видалити питання теми "Вуглеводні та їх галогенопохідні"
-- (щоб далі імпортувати їх з PDF у правильному порядку з картинками)
-- Виконати в Supabase SQL Editor.

-- Спочатку видалити варіанти відповідей (foreign key)
DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);

-- Потім видалити питання
DELETE FROM questions
WHERE topic_id = (
  SELECT t.id
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
);
