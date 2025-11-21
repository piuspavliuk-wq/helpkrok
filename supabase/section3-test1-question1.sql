-- SQL для додавання першого питання в Тест 1 розділу 3: Біологія клітин
-- Питання має бути першим (order_index = 0)

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Фундаментальні медико-біологічні знання'
  LIMIT 1;
  
  IF v_course_id IS NULL THEN
    RAISE EXCEPTION 'Курс не знайдено';
  END IF;
  
  -- Знаходимо topic для Тесту 1
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Біологія клітин - Тест 1'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Topic для Тесту 1 розділу 3 не знайдено';
  END IF;
  
  -- Видаляємо існуюче перше питання якщо воно є (опціонально, якщо потрібно замінити)
  -- DELETE FROM question_options WHERE question_id IN (
  --   SELECT id FROM questions WHERE topic_id = v_topic_id AND order_index = 0
  -- );
  -- DELETE FROM questions WHERE topic_id = v_topic_id AND order_index = 0;
  
  -- Вставляємо питання з order_index = 0 (перше питання)
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під впливом патогенних факторів може настати некротична загибель клітини, яка супроводжується порушенням утворення енергії, внаслідок чого виникають фактори, які ведуть до загибелі ядра та розриву клітинної мембрани. Головний з цих факторів:',
    'medium',
    0,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;
  
  -- Вставляємо варіанти відповідей
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at) VALUES
    (v_question_id, 'Ушкодження апарата Гольджі', false, 0, NOW(), NOW()),
    (v_question_id, 'Порушення саркоплазматичного ретикулуму', false, 1, NOW(), NOW()),
    (v_question_id, 'Гіпертрофія мітохондрій', false, 2, NOW(), NOW()),
    (v_question_id, 'Зміни вмісту циклічних нуклеотидів', false, 3, NOW(), NOW()),
    (v_question_id, 'Розрив лізосом зі звільненням активованих протеаз', true, 4, NOW(), NOW());
  
  RAISE NOTICE 'Питання успішно додано з ID: %', v_question_id;
END $$;

