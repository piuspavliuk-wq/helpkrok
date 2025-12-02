-- SQL для додавання питань до розділу 9: Температурний гомеостаз і його порушення/ Гіпоксія/ Порушення метаболізму
-- Автоматично згенеровано
-- Кількість питань: 274

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
  
  -- Створюємо або знаходимо topic для розділу 9
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Температурний гомеостаз і його порушення/ Гіпоксія/ Порушення метаболізму'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Температурний гомеостаз і його порушення/ Гіпоксія/ Порушення метаболізму',
      'Тести з температурного гомеостазу, гіпоксії та порушень метаболізму',
      0,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;
  
  RAISE NOTICE 'Початок додавання питань для розділу 9...';
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
    'При обстеженні хворого виявлено наступні клінічні прояви: шкірні покриви рожеві, теплі на дотик, сухі, ЧСС - 92 / хв., ЧД - 22 / хв., Температура тіла - 39,2 ° С. Яке співвідношення процесів утворення і віддачі тепла в описаному періоді лихоманки?',
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
    'Теплопродукція дорівнює тепловіддачі',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопродукція перевищує тепловіддачу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення теплопродукції без зміни тепловіддачі',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження тепловіддачі на фоні незміненої теплопродукції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопродукція нижче тепловіддачі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 2
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лікарню наприкінці робочого дня доставлений робітник ’’гарячого” цеху, який скаржиться на головний біль, запаморочення, нудоту, загальну слабкість. Об’єктивно: свідомість збережена, шкірні покриви гіперемовані, сухі, гарячі на дотик. Частота серцевих скорочень - 130/хв. Дихання часте, поверхневе. Яке порушення процесів терморегуляції, найбільш імовірно, виникло у людини в даній ситуації"?',
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
    'Зниження тепловіддачі',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення тепловіддачі і зниження теплопродукції',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення тепловіддачі і теплопродукції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення теплопродукції без змін тепловіддачі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження теплопродукції без змін тепловіддачі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 3
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Рівень теплопродукції у людини, яка перебуває в стані глибокого наркозу із застосуванням міорелаксантів і гангліоблокаторів:',
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
    'Не змінюється',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищується',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Знижується',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спочатку не змінюється, а потім підвищується',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 4
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після введення пірогену у хворого підвищилася температура тіла, шкірні покриви стали блідими, холодними на дотик, з’явилася остуда, збільшилося споживання кисню. Яка зміна у процесах терморегуляції буде спостерігатися, насамперед, під час описаного періоду лихоманки?',
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
    'Збільшення теплопродукції',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження тепловіддачі',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження теплопродукції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тепловіддача та теплопродукція перебувають у рівновазі',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 5
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 38 років скаржиться на підвищену пітливість, серцебиття, підвищення температури тіла у вечірні години. Основний обмін збільшений на 60%. Лікар встановив діагноз тиреотоксикоз. Які властивості тироксину приводять до підсилення теплопродукції?',
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
    'Розщеплює окисне фосфорилювання',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшує дезамінування амінокислот',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сприяє накопиченню ацетил-КоА',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищує спряження окиснення та фосфорилування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшує в-окиснення жирних кислот',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 6
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після введення пірогену у хворого підвищилася температура тіла, шкірні покриви стали блідими, холодними на дотик, з’явилася остуда, збільшилося споживання кисню. Яка зміна у процесах терморегуляції буде спостерігатися, насамперед, під час описаного періоду лихоманки?',
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
    'Знижується тепловіддача',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тепловіддача дорівнює теплопродукції',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшується тепловіддача',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшується теплопродукція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Знижується теплопродукція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 7
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лікарню наприкінці робочого дня доставлений робітник ''гарячого'' цеху, який скаржиться на головний біль, запаморочення, нудоту, загальну слабкість. Об’єктивно: свідомість збережена, шкірні покриви гіперемовані, сухі, гарячі на дотик. ЧСС- 130/хв. Дихання часте, поверхневе. Яке порушення процесів терморегуляції, найбільш імовірно, виникло у людини в даній ситуації?',
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
    'Зниження теплопродукції без змін тепловіддачі',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення тепловіддачі і зниження теплопродукції',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення тепловіддачі і теплопродукції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження тепловіддачі',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення теплопродукції без змін тепловіддачі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 8
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка віком 40 років скаржиться на тремтіння рук, серцебиття, постійну гіпертермію, втрату ваги. В аналізі крові виявлено: підвищення рівня глюкози, жирних кислот та амінокислот. Гіперпродукція яких гормонів викликає ці симптоми?',
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
    'Інсуліну',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Йодтиронінів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматотропінів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кортикотропіну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкокортикоїдів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 9
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час профілактичного огляду пацієнта виявлено потовщення шиї, екзофтальм, підвищення температури тіла, пульс - 110/хв. Уміст яких гормонів необхідно визначити у крові?',
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
    'Інсуліну',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тироксину',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кортизолу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Статевих гормонів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Катехоламінів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 10
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворих на тиреотоксикоз спостерігаються гіпертермія, булімія, зменшення маси тіла, що пов’язане з порушенням:',
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
    'в-окиснення жирних кислот',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синтезу жирів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклу лимонної кислоти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спряження окислення і фосфорилювання',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розпаду АТФ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 11
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки, у якої наявний тиреотоксикоз, спостерігається роз’єднання окисного фосфорилювання. До яких змін це призводить?',
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
    'Теплоутворення не змінюється',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення утворення АТФ',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення теплоутворення',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення теплоутворення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '3меншення частки вільного окислення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 12
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Охолодження тіла людини у воді виникає значно швидше, ніж на повітрі, тому, що у воді значно ефективнішою є віддача тепла шляхом:',
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
    'Конвекції',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування поту',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тепловипромінювання',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 13
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Віддачу тепла яким шляхом збільшують люди, які приймають прохолодний душ у спекотні дні?',
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
    'Конвекція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випромінювання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування поту',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 14
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пасажири автобуса у спекотну погоду попросили відкрити люки. Який шлях тепловіддачі при цьому зростає найбільше?',
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
    'Випромінювання та теплопроведення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випромінювання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування поту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 15
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який механізм тепловіддачі найбільш ефективно спрацьовує при перебуванні людини в умовах 80% вологості повітря та температурі навколишнього середовища +35oC?',
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
    'Теплопровідність',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Потовиділення',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 16
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У холодну погоду з вітром люди замерзають швидше, ніж за відсутності вітру. Причиною цього є те, що вітер, вперш за все, збільшує віддачу тепла шляхом:',
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
    'Випаровування',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекції',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 17
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При термометрії встановлено, що температура відкритих ділянок шкіри на 1-1,5° нижче за температуру поруч розташованих ділянок, закритих одягом з натуральних тканин. Причиною цього є те, що одяг, перш за все, зменшує тепловіддачу таким шляхом:',
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
    'Радіація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проведення',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 18
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Досліджують процеси тепловіддачі у роздягненої людини при кімнатній температурі. З''ясовано, що за таких умов найбільша кількість тепла віддається шляхом:',
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
    'Теплопроведення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплорадіацїї',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 19
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина знаходиться в середовищі з темепературою 38 градусів С, відносною вологістю повітря 50%. Які шляхи тепловіддачі зумовлюють підтримку постійної температури ядра тіла за цих умов?',
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
    'Конвекція і теплопроведення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 20
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина вийшла з кондиційованого приміщення на вулицю, де температура повітря дорівнює +40°С, вологість повітря - 60%. Віддача тепла з організму на вулиці буде здійснюватися за рахунок:',
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
    'Конвекції',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проведення',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування поту',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 21
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Віддачу тепла яким шляхом збільшують люди, які приймають прохолодний душ у спекотні дні?',
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
    'Конвекція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випромінювання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування поту',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 22
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина потрапила у крижану воду й швидко загинула в результаті різкого переохолодження. Це відбулося тому, що в даному випадку значно збільшилась віддача тепла організмом таким шляхом:',
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
    'Теплопроведення',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення і радіація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 23
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина вийшла з кондиціонованого приміщення назовні, де немає вітру, температура повітря +38*C, вологість 64%. За рахунок якого механізму буде здійснюватися віддача тепла організмом за цих умов?',
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
    'Випаровування поту',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кондукція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплорадіація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 24
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який шлях віддачі тепла тілом робітників парникового господарства є найефективнішим при температурі повітря 36*C та відносній його вологості-70%?',
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
    'Випаровування рідини',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплорадіація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 25
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина знаходиться в середовищі з температурою 38oC та відносною вологістю повітря 50%. Які шляхи тепловіддачі зумовлюють підтримку постійної температури ядра тіла за цих умов?',
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
    'Конвекція й теплопроведення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 26
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Робітники парникового господарства працюють в умовах несприятливого мікроклімату: температура повітря +37oC, відносна вологість 90%, швидкість руху повітря 0,2 м/с. Яким шляхом здійснюється тепловіддача за цих умов?',
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
    'Випаровування',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі зазначені шляхи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 27
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина стоїть в кімнаті в легкому одязі, температура повітря +14°С. Вікна та двері закриті. Яким шляхом він віддає більше всього тепла?',
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
    'Теплорадіація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Випаровування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перспірація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 28
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який механізм тепловіддачі найбільш ефективно спрацьовує при перебуванні людини в умовах 80% вологості повітря і температурі навколишнього середовища +35°С?',
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
    'Потовиділення',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопровідність',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 29
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який шлях віддачі тепла тілом робітників парникового господарства є найефективнішим при температурі повітря 36*C та відносній його вологості-70%?',
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
    'Випаровування рідини',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конвекція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплорадіація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теплопроведення',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 30
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак 15-ти років після переохолодження був доставлений в лікарню зі скаргами на біль, озноб. При огляді «гусяча шкіра», блідість, температура поступово підвищується. Яка стадія гарячки спостерігається у хворого?',
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
    'St. fastigii',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'St. incrementi',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'St. inflamenti',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'St. absorbi',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'St. decrement',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 31
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 25 років скаржиться на загальну слабкість, озноб, біль у горлі. Об''єктивно спостерігається: почервоніння в ділянці мигдаликів. Температура тіла - 38,6^oС. Які з наведених клітин є головним джерелом ендогенних пірогенів, що викликають гарячку у пацієнта?',
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
    'В-лімфоцити',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Базофіли',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тучні клітини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еозинофіли',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейтрофіли',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 32
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який із нижченаведених медіаторів запалення має властивості ендогенного пірогену?',
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
    'Гістамін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Брадикінін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтерлейкін 1',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серотонін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоксан А2',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 33
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після введення пірогену у хворого підвищилася температура тіла, шкірні покриви стали блідими, холодними на дотик, з’явилася остуда, збільшилося споживання кисню. Яка зміна у процесах терморегуляції буде спостерігатися, насамперед, під час описаного періоду лихоманки?',
    'medium',
    32,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення теплопродукції',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження тепловіддачі',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження теплопродукції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тепловіддача та теплопродукція перебувають у рівновазі',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 34
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В експерименті на кролику введення пірогеналу призвело до підвищення у тварини температури тіла. Яка з перерахованих речовин відіграє роль вторинного пірогену, що бере участь у механізмі виникнення лихоманкової реакції?',
    'medium',
    33,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтерлейкін-1',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піромен',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Брадикінін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноглобулін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістамін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 35
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який хворіє грипом спостерігаються: висока температура, задишка, тахікардія. Як зміниться спорідненість Hb до кисню за таких умов?',
    'medium',
    34,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змін не відбувається',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшується',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спочатку зростає, а потім зменшується',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зростає',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 36
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого діагностовано септичний ендокардит. Температура тіла протягом 5-ти днів коливалася в межах 39,5oC -40,2oC. На 6-й день на тлі різкого зниження температури до35,2oC розвинувся колапс. Який головний механізм колапсу?',
    'medium',
    35,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вазодилатація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліурія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилене потовиділення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпервентиляція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тахікардія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 37
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка після повернення з роботи спостерігається дертя в горлі, біль у м’язах, підвищення температури тіла до 38,5°C. Який механізм підвищення температури є найбільш раннім на першій стадії формування лихоманки?',
    'medium',
    36,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'М’язовий термогенез',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення ЧСС',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шкірна вазоконстрикція',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення потовиділення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація окислювальних процесів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 38
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 36-ти років розвинулася гарячка, яка супроводжувалася зміщенням установчої точки терморегуляційного центру на більш високий рівень, з послідовним чергуванням наступних стадій: Incrementi, fastigii, decrementi. При якому захворюванні можуть спостерігатися подібні зміни?',
    'medium',
    37,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра пневмонія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Акромегалія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ренальний діабет',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертрофія міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 39
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини виявлено спадкове захворювання шкіри ангідроз (відсутність потових залоз). Унаслідок цього порушені важливі функції шкіри - потовиділення та терморегуляція. Ця вада є наслідком порушення в ембріогенезі закладки:',
    'medium',
    38,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматому',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спланхнотому',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Склеротому',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ектодерми',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 40
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час оперативного втручання із застосуванням інгаляційного наркозу та міорелаксантів, лікар-анестезіолог помітив у пацієнта швидке підвищення температури тіла (до 43°С). Яка патологія розвинулася у пацієнта?',
    'medium',
    39,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фізіологічна гіпертермія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фізична гіпертермія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертермічний синдром',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перегрівання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфекційна гарячка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 41
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Крива дисоціації оксигемоглобіну зміщена вправо. Які зміни в організмі людини можуть бути причиною цього?',
    'medium',
    40,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертермія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення концентрації 2,3-дифосфогліцерату в еритроцитах',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпокапнія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 42
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    '* У пацієнта після травми в ділянці ліктьового суглоба з''явилось утруднення під час згинання 4-го і 5-го пальців кисті, зменшився в розмірах виступ мізинця. Під час огляду виявлено зниження больової та температурної чутливості в ділянці 4-го і 5-го пальців на долонній поверхні і 5-го та частково 4-го пальця на тильній поверхні кисті. Який нерв пошкоджено внаслідок травми?',
    'medium',
    41,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліктьовий',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'М''язово-шкірний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Присередній шкірний нерв передпліччя',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Променевий',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серединний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 43
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностовано абсцес лівої пахвинної ділянки. Скаржиться на загальну слабкість, підвищення температури тіла ввечері до 38,5^oC, що нормалізується вранці, а також на болючість та почервоніння шкіри в ділянці локалізації абсцесу. Укажіть тип температурної кривої у цього пацієнта?',
    'medium',
    42,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris acontinua',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris hectica',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris recurrens',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris continua',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris remittens',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 44
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який хворіє на крупозну пневмонію, спостерігається гарячка з температурою тіла 39°С. Водночас добові коливання температури не перевищують 1°С упродовж 9 діб. До якого типу температурних кривих відноситься гарячка у чоловіка?',
    'medium',
    43,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпіретична',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ремітуюча',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постійна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гектична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поворотна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 45
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на крупозну пневмонію має місце гарячка з температурою тіла 39°С, при цьому добові коливання температури не перевищували 1°С впродовж 9-ти діб. До якого типу температурних кривих відноситься ця гарячка?',
    'medium',
    44,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поворотна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постійна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпіретична',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гектична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ремітуюча',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 46
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта 36-ти років після дорожньої травми виникли параліч м’язів кінцівок справа, втрата больової і температурної чутливості зліва, часткове зниження тактильної чутливості з обох сторін. Для ураження якого відділу мозку вказані зміни є найбільш характерними?',
    'medium',
    45,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Права половина спинного мозку',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Задні стовпи спинного мозку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передні стовпи спинного мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва половина спинного мозку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рухова кора зліва',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 47
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 33-х років як наслідок спинномозкової травми порушена больова та температурна чутливість, що обумовлено пошкодженням такого шляху:',
    'medium',
    46,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спіноталамічного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Заднього спіномозочкового',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Латерального спінокортикального',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Переднього спіномозочкового',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Медіального спінокортикального',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 48
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В клініку доставлено чоловіка з травмою спини. Під час обстеження виявлено перелом хребців грудного відділу. Під час об’єктивного огляду нейрохірургом виявлено: нижче рівня перелому з правого боку відсутня глибока чутливість, з лівого боку – порушена температурна та тактильна чутливість. Яке ураження з боку спинного мозку є у хворого?',
    'medium',
    47,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анестезія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Броун Секара',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Паркінсона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парастезія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Судомний синдром',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 49
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після перенесеного запального процесу хворий став помічати слабкість при згинанні кисті в ділянці 1,2, 3 і 4 пальців, зменшення об’єму м’яза підвищення великого пальця. При обстеженні виявлено порушення больової і температурної чутливості в ділянці поверхні долоні 1, 2, 3 і променевої поверхні четвертого пальців. Який із нервів уражений?',
    'medium',
    48,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліктьовий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Променевий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'М’язово-шкірний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серединний',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Присередній шкірний нерв передпліччя',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 50
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    '23-х років вдень раптово підвищилася температура до 39,5°C і через 6 годин повернулася до норми. На другу добу напад повторився і температура досягла 41,5°C. Період апірексії настав через 8 годин. Який тип температурної кривої?',
    'medium',
    49,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постійний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септичний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виснажуючий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Послаблюючий',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Переміжний',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 51
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворих на поворотний тиф виникає лихоманка, яка характеризується кількаденними періодами високої гарячки, що чергується з періодами нормальної температури. Така температурна крива називається:',
    'medium',
    50,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris hectica',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris recurrens',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris intermittens',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris continua',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris atypica',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 52
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 33-х років внаслідок спинномозкової травми порушена больова та температурна чутливість, що обумовлено пошкодженням таких висхідних шляхів:',
    'medium',
    51,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Задній спиномозочковий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Латеральний спинокортикальний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передній спиномозочковий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спиноталамічні',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Медіальний спинокортикальний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 53
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час операції на головному мозку відмічено, що подразнення певних зон кори великих півкуль викликало в хворого і тактильні і температурні відчуття. На яку зону кори діяли подразники?',
    'medium',
    52,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Верхня латеральна звивина',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парагіпокампова звивина',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прецентральна звивина',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поясна звивина',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постцентральна звивина',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 54
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого вдень піднялася температура тіла до 39 С і через 6 годин повернулася до норми. На другу добу напад повторився: в період пароксизму температура досягла 41 С, період апірексії настав через 8 годин. Як називається такий тип температурної кривої?',
    'medium',
    53,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постійний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтермітуючий',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зворотній',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гектичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 55
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після травми виникли паралічі, розлади больової чутливості справа; зліва - паралічі відсутні, але порушена больова і температурна чутливість. Яка причина такого явища?',
    'medium',
    54,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Однобічне пошкодження спинного мозку з правого боку',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження мозочка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження середнього мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження стовбура мозку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження рухової зони кори головного мозку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 56
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий взимку впав в ополонку, замерз на вітрі, захворів. Температура тіла підвищилася до 39,7°С і коливалася від 39,0°С до 39,8°С. Назвіть тип температурної кривої у хворого.',
    'medium',
    55,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris intermittens',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris hectica',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris continua',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris recurrens',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Febris remittens',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 57
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який переніс тяжке інфекційне захворювання з порушенням функції центральної нервової системи, температура тіла впродовж доби нестабільна, досягає різних значень кожні 2 год (більше і менше норми). Визначте причину добового коливання температури тіла.',
    'medium',
    56,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення периферичної мікроциркуляції',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження гіпоталамуса',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення кіркових процесів головного мозку',
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
    'Порушення кровообігу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 58
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який переніс важке інфекційне захворювання з порушенням функції центральної нервової системи (ЦНС), температура тіла впродовж доби нестабільна, досягає різних значень кожні 2 години (більше і менше норми). Визначте причину добового коливання температури тіла.',
    'medium',
    57,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження гіпоталамуса',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення кіркових процесів головного мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення кровообігу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення периферичної мікроциркуляції',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 59
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аварії на виробництві пацієнт зазнав токсичного впливу калію ціаніду, що спричинило блокаду цитохромоксидази. До якого патологічного процесу це призвело?',
    'medium',
    58,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинної гіпоксії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальної гіпоксії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічної гіпоксії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксичної гіпоксіяї',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторної гіпоксії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 60
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час бігу на короткі дистанції в нетренованої людини виникає м’язова гіпоксія. До накопичення якого метаболіту в м’язах це призводить?',
    'medium',
    59,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетонові тіла',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкозо-6-фосфат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксалоацетат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетил-КоА',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактат',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 61
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У крові пацієнта спостерігається зниження кількості еритроцитів, гемоглобіну, кольорового показника, концентрації сироваткового заліза, мікроанізоцитоз і пойкілоцитоз. Ці зміни супроводжуються розвитком гіпоксії. Який вид гіпоксії спостерігається в цьому разі?',
    'medium',
    60,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 62
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В альпіністів, які без кисневого спорядження підіймалися на висоті 5000 метрів над рівнем моря, виникла тахікардія, знизився артеріальний тиск, а дихання стало частим. Який тип гіпоксії розвинувся в альпіністів?',
    'medium',
    61,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксемічна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 63
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розвитку колапсу спостерігаються розлади функцій нервової системи, порушення газообмінної функції легень, розлади системи крові і гемостазу. Первинне виникнення якої гіпоксії зумовлює ці прояви колапсу?',
    'medium',
    62,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 64
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 40-ка років скаржиться на загальну слабкість, головний біль, кашель з виділенням мокротиння, задишку. Після клінічного огляду й обстеження поставлено діагноз: пневмонія. Який тип гіпоксії має місце у хворого?',
    'medium',
    63,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 65
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після ремонту автомобіля в закритому приміщенні при працюючому двигуні у чоловіка з’явилися задишка, запаморочення, акроціаноз, частота дихання 24-26/хв. Газовий склад крові: pO2 - 60 мм рт.ст., pCO2 - 30 мм рт.ст.; у крові наявний карбоксигемоглобін. Про який вид гіпоксії можна думати?',
    'medium',
    64,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 66
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікар-дослідник у складі альпіністської експедиції піднявся у базовий табір, розташований на висоті 5000 м. На 3-й день перебування у нього з’явилися ознаки гірської хвороби: задишка, головний біль, втрата апетиту, загальна слабкість, ціаноз. Який тип гіпоксії має місце в цьому випадку?',
    'medium',
    65,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішана',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 67
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 13 років знаходиться на стаціонарному лікуванні в гематологічному відділенні обласної дитячої лікарні з діагнозом залізодефіцитна анемія. Який тип гіпоксії має місце у цієї хворої?',
    'medium',
    66,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішана',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 68
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 56-ти років тривалий час хворіє на тиреотоксикоз. Який тип гіпоксії може розвинутися у цієї хворої?',
    'medium',
    67,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішана',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 69
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтку віком 65 років, яка довгий час хворіла на стеноз аортального клапана, після перенесеної вірусної інфекції шпиталізовано з ознаками хронічної серцево-судинної недостатності, задишкою, ціанозом, набряками. Який тип гіпоксії спостерігається в пацієнтки?',
    'medium',
    68,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторний',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 70
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 62 роки з хронічним обструктивним захворюванням легень спостерігається прогресуюча задишка та втома. В аналізі газів артеріальної крові спостерігається: гіпоксемія і підвищений рівень вуглекислого газу. Який механізм є головним у патогенезі його дихальної недостатності?',
    'medium',
    69,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Надмірна метаболічна потреба',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження легеневої вентиляції',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження рівня кисню в повітрі',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення шунтування крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення альвеолярної дифузії кисню',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 71
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розвитку колапсу спостерігаються розлади функцій нервової системи, порушення газообмінної функції легень, розлади системи крові і гемостазу. Первинне виникнення якої гіпоксії зумовлює ці прояви колапсу?',
    'medium',
    70,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторна',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 72
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта внаслідок хронічного захворювання органів дихання, що супроводжується задишкою, тахікардією і ціанозом, під час дослідження газового складу крові виявлено розвиток гіпоксемії і гіперкапнії. Яке порушення зовнішнього дихання спричинило зміни в газовому складі крові?',
    'medium',
    71,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперперфузія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпердифузія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпервентиляція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоперфузія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіповентиляція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 73
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До приймального відділення звернувся хворий зі скаргами на задишку. Температура тіла 39°С. На рентгенограмі легенів спостерігається двостороння пневмонія. Який вид гіпоксії розвинувся у пацієнта?',
    'medium',
    72,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серцево-судинна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кров''яна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 74
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час патологічних процесів, які супроводжуються гіпоксією, відбувається неповне відновлення молекули кисню в дихальному ланцюзі і накопичення пероксиду водню. Вкажіть фермент, який забезпечує його руйнування:',
    'medium',
    73,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каталаза',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сукцинатдегідрогеназа',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитохромоксидаза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аконітаза',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоглутаратдегідрогеназа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 75
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В підводному човні під час занурення порушилася система подачі кисню. У підводників збільшилися частота дихання і серцевих скорочень. Який вид гіпоксії розвинувся у підводників?',
    'medium',
    74,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серцево-судинна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксична',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кров’яна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 76
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вагітна жінка під час пологів втратила близько 800 мл крові. Спостерігається тахікардія, артеріальний тиск 100/70 мм рт.ст., тахіпное до 28/хв. Який тип гіпоксії розвивається первинно в такій клінічній ситуації ?',
    'medium',
    75,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішана',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кров’яна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серцево-судинна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 77
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий знаходиться на обліку в ендокринологічному диспансері з приводу гіпертиреозу. До схуднення, тахікардії, тремтіння пальців рук, приєдналися симптоми гіпоксії - головний біль, втомлюваність, мерехтіння ''мушок'' перед очима. Який механізм дії тиреоїдних гормонів лежить в основі розвитку гіпоксії?',
    'medium',
    76,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення синтезу дихальних ферментів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конкурентне гальмування дихальних ферментів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Роз’єднання окиснення та фосфорилювання',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування синтезу дихальних ферментів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Специфічне зв’язування активних центрів дихальних ферментів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 78
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Робочий комунальної служби спустився в каналізаційний колодязь без засобів захисту і через деякий час знепритомнів. Лікарями швидкої допомоги діагностовано отруєння сірководнем. Який вид гіпоксії при цьому розвинувся?',
    'medium',
    77,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантажувальний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемічний',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циркуляторний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 79
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Послаблення кровопостачання органа зумовлює розвиток гіпоксії, яка активізує функцію фібробластів. Об’єм яких елементів збільшується в цій ситуації?',
    'medium',
    78,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфатичні судини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нервові елементи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Судини мікроциркуляторного русла',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паренхіматозні елементи органа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міжклітинна речовина',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 80
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Зменшення кровопостачання органів обумовлює розвиток гіпоксії, яка активізує функцію фібробластів. Обсяг яких елементів збільшується в цій ситуації?',
    'medium',
    79,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Судин мікроциркуляторного русла',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфатичних судин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нервових елементів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міжклітинної речовини',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паренхіматозних елементів органу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 81
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Стеатоз виникає внаслідок накопичення триацилгліцеролів у гепа-тоцитах. Одним з механізмів розвитку цього захворювання є зменшення утилізації нейтрального жиру ЛПДНЩ. Які ліпотропні речовини попереджують розвиток стеатозу?',
    'medium',
    80,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізолейцин, B1 , B2',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метіонін, B6 , B12',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргінін, B2 , B3',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Валін, B3 , B2',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аланін, B1 , PP',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 82
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий після прийому жирної їжі відчуває нудоту, млявість. З часом з явилися ознаки стеатореї. В крові, холестерин - 9,2 ммоль/л. Причиною такого стану є нестача:',
    'medium',
    81,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирних кислот',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хіломікронів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовчних кислот',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфоліпідів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тригліцеридів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 83
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому 68-ми років в комплекс лікування атеросклерозу, ускладненого ішемічною хворобою серця, лікар включив гіполіпідемічний засіб, який знижує вміст в крові переважно тригліцеридів. Який із вказаних препаратів було призначено хворому?',
    'medium',
    82,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Преднізолон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анаприлін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенофібрат',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 84
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на ішемічну хворобу серця виявлено підвищений вміст тригліцеридів і ліпопротеїнів низької щільності в плазмі крові. Який препарат слід призначити?',
    'medium',
    83,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Добутамін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміодарон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лізиноприл',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фамотидин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенофібрат',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 85
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?',
    'medium',
    84,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гастрит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Запалення легенів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий панкреатит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження нирок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 86
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?',
    'medium',
    85,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Високої щільності',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холестерину',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проміжної щільності',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хіломікронів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Низької щільності',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 87
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині трупа чоловіка 47-ми років, померлого раптово, в інтимі черевного відділу аорти знайдені осередки жовтого кольору у вигляді плям та смуг, що не вибухають над поверхнею інтими. При фарбуванні суданом III спостерігається жовтогаряче забарвлення. Для якої стадії атеросклерозу характерні такі зміни?',
    'medium',
    86,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпоїдозу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпосклерозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атерокальцинозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стадія утворення атероматозної виразки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атероматозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 88
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 65-ти років, що страждає на атеросклероз, госпіталізований до хірургічного відділення з приводу розлитого гнійного перитоніту. Під час операції діагностовано тромбоз брижових артерій. Яка найбільш імовірна причина перитоніту?',
    'medium',
    87,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія компресійна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія ангіоспастична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 89
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця, порушень мозкового кровообігу рекомендується споживання жирів із високим вмістом поліненасичених жирних кислот. Однією з таких жирних кислот є:',
    'medium',
    88,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінолева',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пальмітоолеїнова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стеаринова',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Олеїнова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лауринова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 90
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 69-ти років довго хворіла на атеросклероз. Поступила в хірургічне відділення з симптомами гострого живота. При лапаротомії виявлені: тромбоз мезентеріальної артерії, петлі тонкої кишки набряклі, багряно-чорного кольору, на їх серозній оболонці фібринозні нашарування. Який патологічний процес розвинувся у кишці хворої?',
    'medium',
    89,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Секвестр',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коагуляційний некроз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Суха гангрена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волога гангрена',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 91
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий на атеросклероз приймає антисклеротичний засіб - фенофібрат. Який механізм дії має цей засіб?',
    'medium',
    90,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Знижує рівень хіломікронів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інгібує абсорбцію холестерину в ШКТ',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищує захоплення ліпопротеїдів низької щільності та блокує біосинтез ендогенного холестерину',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поновлює негативний електричний заряд ендотелію судин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліпшує мікроциркуляцію крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 92
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 75-ти років, який довгий час страждав на атеросклероз церебральних судин, на аутопсії виявлені: тромбоз правої середньої мозкової артерії, великий осередок неправильної форми сірого кашоподібного розм’якшення мозкової тканини. Який патологічний процес розвинувся в спинному мозку?',
    'medium',
    91,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коагуляційний некроз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гума мозку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 93
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Сучасні антиатеросклеротичні препарати застосовуються з метою профілактики та лікування атеросклерозу. Такі препарати як гемфіброзил та фенфібрат гальмують біосинтез холестерину шляхом інгібування ферменту:',
    'medium',
    92,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'бета-ГОМК-редуктаза',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гексокіназа',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкозо-6-фосфатаза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацил-КоА-холестеринацилтрансфераза',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 94
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця, порушень мозкового кровообігу рекомендується споживання жирів із високим вмістом поліненасичених жирних кислот. Однією з таких жирних кислот є:',
    'medium',
    93,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стеаринова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Олеїнова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пальмітоолеїнова',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лауринова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінолева',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 95
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині трупа чоловіка 47-ми років, померлого раптово, в інтимі черевного відділу аорти знайдені осередки жовтого кольору у вигляді плям та смуг, що не вибухають над поверхнею інтими. При фарбуванні суданом ІІІ спостерігається жовтогаряче забарвлення. Для якої стадії атеросклерозу характерні такі зміни?',
    'medium',
    94,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпосклерозу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпоїдозу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стадія утворення атероматозної виразки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атероматозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атерокальцинозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 96
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла хворого, що помер від серцевої недостатності, в інтимі аорти і коронарних судин виявлені жовтого кольору плями і смуги, що вибухають над поверхнею інтими сірувато-жовтуваті бляшки, а також вогнищеве виразкування даних бляшок з наявністю крововиливів, тромбозів і вогнищ звапнування. Для якого захворювання характерні вказані зміни судин?',
    'medium',
    95,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вузликовий періартеріїт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сифілітичний мезаортит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертонічна хвороба',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 97
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 60-ти років, що багато років страждає на атеросклероз і переніс раніше інфаркт міокарда, розвинувся напад загрудинного болю. Хворий госпіталізований через 3 дні; на фоні прогресуючої серцево-судинної недостатності помер. Під час розтину тіла у ділянці задньої стінки лівого шлуночка і міжшлуночкової перегородки виявлена ділянка білого кольору близько 3 см у діаметрі, волокниста, западаюча, з чіткою межею. Прозектор трактував ці зміни як:',
    'medium',
    96,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофія міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вогнищевий кардіосклероз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 98
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 75-ти років, який довгий час страждав на атеросклероз церебральних судин, на аутопсії в правій тім’яно-скроневої ділянці головного мозку виявлено вогнище неправильної форми, млявої консистенції, сірого кольору. Яка найбільш вірогідна причина розвитку цього процесу?',
    'medium',
    97,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз правої передньої мозкової артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз правої задньої мозкової артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз правої середньої мозкової артерії',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз базилярної артерії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз судини м’якої мозкової оболонки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 99
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 58-ми років хворіє на атеросклероз судин головного мозку. При обстеженні виявлена гіперліпідемія. Вміст якого класу ліпопротеїдів у сироватці крові даного чоловіка найбільш вірогідно буде підвищений?',
    'medium',
    98,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпопротеїди низької щільності',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хіломікрони',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплекси жирних кислот з альбумінами',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холестерин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпопротеїди високої щільності',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 100
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 70-ти років атеросклероз ускладнився тромбозом судин нижніх кінцівок, виникла гангрена пальців лівої стопи. Початок тромбоутворення, найбільш вірогідно, пов’язаний з:',
    'medium',
    99,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адгезією тромбоцитів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перетворенням фібриногену в фібрин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниженням синтезу гепарину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перетворенням протромбіну в тромбін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активацією протромбінази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 101
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?',
    'medium',
    100,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холестерин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проміжної щільності',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хіломікрони',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Низької щільності',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Високої щільності',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 102
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У процесі онтогенезу у людини на організменному рівні проявилися наступні зміни: зменшилася життєва ємність легень, збільшився артеріальний тиск, розвинувся атеросклероз. Який період онтогенезу найбільш вірогідний у цьому випадку?',
    'medium',
    101,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підлітковий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Похилий вік',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Юнацький',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Молодий вік',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Початок зрілого віку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 103
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину трупа жінки 69 років підвищеного живлення, яка померла від гострого інфаркту міокарда, в інтимі коронарних артерій знайдені численні білуваті, щільні, вибухаючі формування, що різко звужують просвіт судин. Для якої стадії атеросклерозу властиві такі зміни?',
    'medium',
    102,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атерокальциноз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпоїдоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атероматоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стадія утворення атероматозної виразки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпосклероз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 104
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження стінки аорти виявлено велику кількість ксантомних клітин, які розташовані переважно в інтимі. Для якого захворювання це характерно?',
    'medium',
    103,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклерозу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сифілітичного мезаортиту',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертонічної хвороби',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нодозного поліартеріїту',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неспецифічного аортоартеріїту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 105
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гістологічному дослідженні стінки аорти виявлено велику кількість ксантомних клітин, розташованих переважно в інтимі. При якому захворюванні можлива така картина?',
    'medium',
    104,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертонічна хвороба',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неспецифічний аортоартеріїт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сифілітичний мезаортит',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 106
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?',
    'medium',
    105,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий панкреатит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Запалення легенів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гастрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження нирок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 107
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 36-ти років одразу після перенесеного стафілококового сепсису з’явилися напади стенокардії. За допомогою коронарографії в лівій коронарній артерії було виявлено пристінковий тромбоз без ознак атеросклерозу. Утворення тромбу розпочалося внаслідок пошкодження ендотелію судини і вивільнення:',
    'medium',
    106,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фактора активації тромбоцитів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфоліпази А2',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденозиндифосфату',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серотоніну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденозинтрифосфату',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 108
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Серед гіполіпідемічних препаратів, що застосовуються з метою профілактики та лікування атеросклерозу, є ловастатин. Який механізм дії цього лікарського засобу?',
    'medium',
    107,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення всмоктування холестерину в кишківнику',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулювання екскреції холестерину з організму',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування біосинтезу холестерину',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усіма наведеними шляхами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація метаболізму холестерину',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 109
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після курсу лікування атеросклерозу в плазмі крові лабораторно доведено збільшення рівня антиатерогенної фракції ліпопротеїнів. Збільшення рівня яких ліпопротеїнів підтверджує ефективність терапії захворювання?',
    'medium',
    108,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛПНЩ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хіломікрони',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛПДНЩ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛППЩ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛПВЩ',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 110
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відповідно до сучасної концепції атерогенезу «Response to injury», атеросклероз є проявом хронічного запалення в інтимі артерій. З якою стадією запалення пов’язане формування фіброзних бляшок у разі атеросклерозу?',
    'medium',
    109,
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
  -- Питання 111
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 70 років перебіг атеросклерозу ускладнився тромбозом судин нижніх кінцівок, виникла гангрена пальців лівої стопи. Початок тромбоутворення, найімовірніше, пов’язаний з:',
    'medium',
    110,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перетворенням фібриногену в фібрин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниженням синтезу гепарину',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перетворенням протромбіну в тромбін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адгезією тромбоцитів',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активацією протромбінази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 112
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця та порушень мозкового кровообігу людина повинна одержувати 2-6 г незамінних поліненасичених жирних кислот на добу. Ці кислоти необхідні для синтезу:',
    'medium',
    111,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовчних кислот',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стероїдів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адреналіну',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамінів групи D',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Простагладинів',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 113
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В крові хворого виявлено високий вміст галактози, концентрація глюкози знижена. Відмічена розумова відсталість, помутніння кришталика. Яке захворювання має місце?',
    'medium',
    112,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактоземія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фруктоземія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стероїдний діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 114
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої дитини виявлена затримка розумового розвитку, збільшення печінки, погіршення зору. Лікар пов’язує ці симптоми з дефіцитом в організмі галактозо-1-фосфатуридилтрансферази. Який патологічний процес має місце у дитини?',
    'medium',
    113,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперлактатацидемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фруктоземія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 115
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 38-ми років надійшла до реанімаційного відділення в несвідомому стані. Рефлекси відсутні. Цукор крові -2,1 ммоль/л. В анамнезі - цукровий діабет з 18-ти років. Яка кома має місце у хворої?',
    'medium',
    114,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактацидемічна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 116
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворого доставлено у медичний заклад в коматозному стані. Зі слів супроводжуючих вдалося з’ясувати, що він знепритомнів під час тренування на завершальному етапі марафонської дистанції. Який вид коми найімовірніше можна запідозрити у даного пацієнта?',
    'medium',
    115,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпотиреоїдна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 117
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Виникнення нижченаведених захворювань повʼязують із генетичними факторами. Укажіть патологію зі спадковою схильністю.',
    'medium',
    116,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серповидноклітинна анемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хорея Гантінгтона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дальтонізм',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 118
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого зі скаргами на полідипсію, поліфагію, поліурію визначили високий рівень глюкози крові і наявність її у сечі. Яке захворювання можна припустити?',
    'medium',
    117,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Аддісона',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулінома',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Акромегалія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 119
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий після перенесеного епідемічного паротиту схуднув, постійно відчуває спрагу, п''є багато води, відмічає часте сечовиділення, підвищений апетит, шкірний свербіж, слабкість, фурункульоз. У крові: глюкоза - 16 ммоль/л, кетонових тіл - 100 мкмоль/л; глюкозурія. Яке захворювання розвинулось у пацієнта?',
    'medium',
    118,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулінозалежний цукровий діабет',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стероїдний діабет',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет недостатнього харчування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулінонезалежний цукровий діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 120
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 46-ти років скаржиться на сухість в роті, спрагу, часте сечовипускання, загальну слабкість. У крові: гіперглікемія, гіперкетонемія. У сечі: глюкоза, кетонові тіла. На ЕКГ: дифузні зміни в міокарді. Який найбільш імовірний діагноз?',
    'medium',
    119,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аліментарна гіперглікемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Немічна хвороба серця',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий панкреатит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 121
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 26 років скаржиться на сухість у роті, спрагу. Під час обстеження: глюкоза крові - 6,5 ммоль/л, глюкозурія. Для якого з зазначених нижче станів найбільш характерні ці симптоми?',
    'medium',
    120,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аліментарна глюкозурія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стероїдний діабет',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нирковий діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 122
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий після перенесеного епідемічного паротиту схуднув, постійно відчуває спрагу, п’є багато води, відмічає часте сечовиділення, підвищений апетит, шкірний свербіж, слабкість, фурункульоз. У крові: глюкоза - 16 ммоль/л, кетонових тіл - 100 мкмоль/л; глюкозурія. Яке захворювання розвинулось у пацієнта?',
    'medium',
    121,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулінонезалежний цукровий діабет',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулінозалежний цукровий діабет',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет недостатнього харчування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стероїдний діабет',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 123
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Виникнення нижчеперерахованих захворювань пов’язане із генетичними факторами. Назвіть патологію із спадковою схильністю:',
    'medium',
    122,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хорея Гентінгтона',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серпоподібноклітинна анемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дальтонізм',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 124
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 15-ти років концентрація глюкози натще 4,8 ммоль/л, через годину після цукрового навантаження - 9,0 ммоль/л, через 2 години - 7,0 ммоль/л, через 3 години - 4,8 ммоль/л. Ці показники характерні для такого захворювання:',
    'medium',
    123,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет II типу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет I типу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Іценко-Кушинга',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прихований цукровий діабет',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 125
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 46-ти років скаржиться на сухість в роті, спрагу, часте сечовипускання, загальну слабкість. У крові: гіперглікемія, гіперкетонемія. У сечі: глюкоза, кетонові тіла. На ЕКГ: дифузні зміни в міокарді. Який найбільш імовірний діагноз?',
    'medium',
    124,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аліментарна гіперглікемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нецукровий діабет',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Немічна хвороба серця',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий панкреатит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 126
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтка віком 55 років після перенесеної інфекції скаржиться на сухість у роті та часте сечовипускання. Глюкоза крові — 4.8 ммоль/л. Лікарка-ендокринологиня запідозрила в неї нецукровий діабет. Із недостатністю якого гормону пов’язана ця хвороба?',
    'medium',
    125,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альдостерона',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кортизола',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкагона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вазопресина',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсуліна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 127
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта шпиталізовали до лікарні в коматозному стані. Із анамнезу відомо, що він хворіє на цукровий діабет 2-го типу продовж 5-ти років. Об’єктивно спостерігається: дихання шумне, глибоке, із рота відчувається запах ацетону. Вміст глюкози у крові становить 15,2 ммоль/л, кетонових тіл 100 мкмоль/л. Для якого ускладнення цукрового діабету характерні такі симптоми?',
    'medium',
    126,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічної коми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічної коми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотичної коми',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярної коми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкової коми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 128
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки віком 59 років яка хворіє на цукровий діабет, виник метаболічний ацидоз унаслідок накопичення кетонових тіл у крові. Які зміни з боку дихальної системи будуть спостерігатися у пацієнтки?',
    'medium',
    127,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Відбувається затримка дихання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Періодичні бронхостазми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилюється вентиляція легень',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Знижується вентиляція легень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спостерігається дихання Чейна-Стокса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 129
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 60 років зі встановленим діагнозом: цукровий діабет застосовує ін''єкції інсуліну. Який вид медикаментозної терапії призначений пацієнту?',
    'medium',
    128,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Замісний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Профілактичний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіотропний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Симптоматичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патогенетичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 130
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 47 років шпиталізовано до відділення інтенсивної терапії. 3 анамнезу відомо, що хворіє на цукровий діабет І типу впродовж 15 років. Під час огляду спостерігається: свідомість — кома І ст, наявне шумне прискорення дихання, при якому глибокі вдихи зміняються посиленими видихами за участю експіраторних м’язів. Який патологічний тип дихання спостерігається в пацієнта?',
    'medium',
    129,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Куссмауля',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенотичне',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Чейна-Стокса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біота',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апнейстичне',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 131
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнтів з діагнозом: цукровий діабет, часто спостерігаються запальні процеси, знижується регенерація та уповільнюється загоєння ран. Що є причиною цього явища?',
    'medium',
    130,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження протеосинтезу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорення гліконеогенезу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення ліполізу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження ліполізу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилення катаболізму',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 132
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Цукровий діабет матері призвів до народження дитини з вродженими вадами опорно-рухової, серцево-судинної та нервової систем. Вплив яких факторів спричинив розвиток діабетичної ембріопатії?',
    'medium',
    131,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канцерогенних',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екзогенних',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антропогенних',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тератогенних',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутагенних',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 133
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 56 років, який скаржитися на спрагу та часте сечовиділення, встановлено діагноз: цукровий діабет. Призначено глібенкламід. Укажіть механізм дії цього препарату.',
    'medium',
    132,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сприяє засвоєнню глюкози клітинами тканин організму',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює b-клітини острівців Лангерганса',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує а-клітини острівців Лангерганса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує всмоктування глюкози в кишечнику',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полегшує транспорт глюкози крізь клітинні мембрани',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 134
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з діагнозом: цукровий діабет, виявлено підвищений вміст кетонових тіл у крові. Із якої сполуки синтезуються кетонові тіла?',
    'medium',
    133,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацил-КоА',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бутирил-КоА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сукциніл-КоА',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетил-КоА',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксіацил-КоА',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 135
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта госпіталізували до лікарні в коматозному стані. Із анамнезу відомо, що він хворіє на цукровий діабет другого типу впродовж 5 років. Обʼєктивно спостерігається: дихання шумне, глибоке, із рота відчувається запах ацетону. Уміст глюкози у крові становить 15,2 ммоль/л, кетонових тіл = 100 мкмоль/л. Для якого ускладнення цукрового діабету характерні такі симптоми?',
    'medium',
    134,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічної коми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкової коми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярної коми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічної коми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотичної коми',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 136
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який хворіє на цукровий діабет другого типу, але гіперглікемічна кома (рівень глюкози крові - 56 ммоль/л). Яке патологічне явище в цьому разі лежить в основі порушення функцій клітин мозку пацієнта?',
    'medium',
    135,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсичне ураження',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпергідратація клітин мозку (набухання)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іонний дисбаланс',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпогідратація клітин мозку',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енергодефіцит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 137
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час обстеження жінки віком 56 років, яка хворіє на цукровий діабет 1 го типу, виявлено порушення білкового обміну. Під час лабораторного дослідження крові це виявляється аміноацидемією, а клінічно - уповільненням загоєння ран і зменшенням синтезу антитіл. Який із наведених нижче механізмів викликає розвиток аміноацидемії?',
    'medium',
    136,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску в плазмі крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпротеїнемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення протеолізу',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення ліпопротеїдів високої щільності',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення концентрації амінокислот у крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 138
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 30 років, який хворіє на цукровий діабет 1-го типу, було госпіталізовано у стані коми. Лабораторні дослідження виявили гіперглікемію, кетонемію. Яке з наведених нижче метаболічних порушень може бути у цього пацієнта?',
    'medium',
    137,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нормальний кислотно-лужний стан',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 139
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет розвинулась діабетична нефропатія з розвитком уремії. Швидкість клубочкової фільтрації 9 мл/хв. Який найбільш імовірний механізм зниження швидкості клубочкової фільтрації і розвитку хронічної ниркової недостатності у пацієнта?',
    'medium',
    138,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення маси діючих нефронів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження системного артеріального тиску',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спазм артеріол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закупорка просвіту канальців нефрону гіаліновими циліндрами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвиток ацидозу в тканинах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 140
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту, що хворіє на цукровий діабет та алергічний дерматит, лікар призначив фторований гормональний препарат в мазі. На питання хворого, про переваги призначеного препарату над маззю гідрокортизону лікар пояснив, що:',
    'medium',
    139,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Діє короткочасно',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коштує дешевше',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Діє слабше',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилює синтез інсуліну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Призначений препарат практично немає резорбтивної дії',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 141
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні машиною швидкої допомоги доставлено хворого в стані коми. В анамнезі указано цукровий діабет. Під час обстеження спостерігається шумне прискорене дихання, у якому глибокі вдихи чергуються із посиленими видохами за участю експіраторних м’язів. Яка форма порушення зовнішнього дихання спостерігається?',
    'medium',
    140,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апнейстичне дихання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Біота',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Кусмауля',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Чейна-Стокса',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенотичне дихання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 142
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчина 19-ти років, хвора на цукровий діабет, чекає на донорську нирку. Яке ускладнення діабету є причиною хронічної ниркової недостатності?',
    'medium',
    141,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроангіопатія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Невропатія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретинопатія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макроангіопатія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 143
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка, хворого на цукровий діабет, виникли значна спрага, дисфагія та порушення психічної діяльності. Який тип розладів водно-електролітного балансу характеризує поява цих ознак?',
    'medium',
    142,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація ізоосмотична',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація ізоосмотична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіперосмотична',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація гіпоосмотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіпоосмотична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 144
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворого доставили до клініки у коматозному стані. В анамнезі вказано цукровий діабет І типу впродовж 5 років. Об’єктивно: дихання шумне, глибоке, у видихуваному повітрі відчутно запах ацетону. Уміст глюкози у крові -18,2 ммоль/л, кетонових тіл - 100 мкмоль/л. Для якого ускладнення цього захворювання характерні такі розлади?',
    'medium',
    143,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкова кома',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна кома',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна кома',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотична кома',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна кома',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 145
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Цукровий діабет у хворої 35 років ускладнився виникненням і розвитком катаракти, ймовірною причиною якої є:',
    'medium',
    144,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клітинна дегідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікозилювання білків кришталика і накопичення сорбітолу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дефіцит НАДФ • Н2 та гальмування синтезу жирних кислот',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення зв’язування рецепторів з інсуліном',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження спорідненості білків з киснем',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 146
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет з’явився різкий біль у правій стопі. При огляді великий палець стопи чорного кольору, тканини стопи набряклі, осередки відшарування епідермісу, виділення з неприємним запахом. Яка клініко- морфологічна форма некрозу розвинулася в хворого?',
    'medium',
    145,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена волога',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Секвестр',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена суха',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 147
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет виникла значна спрага, дисфагія та порушення психічної діяльності. Який тип розладів водно-електролітного балансу характеризує поява вказаних ознак?',
    'medium',
    146,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіпоосмотична',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація ізоосмотична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіперосмотична',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація гіпоосмотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація ізоосмотична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 148
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 38-ми років надійшла в реанімаційне відділення в непритомному стані. Рефлекси відсутні. Цукор крові - 2,1 ммоль/л. В анамнезі: цукровий діабет з 18-ти років. Яка кома має місце у хворої?',
    'medium',
    147,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактацидемічна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 149
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок росту пухлини в порожнину III шлуночка головного мозку у пацієнта розвиваються вегетативні розлади у вигляді порушення сну, терморегуляції, всіх видів обміну, нецукровий діабет. Подразнення ядер якої ділянки головного мозку викликало ці симптоми?',
    'medium',
    148,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моста',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ніжок мозку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Довгастого мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Покришки середнього мозку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоталамуса',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 150
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 70-ти років, який страждав на цукровий діабет та переніс інфаркт міокарда, помер при явищах прогресуючої серцево-судинної недостатності. На розтині ціанотична індурація селезінки та нирок, бура індурація легень та мускатна печінка. Який вид порушення кровообігу обумовив зміни внутрішніх органів?',
    'medium',
    149,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальна артеріальна гіперемія після анемії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місцева хронічна венозна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна ішемія в результаті перерозподілу крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальна хронічна венозна гіперемія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальна гостра венозна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 151
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лікарню машиною швидкої допомоги доставлено хворого в стані коми. В анамнезі цукровий діабет. При обстеженні спостерігається шумне прискорене дихання, при якому глибокі вдихи чергуються з посиленими видохами за участю експіраторних м’язів. Яка форма порушення зовнішнього дихання спостерігається?',
    'medium',
    150,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Чейна-Стокса',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Біота',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апнейстичне дихання',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихання Куссмауля',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенотичне дихання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 152
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з діагнозом цукровий діабет II типу ендокринолог призначив глібенкламід. Вкажіть основний механізм дії цього засобу:',
    'medium',
    151,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює захоплення глюкози периферичними тканинами',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює метаболізм глюкози',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує глюконеогенез',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активує транспорт глюкози в клітину',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює секрецію інсуліну бета- клітинами острівців Лангерганса',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 153
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні хворого 70-ти років виявлено цукровий діабет II типу. Яким препарат доцільно призначити хворому?',
    'medium',
    152,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паратиреоїдин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кортизон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мерказоліл',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 154
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчина хвора на цукровий діабет, чекає на донорську нирку. Яке ускладнення діабету в неї є причиною хронічної ниркової недостатності?',
    'medium',
    153,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретинопатія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макроангіопатія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроангіопатія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропатія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 155
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Аналіз крові хворого на цукровий діабет показав наявність молочної кислоти у концентрації 2,5 ммоль/л. Яка кома розвинулася у хворого?',
    'medium',
    154,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперкетонемічна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактацидемічна',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 156
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До хірурга звернувся чоловік 60-ти років, що тривалий час хворів на цукровий діабет. Тканини правої стопи були чорного кольору, щільні, з чіткими краями. Який діагноз поставив хірург?',
    'medium',
    155,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Суха гангрена',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волога гангрена',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова гангрена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трофічна виразка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 157
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий з діагнозом цукровий діабет, вранці натще отримав призначену дозу інсуліну пролонгованої дії. Пропустив черговий прийом їжі і невдовзі відчув слабкість, біль голови ,запаморочення, пітливість, тремтіння тіла, судоми, відчуття голоду, явища гіпоглікемії. Застосування глюкози стан не полегшило. Який препарат необхідно ввести для купірування даного стану?',
    'medium',
    156,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пренізолон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідрокортизон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тріамцінолон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Норадреналін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адреналін',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 158
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні жінки 56-ти років, що хвора на цукровий діабет 1-го типу, виявлене порушення білкового обміну, що при лабораторному дослідженні крові проявляється аміноацидемією а клінічно - уповільненням загоєння ран і зменшенням синтезу антитіл. Який з перерахованих механізмів викликає розвиток аміноацидемії?',
    'medium',
    157,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску в плазмі крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення концентрації амінокислот у крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпротеїнемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення ліпопротеїдів високої щільності',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення протеолізу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 159
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До клініки доставлено хвору на цукровий діабет, госпіталізовано у прекоматозному стані кетоацидотичного типу. Збільшення вмісту якого метаболіту до цього призвело?',
    'medium',
    158,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетоацетат',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малонат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитрат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'α-кетоглутарат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аспартат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 160
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої 63-х років діагностований інсулінонезалежний цукровий діабет. Ендокринолог почав лікування з призначення глібенкламіду. Вкажіть механізм дії цього засобу:',
    'medium',
    159,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює гіпоталамічні центри',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активує в-клітини острівців Лангерганса',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмує транспорт глюкози до клітин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшує всмоктування глюкози в кишківнику',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює руйнування білків',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 161
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з діагнозом цукровий діабет II типу ендокринолог призначив глібенкламід. Вкажіть основний механізм дії цього засобу:',
    'medium',
    160,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює секрецію інсуліну бета-клітинами острівців Лангерганса',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активує транспорт глюкози в клітину',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює захоплення глюкози периферичними тканинами',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює метаболізм глюкози',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує глюконеогенез',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 162
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До шпиталю було доставлено юнака 16-ти років, хворого на інсулінозалежний цукровий діабет. Рівень глюкози у крові пацієнта складав 18 ммоль/л. Хворому було введено інсулін. Дві години потому рівень глюкози зменшився до 8,2 ммоль/л, тому що інсулін:',
    'medium',
    161,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює розщеплення глікогену у м’язах',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює транспорт глюкози через плазматичні мембрани в головному мозку та печінці',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює перетворення глюкози в печінці у глікоген та ТАГ',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює розщеплення глікогену в печінці',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмує синтез кетонових тіл із глюкози',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 163
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 58-ми років впродовж 9-ти років хворіє на цукровий діабет, отримує для корекції гіперглікемії інсулін-семіленте. 10 днів тому почав лікування гіпертонічної хвороби анаприліном. Через годину після прийому антигіпертензивного препарату розвинулась гіпоглікемічна кома. Який механізм виникнення гіпоглікемії за умови прийому анаприліну?',
    'medium',
    162,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення періоду напіввиведення інсуліну-семіленте',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення глікогенолізу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення періоду напіввиведення глюкагону',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення всмоктування глюкози',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення біодоступності інсуліну-семіленте',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 164
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 49-ти років був доставлений до лікарні в коматозному стані. В анамнезі - цукровий діабет. Об’єктивно: дихання Кусмауля, зниження артеріального тиску, у видихуваному повітрі запах ацетону. Після проведеної невідкладної терапії стан покращився. Який препарат було введено хворому?',
    'medium',
    163,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адреналін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Букаркам',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізадрин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 165
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 38-ми років надійшла до реанімаційного відділення в несвідомому стані. Рефлекси відсутні. Цукор крові -2,1 ммоль/л. В анамнезі - цукровий діабет з 18-ти років. Яка кома має місце у хворої?',
    'medium',
    164,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактацидемічна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 166
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворій 65-ти років, що страждає на інсулінонезалежний цукровий діабет, призначили всередину глібенкламід. Вкажіть механізм гіпоглікемічної дії цього препарату:',
    'medium',
    165,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує альфа-глюкозидазу і розпад полісахаридів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує глюконеогенез у печінці',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює виділення ендогенного інсуліну бета-клітинами',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилює утилізацію глюкози периферичними тканинами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічує всмоктування глюкози у кишечнику',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 167
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До хірурга звернувся чоловік 60-ти років, що тривалий час хворіє на цукровий діабет. Об’єктивно: тканини правої стопи чорного кольору, щільні, з чіткими краями. Який діагноз поставив хірург?',
    'medium',
    166,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Суха гангрена',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова гангрена',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волога гангрена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трофічна виразка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 168
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До генетичної консультації звернулася сімейна пара, у якій чоловік хворіє на інсулінозалежний цукровий діабет, а жінка здорова. Яка вірогідність появи інсулінозалежного діабету в дитини цього подружжя?',
    'medium',
    167,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Більше, ніж в популяції',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Така сама, як в популяції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нижче, ніж в популяції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '100%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 169
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора похилого віку хворіє на цукровий діабет 2-го типу, який супроводжується ожирінням, атеросклерозом, ішемічною хворобою серця. При цьому виявлена базальна гіперінсулінемія. Запропонуйте хворій адекватне лікування:',
    'medium',
    168,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретаболіл',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ловастатин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амлодипін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 170
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина хворіє на цукровий діабет, що супроводжується гіперглікемією натще понад 7,2 ммоль/л. Рівень якого білку плазми крові дозволяє ретроспективно (за попередні 4-8 тижні до обстеження) оцінити рівень глікемії?',
    'medium',
    169,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Церулоплазмін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноген',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'С-реактивний білок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікозильований гемоглобін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбумін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 171
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні хворого 70-ти років виявлено інсулінонезалежний цукровий діабет. Який препарат доцільно призначити хворому?',
    'medium',
    170,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паратіреоїдин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кортизон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мерказоліл',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 172
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина хворіє на цукровий діабет, що супроводжується гіперглікемією натще понад 7,2 ммоль/л. Рівень якого білка плазми крові дозволяє ретроспективно (за попередні 4-8 тижні до обстеження) оцінити рівень глікемії?',
    'medium',
    171,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Церулоплазмін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'С-реактивний білок',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбумін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікозильований гемоглобін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноген',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 173
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет з’явився різкий біль у правій стопі. Об’єктивно: великий палець стопи чорного кольору, тканини стопи набряклі, осередки відшарування епідермісу, виділення з неприємним запахом. Яка клініко-морфологічна форма некрозу розвинулася в хворого?',
    'medium',
    172,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена суха',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Секвестр',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена волога',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 174
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет після введення інсуліну настала непритомність, спостерігаються судоми. Який результат біохімічного аналізу крові на вміст цукру?',
    'medium',
    173,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '10 ммоль/л',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '1,5 ммоль/л',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '5,5 ммоль/л',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '8 ммоль/л',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '3,3 ммоль/л',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 175
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворих на цукровий діабет і під час голодування в крові збільшується вміст ацетонових тіл, що використовуються в якості енергетичного матеріалу. З якої речовини вони синтезуються?',
    'medium',
    174,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитрат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетил-КоА',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоглутарат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сукциніл-КоА',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 176
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет змінилось значення рH та стало дорівнювати 7,3. Визначення компонентів якої буферної системи використовується для діагностики розладів кислотно-лужної рівноваги?',
    'medium',
    175,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемоглобінової',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксигемоглобінової',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бікарбонатної',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфатної',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білкової',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 177
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий на цукровий діабет вчасно не отримав ін’єкцію інсуліну, що призвело до розвитку гіперглікемічної коми (вміст глюкози в крові – 50 ммоль/л). Який механізм є головним у розвитку цієї коми?',
    'medium',
    176,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпонатріємія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпокаліємія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 178
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У крові хворих на цукровий діабет спостерігається підвищення вмісту вільних жирних кислот. Причиною цього може бути:',
    'medium',
    177,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація синтезу аполіпопротеїнів А-1, А-2, А-4',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація утилізації кетонових тіл',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Накопичення в цитозолі пальмітоїл-КоА',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення активності тригліцеридліпази адипоцитів',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 179
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В лікарню доставили хворого на цукровий діабет в несвідомому стані. Дихання типу Кусмауля, артеріальний тиск 80/50 мм рт. ст., запах ацетону з рота. Накопиченням в організмі яких речовин можна пояснити виникнення даних розладів?',
    'medium',
    178,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Молочної кислоти',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетонових тіл',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вугільної кислоти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Модифікованих ліпопротеїдів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Складних вуглеводів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 180
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий на цукровий діабет вранці натщесерце отримав призначену дозу інсуліну пролонгованої дії. Пропустив черговий прийом їжі і незабаром відчув ознаки гіпоглікемії. Застосування глюкози стан НЕ полегшило. Який препарат необхідно ввести для купірування даного стану?',
    'medium',
    179,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідрокортизон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адреналін',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тріамцинолон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Преднізолон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Норадреналін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 181
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак 16 років, що страждає на цукровий діабет з 10 років, почув про можливості замінити ін''єкції інсуліну таблетками глібенкламіду. Однак лікар, до якого він звернувся, категорично йому відмовив. Чому глібенкламід не можна призначити в даному випадку?',
    'medium',
    180,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулює альфа - клітини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Швидко деградує в печінці',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Не стимулює бета – клітини',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підсилює виділення адреналіну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Викликає гіперпродукцію гідрокортизону',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 182
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У крові пацієнта вміст глюкози натще було 5,65 ммоль/л, через 1 годину після цукрового навантаження становило 8,55 ммоль/л, а через 2 години-4,95 ммоль/л. Такі показники характерні для:',
    'medium',
    181,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Здорової людини',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хворого з інсулінозалежним цукровим діабетом',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хворого з прихованим цукровим діабетом',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хворого з тиреотоксикозом',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хворого з інсуліннезалежний цукровий діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 183
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 60 років зі встановленим діагнозом: цукровий діабет застосовує ін''єкції інсуліну. Який вид медикаментозної терапії призначений пацієнту?',
    'medium',
    182,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Замісний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіотропний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Профілактичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Симптоматичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патогенетичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 184
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора похилого віку хворіє на цукровий діабет 2-го типу, який супроводжується ожирінням, атеросклерозом, ішемічною хворобою серця. При цьому виявлена базальна гіперінсулінемія. Запропонуйте хворій адекватне лікування:',
    'medium',
    183,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретаболіл',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсулін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ловастатин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глібенкламід',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амлодипін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 185
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 15-ти років концентрація глюкози натще 4,8 ммоль/л, через годину після цукрового навантаження - 9,0 ммоль/л, через 2 години - 7,0 ммоль/л, через 3 години - 4,8 ммоль/л. Ці показники характерні для такого захворювання:',
    'medium',
    184,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет II типу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет I типу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Іценко-Кушинга',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прихований цукровий діабет',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 186
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворого доставили до клініки у коматозному стані. В анамнезі вказано цукровий діабет І типу впродовж 5 років. Об’єктивно: дихання шумне, глибоке, у видихуваному повітрі відчутно запах ацетону. Уміст глюкози у крові -18,2 ммоль/л, кетонових тіл - 100 мкмоль/л. Для якого ускладнення цього захворювання характерні такі розлади?',
    'medium',
    185,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкова кома',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна кома',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна кома',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотична кома',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічна кома',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 187
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта госпіталізували до лікарні в коматозному стані. Із анамнезу відомо, що він хворіє на цукровий діабет другого типу впродовж 5 років. Обʼєктивно спостерігається: дихання шумне, глибоке, із рота відчувається запах ацетону. Уміст глюкози у крові становить 15,2 ммоль/л, кетонових тіл = 100 мкмоль/л. Для якого ускладнення цукрового діабету характерні такі симптоми?',
    'medium',
    186,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічної коми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкової коми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярної коми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічної коми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотичної коми',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 188
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта шпиталізовали до лікарні в коматозному стані. Із анамнезу відомо, що він хворіє на цукровий діабет 2-го типу продовж 5-ти років. Об’єктивно спостерігається: дихання шумне, глибоке, із рота відчувається запах ацетону. Вміст глюкози у крові становить 15,2 ммоль/л, кетонових тіл 100 мкмоль/л. Для якого ускладнення цукрового діабету характерні такі симптоми?',
    'medium',
    187,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічної коми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемічної коми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоацидотичної коми',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярної коми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкової коми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 189
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 47 років шпиталізовано до відділення інтенсивної терапії. 3 анамнезу відомо, що хворіє на цукровий діабет І типу впродовж 15 років. Під час огляду спостерігається: свідомість — кома І ст, наявне шумне прискорення дихання, при якому глибокі вдихи зміняються посиленими видихами за участю експіраторних м’язів. Який патологічний тип дихання спостерігається в пацієнта?',
    'medium',
    188,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Куссмауля',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенотичне',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Чейна-Стокса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біота',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апнейстичне',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 190
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час обстеження жінки віком 56 років, яка хворіє на цукровий діабет 1 го типу, виявлено порушення білкового обміну. Під час лабораторного дослідження крові це виявляється аміноацидемією, а клінічно - уповільненням загоєння ран і зменшенням синтезу антитіл. Який із наведених нижче механізмів викликає розвиток аміноацидемії?',
    'medium',
    189,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску в плазмі крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпротеїнемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення протеолізу',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення ліпопротеїдів високої щільності',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення концентрації амінокислот у крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 191
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 30 років, який хворіє на цукровий діабет 1-го типу, було госпіталізовано у стані коми. Лабораторні дослідження виявили гіперглікемію, кетонемію. Яке з наведених нижче метаболічних порушень може бути у цього пацієнта?',
    'medium',
    190,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нормальний кислотно-лужний стан',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 192
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Десятимісячна дитина, батьки якої брюнети, має світле волосся, дуже світлу шкіру і блакитні очі. Зовнішньо при народженні виглядала нормально, але протягом останніх 3-х місяців спостерігалися порушення мозкового кровообігу та відставання у розумовому розвитку. Укажіть імовірну причину такого стану.',
    'medium',
    191,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра порфірія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікогеноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 193
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікар-педіатр під час огляду дитини встановив відставання у фізичному та розумовому розвитку. У сечі спостерігається різко підвищений вміст кетокислоти, яка дає якісну кольорову реакцію з хлорним залізом. Яке порушення обміну речовин було виявлено?',
    'medium',
    192,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозинемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 194
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини 1,5 років спостерігається відставання в розумовому й фізичному розвитку, посвітління шкіри й волосся, зниження вмісту в крові катехоламінів. При додаванні до свіжої сечі декількох крапель 5 % розчину трихлороцтового заліза з’являється оливково-зелене забарвлення. Для якої патології обміну амінокислот характерні дані зміни?',
    'medium',
    193,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксантонурія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозиноз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 195
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час огляду дитини педіатр відзначив відставання у фізичному та розумовому розвитку. У сечі різко підвищений вміст кетокислоти, що дає якісну кольорову реакцію з хлорним залізом. Яке порушення обміну речовин було виявлено?',
    'medium',
    194,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозинемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 196
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Десятимісячна дитина, батьки якої брюнети, має світле волосся, дуже світлу шкіру і блакитні очі. Зовнішньо при народженні виглядала нормально, але протягом останніх 3-х місяців спостерігалися порушення мозкового кровообігу та відставання у розумовому розвитку. Укажіть імовірну причину такого стану.',
    'medium',
    195,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра порфірія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікогеноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 197
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Педіатр при огляді дитини зазначив відставання у фізичному і розумовому розвитку. В аналізі сечі був різко підвищений вміст кетокислоти, яка дає якісну кольорову реакцію з хлорним залізом. Яке порушення обміну речовин було виявлено?',
    'medium',
    196,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозинемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 198
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта під час обстеження виявлено: у сечі — фенілпіровиноградна кислота, у крові — підвищений рівень фенілаланіну. Встановлено діагноз: фенілкетонурія. Яким методом можна підтвердити цей діагноз?',
    'medium',
    197,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно статистичним',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковим',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичним',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бохімічним',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічним',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 199
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До якої групи молекулярних хвороб обміну речовин належить фенілкетонурія?',
    'medium',
    198,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спадкові хвороби обміну сполучної тканини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення обміну мінеральних речовин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення метаболізму амінокислот',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення метаболізму вуглеводів',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 200
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія успадковується як аутосомно-рецесивна ознака. У здорових батьків народилася дитина, хвора на фенілкетонурію. Які генотипи батьків?',
    'medium',
    199,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х Аа',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х Аа',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х АА',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 201
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія - це захворювання, яке зумовлено рецесивним геном, що локалізується в аутосомі. Батьки є гетерозиготами за цим геном. Вони вже мають двох хворих синів і одну здорову доньку. Яка імовірність, що четверта дитина, яку вони очікують, народиться теж хворою?',
    'medium',
    200,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '100%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 202
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернувся хворий зі скаргами на непереносимість сонячної радіації. Мають місце опіки шкіри та порушення зору. Попередній діагноз: альбінізм. Порушення обміну якої амінокислоти відзначається у цього пацієнта?',
    'medium',
    201,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лізин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аланін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Триптофан',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 203
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У трирічної дитини відсутня пігментація шкіри, волосся, райдужної оболонки ока, спостерігається підвищена чутливість до ультрафіолетового випромінювання. Встановлено діагноз: загальний альбінізм, що є наслідком відсутності ферменту тирозинази. Яка мутація є причиною цього захворювання?',
    'medium',
    202,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна аберація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматична',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генна',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 204
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час повторної дії ультрафіолетових променів шкіра темніє внаслідок синтезу в ній меланіну, що захищає клітини від пошкодження. Що є основним механізмом включення цього захисту?',
    'medium',
    203,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення фенілаланінгідроксилази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація оксидази гомогентизинової кислоти',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення оксидази гомогентизинонлї кислоти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація тирозинази',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення тирозинази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 205
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У грудної дитини спостерігається забарвлення склер, слизових оболонок. Виділяється сеча, яка темніє на повітрі. В крові та сечі виявлено гомогентизинову кислоту. Що може бути причиною даного стану?',
    'medium',
    204,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 206
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Батьки дитини 3-х років звернули увагу на потемніння кольору його сечі при відстоюванні. Об’єктивно: температура у нормі, шкірні покриви чисті, рожеві, печінка не збільшена. Назвіть імовірну причину даного стану:',
    'medium',
    205,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Іценка-Кушінга',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемоліз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Подагра',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 207
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини грудного віку спостерігається пігментація склер, слизових оболонок. Виділяється сеча, яка темніє на повітрі. У крові та сечі виявлено гомогентизинову кислоту. Яке захворювання може бути причиною цього стану?',
    'medium',
    206,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкаптонурія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінізм',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 208
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати зауважила занадто темну сечу у її 5-річної дитини. Дитина скарг не висловлює. Жовчних пігментів у сєчі не виявлено. Поставлено діагноз алкаптонурія. Дефіцит якого ферменту має місце у дитини?',
    'medium',
    207,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксидаза оксифенілпірувату',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілаланінгідроксилаза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декарбоксилаза фенілпірувату',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксидаза гомогентизинової кислоти',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозиназа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 209
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Десятирічна дитина скаржиться на загальну слабкість, швидку стомлюваність. Відстає у психічному розвитку. Лабораторні дослідження показали високі концентрації валіну, ізолейцину і лейцину в крові та сечі. Сеча має специфічний запах. Який патологічний стан можна запідозрити у дитини?',
    'medium',
    208,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба кленового сиропу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Аддісона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозиноз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний токсичний зоб',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 210
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитина народилась здоровою, але через тиждень у неї з''явилося блювання, а пізніше гіпертонус м''язів, судоми, специфічний солодкий запах сечі і поту. Яке захворювання спостерігається у дитини?',
    'medium',
    209,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба кленового сиропу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Коновалова-Вільсона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фруктозурія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 211
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хлопчик 13 років скаржиться на загальну слабкість, запаморочення, втомлюваність. Спостерігається відставання у розумовому розвитку. При обстеженні виявлено високу концентрацію валіну, ізолейцину, лейцину в крові та сечі. Сеча специфічного запаху. Який найбільш вірогідний діагноз?',
    'medium',
    210,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозиноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Аддісона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Базедова хвороба',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба ''кленового сиропу''',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 212
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хлопчик 13 років скаржиться на загальну слабість, запаморочення, втомлюваність. Спостерігається відставання у розумовому розвитку. У крові та сечі висока концентрація валіну, ізолейцину, лейцину. Сеча специфічного запаху. Який найбільш імовірний діагноз?',
    'medium',
    211,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Базедова хвороба',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба кленового сиропу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидинемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тирозиноз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Аддісона',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 213
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При лабораторному дослідженні дитини виявлено підвищений вміст у крові та сечі лейцину, валіну, ізолейцину та їх кетопохідних. Сеча має характерний запах кленового сиропу. Недостатність якого ферменту характерно для цього захворювання?',
    'medium',
    212,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфофруктокіназа',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфофруктомутаза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінотрансфераза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкозо-6-фосфатаза',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідрогеназа розгалужених амінокислот',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 214
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Немовля відмовляється від годування груддю, збудливе, дихання неритмічне, сеча має специфічний запах "пивної закваски" або "кленового сиропу". Вроджений дефект якого ферменту викликав дану патологію?',
    'medium',
    213,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкозо-6-фосфатдегідрогеназа',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'УДФ-глюкуронілтрансфераза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аспартатамінотрансфераза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідрогеназа розгалужених альфа-кетокислот',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гліцеролкіназа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 215
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При диспансерному обстеженні хлопчику 7-ми років встановлено діагноз - синдром Леша-Ніхана (хворіють тільки хлопчики). Батьки здорові, але у дідуся за материнською лінією таке саме захворювання. Який тип успадкування захворювання?',
    'medium',
    214,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивний, зчеплений із статтю',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-рецесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-домінантний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений із статтю',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне домінування',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 216
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 19-місячної дитини із затримкою розвитку та проявами самоагресії, вміст сечової кислоти в крові - 1,96 ммоль/л. При якому метаболічному порушенні це спостерігається?',
    'medium',
    215,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Гірке',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Леша-Ніхана',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Подагра',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром набутого імунодефіциту',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Іценко-Кушинга',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 217
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта зі спадковою гіперамоніє-мією внаслідок порушення орнітинового циклу виникла вторинна оротацидурія. Зростання якого метаболіту орнітинового циклу є причиною посиленого синтезу оротової кислоти?',
    'medium',
    216,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитруліну',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карбамоїлфосфату',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Орнітину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргініносукцинату',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечовини',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 218
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На основі лабораторного аналізу у хворого підтверджено діагноз - подагра. Для встановлення діагнозу було проведено визначення вмісту:',
    'medium',
    217,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Залишкового азоту в крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечової кислоти в крові та сечі',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечовини в крові та сечі',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміаку в сечі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатиніну в сечі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 219
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 50 років звернувся до сімейного лікаря зі скаргами на біль у суглобах пальців ніг. Зловживає алкоголем. Об’єктивно спостерігається: плюсно-фалангові суглоби різко деформовані, шкіра над ними червоного кольору, гаряча на дотик; на хрящах вушних раковин дрібні круглі вузли (тофуси). Уміст сечової кислоти в крові — 2,1 мммоль/л (норма 0,27-0,48 ммоль/л). Пацієнту встановлено діагноз: подагра. Що є найвагомішим у встановленні остаточного діагнозу в цьому разі?',
    'medium',
    218,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Навколосуглобова гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біль у суглобах',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Деформація суглобів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зловживання алкоголем',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперурікемія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 220
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнтів із подагрою часто визначається збільшения та деформація суглобів унаслідок запалення. Про який вид запалення свідчать ці зміни?',
    'medium',
    219,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферативне',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішане',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринозне',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альтеративие',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ексудативне',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 221
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка віком 52 роки спостерігаються лихоманка та біль у суглобах. Обидва перші плюсно-фалангові суглоби деформовані, набряклі, почервонілі. Сечова кислота у крові висока. Пацієнту діагностовано подагру. Який основний патогенетичний фактор розвитку цього захворювання?',
    'medium',
    220,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперурикемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперазотемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпераміноацидемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитрулінурія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргінінсукцинатурія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 222
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту, який хворіє на подагру, лікар призначив алопуринол, що призвело до зниження концентрації сечової кислоти. Яка властивість алопуринолу забезпечує цей терапевтичний ефект?',
    'medium',
    221,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорення катаболізму піримідинових нуклеотидів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конкурентне інгібування ксантиноксидази',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Уповільнення реутилізації піримідинових нуклеотидів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення швидкості виведення азотовмісних речовин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорення синтезу нуклеїнових кислот',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 223
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Підвищення вмісту молібдену в організмі призводить до інтенсивного утворення та накопичення сечової кислоти та її солей у тканинах і синовіальних оболонках суглобів, що є причиною розвитку «молібденової» подагри. Надлишок молібдену може так впливати на обмін пуринів, бо останній є складовою частиною і активатором ферменту:',
    'medium',
    222,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксантингуанінфосфорибозилтрансферази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденінфосфорибозилтрансферази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксантиноксидази',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альдегідоксидази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфітоксидази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 224
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на подагру виявлено значне підвищення рівня сечової кислоти в крові. Кінцевим продуктом обміну яких речовин є сечова кислота?',
    'medium',
    223,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирних кислот',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глобулінів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тригліцеридів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пуринових основ',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбумінів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 225
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 65-ти років, який страждає на подагру, скаржиться на біль в ділянці нирок. При ультразвуковому обстеженні встановлена наявність ниркових каменів. Підвищення концентрації якої речовини є найбільш вірогідною причиною утворення каменів у даному випадку?',
    'medium',
    224,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечова кислота',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечовина',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білірубін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холестерин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 226
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 65 років, який страждає на подагру, скаржиться на болі в області нирок. При ультразвуковому обстеженні встановлена наявність ниркових каменів. У результаті якого процесу утворюються ниркові камені?',
    'medium',
    225,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Катаболізму білків',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розпаду пуринових нуклеотидів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Орнітинового циклу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розпаду гему',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Відновлення цистеїну',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 227
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 42 років, який страждає на подагру, в крові підвищена концентрація сечової кислоти. Для зниження рівня сечової кислоти йому призначений алопуринол. Конкурентним інгібітором якого ферменту є алопуринол?',
    'medium',
    226,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденозиндезамінази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксантиноксидази',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксантинфосфорибозилтрансферази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденінфосфорибозилтрансферази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гуаніндезамінази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 228
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 65 років, що страждає на подагру, скаржиться на болі в області нирок. При ультразвуковому дослідженні встановлено наявність ниркових каменів. В результаті якого процесу утворюються ниркові камені?',
    'medium',
    227,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розпаду пуринових нуклеотидів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Орнітинового циклу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розпаду гема',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Відновлення цистеїну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Катаболізм білків',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 229
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому при подагрі лікар призначив алопуринол. Яке фармакологічна властивість алопуринолу забезпечує терапевтичний ефект в даному випадку?',
    'medium',
    228,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення швидкості виведення азотовмісних речовин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорення катаболізму піримідинових нуклеотидів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Конкурентне інгібування ксантиноксидази',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Уповільнення реутилізацію піримідинових нуклеотидів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорення синтезу нуклеїнових кислот',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 230
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з цирозом печінки разом з лікарськими препаратами внутрішньовенно ввели 500,0 мл 5% розчину глюкози. Яке порушення водного балансу найбільш ймовірно може виникнути у хворого?',
    'medium',
    229,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна дегідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна гіпергідратація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпергідратація',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушень водного балансу НЕ відбудеться',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна гіпергідратація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 231
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 58 років, який працює у гарячому цеху протягом 4-х годин, відчув спрагу, дратівливість, яка змінилися на сонливість. Можливості вживання води немає. Яке порушення водно-електролітного обміну розвинулося в пацієнта?',
    'medium',
    230,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна дегідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна гіпергідратація',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна дегідратація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна дегідратація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпергідратація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 232
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий надійшов у інфекційне відділення: шкіра суха, тургор шкіри знижений, випорожнення у вигляді рисового відвару. Поставлено діагноз: холера. Яке порушення водно-електролітного балансу найімовірніше виникає при даному захворюванні?',
    'medium',
    231,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмотична гіпогідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмотична гіпогідратація',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмотична гіпергідратація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмотична гіпергідратація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмотична гіпогідратація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 233
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитина трьох років доставлена до реанімаційного відділення інфекційної лікарні. При огляді: стан важкий, шкіра та слизові оболонки сухі, тургор тканин знижений. З анамнезу відомо, що протягом доби після вживання недоброякісної їжі в дитини була профузна діарея та багаторазове блювання. Який вид порушення водно-сольового обміну розвинувся у хворої дитини?',
    'medium',
    232,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна дегідратація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпергідратація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна дегідратація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна гіпергідратація',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 234
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який хворіє на цукровий діабет другого типу, але гіперглікемічна кома (рівень глюкози крові - 56 ммоль/л). Яке патологічне явище в цьому разі лежить в основі порушення функцій клітин мозку пацієнта?',
    'medium',
    233,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсичне ураження',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпергідратація клітин мозку (набухання)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іонний дисбаланс',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпогідратація клітин мозку',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енергодефіцит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 235
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Трьохрічну дитину госпіталізовано до реанімаційного відділення інфекційної лікарні. Під час огляду спостерігається: стан важкий, шкіра та слизові оболонки сухі, тургор тканин знижений. З анамнезу відомо, що протягом доби після вживання недоброякісної їжі в дитини була профузна діарея та багаторазове блювання. Який вид порушення водно-сольового обміну розвинувся у дитини?',
    'medium',
    234,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна дегідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпергідратація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоосмолярна гіпергідратація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна дегідратація',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна гіпергідратація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 236
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на ентерит, що супроводжувався значною діареєю, спостерігається зменшення кількості води в позаклітинному просторі, збільшення її всередині клітин та зниження осмолярності крові. Як називають таке порушення водно-електролітного обміну?',
    'medium',
    235,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна гіпергідратація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпергідратація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Осмолярна гіпогідратація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярна гіпогідратація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоосмолярна гіпогідратація',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 237
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет виникла значна спрага, дисфагія та порушення психічної діяльності. Який тип розладів водно-електролітного балансу характеризує поява вказаних ознак?',
    'medium',
    236,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіпоосмотична',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація ізоосмотична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дегідратація гіперосмотична',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація гіпоосмотична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідратація ізоосмотична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 238
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час обстеження у пацієнта спостерігається гіперглікемія, кетонурія, поліурія, гіперстенурія та глюкозурія. Яка форма порушення кислотно-лужної рівноваги спостерігається в цій ситуації?',
    'medium',
    237,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 239
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 32-х років, хворого на пневмонію, спостерігається закупорка харкотинням дихальних шляхів. В організмі хворого при цьому буде розвиватися така зміна кислотно-лужної рівноваги:',
    'medium',
    238,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змін не буде',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 240
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Із розвитком якого патологічного стану може пов''язуватись підвищення концентрації амонійних солей у сечі пацієнта?',
    'medium',
    239,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретенційна азотермія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперурикемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стеатоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперхолестеролемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 241
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка виявлено зниження рН крові та вмісту бікарбонатних іонів (падіння лужного резерву крові), зростання вмісту молочної та піровиноградної кислот у крові та сечі. Який тип порушення кислотно-основної рівноваги спостерігається у пацієнта?',
    'medium',
    240,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаний алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 242
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з дихальною недостатністю рН крові 7,35. Визначення рСО. показало наявність гіперкапнії. При дослідженні рН сечі відзначається підвищення її кислотності. Яка форма порушення кислотно-основного стану в даному випадку?',
    'medium',
    241,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз метаболічний, компенсований',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкалоз газовий, декомпенсований',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз газовий, компенсований',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкалоз газовий, компенсований',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз метаболічний, декомпенсований',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 243
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 30 років, який хворіє на цукровий діабет 1-го типу, було госпіталізовано у стані коми. Лабораторні дослідження виявили гіперглікемію, кетонемію. Яке з наведених нижче метаболічних порушень може бути у цього пацієнта?',
    'medium',
    242,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нормальний кислотно-лужний стан',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 244
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Патологічні стани, що характеризуються накопиченням в організмі кислих або лужних сполук, призводять до порушення кислотно-основного балансу. Яка патологія виникає внаслідок гіповентиляції або вдихання повітря з підвищеною концентраціею СО2?',
    'medium',
    243,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 245
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У немовляти внаслідок неправильного годування виникла виражена діарея. Одним з основних наслідків діареї є екскреція великої кількості бікарбонату натрію. Яка форма порушення кислотно-лужного балансу має місце в цьому випадку?',
    'medium',
    244,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Не буде порушень кислотно-лужного балансу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 246
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні хворого визначається наявність гіперглікемії, кетонурія, поліурії, гиперстенурия і глюкозурії. Яка форма порушення кислотно - лужного балансу має місце в даній ситуації?',
    'medium',
    245,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 247
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 32-х років, хворого на пневмонію, спостерігається закупорка харкотинням дихальних шляхів. В організмі хворого при цьому буде розвиватися така зміна кислотнолужної рівноваги:',
    'medium',
    246,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змін не буде',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 248
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого після вживання недоброякісної їжі розвинувся багаторазовий пронос. На наступний день у нього знизився артеріальний тиск, з’явились тахікардія, екстрасистолія. pH крові складає 7,18. Ці порушення є наслідком розвитку:',
    'medium',
    247,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазового алкалозу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазового ацидозу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газового ацидозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічного алкалозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газового алкалозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 249
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого виявлено порушення прохідності дихальних шляхів на рівні дрібних і середніх бронхів. Які порушення кислотно - лужної рівноваги можна визначити в крові в даному випадку?',
    'medium',
    248,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 250
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При цукровому діабеті внаслідок активації процесів окиснення жирних кислот виникає кетоз. До яких порушень кислотно-лужної рівноваги може призвести надмірне накопичення кетонових тіл у крові?',
    'medium',
    249,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змін не відбуватиметься',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 251
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В умовах запалення знижується сила місцевоанестезуючої дії новокаїну. В умовах якого стану у вогнищі запалення виникає порушення гідролізу солі новокаїну і вивільнення активного анестетика-основи?',
    'medium',
    250,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення активності карбоангідрази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення окислювального фосфорилювання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Локального тканинного ацидозу',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Локального тканинного алкалозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація сукцинатдегідрогенази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 252
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з дихальною недостатністю рН крові 7,35. Визначення рСO2 показало наявність гіперкапнії. При дослідженні рН сечі відзначається підвищення її кислотності. Яка форма порушення кислотно-основного стану в даному випадку?',
    'medium',
    251,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкалоз газовий, декомпенсований',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз метаболічний, декомпенсований',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алкалоз газовий, компенсований',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз газовий, компенсований',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидоз метаболічний, компенсований',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 253
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого після вживання недоброякісної їжі розвинулася діарея. На наступний день у нього знизився артеріальний тиск, з’явились тахікардія, екстрасистолія. pH крові складає 7,18. Ці порушення є наслідком розвитку:',
    'medium',
    252,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазового ацидозу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газового ацидозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газового алкалозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічного алкалозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазового алкалозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 254
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого виявлено порушення прохідності дихальних шляхів на рівні дрібних і середніх бронхів. Які порушення кислотно-лужної рівноваги можна виявити у крові в даному',
    'medium',
    253,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний ацидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 255
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час напруженої фізичної роботи у м’язах вантажника утворюється лактат, проте вираженого лактацидозу не спостерігається. Який цикл забезпечує вчасну утилізацію лактату?',
    'medium',
    254,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кребса',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кальвіна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кopi',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мейстера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Орнітиновий',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 256
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки віком 59 років яка хворіє на цукровий діабет, виник метаболічний ацидоз унаслідок накопичення кетонових тіл у крові. Які зміни з боку дихальної системи будуть спостерігатися у пацієнтки?',
    'medium',
    255,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Відбувається затримка дихання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Періодичні бронхостазми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Посилюється вентиляція легень',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Знижується вентиляція легень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спостерігається дихання Чейна-Стокса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 257
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтка віком 47 років скаржиться на тривале блювання. Виявлено, що вона втратила багато шлункового соку. Яке ймовірне порушення КОС у пацієнтки?',
    'medium',
    256,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 258
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 45 років звернувся до лікаря зі скаргами на головний біль, запаморочення, часту нудоту, блювання, м''язову слабість, болі в ділянці серця. АТ - 170/110 мм. рт. ст. Рівень натрію в периферичній крові - 165 ммоль/л, калію - 2,5 ммоль/л. Під час комп''ютерної томографії виявлено пухлину лівого наднирника розміром 1 см. Які зміни кислотно-основної рівноваги спостерігаються у разі цього захворювання?',
    'medium',
    257,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальний алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний алкалоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кислотно-основна рівновага не порушується',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 259
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта віком 57 років шпиталізували у важкому стані. За показниками біохімічного аналізу крові виявлено рН - 7,33, рСО2 артеріальної крові – 36 мм.рт.ст., SB-17 ммоль/л, ВЕ становить +6 ммоль/л. Який тип порушення кислотно-лужного балансу спостерігається у цьому разі?',
    'medium',
    258,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпенсований негазовий алкалоз (закодовано на ЦТ)',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компенсований негазовий алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компенсований газовий алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпенсований негазовий ацидоз (правильна відповідь)',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компенсований негазовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 260
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина в стані спокою штучно примушує себе дихати часто і глибоко впродовж 3-4 хвилин. Як це відбивається на кислотно-лужній рівновазі організму?',
    'medium',
    259,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виникає метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виникає метаболічний алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виникає дихальний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виникає дихальний алкалоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виникає змішаний ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 261
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При підйомі в гори у альпініста розвинулась ейфорія, яка замінилася головним болем, запамороченням, серцебиттям, задишкою, що перейшла в апное. Яке порушення кислотно-лужної рівноваги розвинулось в даному випадку?',
    'medium',
    260,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 262
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина застосовувала дихальну методику, яка заснована на проведенні частого та поверхнього дихання, що супроводжується гіповентиляцією. Внаслідок чого при цьому розвивається респіраторний ацидоз?',
    'medium',
    261,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестачі СО2 в крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Надлишку О2 в крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Надлишку СО2 в крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестачі О2 в крові',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 263
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вагітної жінки розвинувся токсикоз з тяжким повторним блюванням шлунковим вмістом протягом доби. Наприкінці доби почали проявлятися тетанічні судоми та зневоднення організму. Який розлад кислотно-лужної рівноваги викликав дані зміни?',
    'medium',
    262,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий видільний ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий видільний алкалоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий метаболічний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 264
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта у результаті тривалого блювання відбувається значна втрата шлункового соку, що є причиною порушення кислотно-лужного стану в організмі. Яка з перерахованих форм порушення кислотно-лужного стану має місце?',
    'medium',
    263,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 265
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 46-ти років, хворий на гіпертонічну хворобу, разом з безсольовою дієтою та з антигіпертензивними засобами довгий час приймав гідрохлортіазид, що зумовило порушення електролітного балансу. Яке порушення внутрішнього середовища виникло у хворого?',
    'medium',
    264,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення об’єму циркулюючої крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперкаліємія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпохлоремічний алкалоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпермагніємія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 266
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У реанімаційному відділенні знаходиться хворий у коматозному стані. При дослідженні крові відзначено збільшення концентрації іонів K+ і зменшення - Ca++, ацидоз, збільшення рівнів сечовини, сечової кислоти. Який вид коми за етіологією найбільш імовірний?',
    'medium',
    265,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ниркова',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінкова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоглікемічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Діабетична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейрогенна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 267
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 40-ка років ознаки гірської хвороби: запаморочення, задишка, тахікардія, рН крові - 7,50, pCO2 -30 мм рт.ст., зсув буферних основ +4 ммоль/л. Яке порушення кислотно-основного стану має місце?',
    'medium',
    266,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 268
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий на гіпертонічну хворобу разом з безсольовою дієтою та з антигіпертензивними засобами, довгий час приймав гідрохлортіазид, що зумовило порушення електролітного балансу. Яке порушення внутрішнього середовища виникло у хворого?',
    'medium',
    267,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпохлоремічний алкалоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперкаліємія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення об’єму циркулюючої крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпермагніємія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 269
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У немовляти з пілороспазмом внаслідок блювання, що часто повторювалося, з’явилися слабкість, гіподинамія, іноді судоми. Яка форма порушення кислотно-основного стану в нього спостерігається?',
    'medium',
    268,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний алкалоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екзогенний негазовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 270
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженої дитини з пілоростенозом часте блювання, що супроводжується апатією, слабкістю, підвищенням тонусу м’язів, інколи судомами. Яка форма порушення кислотно-основного стану розвинулася в хворого?',
    'medium',
    269,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 271
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вагітної жінки розвинувся токсикоз з важкими повторними блюваннями протягом доби. До кінця доби почали з’являтися тетанічні судоми та зневоднення організму. Який зсув кислотно-лужного стану викликав вказані зміни?',
    'medium',
    270,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний алкалоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Видільний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 272
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого струс головного мозку, що супроводжується повторним блюванням та задишкою. В артеріальній крові: рН- 7,62; PC02 - 40 мм рт.ст. Яке порушення кислотноосновного стану у хворого?',
    'medium',
    271,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 273
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини, яка страждає на пілоростеноз, що супроводжується частими блюваннями, розвинулися ознаки зневоднення організму. Яка форма порушення кислотнолужного стану може розвинутися у даному випадку?',
    'medium',
    272,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий алкалоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий алкалоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газовий ацидоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негазовий ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічний ацидоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 274
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У породіллі через 24 години після пологів діагностовано емболія легеневої артерії. З''явилася задишка з частим глибоким диханням. АТ - 90/40 мм рт. ст, частота серцевих скорочень - 99 / хв. Газовий аналіз: рН = 7,48; pC Про 2 = 32 мм рт. ст.; [ НСО 3 ] = 20 ммоль / л ; [BE] = +1 ммоль / л. Яке з перерахованих нижче розладів кислотно - лужного стану має місце в цьому випадку?',
    'medium',
    273,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Де компенсований метаболічний ацидоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Респіраторний алкалоз + метаболічний ацидоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпенсований респіраторний алкалоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компенсований метаболічний ацидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компенсований респіраторний алкалоз',
    false,
    4,
    NOW(),
    NOW()
  );
  
  RAISE NOTICE 'Додано питань: 274';
END $$;
