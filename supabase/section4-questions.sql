-- SQL для додавання питань до розділу 4: Розвиток людини й основи генетики
-- Автоматично згенеровано
-- Кількість питань: 262

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
  
  -- Створюємо або знаходимо topic для розділу 4
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Розвиток людини й основи генетики'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Розвиток людини й основи генетики',
      'Тести з розвитку людини та основ генетики',
      0,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;
  
  RAISE NOTICE 'Початок додавання питань для розділу 4...';
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
    'У здорових батьків, спадковість яких не обтяжена, народилася дитина з множинними вадами розвитку. Цитогенетичний аналіз виявив у соматичних клітинах дитини трисомію за 18-ю хромосомою (синдром Едвардса). З яким явищем пов’язане народження такої дитини?',
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
    'Нерозходженням пари хромосом під час гаметогенезу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомною мутацією - дуплікацією',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматичною мутацією у ембріона',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантною мутацією',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Впливом тератогенних факторів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 2
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків, спадковість яких не обтяжена, народилась дитина з чисельними вадами розвитку. Цитогенетичний аналіз виявив в соматичних клітинах дитини трисомію за 13-ю хромосомою (синдром Патау). З яким явищем пов’язане народження такої дитини?',
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
    'Порушення гаметогенезу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантна мутація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивна мутація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна мутація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматична мутація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 3
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У мужчини 32-х років високий зріст, гінекомастія, жіночий тип оволосіння, високий голос, розумова відсталість, безпліддя. Попередній діагноз - синдром Клайнфельтера. Що необхідно дослідити для його уточнення?',
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
    'Родовід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоцитарна формула',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Група крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сперматогенез',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріотип',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 4
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відомо, що характер дроблення залежить від будови яйцеклітини. Який тип дроблення характерний для зиготи людини?',
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
    'Повне, нерівномірне , асинхронне',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повне, асинхронне',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне, асинхронне',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне, нерівномірне, синхронне',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне, рівномірне, асинхронне',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 5
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Кросинговер – це обмін ділянками гомологічних хромосом у процесі клітинного поділу, переважно в профазі першого мейотичного поділу, іноді в мітозі. Від чого залежить частота кросинговеру?',
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
    'Від відстані між генами',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від зовнішніх факторів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від кількості хромосом',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від типу хромосоми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від довжини хромосоми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 6
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На одній з фаз сперматогенезу спостерігаються зміни ядра і цитоплазми сперматид, які призводять до утворення зрілих статевих клітин. Назвіть фазу гаметогенезу.',
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
    'Формування',
    true,
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
    'Росту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розмноження',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проліферація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 7
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У порожнині матки був виявлений ембріон людини не прикріплений до ендометрію. Якій стадії розвитку відповідає зародок?',
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
    'Бластоцисти',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зиготи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морули',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаструли',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейрули',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 8
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Процес дроблення зиготи завершується утворенням бластули. Який тип бластули характерний для людини?',
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
    'Бластоциста',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Целобластула',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дискобластула',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амфібластула',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морула',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 9
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Зародок ланцетника перебуває на одній із стадій розвитку, під час якої кількість його клітин збільшується, але загальний об’єм зародка практично не змінюється. На якій стадії розвитку знаходиться зародок?',
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
    'Дроблення',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенезу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаструляції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейруляції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органогенезу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 10
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Процес імплантації відбувається в два етапи: адгезія та інвазія. Морфологічним проявом процесу адгезії бластоцисти є:',
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
    'Руйнування судин ендометрію',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прикріплення бластоцисти до ендометрію',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Формування лакун',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Руйнування сполучної тканини ендометрію',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Руйнування епітелію ендометрію',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 11
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При утворенні зародка людини можна спостерігати появу в його складі порожнини, світлих дрібних бластомерів на периферії та темних великих бластомерів на одному з полюсів. Як називається зародок на цій стадії розвитку?',
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
    'Гаструла',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морула',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зигота',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бластоциста',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зародковий диск',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 12
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Імплантація зародка в слизову оболонку матки складається з двох фаз - адгезії та інвазії. Перша фаза супроводжується:',
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
    'Руйнуванням сполучної тканини ендометрію',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прикріпленням бластоцисти до поверхні ендометрію',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Руйнуванням епітеліоцитів слизової оболонки (ендометрію) матки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активізацією секреції маткових залоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригніченням секреції маткових залоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 13
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вкажіть, як називається процес виникнення відмінностей у будові та функціонуванні клітин, тканин і органів в процесі онтогенезу:',
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
    'Диференціація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаструляція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органогенез',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інвагінація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенез',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 14
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Що може бути наслідком пошкодження генетичного апарату статевих клітин?',
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
    'Спадкові хвороби',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Злоякісні пухлини',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутоімунні процеси',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Старіння',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування апоптозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 15
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На певному етапі онтогенезу людини між кровоносними системами матері і плоду встановлюється фізіологічний зв’язок. Цю функцію виконує провізорний орган:',
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
    'Плацента',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовтковий мішок',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амніон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серозна оболонка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алантоіс',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 16
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У немовляти присутня мікроцефалія. Лікарі вважають, що це зв’язано з застосуванням жінкою під час вагітності актіноміцину D. На які зародкові листки подіяв цей тератоген?',
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
    'Ектодерма',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерма',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезодерма',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерма та мезодерма',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі листки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 17
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вагітна жінка вживала алкоголь, що призвело до порушення закладки ектодерми ембріону. У яких похідних цього листка розвинуться вади?',
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
    'Статеві залози',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Надниркові залози',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епітелій кишечника',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нирки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нервова трубка',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 18
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У процесі диференціації зародкової ектодерми утворюються: нервова трубка, нервові гребені, плакоди, шкірна ектодерма та прехордальна пластинка. Як називається процес формування нервової трубки?',
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
    'Гаструляція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейруляція',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органогенез',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сомітогенез',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенез',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 19
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На третьому тижні ембріогенезу центральна частина клітин епібласту (ектодерми) прогинається і починається процес нейруляції. В якому напрямку диференціюється решта клітин ектодерми?',
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
    'Кишки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шкіра',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соміти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '_',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хорда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 20
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У препараті 10-дснного зародка людини видно 2 міхурці, що контактують між собою (амніотичний та жовтковий). Як називається структура, що лежить у місці їх контакту?',
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
    'Дно амніотичного міхурця',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зародковий щиток',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амніотична ніжка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дах жовткового міхурця',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Позазародкова мезодерма',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 21
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопічному дослідженні первинної кори кореня у всисній зоні виявлено, що основну її масу складає багатошарова жива пухка паренхіма з крохмальними зернами. Це:',
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
    'Мезодерма',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендодерма',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екзодерма',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коленхіма',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фелоген',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 22
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У гістологічному препараті нижньої щелепи ембріону виявляється зубний зачаток, в якому зубний сосочок утворений дрібними зірчастими базофільно забарвленими клітинами. Яка тканина утворює цю частину зубного зачатку?',
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
    'Мезенхіма',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хрящова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретикулярна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кісткова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епітеліальна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 23
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У генетично здорової жінки, яка під час вагітності перенесла вірусну кореву краснуху, народилася глуха дитина із розщілиною верхньої губи і піднебіння. Це є проявом:',
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
    'Фенокопії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генних мутацій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генокопії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативної мінливості',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомної аберації',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 24
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікар виявив у дитини рахіт, зумовлений нестачею вітаміну D, але за своїм проявом подібний до спадкового вітаміностійкого рахіту (викривлення трубчастих кісток, деформація суглобів нижніх кінцівок, зубні абсцеси). Як називаються вади розвитку, які нагадують спадкові, але не успадковуються?',
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
    'Фенокопії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генокопії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генні хвороби',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 25
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка під час вагітності хворіла на вірусну краснуху. Дитина у неї народилась з вадами розвитку – незрощення губи і піднебіння. Генотип у дитини нормальний. Ці аномалії розвитку є проявом:',
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
    'Модифікаційної мінливості',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоїдії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативної мінливості',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомної мутації',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплодії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 26
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 50-х роках у Західній Європі від матерів, які приймали в якості снотворного талідомід, народилося кілька тисяч дітей з відсутністю або недорозвиненням кінцівок, порушенням будови скелета, іншими вадами. Яка природа даної патології?',
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
    'Фенокопія',
    true,
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
    'Моносомія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Триплоїдія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генна мутація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 27
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 50-х роках у Західній Європі від матерів, які приймали в якості снодійного талідомід, народилося кілька тисяч дітей з відсутністю або недорозвиненням кінцівок, порушенням будови скелета, іншими вадами. Яка природа даної патології?',
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
    'Моносомія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Триплоїдія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тератогенна дія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генна мутація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 28
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На мікропрепараті очного яблука плода спостерігається пошкодження рогівки. Частина якого зародкового листка була уражена в процесі ембріонального розвитку?',
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
    'Ектодерма',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерма',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезодерма',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматом',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефротом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 29
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Розпочинається імплантація бластоцисти людини. Як називається період ембріогенезу, що розпочинається одночасно з імплантацією?',
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
    'Гаструляція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інвагінація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Диференціювання',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенез',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроблення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 30
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На мікропрепараті зародка людини, взятого з мимовільного викидня, виявлено зародковий щиток, в якому розпізнаються два шари клітин: енто- і ектодерма. На якому етапі ембріонального розвитку був ембріон?',
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
    'Гаструляції',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Органогенезу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенезу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейруляції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прогенезу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 31
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вагітної жінки, яка вживала алкоголь, порушилась закладка ектодерми в ембріональний період. В яких похідних цього листка розвинуться вади?',
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
    'Нервова трубка',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нирки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епітелій кишечника',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Надниркові залози',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Статеві залози',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 32
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок дії тератогенного фактору у зародка порушено розвиток кровоносної системи. В якому зародковому листку виникло це порушення?',
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
    'Мезодерми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екзодерми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енто- і мезодерми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енто- і ектодерми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 33
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати дитини під час вагітності хворіла на коровy краснуху, внаслідок чого порушився процес закладки мезодерми. Патологія якої системи може спостерігатися в дитини?',
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
    'Видільної',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нервової',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Печінки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підшлункової залози',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дихальної',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 34
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На стадії бластоцисти зареєстровано початок імплантації зародка людини у стінку матки. В який термін ембріогенезу це відбувається?',
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
    '6 - 7 доба',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '10 - 12 доба',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '24- 26 доба',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місяць',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '3 - 4 доба',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 35
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У зародка людини почалася закладка осьових органів. Як називається ця стадія розвитку?',
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
    'Нейрула',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бластула',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаструла',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроблення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зигота',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 36
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини досліджували розвиток зубів у ембріональний та постембріональний період. Було встановлено, що вони є похідними:',
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
    'Ектодерми і мезодерми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерми і мезодерми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки мезодерми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки ектодерми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ектодерми і ентодерми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 37
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженої дитини виявлено вроджені вади розвитку травної системи, що пов’язане з дією тератогенних факторів на початку вагітності. На який з зародкових листків подіяв тератоген?',
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
    'Ентодерма',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ектодерма',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерма і мезодерма',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезодерма',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі листки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 38
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В результаті експресіії окремих компонентів геному клітини зародка набувають характерних для них морфологічних, біохімічних та функціональних особливостей. Яку назву має цей процес?',
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
    'Диференціювання',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Капацитація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецепція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Детермінація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Індукція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 39
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Один з критичних періодів ембріогенезу людини є імплантація зародка в стінку матки на протязі 7-ої доби. Який процес гаструляції відбувається в ембріобласті в цей період?',
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
    'Делямінація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міграція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епіболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інвагінація',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейруляція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 40
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Розпочинається імплантація бластоцисти людини. Як називається період ембріогенезу, що розпочинається одночасно з імплантацією?',
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
    'Диференціювання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаструляція',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інвагінація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістогенез',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроблення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 41
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На мікропрепараті шкіри пальця дитини спостерігаємо, що епідерміс має ознаки недостатнього розвитку. Назвіть, який ембріональний листок в процесі розвитку був пошкоджений?',
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
    'Ектодерма',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезодерма',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерма',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезенхіма',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ектомезенхіма',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 42
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При ультразвуковому обстеженні вагітної жінки було діагностовано багатоводдя. З порушенням діяльності яких позазародкових органів можна пов’язати даний патологічний стан?',
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
    'Амніотичної оболонки',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хоріона',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плаценти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовткового мішка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алантоїса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 43
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Плацента (послід) є місцем тісного злиття зародкової оболонки з тканинами батьківського організму (матки). Яка провізорна (тимчасова) оболонка формує цей орган?',
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
    'Хоріон',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амніон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовтковий мішок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пупковий канатик',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алантоїс',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 44
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла мертвонародженої дитини виявлено аномалію розвитку серця: шлуночки не розмежовані, з правої частини виходить суцільний артеріальний стовбур. Для яких хребетних характерна подібна будова серця?',
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
    'Амфібії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Риби',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рептилії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ссавці',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Птахи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 45
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В процесі розвитку у дитини хребет поступово набув два лордози та два кіфози. Це пояснюється розвитком здатності до:',
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
    'Прямоходіння',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повзання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сидіння',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плавання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лежання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 46
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'П’ятирічна дівчинка, рятуючи молодшу сестру при пожежі, отримала 80% опіків шкіри. Хірурги очищали пошкоджені шматочки її шкіри та пересаджували на їх місце взяту з непошкоджених ділянок шкіру, а також клітини власної шкіри, культивовані поза організмом (in vitro). Який вид трансплантації застосовано в цій ситуації?',
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
    'Аутотрансплантацію',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізотрансплантацію',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алотрансплантацію',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксенотрансплантацію',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетеротрансплантацію',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 47
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У клініці для лікування інфаркту міокарда пацієнту введено ембріональні стовбурові клітини, що одержано шляхом терапевтичного клонування в цього ж пацієнта. Як називається цей вид трансплантації?',
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
    'Аутотрансплантація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізотрансплантація',
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
    'Гетеротрансплантація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксенотрансплантація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 48
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка, яка регулярно зловживала алкогольними напоями, народила дівчинку, яка значно відставала в фізичному та розумовому розвитку. Лікарі констатували алкогольний синдром плода. Наслідком якого впливу є цей стан дівчинки?',
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
    'Тератогенного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутагенного',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малігнізації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канцерогенного',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генокопії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 49
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час онтогенезу в людини з’явилися такі вікові зміни: зменшилася життєва ємність легень, підвищився артеріальний тиск, розвинувся атеросклероз. Як називається період індивідуального розвитку, для якого найбільш характерні такі зміни?',
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
    'Похилий вік',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перший зрілий вік',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ювенільний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підлітковий',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Юнацький',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 50
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати під час вагітності вживала синтетичні гормони. У новонародженої дівчинки спостерігалося підвищене оволосіння, що мало зовнішню схожість з адреногенітальним синдромом. Як називається такий прояв мінливості?',
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
    'Фенокопія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рекомбінація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетерозис',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 51
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вагітної 25-ти років у третьому триместрі вагітності при черговому УЗД обстеженні встановлено вадурозвитку дитини. З анамнезу відомо, що жінка без призначення лікаря приймала впродовж строку вагітності у великих дозах діазепам. Який вид побічної дії має місце?',
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
    'Мутагенний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тератогенний',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фетотоксичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ембріотоксичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канцерогенний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 52
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Прийом деяких лікарських засобів під час вагітності збільшують ризик народження дитини з генетичним вадами. Назвіть цю небажану дію:',
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
    'Мутагенний ефект',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ембріотоксичний ефект',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фітотоксичний ефект',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бластомогенний ефект',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тератогенний ефект',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 53
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Тривале вживання деяких лікарських засобів, що передують вагітності, збільшують ризик народження дитини з генетичними вадами. Як називається ця дія?',
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
    'Тератогенний ефект',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фетотоксичний ефект',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ембріотоксичний ефект',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутагенний ефект',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бластомогенний ефект',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 54
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До жіночої консультації звернулася жінка 26-ти років, у якої було два мимовільні викидні. Яке протозойне захворювання могло спричинити невиношування вагітності?',
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
    'Трипаносомоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонадоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 55
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернулося подружжя у зв’язку з народженням дитини з багатьма вадами розвитку (мікроцефалія, ідіотія, тощо). Жінка під час вагітності хворіла, але мутагенів та тератогенів не вживала. Каріотип батьків і дитини нормальний. Під час збору анамнезу з’ясовано, що сім’я у квартирі тримає кота. Яке захворювання матері під час вагітності, найбільш вірогідно стало причиною вад розвитку у дитини?',
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
    'Токсоплазмоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомоноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дизентерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 56
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 32 років з безсимптомним перебігом хвороби народилася мертва дитина з вираженою мікроцефалією. Про якому захворюванні в першу чергу слід подумати лікарю?',
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
    'Гістоплазмоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лістеріоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сифіліс',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бруцельоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 57
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час бактеріоскопічного дослідження мазків спинномозкової рідини, забарвлених за Романовським-Гімзою, виявлено найпростіших у формі півмісяця з загостреними кінцями, блакитною цитоплазмою та рубіново-червовим ядром. Для збудника якого захворювання характерні ці ознаки?',
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
    'Токсоплазмоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносомоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 58
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки народилась мертва дитина з багатьма вадами розвитку. Яке протозойне захворювання могло спричинити внутрішньоутробну загибель?',
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
    'Токсоплазмоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 59
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту встановлено попередній діагноз: токсоплазмоз. Який біологічний матеріал використано для діагностики цього захворювання?',
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
    'Кров',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мокротиння',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуодентальний вміст',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фекалії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 60
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вади розвитку плода можуть бути наслідками таких хвороб матері як краснуха, сифіліс, токсоплазмоз, цитомегалія, герпес, хламідіоз. До якої форми мінливості відносяться такі вади розвитку?',
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
    'Епімутаційна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Модифікаційна',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутаційна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геномного імприптингу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 61
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки народилася хвора на токсоплазмоз дитина. Жінка вважає, що заразилася токсоплазмою від подруги, яка нещодавно також народила хвору дитину. Який спосіб зараження людини токсоплазмою є НЕМОЖЛИВИМ?',
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
    'Контакт з кішкою',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пиття води, зараженої ооцитами',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Контакт з хворою людиною',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вживання напівсирого м''яса зараженої свійської тварини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Споживання немитих овочі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 62
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У немовляти присутній мікроцефалія. Лікарі вважають, що це пов''язано із застосуванням жінкою під час вагітності актиноміцину D. На які зародкові листки подіяв цей тератоген?',
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
    'Ентодерма',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезодерма',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ектодерма',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентодерми і мезодерма',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі листки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 63
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчинці діагностовано первинну мікроцефалію, що є моногенним аутосомно-рецесивним захворюванням. У рідного брата цієї дитини розвиток нормальний. Які генотипи батьків цих дітей?',
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
    'аа х аа',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ААВВ х ААВВ',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аa х аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х Аа',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х aa',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 64
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У родині здорових батьків, які нещодавно повернулися з Африки, народилася дитина з ознаками анемії та невдовзі померла. Обстеження виявило, що еритроцити дитини мають аномальну півмісяцеву форму. Хвороба успадковується за аутосомно-рецесивним типом. Визначте можливі генотипи батьків.',
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
    'AA х AA',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'aa x aa',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Aa х AA',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Aa x аa',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа x Aa',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 65
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернувся чоловік з кольоровою сліпотою. Це зчеплена з Х-хромосомою рецесивна ознака. Яка імовірність появи в його родині дітей-дальтоників, якщо в генотипі його дружини такий алель відсутній?',
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
    '50%',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '100%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 66
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У деяких клінічно здорових людей в умовах високогір’я виявляються ознаки анемії. У крові в них виявляють серпоподібні еритроцити. Генотип цих людей:',
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
    'ХсХс',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ХСХс',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 67
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини з четвертою групою крові (генотип ІАІВ) в еритроцитах одночасно присутні антиген А, який контролюється алелем ІА, і антиген В - продукт експресії алеля ІВ. Прикладом якої взаємодії генів є дане явище?',
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
    'Полімерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповного домінування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарності',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістазу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 68
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У батьків, хворих на гемоглобінопатію (аутосомно-домінантний тип успадкування), народилася здорова дівчинка. Які генотипи батьків?',
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
    'Мати гетерозиготна за геном гемоглобінопатії, у батька цей ген відсутній',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Батько гетерозиготний за геном гемоглобінопатії, у матері цей ген відсутній',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У обох батьків ген гемоглобінопатії відсутній',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обоє гетерозиготні за геном гемоглобінопатії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обоє гомозиготні за геном гемоглобінопатії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 69
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Секреція грудного молока у жінок обумовлена полімерними генами, причому кількість молока зростає із збільшенням числа домінантних алелів цих генів у генотипі жінки. Який генотип може мати породілля з відсутністю молока?',
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
    'm1m1M2m2',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'M1m1M2m2',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'M1 M1m2m2',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'm1m1m2m2',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'M1m1m2m2',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 70
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Батько і син мають різні мітохондріальні геноми. Це пояснюється тим, що ці геноми:',
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
    'Не успадковуються',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мають високий рівень мутабільності',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мають різну експресивність',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Успадковуються від матері',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підлягають комбінативній мінливості',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 71
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Синдром котячого крику — рідкісне генетичне захворювання, яке пов’язане з відсутністю частини п’ятої хромосоми. За допомогою якого методу можна визначити це захворювання?',
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
    'генеалогічного',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюкового',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Статевого хроматину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічного',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріотипування',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 72
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У мужчини 32-х років високий зріст, гінекомастія, жіночий тип оволосіння, високий голос, розумова відсталість, безпліддя. Попередній діагноз - синдром Клайнфельтера. Що необхідно дослідити для його уточнення?',
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
    'Родовід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоцитарна формула',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Група крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сперматогенез',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріотип',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 73
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженого діагностовано синдром Дауна, що супроводжується розумовою відсталістю, низьким зростом, короткопалістю рук і ніг монголоїдним розрізом очей. Каріотипування показало наявність трисомії у 21й парі хромосом. До якого типу спадкової патології належить це захворювання?',
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
    'Хромосомної хвороби',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фетопатії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Молекулярно-генної хвороби',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гаметопатії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бластопатії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 74
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На підставі фенотипового аналізу в жінки встановлено попередній діагноз: полісомія Х-хромосом. Для уточнення діагнозу використовується цитогенетичний метод. Діагноз буде підтверджено, якщо каріотип буде:',
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
    '48(XXXY)',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47(ХХХ)',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '48(XXYY)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47(XXY)',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '46(XX)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 75
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого в анамнезі відзначено тривале зростання кінцівок, подовжені "павукові" пальці, дефекти кришталика ока, аномалії серцево - судинної системи. Інтелект в нормі. Які фенотипові ознаки ще можуть бути у цього хворого:',
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
    'Плоске обличчя і широке перенісся',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення розвитку сполучної тканини',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розщеплення м''якого та твердого піднебіння',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Недорозвинення гонад',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Недорозвинення нижньої щелепи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 76
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У каріотипі пацієнта 47 хромосом, у ядрі соматичної клітини виявлено тільце Барра. Під час додаткових досліджень спостерігається ендокринна недостатність: недорозвиток сім''яників та відсутність сперматогенезу. Про який синдром свідчить цей фенотип?',
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
    'Патау',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Едвардса',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клайнфельтера',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шерешевського-Тернера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 77
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У батька та матері широка щілина між різцями є домінантною ознакою. Обидва гомозиготні. Яка генетична закономірність проявиться у їх дітей?',
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
    'Незалежне успадкування ознаки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Незчеплене успадкування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Одноманітність гібридів першого покоління',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплене успадкування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розщеплення гібридів за фенотипом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 78
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні новонароджених в одному з міст України у дитини виявлено фенілкетонурію. Батьки дитини не страждають на цю хворобу та мають двох здорових дітей. Визначте можливі генотипи батьків з геном фенілкетонурії.',
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
    'Аа х Аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х аа',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х АА',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 79
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хлопчика велика щілина між різцями. Відомо, що ген, відповідальний за розвиток такої аномалії, домінантний. У рідної сестри цього хлопчика зуби звичайного положення. За генотипом дівчинка буде:',
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
    'Гомозигота рецесивна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетерозигота',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гомозигота домінантна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дігетерозигота',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тригетерозигота',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 80
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік є гомозиготою за домінантним геном, що зумовлює полідактилію, а дружина — гомозиготою за рецесивним алелем цього гена. Яка з наведених біологічних закономірностей проявиться в їхніх дітей щодо наявності в них полідактилії?',
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
    'Закон одноманітності гібридів І покоління',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закон розчеплення',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закон незалежного успадкування ознак',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Явище зчепленого успадкування генів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Явище успадкування, зчепленого зі статтю',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 81
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік є гомозиготою за домінантним геном темної емалі зубів, а у його дружини - зуби мають нормальне забарвлення. У їх дітей спостерігатиметься закономірність:',
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
    'Одноманітність гібридів першого покоління',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розщеплення гібридів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне зчеплення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Незалежне успадкування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повне зчеплення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 82
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Аналізуються діти в одній сім''ї. Один з батьків гомозиготний по домінантному гену полідактилії, а другий - здоровий (гомозиготний по рецесивному гену) в цьому випадку в дітей проявиться закон:',
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
    'Незалежного спадкування',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплене успадкування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розщеплення гібридів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Чистоти гамет',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Одноманітності гібридів першого покоління',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 83
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У батька та матері широка щілина між різцями є домінантною ознакою. Обидва гомозиготні. Яка генетична закономірність проявиться у їх дітей?',
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
    'Незалежне успадкування ознаки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Незчеплене успадкування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Одноманітність гібридів першого покоління',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплене успадкування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розщеплення гібридів за фенотипом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 84
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої дитини спостерігаються ознаки ахондроплазії (карликовості). Відомо, що це моногенне захворювання і ген, який відповідає за розвиток такої аномалії, домінантний. У рідного брата цієї дитини розвиток нормальний. За генотипом здорова дитина буде:',
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
    'аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АаВb',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ААВВ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 85
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У генетично здорових батьків народилася дитина хвора на фенілкетонурію (аутосомно-рецесивне спадкове захворювання). Які генотипи батьків?',
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
    'Аа х Аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х АА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х Аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 86
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія успадковується як аутосомна рецесивна ознака. У родині, де обидвоє батьків здорові, народилася дитина хвора на фенілкетонурію. Які генотипи батьків?',
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
    'Аа х Аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х АА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х Аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 87
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У глухонімих батьків з генотипами DDee і ddEE народились діти з нормальним слухом. Яка форма взаємодії генів D i E?',
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
    'Комплементарність',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Наддомінування',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 88
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У юнака 18 років діагностовано хворобу Марфана. При дослідженні встановлено порушення розвитку сполучної тканини, будови кришталика ока, аномалії серцево-судинної системи, арахнодактилію. Яке генетичне явище зумовлює розвиток цієї хвороби?',
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
    'Плейотропія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарність',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Множинний алелізм',
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
  -- Питання 89
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Колір шкіри у людини контролюється кількома парами незчеплених генів, що взаємодіють за типом адитивної полімерії. Пігментація шкіри у людини з генотипом А1А1 А2А2 А3А3 буде:',
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
    'Чорна (негроїд)',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біла (європеоїд)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовта (монголоїд)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коричнева (мулат)',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбінос',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 90
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Зріст людини контролюють кілька неалельних домінантних генів. Встановлено, що при збільшенні кількості цих генів зріст збільшується. Який тип взаємодії між цими генами?',
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
    'Полімерія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарність',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плейотропія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 91
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини, хворої на серпоподібноклітинну анемію, спостерігаються кілька патологічних ознак: анемія, збільшена селезінка, ураження шкіри, серця, нирок і мозку. Як називається цей випадок множинної дії одного гена?',
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
    'Плейотропія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарність',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 92
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Біохіміки встановили, що гемоглобін дорослої людини містить 2 - α і 2 – β поліпептидні ланцюги. Гени, що кодують ці ланцюги розміщені в різних парах гомологічних хромосом. Яка форма взаємодії між генами відбувається?',
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
    'Комплементарність',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Наддомінування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повне домінування',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 93
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини цистинурія проявляється наявністю цистинових камінців у нирках (гомозиготи) або підвищеним рівнем цистину в сечі (гетерозиготи). Захворювання цистинурією є моногенним. Яким є тип взаємодії генів цистинурії і нормального вмісту цистину в сечі?',
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
    'Неповне домінування',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарність',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повне домінування',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 94
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В Х-хромосомі людини локалізований домінантний ген, який бере участь у згортанні крові. Таку ж роль виконує і аутосомно-домінантний ген. Відсутність кожного з цих генів призводить до порушення згортання крові. Назвіть форму взаємодії між цими генами:',
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
    'Комплементарність',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епістаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плейотропія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 95
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвороба Хартнепа зумовлена точковою мутацією лише одного гена, наслідком чого є порушення всмоктування амінокислоти триптофану в кишечнику та реабсорбції її в ниркових канальцях. Це призводить до одночасних розладів у травній і сечовидільній системах. Яке генетичне явище спостерігається в цьому випадку?',
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
    'Плейотропія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кодомінування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементарна взаємодія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне домінування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 96
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При яких групах крові батьків за системою резус -фактор можлива резусконфліктна ситуація під час вагітності?',
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
    'Жінка Rh–, чоловік Rh+ (гомозигота)',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жінка Rh+, чоловік Rh+ (гомозигота)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жінка Rh+, чоловік Rh+ (гетерозигота)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жінка Rh–, чоловік Rh–',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жінка Rh+(гетерозигота), чоловік Rh+ (гомозигота)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 97
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка з I (0) Rh- групою крові вийшла заміж за чоловіка з IV (AB) Rh+ групою крові. Який варіант групи крові і резус-фактора можна очікувати у дітей?',
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
    'III (B) Rh+',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'I (0) Rh',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IV (AB) Rh+',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IV (AB) Rh',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'I (0) Rh+',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 98
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час хірургічної операції виникла необхідність масивного переливання крові. Група крові потерпілого - III (В) Rh (+). Якого донора треба вибрати?',
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
    'III (В) Rh (+)',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'II (А) Rh (+)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IV (АВ) Rh (-)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'III (В) Rh (-)',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І (0) Rh (-)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 99
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У гетерозиготних батьків з ІІ(А) і ІІІ(В) групами крові за системою АВ0 народилась дитина. Яка ймовірність наявності у неї І (0) групи крові?',
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
    '25%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '100%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 100
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хлопчика І група крові, а в його сестри ІV. Які групи крові у батьків цих дітей?',
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
    'ІІ (ІА І 0 ) і ІІІ (ІВ І 0 ) групи',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ІІ (ІА І А ) і ІІІ (ІВ І 0 ) групи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ІІІ (ІВ І 0 ) і IV (ІА І В ) групи',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І (І0 І 0 ) і IV (ІА І В ) групи',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І (І0 І 0 ) і ІІІ (ІВ І 0 ) групи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 101
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини успадкування груп крові при явищі «Бомбейського феномену» проявляється за принципом рецесивного епістазу. Який генотип має людина з І групою крові:',
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
    'І А І В ss',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І А І 0Ss',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І В І ВSS',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І А І А SS',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І В І 0Ss',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 102
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До жіночої консультації звернулося п’ять подружніх пар. Вони хочуть знати, чи є загроза розвитку гемолітичної хвороби в їхніх дітей. В якому випадку ризик виникнення резус-конфлікту є найвищим?',
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
    'dd (друга вагітність); > DD',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Dd (третя вагітність); > DD',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Dd (друга вагітність); > Dd',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'dd (третя вагітність); > dd',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'DD (перша вагітність); > Dd',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 103
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У випадку, коли один з батьків має групу крові 0, а інший АВ, дитина може мати групу крові:',
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
    'А, В',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0, АВ',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АВ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0, АВ, А, В',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0, А, В',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 104
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки з резус-негативною кров’ю А (II) групи народилася дитина з АВ (IV) групою, у якої діагностували гемолітичну хворобу внаслідок резусконфлікту. Яка група крові можлива у батька дитини?',
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
    'III (В), резус-позитивна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'II (А), резус-позитивна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'III (В), резус-негативна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IV (АВ), резус-негативна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'І (0), резус-позитивна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 105
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У крові жінки з негативним резусом під час вагітності виявлено специфічні білки, здатні зруйнувати резус-позитивні еритроцити плода. Як називається цей захисний компонент організму матері?',
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
    'Антитіло',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гормон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сироватка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антиген',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 106
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пробанда спостерігається зрощення пальців на ногах. У трьох його синів також зрощення пальців, а у двох дочок пальці нормальні. У сестер пробанда пальці нормальні. У брата і батька також зрощення пальців. Як називають таку спадкову ознаку ?',
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
    'Голандрична',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Х-зчеплена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 107
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого шкіра чутлива до сонячного світла. Назвіть це спадкове захворювання, зумовлене дефектами ферментів системи репарації ДНК:',
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
    'Пігментна ксеродермія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітиліго',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порфірія',
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
    'Хвороба Леша-Ніхана',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 108
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Кросинговер – це обмін ділянками гомологічних хромосом у процесі клітинного поділу, переважно в профазі першого мейотичного поділу, іноді в мітозі. Від чого залежить частота кросинговеру?',
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
    'Від відстані між генами',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від зовнішніх факторів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від кількості хромосом',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від типу хромосоми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від довжини хромосоми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 109
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Надмірна волосатість вушних раковин (гіпертрихоз) визначається геном, локалізованим у Y-хромосомі. Цю ознаку має батько. Імовірність народження хлопчика з такою аномалією дорівнює:',
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
    '100%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '35%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 110
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хлопчик хворів на гемофілію, дальтонізм і повну відсутність зубів. Банкір признав його онуком на підставі запевнень сімейного лікаря, що це рідкісне сполучення трьох спадкових хвороб було і у померлого сина банкіра. Чи згодні ви з думкою лікаря?',
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
    'Ні, батько не міг передати сину Х-хромосому, в якій розміщені гени цих хвороб',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Так, хвороби батьків можуть проявлятися у дітей',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплене успадкування',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Батько передав сину гени цих хвороб',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жодна відповідь не вірна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 111
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Які з представлених хвороб є наслідком мутації гена, що локалізується в статевій хромосомі?',
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
    'Гемофілія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Таласемія',
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
    'Синдром Клайнфельтера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 112
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дуже великі зуби - ознака зчеплена з Y-хромосомою. У матері зуби нормальної величини, а у її сина – дуже великі. Ймовірність наявності дуже великих зубів у батька складає:',
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
    '100%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '12,5%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 113
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженого хлопчика суха шкіра, що вкрита товстим шаром рогових лусочок (іхтіоз) і нагадує шкіру рептилій. Після дослідження родоводу виявлено, що ця ознака проявляється в усіх поколіннях лише у чоловіків. Яка з наведених біологічних закономірностей проявляється в даному випадку?',
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
    'Явище успадкування, зчепленого зі статтю',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закон незалежного успадкування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закон одноманітності гібридів І покоління',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Закон розщеплення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Явище зчепленого успадкування генів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 114
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико-генетичну консультацію звернулось подружжя з питанням про ймовірність народження у них дітей хворих на гемофілію. Подружжя здорове, але батько дружини хворий на гемофілію. На гемофілію можуть захворіти:',
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
    'Половина синів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сини і дочки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки дочки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Половина дочок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Всі діти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 115
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При диспансерному обстеженні хлопчику 7-ми років встановлено діагноз - синдром Леша-Найхана (хворіють тільки хлопчики). Батьки здорові, але у дідуся за материнською лінією таке ж захворювання. Який тип успадкування захворювання?',
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
    'Рецесивний, зчеплений із статтю',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений із статтю',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-рецесивний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-домінантний',
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
  -- Питання 116
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка і його сина інтенсивно росте волосся по краю вушних раковин. Це явище спостерігалося також у батька і дідуся за батьковою лінією. Який тип успадкування зумовлює це?',
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
    'Зчеплений з У-хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  -- Питання 117
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'C.Аутосомно-рецесивний',
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
    'Рецесивний, зчеплений з Х-хромосомою',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений з Х-хромосомою',
    false,
    1,
    NOW(),
    NOW()
  );
  -- Питання 118
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулася жінка з приводу оцінки ризику захворювання гемофілією у її дітей. Її чоловік страждає гемофілією. Під час збору анамнезу виявилося, що у сім’ї жінки не було випадків гемофілії. Вкажіть ризик народження хворої дитини:',
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
    'відсутній',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '35%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 119
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Схильність до цукрового діабету обумовлює аутосомний рецесивний ген. Цей ген проявляється лише у 30% гомозиготних особин. Цей частковий прояв ознаки є прикладом слідуючої властивості гена:',
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
    'Пенетрантність',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантність',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Експресивність',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дискретність',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивність',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 120
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини один і той же генотип може спричинити розвиток захворювання з різними ступенями прояву фенотипів. Ступінь прояву ознаки при реалізації генотипу у різних умовах середовища – це:',
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
    'Експресивність',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пенетрантність',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спадковість',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 121
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Одна з форм рахіту успадковується за домінантним типом. Хворіють і чоловіки і жінки. Це захворювання є наслідком мутації:',
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
    'Генної',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геномної',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомної',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоідії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплоідії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 122
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Альбінізм спостерігається у всіх класів хребетних тварин. Ця спадкова патологія зустрічається також у людини і обумовлена геном, який має аутосомно рецесивне успадкування. Проявом якого закону є наявність альбінізму в людини та в представників класів хребетних тварин:',
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
    'Гомологічних рядів спадкової мінливості Вавілова',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біогенетичного Геккеля-Мюллера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Одноманітності гібридів 1 покоління Менделя',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Незалежного успадкування ознак Менделя',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчепленого успадкування Моргана',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 123
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У районах Південної Африки у людей розповсюджена серпоподібноклітинна анемія, при якій еритроцити мають форму серпа внаслідок заміни в молекулі гемоглобіну амінокислоти глутаміну на валін. Чим викликана ця хвороба?',
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
    'Генною мутацією',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушенням механізмів реалізації генетичної інформації',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кросинговером',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геномними мутаціями',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансдукцією',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 124
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків народився син з фенілкетонурією, але завдяки спеціальній дієті розвивався нормально. З якою формою мінливості пов’язане його одужання?',
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
    'Модифікаційна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
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
    'Генотипова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Співвідносна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 125
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулися батьки хворої дівчинки 5 років. Після дослідження каріотипу виявили 46 хромосом. Одна з хромосом 15-ї пари була довша від звичайної, тому що до неї приєдналася хромосома з 21-ї пари. Який вид мутації має місце в цієї дівчинки?',
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
    'Транслокація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестача',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 126
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка під час вагітності хворіла на вірусну краснуху. Дитина у неї народилась з вадами розвитку – незрощення губи і піднебіння. Генотип у дитини нормальний. Ці аномалії розвитку є проявом:',
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
    'Модифікаційної мінливості',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоїдії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативної мінливості',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомної мутації',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплодії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 127
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При цитогенетичному дослідженні в клітинах абортованого ембріону виявлено 44 хромосоми, відсутність обох хромосом третьої пари. Яка мутація відбулась?',
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
    'Нулесомія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна аберація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генна (точкова)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полісомія',
    false,
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
  -- Питання 128
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок дії випромінювання на послідовність нуклеотидів ДНК втрачені 2 нуклеотиди. Яка з перелічених видів мутацій відбулася в ланцюзі ДНК:',
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
    'Делеція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 129
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини з серпоподібноклітинною анемією біохімічний аналіз показав, що у хімічному складі білка гемоглобіну відбулася заміна глутамінової кислоти на валін. Визначте вид мутації:',
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
    'Генна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геномна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплоідія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 130
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У молодого подружжя народилася дитина з енцефалопатією. Лікар встановив, що хвороба пов’язана з порушенням мітохондріальної ДНК. Як успадковуються мітохондріальні патології?',
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
    'Від матері всіма дітьми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від матері тільки синами',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від батька тільки дочками',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від батька тільки синами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Від обох батьків усіма дітьми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 131
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В ділянці хромосоми гени розташовані в такій послідовності: ABCDEFG. В результаті дії радіоактивного випромінювання відбулася перебудова, після чого ділянка хромосоми має наступний вигляд: ABDEFG. Яка мутація відбулася?',
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
    'Делеція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсерція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 132
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У соматичних клітинах абортивного плода людини виявлено делецію короткого плеча 5-ї хромосоми. Вкажіть число аутосом у каріотипі цього організму:',
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
    '46',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '48',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '44',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 133
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У мешканців Закарпаття внаслідок дефіциту йоду в харчових продуктах часто зустрічається ендемічний зоб. Який вид мінливості спричиняє таке захворювання?',
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
    'Модифікаційна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутаційна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онтогенетична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Співвідносна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 134
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок впливу γ-випромінювання ділянка ланцюга ДНК повернулася на 180 градусів. Яка з перелічених видів мутацій відбулася в ланцюзі ДНК?',
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
    'Інверсія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 135
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фактори середовища можуть зумовити зміни фенотипу, які копіюють ознаки, властиві іншому генотипу. Такі зміни проявляються з високою частотою на певних (критичних) стадіях онтогенезу і не успадковуються. Яку назву мають такі зміни?',
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
    'Фенокопії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Модифікації',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тривалі модифікації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генокопії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутації',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 136
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У молодого подружжя народилася дитина з різними кольорами правого і лівого очей. Як називається ця форма мінливості?',
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
    'Соматична мутація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна аберація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетероплоїдія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Модифікаційна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 137
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Отосклероз (патологічна ознака, що проявляється втратою слуху) визначається аутосомно-домінантним геном. Пенетрантність гену 50 %. Яка ймовірність народження хворих дітей у здорових гетерозиготних носіїв цього гену?',
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
    '37,5%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
    '50%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 138
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вживання тетрациклінів в першій половині вагітності призводить до виникнення аномалій органів і систем плода, в тому числі до гіпоплазії зубів, зміни їх кольору. До якого виду мінливості належить захворювання дитини?',
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
    'Модифікаційна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутаційна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спадкова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рекомбінантна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 139
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження каріотипу дівчинки виявлено вкорочення плеча 20-ої хромосоми. Як називається ця мутації?',
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
    'Делеція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 140
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини один і той самий генотип може спричинити розвиток ознаки з різними ступенями прояву і залежить від взаємодії даного гена з іншими та від впливу зовнішніх умов. Як називається ступінь фенотипового прояву ознаки, що контролюється певним геном?',
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
    'Експресивність',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спадковість',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пенетрантність',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 141
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після обробки колхіцином у метафазній пластинці людини визначено на сорок шість хромосом більше норми. Зазначена мутація належить до:',
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
    'Поліплоїдія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплоїдія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Політенія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 142
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після впливу мутагена у метафазній пластинці людини визначено на три хромсоми менше за норму. Зазначена мутація належить до:',
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
    'Анеуплоїдія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоїдія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Політенія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
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
  -- Питання 143
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У клітині відбулася мутація першого екзону структурного гена. В ньому зменшилась кількість пар нуклеотидів - замість 290 пар стало 250. Визначте тип мутації:',
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
    'Делеція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нонсенс-мутація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 144
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час цитогенетичного обстеження пацієнта з порушеною репродуктивною функцією виявлено в деяких клітинах нормальний каріотип 46ХУ, але у більшості клітин каріотип синдрому Клайнфельтера - 47 ХХУ. Яку назву носить таке порушення?',
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
    'Мозаїцизм',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гетерогенність',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транспозиція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 145
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Причиною захворювання на пелагру може бути переважне харчування кукурудзою та зниження у раціоні продуктів тваринного походження. Відсутність у раціоні якої амінокислоти призводить до даної патології?',
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
    'Триптофан',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізолейцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілаланін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метіонін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 146
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На заняттях з молекулярної біології йде розгляд мутацій, які призводять до утворення аномального гемоглобіну. Яка заміна амінокислот відбувається при утворенні S-гемоглобіну, що спричиняє виникнення серпоподібноклітинної анемії?',
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
    'Глутамінова кислота замінюється валіном',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Треонін замінюється лізином',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лізин замінюється глутаміном',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістидін замінюється аргініном',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гліцин замінюється аспарагіном',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 147
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відбулась мутація структурного гену. В ньому змінилась кількість нуклеотидів: замість 90 пар основ стало 180. Ця мутація:',
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
    'Дуплікація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансверсія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 148
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відомо, що ген, відповідальний за розвиток груп крові з системи MN, має два аллельних стани. Якщо ген М вважати вихідним, то поява аллельного йому гена N відбулася внаслідок:',
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
    'Мутації',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінації генів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Репарації ДНК',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікації ДНК',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кросинговеру',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 149
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Що може бути наслідком пошкодження генетичного апарату статевих клітин?',
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
    'Спадкові хвороби',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Злоякісні пухлини',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутоімунні процеси',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Старіння',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування апоптозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 150
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При огляді у 10-річної дитини встановлено маленький зріст, непропорційний розвиток тіла, недостатній розумовий розвиток. Дефіцит якого гормону викликав такі зміни?',
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
    'Тироксину',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тиреокальцитонину',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паратгормону',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адренокортикотропного гормону',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Окситоцину',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 151
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків, спадковість яких не обтяжена, народилась дитина з чисельними вадами розвитку. Цитогенетичний аналіз виявив в соматичних клітинах трисомію по 13-й хромосомі (синдром Патау). З яким явищем пов’язане народження такої дитини?',
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
    'Порушенням гаметогенезу в гаметах одного з батьків',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматичною мутацією в одного з батьків',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивною мутацією',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантною мутацією',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомною мутацією',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 152
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Двомісячній дитині встановлено діагноз : синдром “ котячого крику ”. Причиною цієї хвороби є делеція короткого плеча 5-ї автосоми. Яку загальну кількість хромосом виявлено у дитини ?',
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
    '46',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '44',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '43',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 153
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько були фенотипово здоровими і гетерозиготними за генотипом. У них народилася хвора дитина в сечі і крові якої знайдена фенілпіровиноградна кислота. З приводу цього і був встановлений попередній діагноз – фенілкетонурія. Вкажіть тип успадкування цієі хвороби:',
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
    'Аутосомно-рецесивний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Х-хромосомою рецесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-домінантний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з У-хромосомою',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Х-хромосомою домінантний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 154
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після аналізу родоводу, лікар-генетик встановив: ознака проявляється у кожному поколінні, жінки та чоловіки спадкують ознаку однаково часто, батьки в однаковій мірі передають ознаки своїм дітям. Визначте, який тип успадкування має досліджувана ознака?',
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
    'Аутосомно- домінантний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно- рецесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полігенний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Х-зчеплений рецесивний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У- зчеплений',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 155
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Надмірна волосатість вушних раковин (гіпертрихоз) визначається геном, локалізованим у Y-хромосомі. Цю ознаку має батько. Імовірність народження хлопчика з такою аномалією буде:',
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
    '100%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '35%',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 156
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико-генетичну консультацію звернулось подружжя з питанням про ймовірність народження у них дітей хворих на гемофілію. Подружжя здорове, але батько дружини хворий на гемофілію. На гемофілію можуть захворіти:',
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
    'Половина синів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сини і дочки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки дочки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Половина дочок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Всі діти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 157
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У генетично здорових батьків народилася дитина хвора на фенілкетонурію (аутосомно-рецесивне спадкове захворювання). Які генотипи батьків?',
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
    'Аа х Аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х АА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х Аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 158
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія успадковується як аутосомна рецесивна ознака. У родині, де обидвоє батьків здорові, народилася дитина хвора на фенілкетонурію. Які генотипи батьків?',
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
    'Аа х Аа',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х АА',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АА х Аа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аа х аа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'аа х аа',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 159
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У подружжя народився син, хворий на гемофілію. Батьки здорові, а дідусь за материнською лінією також хворий на гемофілію. Визначте тип успадкування ознаки.',
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
    'Рецесивний, зчеплений зі статтю',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-ресесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений зі статтю',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповне домінування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-домінантний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 160
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулася жінка з приводу оцінки ризику захворювання гемофілією у її дітей. Її чоловік страждає гемофілією. Під час збору анамнезу виявилося, що у сім’ї жінки не було випадків гемофілії. Вкажіть ризик народження хворої дитини:',
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
    'відсутній',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
  -- Питання 161
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пробанда спостерігається зрощення пальців на ногах. У трьох його синів також зрощення пальців, а у двох дочок пальці нормальні. У сестер пробанда пальці нормальні. У брата і батька також зрощення пальців. Як називають таку спадкову ознаку ?',
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
    'Голандрична',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Х-зчеплена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 162
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При аналізі родоводу пробанда виявлено, що ознака проявляється з однаковою частотою у представників обох статей і хворі наявні у всіх поколіннях (по вертикалі), а по горизонталі - у сибсів (братів і сестер пробанда) з відносно великих родин. Який тип успадкування досліджуваної ознаки?',
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
    'Автосомно-домінантний',
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
    'Зчеплений з Х-хромосомою, домінантний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Х-хромосомою, рецесивний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з У-хромосомою',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 163
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія – це захворювання, яке зумовлене рецесивним геном, що локалізується в аутосомі. Батьки є гетерозиготами за цим геном. Вони вже мають двох хворих синів і одну здорову доньку. Яка імовірність, що четверта дитина, яку вони очікують, народиться теж хворою?',
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
    '25%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
  -- Питання 164
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У батьків, хворих на гемоглобінопатію (аутосомно-домінантний тип успадкування), народилася здорова дівчинка. Які генотипи батьків?',
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
    'Обоє гетерозиготні за геном гемоглобінопатії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мати гетерозиготна за геном гемоглобінопатії, у батька цей ген відсутній',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обоє гомозиготні за геном гемоглобінопатії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Батько гетерозиготний за геном гемоглобінопатії, у матері цей ген відсутній',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У обох батьків ген гемоглобінопатії відсутній',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 165
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Батьки - глухонімі, але глухота у дружини залежить від аутосомнорецесивного гена, а у чоловіка виникла внаслідок тривалого прийому антибіотиків у дитинстві. Яка ймовірність народження глухої дитини в родині, якщо батько гомозиготний за алелем нормального слуху?',
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
    '0%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '10%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
  -- Питання 166
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка і його сина інтенсивно росте волосся по краю вушних раковин. Це явище спостерігалося також у батька і дідуся за батьковою лінією. Який тип успадкування зумовлює це?',
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
    'Зчеплений з У-хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  -- Питання 167
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'C.Аутосомно-рецесивний',
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
    'Рецесивний, зчеплений з Х-хромосомою',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений з Х-хромосомою',
    false,
    1,
    NOW(),
    NOW()
  );
  -- Питання 168
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчина 16-ти років звернулася до стоматолога з приводу темної емалі зубів. При вивченні родоводу встановлено, що вказана патологія передається від батька всім дівчаткам, а від матері - 50% хлопчиків. Для якого типу успадкування характерні ці особливості?',
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
    'Домінантний, зчеплений з Х- хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивний, зчеплений з Х- хромосомою',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивний, зчеплений з Y- хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-домінантний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-рецесивний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 169
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При диспансерному обстеженні хлопчику 7-ми років встановлено діагноз - синдром Леша-Найхана (хворіють тільки хлопчики). Батьки здорові, але у дідуся за материнською лінією таке ж захворювання. Який тип успадкування захворювання?',
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
    'Рецесивний, зчеплений із статтю',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений із статтю',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-рецесивний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автосомно-домінантний',
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
  -- Питання 170
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка, його сина та дочки відсутні малі корінні зуби. Така аномалія спостерігалася також у дідуся по батьківській лінії. Який найбільш імовірний тип успадкування цієї аномалії?',
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
    'Аутосомно-домінантний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-рецесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений з Х-хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Y-хромосомою',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивний, зчеплений з Х-хромосомою',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 171
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Яка ймовірність народження хворої дитини у фенотипово здорових батьків, якщо мати є гетерозиготною носійкою гена хвороби при Хзчепленому рецесивному типі успадкування захворювання?',
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
    'Половина хлопчиків',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Половина хлопчиків, половина дівчаток',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі діти будуть хворі',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі діти будуть здорові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Усі хлопчики будуть хворі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 172
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У п’ятирічної дитини діагностовано міопатію Дюшена. Батьки здорові. Дядько дитини і син тітки за материнською лінією також хворі на міопатію. Визначте тип успадкування захворювання.',
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
    'Рецесивний, зчеплений з Х - хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно – домінантний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивний, зчеплений з Y – хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно – рецесивний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантний, зчеплений з Х – хромосомою.',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 173
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні дівчини 18 років знайдені ознаки: недорозвинення яєчників, широкі плечі, вузький таз, вкорочення нижніх кінцівок, «шия сфінкса», розумовий розвиток не порушено. Встановлено діагноз – синдром Шерешевского-Тернера. Які порушення хромосом у хворої?',
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
    'Моносомія Х',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія Х',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нульосомія Х',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 174
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок порушення розходження хромосом при мейозі утворилися: яйцеклітина тільки з 22 аутосомами і полярне тільце з 24 хромосомами. Який синдром можливий у дитини при заплідненні такої яйцеклітини нормальним сперматозооном (22+Х)?',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія Х',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 175
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У букальних мазках епітелію жінки виявлено в ядрі клітини 2 тільця Барра. Це характерно для синдрому:',
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
    'Трисомія статевих хромосом',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія 21-ї хромосоми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія 13-ї хромосоми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія по У-хромосомі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомія статевих хромосом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 176
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У більшості клітин епітелію слизової оболонки щоки чоловіка виявлено глибку статевого Х-хроматину. Це характерно для синдрому:',
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
    'Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шерешевського -Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипло-Х',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипло-У',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 177
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пологовому будинку народилась дитина з численними порушеннями, як зовнішніх так і внутрішніх органів – серця, нирок, травної системи. Був встановлений попередній діагноз – синдром Дауна. Яким методом можливо підтвердити цей діагноз?',
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
    'Цитогенетичним',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистчним',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковим',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічним',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічним',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 178
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернувся юнак з приводу відхилень у фізичному і статевому розвитку. При мікроскопії клітин слизової оболонки рота виявлене одне тільце Барра. Вкажіть найбільш вірогідний каріотип юнака:',
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
    '47, ХХУ',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45, Х0',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 21+',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 18+',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХУУ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 179
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні букального епітелію чоловіка з євнухоподібними ознаками у багатьох клітинах був виявлений статевий Х-хроматин. Для якої хромосомної хвороби це характерно?',
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
    'Синдром Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синром Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за Х-хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Марфана',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 180
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженого хлопчика спостерігається деформація мозкового та лицьового черепа, мікрофтальмія, деформація вушної раковини, вовча паща, та ін. Каріотип дитини виявився 47,ХУ,13+. Про яку хворобу йде мова:',
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
    'Синдром Патау',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Теренера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 181
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико-генетичному центрі проведено каріотипування дитини з такими ознаками: вкорочення кінцівок, маленький череп, аномалії будови обличчя, вузькі очні щілини, епікант, розумова відсталість, порушення будови внутрішніх органів. Вкажіть найбільш вірогідний каріотип:',
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
    '47, 21+',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 13+',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 18+',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХХУ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХХХ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 182
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До гінеколога звернулася 28-річна жінка з приводу безпліддя. Під час обстеження виявлено: недорозвинені яєчники та матка, нерегулярний менструальний цикл. При дослідженні статевого хроматину в більшості соматичних клітин знайдені 2 тільця Барра. Яка хромосомна хвороба найбільш вірогідна в цієї жінки?',
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
    'Трисомія Х',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шрешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 183
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дівчини виявлена диспропорція тіла, крилоподібні складки шкіри на шиї. При цитогенетичному дослідженні у ядрах лейкоцитів не виявлені «барабанні палички», а у ядрах букального епітелію відсутні тільця Барра. Попередній діагноз буде:',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 184
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернувся чоловік з приводу безпліддя. В ядрах більшості клітин епітелію слизової оболонки щоки було виявлено одне тільце Барра. Причиною такого стану може бути:',
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
    'Синдром Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського -Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипло-Х',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипло-У',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 185
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження клітин букального епітелію слизової оболонки щоки у пацієнта чоловічої статі виявлені 2 тільця Барра. Можливий діагноз:',
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
    'Синдром Кляйнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "супержінки"',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "суперчоловіка"',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 186
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернулася хвора дівчина з попереднім діагнозом “синдром Шерешевського-Тернера”. Яким генетичним методом можна уточнити діагноз?',
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
    'Цитогенетичний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гібридологічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 187
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулися батьки хворої дівчинки 5 років. Після дослідження каріотипу виявили 46 хромосом. Одна з хромосом 15-ї пари була довша від звичайної, тому що до неї приєдналася хромосома з 21-ї пари. Який вид мутації має місце в цієї дівчинки?',
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
    'Транслокація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестача',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 188
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При дослідженні каріотипу у паціента були виявлені два типи клітин в рівних частинах з хромосомними наборами 46XY та 47XХY. Який діагноз поставить лікар?',
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
    'Синдром Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомія-Х',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нормальний каріотип',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 189
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В родині зростає дочка 14 років у якої спостерігаються деякі відхилення від норми: зріст її нижче, ніж у однолітків, відсутні ознаки статевого дозрівання, шия дуже коротка, плечі широкі. Інтелект в нормі. Яке захворювання можна припустити?',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 190
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При медичному огляді у військкоматі був виявлений хлопчик 15 років, високого зросту, з євнухоподібними пропорціями тіла, гінекомастією, волосся на лобку росте за жіночим типом. Відмічається відкладання жиру на стегнах, відсутність росту волосся на обличчі, високий голос, коефіцієнт інтелекту – знижений. Виберіть каріотип, що відповідає даному захворюванню.',
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
    '47, ХХУ',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45, ХО',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '46, ХХ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '46, ХУ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХХХ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 191
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини зі спадково обумовленими вадами зразу ж після народження спостерігався характерний синдром, який називають «крик кішки». При цьому у ранньому дитинстві малюки мають «нявкаючий» тембр голосу. Під час дослідження каріотипу цієї дитини було виявлено:',
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
    'Делецію короткого плеча 5-ї хромосоми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Додаткову 21-у хромосому',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Додаткову Х-хромосому',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестачу Х-хромосоми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Додаткову Y-хромосому',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 192
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулась жінка. При огляді у неї виявилися такі симптоми: крилоподібні шийні складки (шия „сфінкса”); широка грудна клітка, слабко розвинені молочні залози. Під час дослідження клітин букального епітелію в ядрах не було виявлено жодної грудочки Ххроматину. Це вказує що у пацієнтки:',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 193
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернувся юнак з попереднім діагнозом “синдром Клайнфельтера”. Яким генетичним методом можна уточнити діагноз?',
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
    'Цитогенетичним',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічним',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічним',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковим',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичним',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 194
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки при обстеженні клітин слизової оболонки щоки не знайдено статевий хроматин. Яке з наведених захворювань можна припустити?',
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
    'Хвороба Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія Х',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Дауна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Леша-Найяна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Коновалова-Вільсона',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 195
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'За допомогою методу каріотипування у новонародженої дитини з множинними дефектами черепа, кінцівок і внутрішніх органів виявлено три хромосоми 13-ї пари. Було встановлено діагноз:',
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
    'Синдром Патау',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едварда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 196
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні 7-річної дитини виявлено наступні ознаки: низький зріст, широке округле лице, близько розміщені очі із вузькими очними щілинами, напіввідкритий рот. Діагностовано також вада серця. Ці клінічні ознаки найбільш характерні для хвороби Дауна. Вкажіть причину даної патології.',
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
    'Трисомія 21-ої хромосоми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія 13-ої хромосоми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за Х хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Часткова моносомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нерозходження статевих хромосом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 197
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Каріотип чоловіка 47 хромосом, в ядрі соматичної клітини виявлене тільце Барра. Спостерігається ендокринна недостатність: недорозвиток сім’яників, відсутність сперматогенезу. Про яке захворювання свідчить даний фенотип?',
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
    'Синдром Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 198
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відомі трисомна, транслокаційна та мозаїчна форми синдрому Дауна. За допомогою якого методу генетики людини можна диференціювати названі форми синдрому Дауна?',
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
    'Цитогенетичного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюкового',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічного',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічного',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичного',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 199
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько здорові. Методом амніоцентезу визначено каріотип плода: 45 ХО. Діагноз:',
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
    'Синдром Шершевського-Тернера',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром котячого крику',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "супержінка"',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 200
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько здорові. Методом амніоцентезу визначено каріотип плода: 47, XX + 21. Діагноз:',
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
    'Синдром Дауна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром котячого крику',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "супержінка"',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 201
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак був обстежений у медико-генетичній консультації. Виявлений каріотип 47 ХУУ. Вкажіть найбільш ймовірний діагноз.',
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
    'Синдром «суперчоловік»',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Кляйнфельтера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 202
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків, спадковість яких не обтяжена, народилась дитина з чисельними вадами розвитку. Цитогенетичний аналіз виявив в соматичних клітинах трисомію за 13-ю хромосомою (синдром Патау). З яким явищем пов’язане народження такої дитини?',
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
    'Порушенням гаметогенезу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматичною мутацією',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рецесивною мутацією',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантною мутацією',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомною мутацією',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 203
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернулася жінка 25 років зі скаргами на дисменорею та безпліддя. При обстеженні виявлено: зріст жінки 145 см, недорозвинені вторинні статеві ознаки, на шиї крилоподібні складки. При цитологічному дослідженні в соматичних клітинах не виявлено тілець Барра. Який діагноз виставив лікар?',
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
    'Синдром Шершевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Морріса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром моносомії Х',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром трисомії Х',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 204
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків, спадковість яких не обтяжена, народилася дитина з множинними вадами розвитку. Цитогенетичний аналіз виявив у соматичних клітинах дитини трисомію за 18-ю хромосомою (синдром Едвардса). З яким явищем пов’язане народження такої дитини?',
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
    'Нерозходженням пари хромосом під час гаметогенезу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Соматичною мутацією у ембріона',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Впливом тератогенних факторів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Домінантною мутацією',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомною мутацією - дуплікацією',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 205
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженої дитини виявлено наступну патологію: аномалія розвитку нижньої щелепи та гортані, що супроводжується характерними змінами голосу, а також мікроцефалія, вада серця, чотирьохпалість. Найбільш йморівною причиною таких аномалій є делеція:',
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
    'Короткого плеча 5-ої хромосоми',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Короткого плеча 7-ої хромосоми',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Короткого плеча 9-ої хромосоми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Короткого плеча 11-ої хромосоми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '21-ої хромосоми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 206
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Визначення Х-хроматину в соматичних клітинах використовується для експрес-діагностики спадкових захворювань, пов’язаних зі зміною кількості статевих хромосом. Який каріотип чоловіка, переважна більшість клітин якого містять одну грудочку Х-хроматину:',
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
    '47, ХХУ',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45, Х0',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '46, ХУ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '48, ХХХУ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '49, ХХХХУ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 207
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 30-ти років народила хлопчика з розщепленням верхньої губи і піднебіння («заяча губа», «вовча паща»). При додатковому обстеженні виявлені значні порушення нервової, серцево-судинної систем та зору. При дослідженні каріотипу діагностована трисомія за 13-ю хромосомою. Який синдром наявний у хлопчика?',
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
    'Патау',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шерешевського-Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дауна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клайнфельтера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 208
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулася жінка 30-ти років у якої в ядрах більшості клітин епітелію слизової оболонки щоки було виявлено по два тільця Барра. Який попередній діагноз можн а встановити?',
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
    'Трисомія за X-хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за 21-ю хромосомою',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за 13-ю хромосомою',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за 18-ю хромосомою',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомія за X-хромосомою',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 209
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні 2-х місячної дитини педіатр звернула увагу, що плач дитини нагадує котячий крик. Діагностовані мікроцефалія і вада серця. За допомогою цитогенетичного метода з’ясований каріотип дитини: 46, XX, 5р- . Дане захворювання є наслідком такого процесу:',
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
    'Делеція',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дуплікація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плейотропія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 210
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У фібробластах шкіри дитини із хворобою Дауна виявлено 47 хромосом. Визначте тип аномалії:',
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
    'Трисомія 21',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полісомія Y',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія Х',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 211
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулася жінка за рекомендацією гінеколога з приводу відхилень фізичного і статевого розвитку. В ході мікроскопії клітин слизової оболонки ротової порожнини не знайдено статевого хроматину. Який найбільш імовірний діагноз?',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Реклінгаузена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія за Х-хромосомою',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 212
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки під час мейозу відбулося порушення розходження аутосом. Утворилася яйцеклітина з зайвою 18-ю хромосомою. Яйцеклітина запліднюється нормальним сперматозооном. У майбутньої дитини буде синдром:',
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
    'Едвардса',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клайнфельтера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шерешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дауна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 213
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лейкоцитах хворого хлопчика з каріотипом 46 ХУ виявлена вкорочена 21 хромосома. Така мутація призводить до виникнення:',
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
    'Хронічного білокрів’я',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдрому Шерешевського-Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороби Тея-Сакса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдрому «крик кішки»',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілкетонурії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 214
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико-генетичну консультацію за рекомендацією андролога звернувся чоловік 35-ти років з приводу відхилень фізичного і психічного розвитку. Об’єктивно встановлено: високий зріст, астенічна будова тіла, гінекомастія, розумова відсталість. При мікроскопії клітин слизової оболонки ротової порожнини знайдено в 30% статевий хроматин (одне тільце Барра). Який діагноз найімовірніший?',
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
    'Синдром Клайнфельтера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Ді Джорджі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Іценка-Кушинга',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Реклінгаузена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Дауна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 215
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У юнака, який має високий зріст (187 см), виявлено високе піднебіння, неправильний ріст великих зубів з дефектами зубної емалі. При дослідженні букального зішкрібка за допомогою люмінесцентної мікроскопії виявлені дві У-хромосоми. Дана аномалія є результатом:',
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
    'Трисомії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нулесомії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алоплоідії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автополіплоїдії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 216
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 19-річної дівчини клінічно виявлено наступну групу ознак: низький зріст, статевий інфантилізм, відставання у інтелектуальному та статевому розвитку, вада серця. Які найбільш імовірні причини даної патології?',
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
    'Моносомія за Х-хромосомою',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія по 13-й хромосомі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія по 18-й хромосомі',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія по 20-й хромосомі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Часткова моносомія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 217
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини діагностовано галактоземію – хворбу накопичення. Цю хворобу можливо діагностувати за допомогою слідуючого методу:',
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
    'Біохімічного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичного',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичного',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюкового',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 218
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При амавротичній ідіотії Тея-Сакса, яка успадковується аутосомнорецесивно, розвиваються незворотні важкі порушення центральної нервової системи, що приводять до смерті в ранньому дитячому віці. При цьому захворюванні спостерігається розлад обміну:',
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
    'Ліпідів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінокислот',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мінеральних речовин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нуклеїнових кислот',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 219
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Одна з форм рахіту успадковується за домінантним типом. Хворіють і чоловіки і жінки. Це захворювання є наслідком мутації:',
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
    'Генної',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геномної',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомної',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоідії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анеуплоідії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 220
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Людина з кариотипом 46,ХУ має жіночий фенотип з розвиненими зовнішніми вторинностатевими ознаками. За цією інформацією лікар встановив попередній діагноз:',
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
    'Синдром Морріса',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром суперчоловіка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Тернера-Шерешевського',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 221
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько були фенотипово здоровими і гетерозиготними за генотипом. У них народилася хвора дитина, в сечі і крові якої знайдена фенілпіровиноградна кислота. З приводу цього і був встановлений попередній діагноз – фенілкетонурія. Вкажіть тип успадкування цієі хвороби:',
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
    'Аутосомно-рецесивний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Х-хромосомою рецесивний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутосомно-домінантний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з У-хромосомою',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зчеплений з Х-хромосомою домінантний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 222
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Першим етапом діагностування хвороб, зумовлених порушенням обміну речовин, є скринінг-метод, після якого використовують більш точні методи дослідження ферментів, амінокислот. Яку назву має описаний метод:',
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
    'Біохімічний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імунологічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гібридизації соматичних клітин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 223
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У здорових батьків народився син з фенілкетонурією, але завдяки спеціальній дієті розвивався нормально. З якою формою мінливості пов’язане його одужання?',
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
    'Модифікаційна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативна',
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
    'Генотипова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Співвідноснa',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 224
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При деяких спадкових хворобах, які раніше вважались невиліковними, з розвитком медичної генетики виникла можливість одужання за допомогою замісної дієтотерапії. В даний час це найбільше стосується:',
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
    'Фенілкетонурії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анемії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Муковісцидозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистинурії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ахондроплазії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 225
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 12-ти років поступив у клініку з гемартрозом колінного суглоба, з раннього дитинства страждає кровоточивістю. Яка хвороба у хлопчика?',
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
    'Гемофілія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний васкуліт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемолітична анемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'B12 фолієво-дефіцитна анемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцитопенічна пурпура',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 226
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак 15-ти років скаржиться на загальну слабкість, запаморочення, швидку стомлюваність. При обстеженні виявлено еритроцити зміненої форми, кількість їх знижена. Попередній діагноз: серпоподібноклітинна анемія. Який тип мутації зумовлює розвиток цього патологічного стану?',
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
    'Точкова мутація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутація зсуву рамки зчитування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інверсія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хромосомна аберація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 227
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини з білявим волоссям, блідою шкірою відмічається збільшений тонус м’язів, судоми та розумова відсталість. В крові підвищений рівень фенілаланіну. Який з перелічених методів необхідно застосувати для встановлення діагнозу цієї ензимопатії?',
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
    'Біохімічний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичниий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Електрофізіологічний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 228
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженої дитини є такі симптоми: судоми, блювота, жовтяниця, специфічний запах сечі. Лікар-генетик висловив підозру про спадкову хворобу обміну речовин. Які методи дослідження необхідно використати для постановки точного діагнозу за відсутності ДНК-діагностики?',
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
    'Біохімічні',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковий',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 229
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В Україні проводять масовий скринінг новонароджених на фенілкетонурію. Який метод медичної генетики використовується в цьому разі?',
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
    'Генеалогічний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічний',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковий',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 230
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У трирічної дитини відсутня пігментація шкіри, волосся, райдужної оболонки ока, спостерігається підвищена чутливість до ультрафіолетового випромінювання. Встановлено діагноз: загальний альбінізм, що є наслідком відсутності ферменту тирозинази. Яка мутація є причиною цього захворювання?',
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
  -- Питання 231
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час цитогенетичного дослідження культури клітин людини виявлено клітини, які мають 44 хромосоми (відсутність обох хромосом третьої пари). Яка мутація відбулася?',
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
    'Хромосомна аберація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нулесомія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генна (точкова)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полісомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моносомі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 232
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Як називається хромосомна мутація, що полягає в перенесенні ділянки однієї хромосоми на іншу, не гомологічну їй хромосому?',
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
    'Дуплікація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансверзія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транспозиція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Делеція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транслокація',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 233
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У популяціях людини у деяких осіб впродовж життя спостерігається не дві, а три генерації зубів. Це прояв такого закону:',
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
    'Біогенетичний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Харді-Вайнберга',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ембріональної індукції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Незалежного успадкування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гомологічних рядів спадкової мінливості',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 234
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У представників однієї з людських популяцій тіло подовжене, широка варіабельність зросту, знижений об’єм м’язової маси, подовжені кінцівки, зменшена у розмірах і об’ємі грудна клітка, підвищене потовиділення, знижені показники основного обміну та синтезу жирів. До якого адаптивного типу людей відноситься дана популяція?',
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
    'Проміжний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тип зони помірного клімату',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тропічний',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Арктичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гірський',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 235
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з нормальним каріотипом виявлено аномалії пальців (арахнодактилію), скелета, серцево-судинної системи, порушення розвитку сполучної тканини, дефект кришталика ока. Який попередній діагноз можна встановити хворому?',
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
    'Синдром Марфана',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Дауна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського–Тернера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 236
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У новонародженої дитини вивих кришталика, довгі й тонкі кінцівки з дуже довгими і тонкими пальцями, аневризма аорти, виділення із сечею окремих амінокислот. Для якого захворювання характерні дані ознаки?',
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
    'Синдром Марфана',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпофосфатемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
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
    'Фруктозурія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 237
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Першим етапом діагностування хвороб, зумовлених порушенням обміну речовин, є скринінг-метод, після якого використовують більш точні методи дослідження ферментів, амінокислот. Яку назву має описаний метод:',
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
    'Біохімічний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імунологічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гібридизації соматичних клітин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 238
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернувся юнак з приводу відхилень у фізичному і статевому розвитку. При мікроскопії клітин слизової оболонки рота виявлене одне тільце Барра. Вкажіть найбільш вірогідний каріотип юнака:',
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
    '47, ХХУ',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '45, Х0',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 21+',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 18+',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХУУ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 239
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико - генетичному центрі проведено каріотипування дитини з такими ознаками: вкорочення кінцівок, маленький череп, аномалії будови обличчя, вузькі очні щілини, епікант, розумова відсталість, порушення будови внутрішніх органів. Вкажіть найбільш вірогідний каріотип:',
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
    '47, 21+',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 13+',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, 18+',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХХУ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '47, ХХХ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 240
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В медико-генетичну консультацію звернулось подружжя з питанням про ймовірність народження у них дітей хворих на гемофілію. Подружжя здорове, але батько дружини хворий на гемофілію. На гемофілію можуть захворіти:',
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
    'Половина синів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сини і дочки.',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки дочки.',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Половина дочок.',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Всі діти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 241
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До приймальної медико-генетичної консультації звернулась пацієнтка. При огляді виявились слідуючи симптоми: трапецевидна шийна складка (шия “сфінкса”); широка грудна клітка, широко розставлені, слабо розвинені соски молочних залоз. Який найбільш ймовірний діагноз пацієнтки?',
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
    'Синдром Шерешевського-Тернера',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Мориса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Клайнфельтера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром “крику кішки”',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 242
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько здорові. Методом амніоцентезу визначено каріотип плода: 45 ХО. Діагноз:',
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
    'Синдром Шершевського-Тернера',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром котячого крику',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "супержінка"',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 243
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати і батько здорові. Методом амніоцентезу визначено каріотип плода: 47, XX + 21. Діагноз:',
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
    'Синдром Дауна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром котячого крику',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром "супержінка"',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 244
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак був обстежений у медико-генетичній консультації. Виявлений каріотип 47 ХУУ. Вкажіть найбільш ймовірний діагноз.',
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
    'Синдром «суперчоловік»',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Патау',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Кляйнфельтера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Шерешевського-Тернера',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синдром Едвардса',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 245
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулася жінка з приводу оцінки ризику захворювання гемофілією у її дітей. Її чоловік страждає гемофілією. Під час збору анамнезу виявилося, що у сім’ї жінки не було випадків гемофілії. Вкажіть ризик народження хворої дитини:',
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
    'Відсутній',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '25%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
  -- Питання 246
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відомі трисомна, транслокаційна та мозаїчна форми синдрому Дауна. За допомогою якого методу генетики людини можна диференціювати названі форми синдрому Дауна?',
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
    'Цитогенетичного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюкового',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічного',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічного',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичного',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 247
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні юнака з розумовою відсталістю виявлено євнухоподібну будову тіла, недорозвиненість статевих органів. В клітинах порожнини рота - статевий хроматин. Який метод генетичного дослідження слід застосувати для уточнення діагнозу?',
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
    'Цитологічний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клініко-генеалогічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 248
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернулась мати 2-річної дитини з відставанням у фізичному і розумовому розвитку. Який метод дослідження дозволить виключити хромосомну патологію?',
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
    'Цитогенетичний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитологічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 249
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Фенілкетонурія - це захворювання, яке зумовлено рецесивним геном, що локалізується в аутосомі. Батьки є гетерозиготами за цим геном. Вони вже мають двох хворих синів і одну здорову доньку. Яка імовірність, що четверта дитина, яку вони очікують, народиться теж хворою?',
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
    '25%',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '0%',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '50%',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '75%',
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
  -- Питання 250
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря медико-генетичної консультації вперше звернулась вагітна жінка з приводу можливої спадкової патології у майбутньої дитини. Із застосування якого методу почнеться її обстеження?',
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
    'Генеалогічного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичного',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюкового',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріотипування',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічного',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 251
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Синдром Мора успадковується домінантно та супроводжується багаточисельними аномаліями розвитку скелета (брахідактилія), порушенням формування зубів, адонтією, гіподонтією та ін. Якими методами антропогенетики скористається лікар для диференціювання цієї патології від можливої генокопії та прогнозу можливої патології у нащадків',
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
    'Генеалогічний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитогенетичний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюків',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 252
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-генетика звернувся юнак 18-ти років астенічної тілобудови: вузькі плечі, широкий таз, високий зріст, нерясна рослинність на обличчі. Виражена розумова відсталість. Було встановлено попередній діагноз: синдром Клайнфельтера. Який метод медичної генетики дозволить підтвердити даний діагноз?',
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
    'Цитогенетичний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іенеалогічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Близнюковий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Популяційно-статистичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 253
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До медико-генетичної консультації звернулось подружжя з питанням про вірогідність народження у них дітей з X-зчепленою формою рахіту (домінантна ознака). Батько здоровий, мати гетерозиготна і страждає на це захворювання. На вітаміностійкий рахіт можуть захворіти:',
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
    'Половина дочок i синів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки дочки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тільки сини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Всі діти',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Всі діти будуть здорові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 254
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У медико-генетичну консультацію звернулася хвора дівчина з попереднім діагнозом “синдром Шерешевського-Тернера”. Яким генетичним методом можна уточнити діагноз?',
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
    'Визначення статевого хроматину',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генеалогічний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гібридологічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біохімічний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматогліфіки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 255
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При дослідженні амніотичної рідини, одержаної при амніоцентезі (прокол амніотичної оболонки), виявлені клітини, ядра яких містять статевий хроматин (тільце Барра). Про що з зазначеного це може свідчити?',
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
    'Розвиток плода жіночої статі',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвиток плода чоловічої статі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генетичні порушення в розвитку плода',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трисомія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліплоїдія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 256
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У популяції мешканців Одеської області домінантний ген праворукості зустрічається з частотою 0,8; рецесивний ген ліворукості – 0,2. Скільки відсотків гетерозигот у цій популяції?',
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
    '32 %',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '46 %',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '58 %',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '64 %',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '100 %',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 257
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для швидкої діагностики багатьох бактеріальних, вірусних, протозойних і грибкових захворювань, виявлення збудників хвороб у довкіллі, харчових продуктах і воді з успіхом використовується реакція, принцип якої полягає в багатократному копіюванні специфічної ділянки ДНК або окремого гена за допомогою ферменту ДНК-полімерази. Назвіть цю реакцію:',
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
    'Радіоімунний аналіз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноферментний аналіз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція ензиммічених антитіл',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція імунофлуоресценції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімеразна ланцюгова реакція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 258
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час проведення лабораторної діагностики гепатиту В у крові пацієнта визначають наявність вірусної ДНК. Яку із нижченаведених реакцій використовують?',
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
    'Імуноферментний аналіз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція непрямої гемаглютинації',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція гальмування гемаглютинації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ланцюгова полімеразна реакція',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція зв''язування комплементу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 259
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Останніми роками застосовується метод геноіндикації збудників, що дає можливість виявити в досліджуваних зразках фрагменти нуклеїнових кислот патогенів. Виберіть із наведених реакцій ту, яка підходить для цього:',
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
    'Імуноферментний аналіз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція наростання титру фага',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімеразна ланцюгова реакція',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція преципітації',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Радіоімунний аналіз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 260
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Останніми роками під час проведення лабораторної діагностики гепатиту В у крові хворого визначають наявність вірусної ДНК. За допомогою якої з наведених реакцій це визначають?',
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
    'Реакція гальмування гемаглютинації',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція звʼязування комплементу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція непрямої гемаглютинації',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноферментний аналіз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ланцюгова полімеразна реакція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 261
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У сучасній лабораторній діагностиці широко застосовується полімеразна ланцюгова реакція – ПЛР. Що виявляють за допомогою цієї реакції?',
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
    'Нуклеїнову кислоту мікроорганізму',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автоімунне захворювання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антиген мікроорганізму',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антитіла до мікроорганізму',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алергію до збудника',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 262
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час проведення лабораторної діагностики на SARS-CoV-2, збудника СOVID-19, визначають наявність вірусної РНК у мазку з ротоглотки. За допомогою якої методики це встановлюють?',
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
    'Методу гібридизації',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Методу ІФА-діагностики',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Методу лігазної ланцюгової реакції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Методу полімеразної ланцюгової реакції (ПЛР)',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Методу гібридизації з посиленням сигнал',
    false,
    4,
    NOW(),
    NOW()
  );
  
  RAISE NOTICE 'Додано питань: 262';
END $$;
