-- SQL для додавання питань до розділу 12: Гриби і захворювання, спричинені грибами/паразити
-- Автоматично згенеровано
-- Кількість питань: 291

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
  
  -- Створюємо або знаходимо topic для розділу 12
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Гриби і захворювання, спричинені грибами/паразити'
  LIMIT 1;
  
  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Гриби і захворювання, спричинені грибами/паразити',
      'Тести з грибів та захворювань, спричинених грибами та паразитами',
      0,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_topic_id;
  END IF;
  
  RAISE NOTICE 'Початок додавання питань для розділу 12...';
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
    'У дитини на слизовій оболонці щік та язика спостерігаються білуваті плями. У виготовлених препаратах-мазках виявлено грампозитивні овальні дріжджоподібні клітини. Визначте ці збудники.',
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
    'Фузобактерії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стафілококи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиноміцети',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифтерійна паличка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гриби роду Кандіда',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 2
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після довготривалого вживання антибіотиків у хворого на слизовій ротової порожнини появилися округлі білі плями, на язику білий наліт. Який мікроорганізм імовірно спричинив дані симптоми?',
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
    'Кишкова паличка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактобацили',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептокок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентерокок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гриби роду Candida',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 3
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 25-ти років з численних шкірних пустул висівається золотистий стафілокок в асоціації з епідермальним стафілококом. В аналізі харкотиння виявлена пневмоциста карінії, у випорожненнях - криптоспоридії, вульгарний протей та гриби роду кандіда. При якому захворюванні зустрічається таке множинне інфікування умовно-патогенними мікроорганізмами?',
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
    'Цукровий діабет',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дисбактеріоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'СНІД',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сепсис',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Медикаментозний агранулоцитоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 4
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопії зіскрібку з язика, забарвленого за Грамом, знайдені овальні, округлі, темно-фіолетового кольору, видовжені ланцюжки клітин, що брунькуються. Про збудника якого захворювання може йти мова?',
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
    'Дифтерія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептококова інфекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стафілококова інфекція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 5
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Зі слизових оболонок та з харкотиння хворого, який тривалий час приймав імунодепресанти, були виділені грампозитивні великі овальні клітини з брунькуванням, що розташовані хаотично, та подовжені клітини у вигляді ланцюжків. Який збудник виділений?',
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
    'Кандиди',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиноміцети',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ієрсінії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептококи',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептобактерії',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 6
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопії зіскрібку з язика, забарвленого за Грамом, знайдені овальні, округлі, темно-фіолетового кольору, видовжені ланцюжки клітин, що брунькуються. Про збудника якого захворювання може йти мова?',
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
    'Стрептококова інфекція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стафілококова інфекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифтерія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 7
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження мікропрепарату з урогенітальних виділень жінки віком 37 років лікар виявив клітини округлої та еліпсоподібної форми, що брунькуються, розміром 3-6 мкм. Збудника якої грибкової хвороби досліджує лікар?',
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
    'Епідермофітії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Криптококозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кокицидіозу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидозу',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 8
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопії зіскрібку з язика, забарвленого за Грамом, знайдені овальні, округлі, темно-фіолетового кольору, видовжені ланцюжки клітин, що брунькуються. Про збудника якого захворювання може йти мова?',
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
    'Дифтерія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептококова інфекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стафілококова інфекція',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 9
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При мікроскопії мікропрепарату з виділень хворої хронічним кольповагінітом лікар виявив округлої форми та еліпсоподібні клітини, що брунькуються, розміром 3-6 мкм. Про збудника якої грибкової хвороби може йти мова в даному випадку?',
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
    'Криптококоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кокцидіоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроспорія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епідермофітія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 10
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час мікроскопії волосини хворого, взятої з уражених ділянок, виявлені обривки міцелію гриба, спори, пухирці повітря і крапельки жиру. Для якого грибкового захворювання характерна така мікроскопічна картина волосини?',
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
    'Споротрихоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихофітія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епідермофітія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроспорія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фавус',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 11
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження стану імунної системи жінки віком 25 років із хронічними грибковими ураженнями шкіри виявлено порушення клітинного імунітету. Зниження яких показників найбільш характерні при цьому патологічномустаніі?',
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
    'Т-лімфоцитів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'В-лімфоцитів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноглобуліну Е',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Плазмоцитів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноглобуліну G',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 12
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У 20-річної дівчини, яка страждає на поліпоз кишечника, у анамнезі вказано часті грибкові та вірусні захворювання. Недостатність якої ланки імунної системи є найімовірнішою в цьому разі?',
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
    'В-лімфоцитів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комплементу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фагоцитів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Т-лімфоцитів',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натуральних кілерів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 13
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час мікроскопічного дослідження мазка слизової оболонки піхви виявлено: великі грампозитивні мікроорганізми овальної подовженої форми, які утворювали псевдоміцелій. На яке середовище необхідно зробити посів, щоб виділити ймовірного збудника?',
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
    'Ендо',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вільсона-Блера',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Олькеницького',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левіна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сабуро',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 14
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час мікроскопічного дослідження мазку слизової оболонки піхви виявлено: великі грампозитивні мікроорганізми овальної подовженої форми, які утворювали псевдоміцелій. На яке середовище необхідно зробити посів, щоб виділити ймовірного збудника?',
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
    'Ендо',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левіна',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вільсона-Блера',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Олькеницького',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сабуро',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 15
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для підтвердження діагнозу: гострий атрофічний кандидоз проведено мікроскопію мазків, виготовлених із шкрібку нальоту на слизовій оболонці щоки, який взятий від хворої жінки. Виявлено овальної форми мікроорганізми, що брунькуються. Який метод забарвлення використав бактеріолог для фарбування мазків із досліджуваного матеріалу?',
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
    'Ожешка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Романовського-Гімзе',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Грама',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Морозова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нейсера',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 16
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для швидкої діагностики багатьох бактеріальних, вірусних, протозойних і грибкових захворювань, виявлення збудників хвороб у довкіллі, харчових продуктах і воді з успіхом використовується реакція, принцип якої полягає в багатократному копіюванні специфічної ділянки ДНК або окремого гена за допомогою ферменту ДНК-полімерази. Назвіть цю реакцію:',
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
  -- Питання 17
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 40-ка років ушкоджені міжпальцеві проміжки на ногах: шкіра мокне, відшаровується, з’явилися тріщини. При посіві зі шкрібу шкіри на середовище Сабуро виросли пухнасті колонії, білі зверху та зеленувато-жовті внизу. У мазках з верхньої частини колоній видно конідії у вигляді «дубинок» з 1-5 клітинами. Які ще органи найбільш імовірно може уразити цей збудник?',
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
    'Лімфатичні судини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Слизова статевих шляхів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Підшкірна клітковина',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волосся',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нігті',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 18
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лабораторії направлено матеріал білуватого нашарування із слизових оболонок ротової порожнини. Висів матеріалу зроблено на середовище Сабуро, відмічено ріст сметаноподібних колоній. Бактеріоскопія виявила короткі бруньковані нитки. До збудників якої інфекції відносять ізольовані мікроорганізми?',
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
    'Мікоплазмоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спірохетоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рикетсіоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хламідіоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 19
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До дерматолога звернувся хворий зі скаргами на появу гнійничків на шкірі обличчя та шиї. При лабораторному аналізі вмісту гнійних фолікул було виявлено рухомі червоподібні паразити. Вкажіть збудника, який викликав це захворювання:',
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
    'Блощиця ліжкова',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Личинка мухи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Залозниця вугрова',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коростяний свербун',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блоха людська',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 20
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Прикладом специфічних паразитів людини є малярійний плазмодій, гострик дитячий і деякі інші. Джерелом інвазії таких паразитів завжди є людина. Такі специфічні паразити людини викликають захворювання, які називаються:',
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
    'Антропозоонозні',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інфекційні',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антропонозні',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мультифакторіальні',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зоонозні',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 21
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні звернулися робітники з приводу того, що на тілі ними були знайдені паразити сірого кольору, довжиною близько 3 мм. Вони викликали неприємне подразнення шкіри, в місцях укусів виникали свербіж, біль, папули синього кольору, крововиливи. У окремих робітників піднялася температура. На шкірі були крововиливи. Яке захворювання найбільш імовірно?',
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
    'Короста',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Саркоптоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міаз шкірний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Педикульоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фтіріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 22
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Серед мешканців тайгового селища, які займаються збором і заготівлею ягід, почастішали випадки зараження на альвеококоз. Що є джерелом інвазії при даному захворюванні?',
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
    'Лисиці',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хворі люди',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Риба',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гризуни',
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
  -- Питання 23
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Гризуни є резервуаром збудників багатьох хвороб. З чим це пов''язано в першу чергу?',
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
    'Проживання в умовах, де ектопаразити використовують гризунів як джерело живлення',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біологічні особливості гризунів, що сприяють обміну паразитами і збудниками з людиною',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Приналежність гризунів до важливих компонентів наземних біоценозів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Приналежність гризунів до найбільш численного ряду класу ссавців',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Властивість гризунів швидко розмножуватися',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 24
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнта шпиталізовано із запаленням жовчних шляхів. У порціях жовчі виявлено рухомі найпростіші грушоподібної форми, двоядерні, із опорним стрижнем-аксостилем. Яке протозойне захворювання діагностується в пацієнта?',
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
    'Амебіаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомоноз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 25
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дослідження вмісту дванадцятипалої кишки чоловіка виявлено найпростіші грушоподібної форми з парними ядрами та чотирма парами джгутиків. Між ядрами дві опірні нитки, з вентрального боку розташований присмоктувальний диск. Якого представника найпростіших виявили у пацієнта?',
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
    'Лейшманію',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазму',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносому',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонаду кишкову',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблію',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 26
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки спостерігаються симптоми запального процесу сечостатевих шляхів. У мазку із слизової оболонки піхви виявлено великі одноклітинні організми грушоподібної форми із загостреним шипом на задньому кінці тіла, великим ядром та ундулюючою мембраною. Які найпростіші знайдені в мазку?',
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
    'Lamblia intestinalis',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trypanosoma gambiense',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas hominis',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas buccalis',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas vaginalis',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 27
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини спостерігаються невротичні симптоми: запаморочення, слабкість, головний біль, який супроводжується нудотою, болем в правому підребер’ї, частими позивами на дефекацію. При лабораторному дослідженні дуоденального вмісту виявлено грушоподібні найпростіші з двома ядрами, 4-ма парами джгутиків, а у фекаліях овальної форми цисти. Яке захворювання у дитини?',
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
    'Токсоплазмоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишковий трихомоноз',
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
    'Лямбліоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 28
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При огляді хворої лікар-гінеколог відмітив симптоми запалення статевих шляхів, у мазку взятому із піхви, виявлено грушоподібні найпростіші з шипом, з передньої частини відходять джгутики, наявна ундулююча мембрана. Яке захворювання підозрює лікар у хворої?',
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
    'Кишковий трихомоноз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Урогенітальний трихомоноз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіоз',
    false,
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
    'Токсоплазмоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 29
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При дослідженні вмісту дванадцятипалої кишки людини знайдені найпростіші грушоподібної форми з парними ядрами, чотирма парами джгутиків. Між ядрами - дві опірні нитки, з вентрального боку розташований присмоктувальний диск. Який представник найпростіших виявлений у хворого?',
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
    'Токсоплазма',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада кишкова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносома',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 30
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої симптоми запального процесу сечостатевих шляхів. У мазку із слизової оболонки піхви виявлено великі одноклітинні організми грушоподібної форми з загостреним шипом на задньому кінці тіла, великим ядром та ундулюючою мембраною. Які найпростіші знайдені в мазку?',
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
    'Trichomonas buccalis',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas vaginalis',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas hominis',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trypanosoma gambiense',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Lamblia intestinalis',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 31
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До гастроентерологічного відділення надійшов хворий із запаленням жовчних шляхів. У порціях жовчі виявлено рухомі найпростіші грушоподібної форми, двоядерні, з опорним стрижнем - аксостилем. Яке протозойне захворювання діагностується у хворого?',
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
    'Амебна дизентерія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіаз кишковий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз кишковий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомоноз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 32
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час дегельмінтизації з фекаліями виділився гельмінт довжиною до 2 м. Тіло сегментоване, із маленькою голівкою, на якій є чотири присоски та гачки. Укажіть вид гельмінта.',
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
    'Неозброєний ціп’як',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стьожак широкий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карликовий ціп’як',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Озброєний ціп’як',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінокок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 33
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини виявлено гельмінти. Які зміни в периферичній крові спостерігатимуться при такій патології?',
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
    'Моноцитоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоцитоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еозинофілія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Базофілія',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 34
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після дегельмінтизації у пацієнта віком 35 років під час випорожнення кишечника виділився стрічковий хробак довжиною 3,5 м. Дослідження калу виявило сколекс із чотирма присосками та гачками. Зрілі членики гельмінта нерухомі та мають до 12 бічних гілок матки. Яке захворювання ймовірно у чоловіка?',
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
    'Теніоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінококоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 35
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лабораторії під час мікроскопії харкотиння пацієнта, хворого на пневмонію, випадково виявлено личинки гельмінти. Під час аналізу крові виявлена еозинофілія. Який гельмінтоз можна припустити?',
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
    'Ентеробіоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихоцефальоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парагонімоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 36
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік протягом 3-х років працював в одній із африканських країн. Через місяць після переїзду до України звернувся до офтальмолога зі скаргами на біль в очах, набряки повік, сльозоточивість і тимчасове послаблення зору. Під кон’юнктивою ока були виявлені гельмінти розмірами 30-50 мм, які мали видовжене ниткоподібне тіло. Який найбільш вірогідний діагноз?',
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
    'Дифілоботріоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихоцефальоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Філяріоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 37
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитина 10 років скаржиться на слабкість, нудоту, дратівливість. На білизні знайдені гельмінти білого кольору завдовжки 5-10 мм. Під час мікроскопії зіскрібка з періанальних складок виявлені безбарвні яйця несиметричної форми. Укажіть, який гельмінт паразитує у дитини?',
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
    'Трихінела',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кривоголовка',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскарида людська',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волосоголовець',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострик',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 38
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати виявила у 5 річної дочки на перианальних складках білих "черв''ячків", які викликали у дівчинки свербіж і занепокоєння, і доставила їх в лабораторію. Виявлено білі гельмінти 0,5-1 см завдовжки, ниткоподібної форми з загостреними кінцями, у деяких вони закручені. Який діагноз можна поставити?',
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
    'Опісторхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 39
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт, що прийшов на прийом, скаржиться на свербіж між пальцями. Лікар поставив діагноз - скабієз. Які членистоногі можуть спричиняти це захворювання?',
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
    'Тайговий кліщ.',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Собачий кліщ.',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Коростяний свербун',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дермацентор.',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Селищний кліщ.',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 40
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого, який страждає на вугрі та на запальні зміни шкіри обличчя, при мікроскопії матеріалу з осередків ураження виявлені живі членистоногі, довгастої форми, з 4 парами дуже редукованих кінцівок. Встановіть попередній діагноз:',
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
    'Ураження шкіри коростяним свербуном',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алергія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Демодекоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ураження шкіри блохами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Педикульоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 41
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на обличчі вугрі. Під час мікроскопії зскрібків із уражених ділянок виявлені живі членистоногі розміром 0,2-0,5 мм., які мають витягнуту червоподібну форму, чотири пари коротких кінцівок, що розташовані у середній частині тіла. Який лабораторний діагноз?',
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
    'Фтиріоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Педикульоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Міаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Короста',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Демодекоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 42
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернувся пацієнт зі скаргами на свербіж між пальцями рук і на животі, що посилюється вночі. Під час огляду на шкірі виявлено тоненькі смужки сірого кольору та дрібний висип. Який імовірний збудник цього захворювання?',
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
    'Ixodes ricinus',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Sarcoptes scabiei',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ornitodorus papillipes',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ixodes persulcatus',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Dermacentor pictus',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 43
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак 16 років скаржиться на свербіж між пальцями рук і на животі, який посилюється вночі. При огляді на шкірі були виявлені тоненькі смуги сірого кольору і дрібна висипка. Який найбільш ймовірний збудник цієї хвороби?',
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
    'Ixodes persulcatus',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ixodes ricinus',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ornithodorus papillipes',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Sarcoptes scabiei',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Dermacentor pictus',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 44
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки народилася мертва дитина з вадами розвитку. Яке протозойне захворювання могло спричинити внутрішньо- утробне зараження плода?',
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
    'Малярія',
    false,
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
    'Трипаносомоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонадоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 45
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки народилась мертва дитина з багатьма вадами розвитку. Яке протозойне захворювання могло спричинити внутрішньоутробну загибель?',
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
  -- Питання 46
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, що прибув з ендемічного за малярією району, підвищилася температура тіла, відзначається головний біль, озноб, загальне нездужання - симптоми, що характерні й для звичайної застуди. Які лабораторні дослідження необхідно провести, щоб підтвердити або спростувати діагноз ''малярія''?',
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
    'Дослідження пунктату лімфовузлів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазків крові',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дослідження спинномозкової рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія пунктату червоного кісткового мозку',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аналіз сечі',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 47
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хірургічне відділення лікарні був прийнятий хворий з підозрою на абсцес печінки. Хворий тривалий час знаходився у відрядженні в одній з африканських країн і неоднарозово хворів на гостре шлунково-кишкове захворювання. Яке протозойне захворювання може бути в хворого?',
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
    'Малярія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
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
    'Лейшманіоз',
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
  -- Питання 48
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, що прибув з ендемічного за малярією району, підвищилася температура тіла, відзначається головний біль, озноб, загальне нездужання -симптоми, що характерні й для звичайної застуди. Які лабораторні дослідження необхідно провести, щоб підтвердити або спростувати діагноз ''малярія''?',
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
    'Аналіз сечі',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія пунктату червоного кісткового мозку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дослідження спинномозкової рідини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазків крові',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дослідження пунктату лімфовузлів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 49
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінці під час пологів було проведено гемотрансфузію кровʼю донора, який прибув із Південної Африки. За два тижні у реципієнтки виникла лихоманка. Встановлено попередній діагноз:малярія. Яке лабораторне дослідження потрібно провести для підтвердження діагнозу?',
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
    'Вивчення пунктату лімфатичних вузлів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вивчення лейкоцитарної формули',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Визначення збудника методом посіву крові на живильне середовище',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проведення серологічних досліджень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вивчення мазка і товстої краплі крові для виявлення еритроцитарних стадій збудника',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 50
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'На розтиш тїла жінки з середньої Азії, що тривалий час страждає на виснажуючу лихоманку, були виявлені збільшені'' печінка і селезінка аспідно-чорного кольору. Кістковий мозок гіперплазований, такого ж кольору. Кора головного мозку сіро-димчатого кольору. Для якого захворювання характерні такі зміни?',
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
    'СНЩ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярія',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Висипний тиф',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сепсис',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гепатит',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 51
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час розтину тіла померлого чоловіка виявлено, що речовина головного мозку та лімфатичних вузлів має темно-сірий колір, а печінка та селезінка значно збільшені. Гістологічно в них спостерігаються гемомеланоз і гемосидероз. Із анамнезу відомо про періодичні напади гарячки. Для якого захворования характерні такі патогістологічні зміни?',
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
    'Септицемія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Чорна віспа',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярія',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемолітична анемія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аддісонова хвороба',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 52
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини виявлено протозойне захворювання, унаслідок якого вражений головний мозок і спостерігається втрата зору. У крові знайдено одноклітинні півмісяцевоі форми із загостреним кінцем. Збудником цього захворювання є:',
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
    'Амеба',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазма',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 53
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 37-ми років звернулася до гінеколога з приводу запального процесу піхви, який супроводжується свербінням та пінистими виділеннями. Баканаліз встановив наявність трихомонадної інфекції. Який засіб найбільш ефективний у даному випадку?',
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
    'Еритроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітроксолін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ністатин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 54
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час трьох вагітностей у жінки спостерігалися викидні. З анамнезу відомо, що жінка протягом тривалого часу проживала в сім’ї, де була кішка. Яким одноклітинним паразитом, що міг бути причиною викиднів, могла заразитися жінка?',
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
    'Лямблія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазма',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 55
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини спостерігаються невротичні симптоми: запаморочення, слабкість, головний біль, який супроводжується нудотою, болем в правому підребер’ї, частими позивами на дефекацію. При лабораторному дослідженні дуоденального вмісту виявлено грушоподібні найпростіші з двома ядрами, 4-ма парами джгутиків, а у фекаліях овальної форми цисти. Яке захворювання у дитини?',
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
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишковий трихомоноз',
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
    'Лямбліоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 56
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В ході копрологічного дослідження у працівників кав’ярні лікарями санітарно-епідеміологічної станції були виявлені округлі цисти, характерною ознакою яких є наявність чотирьох ядер. Імовірніше за все у цих працівників безсимптомно паразитує:',
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
    'Кишкова трихомонада',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дизентерійна амеба',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба кишкова',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 57
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні потрапили пацієнти зі скаргами: слабкість, болі в кишечнику, розлади травлення. Після дослідження фекалій були виявлені кулясті цисти з чотирма ядрами. Для якого найпростішого характерні такі цисти?',
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
    'Балантидій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба кишкова',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба ротова',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишкова трихомонада',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба дизентерійна',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 58
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При копрологічному дослідженні у працівників кав’ярні лікарями санітарно- епідеміологічної станції були виявлені округлі цисти, характерною ознакою яких є наявність чотирьох ядер. Імовірніше за все у цих працівників безсимптомно паразитує:',
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
    'Лямблія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишкова трихомонада',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дизентерійна амеба',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба кишкова',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 59
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого виявлено протозойне захворювання, при якому вражений головний мозок і спостерігається втрата зору. У крові знайдені одноклітинні півмісяцевої форми з загостреним кінцем. Збудником цього захворювання є:',
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
    'Лейшманія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазма',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 60
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У мазку дуоденального вмісту хворого з розладом травлення виявлено найпростіших розміром 10-18 мкм. Тіло грушоподібної форми, 4 пари джгутиків, у розширеній передній частині тіла два ядра, які розміщені симетрично. Який вид найпростіших найбільш вірогідний?',
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
    'Балантидій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дизентерійна амеба',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишкова амеба',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 61
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернулися пацієнти з подібними скаргами: слабкість, болі у животі, рідкі випорожнення. Після дослідження фекалій з''ясувалося, що терміновій госпіталізації підлягає один з пацієнтів, у якого були виявлені цисти з чотирма ядрами. Для якого найпростішого характерні такі цисти?',
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
    'Дизентерійна амеба',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кишкова амеба',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 62
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернулися пацієнти з подібними скаргами: слабкість, болі в кишечнику, розлад ШКТ. Після дослідження фекалій з''ясувалось, що терміновій госпіталізації підлягає один з пацієнтів, у якого були виявлені цисти з чотирма ядрами. Для якого найпростішого характерні такі цисти?',
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
    'Кишкова амеба',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дизентерійна амеба',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямблія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 63
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час трьох вагітностей у жінки спостерігалися викидні. З анамнезу відомо, що жінка протягом тривалого часу проживала в сім’ї, де була кішка. Яким одноклітинним паразитом, що міг бути причиною викиднів, могла заразитися жінка?',
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
    'Лямблія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазма',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихомонада',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеба',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 64
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки 32 років з безсимптомним перебігом хвороби народилася мертва дитина з вираженою мікроцефалією. Про якому захворюванні в першу чергу слід подумати лікарю?',
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
  -- Питання 65
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з підозрою на одне з протозойних захворювань досліджено пунктат лімфатичного вузла. В препараті, забарвленому за Романовським-Гімзою, виявлені тільця півмісяцевої форми із загостреним кінцем, блакитною цитоплазмою, ядром червоного кольору. Яких найпростіших виявлено в мазках?',
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
    'Дерматотропні лейшманії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазми',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярійні плазмодії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеротропні лейшманії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносоми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 66
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вади розвитку плода можуть спричинити такі хвороби матері, як краснуха, сифіліс, токсоплазмоз, цитомегалія, герпес, хламідіоз. До якої форми мінливості належать такі вади розвитку?',
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
    'Геномного імпринтингу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Модифікаційної',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мутаційної',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комбінативної',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Епімутаційної',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 67
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту встановлено попередній діагноз: токсоплазмоз. Який біологічний матеріал використано для діагностики цього захворювання?',
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
    'Мокротиння',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кров',
    true,
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
    'Фекалії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сечу',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 68
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Перебуваючи в робочому відрядженні в одній із країн тропічної Африки, лікар почув скарги місцевого населення через хворобу, яка виникає у дітей 10-14-ти річного віку, що супроводжується стійкою гарячкою, яка не має правильного чергування, виснаженням, анемією, збільшенням печінки і селезінки. Який найімовірніший діагноз?',
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
    'Хвороба Чагаса',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеральний лейшманіоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сонна хвороба',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 69
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-інфекціоніста звернулись батьки з хворою дитиною, які тривалий час працювали в Індії. У дитини такі симптоми: шкіра землистого кольору, втрата апетиту, в''ялість, збільшені печінка, селезінка та лімфатичні вузли. Яке протозойне захворювання можна припустити у дитини?',
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
    'Амебіаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеральний лейшманіоз',
    true,
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
    'Токсоплазмоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 70
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки народилася хвора на токсоплазмоз дитина. Жінка вважає, що заразилася токсоплазмою від подруги, яка нещодавно також народила хвору дитину. Який спосіб зараження людини токсоплазмою є НЕМОЖЛИВИМ?',
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
    'Контакт з хворою людиною',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Контакт з кішкою',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пиття води, зараженої ооцитами',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Споживання немитих овочів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вживання напівсирого м''яса зараженої свійської тварини',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 71
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'За два тижні після переливання крові у реципієнта виникла лихоманка. Яке протозойне захворювання може припустити лікар в цій ситуації?',
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
    'Амебіаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярію',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносомоз',
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
  -- Питання 72
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хірургічне відділення лікарні був прийнятий хворий з підозрою на абсцес печінки. Хворий тривалий час знаходився у відрядженні в одній з африканських країн і неоднарозово хворів на гостре шлунково-кишкове захворювання. Яке протозойне захворювання може бути в хворого?',
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
    'Малярія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіаз',
    true,
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
    'Трипаносомоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 73
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жіночій консультації обстежується жінка, у якої було декілька мимовільних викиднів. На підставі клініко-епідеміологічного анамнезу було припущено хронічний токсоплазмоз. Яке лабораторне дослідження буде найефективнішим для підтвердження діагнозу?',
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
    'Мікроскопія піхвового мазка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шкірно-алергічна проба',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазка фекалій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазка крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серологічні реакції',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 74
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У вагітної жінки взяли кров для підтвердження клінічного діагнозу ''токсоплазмоз'' Яка з перерахованих серологічних реакцій має діагностичне значення?',
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
    'Реакція зв’язування комплементу',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція гемадсорбції',
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
    'Реакція аглютинації',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реакція нейтралізації',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 75
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Турист нещодавно повернувся з країн Середньої Азії, де є багато москітів. У нього на шкірі з’явилися невеликі виразки з нерівними краями. В цьому випадку можна припустити наступне захворювання:',
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
    'Скабіес',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Специфічний міаз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дерматотропний лейшманіоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Демодекоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 76
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини після укусу москітом виникли виразки шкіри. Аналіз вмісту виразки виявив всередині клітин людини безджгутикові одноклітинні організми. Який попередній діагноз?',
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
    'Трипаносомоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз вісцеральний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейшманіоз дерматотропний',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 77
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Через два тижні після переливання крові у реципієнта виникла пропасниця. Про яке протозойне захворювання можна думати?',
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
    'Амебіаз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносомоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
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
    'Малярію',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 78
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому, який звернувся до лікаря з приводу безпліддя, було призначено обстеження на токсоплазмоз і хронічну гонорею. Яку реакцію слід поставити для виявлення прихованого токсоплазмозу і хронічної гонореї у цього хворого?',
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
    'РЗНГА',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Імуноблотингу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'РЗПГА',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'РЗК',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'РІФ',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 79
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-інфекціоніста з хворою дитиною звернулися батьки, які тривалий час працювали в одній азіатській країні. У дитини шкіра землистого кольору, втрата апетиту, в’ялість, збільшені печінка, селезінка, периферичні лімфатичні вузли. Яке протозойне захворювання можна припустити у дитини?',
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
    'Токсоплазмоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидіаз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіаз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеральний лейшманіоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 80
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Які стадії розвитку проходить малярійний плазмодій в організмі людини?',
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
    'Еритроцитарна шизогонія, гаметогонія',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тканинна шизогонія, спорогонія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Статеве розмноження, спорогонія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ендогонія, шизогонія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спорогонія, шизогонія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 81
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінці під час пологів було проведено гемотрансфузію кровʼю донора, який прибув із Південної Африки. За два тижні у реципієнтки виникла лихоманка. Встановлено попередній діагноз:малярія. Яке лабораторне дослідження потрібно провести для підтвердження діагнозу?',
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
    'Вивчення пунктату лімфатичних вузлів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вивчення лейкоцитарної формули',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Визначення збудника методом посіву крові на живильне середовище',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проведення серологічних досліджень',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вивчення мазка і товстої краплі крові для виявлення еритроцитарних стадій збудника',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 82
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні госпіталізовано пацієнта зі скаргами на слабкість, болі в кишечнику. Під час лабораторного дослідження фекалій виявлено кулясті цисти з чотирма ядрами. Для якого виду найпростіших характерні такі цисти?',
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
    'Кишкової трихомонади',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеби кишкової',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантидію',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеби ротової',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амеби дизентерійної',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 83
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 40-ка років у ділянці шиї виникло почервоніння та набряк шкіри і з часом розвинувся невеликий гнійник. На розрізі осередок щільний, жовто-зеленого забарвлення. У гнійних масах видно білі крупинки. Гістологічно виявлено друзи грибка, плазматичні та ксантомні клітини, макрофаги. Який найбільш вірогідний вид мікозу?',
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
    'Аспергільоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кокцидіомікоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Споротрихоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 84
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки віком 40 років у ділянці шиї виникли почервоніння та набряк шкіри, а згодом сформувався невеликий гнійник. На розрізі осередок гнійного запалення щільний, жовто-зеленого кольору. У гнійних масах помітні білі крупинки. Гістологічно виявлено друзи грибка, плазматичні та ксантомні клітини, макрофаги. Який вид мікозу розвинувся у пацієнтки?',
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
    'Аспергільоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кокцидіоїдомікоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кандидоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Споротрихоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 85
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік 32-х років, мешканець сільської місцевості, звернувся до лікаря зі скаргами на наявність болісної припухлості у підщелепній ділянці з утворенням нориці. Під час огляду хворого лікар виявив інфільтрат, у центрі якого наявна нориця з густим гнійним виділенням з крихтами білого кольору. Під час розтину інфільтрату тканини щільні, жовтувато-зеленого кольору, стільникової будови через множинні дрібні гнійники. Яке захворювання можна припустити?',
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
    'Сифіліс',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Туберкульоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Актиномікоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Абсцес підщелепної ділянки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лепра (проказа)',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 86
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтка скаржиться на свербіння, відчуття печіння у ділянці зовнішніх статевих органів та гнійні пінисті виділення з них. Під час лабораторного дослідження у виділеннях виявлено одноклітинні організми грушоподібної форми з чотирма джгутиками, ундулюючою мембраною і шипом на кінці тіла. Який це вид організмів?',
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
    'Trichomonas hominis',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Lamblia intestinalis',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Entamoeba gingivalis',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichomonas vaginalis',
    true,
    3,
    NOW(),
    NOW()
  );
  -- Питання 87
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хірургічне відділення лікарні був прийнятий хворий з підозрою на абсцес печінки. Хворий тривалий час знаходився у відрядженні в одній з африканських країн і неоднарозово хворів на гостре шлунково-кишкове захворювання. Яке протозойне захворювання може бути в хворого?',
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
    'Малярія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазмоз',
    true,
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
    'Лейшманіоз',
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
  -- Питання 88
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікар-стоматолог для лікування гінгівіту призначив пацієнту препарат з протипротозойною та антибактеріальною діями, який може викликати відразу до алкоголю. Вкажіть препарат, який призначив лікар:',
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
    'Метронідазол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефтріаксон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінкоміцину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 89
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з підозрою на одне з протозойних захворювань досліджено пунктат лімфатичного вузла. В препараті, забарвленому за Романовським-Гімзою, виявлені тільця півмісяцевої форми із загостреним кінцем, блакитною цитоплазмою, ядром червоного кольору. Яких найпростіших виявлено в мазках?',
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
    'Дерматотропні лейшманії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токсоплазми',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярійні плазмодії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вісцеротропні лейшманії',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трипаносоми',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 90
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Які з нижченаведених членистоногих можуть бути переносниками збудників пропасниці papataсhi?',
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
    'Мошки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комарі',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хатні мухи',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Москіти',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сліпні',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 91
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У розповсюдженні деяких захворювань значну роль відіграють переносники збудників цих хвороб. Збудник якого захворювання поширюється завдяки наявності специфічного переносника?',
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
    'Трихомонозу',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лямбліозу',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амебіазу',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Балантідіозу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Малярії',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 92
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У людини подразнення шкіри - свербіж, висипання, депігментація, збільшені лімфовузли. В оці знайдені філярії. Встановлений діагноз - онхоцеркоз. Які компоненти гнусу могли стати переносниками філярій p.Onchocerca?',
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
    'Ґедзі',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Москіти',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мокрець',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комарі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мошки',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 93
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який період життєвого циклу малярійного плазмодія збігається з появою у пацієнта клінічних симптомів малярії?',
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
    'При проникненні мерозоїтів в еритроцити',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Під час утворення гаметоцитів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'У період тканинної шизогонії',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'При виході мерозоїтів зі зруйнованих еритроцитів',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'При проникненні спорозоїтів у кров людини',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 94
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У життєвому циклі деяких паразитів може бути хазяїн, у якому паразит зберігає життєздатність, нагромаджується, але не розвивається. Як називають цього хазяїна?',
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
    'Резервуарним',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Додатковим',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Факультативним',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Облігатним',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дефінітивним',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 95
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому з лихоманкою та висипкою на шкірі після обстеження за допомогою серологічних реакцій поставлено діагноз - фасціольоз. Було встановлено, що хворий заразився шляхом споживання сирої води з річки. Яка стадія життєвого циклу фасціоли інвазійна для людини?',
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
    'Фіна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мірацидій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метацеркарій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адолескарій',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Яйце',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 96
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого з лихоманкою та висипкою на шкірі після обстеження за допомогою серологічних реакцій поставлений діагноз фасціольоз. Було встановлено, що хворий заразився шляхом споживання сирої води з річки. Яка стадія життєвого циклу фасціоли інвазійна для людини?',
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
    'Мірацидій',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метацеркарій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Яйце',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фіна',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адолескарій',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 97
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після дегельмінтизації у пацієнта віком 35 років під час випорожнення кишечника виділився стрічковий хробак довжиною 3,5 м. Дослідження калу виявило сколекс із чотирма присосками та гачками. Зрілі членики гельмінта нерухомі та мають до 12 бічних гілок матки. Яке захворювання ймовірно у чоловіка?',
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
    'Теніоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінококоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 98
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лабораторії під час мікроскопії харкотиння пацієнта, хворого на пневмонію, випадково виявлено личинки гельмінти. Під час аналізу крові виявлена еозинофілія. Який гельмінтоз можна припустити?',
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
    'Ентеробіоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихоцефальоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парагонімоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 99
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати виявила у 5 річної дочки на перианальних складках білих "черв''ячків", які викликали у дівчинки свербіж і занепокоєння, і доставила їх в лабораторію. Виявлено білі гельмінти 0,5-1 см завдовжки, ниткоподібної форми з загостреними кінцями, у деяких вони закручені. Який діагноз можна поставити?',
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
    'Опісторхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 100
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хлопчика 5 років, якого непокоїть анальний свербіж, виявлені черв’яки класу нематод (гострики). Оберіть лікарський засіб для дегельмінтації дитини:',
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
    'Сім’я гарбуза',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Празіквантель',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенасал',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноакрихін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 101
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після довготривалого вживання антибіотиків у хворого на слизовій ротової порожнини появилися округлі білі плями, на язику білий наліт. Який мікроорганізм імовірно спричинив дані симптоми?',
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
    'Кишкова паличка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лактобацили',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептокок',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентерокок',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гриби роду Candida',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 102
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся із скаргами на загальну слабкість, головний біль, нудоту, блювання, рідкі випорожнення з домішками слизу та крові. При мікроскопії дуоденального вмісту та при дослідженні свіжих фекалій виявлено рухомі личинки. Який найбільш вірогідний діагноз?',
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
    'Стронгілоїдоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анкілостомідоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихоцефальоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дракункульоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 103
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час огляду хворого з ранами, що кровоточать, лікар виявив пошкодження тканин личинками, а також локальні місця нагноєння, та встановив діагноз: облігатний міаз. Личинки яких комах є збудниками цього захворювання?',
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
    'Тріатомовий клоп',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Жигалка осіння',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Муха хатня',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Муха вольфартова',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Муха цеце',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 104
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лабораторії при мікроскопії мокротиння хворого на пневмонію випадково виявлені личинки. При аналізі крові виявлено еозинофілія. Який гельмінтоз можна припустити?',
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
    'Трихоцефальоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парагонімоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 105
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий скаржиться на загальну слабкість, головний біль, нудоту, блювоту, рідкі випорожнення з домішкою слизу і крові. При мікроскопії дуоденального вмісту і при дослідженні свіжих фекалій виявлено рухомі личинки. Поставте діагноз.',
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
    'Ентеробіоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анкілостомоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'дракункульоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихоцефальоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стронгілоїдоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 106
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні звернулася мати з дитиною. На голові у дитини спостерігається гангренозна рана. Під час огляду у рані виявлено білі червоподібні личинки відкласти? Яка комаха найімовірніше могла їх відкласти?',
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
    'Вольфартова муха',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блохи',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Муха-жигалка',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Комарі',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Москіти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 107
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий скаржиться на біль у ділянці печінки. При дослідженні жовчі, отриманої під час дуоденального зондування, виявлені жовтуваті яйця овальної форми, звужені до полюсів, на кінці одного полюсу знаходиться кришечка. Розміри цих яєць найменші серед яєць усіх гельмінтів. Який найбільш вірогідний діагноз?',
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
    'Теніоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінококоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 108
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В лікарню потрапив хворий з Східного Сибіру зі скаргами на біль в печінці. У фекаліях знайдені яйця до 30 мкм, що нагадують по формі насіння огірків. Який попередній діагноз можна поставити хворому?',
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
    'Гіменолепідоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дикроцеліоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Парагонімоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 109
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт скаржиться на біль в області печінки. Під час дуоденального зондування виявлено: жовтуваті яйця овальної форми, звужені до полюсу, на якому розташована кришечка. Розміри цих яєць найменші серед яєць усіх гельмінтів. Який гельмінтоз спостерігається у пацієнта?',
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
    'Теніарінхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 110
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Журналіст тривалий час працював в Індії. Через деякий час після повернення з цієї країни у нього в підшкірній клітковині підколінної ділянки на правій кінцівці утворився довгий шнуроподібний валик, на кінці якого сформувався міхур, заповнений некротичними масами. Який гельмінтоз можна запідозрити у хворого?',
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
    'Опісторхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аскаридоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дракункульоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихінельоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 111
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Під час операції в печінці хворого виявлені дрібні пухирці малих розмірів з незначною кількістю рідини, які щільно прилягають один до одного. Який гельмінтоз виявився у хворого?',
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
    'Клонорхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фасціольоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дикроцеліоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альвеококоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 112
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий впродовж трьох років безрезультатно лікувався з приводу значного зниження кислотності шлункового соку. Його пригнічувала поява на білизні, постелі члеників, що рухались і самостійно виповзали з анального отвору. Який найбільш імовірний діагноз?',
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
    'Теніоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіменолепідоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистицеркоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 113
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Мати виявила у 5-річної доньки на періанальних складках білих "черв’ячків", які викликали у дитини свербіж і неспокій, і доставила їх до лабораторії. Під час огляду лікар побачив білих гельмінтів 0,5-1 см довжиною, ниткоподібної форми з загостреними кінцями, у деяких кінці були закручені. Який найбільш вірогідний діагноз?',
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
    'Аскаридоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеробіоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 114
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Група чоловіків звернулася до лікаря зі скаргами на підвищення температури, головні болі, набряки повік та обличчя, болі в м''язах. З анамнезу стало відомо, що всі вони мисливці і часто вживають в їжу м''ясо диких тварин. Який найбільш імовірний діагноз?',
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
    'Теніаринхоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихінельоз',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Філяріатоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистицеркоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 115
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий скаржиться на біль у ділянці печінки. При дослідженні жовчі, отриманої під час дуоденального зондування, виявлені жовтуваті яйця овальної форми, звужені до полюсів, на кінці одного полюсу знаходиться кришечка. Розміри цих яєць найменші серед яєць усіх гельмінтів. Який найбільш вірогідний діагноз?',
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
    'Теніоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінококоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 116
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні надійшов хворий із скаргами на головний біль, біль у м’язах під час руху, слабкість, температуру, набряк повік і обличчя. Лікар пов’язує цей стан із вживанням свинини, купленої у приватних осіб. Який попередній діагноз може поставити лікар?',
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
    'Фасціольоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трихінельоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 117
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого діагностовано паразитарне захворювання, яке супроводжується клінічною картиною В12- фолієводефіцитної анемії. Який гельмінт спричинив дане захворювання?',
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
    'Taeniarhynchus saginatus',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taenia solium',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Hymenolepis nana',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Fasciola hepatica',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Diphyllobothrium latum',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 118
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностовано паразитарне захворювання, яке супроводжується клінічною картиною B12-фолієводефіцитної анемії. Який гельмінт спричинив захворювання у пацієнта?',
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
    'Fasciola hepatica',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taeniarhynchus saginatus',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Hymenolepis nana',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Diphyllobothrium latum',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taenia solium',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 119
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 26-ти років звернулася до лікаря зі скаргами на появу у випорожненнях білих плоских рухливих утворів, які нагадують локшину. При лабораторному дослідженні виявлені членики з такою характеристикою: довгі, вузькі, з розміщеним поздовжньо каналом матки, яка має 17-35 бічних відгалужень з кожного боку. Який вид гельмінтів паразитує у кишечнику жінки?',
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
    'Hymenolepis nana',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taeniarhynchus saginatus',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Echinococcus granulosus',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Diphyllobothrium latum',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taenia solium',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 120
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При деяких гельмінтозах людина може сама виявити гельмінта, оскільки зрілі членики збудника можуть активно виповзати з ануса людини. Це характерно для такого захворювання:',
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
    'Теніаринхоз',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дифілоботріоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінококоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіменолепідоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 121
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий впродовж трьох років безрезультатно лікувався з приводу значного зниження кислотності шлункового соку. Його пригнічувала поява на білизні, постелі члеників, що рухались і самостійно виповзали з анального отвору. Який найбільш імовірний діагноз?',
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
    'Теніоз',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіменолепідоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цистицеркоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Теніаринхоз',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 122
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 26-ти років звернулася до лікаря зі скаргами на появу у випорожненнях білих плоских рухливих утворів, які нагадують локшину. При лабораторному дослідженні виявлені членики з такою характеристикою: довгі, вузькі, з розміщеним поздовжньо каналом матки, яка має 17-35 бічних відгалужень з кожного боку. Який вид гельмінтів паразитує у кишечнику жінки?',
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
    'Taenia solium',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Echinococcus granulosus',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Hymenolepis nana',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taeniarhynchus saginatus',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Diphyllobothrium latum',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 123
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікарні потрапив чоловік 35-ти років, який втратив зір на одне око. З анамнезу відомо, що хворий часто вживав недостатньо просмажений шашлик. Після рентгенологічного обстеження та проведення імунологічних реакцій лікар поставив діагноз цистицеркоз. Який гельмінт є збудником цього захворювання?',
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
    'Diphyllobothrium latum',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taenia solium',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichocephalus trichiurus',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Trichinella spiralis',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Taeniarhynchus saginatus',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 124
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дівчина 15-ти років була доставлена до лікарні з запаленням червоподібного відростку. Аналіз крові показав ознаки анемії. У фекаліях було виявлено яйця гельмінта, які мають лимоноподібну форму (50х30 мкм), з "пробочками" на полюсах. Який вид гельмінту паразитує у хворої?',
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
    'Анкілостома',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Волосоголовець',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карликовий ціп’як',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гострик',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ехінокок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 125
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до лікаря-уролога зі скаргами на біль під час сечовипускання. У сечі, що отримана на аналіз у денний час, були виявлені яйця з характерним шипом. З анамнезу відомо, що хворий недавно повернувся з Австралії. Який найбільш вірогідний діагноз?',
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
    'Шистосомоз кишковий',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Опісторхоз',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шистосомоз урогенітальний',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дикроцеліоз',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шистосомоз японський',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 126
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на сепсис призначили антимікробний препарат з групи фторхінолонів. Оберіть його серед наведених препаратів:',
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
    'Цефпіром',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалексин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 127
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для лікування бактеріальної пневмонії було призначено бензилпеніциліну натрієву сіль. Який механізм антимікробної дії препарату?',
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
    'Пригнічення синтезу клітинної стінки мікроорганізмів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антагонізм з параамінобензойною кислотою',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення SH-груп ферментів мікроорганізмів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення внутрішньоклітинного синтезу білка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення активності холінестерази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 128
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікарі-інфекціоністи широко застосовують антибіотики, які інгібують синтез нуклеїнових кислот. Який етап біосинтезу гальмує рифампіцин?',
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
    'Транскрипцію в прокаріотах і еукаріотах',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ініціацію транскрипції в прокаріотах',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сплайсинг у прокаріотах та еукаріотах',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Термінацію транскрипції в прокаріотах і еукаріотах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікацію в прокаріотах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 129
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки, яка тривалий час приймала антибіотики, розвинулось ускладнення на слизовій оболонці порожнини рота: запальний процес з білим нальотом. Під час бактеріологічного дослідження нальоту виявлено дріжджеподібні грибки Candida albicans. Який лікарський засіб треба використати для лікування цього ускладнення?',
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
    'Бісептол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліміксин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 130
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Батьки для профілактики кишкових інфекцій у дитини 3-х років тривало застосовували антибіотики. Через місяць стан дитини погіршився. У крові - виражена лейкопенія і гранулоцитопенія. Який найбільш вірогідний механізм виявлених змін у крові?',
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
    'Гемолітичний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Віковий',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аутоімунний',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мієлотоксичний',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перерозподільний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 131
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Встановлено, що деякі сполуки, наприклад, токсини грибів та деякі антибіотики, можуть пригнічувати активність РНК-полімерази. Порушення якого процесу відбувається в клітині у випадку пригнічування даного ферменту?',
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
    'Репарація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансляція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Процесінг',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транскрипція',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 132
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До стоматолога звернулася мати зі скаргами на руйнування зубів у дитини 2-х років. Під час огляду молочні зуби деформовані, уражені карієсом, у шийки коричнева облямівка. З анамнезу встановлено, що мати під час вагітності приймала антибіотики без контролю лікаря. Вкажіть, антибітики якої групи, що мають найбільш виражену тератогенну дію, могла приймати мати?',
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
    'Макроліди',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрацикліни',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 133
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До стоматолога звернулася мати дитини 2-х років, яка під час вагітності, у зв’язку з інфекційним захворюванням, безсистемно приймала антибіотики. Під час огляду у дитини відзначається руйнування різців, емаль зубів жовтого кольору, у шийки зубів коричнева облямівка. Який з препаратів має виражену тератогенну дію?',
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
    'Доксацикліну гідрохлорид',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ксантинола нікотинат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіокс',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Октадин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуросемід',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 134
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Деякі лікарські препарати за механізмом дії є активаторами або інгібіторами певних ферментів. Який з нижченаведених представників належить до групи інгібіторів?',
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
    'Крохмаль',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміак',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфаніламіди',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фосфоліпіди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Іони натрія, калія, магнія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 135
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт віком 50 років із загостренням хронічного гнійного середнього отиту лікувався сульфаніламідами протягом 3-х тижнів. На 20-й день лікування антибіотиками у нього з’явилися симптоми анемії. Аналіз сироватки крові виявив антитіла до еритроцитів. Укажіть основний механізм розвитку анемії в цьому разі.',
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
    'Гемоліз еритроцитів',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дефіцит заліза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хронічна крововтрата',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення кровотворення',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпоплазія кісткового мозку',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 136
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт тривалий час застосовував великі дози сульфаніламідних препаратів. Нещодавно в нього з''явилися: значна задишка в спокої, слабкість, втрата апетиту, порушення сну. Лабораторне дослідження крові виявило наявність в крові метгемоглобіну. Який механізм інактивації гемоглобіну в еритроцитах відбувається в пацієнта?',
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
    'Сполучення гемоглобіну з сульфаніламідами',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада окисних ферментних систем',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пошкодження білка в гемоглобіні',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада відновних ферментних систем',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Окислення заліза в гемоглобіні',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 137
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої 36-ти років, яка лікувалася сульфаніламідами з приводу респіраторної вірусної інфекції, в крові спостерігаються гіпорегенераторна нормохромна анемія, лейкопенія, тромбоцитопенія. В кістковому мозку - зменшення кількості мієлокаріоцитів. Яка це анемія?',
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
    'Залізодефіцитна',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіпопластична',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Постгеморагічна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гемолітична',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'В 12-фолієводефіцитна',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 138
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після прийому сульфаніламідів у хворого виникли лихоманка, блювання і стул з кров’ю. У крові: лейк.-0,9 • 10^9 /л (гранул.- 0,7 • 10^9 /л), лейкоаглютиніни. Який з термінів найбільш точно характеризує виявлені зміни у крові?',
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
    'Гемодилюція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Агранулоцитоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкопенія',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лейкоз',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 139
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для лікування деяких інфекційних захворювань, викликаних бактеріями, застосовуються сульфаніламідні препарати, що блокують синтез фактора росту бактерій. Назвіть механізм їх дії:',
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
    'Інгібують всмоктування фолієвої кислоти',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Є антивітамінами параамінобензойної кислоти',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Є алостеричними інгібіторами ферментів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Є алостеричними ферментами',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Беруть участь в окисно-відновних процесах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 140
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої дитини гінгівіт, спричинений анаеробною інфекцією. Яку групу протимікробних засобів потрібно призначити для лікування?',
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
    'Нітроімідазоли',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітрофурани',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфаніламіди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліміксини',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 141
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 37-ми років внаслідок тривалої антибіотикотерапії розвинувся дисбактеріоз кишечнику. Який вид препаратів необхідно використати для нормалізації кишкової мікрофлори?',
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
    'Аутовакцини',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еубіотики',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітаміни',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфаніламіди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактеріофаги',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 142
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого із запаленням легень непереносимість антибіотиків. Який з комбінованих сульфаніламідних препаратів слід призначити хворому?',
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
    'Етазол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфадиметоксин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бісептол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфацил натрію',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоцид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 143
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворої 38 років після прийому аспірину і сульфаніламідів спостерігається посилений гемоліз еритроцитів, викликаний недостатністю глюкозо-6-фосфатдегідрогенази. Порушенням утворення якого коферменту зумовлена ця патологія?',
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
    'Убіхінон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піридоксальфосфат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'НАДФН',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ФМНН2',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ФАДН2',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 144
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до лікаря зі скаргами на гнійничкові висипання на шкірі кінцівок. Який антисептик необхідно призначити хворому?',
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
    'Розчин йоду спиртовий',
    true,
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
    'Сибазон',
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
    'Гепарин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 145
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря звернувся хворий з пошкодженою стопою, забинтованою брудною марлевою пов''язкою, просоченою гнійними виділеннями. Спроба зняти пов''язку для огляду і обробки рани викликає гострий біль, так як вона прилипла до раневої поверхні. Який антисептик полегшить видалення пов''язки і очистить рану від бруду і гною?',
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
    'Фурацилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Калію перманганат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Перекис водню',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етоній',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етакридин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 146
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому для обробки опіків призначили лікарський засіб, антисептичні властивості якого пов’язані з утворенням атомарного кисню в присутності органічних речовин. Препарату властива також в’яжуча (протизапальна) дія, обумовлена утворенням альбумінатів. Визначте препарат:',
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
    'Хлоргексидину біглюконат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Калію перманґанат',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Спирт етиловий',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Водню пероксид',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію гідрокарбонат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 147
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого для обробки опікової поверхні шкіри було використано препарат, антисептичні властивості якого забезпечуються вільним киснем, що відщеплюється у присутності органічних речовин. Який лікарський засіб був використаний?',
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
    'Калію перманганат',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію гідрокарбонат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кислота борна',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хлоргексидин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фурацилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 148
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Укажіть препарат, що належить до групи β-лактамних антибіотиків.',
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
    'Офлоксацин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 149
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Вагітна жінка захворіла на пневмонію; термін вагітності 20 тижнів. Який хіміотерапевтичний препарат можна порадити лікарю для призначення хворій без загрози для розвитку плоду?',
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
    'Офлоксацин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфален',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 150
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До дермато-венерологічного диспансера надійшла жінка 30 років із діагнозом: первинний сифіліс. Який засіб найдоцільніше їй призначити?',
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
    'Феноксимстилпеніцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефамізин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 151
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловікові, хворому на сифіліс, призначили лікарський засіб, в основі механізму дії якого є порушення утворення муреїну, що призводить до загибелі збудника. Визначте препарат:',
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
    'Бійохінол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніциліну натрієва сіль',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксацикліну гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 152
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому зі стрептококовою інфекцією ясен було призначено препарат, що містить у своїй структурі b-лактамне кільце. Який препарат із наведених належить до цієї групи?',
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
    'Левоміцетин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 153
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на стрептококову пневмонію призначено протимікробний засіб, що порушує побудову мікробної оболонки. Який це препарат?',
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
    'Бензилпеніциліну натрієва сіль',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксицикліну гідрохлорид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцину сульфат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 154
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтці встановлено діагноз: первинний сифіліс. Який із нижченаведених препаратів треба їй призначити?',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Феноксиметилпеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефамезин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 155
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на стрептококову пневмонію призначено протимікробний засіб, що порушує побудову мікробної оболонки. Який це препарат?',
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
    'Бензилпеніциліну натрієва сіль',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцину сульфат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксицикліну гідрохлорид',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 156
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який антибактеріальний засіб не призначається дітям через негативний вплив на розвиток кісткової тканини?',
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
    'Нітроксолін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніцилін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксациклін',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ко-тримоксазол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хлорамфенікол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 157
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 45 років, який хворіє на гостру пневмонію, призначено антибіотик із групи пеніцилінів, Під час проведення проби на індивідуальну чутливість до антибіотика виникла алергічна реакція. Який із нижченаведених препаратів необхідно призначити пацієнту в цьому разі?',
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
    'Біцилін-5',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Феноксиметилпеніцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 158
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтці віком 30 років, яка перебуває на 32 тижні вагітності, у складі комплексної терапії виразкової хвороби шлунка лікар призначив антибіотик. Який із нижченаведених препаратів можна рекомендувати у разі виникнення такого ускладнення?',
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
    'Левоміцетин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 159
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Інфекційний хворий сенсибілізований до бензилпеніциліну. Застосування якого антибіотика буде найбезпечнішим у цьому разі?',
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
    'Біциліну',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіциліну',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксациліну',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амоксициліну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитромицину',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 160
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловік з уретритом протягом тижня самостійно лікувався антибіотиком пеніцилінового ряду, але це не покращило його стан. Проведене бактеріологічне дослідження показало, що збудником захворювання є мікоплазми. Чому препарат, який приймав пацієнт, виявився неефективним?',
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
    'Мікоплазми утворюють фермент, який руйнує пеніцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікоплазми не мають клітинної стінки',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мембрана мікоплазм містить холестерин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікоплазми не утворюють відповідних транспортних білків',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Збудник розмножується всередині клітин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 161
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтці віком 30 років, яка перебуває на 32 тижні вагітності, у складі комплексної терапії виразкової хвороби шлунка лікар призначив антибіотик. Який із наведених нижче препаратів можна рекомендувати у разі виникнення такого ускладнення?',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 162
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До інфекційного відділення надійшов чоловік із діагнозом: холера. Яка основна група антибіотиків для лікування цього захворювання?',
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
    'Тетрацикліни',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макроліди',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 163
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіку з гострим гастроентероколітом після проведених бактеріологічних досліджень установлено діагноз холера. Який антибіотик є засобом вибору у разі цього захворювання?',
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
    'Доксициклін',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалексин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 164
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на крупозну пневмонію внутрішньом’язово ввели бензилпеніцилін-натрій. Через кілька хвилин у пацієнта розвинувся анафілактичний шок. Який лікарський засіб необхідно ввести хворому?',
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
    'Норадреналіну гідротартрат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кофеїн-бензоат натрію',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ефедрин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мезатон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Адреналіну гідрохлорид',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 165
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіку 18-ти років з приводу флегмони плеча було зроблено внутрішньом’язову ін’єкцію пеніциліну. Після цього у нього з’явилися тахікардія, ниткоподібний пульс, АТ знизився до 80/60 мм рт.ст. Який вид фармакологічної реакції розвинувся?',
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
    'Центральна дія',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рефлекторна дія',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Потенціювання',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Периферична дія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анафілаксія',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 166
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитина 10-ти років страждає на стафілококовий дерматит. Лікування бензилпеніциліном не дало результатів. Призначення комбінованого препарату пеніциліну з клавулановою кислотою дало швидке одужання. Яка причина позитивної дії цього препарату?',
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
    'Гальмування транспептидази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування аденозиндезамінази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада транслокази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інактивація β-лактамази',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація фосфодіестерази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 167
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворій 43-х років для лікування бронхопневмонії призначена бензилпеніциліну натрієва сіль. Який з вказаних побічних ефектів найбільш характерний для даного засобу?',
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
    'Ураження печінки',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Алергічні реакції',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Агранулоцитоз',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неврит слухового нерва',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Анемія',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 168
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка в період вагітності тривалий час безконтрольно приймала хіміотерапевтичний препарат. Через деякий час у неї погіршився апетит, з’явились нудота, пронос. З часом виникла жовтяниця. У новонародженого відмічено порушення росту кісток. Який препарат з групи тетрацикліну приймала жінка?',
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
    'Азитроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніциліну натрієва сіль',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксицикліну гідрохлорид',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бісептол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 169
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Дитина 10-ти років страждає на стафілококовий дерматит. Лікування бензилпеніциліном не дало результатів. Призначення комбінованого препарату пеніциліну з клавулановою кислотою дало швидке одужання. Яка причина позитивної дії цього препарату?',
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
    'Інактивація бета-лактамази',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада транслокази',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Активація фосфодіестерази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування аденозиндезамінази',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмування транспептидази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 170
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини 5-ти років гостра правобічна нижньодольова пневмонія. При посіві харкотиння виявлено, що збудник захворювання стійкий до пеніциліну, але чутливий до макролідів. Який препарат найбільш доцільно використати в даному випадку?',
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
    'Гентаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 171
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для лікування бактеріальної пневмонії було призначено бензилпеніциліну натрієву сіль. Який механізм антимікробної дії препарату?',
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
    'Антагонізм з параамінобензойною кислотою',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення SH-груп ферментів мікроорганізмів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення синтезу клітинної стінки мікроорганізмів',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення внутрішньоклітинного синтезу білка',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пригнічення активності холінестерази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 172
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 19-ти років, хвора на первинний сифіліс, отримує комплексну терапію, до складу якої входить натрієва сіль бензилпеніциліну. Вкажіть механізм дії цього препарату:',
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
    'Блокада синтезу РНК',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада тіолових груп ензимів',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада синтезу білків цитоплазми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада синтезу пептидогліканів мікробної оболонки',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада синтезу ДНК',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 173
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого важка післяопераційна псевдомонадна інфекція. Який з перелічених антибіотиків показаний хворому?',
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
    'Бензилпеніцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амікацину сульфат',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксициклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 174
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінці 30 років на 32 тижні вагітності лікар, в складі комплексної терапії виразкової хвороби шлунка, призначив антибіотик. Вкажіть, який препарат можна застосувати у даному випадку?',
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
    'Гентаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
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
  -- Питання 175
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До стоматолога звернулася мати зі скаргами на руйнування зубів у дитини 2-х років. Під час огляду молочні зуби деформовані, уражені карієсом, у шийки коричнева облямівка. З анамнезу встановлено, що мати під час вагітності приймала антибіотики без контролю лікаря. Вкажіть, антибітики якої групи, що мають найбільш виражену тератогенну дію, могла приймати мати?',
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
    'Макроліди',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрацикліни',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 176
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 60 років госпіталізований до хірургічного відділення в зв’язку з інфекцією, викликаною синьогнійною паличкою, чутливою до антибіотика пеніцилінового ряду. Вкажіть, який з наведених пеніцилінів має виражену активність по відношенню до Pseudomonas aeruginosa?',
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
    'Метицилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Феноксиметилпеніцилін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Карбеніцилін',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 177
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'З гнійної рани хворого виділений патогенний стафілокок і визначена чутливість його до антибіотиків: пеніцилін - зона затримки росту 8 мм ; оксацилін - 9 мм ; ампіцилін - 10 мм ; гентаміцин - 22 мм ; лінкоміцин - 11 мм. Який антибіотик необхідно вибрати для лікування хворого?',
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
    'Ампіцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінкоміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 178
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора 27-ми років закрапала в очі краплі, до складу яких входить пеніцилін. Через декілька хвилин з’явився свербіж та печіння тіла, набряк губ та повік, свистячий кашель; став падати артеріальний тиск. Які імуноглобуліни беруть участь в розвитку даної алергічної реакції?',
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
    'IgG та IgD',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IgA та IgM',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IgE та IgG',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IgM та IgD',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'IgM та IgG',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 179
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, що приймая великі дози стрептоміцину, спостерігається втрата слуху. Функція яких клітин внутрішнього вуха була ушкоджена в цьому разі?',
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
    'Волоскових',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клітин Дейтерса',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клітин-стовпів',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фалангових',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сполучнотканинних',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 180
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на туберкульоз після тривалого лікування з''явилися шум і дзвін у вухах, зниження слуху, висипання на шкірі, набряк слизових оболонок і порушилася координація рухів. Після скасування препарату стан хворого значно покращився. Який препарат приймав хворий?',
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
    'Ізоніазид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бепаск',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 181
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 38 років, який перебуває на стаціонарному лікуванні, діагностовано нозокоміальну пневмонію. Лікар призначив йому антибіотик широкого спектра дії, який стійкий до β-лактамаз, пригнічує синтез пептидоглікану оболонки бактерій та практично не руйнується в ниркових канальцях дегідропептидазою-1. Який антибіотик призначили пацієнту?',
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
    'Еритроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Меропенем',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левофлоксацин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 182
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнт отримує антибіотикотерапію. Який процес передачі спадкової інформації пригнічує стрептоміцин?',
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
    'Процесинг',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікацію',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транскрипцію',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Синтез азотистих основ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Трансляцію',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 183
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У дитини 5-ти років гостра правобічна нижньодольова пневмонія. При посіві харкотиння виявлено, що збудник захворювання стійкий до пеніциліну, але чутливий до макролідів. Який препарат найбільш доцільно використати в даному випадку?',
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
    'Гентаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 184
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на пневмонію призначений антибіотик із групи макролідів. Вкажіть цей препарат:',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 185
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому зі стрептококовою інфекцією ясен було призначено препарат, що містить у своїй структурі b-лактамне кільце. Який препарат із наведених належить до цієї групи?',
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
    'Левоміцетин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 186
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Укажіть препарат, який чинить згубний вплив на еритроцитарні форми малярійних плазмодів, дизентерійну амебу та застосовується для лікування та профілактики малярії, лікування амебіазу та колагенозів.',
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
    'Хінгамін',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еметину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 187
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 37-ми років звернулася до гінеколога з приводу запального процесу піхви, який супроводжується свербінням та пінистими виділеннями. Баканаліз встановив наявність трихомонадної інфекції. Який засіб найбільш ефективний у даному випадку?',
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
    'Еритроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітроксолін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ністатин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 188
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Препарат чинить згубний вплив на еритроцитарні форми малярійних плазмодіїв, дизентерійну амебу. Застосовується для лікування та профілактики малярії, лікування амебіазу й колагенозів. Визначте цей препарат:',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еметину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 189
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого важка післяопераційна псевдомонадна інфекція. Який з перелічених антибіотиків показаний хворому?',
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
    'Бензилпеніцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амікацину сульфат',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксициклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 190
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до лікаря зі скаргами на дисфункцію кишечнику. Лікар констатував симптоми дуоденіту і ентериту. Під час лабораторного дослідження встановлено діагноз: лямбліоз. Застосування якого препарату показане?',
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
    'Мономіцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 191
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 45 років, який хворіє на гостру пневмонію, призначено антибіотик із групи пеніцилінів, Під час проведення проби на індивідуальну чутливість до антибіотика виникла алергічна реакція. Який із нижченаведених препаратів необхідно призначити пацієнту в цьому разі?',
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
    'Біцилін-5',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Феноксиметилпеніцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 192
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У п''ятирічної дитини відзначається змішана інвазія аскаридами та гостриками. Який протигельмінтний препарат необхідно призначити?',
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
    'Фенасал',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазину адипінат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 193
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта виявлено змішану глистну інвазію: аскаридоз кишечника та трематодоз печінки. Який протигельмінтний препарат доцільно призначити у цьому разі?',
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
    'Хлоксил',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левамізол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазину адипінат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пірантел',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 194
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту проведено апендектомію. Що доцільно призначити першочергово для хіміопрофілактики анаеробних ускладнень у післяопераційний період?',
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
    'Ампіцилін + оксацилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефатоксим',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Триметоприм + сульфаметоксазол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 195
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до стоматолога зі скаргами на гнійне запалення ясен. Який препарат буде найбільш ефективним, якщо передбачається анаеробна природа збудника?',
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
    'Гентаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін-натрій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітроксолін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ко-тримоксазол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 196
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Жінка 37-ми років звернулася до гінеколога з приводу запального процесу піхви, який супроводжується свербінням та пінистими виділеннями. Баканаліз встановив наявність трихомонадної інфекції. Який засіб найбільш ефективний у даному випадку?',
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
    'Еритроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітроксолін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ністатин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 197
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловікові, який хворіє на перитоніт, до комплексної антибактеріальної терапії включено препарат, що належить до похідних нітроімідазолу. Який із наведених препаратів потрібно призначити?',
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
    'Метронідазол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Норфлоксацин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінезолід',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Уросульфан',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактрим',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 198
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до лікаря зі скаргами на пронос і біль в животі протягом 5-ти днів, підвищену температуру тіла до 37,5°С. Бактеріологічно встановлений діагноз амебна дизентерія. Вкажіть препарат вибору для лікування цього захворювання:',
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
    'Метронідазол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ітраконазол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фурацилін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацикловір',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 199
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту для лікування лямбліозу призначено синтетичний протипротозойний засіб з групи похідних імідазолу. Перед цим лікар суворо попередив пацієнта про те, що під час лікування забороняється вживати алкогольні напої. Який препарат був призначений?',
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
    'Фуразолідон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 200
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до лікаря зі скаргами на дисфункцію кишечнику. Лікар констатував симптоми дуоденіту і ентериту. Під час лабораторного дослідження встановлено діагноз: лямбліоз. Застосування якого препарату показане?',
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
    'Мономіцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 201
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікар-стоматолог для лікування гінгівіту призначив пацієнту препарат з протипротозойною та антибактеріальною діями, який може викликати відразу до алкоголю. Вкажіть препарат, який призначив лікар:',
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
    'Левоміцетин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінкоміцину гідрохлорид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефтріаксон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 202
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 30-ти років звернувся до лікаря зі скаргами на пронос і біль у животі протягом 5-ти днів, підвищення температури тіла до 37,5oC з ознобами. Напередодні хворий був у лісі, де випив води з відкритого водоймища. Встановлено лабораторно підтверджений діагноз: амебна дизентерія. Вкажіть препарат вибору для лікування цього захворювання:',
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
    'Еметина гідрохлорид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фталазол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 203
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий звернувся до стоматолога зі скаргами на гнійне запалення ясен. Який препарат буде найбільш ефективним, якщо припускається анаеробна природа збудника?',
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
    'Котримоксазол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін-натрій',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітроксолін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 204
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворій на виразкову хворобу шлунка в якості етіотропної терапії призначили препарат, що пригнічує ріст і розмноження H.pylori. Назвіть цей препарат:',
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
    'Фуросемід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Празозин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глаувент',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Корглікон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 205
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хвора звернулася до лікаря зі скаргами на неприємні відчуття в епігастрії, нудоту, зниження апетиту. При дослідженні дуоденального вмісту виявлено лямблії. Який препарат слід призначити?',
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
    'Рифампіцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацикловір',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 206
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 52 років діагностовано системний амебіаз з ураженням кишечнику, печінки, легень. Який препарат слід призначити?',
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
    'Ентеросептол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хініофон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
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
  -- Питання 207
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностовано змішаний кишковий гельмінтоз. Для лікування призначено антигельмінтний препарат надширокого спектру дії, що викликає пригнічення полімеризації білка гельмінтів тубуліну. Що це за препарат?',
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
    'Метронідазол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Альбендазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксициклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 208
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Здорова людина перебуває в небезпечному за захворюванням на малярію районі. Який із зазначених препаратів необхідно призначити з метою особистої хіміопрофілактики малярії?',
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
    'Бісептол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфален',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
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
  -- Питання 209
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на сепсис призначили антимікробний препарат з групи фторхінолонів. Оберіть його серед наведених препаратів:',
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
    'Цефпіром',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалексин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 210
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий під час курсу лікування метронідазолом вжив невелику кількість алкоголю, внаслідок чого розвинулось тяжке отруєння. Поясніть причину цього:',
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
    'Алергічна реакція',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серцево-судинна недостатність',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Неврологічні розлади',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Накопичення ацетальдегіду',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушення функції нирок',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 211
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хлопчика 6-ти років відзначається змішана інвазія аскаридами та гостриками. Який протиглисний препарат слід призначити для одноразового прийому?',
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
    'Піперазину адипінат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноакрихін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Насіння гарбуза',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенасал',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 212
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Призначення доксицикліну гідрохлориду викликало порушення симбіозу мікробної флори в кишечнику. Визначити тип порушень при антибіотикотерапії:',
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
    'Сенсибілізація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Дисбактеріоз',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Суперінфекція',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ідіосинкразія',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактеріоз',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 213
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта виявлено змішану глистну інвазію: аскаридоз кишечника та трематодоз печінки. Який протигельмінтний препарат доцільно призначити у цьому разі?',
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
    'Хлоксил',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левамізол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазину адипінат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пірантел',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 214
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту для лікування лямбліозу призначено синтетичний протипротозойний засіб з групи похідних імідазолу. Перед цим лікар суворо попередив пацієнта про те, що під час лікування забороняється вживати алкогольні напої. Який препарат був призначений?',
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
    'Фуразолідон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метациклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 215
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка 52-х років діагностовано системний амебіаз з ураженням кишківника, печінки, легенів. Який препарат слід призначити?',
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
    'Хініофон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ентеросептол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метронідазол',
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
  -- Питання 216
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Укажіть препарат, який чинить згубний вплив на еритроцитарні форми малярійних плазмодів, дизентерійну амебу та застосовується для лікування та профілактики малярії, лікування амебіазу та колагенозів.',
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
    'Хінгамін',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еметину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 217
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Препарат чинить згубний вплив на еритроцитарні форми малярійних плазмодіїв, дизентерійну амебу. Застосовується для лікування та профілактики малярії, лікування амебіазу й колагенозів. Визначте цей препарат:',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еритроміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Хінгамін',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Еметину гідрохлорид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 218
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жінки, яка тривалий час приймала антибіотики, розвинулось ускладнення на слизовій оболонці порожнини рота: запальний процес з білим нальотом. Під час бактеріологічного дослідження нальоту виявлено дріжджеподібні грибки Candida albicans. Який лікарський засіб треба використати для лікування цього ускладнення?',
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
    'Бісептол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Поліміксин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 219
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта віком 18 років після перенесеної пневмонії, яку лікували В-лактамним антибіотиком, виник кандидоз. Який протигрибковий засіб треба призначити?',
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
    'Фталазол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бісептол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 220
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого, який тривалий час приймав тетрациклін, виник кандидоз слизових оболонок. Який лікарський препарат слід призначити для його лікування?',
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
    'Амфотеріцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фурадонін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гризеофульвін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Нітрофунгін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ітраконазол',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 221
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого за лабораторними даними визначили аскаридоз. Який засіб треба призначити?',
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
    'Фенасал',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 222
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту встановлено діагноз: аскаридоз. Який лікарський засіб треба йому призначити?',
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
    'Мебендазол',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенасал',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 223
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хлопчика 5 років, якого непокоїть анальний свербіж, виявлені черв’яки класу нематод (гострики). Оберіть лікарський засіб для дегельмінтації дитини:',
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
    'Сім’я гарбуза',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Празіквантель',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фенасал',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноакрихін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 224
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта виявлено змішану глистну інвазію: аскаридоз кишечника та трематодоз печінки. Який протигельмінтний препарат доцільно призначити у цьому разі?',
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
    'Хлоксил',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левамізол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піперазину адипінат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пірантел',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 225
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту встановлено діагноз: аскаридоз. Який лікарський засіб необхідно призначити для лікування?',
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
    'Піперазин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ніклозамід',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мебендазол',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 226
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До інфекційного відділення надійшов чоловік із діагнозом: холера. Яка основна група антибіотиків для лікування цього захворювання?',
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
    'Тетрацикліни',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макроліди',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 227
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До стоматолога звернулася мати зі скаргами на руйнування зубів у дитини 2-х років. Під час огляду молочні зуби деформовані, уражені карієсом, у шийки коричнева облямівка. З анамнезу встановлено, що мати під час вагітності приймала антибіотики без контролю лікаря. Вкажіть, антибітики якої групи, що мають найбільш виражену тератогенну дію, могла приймати мати?',
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
    'Макроліди',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрацикліни',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 228
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому після апендектомії з метою профілактики інфекції призначено антибіотик групи цефалоспоринів. Порушення якого процесу лежить в основі протимікробної активності антибіотиків цієї групи?',
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
    'Синтез нуклеїнових кислот',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рибосомальний синтез білку',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Блокада холінестерази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Утворення мікробної стінки',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Енергетичний обмін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 229
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 68 років встановлено діагноз: стрептококова пневмонія. Розпочав лікування цефалоспорином ІІІ покоління. Механізм дії цього препарату пов’язаний із пригніченням бактеріального ферменту. Укажіть цей фермент.',
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
    'Б-лактамаза',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ДНК-гіраза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацетилтрансфераза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ДНК-залежна РНК-полімераза',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Транспептидаза',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 230
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-стоматолога звернулася мати 10-річного хлопчика, хворого на гнійний гінгівіт, з запитанням: чи можна застосувати для лікування хвороби препарати з групи фторхінолонів. Лікар дав негативну відповідь, мотивуючи це тим, що фторхінолони:',
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
    'Викликають пошкодження хрящової тканини у дітей',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Викликають пошкодження дентину',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Провокують кровотечу з ясен',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Проявляють припікаючу дію на слизові оболонки',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сприяють виведенню кальцію з кісток і зубів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 231
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У чоловіка виявлено гонорею за даними бактеріоскопії мазка з уретри. Враховуючи, що препаратами вибору для лікування гонореї є фторхінолони, хворому необхідно призначити:',
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
    'Фторурацил',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Уросульфан',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 232
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'За даними бактеріоскопії мазку з уретри у хворого виявлено гонорею. Враховуючи, що препаратами вибору для лікування гонореї є фторхінолони, хворому необхідно призначити:',
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
    'Уросульфан',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фторурацил',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ципрофлоксацин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 233
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Який антибіотик належить до групи макролідів?',
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
    'Гентаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 234
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До стоматолога звернулася мати зі скаргами на руйнування зубів у дитини 2-х років. Під час огляду молочні зуби деформовані, уражені карієсом, у шийки коричнева облямівка. З анамнезу встановлено, що мати під час вагітності приймала антибіотики без контролю лікаря. Вкажіть, антибітики якої групи, що мають найбільш виражену тератогенну дію, могла приймати мати?',
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
    'Макроліди',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрацикліни',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 235
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на пневмонію призначений антибіотик із групи макролідів. Вкажіть цей препарат:',
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
    'Тетрациклін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гентаміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азитроміцин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 236
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До інфекційного відділення надійшов чоловік із діагнозом: холера. Яка основна група антибіотиків для лікування цього захворювання?',
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
    'Тетрацикліни',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пеніциліни',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоспорини',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аміноглікозиди',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Макроліди',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 237
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для лікування урогенітальних інфекцій використовують хінолони - інгібітори ферменту ДНК-гірази. Який процес порушується під дією хінолонів у першу чергу?',
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
    'Ампліфікація генів',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Зворотна транскрипція',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікація ДНК',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рекомбінація генів',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Репарація ДНК',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 238
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта з ослабленим імунітетом, віком 36 років, діагностовано простий герпес слизової оболонки губ. Як компонент комплексної терапії лікар призначив йому препарат місцевого застосування, що має противірусну активність. Укажіть цей лікарський засіб.',
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
    'Інтерферон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацикловір',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амікацин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тималін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ремантадин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 239
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після переохолодження у ділянці крил носа та верхньої губи з''явились герпетичні висипання. Для лікування була застосована мазь. Який противірусний засіб містить застосована мазь?',
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
    'Ацикловір',
    true,
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
    'Дексаметазон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азидотимідин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтерферон',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 240
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Школяр 8-ми років звернувся до стоматолога з герпетичним висипанням на нижній губі. Який найбільш ефективний засіб слід призначити?',
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
    'Ампіцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацикловір',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксацилін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фурадонін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоконазол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 241
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностовано герпетичний стоматит. Що слід призначити в даному випадку для лікування?',
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
    'Сульфацил натрію',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ацикловір',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Клотримазол',
    false,
    3,
    NOW(),
    NOW()
  );
  -- Питання 242
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після переохолодження у ділянці крил носа та верхньої губи з''явились герпетичні висипання. Для лікування була застосована мазь. Який противірусний засіб містить застосована мазь?',
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
    'Ацикловір',
    true,
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
    'Дексаметазон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Азидотимідин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інтерферон',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 243
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта після переохолодження на губах з’явились герпетичні висипання. Для лікування призначений крем ацикловіру, терапевтичний ефект якого пояснюється здатністю:',
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
    'Гальмувати активність протеази',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гальмувати активність ДНК-полімерази',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Порушувати функцію зворотної транскриптази',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Інгібувати нейрамінідазу',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Уповільнювати реплікацію РНК- і ДНК-геномних вірусів',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 244
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-дерматолога звернулася пацієнтка віком 22 роки зі скаргами на гнійний висип на обличчі та спині. Із анамнезу відомо, що в неї виявлено H. Pylori. Ураховуючи таку супутню патологію, лікар призначив антибактеріальний препарат, який буде діяти як на збудників інфекцій м’яких тканин, так і на H. pylori. Який антибактеріальний препарат призначив лікар?',
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
    'Ізоніазид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Озельтамівір',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кларитроміцин',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 245
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після лікування протитуберкульозним лікарським засобом у жінки віком 40 років виникли явища невриту зорового нерва, порушення памʼяті та судоми. Який препарат приймала пацієнтка?',
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
    'Канаміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ПАСК',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тіоацетазон',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 246
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на туберкульоз в комплексній терапії призначено препарат - похідне гідразиду ізонікотинової кислоти. Визначити цей препарат:',
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
    'Ізоніазид',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канаміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалоридин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 247
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'В тубдиспансері у хворого на інфільтративну форму туберкульозу легень, який лікувався ізоніазидом, проявилися симптоми В6-гіповітамінозу. Чому ізоніазид призводить до цього явища?',
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
    'Прискорюється біотрансформація',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сповільнюється всмоктування вітаміну',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Прискорюється елімінація',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Утворюється міцний зв’язок з білками плазми крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид є антагоністом вітаміну В6',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 248
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з діагнозом: туберкульоз легень, для лікування призначено протитуберкульозний препарат першого ряду, що спричинив розвиток невриту лицьового нерва та порушення рівноваги. Визначте цей лікарський засіб.',
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
    'Ізоніазид',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бісептол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 249
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта, який тривалий час хворіє на туберкульоз, виявлено внутрішньоклітинне розташування мікобактерій. Який з вказаних препаратів обов''язково повинен бути включений в комплексну терапію туберкульозу?',
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
    'Натрію парааміносаліцилат',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіонамід',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 250
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Після лікування високоефективним протитуберкульозним засобом у жінки 48-ми років виникли явища невриту зорового нерва, порушення пам’яті, судоми. Який із зазначених протитуберкульозних препаратів приймала хвора?',
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
    'Рифампіцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канаміцину сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ПАСК',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 251
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому встановлено діагноз - активний вогнищевий туберкульоз легень. Вкажіть, який із препаратів найбільш доцільно призначити в першу чергу?',
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
    'Етоксид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіонамід',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфален',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклосерин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 252
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 55 років для лікування легеневої форми туберкульозу, в рамках комплексної терапії, призначено протитуберкульозний засіб. Який лікарський засіб виявляє антимікробну активність виключно до мікобактерій туберкульозу?',
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
    'Ізоніазид',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклосерин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канаміцину сульфат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гатіфлоксацин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 253
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Для комплексної терапії туберкульозу було призначено препарат, що є антагоністом вітаміну В6. Назвіть цей препарат:',
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
    'Етамбутол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левофлоксацип',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ПАСК',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 254
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого діагностували легеневу форму туберкульозу. Який з наведених лікарський засіб використовують для лікування туберкульозу?',
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
    'Пеніцилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Норсульфазол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
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
  -- Питання 255
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на туберкульоз легень призначений препарат першого ряду, який спричинив розвиток невриту лицьового нерва та порушення рівноваги. Вкажіть цей лікарський засіб:',
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
    'Фуразолідон',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бісептол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Левоміцетин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефазолін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 256
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому встановлено діагноз - активний вогнищевий туберкульоз легень. Вкажіть, який із препаратів йому найбільш доцільно призначити в першу чергу',
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
    'Циклосерин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етоксид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сульфален',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіонамід',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 257
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого 26-ти лет, що приймав високоефективний протитуберкульозний засіб, наприкінці курсу лікування розвинувся периферичний неврит. Який препарат викликав ускладнення?',
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
    'Ципрофлоксацин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флориміцину сульфат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 258
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на туберкульоз призначено комплексне лікування, до складу якого входить ізоніазид. До якої групи препаратів за хімічною будовою належить цей засіб?',
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
    'Похідне гідразиду ізонікотинової кислоти',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Похідне параамінобензойної кислоти',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Антибіотик групи стрептоміцину',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Напівсинтетичний антибіотик',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Похідне парааміносаліцилової кислоти',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 259
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з активною формою туберкульозу призначили ізоніазид. Який вітамінний препарат необхідно застосовувати для профілактики побічної дії ізоніазиду?',
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
    'Піридоксину гідрохлорид',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токоферолу ацетат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ціанокобаламін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рутин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретинолу ацетат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 260
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з туберкульозом призначено антибіотик. Під час застосування препарату можливе виникнення порушень функції печінки, лейкопенія, забарвлення біологічних рідин у червоний колір. Який лікарський засіб був призначений?',
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
    'Піразинамід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклосерин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію парааміносаліцилат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 261
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту віком 40 років, який хворіє на туберкульоз легень, призначено ізоніазид. Нестача якого вітаміну може розвинутися внаслідок тривалого прийому цього препарату?',
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
    'Біотину',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піридоксину',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фолієвої кислоти',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тіаміну',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кобаламіну',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 262
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'До лікаря-дерматолога звернулася пацієнтка віком 22 роки зі скаргами на гнійне висипання на обличчі та спині. Із анамнезу відомо, що у неї виявлено Н.pylori. Враховуючи таку супутню патологію, лікар призначив антибактеріальний препарат, який буде діяти як на збудників інфекцій мʼяких тканин, так і на H. pylori. Який антибактеріальний препарат призначив лікар?',
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
    'Кларитроміцин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Озельтамівір',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флуконазол',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 263
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чоловіку віком 40 років, який хворіє на туберкульоз легень, призначено ізоніазид. Дефіцит якого вітаміну може розвинутися унаслідок тривалого вживання цього лікарського засобу?',
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
    'Біотину',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піридоксину',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кобаламіну',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фолієвої кислоти',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тіаміну',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 264
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на активну форму туберкульозу призначили ізоніазид. Який вітамінний препарат необхідно застосовувати для профілактики побічної дії ізоніазиду?',
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
    'Рутин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Токоферолу ацетат',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ретинолу ацетат',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ціанокобаламін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піридоксину гідрохлорид',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 265
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Чим пояснити той факт, що для лікування туберкульозу доза ізоніазиду підбирається індивідуально, з обов’язковим контролем після перших прийомів препарату його вмісту в сечі?',
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
    'Розвитком гемолітичної анемії',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Подразнювальною дією препарату',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Генетично обумовленою швидкістю ацетилювання препарату у різних людей',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Розвитком ниркової недостатності',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Гіперглікемією, що виникає на тлі приймання препарату',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 266
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на туберкульоз призначено бактерицидний антибіотик, побічним ефектом якого є забарвлення біологічних рідин у червоний колір. Визначте препарат:',
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
    'Етамбутол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Протіонамід',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 267
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий 47-ми років з діагнозом вогнищевий туберкульоз верхньої долі правої лєгені, в скиді комбінованої терапії одержує ізоніазид. Через деякий час пацієнт почав пред’являти скарги на м’язову слабкість, зниження шкірної чутливості, порушення зору, координації рухів. Який вітамінний препарат доцільно використати для усунення даних явищ?',
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
    'Вітамін В6',
    true,
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
    'Вітамін C',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін В12',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін A',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 268
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий з діагнозом ''вогнищевий туберкульоз верхньої долі правої легені'' в складі комбінованої терапії одержує ізоніазид. Через деякий час пацієнт почав пред’являти скарги на м’язову слабкість, зниження шкірної чутливості, порушення зору, координації рухів. Який вітамінний препарат доцільно використати для усунення даних явищ?',
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
    'Вітамін D',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін В6',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін C',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін В12',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін A',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 269
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У клінічній практиці для лікування туберкульозу застосовують препарат ізоніазид - антивітамін, який здатний проникати у туберкульозну паличку. Туберкулостатичний ефект обумовлений порушенням процесів реплікації, окисновідновних реакцій, завдяки утворенню несправжнього коферменту з:',
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
    'КоQ',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ФМН',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'НАД',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ТДФ',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ФАД',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 270
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікування туберкульозу здійснюється за допомогою комбінованої хіміотерапії, що включає речовини різного механізму дії. Яке з протитуберкульозних засобів пригнічує в мікобактеріях транскрипцію РНК на ДНК?',
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
    'Ізоніазид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіонамід',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'ПАСК',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 271
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворий з діагнозом вогнищевого туберкульозу верхньої частки правого легкого отримує ізоніазид в складі комбінованої терапії. Через деякий час пацієнт почав скаржитися на м''язову слабкість, зниження чутливості шкіри, порушення зору, координації рухів. Який вітамінний препарат доцільно використовувати для усунення цих явищ?',
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
    'Вітамін С',
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
    'Вітамін А',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін В12',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Вітамін В6',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 272
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на туберкульоз після тривалого лікування з''явилися шум і дзвін у вухах, зниження слуху, висипання на шкірі, набряк слизових оболонок і порушилася координація рухів. Після скасування препарату стан хворого значно покращився. Який препарат приймав хворий?',
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
    'Ізоніазид',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бепаск',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцину сульфат',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 273
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Збудник туберкульозу може існувати як внутрішньоклітинно, так і позаклітинно, а також у казеозному некрозі. Укажіть препарат, який здатний згубно діяти на мікобактерії туберкульозу будь-якої локалізації.',
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
    'Етамбутол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію аміносаліцилат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 274
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту з туберкульозом призначено антибіотик. Під час застосування препарату можливе виникнення порушень функції печінки, лейкопенія, забарвлення біологічних рідин у червоний колір. Який лікарський засіб був призначений?',
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
    'Піразинамід',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклосерин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію парааміносаліцилат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 275
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностований первинний туберкульоз легень. Призначення якого протитуберкульозного засобу з групи антибіотиків, що порушують синтез РНК мікобактерій, є бажаним?',
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
    'ПАСК',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канаміцину сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піразинамід',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 276
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнтці 68-ми років з туберкульозом легень призначено антибіотик, прийом якого може викликати забарвлення сечі та сльозної рідини в червоний колір. Назвіть його:',
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
    'Рифампіцин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Амоксиклав',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етіонамід',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 277
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Збудник туберкульозу може існувати як внутрішньоклітинно, так і позаклітинно, а також у казеозному некрозі. Укажіть препарат, який здатний згубно діяти на мікобактерії туберкульозу будь-якої локалізації.',
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
    'Етамбутол',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ізоніазид',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Натрію аміносаліцилат',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 278
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У хворого на туберкульоз легень непереносимість аміноглікозидного антибіотика амікацину. Який протитуберкульозний антибіотик можна включити до складу комплексної терапії у даному випадку?',
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
    'Амоксицилін',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоміцин',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бензилпеніцилін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канзміцин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 279
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Хворому на туберкульоз легень було призначено препарат з групи антибіотиків, що відноситься до високоефективних протитуберкульозних засобів. Який препарат був призначений?',
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
    'ПАСК',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Тетрациклін',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефалексин',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Циклосерин',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 280
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Працівник соціальної служби після тривалого спілкування з людиною без визначеного місця проживання захворів на туберкульоз. До складу комплексного лікування було включено напівсинтетичний антибіотик широкого спектру дії. Вкажіть препарат:',
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
    'Еритроміцин',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цефотаксим',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Лінкоміцин',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ампіцилін',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 281
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У пацієнта діагностований первинний туберкульоз легень. Призначення якого протитуберкульозного засобу з групи антибіотиків, що порушують синтез РНК мікобактерій, є бажаним?',
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
    'ПАСК',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Рифампіцин',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Етамбутол',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Канаміцину сульфат',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Піразинамід',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 282
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Пацієнту, який хворіє на легеневий туберкульоз, призначено найбільш ефективне специфічне лікування - протитуберкульозний антибіотик. Укажіть цей препарат.',
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
    'Рифампіцин',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Стрептоцид',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактрім',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Доксициклін',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Фуразолідон',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 283
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Лікарі-інфекціоністи широко застосовують антибіотики, які інгібують синтез нуклеїнових кислот. Який етап біосинтезу гальмує рифампіцин?',
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
    'Транскрипцію в прокаріотах і еукаріотах',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Ініціацію транскрипції в прокаріотах',
    true,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сплайсинг у прокаріотах та еукаріотах',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Термінацію транскрипції в прокаріотах і еукаріотах',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Реплікацію в прокаріотах',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 284
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лабораторії визначено чутливість стафілокока до антибіотиків та отримано такі результати досліджения щодо діаметра зон затримки росту: пеніцилін - 25 мм, гентаміци - 22 мм. Який метод дослідження використано?',
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
    'Паперових дисків',
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
    'Серійних розведень',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Біометричний',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактеріоскопічний',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 285
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У лабораторії визначено чутливість стафілокока до антибіотиків та отримано такі результати дослідження щодо діаметра зон затримки росту: пеніцилін - 8 мм, оксацилін - 8 мм, ампіцилін -25 мм, гентаміцин - 22 мм. Який метод дослідження використано?',
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
    'Біометричний',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серійних розведень',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Бактеріоскопічний',
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
    'Паперових дисків',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 286
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У приймальному відділенні лікарні відбирають матеріал для бактеріологічного дослідження. Із якою метою треба взяти матеріал у пацієнта з гнійним ураженням глибоких тканин нижньої кінцівки?',
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
    'Для встановлення етіології гнійного процесу та визначення чутливості до антибіотиків',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Для виявлення збудника, щоб попередити внутрішньолікарняне інфікування',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Для виявлення патогенного стафілокока та визначення антибіотикограми',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Для підтвердження анаеробної інфекції',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Для виявлення токсичності збудника',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 287
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Юнак 17 років страждає на фурункульоз, викликаний умовно-патогенним Staphylococcus epidermidis. Яке дослідження найдоцільніше провести, щоб правильно вибрати препарат для лікування цього хворого?',
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
    'Дослідити біохімічні властивості',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Виявити фактори патогенності',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Визначити антигенні властивості',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Визначити фаговар',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Скласти антибіотикограму',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 288
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'Організми, які в процесі еволюції не створили захисту від H2O2, живуть лише в анаеробних умовах. Які з нижченаведених ферментів можуть руйнувати пероксид водню?',
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
    'Оксигеназа та гідроксилаза',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Оксигеназа та каталаза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Пероксидаза та каталаза',
    true,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитохромоксидаза, цитохром b5',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Флавінзалежні оксидази',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 289
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При патологічних процесах, які супроводжуються гіпоксією, відбувається неповне відновлення молекули кисню в дихальному ланцюзі і накопичення пероксиду водню. Вкажіть фермент, який забезпечує його руйнування:',
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
    'Каталаза',
    true,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Аконітаза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Кетоглутаратдегідрогеназа',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Сукцинатдегідрогеназа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Цитохромоксидаза',
    false,
    4,
    NOW(),
    NOW()
  );
  -- Питання 290
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'При нанесенні стоматологом пероксиду водню на слизову оболонку порожнини рота з''явилася інтенсивна піна. Який фермент спричиняє такий ефект?',
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
    'Ацетилтрансфераза',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Холінестераза',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Метгемоглобінредуктаза',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Глюкозо-6-фосфатдегідрогеназа',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Каталаза',
    true,
    4,
    NOW(),
    NOW()
  );
  -- Питання 291
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (
    v_topic_id,
    'У жіночій консультації обстежується жінка, у якої було декілька мимовільних викиднів. На підставі клініко-епідеміологічного анамнезу було припущено хронічний токсоплазмоз. Яке лабораторне дослідження буде найефективнішим для підтвердження діагнозу?',
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
    'Мікроскопія піхвового мазка',
    false,
    0,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Шкірно-алергічна проба',
    false,
    1,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазка фекалій',
    false,
    2,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Мікроскопія мазка крові',
    false,
    3,
    NOW(),
    NOW()
  );
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (
    v_question_id,
    'Серологічні реакції',
    true,
    4,
    NOW(),
    NOW()
  );
  
  RAISE NOTICE 'Додано питань: 291';
END $$;
