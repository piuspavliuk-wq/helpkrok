-- SQL для додавання питань до розділу 27: Лікарські засоби які впливають на дихальну систему
-- Автоматично згенеровано
-- Кількість питань: 45

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо або створюємо курс Дихальна система
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Дихальна система'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    INSERT INTO courses (title, faculty, description, order_index, is_active, created_at, updated_at)
    VALUES (
      'Дихальна система',
      'medical',
      'Дихальна система',
      2,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_course_id;
    RAISE NOTICE 'Створено курс "Дихальна система" з ID: %', v_course_id;
  END IF;

  -- Створюємо або знаходимо topic для розділу 27
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Лікарські засоби які впливають на дихальну систему'
  LIMIT 1;

  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Лікарські засоби які впливають на дихальну систему',
      'Тести з лікарських засобів що впливають на дихальну систему',
      2,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;

  RAISE NOTICE 'Topic ID: %', v_topic_id;

  DELETE FROM question_options
  WHERE question_id IN (SELECT id FROM questions WHERE topic_id = v_topic_id);

  DELETE FROM questions WHERE topic_id = v_topic_id;

  RAISE NOTICE 'Старі питання видалено. Додаємо нові...';

  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта під час відвідування стоматолого виникла різка гіпотензія. Який із препаратів, що стимулює адренергічну іннервацію, необхідно використати для нормалізації артеріального тиску?', 'medium', 0, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нафазолін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ерготамін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенілефрин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ксилометазолін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Доксазозин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта під час відвідування стоматолога виникла гіпотензія. Який із препаратів, що стимулює α-адренергічну іннервацію, необхідно використати для підвищення артеріального тиску?', 'medium', 1, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенілефрин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Доксазозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бромокриптин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ерготамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка колаптоїдний стан через зниження тонусу периферичних судин. Який препарат найефективніший у цій ситуації?', 'medium', 2, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прозерин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезатон', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клофелін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта під час відвідування стоматолога виникла різка гіпотензія. Який із препаратів, що стимулює адренергічні структури, слід використати для нормалізації артеріального тиску?', 'medium', 3, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезатон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ксилометазолін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Санорин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ерготамін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Доксазозин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Офтальмолог з діагностичною метою (розширення зіниць для огляду очного дна) використав 1% розчин мезатону. Мідріаз, викликаний препаратом, обумовлений:', 'medium', 4, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією М-холінорецепторів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією α₁-адренорецепторів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією β₁ -адренорецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокадою α₁-адренорецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією α₂-адренорецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час оперативного втручання на фоні використання гігронію різко знизився артеріальний тиск. Представники яких груп лікарських препаратів можуть нормалізувати артеріальний тиск?', 'medium', 5, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'α-адреноміметики', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліоблокатори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'M-холіноміметики', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Н-холіноміметики', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'α-адреноблокатори', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для корекції артеріального тиску при колаптоїдному стані хворому було введено мезатон. Який механізм дії даного препарату?', 'medium', 6, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокує α-адренорецептори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокує β-адренорецептори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює α-адренорецептори', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює α- і β-адренорецептори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює β-адренорецептори', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для корекції артеріального тиску при колаптоїдному стані хворому було введено мезатон. Який механізм дії даного препарату?', 'medium', 7, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокує α-адренорецептори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокує β-адренорецептори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює α-адренорецептори', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює α- і β-адренорецептори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює β-адренорецептори', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку для лікування хронічного обструктивного бронхіту до складу комплексної терапії треба включити муколітик. Виберіть цей препарат із запропонованих:', 'medium', 8, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилцистеїн', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пантогам', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію оротат', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вінкристин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклофосфамід', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт, що хворіє на хронічний бронхіт, приймає синтетичний муколітичний препарат, який сприяє розріджуванню харкотиння. Назвіть цей препарат:', 'medium', 9, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепарин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилцистеїн', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діазепам', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еналаприл', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікар призначив пацієнту з хронічним бронхітом відхаркувальний засіб, який діє шляхом розщеплення дисульфідних зв’язків глікозаміногліканів харкотиння, зменшуючи цим його в’язкість, проте попередив хворого про можливий бронхоспазм при його використанні. Який засіб був призначений?', 'medium', 10, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилцистеїн', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трава термопсису', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бромгексин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лібексин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію гідрокарбонат', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловікові, який хворіє на бронхопневмонію, лікар призначив ацетилцистеїн. Визначте показання до його застосування:', 'medium', 11, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бронхіт із харкотинням', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Судоми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асфіксія новонароджених', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серцева недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бронхіальна астма', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту віком 25 років, який хворіє на хронічний бронхіт лікар призначив препарат із групи муколітиків — стимулятор синтезу сурфактанта. Укажіть цей лікарський засіб.', 'medium', 12, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преноксдіазин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію гідрокарбонат', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Теофілін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амброксол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: хронічний бронхіт, призначили муколітичний та відхаркувальний лікарський засіб. Вкажіть цей препарат:', 'medium', 13, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амброксол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кодеїн', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глауцину гідрохлорид', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парацетамол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту діагностовано хронічний бронхіт та призначено муколітичний препарат, що підвищує синтез сурфактанту. Який лікарський засіб використано для лікування пацієнта?', 'medium', 14, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амброксол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилцистеїн', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенотерол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кодеїн', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мукалтин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на хронічний бронхіт призначили муколітичний препарат, що підвищує синтез сурфактанту. Який препарат був використаний?', 'medium', 15, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мукалтин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенотерол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кодеїн', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амброксол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лібексин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікар швидкої допомоги був викликаний до жінки 40-ка років з приводу нападу бронхіальної астми з явищами стенокардії, лікар ввів хворій належний препарат. Який із наведених препаратів найбільш ефективний для невідкладної допомоги?', 'medium', 16, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Платифілін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атропін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки 38 років розвинувся напад бронхіальної астми. Який із наведених бронхолітиків є ефективним для надання невідкладної допомоги та належить до групи бета-2-адреноміметиків?', 'medium', 17, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іпратропію бромід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальметерол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Платифілін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 40-ка років страждає на бронхіальну астму та скаржиться на тахікардію протягом тривалого часу. Вкажіть найбільш оптимальний в даній ситуації препарат для купірування бронхоспазму:', 'medium', 18, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну гідрохлорид', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Орципреналіну сульфат', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрину гідрохлорид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки, яка хворіє на гіпертонічну хворобу, розвинувся напад бронхіальної астми. Який засіб слід призначити для зняття нападу?', 'medium', 19, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на бронхіальну астму не повідомив лікаря, що в нього бувають напади стенокардії. Лікар призначив препарат, після прийому якого напади бронхіальної астми стали рідшими, однак почастішали напади стенокардії. Який препарат був призначений?', 'medium', 20, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенотерол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кромолін-натрій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При черговому нападі бронхіальної астми хворий з допомогою інгалятора вдихнув препарат, який в вигляді інгаляцій використовується як бронхолітик, а в ін''єкціях - в акушерській практиці для попередження викиднів. Який препарат був використаний хворим?', 'medium', 21, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенотерол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дванадцятирічної дитини вірусна інфекція ускладнилася обструктивним бронхітом. Препарат якої фармакологічної групи необхідно призначити для інгаляцій із метою усунения бронхоспазму?', 'medium', 22, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В2-адреноблокатори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аналентики', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В2-адреноміметики', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Н-холіноміметики', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М-холіноміметики', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дванадцятирічної дитини вірусна інфекція ускладнена обструктивним бронхітом. Препарат якої фармакологічної групи необхідно призначити для інгаляцій із метою усунення бронхоспазму?', 'medium', 23, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Н-холіноміметики', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аналептики', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М-холіноміметики', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β2-адреноміметики', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β2-адреноблокатори', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка з діагнозом: бронхіальна астма, тривалий час лікувалася глюкокортикоїдами. Після різкого припинення лікування відчула погіршення стану, яке проявлялось падінням артеріального тиску і відновленням нападів бронхіальної астми. Для якого патологічного стану є характерним наявність таких симптомів?', 'medium', 24, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізація', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Акумуляція', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром відміни', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '–', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із бронхіальною астмою довгий час приймав преднізолон. Який механізм дії цього препарату?', 'medium', 25, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмування активності фосфоліпази А2', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада гістамінових рецепторів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада лейкотрієнових рецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення активності дигідрофолатредуктази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада натрієвих каналів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із бронхіальною астмою тривалий час приймає преднізолон. Який механізм дії цього препарату?', 'medium', 26, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада натрієвих каналів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада лейкотрієнових рецепторів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада гістамінових рецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмування активності фосфоліпази А', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення активності дигідрофолатредуктази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка страждає на тяжку форму бронхіальної астми. За призначенням лікаря тривалий час отримує гормональну терапію. До яких ускладнень може призвести тривала терапія глюкортикоїдами?', 'medium', 27, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковокам’яної хвороби', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Феохромоцитоми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої надниркової недостатності', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальної гіпертензії', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хвороби Іценко-Кушинга', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт, відчувши передвісники нападу бронхіальної астми, прийняв перорально без контролю лікаря кілька таблеток через короткі проміжки часу. Проте нетривале покращения стану відзначив тільки після вживання перших двох таблеток. Наступні прийоми препарату не покращили його стан. Яким явищем зумовлене зниження ефекту препарату?', 'medium', 28, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Залежністю', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляцією', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксією', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звиканням', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіосинкразією', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта напади бронхіальної астми виникають зазвичай уночі та супроводжуються брадикардіею, спастичним болем у кишечнику та діареєю. Препарати якої групи можуть усунути ці симптоми?', 'medium', 29, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'а-адреноблокатори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'в-адреноблокатори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М-холіноблокатори', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Н-холіноблокатори, Н2-гістамінодлокатори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатолітики', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора на бронхіальну астму приймала протягом 3-х місяців преднізолон у таблетках. Внаслідок значного покращення стану раптово припинила його прийом. Розвиток якого ускладнення високоймовірний у цьому випадку?', 'medium', 30, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдрому відміни', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ожиріння верхньої половини тулуба', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотонії', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлункової кровотечі', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдрому Іценка-Кушинга', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора на бронхіальну астму приймала протягом 2-х місяців преднізолон у таблетках. Внаслідок значного покращання стану раптово припинила його прийом. Розвиток якого ускладнення високоімовірний у цьому випадку?', 'medium', 31, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотонія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ожиріння верхньої половини тулуба', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Іценко-Кушинга', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром відміни', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлункова кровотеча', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на бронхіальну астму призначено інгаляції 0,5% розчину ізадрину. Бронхоспазм був усунутий, але пацієнт почав скаржитися на болі в серці та серцебиття. Це пов''язано зі стимуляцією:', 'medium', 32, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β1-адренорецепторів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтезу ацетилхоліну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β2-адренорецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'α1-адренорецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М-холінорецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого напади бронхіальної астми виникають зазвичай вночі, супроводжуються брадикардією, спастичними болями у кишечнику, проносом. Препарати якої групи можуть усунути ці симптоми?', 'medium', 33, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М-холіноблокатори', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Салуретики', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β-адреноблокатори', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Н-холіноблокатори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатолітики', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора на бронхіальну астму приймала таблетки, які викликали безсоння, головний біль і підвищення артеріального тиску. Який препарат міг стати причиною таких ускладнень?', 'medium', 34, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кромолін натрію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для попередження нападу бронхіальної астми лікар призначив хворому кромолін натрію. Який з наведених механізмів характерний для цього?', 'medium', 35, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стабілізація мембран тучних клітин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інактивація гістаміну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження концентрації імуноглобулінів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зв''язування вільного гістаміну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада гістамінових рецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При черговому нападі бронхіальної астми хворий з допомогою інгалятора вдихнув препарат, який в вигляді інгаляцій використовується як бронхолітик, а в ін''єкціях - в акушерській практиці для попередження викиднів. Який препарат був використаний хворим?', 'medium', 36, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенотерол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка з діагнозом: бронхіальна астма, тривалий час лікувалася глюкокортикоїдами. Після різкого припинення лікування відчула погіршення стану, яке проявлялось падінням артеріального тиску і відновленням нападів бронхіальної астми. Для якого патологічного стану є характерним наявність таких симптомів?', 'medium', 37, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Акумуляція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром відміни', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізація', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на миготливу аритмію, у якого в анамнезі бронхіальна астма, треба призначити протиаритмічний засіб. Який препарат з цієї групи протипоказаний хворому?', 'medium', 38, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новокаїнамід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аймалін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт довгий час хворіє на бронхіальну астму. Останнім часом у нього зʼявилися напади стенокардії. Який із нижченаведених препаратів йому протипоказано призначати?', 'medium', 39, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранолол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дипіридамол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якому з антигіпертензивних лікарських засобів лікар віддасть перевагу, якщо відомо, що артеріальна гіпертензія асоційована з бронхіальною астмою, цукровим діабетом 2-го типу та дисліпідемією?', 'medium', 40, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранолол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глібенкламід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аторвастатин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на миготливу аритмію, в анамнезі якого бронхіальна астма, треба призначити протиаритмічний засіб. Який препарат з цієї групи ПРОТИПОКАЗАНИЙ хворому?', 'medium', 41, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новокаїнамід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аймалін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на миготливу аритмію, у якого в анамнезі бронхіальна астма, треба призначити протиаритмічний засіб. Який препарат з цієї групи протипоказаний хворому?', 'medium', 42, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новокаїнамід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аймалін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Новонародженому з асфіксією введено препарат для прямої стимуляції дихального центру, який має протизапальну, протиалергічну та бронхолітичну дії, а також пригнічує кору головного мозку і не викликає судом. Який із нижченаведених препаратів має такі властивості?', 'medium', 43, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бемегрид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нікетамід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Камфора', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лобелін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Етимізол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дитина народилася в стані асфіксії. Який препарат необхідно ввести новонародженому для стимуляції дихання?', 'medium', 44, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атропін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прозерин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лобелін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Етимізол', true, 4, NOW(), NOW());

  RAISE NOTICE 'Додано питань: 45';
END $$;
