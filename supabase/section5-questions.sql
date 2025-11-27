-- SQL для додавання питань до розділу 5: Основні патологічні процеси
-- Автоматично згенеровано
-- Кількість питань: 345

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
  
  -- Створюємо або знаходимо topic для розділу 5
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Основні патологічні процеси'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Основні патологічні процеси',
      'Тести з основних патологічних процесів',
      0,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;
  
  RAISE NOTICE 'Початок додавання питань для розділу 5...';
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
    'В експерименті у кролика було видалено верхній шийний вузол симпатичного стовбура. На боці видалення спостерігається почервоніння і підвищення температури шкіри голови. Яка форма порушень периферичного кровообігу розвинулась у кроля?',
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
    'Метаболічна артеріальна гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична артеріальна гіперемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 2
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У кроля перерізали нерв, що іннервує праве вухо, і видалили правий верхній шийний симпатичний вузол. Одразу після операції провели вимірювання температури шкіри вух. Виявилося, що температура шкіри вуха кролика на боці денервації на 1,50 C вища, ніж на протилежному інтактному боці. Що з наведеного є найбільш вірогідною причиною вказаних явищ?',
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
    'Фізіологічна артеріальна гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія нейропаралітичного типу',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реактивна артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія, обумовлена метаболічними факторами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія нейротонічного типу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 3
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гри у волейбол спортсмен після стрибка приземлився на зовнішній край стопи. Виник гострий біль у гомілковостопному суглобі, активні рухи в ньому обмежені, пасивні - в повному обсязі, але болісні. Потім розвинулася припухлість у ділянці зовнішньої кісточки, шкіра почервоніла, стала теплішою на дотик. Який вид розладу периферичного кровообігу розвинувся в даному випадку?',
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
    'Стаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 4
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини внаслідок попадання гарячої води на руку виник опік. Шкіра на місці опіку яскраво-червона. Яке порушення місцевого кровообігу виникло на місці опіку?',
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
    'Артеріальна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 5
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 44 роки з інфарктом міокарда помер від лівошлуночкової недостатності. Під час аутопсії виявлено: набряк легень, дрібнокраплинні крововиливи у серозних та слизових оболонках. Мікроскопічно спостерігається: дистрофічні та некробіотичні зміни епітелію проксимальних канальців нирок, у печінці - центролобулярні крововиливи та осередки некрозу. На який вид порушення кровообігу вказують такі патологічні зміни?',
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
    'Хронічне малокрівʼя',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічне загальне венозне повнокрівʼя',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостре малокрівʼя',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостре загальне венозне повнокрівʼя',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 6
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта зі скаргами на біль у правій нозі при огляді стопи виявлено збліднення, зменшення об’єму, місцеве зниження температури. Яке порушення місцевого кровообігу спостерігається у хворого?',
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
    'Венозна гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічна артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 7
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При змащуванні скипидаром язик у кроля червоніє, його кровонаповнення збільшується. Артеріальна гіперемія якого типу виникає в цьому випадку?',
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
    'Робоча',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реактивна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 8
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка, яка хворіла на ревматичну хворобу серця з переважанням стенозу лівого атріовентрикулярного отвору, померла від хронічної серцевої недостатності, що прогресувала. Під час гістологічного дослідження виявлено зміни легеневої тканини: просвіт міжальвеолярних капілярів та перибронхіальних судин розширений, відзначається виражена гіперемія, у альвеолах та стромі легенів присутні гемосидерофаги, спостерігається розростання сполучної тканини. Епітелій бронхів та бронхіол десквамований, стінка бронха набрякла, інфільтрована нейтрофілами та лімфоцитами. Під час гістологічного дослідження печінки виявлено: центральні вени та синусоїди повнокровні, відзначаються перивенулярні крововиливи та атрофія центролобулярних гепатоцитів, гіпертрофія периферичних гепатоцитів, також відзначаються поширені ділянки фіброзування паренхіми печінки. Який патологічний процес розвинувся в органах?',
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
    'Загальне гостре венозне повнокрів''я',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місцева венозна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальне хронічне венозне повнокрів''я',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 9
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 54-х років, який скаржиться на біль, блідість та відчуття похолодання нижніх кінцівок, лікар діагностував облітеруючий ендартеріїт. Яке порушення периферичного кровообігу є головною причиною зазначених симптомів?',
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
    'Венозний стаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обтураційна ішемія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 10
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При змащуванні скипидаром язик у кроля червоніє, його кровонаповнення збільшується. Артеріальна гіперемія якого типу виникає в цьому випадку?',
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
    'Робоча',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реактивна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 11
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 40-ка років з ішемічною хворобою серця і захворюванням судин (облітеруючий ендартеріїт) під час огляду нижніх кінцівок виявлені блідість і дистрофічні зміни шкіри, зниження місцевої температури, порушення чутливості, біль. Яке порушення периферичного кровообігу має місце у хворого?',
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
    'Обтураційна ішемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компресійна ішемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ангіоспастична ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 12
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 25-ти років на 8-му місяці вагітності з’явилися ознаки розширення вен нижніх кінцівок, набряки стоп. Який вид розладів периферичного кровообігу спостерігається у вагітної?',
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
    'Венозна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія нейротонічного типу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія нейропаралітичного типу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 13
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 54-х років, який скаржиться на біль, блідість та відчуття похолодання нижніх кінцівок, лікар діагностував облітеруючий ендартеріїт. Яке порушення периферичного кровообігу є головною причиною зазначених симптомів?',
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
    'Обтураційна ішемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейротонічна артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозний стаз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 14
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому із закритим переломом плечової кістки накладена гіпсова пов’язка. Через день з’явилися припухлість, синюшність і похолодання кисті травмованої руки. Про який розлад периферичного кровообігу свідчать дані ознаки?',
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
    'Венозна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 15
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка звернулася до лікаря зі скаргами на біль у ногах, який з’являється надвечір, набряклість стоп і гомілок. Об’єктивно: шкіра на ногах синюшного кольору, холодна на дотик. Яки тип порушення периферичного кровообігу має місце у даної хворої?',
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
    'Венозна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 16
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з варикозним розширенням вен, під час огляду нижніх кінцівок відзначається: ціаноз, пастозність, зниження температури шкіри, поодинокі петехії. Який розлад гемодинаміки наявний у хворого?',
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
    'Компресійна ішемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обтураційна ішемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 17
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 40-ка років з ішемічною хворобою серця і захворюванням судин (облітеруючий ендартеріїт) під час огляду нижніх кінцівок виявлені блідість і дистрофічні зміни шкіри, зни- ження місцевої температури, порушення чутливості, біль. Яке порушення периферичного кровообігу має місце у хворого?',
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
    'Обтураційна ішемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компресійна ішемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ангіоспастична ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 18
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка звернулася до лікаря зі скаргами на біль у ногах, який з’являється надвечір, набряклість стоп і гомілок. Об’єктивно: шкіра на ногах синюшного кольору, холодна на дотик. Яки тип порушення периферичного кровообігу має місце у даної хворої?',
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
    'Венозна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 19
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт 54-х років після значного психоемоційного напруження раптово відчув сильний біль за грудниною з іррадіацією в ліву руку, лівий бік шиї, страх смерті, він вкрився холодним потом. Прийом нітрогліцерину вгамував біль. Назвіть розлад місцевого крово- обігу в серці, який найбільш вірогідно розвинувся в даному випадку:',
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
    'Ішемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 20
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з пародонтитом відмічається набряк ясен. Вони мають темно-червоний колір. Яке місцеве порушення кровообігу переважає в яснах хворого?',
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
    'Ішемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 21
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з хронічною серцевою недостатністю виявлене збільшення в’язкості крові. При капіляроскопії виявлено пошкодження стінок судин мікроциркуляторного русла. Яке з перелічених порушень можливе у даному випадку?',
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
    'Емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіпєрємія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сладж-феномен',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 22
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту, у якого закритий перелом плечової кістки, накладено гіпсову пов’язку. Наступного дня з’явилися припухлість, синюшність і похолодніння кисті травмованої руки. Про який розлад периферичного кровообігу свідчать ці ознаки?',
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
    'Артеріальна гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 23
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 70-ти років, який страждав на цукровий діабет та переніс інфаркт міокарда, помер при явищах прогресуючої серцево-судинної недостатності. На розтині ціанотична індурація селезінки та нирок, бура індурація легень та мускатна печінка. Який вид порушення кровообігу обумовив зміни внутрішніх органів?',
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
  -- Питання 24
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На секції тіла жінки 76-ти років були знайдені ознаки хронічного бронхіту та легеневого серця, печінка збільшена в розмірах, щільна, тканина на розрізі строката. Мікроскопічно: просвіти центральних вен та синусоїдних капілярів розширені. повнокровні, а гепатоцити на периферії часточок з жировою дистрофією. Який вид розладу кровообігу викликав зміни печінки?',
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
    'Місцева венозна гіперемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місцева артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальна артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальне малокрів’я',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Загальна венозна гіперемія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 25
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з варикозним розширенням вен під час огляду нижніх кінцівок відзначається: ціаноз, пастозність, зниження температури шкіри, поодинокі петехії. Який розлад гемодинаміки має місце у хворого?',
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
    'Венозна гіперемія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обтураційна ішемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компресійна ішемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 26
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 60-ти років після емоційної реакції, яка була викликана гнівом, виник напад загрудинного болю. На ЕКГ були встановлені ознаки порушення коронарного кровообігу. Який вид порушень міг спричинити це явище?',
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
    'Справжній стаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ангіоспастична ішемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозний стаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіпєрємія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 27
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 44-х років з інфарктом міокарда, помер від лівошлуночкової недостатності. На аутопсії: набряк легень, дрібнокраплинні крововиливи в серозних та слизових оболонках. Мікроскопічно: дистрофічні та некробіотичні зміни епітелію проксимальних канальців нирок, у печінці - центролобулярні крововиливи та осередки некрозу. Який з видів порушення кровообігу найбільш вірогідний?',
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
    'Гостре загальне венозне повнокров’я',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічне загальне венозне повнокров’я',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостре недокрів’я',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічне недокрів’я',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 28
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині тіла померлого чоловіка 73-х років, який довго хворів на ішемічну хворобу серця з серцевою недостатністю, знайдено: "мускатна" печінка, бура індурація легень, ціанотична індурація нирок та селезінки. Вкажіть, який з видів порушення кровообігу у хворого призвів до таких наслідків?',
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
    'Хронічне загальне венозне повнокров’я',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічне недокрів’я',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостре недокрів’я',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостре загальне венозне повнокров’я',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 29
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 42 років із невралгією трійчастого нерва скаржиться на періодичне почервоніння правої половини обличчя та шиї, відчуття припливу тепла та підвищення шкірної чутливості. Якою у цьому випадку є артеріальна гіперемія за патофізіологічним механізмом?',
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
    'Нейротонічна',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Робоча',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реактивна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейропаралітична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 30
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з пародонтитом відмічається набряк ясен. Вони мають темно-червоний колір. Яке місцеве порушення кровообігу переважає в яснах хворого?',
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
    'Ішемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 31
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з закритим переломом плечової кістки накладена гіпсова пов’язка. Наступного дня з’явилися припухлість, синюшність і похолодання кисті травмованої руки. Про який розлад периферичного кровообігу свідчать ці ознаки?',
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
    'Емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіперемія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозна гіперемія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 32
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час патологоанатомічного розтину тіла п''ятнадцятирічного юнака виявлено збільшення обох легень. У легеневій паренхімі присутні множинні осередкові крововиливи з буро-коричневими ущільненнями. В анамнезі: рецидивні кровохаркання. Інші внутрішні органи характеризуються малокрів''ям. Яке основне захворювання встановлено під час розтину?',
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
    'Синдром Гудпасчера',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний гемосидероз легень',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний гемосидероз легень',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний альвеоліт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Первинна легенева гіпертензія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 33
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта шпиталізовано зі скаргами на інспіраторну задишку та сухий кашель на висоті вдоху. Під час огляду спостерігається блідість шкірних покривів, ціаноз губ, "пальці Гіппократа". Аускультативно визначається: хрипи velcro-type cracles (тріск застібки-липучки). Рентгеноглогічно виявлено: симптом "матового скла". Який найімовірніший діагноз?',
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
    'Ідіопатичний легеневий фіброз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екзогенний алергічний альвеоліт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гістіоцитоз Х легень',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Хенда-Шюллера-Крісчена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний гемосидероз легень',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 34
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження біоптату печінки 67-річного чоловіка, який тривалий час хворіє на хронічну дифузну обструктивну емфізему, було знайдено такі морфологічні зміни: центральні вени дилатовані; у центрі часточок синусоїди гіперемовані, з ознаками капілярізації; частина гепатоцитів дистрофічно змінена; помірний периваскулярний склероз; перипортально спостерігаються гепатоцити з ознаками жирової дистрофії, Діагностуйте вид ураження печінки:',
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
    'Портальний цироз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '"Мускатна" печінка',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '"Кремнієва" печінка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жировий гепатоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '"Гусяча" печінка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 35
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий помер при явищах серцево-судинної недостатності. Результати розтину: післяінфарктний кардіосклероз, гіпертрофія міокарда і дилятація його порожнин, особливо правого шлуночка. Печінка збільшена, з гладенькою поверхнею, на розрізі повнокровна, з темно-червоними крапками на буруватому фоні тканини. Гістологічно: повнокров’я центральних відділів часточок; у периферичних відділах навколо портальних трактів - гепатоцити у стані жирової дистрофії. Як називаються описані вище зміни печінки?',
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
    'Стеатоз печінки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цироз печінки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Несправжньомускатна печінка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мускатна печінка',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 36
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 56 років госпіталізована до хірургічного відділення з клінікою гострого живота. Під час операції виявлено, що частина тонкої кишки протяжністю 80 см має темно-червоний колір, серозна оболонка її тьмяна, шорстка, у черевній порожнині геморагічна рідина. Який розлад кровообігу виявлено у пацієнтки?',
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
    'Крововилив у стінку тонкої кишки',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт тонкої кишки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місцеве артеріальне повнокрів’я',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Місцеве венозне повнокрів’я',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт тонкої кишки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 37
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка, що загинув раптово при явищах гострого порушення мозкового кровообігу, на розтині виявлений розрив аневризми середньої мозкової артерії й округла порожнина діаметром 4 см, заповнена кров’ю, у лобній частці головного мозку. Як називається такий вид крововиливу?',
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
    'Геморагічна інфільтрація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кровопідтік',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематома',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Петехії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 38
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла померлого в підкоркових ядрах правої півкулі головного мозку спостерігається порожнина неправильної форми 5х3,5 см, заповнена червоними згустками крові та розм’якшеною тканиною мозку. Назвіть патологію, яка розвинулася у головному мозку:',
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
    'Гематома',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес',
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
    'Геморагічне просякнення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Астроцитома',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 39
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину померлого, що страждав на гіпертонічну хворобу, у речовині головного мозку виявлена порожнина, стінки якої мають іржавий колір. Що передувало виникненню даних змін?',
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
    'Ішемічний інфаркт',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Діапедезні крововиливи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематома',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плазморагії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 40
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині померлого в підкоркових ядрах правої півкулі головного мозку визначається порожнина неправильної форми 5 х 3,5 см, заповнена червоними згортками крові і розм’якшеною тканиною мозку. Назвіть патологію, яка розвинулась у головного мозку?',
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
    'Ішемічний інфаркт.',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кіста.',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес.',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічне просякнення.',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематома.',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 41
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла померлого чоловіка віком 43 роки було виявлено набряк легень. З анамнезу відомо, що пацієнт хворів на ІХС із розвитком інфаркту міокарда. Яка ймовірна причина набряку легень?',
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
    'Гостре загальне малокрів''я',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія малого кола',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра правошлуночкова недостатність',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра лівошлуночкова недостатність',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 42
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії тіла чоловіка віком 70 років у передній стінці лівого шлуночка визначається ділянка із тьмяною поверх нею білуватого кольору яка поширюється на всю товщу міокарда та оточена перифокальним геморагічним вінчиком. Під мікроскопом уражена ділянка відмежована від міокарда, що зберігся, зоною повнокрів’я і лейкоцитарною інфільтрацією (демаркаційне запалення), представлена некротизованою тканиною з наявністю периваскулярних «острівців» збережених кардіоміоцитів. Якому діагнозу відповідає така морфологічна картина?',
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
    'Інтрамуральний інфаркт міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вогнищевий міокардит',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіосклероз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міомаляція',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансмуральний інфаркт міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 43
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 50 років шпиталізовано у відділення реанімації зі скаргами на слабкість, задишку, стискальний біль за грудиною. Під час огляду виявлено: стан середньої тяжкості, ЧСС – 80/хв, АТ – 130/85 мм рт ст. На ЕКГ: поглиблений зубець Q і підйом сегмента ST. Активність АсАТ, МВ-КФК і тропонінів у крові різко збільшені. Якому патологічному стану відповідають описані симптоми та результати лабораторних досліджень?',
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
    'Міокардиту',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перикардиту',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболії легеневої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркту міокарда',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенокардії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 44
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У крові хворого при обстеженні виявлено підвищений вміст ферментів: креатинкінази (МВ-ізоформа), АсАЕ і ЛДГ1,2. Яку патологію слід насамперед припустити у цьому випадку?',
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
    'Інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'М’язова дистрофія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цироз печінки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ураження центральної нервової системи',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Панкреатит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 45
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 49-ти років, водій за професією, скаржиться на нестерпний стискаючий біль за грудниною, що "віддає" у ділянку шиї. Біль виник 2 години тому. Об’єктивно: стан важкий, блідість, тони серця послаблені. Лабораторне обстеження показало високу активність креатинкінази та ЛДГ1 . Для якого захворювання характерні такі симптоми?',
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
    'Гострий інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенокардія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жовчнокам’яна хвороба',
    false,
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
  -- Питання 46
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого через 12 годин після гострого нападу загрудинного болю визначено різке підвищення активності АсАТ в сироватці крові. Яка з перерахованих патологій буде найбільш імовірною?',
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
    'Колагенози',
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
    'Цукровий діабет',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вірусний гепатит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 47
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла померлого від набряку легень у міокарді знайдено велике вогнище жовто-сірого кольору, а в коронарній артерії - свіжий тромб. Який найбільш імовірний діагноз?',
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
    'Інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіосклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіоміопатія',
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
    'Амілоїдоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 48
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії тіла чоловіка у верхній долі правої легені виявлено крупний клиноподібний осередок темно-червоної щільної тканини. Під час гістологічного дослідження виявлено некроз стінок альвеол, просвіт альвеол щільно заповнений еритроцитами. Який процес розвинувся в легенях?',
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
    'Геморагічний інфаркт легень',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карніфікація легень',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена легень',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крововилив у легені',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ателектаз легень',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 49
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла 68-річної жінки, що померла від гострої серцевої недостатності, у задній стінці лівого шлуночка серця виявлена ділянка неправильної форми, розмірами 6,5х4,5 см, в’яла, блідо-жовтуватого кольору, оточена зоною гіперемії. Як розцінив патологоанатом виявлені зміни?',
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
    'Гострий інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аневризма серця',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний кардіосклероз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вогнищевий міокардит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Післяінфарктний кардіосклероз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 50
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження міокарда було виявлено велику ділянку міокардіоцитів, у яких відсутні ядра. Цитоплазма клітин гомогенна, рожевого кольору. На периферії вогнища визначаються розширені, різко повнокровні судини і виражена інфільтрація сегментоядерними лейкоцитами. Про який процес свідчить ця гістологічна картина?',
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
    'Інкапсуляцію інфаркту',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Асептичний автоліз інфаркту',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Організацію інфаркту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Демаркаційне запалення навколо інфаркту',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септичний розпад інфаркту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 51
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла чоловіка, який помер від набряку легень, у міокарді було виявлено велике вогнище жовто-сірого кольору, а в коронарній артерії свіжий тромб. Для якого захворювання характерні такі симптоматичні явища?',
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
    'Інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіоміопатія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз',
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
    'Кардіосклероз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 52
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 65 років, який страждав на атеросклероз, госпіталізований в хірургічне відділення з приводу розлитого гнійного перитоніту. Під час операції діагностовано тромбоз брижових артерій. Яка найбільш ймовірна причина перитоніту?',
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
    'Стазі',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія компресійна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія ангіоспастична',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 53
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На секції в лівій легені виявлено ділянку щільної тканини червоного кольору. Ділянка має форму конуса, чітко відмежована від здорової тканини, основою обернена до плеври. Тканина на розрізі зерниста, темно-червона. Який найбільш вірогідний діагноз?',
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
    'Первинний туберкульозний афект',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена легені',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крупозна пневмонія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес легені',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 54
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Літня людина перенесла інфаркт правої півкулі головного мозку. Через рік, враховуючи відсутність рухів лівих кінцівок, проведено комп''ютерну томографію мозку, під час якої в правій півкулі знайдено порожнину з гладенькими стінками, заповнену ліквором. Який патологічний процес виявлено у головному мозку?',
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
    'Інфаркт мозку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематома',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сіре розм''якшення мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідроцефалія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постінфарктна кіста',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 55
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині в серці виявлено наступні зміни: великий осередок некрозу білого кольору з червоною облямівкою, який захоплює всю товщу серцевого м’яза. На зовнішній оболонці серця - ознаки фібринозного перикардиту. Який найбільш імовірний діагноз?',
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
    'Субепікардіальний інфаркт міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансмуральний інфаркт міокарда',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Субендокардіальний інфаркт міокарда',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтрамуральний інфаркт міокарда',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 56
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині померлого, що страждав від атеросклерозу, в головному мозку виявлено тромбоз гілки внутрішньої сонної артерії і сірого кольору вогнище вологого розм''якшення тканин. Який патологічний процес виявлений в головному мозку?',
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
    'Гематома',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічна інфільтрація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пухлина мозку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енцефаліт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 57
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження серця померлого від гострої серцевої недостатності у міокарді лівого шлуночка виявлена ділянка омертвіння, відмежована від неушкодженої тканини зоною повнокровних судин, дрібних крововиливів та лейкоцитарною інфільтрацією. Який діагноз найбільш імовірний?',
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
    'Осередковий ексудативний міокардит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічна дистрофія міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний ексудативний міокардит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Продуктивний міокардит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 58
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину трупа чоловіка 60-ти років у міокарді передньої стінки лівого шлуночка виявлене сіре неправильної форми щільне вогнище 5х4 см з чіткими межами, волокнистої структури. Який діагноз найбільш вірогідний?',
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
    'Кардіоміопатія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Післяінфарктний міокардіосклероз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний дрібновогнищевий міокардіосклероз',
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
    'Інфаркт',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 59
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії тіла чоловіка віком 62 роки, який хворів на атеросклероз і помер від гострої серцевої недостатності, у передній стінці лівого шлуночка серця виявлено ділянку біло-жовтого кольору, розміром 6х5 см, неправильної форми, яка чітко відмежована від навколишніх тканин геморагічним вінчиком. Якому захворюванню відповідають такі патологічні зміни?',
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
    'Кардіоміопатії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардиту',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркту міокарда',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постінфарктному кардіосклерозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дрібно-осередкованому кардіосклерозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 60
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла 68-річної жінки, що померла від гострої серцевої недостатності, у задній стінці лівого шлуночка серця виявлена ділянка неправильної форми, розмірами 6,5х4,5 см, в’яла, блідо-жовтуватого кольору, оточена зоною гіперемії. Як розцінив патологоанатом виявлені зміни?',
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
    'Аневризма серця',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий інфаркт міокарда',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вогнищевий міокардит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний кардіосклероз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Післяінфарктний кардіосклероз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 61
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого через 12 годин після гострого нападу загрудинного болю спостерігається різке підвищення активності АсАТ в сироватці крові. Вкажіть патологію, для якої характерне це зміщення:',
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
    'Інфаркт міокарду',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вірусний гепатит',
    false,
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
    'Колагеноз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 62
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині в серці виявлено наступні зміни: великий осередок некрозу білого кольору з червоною облямівкою, який захоплює всю товщу серцевого м’яза. На зовнішній оболонці серця - ознаки фібринозного перикардиту. Який найбільш імовірний діагноз?',
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
    'Інтрамуральний інфаркт міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Субендокардіальний інфаркт міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Субепікардіальний інфаркт міокарда',
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
    'Трансмуральний інфаркт міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 63
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 65-ти років, що страждає на атеросклероз, госпіталізований до хірургічного відділення з приводу розлитого гнійного перитоніту. Під час операції діагностовано тромбоз брижових артерій. Яка найбільш імовірна причина перитоніту?',
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
    'Ішемічний інфаркт',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія компресійна',
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
  -- Питання 64
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 75-ти років, який довгий час страждав на атеросклероз церебральних судин, на аутопсії виявлені: тромбоз правої середньої мозкової артерії, великий осередок неправильної форми сірого кашоподібного розм’якшення мозкової тканини. Який патологічний процес розвинувся в спинному мозку?',
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
    '-',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічний інфаркт',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 65
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При дослідженні крові хворого виявлено значне збільшення активності МВ-форм КФК (креатинфосфокінази) та ЛДГ-1. Яку патологію можна припустити?',
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
    'Гепатит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Панкреатит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ревматизм',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холецистит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 66
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 68-ми років, що страждає на атеросклероз, госпіталізована до хірургічного відділення з приводу розлитого гнійного перитоніту. Під час операції діагностовано тромбоз брижових артерій. Яка найбільш імовірна причина перитоніту?',
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
    'Геморагічний інфаркт',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія ангіоспастична',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія компресійна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Немічний інфаркт',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 67
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого через 12 годин після гострого нападу загруднинного болю знайдено різке підвищення активності АсАТ у сироватці крові. Вкажіть патологію, для якої характерне це зміщення:',
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
    'Інфаркт міокарда',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цукровий діабет',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колагеноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вірусний гепатит',
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
  -- Питання 68
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При дослідженні крові хворого виявлено значне збільшення активності МВ - форм КФК (креатинфосфокінази) та ЛДГ-1. Яка найбільш ймовірна патологія?',
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
    'Холецистит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ревматизм',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Панкреатит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепатит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 69
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину в верхній долі правої легені виявлений крупний клиноподібний осередок темно-червоної, щільної тканини. При гістологічному дослідженні в ній виявлений некроз стінок альвеол, просвіт альвеол щільно заповнений еритроцитами. Який процес розвинувся в легенях?',
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
    'Гангрена легенів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічний інфаркт легень',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крововилив в легені',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карніфікація легких',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ателектаз легенів',
    false,
    4,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемічна енцефалопатія',
    false,
    5,
    NOW(),
    NOW()
  );
  -- Питання 70
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт на ранніх етапах гострого інфаркту міокарда для відновлення кровопостачання ішемізованих тканин потребує тромболітичної терапії з використанням рекомбінантного активатора ппазміногену тканинного типу. Який із нижченаведених препаратів потрібно ввести пацієнту?',
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
    'Ацетилсаліцилова кислота',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Варфарин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептокіназа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альтеплаза',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 71
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 63 роки помер із ознаками гострої серцево-судинної недостатності. Під час аутопсії у передній стінці серця виявлено ділянку жовтувато-сірого кольору, оточену геморагічним вінчиком, а в передній міжшлуночковій артерії — тромб, який повністю закривав просвіт судини та був причиною ішемії міокарда. Яка ішемія за причиною і механізмом розвитку призвела до інфаркту міокарда?',
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
    'Перерозподільча',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компресійна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Функціональна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ангіоспастична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обтураційна',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 72
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіку віком 68 років діагностовано гострий інфаркт міокарда. Який препарат фібринолітичної дії показаний пацієнту?',
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
    'Кислота ацетилсаліцилова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альтеплаза',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фраксипарин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неодикумарин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 73
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтка віком 65 років госпіталізована до кардіологічного відділення клініки з діагнозом: синдром Дресслера. З анамнезу відомо, що у пацієнтки був інфаркт міокарда. Які додатокві клініко-лабораторні показники будуть підтвердження дігнозу: синдром Дреслера?',
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
    'Збільшення ШОЕ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення активності аспартатамінотрансферази в крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гарячка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення рівня автоантитіл крові',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоцитоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 74
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт із гострим трансмуральним інфарктом міокарда лівого шлуночка помер від розриву серця і тампонади. Який процес у зоні інфаркту міг бути причиною розриву?',
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
    'Формування рубця із стоншенням стінки лівого шлуночка серця',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення тиску в малому колі кровообігу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутолітичні процеси з розплавленням тканини міокарда (міомаляція)',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стоншення рубцево зміненої стінки шлунка з формуванням аневризми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Заміщення сполучною тканиною зі зниженням еластичності міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 75
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який препарат призначають для профілактики інфаркту міокарда, якщо є протипоказання до застосування ацетилсаліцилової кислоти?',
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
    'a.Неодикумарин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'b.Тиклопідин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'c.Стрептокіназа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'd.Гепарин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'e.Фенілін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 76
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки віком 62 роки з трансмуральним інфарктом міокарду розвинулася серцева недостатність. Який патогенетичний механізм її розвитку?',
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
    'a. Гостра тампонада серця',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'b. Зниження маси функціонуючих кардіоміоцитів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'c. Перевантаження серця тиском',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'd. Перевантаження серця об`ємом',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'e. Реперфузійне ураження міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 77
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 68 років, який переніс інфаркт міокарда, під час ЕКГ-обстеження відмічається прогресуюче збільшення інтервалу PQ з випадінням комплексу QRS, після чого інтервал PQ відновлюється. Із порушенням якої функції серця пов''язане це порушення серцевого ритму?',
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
    'Збудливості',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автоматизму',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Провідності',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скоротливості',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '--',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 78
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 50 років, через 5 років після інфаркту помер від хронічної серцевої недостатності. Під час аутопсії виявлено щільне лантухоподібне випинання на боковій поверхні стінки лівого шлуночка. Стінка у цьому місці стоншена, щільна, сірого кольору. Для якої патології серця характерні такі зміни?',
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
    'Інфаркту міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіосклерозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічної аневризми',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіоміопатії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардиту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 79
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На аутопсії жінки, яка померла від гострого інфаркту міокарда, у вені лівої гомілки виявлений тромб. При мікроскопічному дослідженні тромба виявлено, що він заміщений сполучною тканиною, в якій відзначається дифузне відкладення солей кальцію. Дайте назву такому результату тромбозу:',
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
    'Петрифікація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Організація і каналізація',
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
    'Септичний аутоліз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Асептичний аутоліз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 80
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт, у якого в анамнезі був гострий інфаркт міокарда, у складі комплексної терапії отримував гепарин. Через деякий час зʼявилася гематурія. Який препарат показаний у якості антидоту?',
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
    'Вікасол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неодикумарин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протаміну сульфат',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінокапронова кислота',
    false,
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
  -- Питання 81
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гепатиту та інфаркту міокарда в плазмі крові пацієнтів різко зростає активність аланін- і аспартатамінотрансфераз. Які причини зростання активності цих ферментін у крові?',
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
    'Нестача піридоксину',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зростання швидкості синтезу амінокислот у тканинах',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення активності ферментів гормонами',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкоджения мембран клітин і вихід ферментів у кров',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення швидкості розпаду амінокислот у тканинах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 82
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У результаті інфаркту міокарда відбулося пошкодження ділянки серцевого мʼяза, яке супроводжується масовою загибеллю кардіоміоцитів. Які клітинні елементи забезпечать заміщення утвореного дефекту в структурі міокарда?',
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
  -- Питання 83
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з інфарктом міокарда артеріальний тиск знизився до 70/40 мм рт. ст. Що є первинним механізмом розвитку артеріальної гіпотензії за серцевої недостатності?',
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
    'Зменшення хвилинного обʼєму кровобігу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Затримка калію в організмі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вазоконстрикція периферичних судин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генералізована вазодилятація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Втрата організмом натрію',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 84
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 70 років після нервового збудження потрапив до лікарні з діагнозом: ішемічна хвороба серця, передінфарктний стан. Яка речовина могла спричинити ангіоспазм вінцевих судин у пацієнта?',
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
    'Простациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іони калію',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоксан А2',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденозин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксид азоту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 85
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіка віком 59 років шпиталізували у тяжкому стані з діагнозом: гострий інфаркт міокарда в ділянці задньої стінки лівого шлуночка та перегородки, початковий набряк легень. Який механізм є первинним у виникненні набряку легень у пацієнта?',
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
    'Легенева венозна гіпертензія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Легенева артеріальна гіпертензія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження альвеоло-капілярної дифузії кисню',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лівошлуночкова недостатність',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 86
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Активність якого ферменту підвищується в крові пацієнта під час інфаркту міокарда?',
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
    'Карбамоілфосфатсинтетази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лужної фосфатази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази ММ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази МВ',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази ВВ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 87
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після перевʼязки однієї з гілок вінцевих артерій у собаки розвинувся інфаркт міокарда, який супроводжувався проявами резорбційно-некротичного синдрому. Укажіть найхарактернішу ознаку розвитку цього синдрому.',
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
    'Біль за грудниною',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження хвилинного обʼєму крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення у крові креатинкінази',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення у крові катехоламінів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриляція шлуночків',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 88
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 53-х років після тяжкого психоемоційного навантаження раптово з’явився гострий біль у ділянці серця з іррадіацією у ліву руку, шию, під ліву лопатку. Відзначалося оніміння лівої кисті. Обличчя стало блідим, вкрилося холодним потом. Нітрогліцерин зняв напад болю через 10 хвилин. Яке захворювання найбільш імовірно виникло у хворого?',
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
    'Вегето-судинна дистонія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія легеневої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсульт',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенокардія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 89
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення лікарні госпіталізовано чоловіка віком 49 років з інфарктом міокарда. Які зміни клітинного складу периферичної крові індуковані некротичними змінами в міокарді?',
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
    'Нейтрофільний лейкоцитоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еозинофільний лейкоцитоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцитопенія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моноцитоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфопенія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 90
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Визначення якого ферменту в крові є найбільш інформативним у перші години після виникнення інфаркту міокарда?',
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
    'Лактатдегідрогенази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аланінамінотрансфсрази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аспартатамінотрансферази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глутаматдегідрогенази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 91
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловікові 54 років діагностовано великовогнищевий інфаркт міокарда передньої стінки лівого шлуночка. В якій артерії порушений кровообіг? (Коректна відповідь - У передній міжшлуночковій гілці ЛІВОЇ вінцевої артерії)',
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
    'У правій вінцевій артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У задній міжшлуночковій гілці правої вінцевої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'В огинальній гілці лівої вінцевої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У лівій вінцевій артерії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У передній міжшлуночковій гілці правої вінцевої артерії (закодовано на ЦТ)',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 92
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта за 2 доби після розвитку інфаркту міокарда відбулося різке падіння систолічного АТ до 60 мм рт.ст. з тахікардією 140/хв., задишкою та непритомністю. Який механізм має вирішальне значення в патогенезі шоку, що розвинувся?',
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
    'Зниження об’єму циркулюючої крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвиток анафілактичної реакції на міокардіальні білки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення хвилинного об''єму крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення збудливості міокарда продуктами некротичного розпаду',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвиток пароксизмальної тахікардії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 93
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення лікарні госпіталізовано чоловіка віком 49 років з інфарктом міокарда. Які зміни клітинного складу периферичної крові індуковані некротичними змінами в міокарді?',
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
    'Нейтрофільний лейкоцитоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еозинофільний лейкоцитоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцитопенія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моноцитоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфопенія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 94
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому після гострого інфаркту міокарда лікар порекомендував протягом 3-4 місяців приймати ацетилсаліцилову кислоту. На яку дію ацетилсаліцилової кислоти розрахував лікар?',
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
    'Анальгезуюча',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протизапальна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жарознижуюча',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антиагрегантна',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спазмолітична',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 95
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 62-х років госпіталізований у кардіологічне відділення у важкому стані з діагнозом: гострий інфаркт міокарда у ділянці задньої стінки лівого шлуночкаі перегородки,набряк легень. Який первинний механізм викликає розвиток набряку легень у пацієнта?',
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
    'Легенева артеріальна гіпертензія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоксемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження альвеоло-капілярної дифузії кисню',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра лівошлуночкова недостатність',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Легенева венозна гіпертензія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 96
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 65-ти років переніс інфаркт міокарда. Через місяць у нього розвинулась серцева недостатність. Що зумовило її виникнення?',
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
    'Інфекція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищений опір вигнанню крові в легеневий стовбур',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ушкодження міокарда',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаження серця опором',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищений опір вигнанню крові в аорту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 97
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Препарат з якої фармакологічної групи необхідно призначити хворому, що переніс інфаркт міокарда, для профілактики тромбозу?',
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
    'Блокатори протонної помпи',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемостатичні засоби',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міорелаксанти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антикоагулянти непрямої дії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Наркотичні анальгетики',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 98
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на інфаркт міокарда проводилась терапія по протидії внутрішньосудинному згортанню крові. Який лікарський препарат можна застосовувати з цією метою?',
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
    'Гістамін',
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
    'Хондроїтинсульфат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 99
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Внаслідок інфаркту міокарда у хворого виникла шлуночкова аритмія. Серцевий ритм нормалізувався після введення протиаритмічного засобу з місцевоанестезуючою активністю. Який препарат введено?',
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
    'Лідокаїн',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Новокаїнамід',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Верапаміл',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Панангін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пропранолол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 100
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?',
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
    'Концентрації фібриногену',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активованого часткового тромбопластинового часу (коректна відповідь)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міжнародного нормалізованого відношення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ШОЕ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протромбінового часу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 101
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При досліджені трупа жінки 59-ти років, яка померла від гострої серцевої недостатності, в стінці лівого шлуночка виявлено ділянку жовтого кольору 2,5х2 см, неправильної форми, тістоподібної консистенції. На ендокарді, відповідно до неї, утворився тромб, а на епікарді – фібринозні нашарування. Яка локалізація інфаркту стосовно стінки серця мала місце?',
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
    '–',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтрамуральний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Субепікардіальний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансмуральний',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Субендокардіальний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 102
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий скаржиться на біль за грудниною, потовиділення та посилене серцебиття. Які з перелічених ферментів слід визначити в крові для підтвердження діагнозу інфаркту міокарда?',
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
    'АсАТ, КФК, ЛДГ-1',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АлАТ, альдолаза, ЛДГ-4',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілаза, лужна фосфатаза, АлАТ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кисла фосфатаза, ЛДГ-5, ЛДГ-4',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'α-фетопротеїн, альдолаза, КФК',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 103
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На автопсії в померлого 72-х років з повторним трансмуральним інфарктом міокарда оболонки епікарду та перикарду набухлі, потовщені, кострубаті, неначе вкриті волосяним покровом. Назвіть вид запалення у оболонках серця:',
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
    'Катаральне',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серозне',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крупозне',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гнійне',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифтеритичне',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 104
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення госпіталізовано чоловіка з інфарктом міокарда в гострій фазі. Який фермент застосовують для лізису тромбів у коронарних судинах у перші години?',
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
    'Трипсин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лізоцим',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хімотрипсин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лідазу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептокіназу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 105
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка на тлі інфаркту міокарда виникла пароксизмальна шлуночкова тахікардія. Який із нижченаведених протиаритмічних засобів треба обрати, щоб не зменшити серцевий викид?',
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
    'Новокаїнамід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лідокаїну гідрохлорид',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Верапаміл',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Калію хлорид',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анаприлін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 106
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту встановлено діагноз: інфаркт задньої частини міжшлуночкової перетинки. У ділянці якої кровоносної судини виникло порушення кровообігу?',
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
    'R. circumflexus',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. marginalis sinister',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. marginalis dexter',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. atrialis intermedius',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. interventricularis posterior',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 107
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 56-ти років скаржиться на періодичні напади болю в ділянці серця, що іррадіюють в ліву руку, інколи в ліву лопатку, та купіруються прийманням нітрогліцерину. Яку патологію серця можна запідозрити в цього хворого?',
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
    'Стенокардія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендокардит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перікардит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 108
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого лікар діагностував тромбоз селезінкової артерії (інфаркт селезінки). Звідки відходить уражена артерія?',
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
    'Загальна печінкова артерія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Верхня брижова артерія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Черевний стовбур',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва шлункова артерія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нижня брижова артерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 109
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 64-х років часті напади стенокардії. Два роки тому він переніс інфаркт міокарда. Вкажіть групу лікарських засобів, препарати якої доцільно призначити для профілактики розвитку повторного інфаркту міокарда:',
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
    'Антиагреганти',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коагулянти',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антагоністи гепарину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринолітики',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антикоагулянти непрямої дії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 110
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 48-ми років з обширним інфарктом міокарда розвинулась серцева недостатність. Який патогенетичний механізм сприяв розвитку серцевої недостатності у хворої?',
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
    'Реперфузійне ураження міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаження тиском',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра тампонада серця',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення маси функціонуючих міокардіоцитів',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаження об’ємом',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 111
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 59-ти років з трансмуральним інфарктом міокарда лівого шлуночка, помер від справжнього розриву серця - тампонади серця. Який процес у зоні інфаркту міг сприяти розриву серця?',
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
    'Аутолітичні процеси розплавлення тканини міокарда (міомаляція)',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Формування рубця з витонченням лівого шлуночка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоутворення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Заміщення сполучної тканини зони інфаркту (організація)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 112
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У відділення інтенсивної терапії доставлено жінку 50-ти років з діагнозом: інфаркт міокарда. Активність якого ферменту крові буде найбільш підвищена протягом перших двох діб захворювання?',
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
    'ЛДГ5',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аспартатамінотрансфераза',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аланінамінотрансфераза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аланінамінопептидаза',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ4',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 113
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Бригада швидкої допомоги була викликана до хворого 48-ми років із приводу інфаркту міокарда. У комплексну терапію було включено анальгетик, що застосовують для нейролептаналгезії. Вкажіть найбільш доцільний швидкодіючий препарат:',
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
    'Промедол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Індометацин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фентаніл',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морфіну гідрохлорид',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аспірин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 114
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження коронарних артерій виявлені атеросклеротичні бляшки з кальцинозом, що закривають просвіт на 1/3. У м’язі дрібні множинні білуваті прошарки сполучної тканини. Який процес виявлено в міокарді?',
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
    'Післяінфарктний кардіосклероз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міокардит',
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
    'Тигрове серце',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний кардіосклероз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 115
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого після інфаркту міокарда передсердя і шлуночки стали скорочуватись незалежно одне від одного: з частотою 60-70 та 35-40 за хвилину. Назвіть вид блокади в даному випадку:',
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
    'Сино-атріальна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Внутрішньопередсердна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повна передсердно-шлуночкова',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неповна передсердно-шлуночкова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Внутрішньошлуночкова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 116
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 68 років переніс інфаркт міокарду. Під час ЕКГ-обстеження спостерігається прогресивне збільшення тривалості інтервалу PQ аж до випадіння комплексу QRS, після чого інтервал PQ відновлюється. З порушенням якої функції серця пов''язане таке порушення серцевого ритму?',
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
    'Провідності',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автоматизму',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збудливості',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скоротливості',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 117
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 42-річного чоловіка діагностований інфаркт міокарда. Неефективність попередніх заходів дала підставу лікарю провести нейролептаналгезію. Який нейролептик необхідно застосувати?',
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
    'Дроперидол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галоперидол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміназин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прометазин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клозепін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 118
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіку, після інфаркту міокарда, призначено ацетилсаліцилову кислоту, 75 мг щоденно. З якою метою призначено препарат?',
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
    'Розширення коронарних судин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення болю',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення агрегації тромбоцитів',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження температури',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення запалення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 119
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 50 років за місяць після перенесеного інфаркту міокарда розвинулася серцева недостатність. Невідповідність між навантаженням на серце та його здатністю виконувати роботу пов’язана в цьому разі з:',
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
    'Перевантаженням серця',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищеним опором вигнанню крові в легеневому стовбурі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ушкодженням міокарда',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаною формою серцевої недостатності',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищеним опором вигнанню крові в аорті',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 120
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого інфаркт міокарда в ділянці передньої стінки лівого шлуночка. В басейні якої судини виникло порушення кровообігу?',
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
    'Передня міжшлуночкова гілка лівої вінцевої артерії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Огинаюча гілка лівої вінцевої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва крайова гілка лівої вінцевої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передня шлуночкова гілка правої вінцевої артерії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передсердно-шлуночкова гілка лівої вінцевої артерії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 121
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення надійшов хворий з інфарктом міокарда. Для усунення болю було вирішено потенціювати дію фентанілу нейролептиком. Який з перелічених нейролептиків найбільш придатний для нейролептаналгезії?',
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
    'Аміназин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульпірид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроперидол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галоперидол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трифтазин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 122
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого інфаркт міокарда задньої стінки правого шлуночка. Гілки якої артерії тромбовані?',
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
    'Права підключична артерія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Права коронарна артерія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва коронарна артерія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва підключична артерія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва та права коронарна артерія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 123
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з інфарктом міокарда була проведена нейролептаналгезія. Який препарат з групи наркотичних анальгетиків найчастіше застосовується спільно з дроперидолом?',
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
    'Фентаніл',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морфін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пентазоцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Омнопон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Промедол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 124
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для усунення больового синдрому пацієнту з інфарктом міокарда лікар призначив анальгетичний препарат. Стан хворого поліпшився, але з часом з’явилися ейфорія, міоз. Лікар виявив пригнічення дихання. Який лікарський засіб був призначений?',
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
    'Баралгін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парацетамол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мелоксикам',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ібупрофен',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морфіну гідрохлорид',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 125
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для купірування больового синдрому пацієнту з інфарктом міокарда лікар призначив аналгетичний засіб. Стан хворого поліпшився, але згодом, у зв’язку з передозуванням з’явилася сонливість, міоз, лікар відзначив пригнічення дихання. Який лікарський засіб було призначено?',
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
    'Морфін',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ібупрофен',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парацетамол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Баралгін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Седалгін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 126
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на 2 добу після розвитку інфаркту міокарда різко знизився систолічний АТ до 60 мм рт.ст., виникли тахікардія до 140/хв, задишка; хворий знепритомнів. Який механізм є провідним у патогенезі шоку, що розвинувся?',
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
    'Зменшення ударного об’єму крові',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтоксикація',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анафілактична реакція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пароксизмальна тахікардія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження об’єму циркулюючої крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 127
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому поставили попередній діагноз інфаркт міокарда. Характерною ознакою цього захворювання є суттєве підвищення в крові активності:',
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
    'Креатинфосфокінази',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргінази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Г-6-ФДГ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каталази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альфа-амілази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 128
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 68 років переніс інфаркт міокарда. Під час ЕКГ-обстеження відзначається прогресуюче збільшення тривалості інтервалу PQ аж до випадіння комплексу QRS, після чого інтервал PQ відновлюється. З порушенням якої функції серця пов’язане таке порушення серцевого ритму?',
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
    'Збудливість',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автоматизм',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скоротливість',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Провідність',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 129
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий переніс повторний інтрамуральний інфаркт міокарда. Після лікування та реабілітації був виписаний у задовільному стані під нагляд дільничного терапевта. Через 2 роки загинув у автомобільній катастрофі. Який характер патологічного процесу в міокарді було встановлено на розтині?',
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
    'Дрібновогнищевий кардіосклероз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некроз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Великовогнищевий кардіосклероз',
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
  -- Питання 130
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 50-ти років через місяць після перенесеного інфаркту міокарда розвинулася серцева недостатність. Невідповідність між навантаженням на серце та його здатністю виконувати роботу пов’язана в цьому випадку з:',
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
    'Підвищеним опором вигнанню крові в легеневому стовбурі',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаною формою недостатності серця',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищеним опором вигнанню крові в аорті',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаженням серця',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ушкодженням міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 131
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Через три тижні після пересадки серця у пацієнта різко погіршився стан. Смерть настала від гострої серцевої недостатності. Гістологічно в міокарді виявлено васкуліт, некрози та лімфоцитарну інфільтрацію. Назвіть причину таких змін:',
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
    'Гостре відторгнення трансплантату',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічне відторгнення трансплантату',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Найгостріше відторгнення трансплантату',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некротизуючий васкуліт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 132
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У реанімаційне відділення надійшов хворий з гострим інфарктом міокарда, якому для зменшення болю ввели морфіну гідрохлорид. Механізм дії морфіну гідрохлориду обумовлений:',
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
    'Стимуляцією опіатних рецепторів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокадою гістамінових рецепторів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокадою фосфодіестерази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокадою холінестерази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимуляцією аденілатциклази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 133
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого інфаркт міокарда. Активність якого ферменту буде значно підвищена в сироватці крові хворого в перші години?',
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
    'АЛТ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокіназа МВ',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ4',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ5',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'АСТ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 134
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий переніс повторний інтрамуральний інфаркт міокарда. Після лікування та реабілітації виписаний у задовільному стані під нагляд дільничного терапевта. Через 2 роки загинув у автомобільній катастрофі. Який характер патологічного процесу в міокарді було встановлено на розтині?',
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
    'Крупновогнищевий кардіосклероз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дрібновогнищевий кардіосклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некроз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперплазія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 135
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого діагностовано інфаркт задньої частини міжшлуночкової перегородки. В ділянці якої кровоносної судини виникло порушення кровообігу?',
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
    'R. circumflexus',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. interventricularis posterior',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. atrialis intermedius',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. marginalis sinister',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'R. marginalis dexter',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 136
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У відділення реанімації був доставлений хворий з інфарктом міокарда. Який препарат необхідно ввести хворому для лікування больового шоку?',
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
    'Налоксон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анальгін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Целекоксиб',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Промедол',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парацетамол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 137
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У відділення реанімації надійшов чоловік 47-ми років з діагнозом інфаркт міокарда. Яка з фракцій лактатдегідрогенази (ЛДГ) буде переважати в сироватці крові впродовж перших двох діб захворювання?',
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
    'ЛДГ2',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ5',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ1',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ3',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ4',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 138
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 38-ми років раптово помер. На розтині: у задній стінці лівого шлуночка серця виявлено інфаркт міокарда. Які найбільш імовірні зміни у будові міокардіоцитів можна побачити у вогнищі інфаркту мікроскопічно?',
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
    'Звапнування',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова дистрофія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводна дистрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білкова дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріолізис',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 139
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 45-ти років на тлі трансмурального інфаркту міокарда розвинулася гостра лівошлуночкова недостатність. Який лікарський засіб доцільно застосувати у даній ситуації для покращення помпової функції серця?',
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
    'Добутамін',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізадрин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Промедол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еуфілін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ефедрин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 140
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий на трансмуральний інфаркт міокарда лівого шлуночка переведений до відділення реанімації у важкому стані. АТ- 70/50 мм рт.ст., ЧСС- 56/хв., ЧД- 32/хв. Зазначте головну ланку в патогенезі кардіогенного шоку:',
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
    'Втрата електролітів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Падіння периферичного судинного опору',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Втрата води',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Падіння серцевого викиду',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крововтрата',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 141
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 63-х років, що багато років страждав на атеросклероз і переніс раніше інфаркт міокарда, розвинувся напад загрудинного болю. Хворий госпіталізований, через 3 дні, на фоні прогресуючої серцево-судинної недостатності, помер. Під час розтину тіла у ділянці задньої стінки лівого шлуночка і міжшлуночкової перегородки виявлена ділянка білого кольору близько 3 см у діаметрі, волокниста, западаюча, з чіткою межею. Прозектор трактував ці зміни як:',
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
    'Інфаркт міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ішемія міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофія міокарда',
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
  -- Питання 142
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінці 54-х років поставили попередній діагноз: інфаркт міокарда. Характерною ознакою даного захворювання є суттєве підвищення в крові активності такого ферменту:',
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
    'Г-6-ФДГ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокіназа',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каталаза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргіназа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альфа-амілаза',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 143
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 58-ми років помер від прогресуючої серцевої недостатності. На розтині: серце розширене у поперечнику, мляве, м’яз на розрізі нерівномірного кровонаповнення, пістрявий. При гістологічному дослідженні: у міокарді повнокров’я, у стромі лімфогістіоцитарні інфільтрати, що розсувають кардіоміоцити. Виявлені морфологічні зміни свідчать про:',
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
    'Венозне повнокров’я',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негнійний проміжний міокардит',
    true,
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
    'Кардіосклероз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирову дистрофії міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 144
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого, який скаржився на біль у ділянці лівої лопатки, був діагностований інфаркт міокарду. Назвіть вид болю у хворого?',
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
    'Перший (протопатичний)',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фантомний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеральний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Другий (епікритичний)',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іррадіюючий (відбитий)',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 145
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий помер від прогресуючої серцевої недостатності. На розтині серце розширене у поперечнику, мляве, м’яз на розрізі нерівномірного кровонаповнення, пістрявий, при гістологічному дослідженні у міокарді повнокров’я, у стромі лімфогістіоцитарні інфільтрати, що розсувають кардіоміоцити. Виявлені морфологічні зміни свідчать про:',
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
    'Негнійний проміжний міокардит',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кардіосклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Венозне повнокрів’я',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирову дистрофії міокарда',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 146
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення доставлений хворий з діагнозом: гострий інфаркт міокарда. Для усунення больового синдрому (нейролептанальгезії) пацієнту необхідно ввести таку комбінацію лікарських препаратів:',
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
    'Аміназин + діазепам',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анальгін + піпольфен',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морфін + атропін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ношпа + димедрол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроперидол + фентаніл',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 147
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на гострий інфаркт міокарда у комплексній терапії було призначено гепарин. Через деякий час після введення даного препарату з’явилась гематурія. Який антагоніст гепарину необхідно ввести хворому для усунення даного ускладнення?',
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
    'Амінокапронова кислота',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протаміну сульфат',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноген',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неодикумарин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вікасол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 148
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До кардіологічного відділення надійшов хворий з інфарктом міокарда. Для усунення болю було вирішено потенціювати дію фентаніла нейролептиком. Який з перерахованих нейролептиків найбільш придатний для проведення нейролептаналгезії?',
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
    'Трифтазін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульпірид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дроперидол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галоперидол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміназин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 149
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому, який переніс інфаркт міокарда, призначена ацетилсаліцилова кислота по 75 мг щоденно. З якою метою призначено препарат?',
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
    'Зменшення агрегації тромбоцитів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження температури',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення болю',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення запалення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розширення коронарних судин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 150
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У клініці для лікування інфаркту міокарда пацієнту введено ембріональні стовбурові клітини, що одержано шляхом терапевтичного клонування в цього ж пацієнта. Як називається цей вид трансплантації?',
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
  -- Питання 151
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий помер при явищах серцево-судинної недостатності. Результати розтину: післяінфарктний кардіосклероз, гіпертрофія міокарда і дилятація його порожнин, особливо правого шлуночка. Печінка збільшена, з гладенькою поверхнею, на розрізі повнокровна, з темно-червоними крапками на буруватому фоні тканини. Гістологічно: повнокров’я центральних відділів часточок; у периферичних відділах навколо портальних трактів - гепатоцити у стані жирової дистрофії. Як називаються описані вище зміни печінки?',
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
    'Стеатоз печінки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цироз печінки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Несправжньомускатна печінка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мускатна печінка',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 152
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До відділення реанімації надійшов чоловік 47-ми років з діагнозом інфаркт міокарду. Яка з фракцій лактатдегідрогенази (ЛДГ) буде переважати в сироватці крові протягом перших двох діб?',
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
    'ЛДГ2',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ4',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ3',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ5',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ЛДГ1',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 153
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Тромбоз коронарної артерії спричинив розвиток інфаркту міокарда. Які механізми ушкодження кардіоміоцитів є домінуючими при цьому захворюванні?',
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
    'Ліпідні',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидотичні',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кальцієві',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Електролітно-осмотичні',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протеїнові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 154
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині померлої в комі молодої людини виявлено поширений тромбоемболічний інфаркт лівої півкулі мозку, велика септична селезінка, імунокомплексний гломерулонефрит, виразки в стулках аортального клапана, прикриті поліпоподібними тромбами з колоніями стафілококів. Яке захворювання викликало церебральну тромбоемболію?',
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
    'Септицемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септичний бактеріальний ендокардит',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септикопіємія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий ревматичний вальвуліт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ревматичний тромбоендокардит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 155
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Трансмуральний інфаркт міокарда у хворого ускладнився розвитком гострої лівошлуночкової недостатності. Що є найбільш типовим для цього стану?',
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
    'Набряк кінцівок',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Артеріальна гіпертензія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Набряк легенів',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ціаноз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 156
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого інфаркт міокарда в області передньої стінки лівого шлуночка. У басейні якої артерії виникло порушення кровообігу?',
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
    'Передньої міжшлуночкової гілки лівої вінцевої артерії',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передсердно-шлуночкових гілок лівої вінцевої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передніх шлуночкових гілок правої вінцевої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лівої крайової гілки лівої вінцевої артерії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Огинаючої гілки лівої вінцевої артерії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 157
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з гострим інфарктом міокарда внутрішньовенно крапельно введено 1500 мл різних розчинів в протягом 8 годин, кисень інтраназально. Смерть наступила від набряку легенів. Що стало причиною набряку легенів?',
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
    'Інгаляція кисню',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейрогенная реакція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаження лівого шлуночка об''ємом',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення онкотичного тиску за рахунок гемодилюції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алергічна реакція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 158
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 45 років після значного психоемоційного навантаження несподівано з''явився стискаючий біль в області серця з іррадіацією в ліву руку, шию, під ліву лопатку. Особа стала бліда, покрилася холодним потім. Нітрогліцерин зняв напад болю. Який процес розвинувся у хворого?',
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
    'Стенокардія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсульт',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Психогенний шок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перфорація виразки шлунка',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 159
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого інфаркт передньої стінки лівого шлуночка. У басейні якої судини виникло порушення кровообігу?',
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
    'Лівої крайової гілки лівої вінцевої артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Задньої міжшлуночкової гілки правої вінцевої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передсердно - шлуночкових гілок правої вінцевої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Огинаючої гілки і лівої вінцевої артерії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передньої міжшлуночкової гілки лівої вінцевої артерії',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 160
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого діагностовано гострий інфаркт міокарду, який супроводжується стійкими болями за грудиною. Неефективність попередньо введених препаратів дала підставу лікарю провести нейролептанальгезію. Який нейролептик використовується для цього виду знеболення?',
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
    'Дроперидол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галоперидол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Резерпін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метеразин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміназин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 161
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий помер від інфаркту міокарда. При патогістологічному дослідженні міокарда виявлені значні контрактурні зміни в кардіоміоцитах. Це обумовлено нагромадженням в кардіоміоцитах іонів:',
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
    'Водню',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хлора',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Магнію',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кальцію',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 162
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гепатиті, інфаркті міокарда в плазмі крові хворих різко зростає активність аланін - і аспартатамінотрансферази. Які причини зростання активності цих ферментів в крові?',
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
    'Збільшення активності ферментів гормонами',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження мембран клітин і вихід ферментів у кров',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нестача піридоксину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зростання швидкості синтезу амінокислот у тканинах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення швидкості розпаду амінокислот в тканинах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 163
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Активність якого ферменту підвищується в крові пацієнта під час інфаркту міокарда?',
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
    'Креатинфосфокінази МВ',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карбамоілфосфатсинтетази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази ММ',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лужної фосфатази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Креатинфосфокінази ВВ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 164
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В ході розтину тіла чоловіка у віці 40 років у третьому сегменті правої легені субплеврально було виявлено ділянку ущільнення діаметром 1,5 см, з чіткими межами, оточену білуватою волокнистою тканиною, з крихкими ділянками біло-жовтого кольору на розрізі. Для чого є характерною наявність такого осередка?',
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
    'Хондроми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Периферичного раку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інкапсульованого первинного афекту',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркту легені, який організується',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фіброми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 165
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гострому інфаркті в міокарді виникає декілька зон в осередку інфаркту: зона некрозу, зона ішемічного пошкодження і зона ішемії. Зоні пошкодження на ЕКГ відповідає:',
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
    'Зниження зубця R',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глибокий зубець Q',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Негативний зубець T',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплекс QRS типу QS',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зміщення сегменту RS — T вище ізолінії',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 166
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який півтора місяця тому назад переніс інфаркт міокарда, діагностований синдром Дреслера з характерною тріадою: перикардит, плеврит, пневмонія. Причиною його розвитку вважається:',
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
    'Зниження резистентності до інфекційних агентів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтоксикація організму продуктами некрозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація сапрофітної мікрофлори',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Викид в кров міокардіальних ферментів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сенсибілізація організму антигенами міокарда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 167
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 45-ти років після значного психоемоційного навантаження раптово з’явився стискаючий біль у ділянці серця з іррадіацією в ліву руку, шию, під ліву лопатку. Обличчя стало блідим, вкрилося холодним потом. Нітрогліцерин усунув напад болю. Який процес розвинувся у хворого?',
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
    'Інфаркт міокарда',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перфорація виразки шлунка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Психогенний шок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інсульт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стенокардія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 168
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з гострим інфарктом міокарда внутрішньовенно крапельно введено 1500 мл різних розчинів протягом 8 годин, кисень інтраназально. Смерть настала від набряку легень. Що спричинило набряк легень?',
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
    'Інгаляція кисню',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алергічна реакція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейрогенна реакція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перевантаження лівого шлуночка об''ємом',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення онкотичного тиску за рахунок гемодилюції',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 169
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 75-ти років, який довгий час страждав на атеросклероз церебральних судин, на аутопсії в правій тім’яно-скроневої ділянці головного мозку виявлено вогнище неправильної форми, млявої консистенції, сірого кольору. Яка найбільш вірогідна причина розвитку цього процесу?',
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
  -- Питання 170
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 55 років прооперований із приводу гострого апендициту. 3а 5 днів після підняття з ліжка відчув нестачу повітря. У нього розвинувся різкий ціаноз обличчя. Пацієнт втратив свідомість. Після безрезультатної реанімації була констатовано смерть. На розтині виявлено тромбоемболію легеневого стовбура. Яке ймовірне джерело тромбоемболії?',
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
    'Тромбоз брижових артерій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кулястий тромб передсердя',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз у лівому шлуночку серця',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз ворітної вени',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз вен нижніх кінцівок',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 171
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 55 років прооперований із приводу гострого апендициту. На 5-ту добу, піднявшись із ліжка, відчув брак повітря. У нього розвинувся різкий ціаноз обличчя. Пацієнт втратив свідомість. Після безрезультатної реанімації констатована смерть. На розтині виявлена тромбоемболія легеневого стовбура. Що могло бути найімовірнішим джерелом тромбоемболії?',
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
    'Тромбоз брижових артерій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кулястий тромб передсердя',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз ворітної вени',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз у лівому шлуночку серця',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз вен нижніх кінцівок',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 172
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час огляду чоловіка віком 76 років виявлено моторну афазію. Із анамнещу відомо, що два дні тому виник тромбоз судин головного мозку. Де локалізований осередок пошкодження?',
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
    'Центр Верніке',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кутова звивина',
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
    'Центр Брока',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Звивина Гешля',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 173
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час огляду чоловіка віком 76 років виявлено сенсорну афазію. Із анамнезу відомо, що два дні тому виник тромбоз судин головного мозку. Де локалізований осередок пошкодження?',
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
    'Постцентральна звивина',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Центр Верніке',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Звивина Гешля',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кутова эвивина',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Центр Брока',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 174
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні звернулася жінка віком 71 рік, яка після прийому ацетилсаліцилової кислоти, що вживає з метою профілактики тромбозу, відчула такі симтоми: гострий біль в епігастрії, нудоту, печію, закрепи. Лікар діагностував виразку шлунка. Який механізм ульцерогенної дії ацетилсаліцилової кислоти лежить в основі розвитку виразки у цієї пацієнтки?',
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
    'Активація входження Са +в клітини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення утворення простагландинів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення синтезу фосфоліпази А2',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення синтезу шлункового соку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення утворення лейкотрієнів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 175
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 36-ти років одразу після перенесеного стафілококового сепсису з’явилися напади стенокардії. За допомогою коронарографії в лівій коронарній артерії було виявлено пристінковий тромбоз без ознак атеросклерозу. Утворення тромбу розпочалося внаслідок пошкодження ендотелію судини і вивільнення:',
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
  -- Питання 176
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік з кесонною хворобою помер з ознаками гострих порушень мозкового кровообігу в басейні a. meningea media лівої півкулі головного мозку. На розтині в зазначеній ділянці виявлено вогнище сірого розм''якшення мозку розмірами 6х7х3,4 см. Визначте характер процесу, що призвів до смерті людини:',
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
    'Тромбоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова емболія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз судин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 177
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На аутопсії жінки, яка померла від гострого інфаркту міокарда, у вені лівої гомілки виявлений тромб. При мікроскопічному дослідженні тромба виявлено, що він заміщений сполучною тканиною, в якій відзначається дифузне відкладення солей кальцію. Дайте назву такому результату тромбозу:',
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
    'Петрифікація',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Організація і каналізація',
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
    'Септичний аутоліз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Асептичний аутоліз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 178
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для попередження тромбозів використовують антикоагулянти. Визначте прямий антикоагулянт.',
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
    'Кислота ацетилсаліцилова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тіклопідин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вінпоцетін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Папаверину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 179
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після крововиливу у ліву півкулю головного мозку пацієнт втратив здатність говорити, У басейні якої артерії відбувся тромбоз?',
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
    'Arteria cerebri media',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Arteria cerebri posterior',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Arteria communicans anterior',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Arteria communicans posterior',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Arteria cerebri anterior',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 180
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для лікування тромбозу лікар призначив хворому препарат з групи антикоагулянтів прямої дії. Назвіть цей препарат:',
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
    'Гепарин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вікасол (Менадіон)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілін (Феніндіон)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Варфарин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синкумар (Аценокумарол)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 181
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гострого тромбозу показана антикоагулянтна терапія. Назвіть антикоагулянт прямої дії, який застосовується в разі загрози тромбозу.',
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
    'Гепарин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фраксипарин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дипіридамол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Варфарин',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 182
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Препарат з якої фармакологічної групи необхідно призначити хворому, що переніс інфаркт міокарда, для профілактики тромбозу?',
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
    'Блокатори протонної помпи',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемостатичні засоби',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міорелаксанти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антикоагулянти непрямої дії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Наркотичні анальгетики',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 183
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта виявлено сліпоту кіркового походження. Тромбоз якої артерії в нього розвинувся?',
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
    'Задньої сполучної',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Середньої мозкової',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передньої мозкової',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Задньої мозкової',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Передньої ворсинчастої',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 184
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після механічної травми хворому наклали джгут на руку, щоб зупинити кровотечу. Нижче джгута рука зблідла, з’явилося відчуття оніміння. Цей стан є наслідком:',
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
    'Венозного застою',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ангіоспастичної ішемії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Обтураційної ішемії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компресійної ішемії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 185
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На секції виявлено: множинні геморагічні інфаркти легень, у деяких судинах легень буруватого кольору щільні маси, які не прикріплені до стінки судин, варикозне розширення вен нижніх кінцівок, у яких наявні тромби. Про який патологічний процес йдеться?',
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
    'Тканинна емболія легеневої артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія легеневої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Застійний тромбоз легеневої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія легеневої артерії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Геморагічна бронхопневмонія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 186
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час лапаротомії хірург виявив гангренозне ураження низхідної ободової кишки. Тромбоз якої артерії зумовив цей стан?',
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
    'Клубово-ободова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Права ободова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серединна ободова',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліва ободова',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Верхня брижова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 187
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Тромбоз коронарної артерії спричинив розвиток інфаркту міокарда. Які механізми ушкодження кардіоміоцитів є домінуючими при цьому захворюванні?',
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
    'Ліпідні',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацидотичні',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кальцієві',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Електролітно-осмотичні',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протеїнові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 188
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого тромбоз коронарних судин. Необхідно введення речовини, що відновлює їх прохідність. Яка з перелічених речовин має необхідні властивостями?',
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
    'Пентоксифілін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептокіназа',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетилсаліцилова кислота',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 189
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження аутопсійного матеріалу від померлої вагітної жінки в мікроциркуляторному руслі легень виявлено клітини плоского епітелію шкіри ембріона, пушкове волосся, казеозну змазку і муцини з травного тракту ембріона. Також в легенях визначається набряк, дифузне ушкодження альвеол та системний тромбоз фібриновими тромбами. Який вид емболії розвинувся у жінки?',
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
    'Тромбоемболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амніотична',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повітряна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 190
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 70-ти років атеросклероз ускладнився тромбозом судин нижніх кінцівок, виникла гангрена пальців лівої стопи. Початок тромбоутворення, найбільш вірогідно, пов’язаний з:',
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
  -- Питання 191
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 59-ти років, директора підприємства, після перевірки податкової інспекції з’явився інтенсивний пекучий біль, локалізований за грудниною, який іррадіює в ліву руку. Через 15 хвилин стан хворого нормалізувався. Який можливий механізм стенокардії є провідним у цього хворого?',
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
    'Підвищення у крові рівня катехоламінів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Внутрішньосудинна агрегація формених елементів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Функціональне перевантаження серця',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз коронарних судин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз коронарних судин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 192
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на тромбофлебіт нижніх кінцівок з’явився біль у грудній клітці, кровохаркання, наростаюча дихальна недостатність, при явищах якої він помер. На розтині діагностовано множинні інфаркти легень. Яка найбільш вірогідна причина їх розвитку в цьому випадку?',
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
    'Тромбоз гілок легеневої артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія гілок легеневої артерії',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія бронхіальних артерій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз бронхіальних артерій',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз легеневих вен',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 193
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після накладання джгута у досліджуваного виявили точкові крововиливи. З порушенням функції яких клітин крові це пов’язано?',
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
    'Нейтрофіли',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцити',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфоцити',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моноцити',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 194
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У препараті червоного кісткового мозку людини визначаються скупчення гігантських клітин, що знаходяться в тісному контакті з синусоїдними капілярами. Які формені елементи крові утворюються з цих клітин?',
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
    'Лімфоцити',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоцити',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроцити',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцити',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Моноцити',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 195
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Плазмові фактори згортання крові зазнають посттрансляційної модифікації за участю вітаміну K. Як кофактор, він потрібен у ферментній системі у-карбоксилювання білкових факторів коагуляції крові, завдяки збільшенню спорідненості їх молекул з іонами кальцію. Яка амінокислота карбоксилюється в цих білках?',
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
    'Валін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргінін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілаланін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глутамінова',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 196
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні хворого на гемофілію виявлено зміну деяких показників крові. Яка з перерахованих ознак відповідає цьому захворюванню?',
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
    'Еозинофілія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Афібриногенемія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Час згортання крові вповільнений',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоцитопенія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроцитоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 197
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностовано гемофілію А. Дефіцит якого фактора згортання крові є причиною цієї патології?',
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
    'XII',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IX',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'V, X',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'I, II',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'VIII',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 198
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?',
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
    'Концентрації фібриногену',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активованого часткового тромбопластинового часу (коректна відповідь)',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міжнародного нормалізованого відношення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ШОЕ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протромбінового часу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 199
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Восьмирічній дитині рекомендовано проведення тонзилектомії. Лабораторний аналіз крові виявив, що час згортання крові збільшено до 7 хвилин. Який лікарський засіб треба призначити дитині для зменшення крововтрати під час операції?',
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
    'Дицинон',
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
    'Кальцію хлорид',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вікасол',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінокапронову кислоту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 200
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Застосування антикоагулянтного засобу викликало крововиливи на слизових оболонках, макрогематурію, зменшення часу згортання крові. Введення протаміну сульфату усунуло ці порушення. Який засіб було призначено?',
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
    'Гепарин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вікасол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринолізин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію цитрат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неодикумарин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 201
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики та лікування тромбозу застосовуються засоби, що знижують згортання крові (антикоагулянти). Укажіть антикоагулянт, у разі передозування якого застосовують як антагоніст протаміну сульфат:',
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
    'Натрію гідроцитрат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синкумар',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепарин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неодикумарин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 202
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з опіковою хворобою як ускладнення розвинувся ДВЗ-синдром. Яку стадію ДВЗ-синдрому можна припустити, якщо відомо, що час згортання крові хворого за Лі-Уайтом становить менше, ніж 3 хвилини?',
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
    'Перехідну',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Термінальну',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринолізу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперкоагуляції',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпокоагуляцїї',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 203
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 37-ми років на фоні тривалого застосування антибіотиків спостерігається підвищена кровоточивість при невеликих пошкодженнях. У крові - зниження активності факторів згортання крові ІІ, VII, IX, X, подовження часу згортання крові. Недостатністю якого вітаміну обумовлені зазначені зміни?',
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
    'Вітамін А',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін D',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін С',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін Е',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін К',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 204
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відомо, що введення в організм людини лікарського препарату дикумаролу викликає різке зниження в крові вмісту протромбіну і ряду інших білкових факторів згортання крові. Антивітаміном якого вітаміну є дикумарол?',
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
    'Вітамін P',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін K',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін E',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін H',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін C',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 205
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого спостерігаються геморагії, в крові знижена концентрація протромбіну. Недостатність якого вітаміну призвела до порушення синтезу цього фактору згортання крові?',
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
    'D',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'C',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'A',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'K',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'E',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 206
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт страждає на геморагічний синдром, що проявляється частими носовими кровотечами, посттравматичними та спонтанними внутрішньошкірними та внутрішньосуглобовими крововиливами. Після лабораторного обстеження було діагностовано гемофілію В. Дефіцит якого фактора згортання крові обумовлює дане захворювання?',
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
    'V',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IX',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'XI',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'VIII',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'VII',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 207
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Плазмові фактори згортання крові зазнають посттрансляційної модифікації за участю вітаміну K. Як кофактор, він потрібен у ферментній системі у-карбоксилювання білкових факторів коагуляції крові, завдяки збільшенню спорідненості їх молекул з іонами кальцію. Яка амінокислота карбоксилюється в цих білках?',
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
    'Валін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аргінін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенілаланін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глутамінова',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 208
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для запобігання післяопераційної кровотечі 6-ти річній дитині рекомендовано приймати вікасол, який є синтетичним аналогом вітаміну K. Вкажіть, які посттрансляційні зміни факторів згортання крові активуються під впливом вікасолу?',
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
    'Фосфорилювання радикалів серину',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карбоксилювання глутамінової кислоти',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Частковий протеоліз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глікозилювання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Полімеризація',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 209
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 36-ти років одразу після перенесеного стафілококового сепсису з’явилися напади стенокардії. За допомогою коронарографії в лівій коронарній артерії було виявлено пристінковий тромбоз без ознак атеросклерозу. Утворення тромбу розпочалося внаслідок пошкодження ендотелію судини і вивільнення:',
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
  -- Питання 210
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині раптово померлого чоловіка віком 50 років у загальному стовбурі легеневої артерії виявлені вільно розташовані, щільні червоного кольору червоподібні маси з тьмяною поверхнею. Яка найімовірніша причина раптової смерті пацієнта?',
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
    'Мікробна емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна емболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія сторонніми масами',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія легеневої артерії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 211
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 75-ти років був оперований з приводу рака передміхурової залози, помер раптово на 4-ту добу після оперативного втручання. При розтині тіла померлого у просвітах головного стовбура і біфуркації легеневої артерії були виявлені і легко видалені крихкі маси темно-червоного кольору з тьмяною поверхнею. Такі ж маси знаходились у порожнині правого шлуночка серця. Який різновид порушення кровообігу призвів до раптової смерті хворого?',
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
    'Парадоксальна емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт міокарда',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз легеневої артерії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія легеневої артерії',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 212
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на тромбофлебіт нижніх кінцівок з’явився біль у грудній клітці, кровохаркання, наростаюча дихальна недостатність, при явищах якої він помер. На розтині діагностовано множинні інфаркти легень. Яка найбільш вірогідна причина їх розвитку в цьому випадку?',
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
    'Тромбоз гілок легеневої артерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія гілок легеневої артерії',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія бронхіальних артерій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз бронхіальних артерій',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз легеневих вен',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 213
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої, яка страждає на тромбофлебіт глибоких вен гомілки, раптово настала смерть. На розтині трупа у загальному стовбурі і біфуркації легеневої артерії знайдено червоні пухкі маси з тьмяною гофрованою поверхнею, що лежать вільно. Який патологічний процес виявив патологоанатом?',
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
    'Жирова емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Емболія стороннім тілом',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 214
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з тромбофлебітом нижніх кінцівок раптово після навантаження виникли задишка, різкий біль у грудях, ціаноз, набухання шийних вен. Яке найбільш імовірне порушення кровообігу виникло у хворого?',
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
    'Тромбоемболія ворітної вени',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія судин головного мозку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія легеневої артерії',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія мезентеріальних судин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія вінцевих судин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 215
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на тромбофлебіт нижніх кінцівок з’явився біль у грудній клітці, кровохаркання, наростаюча дихальна недостатність, при явищах якої він помер. На розтині діагностовано множинні інфаркти легень. Яка найбільш вірогідна причина їх розвитку в цьому випадку?',
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
    'Тромбоз бронхіальних артерій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз легеневих вен',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія бронхіальних артерій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія гілок легеневої артерії',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз гілок легеневої артерії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 216
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік з кесонною хворобою помер з ознаками гострих порушень мозкового кровообігу в басейні a. meningea media лівої півкулі головного мозку. На розтині в зазначеній ділянці виявлено вогнище сірого розм''якшення мозку розмірами 6х7х3,4 см. Визначте характер процесу, що призвів до смерті людини:',
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
    'Тромбоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова емболія',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклероз судин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 217
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 27-ми років з політравмою (закрита травма грудної клітини, закритий перелом правого стегна) через дві години після проведення скелетного витягнення різко погіршився стан і, на фоні гострої легенево-серцевої недостатності, настала смерть. При гістологічному дослідженні кровоносних судин легень та головного мозку померлого, при забарвленні суданом ІІІ, виявлені краплі помаранчевого кольору, які закупорюють просвіт судин. Яке ускладнення політравми розвинулося у хворого?',
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
    'Мікробна емболія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Повітряна емболія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 218
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час внутрішньовенної трансфузії фізіологічним розчином стан хворого різко погіршився і на фоні гострої ядухи настала смерть. При розтині померлого виявлено гостре венозне повнокров''я внутрішніх органів з різко розширеними правими відділами серця. При проколі правого шлуночка під водою виявляються пухирці. Який патологічний процес та його вид виник у хворого?',
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
    'Повітряна емболія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоемболія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова емболія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ГІазова емболія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна емболія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 219
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 55 років прооперований із приводу гострого апендициту. На 5-ту добу, піднявшись із ліжка, відчув брак повітря. У нього розвинувся різкий ціаноз обличчя. Пацієнт втратив свідомість. Після безрезультатної реанімації констатована смерть. На розтині виявлена тромбоемболія легеневого стовбура. Що могло бути найімовірнішим джерелом тромбоемболії?',
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
    'Тромбоз брижових артерій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кулястий тромб передсердя',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз ворітної вени',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз у лівому шлуночку серця',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тромбоз вен нижніх кінцівок',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 220
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?',
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
  -- Питання 221
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження стінки аорти виявлено велику кількість ксантомних клітин, які розташовані переважно в інтимі. Для якого захворювання це характерно?',
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
    'Нодозного періартеріїту',
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
  -- Питання 222
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла хворого, що помер від серцевої недостатності, в інтимі аорти і коронарних судин виявлені жовтого кольору плями і смуги, що вибухають над поверхнею інтими сірувато-жовтуваті бляшки, а також вогнищеве виразкування даних бляшок з наявністю крововиливів, тромбозів і вогнищ звапнування. Для якого захворювання характерні вказані зміни судин?',
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
    '-',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертонічна хвороба',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 223
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження стінки аорти виявлено велику кількість ксантомних клітин, які розташовані переважно в інтимі. Для якого захворювання це характерно?',
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
  -- Питання 224
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гістологічному дослідженні стінки аорти виявлено велику кількість ксантомних клітин, розташованих переважно в інтимі. При якому захворюванні можлива така картина?',
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
  -- Питання 225
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?',
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
  -- Питання 226
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після курсу лікування атеросклерозу в плазмі крові лабораторно доведено збільшення рівня антиатерогенної фракції ліпопротеїнів. Збільшення рівня яких ліпопротеїнів підтверджує ефективність терапії захворювання?',
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
  -- Питання 227
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Відповідно до сучасної концепції атерогенезу «Response to injury», атеросклероз є проявом хронічного запалення в інтимі артерій. З якою стадією запалення пов’язане формування фіброзних бляшок у разі атеросклерозу?',
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
  -- Питання 228
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця та порушень мозкового кровообігу людина повинна одержувати 2-6 г незамінних поліненасичених жирних кислот на добу. Ці кислоти необхідні для синтезу:',
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
  -- Питання 229
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?',
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
  -- Питання 230
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Серед антиатеросклеротичних препаратів, що застосовуються з метою профілактики та лікування атеросклерозу, є левастатин. Він діє шляхом:',
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
    'Усіма наведеними шляхами',
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
    'Активації метаболізму холестерину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення всмоктування холестерину в кишківнику',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування біосинтезу холестерину',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 231
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині трупа чоловіка 47-ми років, померлого раптово, в інтимі черевного відділу аорти знайдені осередки жовтого кольору у вигляді плям та смуг, що не вибухають над поверхнею інтими. При фарбуванні суданом III спостерігається жовтогаряче забарвлення. Для якої стадії атеросклерозу характерні такі зміни?',
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
  -- Питання 232
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця, порушень мозкового кровообігу рекомендується споживання жирів із високим вмістом поліненасичених жирних кислот. Однією з таких жирних кислот є:',
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
  -- Питання 233
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Сучасні антиатеросклеротичні препарати застосовуються з метою профілактики та лікування атеросклерозу. Такі препарати як гемфіброзил та фенфібрат гальмують біосинтез холестерину шляхом інгібування ферменту:',
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
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацилтрансфераза',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 234
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для профілактики атеросклерозу, ішемічної хвороби серця, порушень мозкового кровообігу рекомендується споживання жирів із високим вмістом поліненасичених жирних кислот. Однією з таких жирних кислот є:',
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
  -- Питання 235
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 58-ми років хворіє на атеросклероз судин головного мозку. При обстеженні виявлена гіперліпідемія. Вміст якого класу ліпопротеїдів у сироватці крові даного чоловіка найбільш вірогідно буде підвищений?',
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
  -- Питання 236
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?',
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
  -- Питання 237
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У процесі онтогенезу у людини на організменному рівні проявилися наступні зміни: зменшилася життєва ємність легень, збільшився артеріальний тиск, розвинувся атеросклероз. Який період онтогенезу найбільш вірогідний у цьому випадку?',
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
  -- Питання 238
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину трупа жінки 69 років підвищеного живлення, яка померла від гострого інфаркту міокарда, в інтимі коронарних артерій знайдені численні білуваті, щільні, вибухаючі формування, що різко звужують просвіт судин. Для якої стадії атеросклерозу властиві такі зміни?',
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
  -- Питання 239
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки, що хворіє на остеохондроз, з’явився різкий біль у плечовому суглобі, який посилювався при відведенні плеча. Ураження якого нерва може бути причиною цих симптомів?',
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
    'Підлопатковий нерв',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пахвовий нерв',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дорсальний нерв лопатки',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Грудо-спинний нерв',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підключичний нерв',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 240
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка, що хворіє на остеохондроз, з’явився різкий біль у м’язах живота (бічних та передніх). При об’єктивному обстеженні лікар констатував підвищену больову чутливість шкіри підчеревної ділянки. Ураження якого нерва могло спричинити цій біль?',
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
    'Затульний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стегновий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клубово-підчеревний',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сідничний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Статево-стегновий',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 241
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 49-річної жінки після видалення лімфатичних вузлів правої аксилярної ділянки з приводу раку грудної залози через півроку виявлено збільшення правої верхньої кінцівки в об’ємі та значне її ущільнення, гладка та напружена шкіра, через щілиноподібні дефекти якої на поверхню витікає прозора рідина. Діагностуйте вид порушення лімфообігу:',
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
    'Хронічна вроджена місцева лімфедема',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічна загальна лімфедема',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра загальна лімфедема',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гостра місцева лімфедема',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічна набута місцева лімфедема',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 242
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 49-ти років після тривалого стояння виявлено набряк ніг. Назвіть можливу причину появи набряків:',
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
    'Підвищення гідростатичного тиску крові у венах',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення онкотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення артеріального тиску',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення гідростатичного тиску крові в артеріях',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення гідростатичного тиску крові у венах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 243
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з патологією серцево-судинної системи розвинулися набряки на нижніх кінцівках. Який механізм розвитку серцевого набряку?',
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
    'Зниження осмотичного тиску плазми крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в артеріолах',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в венулах',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення лімфовідтоку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 244
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 56 років з серцевою недостатністю спостерігається набряк стоп та гомілок, шкіра в місці набряку бліда і холодна. Яка провідна ланка патогенезу набряку у цього хворого?',
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
    'Підвищення проникливості капілярів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Позитивний водний баланс',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в венулах',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення онкотичного тиску в капілярах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення лімфовідтоку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 245
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнтки віком 49 років після тривалого стояння набрякли ноги. Яка ймовірна причина виникнення набряків?',
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
    'Підвищення гідростатичного тиску крові у венах',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення гідростатичного тиску крові у венах',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення онкотичного тиску плазми крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '3меншення гідростатичного тиску крові в артеріях',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення артеріального тиску',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 246
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з діагнозом: серцева недостатність, розвинулися набряки на нижніх кінцівках. Який механізм розвитку серцевого набряку?',
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
    'Підвищення гідростатичного тиску в венулах',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження осмотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення лімфовідтоку',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в артеріолах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску плазми крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 247
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 56 років із серцевою недостатністю спостерігається набряк стоп та гомілок, шкіра в місці набряку бліда і холодна. Яка провідна ланка патогенезу набряку у хворого?',
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
    'Порушення лімфовідтоку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності капілярів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в венулах',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Позитивний водний баланс',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення онкотичного тиску в капілярах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 248
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з патологією серцево-судинної системи розвинулись набряки на нижніх кінцівках. Який механізм розвитку серцевого набряку?',
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
    'Порушення лімфовідтоку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в венулах',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження осмотичного тиску плазми крові',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в артеріолах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску плазми крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 249
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 30 років, який шпиталізований із діагнозом: гострий гломерулонефрит – спостерігалася протеїнурія. Яке порушення спричинило це явище?',
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
    'Зниження онкотичного тиску крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску на стінку капілярів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності клубочкової мембрани',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження кількості нефронів,що функціонують',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Затримка виведення продуктів азотистого обміну',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 250
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта протягом доби спостерігалася гіпотензія (АТ 85/50 мм рт. Ст), яка супроводжувалася зменшенням діурезу. Яка найімовірніша причина олігоурії?',
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
    'Збільшення канальцевої реабсорбий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення канальцевої реабсорбції',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення канальцевої секреції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження гідростатичного тиску крові',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 251
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 58 років із кардіогенним шоком спостерігалося зменшення добової кількості сечі — олігурія. Який механізм цього явища?',
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
    'Зниження клубочкової фільтрації',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску на стінку капілярів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження проникності клубочкової мембрани',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження кількості функціональних клубочків',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 252
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінку віком 32 роки вжалила оса. На місці укусу виникли набряк і гіперемія. Який механізм набряку є первинним у цьому разі?',
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
    'Утруднення лімфовідтоку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності капілярів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканинної рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску крові в капілярах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 253
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої, яка страждає на поліноз, після поїздки за місто з''явилися набряки губ і повік, сльозотеча, виділення з носа, печіння в очах. Який основний механізм розвитку цього набряку?',
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
    'Підвищення онкотичного тиску крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності капілярів',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в капілярах',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення лімфовідтоку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 254
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 30 років, який шпиталізований із діагнозом: гострий гломерулонефрит, спостерігалася протеїнурія. Яке порушення спричинило це явище?',
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
    'Зниження кількості нефронів, що функціонують',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Затримка виведення продуктів азотистого обміну',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності клубочкової мембрани',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску на стінку капілярів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 255
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мама одинадцятирічної дівчинки скаржиться на слабкість та набряклість обличчя її дитини уродовж 3-х днів, хоча до цього вона завжди була здоровою та активною. Під час фізикального обстеження виявлено генералізований набряк обличчя, якщо натискати на набряк нижніх кінцівок, залишається ямка, яка поступово згладжується. Під час збору анамнезу дівчинка зазначає пінистий вигляд сечі, але заперечує домішки крові у сечі, ніктурію або біль під час сечовиділення. Лабораторні дослідження виявили протеїнурію та мікрогематурію. Що з нижченаведеного є ймовірною причиною змін у лабораторному аналізі сечі?',
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
    'Підвищення гідростатичного тиску в клубочку',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в капсулі Шумлянського-Боумена',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності стінки клубочкового капіляра',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 256
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчинка 11 років прийшла на прийом до лікаря із мамою, яка скаржиться на слабкість та набряклість обличчя її дитини протягом 3 днів. Мати стверджує, що до початку симптомів її дитина завжди була здоровою та активною. Під час фізикального обстеження виявлено генералізований набряк обличчя, якщо натискати на набряк нижніх кінцівок, залишається ямка, яка поступово згладжується. Під час збору анамнезу дівчинка зазначає пінистий вигляд сечі, але заперечує домішки крові у сечі, ніктурію або біль під час сечовиділення. Лабораторні дослідження виявили протеїнурію та мікрогематурію. Що з наведеного є найімовірнішою причиною змін у лабораторному аналізі сечі?',
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
    'Підвищення гідростатичного тиску у капсулі Шумлянського-Боумена',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску у клубочку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникності стінки клубочкового капіляру',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 257
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дівчинки 6-ти років пастозність повік, губ, шиї, слизової оболонки язика виникла після того, як вона з’їла апельсин. Раніше на апельсини виникали висипання на шкірі, свербіння. Який патогенетичний механізм є провідним у розвитку набряку у дівчинки?',
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
    'Підвищення проникності капілярів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску крові в капілярах',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканинної рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення лімфовідтоку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 258
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Введення знеболюючого пацієнту перед екстракцією зуба призвело до розвитку анафілактичного шоку, який супроводжувався розвитком олігурії. Який патогенетичний механізм зумовив зменшення діурезу в даній клінічній ситуації?',
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
    'Зниження гідростатичного тиску в капілярах клубочків',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення онкотичного тиску крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску в капсулі Шумлянського-Боумена',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження клубочкового фільтру',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення кількості функціонуючих нефронів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 259
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 32-х років чотири роки страждає на хронічний гломерулонефрит з нефротичним синдромом. Відзначаються явні набряки на обличчі, в останній час з’явилися набряки на ногах та тулубі. Який із механізмів розвитку набряків найбільш вірогідний у цього хворого?',
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
    'Підвищення гідростатичного тиску крові в капілярах',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Утруднення лімфовідтоку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканинної рідини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення проникливості капілярів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 260
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 58-ми років з гострою серцевою недостатністю спостерігається зменшення добової кількості сечі - олігурія. Який механізм цього явища?',
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
    'Зниження проникності ниркового фільтру',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження кількості функціонуючих клубочків',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження клубочкової фільтрації',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення гідростатичного тиску крові в капілярах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 261
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При повному (з водою) аліментарному голодуванні розвинулись генералізовані набряки. Який з патогенетичних факторів у цьому випадку є провідним?',
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
    'Зниження гідростатичного тиску міжклітинної рідини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження осмотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення осмотичного тиску міжклітинної рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканинної рідини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску плазми крові',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 262
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта протягом доби спостерігалася гіпотензія (АТ 85/50 мм рт. Ст), яка супроводжувалася зменшенням діурезу. Яка найімовірніша причина олігоурії?',
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
    'Збільшення канальцевої реабсорбий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження гідростатичного тиску крові',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення канальцевої секреції',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення канальцевої реабсорбції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 263
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При повному (з водою) аліментарному голодуванні розвинулись генералізовані набряки. Який з патогенетичних факторів у цьому випадку є провідним?',
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
    'Зниження гідростатичного тиску міжклітинної рідини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження осмотичного тиску плазми крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення осмотичного тиску міжклітинної рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підвищення онкотичного тиску тканинної рідини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зниження онкотичного тиску плазми крові',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 264
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 30-ти років виникли набряки обличчя. При обстеженні виявлені протеїнурія (5,87 г/л), гіпопротеїнемія, диспротеїнемія, гіперліпідемія. Для якого стану характерно таке поєднання симптомів?',
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
    'Гостра ниркова недостатність',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний пієлонефрит',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефритичний синдром',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічна ниркова недостатність',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефротичний синдром',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 265
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Унаслідок токсичного ушкодження клітин печінки з порушенням білковосинтезуючої функції у пацієнта спостерігаються різко знижені кількість альбумінів у плазмі крові та онкотичний тиск. Яке явище буде наслідком цих змін?',
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
    'Зменшення діурезу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збільшення темпу діурезу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поява набряків',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення ШОЕ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зменшення густини крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 266
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка швидкість клубочкової фільтрації 80 мл/хв (норма - 125 ± 25 мл/хв). Збільшення якого показника може бути причиною цього?',
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
    'Гідростатичний тиск крові в капілярах клубочків',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нирковий кровотік',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онкотичний тиск плазми крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ефективний фільтраційний тиск',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проникність ниркового фільтру',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 267
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої людини посилений рух води з кровоносних капілярів до тканин, що викликало їх позаклітинний набряк (збільшені розміри м’яких тканин кінцівок, печінки тощо). Зменшення якого параметру гомеостазу є найбільш імовірною причиною розвитку набряку?',
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
    'рН крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онкотичний тиск плазми крові',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематокрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Осмотичний тиск плазми крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'В’язкість крові',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 268
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини внаслідок хронічного захворювання печінки суттєво порушена її білковосинтезуюча функція. До зменшення якого параметру гомеостазу це призведе?',
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
    'Осмотичний тиск',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Щільність крові',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онкотичний тиск плазми крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'pH',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іематокритний показник',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 269
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У зв’язку з крововтратою пацієнту введено 1 л розчину хлориду натрію з концентрацією 150 ммоль/л. Внаслідок цього, насамперед, зменшиться:',
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
    'Осмотичний тиск крові',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Осмотичний тиск міжклітинної рідини',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онкотичний тиск крові',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Осмотичний тиск внутрішньоклітинний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Онкотичний тиск міжклітинної рідини',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 270
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворій 34 років 3 роки тому було встановлено діагноз гломерулонефриту. За останні 6 місяців з''явилися набряки. Що лежить в основі їх розвитку?',
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
    'Гіперальдостеронізм',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення білковоутворюючої функції печінки',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протеїнурія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперосмолярність плазми',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпродукція вазопресину',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 271
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    '3 роки тому хворій 34 років було встановлено діагноз хронічного гломерулонефриту. За останні 6 місяців з’явилися набряки. Що лежить в основі їх розвитку?',
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
    'Гіперосмолярність плазми',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперальдостеронізм',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протеїнурія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення білковоутворюючої функції печінки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперпродукція вазопресину',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 272
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 23-х років після перенесеної ангіни розвинувся сечовий синдром (гематурія, протеїнурія, лейкоцитурія). У пункційній біопсії нирок виявлена картина інтракапілярного проліферативного гломерулонефриту, а електронномікроскопічно виявлені великі субепітеліальні депозити. Який патогенез цього захворювання?',
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
    'Цитотоксична, цитолітична дія антитіл',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атопія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імунокомплексний механізм',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клітинно обумовлений цитоліз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Грануломатоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 273
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтці, у якої наявні протеїнурія, гематурія, набряки і артеріальна гіпертензія, поставлено діагноз: гострий гломерулонефрит. Назвіть алергічні реакції за Кумбсом і Джеллом, які у 80% випадків є причиною гломерулонефриту:',
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
    'Анафілактичні',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імунокомплексні',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперчутливості сповільненого типу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитотоксичні',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стимулювального типу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 274
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який помер від хронічної ниркової недостатності на фоні хронічного гломерулонефриту, нирки зменшені в розмірах, щільної консистенці, капсула знімається складно, оголяючи зернисту поверхню. На розрізі кірковий та мозковий шари тонкі, тканина нирок суха, сірого кольору. Як називаються такі нирки?',
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
    'Амілоїдно-зморщені',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пієлонефротично-зморщені',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атеросклеротично-зморщені',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинно-зморщені',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Первинно-зморщені',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 275
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час мікроскопії нирки патолоанатом виявив, що приблизно у 80% клубочків спостерігається розмноження епітелію зовнішнього листка капсули Шумлянського, що формує «півмісяці». Він дійшов висновку що така картина відповідає:',
    'medium',
    274,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтракапілярному ексудативному гломерулонефриту',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екстракапілярному проліферативному (швидкопрогресуючому) гломерулонефриту',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібропластичному гломерулонефриту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Екстракапілярному ексудативному гломерулонефриту',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтракапілярному проліферативному гломерулонефриту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 276
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки впродовж року прогресувала ниркова недостатність, що призвело до смерті. Під час розтину тіла померлої виявлено великі строкаті нирки з червоними дрібними краплями в жовто-сірому кірковому шарі. Під час гістологічного дослідження в клубочках спостерігаються «півмісяці» з проліферуючого нефротелія. Для якого захворювання характерні такі результати дослідження?',
    'medium',
    275,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Раку нирки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гнійного нефриту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Швидкопрогресуючого гломерулонефриту',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крововиливу в нирки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 277
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого, що страждає на серцеву недостатність, спостерігаються збільшення печінки, набряки нижніх кінцівок, асцит. Який механізм є провідним в утворенні даного набряку?',
    'medium',
    276,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфогенний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мембраногенний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колоїдно-осмотичний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідродинамічний',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 278
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вогнищі запалення підвищується проникність судин мікроциркуляторного русла, у них збільшується гідродинамічний опір. У міжклітинній рідині підвищується осмотична концентрація та дисперсність білкових структур. Який вид набряку буде спостерігатися у даному випадку?',
    'medium',
    277,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Змішаний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мембраногенний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідродинамічний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфогенний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колоїдно-осмотичний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 279
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В ході експерименту у білого щура моделювався набряк легені шляхом введення адреналіну. Який патогенетичний механізм розвитку набряку є провідним в даному випадку?',
    'medium',
    278,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфогенний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колоїдно-осмотичний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсичний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідродинамічний',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мембраногенний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 280
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час гістологічного дослідження міокарда виявлено, що окремі клітини розпадаються на часточки, оточені мембраною та без перифокальної запальної реакції. У деяких збережені органели та фрагменти ядра, що розпалося. Які зміни спостерігаються?',
    'medium',
    279,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Автоліз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атрофія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некроз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Агенезія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 281
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопічному дослідженні тканини печінки було виявлено, що деякі клітини розпалися на невеликі фрагменти з окремими органелами і залишками ядра, оточені мембраною. Запальна реакція відсутня. Для якого патологічного процесу характерні ці зміни?',
    'medium',
    280,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плазмолізу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плазморексису',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некрозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріорексису',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптозу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 282
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дослідник при мікроскопічному і електронно-мікроскопічному вивченні печінки звернув увагу, що деякі окремо розташовані клітини розпалися на дрібні фрагменти, оточені мембраною. У деяких з них наявні органели, інші включають фрагменти ядра, що розпалося. Запальна реакція навколо відсутня. Дослідник розцінив ці зміни, як:',
    'medium',
    281,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некроз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Атрофія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоплазія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 283
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Безпосередніми «виконавцями» апоптозу в клітині є особливі ферменти каспази. В утворенні одного з них бере участь цитохром С. Яка його функція в нормальній клітині?',
    'medium',
    282,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент дихального ланцюга переносу електронів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент бета-окислювання жирних кислот',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент ЦТК',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компонент Н+ -АТФ-азної системи',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компонент піруватдегідрогеназної системи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 284
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дослідженнями останніх десятиліть встановлено, що безпосередніми «виконавцями» апоптозу в клітині є особливі ферменти - каспази. В утворенні одного з них бере участь цитохром С. Вкажіть його функцію в нормальній клітині:',
    'medium',
    283,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент дихального ланцюга переносу електронів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компонент піруватдегідрогеназної системи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент ЦТК',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фермент бета-окислювання жирних кислот',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Компонент H + - АТФ-азной системи',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 285
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на туберкульоз у біоптаті нирки при гістологічному дослідженні у вогнищі казеозного некрозу виявлені хаотично розташовані дрібні зерна хроматину. Наслідком чого є виявлені зміни?',
    'medium',
    284,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріопікноз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Апоптоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мітотична активність ядер',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріорексис',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріолізис',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 286
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 38-ми років раптово помер. На розтині: у задній стінці лівого шлуночка серця виявлено інфаркт міокарда. Які найбільш імовірні зміни у будові міокардіоцитів можна побачити у вогнищі інфаркту мікроскопічно?',
    'medium',
    285,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводна дистрофія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каріолізис',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова дистрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білкова дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Звапнування',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 287
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 58-ми років, померлого при наростаючих явищах хронічної серцевої недостатності, діагностовано ревматичний гранульоматозний міокардит. Мікроскопічно в міокарді спостерігаються гранульоми, що складаються з макрофагів з гіперхромними ядрами та світлою цитоплазмою, в центрі - осередок некрозу. Який характер має некроз в середині гранульоми?',
    'medium',
    286,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдний',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Казеозний',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жировий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ценкеровський',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Колікваційний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 288
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопічному дослідженні шийного лімфатичного вузла виявлено скупчення епітеліоїдних клітин, лімфоцитів і гігантських клітин Пирогова-Лангханса. В центрі - казеозний некроз. Вкажіть найбільш імовірну патологію:',
    'medium',
    287,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сап',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Риносклерома',
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
    'Саркоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 289
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на рентгенограмі легень виявлено затемнення. В ході діагностичної експрес-біопсії лімфатичного вузла бронха виявлено казеозний некроз, навколо якого розташовані епітеліоїдні та лімфоїдні пласти з домішками багатоядерних гігантських клітин. Вкажіть причину лімфаденіту:',
    'medium',
    288,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сифіліс',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аденовірусна інфекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пневмонія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метастази раку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 290
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з субфебрильною температурою тіла в біоптаті збільшеного лімфатичного вузла виявлено численні гранульомі, які містять у центрі казеозний некроз, оточений епітеліоїдними клітинами, велетенськими багатоядерними клітинами Пирогова-Лангханса і лімфоцитами. Для якого захворювання характерні такі патогістологічні зміни?',
    'medium',
    289,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфолейкозу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфогранулематозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфосаркоми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульозу',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лімфаденіту',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 291
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При гістологічному дослідженні біоптату шкіри у хворого 24-х років виявлено казеозний некроз, оточений клітинним інфільтратом з лімфоцитів, серед яких зустрічаються окремі велетенські клітини, має місце розростання сполучної тканини, ендоваскуліти. Який характер патологічного процесу?',
    'medium',
    290,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Продуктивне інтерстиціальне запалення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Катаральне запалення',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іхорозне запалення',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Продуктивне гранульоматозне запалення',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 292
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка віком 68 років зі встанонленим діагнозом вібраційна хвороба, з’явився різкий біль у великому пальці лівої долоні. Під час огляду спостерігається: шкіра дистальної фаланги великого пальця чорного кольору, щільна. Палець видалили хірургічним шляхом. Яка клініко-морфологічна форма некрозу розвилася в пацієнта?',
    'medium',
    291,
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
    'Гангрена суха',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Папула',
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
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 293
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До хірурга звернувся чоловік 60-ти років, що тривалий час хворіє на цукровий діабет. Об’єктивно: тканини правої стопи чорного кольору, щільні, з чіткими краями. Який діагноз поставив хірург?',
    'medium',
    292,
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
  -- Питання 294
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який тривалий час хворів на переміжну кульгавість, об''єктивно спостерігається: шкіра пальців стопи суха, чорного кольору, нагадує тканину мумії. На невеликій відстані від почорнілої ділянки розташована двоколірна лінія (червоний колір прилягає до майже незмінених тканин, а біло-жовтий колір до змінених тканин). Який вид некрозу розвинувся у пацієнта?',
    'medium',
    293,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена',
    true,
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
    'Секвестр',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 295
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 69-ти років довго хворіла на атеросклероз. Поступила в хірургічне відділення з симптомами гострого живота. При лапаротомії виявлені: тромбоз мезентеріальної артерії, петлі тонкої кишки набряклі, багряно-чорного кольору, на їх серозній оболонці фібринозні нашарування. Який патологічний процес розвинувся у кишці хворої?',
    'medium',
    294,
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
  -- Питання 296
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час огляду дитини, яка перехворіла на кір, у м’яких тканинах щік та промежини виявлено нечітко відмежовані, набряклі, червоно-чорного кольору ділянки, у яких виявляється помірна флюктуація. Яке ускладнення розвинулося у дитини?',
    'medium',
    295,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трофічна виразка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волога гангрена (нома)',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Суха гангрена',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Газова гангрена',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 297
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на цукровий діабет з''явився різкий біль у правій стопі. Під час огляду великий палець стопи чорного кольору, тканини стопи набряклі, осередки відшарування епідермісу, виділення з неприємним запахом. Яка клініко-морфологічна форма некрозу розвинулася у хворого?',
    'medium',
    296,
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
    'Гангрена суха',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гангрена волога',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 298
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла жінки, яка померла внаслідок пухлинної дисемінації (множинні метастази та карциноз очеревини) муцинозної цистаденокарциноми і тривалий час мала вимушене положення в ліжку, були знайдені великі ділянки некрозу шкіри та підлеглих м’яких тканин крижової ділянці. Діагностуйте вид некрозу.',
    'medium',
    297,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пролежень',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Секвестр',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Воскоподібний (Ценкеровський) некроз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфаркт',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сирнистий некроз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 299
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки з важкою інтоксикацією, зумовленою сепсисом, який і послужив безпосередньою причиною смерті, на розтині виявлене ''тигрове серце''. Мікроскопічно в цитоплазмі кардіоміоцитів виявлені ліпіди. Який морфогенетичний механізм розвитку переважно лежить в основі даної дистрофії?',
    'medium',
    298,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфільтрація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спотворений синтез',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансформація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпозиція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 300
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При зовнішньому огляді новонародженого виявлені виражені зміни шкірних покривів усього тіла. Шкіра суха, тьмяна, з нерівною поверхнею та з наявністю сірих пластин, які відшаровуються. З яким видом дистрофії пов’язана ця патологія?',
    'medium',
    299,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліново-крапельна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гідропічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рогова',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 301
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік віком 65 років зі встановленим діагнозом: фіброзно-кавернозний туберкульоз легень помер від хронічної легенево-серцевої недостатності. Протягом останніх місяців спостерігалася виражена протеїнурія. На розтині нирки збільшені, щільні, восковидні на поверхні і всередині. Які зміни в нирках при цій формі туберкульозу могли викликати протеїнурію?',
    'medium',
    300,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефролітіаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гломерулонефрит',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульоз нирок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некротичний нефроз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз нирок',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 302
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка протягом 8 років хворіла на туберкульоз, померла в стаціонарі при ознаках хронічної ниркової недостатності. На розтині – нирки збільшені, поверхня розрізу має сальний вигляд; гістологічно виявлено масивні відкладання безструктурних гомогенних еозинофільних мас, при забарвленні Конго-рот спостерігається їх виражена метахромазія. Який патологічний процес розвинувся у нирках?',
    'medium',
    301,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсичний нефрит на фоні антибіотикотерапії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефросклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий гломерулонефрит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематогенний туберкульоз нирок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 303
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії чоловіка віком 60 років, який тривалий час хворів на фіброзно-кавернозний туберкульоз легень, виявлено збільшені у розмірах нирки масою по 180 гр кожна. Тканина нирок щільна, біло-сіра, з «сальним» блиском. Під час гістологічного дослідження у клубочках нирки та у стінці окремих артерій малого калібру виявлено гомогенні оксифільні маси, які під час забарвлення за конго-червоним зафарбувались у червоно-оранжевий колір. Які морфологічні зміни спостерігаються у нирках?',
    'medium',
    302,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Старечий амілоїдоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Локальний пухлиноподібний амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний гіаліноз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 304
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Молодий чоловік 19-ти років страждав з раннього дитинства на бронхоектатичну хворобу, помер від ниркової недостатності. На розтині окрім множинних бронхоектатичних каверн, заповнених гнійним ексудатом, виявлено збільшені в розмірах нирки щільної консистенції, кірковий шар потовщений, білого кольору, щільний. Піраміди нирки анемічні, чіткі. Назвіть процес, який розвинувся в нирках:',
    'medium',
    303,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вроджений кістоз нирок',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гломерулонефрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний нефросклероз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний пієлонефрит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 305
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла померлого від ниркової недостатності, який протягом останніх 5-ти років хворів на бронхоектатичну хворобу, виявлені збільшені в розмірах нирки щільної консистенції з потовщеним кірковим шаром білого кольору та сальним блиском. Про яке захворювання нирок можна думати?',
    'medium',
    304,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гломерулонефрит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний пієлонефрит',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Некротичний нефроз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 306
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При аутопсії тіла чоловіка середніх років, що тривало страждав на бронхоектатичну хворобу, виявлено, що обидва наднирника різко з6ільшені в об’ємі за рахунок кіркового шару. Наднирники щільні, бліді, сального вигляду. Мікроскопічно по ходу ретикулярної строми, у стінках судин - відкладання безструктурних, гомогенних, еозинофільних мас і конго-рот - позитивних мас. Який процес зумовив ці зміни?',
    'medium',
    305,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 307
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 53-х років, що тривало страждав на бронхоектатичну хворобу та кровохаркання, з’явилися набряки на обличчі і в ділянці попереку; у сечі - білок 33 мг/л. Смерть настала від легеневої кровотечі. Результати аутопсії: нирки збільшені в об’ємі, ущільнені, поверхня розрізу має сальний вигляд. Гістологічно відзначено відкладення у клубочках і по ходу канальців гомогенних еозинофільних мас, які вибірково забарвлюються конгорот і дають метахромазію з метиловим фіолетовим. Який патологічний процес мав місце в нирках у даному випадку?',
    'medium',
    306,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 308
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 35-річного наркомана, який тривало хворів на фіброзно-кавернозний туберкульоз легень, під час патологоана- томічного дослідження встановлено, що нирки та селезінка збільшені в розмірах, щільної консистенції, на розрізі тканина із сірим відтінком та ''сальним” блиском. Мікроскопічно вичвлено в білій та червоній пульпі селезінки, у інтерстиції та мезангіумі клубочків нирок депозити Конго-рот-позитивних мас. Діагностуйте вид ураження внутрішніх органів:',
    'medium',
    307,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Старечий амілоїдоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний амілоїдоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний гіаліноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Локальний пухлиноподібний амілоїдоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 309
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині тіла чоловіка, який хворів на фіброзно-кавернозний туберкульоз і помер від ниркової недостатності, виявлені збільшені в розмірах нирки, щільні на дотик, сіруватого кольору, на розрізі мають сальний вигляд. Який діагноз можна припустити?',
    'medium',
    308,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз нирок',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефросклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мієломна нирка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гломерулонефрит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний пієлоневрит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 310
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 40-а років протягом 10 років після перелому великогомілкової кістки страждав на хронічний остеомієліт. Три роки тому з’явився нефротичний синдром. Смерть настала від уремії. На секції: нирки щільні, білі, з рубцями в кірковому шарі на розрізі з сальним блиском. Яка патологія нирок розвинулася?',
    'medium',
    309,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний гломерулонефрит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний пієлонефрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Первинний амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний амілоїдоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 311
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий, що страждав хронічним гнійним остеомієлітом, помер від хронічної ниркової недостатності. При розтині виявлено великі щільні нирки біло-жовтого кольору з сальним блиском на зрізі. Який найбільш вірогідний діагноз?',
    'medium',
    310,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підгострий гломерулонефрит',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий некротичний нефроз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Септичний нефрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний гломерулонефрит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз нирок',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 312
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії тіла пацієнта з діагнозом: мієломна хвороба, який помер з явищами серцевої недостатності, виявлено збільшене в розмірах серце з розширеними порожнинами. Міокард блідий, має щільну консистенцію і воскоподібний блиск. Мікроскопічно під час забарвлення конго-рот визначається позитивна реакція. Для якої патології серця характерні такі результати дослідження?',
    'medium',
    311,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '–',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сальне серце',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тигрове серце',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ожиріння серця',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертензивне серце',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 313
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка протягом 8 років хворіла на туберкульоз, померла в стаціонарі при ознаках хронічної ниркової недостатності. На розтині – нирки збільшені, поверхня розрізу має сальний вигляд; гістологічно виявлено масивні відкладання безструктурних гомогенних еозинофільних мас, при забарвленні Конго-рот спостерігається їх виражена метахромазія. Який патологічний процес розвинувся у нирках?',
    'medium',
    312,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсичний нефрит на фоні антибіотикотерапії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нефросклероз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий гломерулонефрит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гематогенний туберкульоз нирок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 314
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 35-річного наркомана, який тривало хворів на фіброзно-кавернозний туберкульоз легень, під час патологоана- томічного дослідження встановлено, що нирки та селезінка збільшені в розмірах, щільної консистенції, на розрізі тканина із сірим відтінком та ''сальним” блиском. Мікроскопічно вичвлено в білій та червоній пульпі селезінки, у інтерстиції та мезангіумі клубочків нирок депозити Конго-рот-позитивних мас. Діагностуйте вид ураження внутрішніх органів:',
    'medium',
    313,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Старечий амілоїдоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіопатичний амілоїдоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифузний гіаліноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вторинний амілоїдоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Локальний пухлиноподібний амілоїдоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 315
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При аутопсії тіла чоловіка середніх років, що тривало страждав на бронхоектатичну хворобу, виявлено, що обидва наднирника різко з6ільшені в об’ємі за рахунок кіркового шару. Наднирники щільні, бліді, сального вигляду. Мікроскопічно по ходу ретикулярної строми, у стінках судин - відкладання безструктурних, гомогенних, еозинофільних мас і конго-рот - позитивних мас. Який процес зумовив ці зміни?',
    'medium',
    314,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 316
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт із ревматичною вадою мітрального клапана помер від хроніосепсису. Під час аутопсії виявлено: стулки мітрального клапана потовщені, зрощені, непрозорі, щільні, молочно-білого кольору. Укажіть характер патологічного процесу в клапані.',
    'medium',
    315,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдний некроз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 317
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час проведення аутопсії жінки віком 58 років, яка хворіла на цукровий діабет, при гістологічному дослідженні нирок виявлено у клубочках сегментарні гомогенні оксифільні відкладення, стінки артеріол дифузно потовщені, гомогенні, оксифільні. Який патологічний стан виник у клубочках і судинах нирок?',
    'medium',
    316,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліново-крапельна дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 318
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час аутопсії тіла жінки віком 63 роки, що хворіла на ревматизм і комбіновану мітральну ваду, виявлено: стулки мітрального клапана різко потовщені, зрощені між собою, кам''янистої щільності, під час розрізання визначається хрускіт. Який патологічний процес зумовив кам''янисту щільність клапана серця?',
    'medium',
    317,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофічне звапнення',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метастатичне звапнення',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічне звапнення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїд',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 319
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла чоловіка, який помер із явищами легенево-серцевої недостатності, виявлено, що бронхи деформовані, із мішковидними вип''ячуваннями стінки та гнійним запаленням. У серці виявлено гіпертрофію правого шлуночка, у нирках - амілоїдоз. Із анамнезу відомо, що протягом 8 років пацієнт скаржився на кашель із гнійним мокротинням та задуху, а його пальці рук нагадували барабанні палички. Якому захворюванню характерні такі патологічні зміни?',
    'medium',
    318,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бронхоектатичній хворобі',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцесу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічному бронхіту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострому броніту',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульозу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 320
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки впродовж року прогресувала ниркова недостатність, що призвело до смерті. Під час розтину тіла померлої виявлено великі строкаті нирки з червоними дрібними краплями в жовто-сірому кірковому шарі. Під час гістологічного дослідження в клубочках спостерігаються «півмісяці» з проліферуючого нефротелія. Для якого захворювання характерні такі результати дослідження?',
    'medium',
    319,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Раку нирки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гнійного нефриту',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Швидкопрогресуючого гломерулонефриту',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Крововиливу в нирки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 321
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка, який помер від уремії, на розтині виявлена деформація хребетного стовпа з різким обмеженням рухливості. Суглобові хрящі дрібних суглобів хребта зруйновані, є виражені ознаки тривалого поточного хронічного запалення в тканинах суглобів, порожнини суглобів заповнені сполучною тканиною, місцями кістковою з формуванням анкілозів. В аорті, серці та легенях наявні хронічне запалення та вогнищевий склероз. У нирках спостерігається амілоїдоз. Який діагноз у цьому разі найімовірніший?',
    'medium',
    320,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Педжета (деформівний остоз)',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Паратиреоїдна остеодистрофія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Остеопетроз (мармурова хвороба)',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ревматоїдний артрит',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анкілозивний спондилоартрит (хвороба Бехтерева)',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 322
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині виявлено зменшені в розмірах нирки, вага 50,0 г, їх поверхня дрібнозерниста, кора рівномірно стоншена. Під час мікроскопічного дослідження спостерігається: стінки артеріол значно потовщені внаслідок відкладення в них гомогенних безструктурних рожевого кольору мас, просвіт їх різко звужений, клубочки зменшені, склерозовані, канальці атрофічні. Для якого захворювання характерні описані зміни?',
    'medium',
    321,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострий некротичний нефроз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз нирок',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічний гломерулонефрит',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пієлонефрит зі зморщуванням нирок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпертонічна хвороба',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 323
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На аутопсії тіла жінки, яка хворіла на хронічну дизентерію, під час гістологічного дослідження внутрішніх органів у стромі та паренхімі міокарда, нирок, у слизовій оболонці шлунка та в сполучній тканині легень виявлені аморфні відкладення фіолетового кольору, що дають позитивну реакцію за Коссом. Яке ускладнення розвинулося у хворої?',
    'medium',
    322,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофічне звапнення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічне звапніння',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метастатичне звапнення',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 324
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 48 років помер при явищах серцевої недостатності. Під час макроскопічного дослідження серця встановлено, що стулки мітрального клапану ущільнені, потовщені та помірно деформовані. Мікроскопічно виявлено пучки колагенових фібрил гомогенізовані, еозинофільні, оточені незначним макрофагальним інфільтратом, метахромазія не виявляється. У разі забарвлення пікрофуксином виявляються вогнища жовтого кольору. Діагностуйте вид ураження сполучної тканини:',
    'medium',
    323,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Склероз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 325
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтині трупа жінки 63-х років, що страждала на ревматизм і комбіновану мітральну ваду, виявлено, що стулки мітрального клапана різко потовщені, зрощені між собою, кам’янистої щільності, під час розрізання визначається хрускіт. Який патологічний процес зумовив кам’янисту щільність клапана серця?',
    'medium',
    324,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїд',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дистрофічне звапнення',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метастатичне звапнення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метаболічне звапнення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 326
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла померлого 58 років знайдено, що мітральний клапан деформований, потовщений, змикається не до кінця. Мікроскопічно: вогнища колагенових волокнинок еозинофільні, дають позитивну реакцію на фібрин. Найвірогідніше це:',
    'medium',
    325,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринозне запалення',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 327
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження біоптату шкіри хворого на алергічний васкуліт знайдено: стінка судин потовщена, гомогенна, пікрофуксином забарвлюється у жовтий колір, ШІК-позитивна. Який патологічний процес розвинувся в стінках судин?',
    'medium',
    326,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 328
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині жінки 40 років, стра дає ревматоїдний артрит, виявлено збільшену щільну селезінку. На розрізі її тканина коричнево - червоного кольору з збільшеними фолікулами, які мають вигляд напівпрозорих сірувато - білуватих зерен. Який з перерахованих патологічних процесів найбільш вірогідний?',
    'medium',
    327,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сагова селезінка',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сальна селезінка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глазурна селезінка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порфірова селезінка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз селезінки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 329
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При розтині жінки 40 років, яка страждала ревматоїдним артритом, виявлено збільшену щільну селезінку. На розрізі її тканина коричнево - червоного кольору з збільшеними фолікулами, які мають вигляд напівпрозорих сірувато - білуватих зерен. Який патологічний процес найбільш вірогідний?',
    'medium',
    328,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сальна селезінка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порфірна селезінка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сагова селезінка',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глазурна селезінка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз селезінки',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 330
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла чоловіка 56 років, який страждав на фіброзно-кавернозний туберкульоз легень, знайдено збільшену у розмірах щільну селезінку. На розрізі тканина її коричнево-рожевого кольору, гладенька, з віскоподібною поверхнею. Який з перелічених патологічних процесів у селезінці найбільш вірогідний?',
    'medium',
    329,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цианотична індурація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порфірна селезінка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сагова селезінка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глазурна селезінка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сальна селезінка',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 331
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки з важкою інтоксикацією, спричиненою сепсисом, який і послужив безпосередньою причиною смерті, на розтині виявлене ''тигрове серце''. Який морфогенетичний механізм розвитку переважно лежить в основі даної дистрофії?',
    'medium',
    330,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    '-',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спотворений синтез',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфільтрація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансформація',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Декомпозиція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 332
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У померлого від хронічної серцево-судинної недостатності на розтині виявлене ''тигрове серце''. З боку ендокарду помітна жовтувато-біла посмугованість; міокард тьмяний, глинисто-жовтий. Який процес зумовив дану патологію?',
    'medium',
    331,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводна дистрофія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліново-краплинна дистрофія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова судинно-стромальна дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жирова паренхіматозна дистрофія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 333
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Стеатоз виникає внаслідок накопичення триацилгліцеролів у гепатоцитах. Одним з механізмів розвитку цього захворювання є зменшення утилізації нейтрального жиру ЛПДНЩ. Які ліпотропні речовини попереджують розвиток стеатозу?',
    'medium',
    332,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Валін, B3 , B2',
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
    'Ізолейцин, B1 , B2',
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
  -- Питання 334
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини трапляються хвороби, пов''язані із порушенням розщеплення і накопичення у клітинах глікогену, ліпідів та ін. Причиною виникнення цих спадкових хвороб є відсутність відповідних ферментів у:',
    'medium',
    333,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікротрубочках',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лізосомах',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендоплазматичній сітці',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мітохондріях',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 335
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернулась мати з приводу поганого самопочуття дитини - відсутність апетиту, поганий сон, дратівливість. При біохімічному дослідженні в крові виявлено відсутність ферменту глюкоцереброзидази. Для якої патології це характерно?',
    'medium',
    334,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Помпе',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Тея-Сакса',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Гірке',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Німана-Піка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Гоше',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 336
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні надійшла дитина 6-ти років. Під час обстеження було виявлено, що дитина не може фіксувати погляд, не слідкує за іграшками, на очному дні відзначається симптом "вишневої кістки". Лабораторні аналізи показали, що в мозку, печінці та селезінці - підвищений рівень гангліозиду глікометиду. Яке спадкове захворювання в дитини?',
    'medium',
    335,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Мак-Ардля',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Німана-Піка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Вільсона-Коновалова',
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
    'Хвороба Тея-Сакса',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 337
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У культурі клітин, отриманих від хворого з лізосомною патологією, виявлено накопичення значної кількості ліпідів у лізосомах. При якому з перелічених захворювань має місце це порушення?',
    'medium',
    336,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Галактоземія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Вільсона-Коновалова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хвороба Тея-Сакса',
    true,
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
    'Подагра',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 338
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитині встановлено діагноз: хвороба Тея-Сакса, що пов''язана з порушенням обміну речовин. Порушения якого обміну речовин зумовлює цю хворобу:',
    'medium',
    337,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідного',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білкового',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводного',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мінерального',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінокислотного',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 339
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини встановлено діагноз: хвороба Тея-Сакса, що пов''язана з порушенням обміну речовин. Порушення якого обміну речовин зумовлює цю хворобу?',
    'medium',
    338,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вуглеводного',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мінерального',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Білкового',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідного',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амінокислотного',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 340
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт із ревматичною вадою мітрального клапана помер від хроніосепсису. Під час аутопсії виявлено: стулки мітрального клапана потовщені, зрощені, непрозорі, щільні, молочно-білого кольору. Укажіть характер патологічного процесу в клапані.',
    'medium',
    339,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдний некроз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 341
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час проведення аутопсії жінки віком 58 років, яка хворіла на цукровий діабет, при гістологічному дослідженні нирок виявлено у клубочках сегментарні гомогенні оксифільні відкладення, стінки артеріол дифузно потовщені, гомогенні, оксифільні. Який патологічний стан виник у клубочках і судинах нирок?',
    'medium',
    340,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліново-крапельна дистрофія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 342
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 48 років помер при явищах серцевої недостатності. Під час макроскопічного дослідження серця встановлено, що стулки мітрального клапану ущільнені, потовщені та помірно деформовані. Мікроскопічно виявлено пучки колагенових фібрил гомогенізовані, еозинофільні, оточені незначним макрофагальним інфільтратом, метахромазія не виявляється. У разі забарвлення пікрофуксином виявляються вогнища жовтого кольору. Діагностуйте вид ураження сполучної тканини:',
    'medium',
    341,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Склероз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 343
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження біоптату шкіри хворого на алергічний васкуліт знайдено: стінка судин потовщена, гомогенна, пікрофуксином забарвлюється у жовтий колір, ШІК-позитивна. Який патологічний процес розвинувся в стінках судин?',
    'medium',
    342,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ліпідоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 344
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла померлого 58 років знайдено, що мітральний клапан деформований, потовщений, змикається не до кінця. Мікроскопічно: вогнища колагенових волокнинок еозинофільні, дають позитивну реакцію на фібрин. Найвірогідніше це:',
    'medium',
    343,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринозне запалення',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 345
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У померлого 58 років на розтині мітральний клапан деформований, потовщений, змикається не до кінця. Мікроскопічно: вогнища колагенових волокнинок еозинофільні, дають плюсову реакцію на фібрин. Найвірогідніше це:',
    'medium',
    344,
    true,
    NOW(),
    NOW()
  )
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амілоїдоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібриноїдне набухання',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіаліноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мукоїдне набухання',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фібринозне запалення',
    false,
    4,
    NOW(),
    NOW()
  );
  
  RAISE NOTICE 'Додано питань: 345';
END $$;
