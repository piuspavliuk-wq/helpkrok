-- SQL для додавання питань до розділу 6: Клітинні процеси адаптації і компенсації
-- Автоматично згенеровано
-- Кількість питань: 32

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
  v_order_index INTEGER := 0;
BEGIN
  -- Знаходимо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Фундаментальні медико-біологічні знання'
  LIMIT 1;
  
  IF v_course_id IS NULL THEN
    RAISE EXCEPTION 'Курс "Фундаментальні медико-біологічні знання" не знайдено';
  END IF;
  
  -- Створюємо або знаходимо topic для розділу 6
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Клітинні процеси адаптації і компенсації'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Клітинні процеси адаптації і компенсації',
      'Тести з клітинних процесів адаптації і компенсації',
      0,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;
  
  RAISE NOTICE 'Початок додавання питань для розділу 6...';
  RAISE NOTICE 'Topic ID: %', v_topic_id;
  
  -- Видаляємо старі питання та їх варіанти відповідей
  DELETE FROM question_options
  WHERE question_id IN (
    SELECT id FROM questions WHERE topic_id = v_topic_id
  );
  
  DELETE FROM questions
  WHERE topic_id = v_topic_id;
  
  RAISE NOTICE 'Старі питання видалено. Додаємо нові питання...';

  -- Питання 1
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При відтворенні артеріальної гіпертензії у собаки через 1 місяць товщина стінки лівого шлуночка зросла в 1,7 рази, а об’єм циркулюючої крові не змінився порівняно з вихідними даними. Яка стадія гіпертрофії міокарда спостерігається у тварини?',
    'medium',
    0,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Початкова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпенсації',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прогресуючого кардіосклерозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аварійна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закінчена гіпертрофія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 2
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При проходженні профілактичного огляду у шахтаря лікар встановив зміни функціонального стану серця, що свідчать про серцеву недостатність у стадії компенсації. Що з нижче перерахованого є головним підтвердженням компенсації діяльності серця?',
    'medium',
    1,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ціаноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення артеріального тиску',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тахікардія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Задишка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 3
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження слизової оболонки матки знайдено звивисті залози, пилко- та штопороподібні, подовжені, розростання строми з гіперплазією її клітин. Який найбільш вірогідний діагноз?',
    'medium',
    2,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий ендометрит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пухирний занос',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плацентарний поліп',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Залозиста гіперплазія ендометрія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейоміома',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 4
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінці з дисфункціональною матковою кровотечею зробили діагностичне вишкрябання. Гістологічно у зіскрібку виявлено велику кількість звивистих залоз, просвіти окремих залоз кістозно розширені. Назвіть різновид загальнопатологічного процесу в ендометрії:',
    'medium',
    3,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаплазія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофічні розростання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дисплазія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Залозисто-кістозна гіперплазія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 5
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 30 років під час лабораторного аналізу крові виявлено: кількість еритроцитів 6 на 10в12/л, гемоглобіну - 10,55 ммоль/л. Діагностовано хворобу Вакеза. Укажіть провідну ланку патогенезу.',
    'medium',
    4,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дефіцит вітаміну В12',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дефіцит заліза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія еритроїдного відростка пухлинної природи',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 6
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 37 років, який палить протягом 19 років, звернувся із скаргами на постійний кашель. Під час біопсії бронха виявлено: ознаки хронічного запалення, потовщення слизової оболонки, трансформація одношарового війчастого епітелію в багатошаровий плоский епітелій. Який патологічний процес спостерігається у пацієнта?',
    'medium',
    5,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоплакія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія епітелію',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаплазія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дисплазія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія епітелію',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 7
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження біоптату, який отримали із нижньої третини стравоходу чоловіка віком 57 років із симптомами тривалого рефлюксу шлункового вмісту, виявлено такі зміни: у слизовій оболонці на місці багатошарового плоского епітелію визначається одношаровий залозистий призматичний епітелій, з ознаками продукції слизу. Укажіть патологічний процес, який виник у слизовій оболонці пацієнта.',
    'medium',
    6,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Регенерація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Організація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаплазія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 8
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В ході гістологічного дослідження біоптату, отриманого з нижньої третини стравоходу 57-річного чоловіка з симптомами тривалого рефлюксу шлункового вмісту, виявлено наступні зміни: у слизовій оболонці на місці багатошарового плаского епітелію спостерігається одношаровий залозистий призматичний епітелій, з ознаками продукції слизу. Вкажіть патологічний процес, який виник у слизовій оболонці:',
    'medium',
    7,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Організація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Регенерація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаплазія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 9
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В біоптаті бронха хворого, який зловживає палінням, в потовщеній слизовій оболонці виявлено хронічний обструктивний бронхіт з ознаками трансформації одношарового війчастого епітелія в багатошаровий плоский епітелій. Який з процесів найбільш імовірний?',
    'medium',
    8,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаплазія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоплакія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плоскоклітинний рак',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія епітелію',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія епітелію',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 10
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під дією негативних чинників довкілля порушена функція міосателітоцитів. Зміну якої функції всього м’язового волокна слід очікувати в даному випадку?',
    'medium',
    9,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трофіка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скоротливий термогенез',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скорочення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Регенерація',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 11
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнтки за два тижні після видалення зуба відбулася регенерація багатошарового плоского епітелію. Які органели брали участь у відновленні слизової оболонки?',
    'medium',
    10,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рибосоми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гладкий ЕПР',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Центросоми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постлізосоми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мітохондрії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 12
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після перелому великогомілкової кістки відбувається надмірна продукція кісткової тканини - екзостоз. Визначте, який вид регенерації спостерігається у нього?',
    'medium',
    11,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фізіологічна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патологічна надмірна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патологічна недостатня',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Репаративна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '–',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 13
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У результаті патологічного процесу в бронхах відбувається десквамація епітелію. За рахунок яких клітин відбуватиметься регенерація бронхіального епітелію?',
    'medium',
    12,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вставочні',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Келихоподібні',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендокринні',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Базальні',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Війчасті',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 14
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До травматологічного пункту доставлено хворого з пошкодженням м''язів нижніх кінцівок. За рахунок яких клітин можлива репаративна регенерація м''язових волокон і відновлення функції м''язів?',
    'medium',
    13,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міофібробластів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібробластів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клітин-сателітів',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міобластів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міоепітеліальних клітин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 15
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гастритах, як правило, ушкоджуються залози слизової оболонки шлунку. За рахунок яких клітин можлива їх регенерація?',
    'medium',
    14,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парієтальні',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Додаткові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Головні',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шийкові мукоцити',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендокринні',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 16
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До травматологічного пункту доставлено хворого з пошкодженням м’язів нижніх кінцівок. За рахунок яких клітин можлива репаративна регенерація м’язових волокон і відновлення функції м’язів?',
    'medium',
    15,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібробласти',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плазмоцити',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адипоцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міосателітоцити',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендотеліоцити',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 17
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після загоєння рани на її місці утворився рубець. Яка речовина є основним компонентом цього різновиду сполучної тканини?',
    'medium',
    16,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еластин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіалуронова кислота',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кератансульфат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хондроїтин-сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колаген',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 18
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відповідно до сучасної концепції атерогенезу «Response to injury», атеросклероз є проявом хронічного запалення в інтимі артерій. З якою стадією запалення пов’язане формування фіброзних бляшок у разі атеросклерозу?',
    'medium',
    17,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинна альтерація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Первинна альтерація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ексудація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферація',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансформація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 19
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На відміну від нервових клітин, які зазвичай не розмножуються, стовбурові клітини можуть відновлюватися багато разів. Процес багаторазового відновлення клітин називають:',
    'medium',
    18,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Диференціація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферація',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атрофія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 20
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який переніс травму і подальший геморагічний бурсит лівого колінного суглоба, під час огляду за 3 місяці відзначається обмеження обсягу рухів у цьому суглобі внаслідок утворення рубця. Який компонент запалення є провідним у розвитку цього ускладнення?',
    'medium',
    19,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альтерація первинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферація',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ексудація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альтерація вторинна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення мікроциркуляції',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 21
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Експериментально з бластоцисти людини одержано плюрипотентні ембріональні стовбурові клітини. Упродовж декількох місяців у лабораторії на поживному середовищі вони утворили мільйони нових клітин. Яку назву має процес багаторазового відновлення клітин?',
    'medium',
    20,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дозрівання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферація',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Диференціація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Репарація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 22
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На електронній мікрофотографії представлена клітина макрофагічної природи, вздовж відростків якої розташовуються еритроцити на різних стадіях диференціювання. Клітина якого органу представлена?',
    'medium',
    21,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мигдалик',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Селезінка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тимус',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Червоний кістковий мозок',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфатичний вузол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 23
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У результаті радіаційного випромінювання ушкоджені стовбурові гемопоетичні клітини. Утворення яких клітин сполучної тканини буде порушено?',
    'medium',
    22,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Періцити',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макрофаги',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адіпоцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Меланоцити',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібробласти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 24
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У гістологічному препараті визначаються рецепторна зона сенсоепітеліального органа чуттів. Клітини даної зони лежать на базальній мембрані й включають наступні види: зовнішні та внутрішні сенсорні, зовнішні та внутрішні фалангові, стовбурові, зовнішні межові і зовнішні підтримуючі. Вкажіть, якому органу чуттів належить зазначена рецепторна зона:',
    'medium',
    23,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Слуху',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зору',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нюху',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Смаку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рівноваги',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 25
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У гістологічному препараті визначаються рецепторна зона сенсоепітеліального органа чуттів. Клітини даної зони лежать на базальній мембрані і включають наступні види: зовнішні та внутрішні сенсорні, зовнішні та внутрішні фалангові, стовбурові, зовнішні межові і зовнішні підтримуючі. Вкажіть, якому органу чуттів належить зазначена рецепторна зона:',
    'medium',
    24,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органу зору',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органу смаку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органу слуху',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органу рівноваги',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органу нюху',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 26
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У клініці для лікування інфаркту міокарда пацієнту введено ембріональні стовбурові клітини, що одержано шляхом терапевтичного клонування в цього ж пацієнта. Як називається цей вид трансплантації?',
    'medium',
    25,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетеротрансплантація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксенотрансплантація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алотрансплантація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізотрансплантація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутотрансплантація',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 27
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У результаті інфаркту міокарда відбулося пошкодження ділянки серцевого мʼяза, яке супроводжується масовою загибеллю кардіоміоцитів. Які клітинні елементи забезпечать заміщення утвореного дефекту в структурі міокарда?',
    'medium',
    26,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міосателітоцити',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епітеліоцити',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Непосмуговані міоцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібробласти',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіоміоцити',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 28
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворих із синдромом набутого імунодефіциту (СНІД) різко знижується імунологічна реактивність, що проявляється розвитком хронічних запальних процесів, інфекційних захворювань, пухлинного росту. Клітини якого типу ушкоджує ВІЛ-інфекція, внаслідок чого знижується імунний захист?',
    'medium',
    27,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Т-супресори',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Природні кілери (NK)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'В-лімфоцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Т4-хелпери',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Т8-ефектори',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 29
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини нормальна чутливість шкіри пальця, але він не відчуває наявності на ньому обручки. Який процес, спричинений впливом обручки, є причиною цього?',
    'medium',
    28,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення структури рецепторів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення структури епідермісу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення кровообігу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвиток фіброзної тканини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адаптація рецепторів',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 30
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людей, які постійно проживають в гірській місцевості, адаптація до ''кисневого голодування'' здійснюється шляхом полегшеної віддачі кисню гемоглобіном внаслідок:',
    'medium',
    29,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниженого утворення 2,3- дифосфогліцерату в еритроцитах',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зростання парціального тиску CO2',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищеного утворення 2,3- дифосфогліцерату в еритроцитах',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження температури крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення pH крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 31
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В експерименті на білого щура подіяли стресовим фактором (електричним струмом) і спостерігали після цього гіпотонію м''язів, артеріальну гіпотензію, гіпотермію, гіпоглікемію. Який період загального адаптаційного синдрому у щура?',
    'medium',
    30,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фаза протишоку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фаза шоку',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стадія резистентності',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стадія виснаження',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 32
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Реалізація загального адаптаційного синдрому здійснюється переважно через нейроендокринну систему. Якій із ланок цієї системи належить провідна роль у патогенезі реакції, що розвивається?',
    'medium',
    31,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофізарно-тиреоїдна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофізарно-інсулярна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофізарно-адреналова',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофізарно-юкстагломерулярна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофізарно-адреногенітальна',
    false,
    4,
    NOW(),
    NOW()
  );
  
  RAISE NOTICE 'Додано питань: 32';
END $$;
