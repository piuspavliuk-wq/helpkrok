-- SQL для видалення тестів з розділу 2: Метаболізм основних класів біомолекул
-- Видаляє topics та всі пов'язані питання та варіанти відповідей

DO $$
DECLARE
  v_course_id UUID;
  v_topic_ids UUID[];
BEGIN
  -- Знаходимо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Фундаментальні медико-біологічні знання'
  LIMIT 1;
  
  IF v_course_id IS NULL THEN
    RAISE NOTICE 'Курс не знайдено';
    RETURN;
  END IF;
  
  -- Знаходимо всі topics для розділу 2 з тестами
  SELECT ARRAY_AGG(id) INTO v_topic_ids
  FROM topics
  WHERE course_id = v_course_id 
    AND (title = 'Метаболізм основних класів біомолекул - Тест 1'
         OR title = 'Метаболізм основних класів біомолекул - Тест 2'
         OR title = 'Метаболізм основних класів біомолекул');
  
  IF v_topic_ids IS NULL OR array_length(v_topic_ids, 1) = 0 THEN
    RAISE NOTICE 'Topics для розділу 2 не знайдено';
    RETURN;
  END IF;
  
  -- Видаляємо варіанти відповідей
  DELETE FROM question_options
  WHERE question_id IN (
    SELECT id FROM questions WHERE topic_id = ANY(v_topic_ids)
  );
  
  -- Видаляємо питання
  DELETE FROM questions
  WHERE topic_id = ANY(v_topic_ids);
  
  -- Видаляємо topics
  DELETE FROM topics
  WHERE id = ANY(v_topic_ids);
  
  RAISE NOTICE 'Видалено % topics та всі пов''язані дані', array_length(v_topic_ids, 1);
END $$;

