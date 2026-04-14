-- SQL для додавання питань до розділу 23: Нормальний розвиток і структура, вікові зміни
-- Автоматично згенеровано
-- Кількість питань: 216

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо або створюємо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Загальний покрив (шкіра та її деривати)'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    INSERT INTO courses (title, faculty, description, order_index, is_active, created_at, updated_at)
    VALUES (
      'Загальний покрив (шкіра та її деривати)',
      'medical',
      'Загальний покрив (шкіра та її деривати)',
      5,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_course_id;
    RAISE NOTICE 'Створено курс "%s" з ID: %', 'Загальний покрив (шкіра та її деривати)', v_course_id;
  END IF;

  -- Створюємо або знаходимо topic
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Нормальний розвиток і структура, вікові зміни'
  LIMIT 1;

  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Нормальний розвиток і структура, вікові зміни',
      'Tests',
      0,
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
  VALUES (v_topic_id, 'У трирічної дитини зі встановленим діагнозом: квашіоркор спостерігається порушення зроговіння епідермісу та збільшення його злущення, є жирова інфільтрація печінки. Який тип голодування спостерігається в цьому разі?', 'medium', 0, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирове', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білкове', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Енергетичне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінеральне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У судово-медичній практиці періодично виникає необхідність виконати ідентифікацію особистості. Із цією метою використовують метод дактилоскопії. Особливостями будови якого шару шкіри визначається індивідуальний малюнок шкіри пальців людини?', 'medium', 1, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епідермісу і дерми', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сосочкового шару дерми', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епідермісу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епідермісу, дерми і гіподерми', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сітчастого шару дерми', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У гістологічному препараті біоптату епідермісу шкіри здорової дорослої людини в базальному шарі видно клітини, що діляться. Який процес забезпечують ці клітини?', 'medium', 2, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фізіологічну регенерацію', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Репаративну регенерацію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Апоптоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адаптацію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Диференціювання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В епідермісі є клітини, що виконують захисну функцію та мають моноцитарний генез. Які це клітини?', 'medium', 3, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити остистого шару', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Лангерганса', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити базального шару', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити зернистого шару', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На електронній мікрофотографії епідермісу шкіри серед клітин кубічної форми виділяються паросткові клітини, в цитоплазмі яких добре розвинутий апарат Гольджі, багато рибосом і меланосом. Назвіть ці клітини:', 'medium', 4, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Лангерганса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланоцити', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Меркеля', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинні базофіли', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У мертвонародженої дитини шкіра потовщена, нагадує панцир черепахи, вушні раковини недорозвинені. Гістологічно в шкірі: надмірне зроговіння, атрофія зернистого шару епідермісу, відсутні запальні зміни. Яке захворювання найбільш вірогідно?', 'medium', 5, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоплакія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іхтіоз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еритроплакія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматоміозит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ксеродермія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У зародка порушено процес сегментації дорзальної мезодерми та утворення сомітів. У якій частині шкіри можливі порушення розвитку?', 'medium', 6, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальні залози', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волосся', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Потові залози', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епідерміс', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На обмеженій ділянці епідермісу внаслідок травми відсутні шари аж до росткового. Назвати клітини, які послужать основним джерелом його регенерації.', 'medium', 7, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шари шипуватих і зернистих клітин незруйнованої ділянки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини блискучого шару незруйнованої ділянки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шари базальних клітин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шари зернистих клітин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шари шипуватих клітин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Вивчення відбитків виступів епідермісу пальців рук (дактилоскопія) використовується в криміналістиці для ідентифікації особи, а також для діагностики генетичних аномалій, і зокрема хвороби Дауна. Який шар шкіри визначає індивідуальність відбитків?', 'medium', 8, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сітчастий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Роговий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базальний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блискучий', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сосочковий', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час парадонтозу відбувається деструкція білкових та полісахаридних компонентів сполучної тканини. Який із наведених нижче білків входить до складу сполучної тканини?', 'medium', 9, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансферин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колаген', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Церулоплазмін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антитрипсин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альбумін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після загоєння рани на її місці утворився рубець. Яка речовина є основним компонентом цього різновиду сполучної тканини?', 'medium', 10, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еластин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіалуронова кислота', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератансульфат', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хондроїтин-сульфат', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колаген', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На місці механічного пошкодження шкіри завдяки процесам регенерації формується пухка волокниста сполучна тканина. Які її клітини продукують білки: колаген, еластин та компоненти міжклітинної речовини?', 'medium', 11, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинні базофіли', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адипоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Макрофаги', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібробласти', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плазмоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дитини виявлено спадкове захворювання шкіри ангідроз (відсутність потових залоз). Унаслідок цього порушені важливі функції шкіри - потовиділення та терморегуляція. Ця вада є наслідком порушення в ембріогенезі закладки:', 'medium', 12, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматому', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спланхнотому', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Склеротому', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерми', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерми', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт скаржиться на сухість шкіри голови, свербіж, ламкість і випадіння волосся. При обстеженні встановлений діагноз: себорея. З порушенням діяльності яких клітин це пов’язано?', 'medium', 13, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини потових залоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини сальних залоз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланоцити', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епітеліоцити', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адипоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 40-ка років ушкоджені міжпальцеві проміжки на ногах: шкіра мокне, відшаровується, з’явилися тріщини. При посіві зі шкрібу шкіри на середовище Сабуро виросли пухнасті колонії, білі зверху та зеленувато-жовті внизу. У мазках з верхньої частини колоній видно конідії у вигляді «дубинок» з 1-5 клітинами. Які ще органи найбільш імовірно може уразити цей збудник?', 'medium', 14, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфатичні судини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Слизова статевих шляхів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підшкірна клітковина', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волосся', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нігті', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До косметолога звернулася пацієнтка зі скаргами на появу чорних цяток на обличчі. Після обстеження було встановлено, що поява цяток пов’язана з порушенням виділення секрету сальних залоз. Який тип секреції характерний для цих залоз?', 'medium', 15, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мерокриновий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Макроапокриновий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мерокриновий та мікроапокриновий', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мікроапокриновий', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Голокриновий', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої під час профілактичного обстеження на медіальній стінці лівої пахвової западини виявлений збільшений лімфовузол метастатичного походження. Вкажіть найбільш вірогідну локалізацію первинної пухлини:', 'medium', 16, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Молочна залоза', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піднижньощелепна слинна залоза', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлунок', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легеня', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щитоподібна залоза', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка звернулася до лікаря зі скаргами на ущільнення у верхньо-бічній ділянці правої молочної залози. Які лімфатичні вузли повинен перевірити лікар, щоб переконатися в нерозповсюдженні патологічного процесу?', 'medium', 17, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пахвові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжреберні', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верхні діафрагмальні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білягрудинні', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передні середостінні', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В епідермісі є клітини, що виконують захисну функцію та мають моноцитарний генез. Які це клітини?', 'medium', 18, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити остистого шару', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Лангерганса', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити базального шару', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кератиноцити зернистого шару', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Вивчення відбитків виступів епідермісу пальців рук (дактилоскопія) використовується в криміналістиці для ідентифікації особи, а також для діагностики генетичних аномалій, і зокрема хвороби Дауна. Який шар шкіри визначає індивідуальність відбитків?', 'medium', 19, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сітчастий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Роговий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базальний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блискучий', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сосочковий', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Одним із правил хірургії є виконання розрізів уздовж так званих ліній Лангера (ліній натягу шкіри). Яка тканина утворює найміцніший шар дерми — сітчастий шар дерми?', 'medium', 20, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна неоформлена сполучна тканина', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухка волокниста сполучна тканина', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретикулярна сполучна тканина', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна оформлена сполучна тканина', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епітеліальна тканина', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час огляду лікарем-педіатром на шкірі десятирічної дитини виявлено множинні петехії, а також спостерігається кровоточивість ясен та знижений рівень вітаміну С в сечі. Який процес порушений у цьому разі?', 'medium', 21, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез протеогліканів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація гіалуронідази', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розпад колагену', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розпад протеогліканів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез колагену', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У разі нестачі вітаміну С виникає порушення структури колагенових волокон. Яка стадія їх синтезу порушується?', 'medium', 22, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Приєднання глюкозних і галактозних залишків', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утворення гідроксипроліну і гідроксилізину', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Агрегація тропоколагену і утворення фібрил', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Угворення г-карбоксиглутамату', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відщеплення сигнальних олігопептидів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 30 років хворіє близько року, коли вперше з''явилися болі в області суглобів, їх припухлість, почервоніння шкіри над ними. Попередній діагноз - ревматоїдний артрит. Однією з ймовірних причин цього захворювання є зміна в структурі білка сполучної тканини:', 'medium', 23, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міозин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Муцин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Овальбумін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тропонін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колагена', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з частими кровотечами у внутрішні органи і слизові оболонки у складі колагенових волокон виявлено пролін і лізин. Відсутність якого вітаміну спричиняє порушення їх гідроксилювання?', 'medium', 24, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'D', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'А', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'К', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Е', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'С', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До косметолога звернувся пацієнт із проханням вивести татуювання на його плечі. Яка речовина, що міститься в сполучній тканині, обмежує поширення барвника?', 'medium', 25, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіалуронідаза', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібронектин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіалуронова кислота', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колаген', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еластин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Судини, які мають вигляд сплющених ендотеліальних трубок, не мають базальної мембрани і перицитів, ендотелій цих судин фіксований стропними філаментами до колагенових волокон сполучної тканини. Які це судини?', 'medium', 26, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріо-венозні анастомози', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемокапіляри', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Венули', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріоли', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфокапіляри', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 36-ти років страждає на колагеноз. Збільшення вмісту якого метаболіту найбільш вірогідно буде встановлено у сечі?', 'medium', 27, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Оксипроліну', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індикану', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уробіліногену', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта стоматологічного відділення виявлено хворобу Педжета, що супроводжується деградацією колагену. Вирішальним фактом для постановки діагнозу було виявлення у сечі хворого підвищеного рівня:', 'medium', 28, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триптофану', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Оксипроліну', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серину', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аланіну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аргініну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До фібрилярних елементів сполучної тканини належать колаген, еластин та ретикулін. Вкажіть амінокислоту, яка входить тільки до складу колагену і визначення якої в біологічних рідинах використовується для діагностики захворювань сполучної тканини:', 'medium', 29, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гліцин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенілаланін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідроксипролін', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пролін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У вагітної жінки на передній черевній стінці виявлено пухлиноподібне утворення, яке виникло на місці видаленої два роки тому пухлини. Утворення має щільну консистенцію й розміри 2х1 см, з чіткими межами. При гістологічному дослідженні виявлено, що пухлина побудована з диференційованої сполучної тканини з переважанням колагенових волокон. Про яку пухлину слід думати?', 'medium', 30, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейоміома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гібернома', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібросаркома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпома', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Десмоїд', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 38-ми років загинув при спробі підйому вантажу. Розвинувся колаптоїдний стан. На аутопсії виявлений розрив обширної аневризми грудного відділу аорти. За життя страждав на вісцеральний сифіліс. Який патологічний процес в даному випадку обумовив зменшення міцності стінки аорти, її розширення й розрив?', 'medium', 31, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зникнення еластичних волокон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зміни інтими за типом "шагреневої шкіри"', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атрофія м’язового шару', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зникнення колагенових волокон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новоутворення судин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У шкірі виявлена щільна, рухома, чітко відмежована від оточуючих тканин пухлина. На розрізі вона білого кольору, представлена волокнистою тканиною. Мікроскопічно: хаотично переплетені колагенові волокна, клітин мало. Що це за пухлина?', 'medium', 32, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Десмоїд', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фіброма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістіоцитома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматофіброма', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з частими кровотечами з внутрішніх органів і слизових оболонок виявлені пролін і лізин у складі колагенових волокон. Через відсутність якого вітаміну порушено їх гідроксилювання?', 'medium', 33, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін E', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тіамін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін C', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін A', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін K', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворих на колагеноз має місце процес деструкції сполучної тканини. Це підтверджується збільшенням у крові:', 'medium', 34, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вмісту оксипроліну та оксилізину', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активності ізоферментів ЛДГ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активності трансаміназ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вмісту креатину та креатиніну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вмісту уратів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Більша частина учасників експедиції Магелана до Америки загинула від авітамінозу. Це захворювання проявлялося загальною слабкістю, підшкірними крововиливами, випадінням зубів, кровотечею з ясен. Як називається цей авітаміноз?', 'medium', 35, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліневрит (бері-бері)', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рахіт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пелагра', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анемія Бірмера', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скорбут (цинга)', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого спостерігаються часті кровотечі з внутрішніх органів, слизових оболонок. Аналіз виявив недостатність гідроксипроліну та гідроксилізину у складі колагенових волокон. Через нестачу якого вітаміну порушено в організмі пацієнта процеси гідроксилювання названих амінокислот?', 'medium', 36, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін РР', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін А', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін Н', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін С', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін К', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Юнак 25 років звернувся до лікаря зі скаргами на загальну слабкість, швидку втомлюваність, дратівливість, зниження працездатності, кровоточивість ясен. Недостатність якого вітаміну може мати місце у цьому разі?', 'medium', 37, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолієва кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рибофлавін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретинол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аскорбінова кислота', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тіамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дівчинка 10-ти років часто хворіє на гострі респіраторні інфекції, після яких спостерігаються множинні точкові крововиливи в місцях тертя одягу. Який гіповітаміноз має місце в дівчинки:', 'medium', 38, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'B2', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'C', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'B1', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В6', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Підвищена ламкість судин, руйнування емалі і дентину у хворих на цингу здебільшого обумовлені порушенням дозрівання колагену. Який етап модифікації проколагену порушений при цьому авітамінозі?', 'medium', 39, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утворення поліпептидних ланцюгів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відщеплення N-кінцевого пептиду', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глікозилювання гідроксилізинових залишків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідроксилювання проліну', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Видалення з проколагену С-кінцевого пептиду', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До стоматолога звернувся хворий зі скаргами на біль, почервоніння слизової оболонки порожнини рота, припухлість ясен. Було встановлено діагноз: герпетичний гінгівостоматит. Це захворювання міг викликати вірус:', 'medium', 40, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простого герпесу тип', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простого герпесу тип', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитомегалії', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епштейна-Барр', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Оперізуючого лишаю', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Гострий герпетичний гінгівостоматит є найпоширенішою первинною інфекцією, яку спричиняє вірус простого герпесу першого типу. Який матеріал треба взяти лікарю-стоматологу для лабораторного підтвердження діагнозу?', 'medium', 41, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мокротиння', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рідину з везикул', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Слину', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кров', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У неврологічному відділенні з приводу оперізуючого лишаю проходить курс лікування жінка 50-ти років. Внаслідок реактивації якого вірусу виникло це захворювання?', 'medium', 42, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусу кору', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусу простого ГЕРПЕСУ 1-го типу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусу цитомегалії', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусу простого ГЕРПЕСУ 2-го типу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусу Зостер (вітряної віспи)', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У посіві гною з фурункула виявлено мікроби кулястої форми, які розташовані, як «гроно» винограду. Які мікроби виявлено?', 'medium', 43, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стрептококи', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Диплококи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мікрококи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стафілококи', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тетракоки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта в ділянці нижньої щелепи виник болючий вузлик червоного кольору. Гістологічно спостерігається: скупчення гнійного ексудату в декількох волосяних фолікулах. Яка клініко-морфологічна форма запалення спостерігається у цьому випадку?', 'medium', 44, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Карбункул', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флегмона', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фурункул', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсцес', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натічник', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого через декілька годин після опіку в ділянці гіперемії та набряку шкіри з’явилося вогнище некрозу. Який головний механізм забезпечує посилення руйнівних явищ в осередку запалення?', 'medium', 45, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинна альтерація', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діапедез еритроцитів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинна альтерація', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еміграція лімфоцитів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація фібробластів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Через декілька годин після опіку в ділянці гіперемії та набряку шкіри у хворого з’явилось вогнище некрозу. Який головний механізм забезпечує посилення руйнівних явищ в осередку запалення?', 'medium', 46, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинна альтерація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація фібробластів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еміграція лімфоцитів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діапедез еритроцитів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинна альтерація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який переніс травму і подальший геморагічний бурсит лівого колінного суглоба, під час огляду за 3 місяці відзначається обмеження обсягу рухів у цьому суглобі внаслідок утворення рубця. Який компонент запалення є провідним у розвитку цього ускладнення?', 'medium', 47, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтерація первинна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ексудація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтерація вторинна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення мікроциркуляції', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Відповідно до сучасної концепції атерогенезу «Response to injury», атеросклероз є проявом хронічного запалення в інтимі артерій. З якою стадією запалення пов’язане формування фіброзних бляшок у разі атеросклерозу?', 'medium', 48, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинна альтерація', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинна альтерація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ексудація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансформація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У відпочиваючого в санаторії у результаті сонячного опіку на шкірі спини утворилися міхурці, заповнені світлою рідиною, оточені зоною гіперемії, болісні. Який з перерахованих механізмів лежить в основі формування ексудації у вогнищі запалення?', 'medium', 49, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення виведення рідини з тканини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еміграція лейкоцитів з судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення рівня кейлонів у тканині', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення колоїдно-осмотичного тиску в тканині', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення кількості лізосомальних ферментів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На відміну від нервових клітин, які зазвичай не розмножуються, стовбурові клітини можуть відновлюватися багато разів. Процес багаторазового відновлення клітин називають:', 'medium', 50, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атрофія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертрофія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Апоптоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Диференціація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Експериментально з бластоцисти людини одержано плюрипотентні ембріональні стовбурові клітини. Упродовж декількох місяців у лабораторії на поживному середовищі вони утворили мільйони нових клітин. Яку назву має процес багаторазового відновлення клітин?', 'medium', 51, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Апоптоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дозрівання', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Диференціація', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Репарація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 52-х років, хвора на рак молочної залози, пройшла курс променевої терапії. Розмір пухлини зменшився. Який з наведених механізмів ушкодження клітини найбільше обумовлює ефективність променевої терапії?', 'medium', 52, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мутагенез', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утворення вільних радикалів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізис NK-клітинами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертермія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Однією з патогенетичних ланок у розвитку променевої хвороби є інтенсифікація процесів вільнорадикального окиснення речовин. Які речовини є основним джерелом утворення вільних радикалів?', 'medium', 53, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпіди', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вода', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гормони', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Надмірне утворення вільних радикалів спричиняє пошкодження клітин. Укажіть неферментативний фактор антиоксидантної системи захисту клітини.', 'medium', 54, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамін E', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкуронідаза', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутатіонредуктаза', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Супероксиддисмутаза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ціанокобаламін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На гістологічному препараті у сполучній тканині знайдено великі клітини, заповнені базофільною метахроматичною зернистістю; гістохімічно встановлено, що гранули містять гепарин та гістамін. Які клітини, найбільш імовірно, знайдено в препараті?', 'medium', 55, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плазмоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адипоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібробласти', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тучні', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Макрофаги', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарні звернулася жінка віком 71 рік, яка після прийому ацетилсаліцилової кислоти, що вживає з метою профілактики тромбозу, відчула такі симтоми: гострий біль в епігастрії, нудоту, печію, закрепи. Лікар діагностував виразку шлунка. Який механізм ульцерогенної дії ацетилсаліцилової кислоти лежить в основі розвитку виразки у цієї пацієнтки?', 'medium', 56, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація входження Са +в клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення утворення простагландинів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення синтезу фосфоліпази А2', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення синтезу шлункового соку', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення утворення лейкотрієнів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При утилізації арахідонової кислоти за циклооксигеназним шляхом утворюються біологічно активні речовини. Вкажіть їх:', 'medium', 57, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландини', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматомедини', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біогенні аміни', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсуліноподібні фактори росту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після вживання ацетилсаліцилової кислоти у пацієнта зʼявився біль у ділянці шлунка як наслідок загострення виразкової хвороби. Що лежить в основі ульцерогенності цього препарату?', 'medium', 58, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовчогінна дія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулює дію пепсину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спазм судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антипростагландинова дія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунодепресивний ефект', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При утилізації арахідонової кислоти за циклооксигеназним шляхом утворюються біологічно активні речовини. Вкажіть їх:', 'medium', 59, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландини', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматомедини', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біогенні аміни', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсуліноподібні фактори росту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Аспірин має протизапальну дію, оскільки пригнічує активність циклооксигенази. Рівень яких біологічно активних речовин буде при цьому знижуватися?', 'medium', 60, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катехоламінів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Йодтиронінів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландинів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієнів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біогенних амінів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Арахідонова кислота, як незамінний компонент їжі, є попередником біологічно активних речовин. Які сполуки синтезуються з цієї кислоти?', 'medium', 61, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Етаноламін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксани', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трийодтиронін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До біорегуляторів клітинних функцій ліпідної природи належать тромбоксани. Яка кислота є джерелом для синтезу цих сполук?', 'medium', 62, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфатидна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пальмітоолеїнова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Арахідонова', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пальмітинова', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеаринова', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У 25-річного пацієнта на тлі гострого запалення легень із температурою тіла 40,1^oC визначено лейкоцитоз 14,9 г/л із чітким зсувом лейкоформули вліво. Який із наведених чинників безпосередньо підвищує в кістковому мозку і проліферацію, і диференціацію лейкоцитів?', 'medium', 63, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колонієстимулюючий чинник', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухлинний некротичний чинник', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкін-10', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкін-1', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простациклін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці з діагнозом: ішемічна хвороба серця, призначено ацетилсаліцилову кислоту. Синтез якої ендогенної речовини зумовлює антиагрегантну дію цього препарату?', 'medium', 64, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландину E1', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландину E2', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксану А2', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієнів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландину I2 (простацикліну)', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Відомо, що ацетилсаліцилова кислота та глюкокортикоїди мають виражену протизапальну дію. Укажіть на синтез яких біологічно активних речовин не впливає ацетилсаліцилова кислота на відміну від глюкокортикоїдів.', 'medium', 65, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландинів Е', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієнів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простациклінів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксанів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландинів F', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Одними з медіаторів запалення клітинного походження є лейкотрієни. Під впливом якого ферменту утворюються ці біологічно активні речовини?', 'medium', 66, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклооксигенази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпооксигенази', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпази А2', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклооксигенази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксансинтетази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку віком 27 років проведено туберкулінову пробу Манту. Через 24 год на місці інʼєкції виник інфільтрат 40х35 мм, шкіра над яким гіперемована. Яка з груп біологічно активних речовин насамперед визначила розвиток алергічного запалення у пацієнта?', 'medium', 67, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кініни', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієни', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біогенні аміни', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфокіни', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого із запаленням легень спостерігається підвищення температури тіла. Яка біологічно активна речовина відіграє провідну роль у виникненні цього прояву?', 'medium', 68, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикінін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієни', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкін-I', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При моделюванні запалення нижньої кінцівки у тварини підвищилася температура тіла, збільшився вміст антитіл та лейкоцитів у крові. Які речовини зумовили розвиток цих загальних реакцій організму при запаленні?', 'medium', 69, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматомедини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїди', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієни', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкіни', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїди', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт віком 60 років звернувся до лікарки з підвищеним артеріальним тиском, який складно коригується стандартними антигіпертензивними препаратами. Під час обстеження лікарка помітила, що в пацієнта є високий рівень ендотеліальної дисфункції. Який із нижченаведених пептидів має виражену гіпотензивну дію, впливаючи на гладкі м’язи?', 'medium', 70, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикінін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триацетин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутатіон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Граміцидин', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Який із нижченаведених медіаторів запалення має властивості ендогенного пірогену?', 'medium', 71, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикінін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкін 1', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксан А2', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 38 років померла під час нападу бронхіальної астми, який не вдалося зняти. В ході гістологічного дослідження у просвіті бронхів виявлені накопичення слизу, в стінці бронхів численні лаброцити, багато з них у стані дегрануляції, а також велика кількість еозинофілів. Який патогенез (механізм розвитку) цих змін у бронхах?', 'medium', 72, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітинно обумовлений цитоліз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гранулематоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитотоксична, цитолітична дія антитіл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атопія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунокомплексний механізм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В осередку запалення утворюється біогенний амін, що має судинорозширювальну дію. Назвіть його:', 'medium', 73, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ГАМК', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триптамін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДОФА', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Який із нижченаведених факторів забезпечує розширення та зростання проникності суди мікроциркуляторного русла?', 'medium', 74, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендотелін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час катаболізму гістидину утворюється біогенний амін, що має потужну судинорозширюючу дію. Назвіть його:', 'medium', 75, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДОФА', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під дією декарбоксилаз утворюються біогенні аміни. Який біогенний амін запускає багатостадійний механізм регуляції секреції НСl у шлунку?', 'medium', 76, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутамін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ГАМК', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 32 роки спостерігається алергічна реакція, яка супроводжується свербіжем, набряками та почервонінням шкіри. Укажіть біогеннинй амін, надлишкове накопичення якого в зонах запалення призводить до розвитку алергічної реакції?', 'medium', 77, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мелатонін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта 35-ти років виявили підвищену кислотність шлункового соку. Блокада яких рецепторів може спричинити її зниження?', 'medium', 78, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'α2 -адренорецептори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'α1 -адренорецептори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β1 -адренорецептори', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'β2 -адренорецептори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамінові', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час огляду шкіри пацієнта лікар помітив запальний процес у вигляді круглих підвищень червонуватого кольору, оточених зоною гіперемії. Який медіатор запалення зумовив явища судинної гіперемії?', 'medium', 79, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізосомальні ферменти', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерлейкін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксан', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фактор активації тромбоцитів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: кропив''янка призначили антигістамінний засіб - димедрол. Укажіть механізм дії цього препарату.', 'medium', 80, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вивільнення гістаміну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація В-лімфоцитів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Взаємодія гістаміну з рецепторами в органах', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утворення комплексу антиген-антиті-ло', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез імуноглобулінів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікарем швидкої допомоги у пацієнта було діагностовано анафілактичний шок, що супроводжувався бронхоспазмом. Виділення якої біологічно активної речовини тканинними базофілами зумовлює таку клінічну симптоматику?', 'medium', 81, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкотрієни', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепарин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикінін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки, яка відпочивала на дачі, відразу після укусу оси виник біль, через кілька хвилин на шкірі в місці укусу з’явився пухир, еритема і сильне свербіння, а ще через деякий час -кропив’янка, експіраторна задишка. Внаслідок дії яких факторів у хворої розвинулась експіраторна задишка?', 'medium', 82, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістамін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізосомальні ферменти', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фактор Хагемана', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Кухар на робочому місці під час приготування їжі отримав опік руки парою. Підвищення концентрації якої речовини викликало почервоніння, набряк та біль ураженої ділянки шкіри?', 'medium', 83, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістаміну', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тіаміну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Галактозаміну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутаміну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На гістологічному препараті у сполучній тканині знайдено великі клітини, заповнені базофільною метахроматичною зернистістю; гістохімічно встановлено, що гранули містять гепарин та гістамін. Які клітини, найбільш імовірно, знайдено в препараті?', 'medium', 84, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плазмоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адипоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібробласти', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тучні', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Макрофаги', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При повторному введенні алергену починається виділення гістаміну тучними клітинами крові. До якого рівня реактивності відноситься така відповідь організму?', 'medium', 85, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Органний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітинний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Молекулярний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субклітинний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На щурах моделювали опіки. Збільшилось утворення гістаміну, серотоніну, кінінів. оксиду азоту. Який тип причинно-наслідкових відносин у патогенезі єднає ці зміни з розвитком артеріальної гіперемії та підвищення проникності судин?', 'medium', 86, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Конвергенція', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дивергенція', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Саногенез', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '''Пряма лінія''', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарні швидкої допомоги доставили дитину 7 років у стані алергічного шоку, який розвинувся після того, як її вжалила оса. У крові підвищена концентрація гістаміну. В результаті якої реакції утворився цей амін?', 'medium', 87, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрооксилювання', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Декарбоксилювання', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відновлення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дегідрування', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дезамінування', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час алергічних реакцій негайного типу виникає дегрануляція базофільних гранулоцитів, які виділяють біологічно активні речовини. Укажіть таку речовину.', 'medium', 88, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фактор Хагемана', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоксан', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилхолін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфокіни', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотонін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У значної кількості пацієнтів перед відвідуванням стоматолога виникає тривожність, страх, пригнічений настрій. Посилення виділення якого медіатора центральної нервової системи може зменшити ці порушення психоемоційного стану у людини?', 'medium', 89, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотоніну', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофаміну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилхоліну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналіну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ГАМК', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У Дитини спостерігаються пелагроподібні зміни шкіри, порушення розумового та фізичного розвитку. Ці симптоми виникли через недостатність в організмі нікотинової кислоти та серотоніну. З порушенням обміну якої амінокислоти це пов’язано ?', 'medium', 90, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метіонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенілаланін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейцин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триптофан', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістидин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка діагностували гостру променеву хворобу. Під час лабораторного дослідження встановлено різке зниження серотоніну в тромбоцитах. Порушення метаболізму якої речовини спричинило такі показники?', 'medium', 91, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенілаланіну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тирозину', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гістидину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '5-окситриптофану', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До клініки госпіталізовано чоловіка з діагнозом: карциноїд кишечника. Аналіз виявив підвищену продукцію серотоніну. Відомо, що ця речовина утворюється з амінокислоти триптофану. Який біохімічний механізм лежить в основі цього процесу?', 'medium', 92, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мікросомальне окиснення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утворення парних сполук', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансамінування', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Декарбоксилювання', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дезамінування', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з діагнозом "злоякісний карциноїд" різко підвищено вміст серотоніну в крові. З якої амінокислоти може утворитися даний біогенний амін?', 'medium', 93, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аланіну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейцину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триптофану', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метіоніну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Треоніну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Антитіла, компоненти системи комплементу та інші білки здатні приєднуватися до антигенів, прискорюючи фагоцитоз. Як називається такий процес?', 'medium', 94, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Опсонізація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кон’ югація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кілінг', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адгезія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процесинг', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дослідник після змішування макрофагів із суспензією бактерій зробив мазок і виявив під мікроскопом, що в макрофагах утворилися великі ендоцитозні пухирці, які зливалися з лізосомами. Як називається цей процес?', 'medium', 95, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піноцитоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екзоцитоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезоцитоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діапедез', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фагоцитоз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час субмікроскопічного дослідження клітини виявлено, що її цитоплазма містить багато лізосом, фагосом, піноцитозних міхурців. Інші органели розвинені помірно. Яку функцію може виконувати така клітина?', 'medium', 96, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фагоцитоз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез ліпідів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбцію іонів натрію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез полісахаридів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Депонування іонів кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої, яка страждає на поліноз, після поїздки за місто з''явилися набряки губ і повік, сльозотеча, виділення з носа, печіння в очах. Який основний механізм розвитку цього набряку?', 'medium', 97, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності капілярів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в капілярах', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску тканин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінку віком 32 роки вжалила оса. На місці укусу виникли набряк і гіперемія. Який механізм набряку є первинним у цьому разі?', 'medium', 98, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утруднення лімфовідтоку', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності капілярів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску тканинної рідини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску крові в капілярах', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дівчинки 6-ти років пастозність повік, губ, шиї, слизової оболонки язика виникла після того, як вона з’їла апельсин. Раніше на апельсини виникали висипання на шкірі, свербіння. Який патогенетичний механізм є провідним у розвитку набряку у дівчинки?', 'medium', 99, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності капілярів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску крові в капілярах', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску тканинної рідини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Юнака 15-ти років вжалила бджола. На місці укусу визначається набряк, гіперемія, підвищення температури. Назвіть ініціальний патогенетичний фактор запального набряку:', 'medium', 100, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення кров’яного тиску в капілярах', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності мікросудин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення осмотичного тиску у вогнищі запалення', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Людину 35-ти років вкусила бджола. На місці укусу комахи визначається набряк, гіперемія, підвищення температури. Назвіть ініціальний патогенетичний фактор запального набряку:', 'medium', 101, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення осмотичного тиску у вогнищі запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності мікросудин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення кров''яного тиску в капілярах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту діагностовано флегмону передпліччя. Під час мікробіологічного аналізу ексудату із зони запалення виявлено стрептококи. Які клітини будуть переважати в ексудаті?', 'medium', 102, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еозинофільні гранулоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Моноцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базофільні гранулоцити', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейтрофільні гранулоцити', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнта віком 45 років шпиталізовано до лікарні зі скаргами на температуру, біль під час дихання, задуху та кашель. Після лабораторної та рентгенодіагностики вставлено діагноз: плеврит. Для евакуації ексудату призначено плевральну пункцію. В якому місці плевральної порожнини знаходиться найбільша кількість ексудату?', 'medium', 103, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реберно-діафрагмальний синус', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Під куполом плеври', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діафрагмально-медіастинальний синус', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реберно-медіастинальний синус', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Під коренем легенів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого запалення легенів ускладнилось ексудативним плевритом. В якому з перелічених анатомічних утворень переважним чином може накопичуватися рідина?', 'medium', 104, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'sinus costodiaphragmaticus pleurae', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'sinus transversus pericardii', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'sinus phrenicomediastinalis pleurae', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'sinus costomediastinalis pleurae', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'sinus obliquus pericardii', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 38 років поступив у терапевтичне відділення з діагнозом: правосторонній ексудативний плеврит. Відкачана з плевральної порожнини грудної клітки рідина прозора, має відносну щільність 1.020; містить 55 г\л, білка альбуміно-глобуліновий коефіцієнт-1.6; загальна кількість клітин-2.8. в 1 мкл; pH-6.5.Який тип ексудату має місце у хворого?', 'medium', 105, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнилісний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дитини 5-ти років, що часто хворіє на респіраторні захворювання, відмічаються екзематозні явища після вживання деяких харчових продуктів, схильність до затяжного перебігу запальних процесів. Який вид діатезу можна припустити в даному випадку?', 'medium', 106, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нервово-артритичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфатико-гіпопластичний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ексудативно-катаральний', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Астенічний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Розтин тіла показує, що м’які мозкові оболонки померлої людини є повноцінними, потовщеннями, непрозорими та мають жовто-зелений колір. Який тип ексудативного запалення може характеризуватися такими змінами в м’яких мозкових оболонках?', 'medium', 107, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з плевритом у плевральній порожнині виявлено рідину з неприємним запахом, що містить біогенні аміни та гази. Який тип запалення спостерігається в цьому випадку?', 'medium', 108, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтеративне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнильне', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 47-ми років впродовж останніх 3-х років хворіє на туберкульоз легень, скаржиться на задишку, важкість в області правого боку грудної стінки, температуру тіла 37,7°С. Виявлено правобічний ексудативний плеврит. Який тип клітин передбачається у плевральному пунктаті?', 'medium', 109, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфоцити', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еозинофіли', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейтрофіли', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еритроцити', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атипові клітини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого запалення легень ускладнилось ексудативним плевритом. В якому з перелічених анатомічних утворень переважно може накопичуватися рідина?', 'medium', 110, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Sinus transversus pericardii', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Sinus costodiaphragmaticus pleurae', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Sinus obliquus pericardii', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Sinus costomediastinalis pleurae', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Sinus phrenicomediastinalis pleurae', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на сухий плеврит вислуховується шум тертя плеври. При ураженні якого виду епітелію відмічається цей симптом?', 'medium', 111, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перехідний епітелій', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Одношаровий кубічний епітелій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Одношаровий плоский епітелій', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багатошаровий епітелій', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Одношаровий призматичний епітелій', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Розтин тіла показує, що м’які мозкові оболонки померлої людини є повноцінними, потовщеннями, непрозорими та мають жовто-зелений колір. Який тип ексудативного запалення може характеризуватися такими змінами в м’яких мозкових оболонках?', 'medium', 112, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час ректороманоскопії в десятирічної дитини виявлено: слизова оболонка прямої та сигмоподібної кишок набрякла, червоного кольору, вкрита товстим шаром слизу. Про яку патологію свідчать зазначені зміни?', 'medium', 113, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Венозне повнокрів''я', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синець', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з плевритом у плевральній порожнині виявлено рідину з неприємним запахом, що містить біогенні аміни та гази. Який тип запалення спостерігається в цьому випадку?', 'medium', 114, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтеративне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнильне', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка віком 50 років, яка довго хворіла на гломерулонефрит, при наростаючих явищах інтоксикації (уремії) померла. Під час розтину тіла виявлено: стінка товстої кишки потовщена, на слизовій оболонці сірувато-білувата плівка, яка тісно зрощена з підлеглою тканиною. На плеврі наявні сіруваті плівки, які легко відділяються. Які види запалення виявлено?', 'medium', 115, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У товстій кишці - крупозне, на плеврі - дифтеритичне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У товстій кишці - серозний катар, на плеврі - крупозне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У товстій кишці - гнійне, на плеврі - крупозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У товстій кишці дифтеритичне, на плеврі – крупозне', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У товстій кишці - гнійне, на плеврі - дифтеритичне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження стегнової кістки виявлено хронічне гнійне запалення компактної речовини та кісткового мозку, утворення секвестрів. Для якого захворювання характерні такі симптоматичні явища?', 'medium', 116, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Періоститу', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретикулосаркоми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Остеобластокластоми', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Остеомієліту', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мієломної хвороби', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дитину госпіталізовано до лікарні в стані асфіксії. Під час огляду гортані виявлено білуваті плівки, що обтурують просвіт дихальних шляхів та легко видаляються. Для якого виду запалення гортані характерні такі ознаки?', 'medium', 117, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До інфекційного відділення госпіталізовано семирічну дитину госпіталізовано, яка скаржиться на різкий біль у горлі під час ковтання. Об''єктивно спостерігається: підвищення температури тіла до 39°С, набряк шиї, мигдалики збільшені, їх слизова оболонка гіперемічна, вкрита великою кількістю плівок білувато-жовтого кольору, які щільно прилягають до слизової оболонки. Під час спроби зняти плівку залишається глибокий дефект тканини, який кровоточить. Який вид запалення у дитини?', 'medium', 118, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка 56 років, який тривалий час хворів на хронічний гломерулонефрит, на поверхні епікарда і перикарда виявили сірувато-білуваті ворсинчасті нашарування («волосате» серце). Про який патологічний процес йдеться?', 'medium', 119, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час макро- та мікроскопічних досліджень ділянки великогомілкової кістки та м''яких тканин довкола виявлено дифузне гнійне запалення, що захоплює кістковий мозок, гаверсові канали та периост, осередки некрозу. Яке захворювання можна припустити?', 'medium', 120, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гематогений остеомієліт', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гематогений остеомієліт', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хвороба Педжета', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Остеонекроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратиреоїдна остеодистрофія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому проведено трепанацію і вишкрібання осередків відростка скроневої кістки через його гнійне запалення, яке перейшло з середнього вуха. На якому відростку здійснено хірургічне втручання?', 'medium', 121, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Processus styloideus', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Processus prerygoideus', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Processus zygomaticus', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Processus mastoideus', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На слизовій оболонці мигдаликів та м’якого піднебіння виявляються білувато-сірого кольору плівки, які щільно з’єднані з підлеглою тканиною. При спробі зняти плівку на її місці виникає глибокий дефект тканини. Визначити патологічний процес, який виник на слизовій оболонці мигдаликів та м’якого піднебіння:', 'medium', 122, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне запалення', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Змішане запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дівчинка 4-х років на 3-ю добу від початку захворювання на дифтерію померла від справжнього крупу На аутопсії слизова оболонка гортані, трахеї та бронхів потовщена, набрякла, тьмяна, вкрита сіруватою плівкою, що легко відокремлюється. Визначити вид ексудативного запалення гортані:', 'medium', 123, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Змішане', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 35-ти років захворів гостро, відзначалося підвищення температури до 39°С, з’явилися нежить, кашель, сльозотеча. При огляді слизова носоглотки набрякла, гіперемована з рясним слизовиділенням. Який вид запалення розвинувся в носоглотці?', 'medium', 124, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Тварині, сенсибілізованій туберкуліном, внутрішньоочеревинно введений туберкулін. Через 24 години при лапаротомії виявлено венозну гіперемію та набряк очеревини. У мазках-відбитках з очеревини велика кількість лімфоцитів та моноцитів. Яке запалення має місце у тварини?', 'medium', 125, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергічне', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асептичне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині тіла жінки, померлої від хронічної ниркової недостатності, в слизовій оболонці товстої кишки виявлені сіро-жовті плівки, що щільно з’єднані з підлеглим шаром, при відокремленні яких утворюються виразки. Мікроскопічно: глибока ділянка некрозу пронизана нитками фібрину. Визначте вид запалення:', 'medium', 126, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнильне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дитини 5-ти років розвинулось гостре респіраторне захворювання, яке супроводжувалось кашлем, виділенням значної кількості слизу із носа. Який тип запалення у хворої дитини?', 'medium', 127, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїдне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнилісне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта 38-ми років при прогресуванні стафілококового гнійного періодонтиту виникло гнійне запалення кістково-мозкових просторів альвеолярного відростка, а потім тіла нижньої щелепи. Мікроскопічно кісткові балки витончені, вогнища некрозу, кісткові секвестри, оточені сполучнотканинною капсулою. Який найбільш імовірний діагноз?', 'medium', 128, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний періостит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний фіброзний періостит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний остеомієліт', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий остеомієліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пародонтома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Тварині, сенсибілізованій туберкуліном, внутрішньоочеревинно введений туберкулін. Через 24 години при лапаротомії виявлено венозну гіперемію та набряк очеревини. У мазках-відбитках з очеревини велика кількість лімфоцитів та моноцитів. Який патологічний процес у тварини?', 'medium', 129, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергійне запалення', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асептичне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дитини підвищилася температура тіла, з''явилися болі при ковтанні. При огляді: піднебінні мигдалики збільшені, темно - червоні, покриті сіро - жовтими плівками, щільно спаяні з поверхнею мигдаликів. Яке запалення розвинулося в мигдаликах?', 'medium', 130, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час ректороманоскопії в десятирічної дитини виявлено: слизова оболонка прямої та сигмоподібної кишок набрякла, червоного кольору, вкрита товстим шаром слизу. Про яку патологію свідчать зазначені зміни?', 'medium', 131, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Венозне повнокрів''я', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синець', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла чоловіка, який хворів на хронічну ниркову недостатність, у слизовій оболонці товстої кишки виявлено сіро-жовті, щільно зʼєднані з підлеглими тканинами плівки, які відокремлюються з утворенням виразок. Який вид запалення виник у слизовій оболонці товстої кишки?', 'medium', 132, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка, який помер від крупозної пневмонії, виявлено: у плевральній порожнині непрозора рідина, на вісцеральній плеврі плівка сіруватого кольору. Який вид запалення на вісцеральній плеврі?', 'medium', 133, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гранулематозне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який помер від хронічної ниркової недостатності, листки перикарду тьмяні, з тонкими ниткоподібними нашаруваннями сірого кольору. Який патологічний процес відбувся в перикарді?', 'medium', 134, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферативне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка 56 років, який тривалий час хворів на хронічний гломерулонефрит, на поверхні епікарда і перикарда виявили сірувато-білуваті ворсинчасті нашарування («волосате» серце). Про який патологічний процес йдеться?', 'medium', 135, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла дитини, яка померла при ознаках асфіксії, були виявлені в трахеї і головних бронхах сіруватого кольору плівки, які вільно лежали у просвіті дихальних шляхів, нагадуючи їх зліпки. Вкажіть вид запалення:', 'medium', 136, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дівчинка 6 років захворіла на дифтерію та померла від асфіксії на третю добу. На аутопсії слизова оболонка трахеї та бронхів стовщена, набрякла, тьмяна, вкрита сіруватими плівками, які легко відокремлюються. Про який вид запалення свідчать морфологічні зміни?', 'medium', 137, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дитину госпіталізовано до лікарні в стані асфіксії. Під час огляду гортані виявлено білуваті плівки, що обтурують просвіт дихальних шляхів та легко видаляються. Для якого виду запалення гортані характерні такі ознаки?', 'medium', 138, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтеритичне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупозне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 40-ка років перебував у пульмонологічному відділенні з приводу рецидивуючої правосторонньої пневмонії. Помер від легенево-серцевої недостатності. На розтині в правій легені визначається ділянка круглої форми 3х4 см. Вона являє собою порожнину з нерівними шорсткими краями, заповнену каламутною вершкоподібною жовто-зеленою рідиною. Мікроскопічно: стінка порожнини утворена тканиною легені з дифузною інфільтрацією лейкоцитами. Визначте патологічний процес у легені:', 'medium', 139, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий абсцес', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангрена', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний абсцес', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому хірург видалив порожнинне утворення печінки діаметром 2 см. Встановлено, що стінка порожнини утворена щільною волокнистою сполучною тканиною, вміст являє собою каламутну, густу, жовтувато-зеленого кольору рідину з неприємним запахом, яка мікроскопічно складається переважно з поліморфноядерних лейкоцитів. Якому патологічному процесу відповідають такі морфологічні зміни?', 'medium', 140, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний абсцес', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий абсцес', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флегмона', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з хронічним тонзилітом виникло ускладнення - заглотковий абсцес. Куди може поширитися інфекція із заглоткового (ретровісцерального) простору?', 'medium', 141, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В надгрудинний міжапоневротичний простір', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В грудну порожнину, в заднє середостіння', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В превісцеральний простір', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В грудну порожнину, в середнє середостіння', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В грудну порожнину, в переднє середостіння', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні біоптату шкіри у хворого 24-х років виявлено казеозний некроз, оточений клітинним інфільтратом з лімфоцитів, серед яких зустрічаються окремі велетенські клітини, має місце розростання сполучної тканини, ендоваскуліти. Який характер патологічного процесу?', 'medium', 142, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Продуктивне інтерстиціальне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральне запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іхорозне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсцес', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Продуктивне гранульоматозне запалення', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта виявлено гнійний запальний процес у ділянці стегна (післяін''єкційний абсцес). Які лімфатичні вузли збільшуються у цьому разі?', 'medium', 143, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Задні шийні', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пахвинні', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратрахеальні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підколінні', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піднижньощелепні', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 65-ти років розвинувся гнійний абсцес на шиї. Виділена культура грампозитивних коків, яка має плазмокоагулазну активність. Більш за все, це:', 'medium', 144, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Staphylococcus epidermidis', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Staphylococcus saprophyticus', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Streptococcus pyogenes', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Staphylococcus aureus', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обстеження у хворого виявлено абсцес крило-піднебінної ямки. Куди може розповсюдитись інфекція при несвоєчасному наданні медичної допомоги?', 'medium', 145, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Барабанна порожнина', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лобова пазуха', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Орбіта', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підапоневротичний скроневий простір', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжкрилоподібний простір', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після позалікарняного аборту у жінки прогресував гнійний ендоміометрит зі смертельним наслідком. При розтині померлої виявлені чисельні абсцеси легень, субкапсулярні гнійнички в нирках, гіперплазія селезінки. Яка форма сепсису виникла у хворої?', 'medium', 146, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легеневий сепсис', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уросепсис', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септицемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септикопіємія', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 37 років скаржиться на підвищення температури тіла, задишку, біль у правій половині грудної клітки. Після проведення плевральної пункції отримано 650 мл в’язкої рідини зеленувато-жовтого кольору. Який патологічний процес виник у пацієнта?', 'medium', 147, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гематогенний туберкульоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Продуктивний пневмосклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма плеври', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний плеврит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозний плеврит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла жінки, яка хворіла на гнійний холецистит і померла від сепсису, у жовчному міхурі виявили 100 мл каламутної зеленувато-жовтої рідини, стінка міхура в''яла, стоншена, тьмяна, повнокровна. Гістологічно встановлено: дифузна інфільтрація нейтрофілами стінки міхура й повнокрів''я. Визначте, який вид запалення був у жовчному міхурі.', 'medium', 148, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозне запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий абсцес', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний абсцес', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого висока температура, задуха, біль у правій частині грудної клітини. Плевральна пункція дала 700 мл в''язкої рідини жовто-зеленого кольору. Який патологічний процес розвився у плевральній порожнині?', 'medium', 149, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Карциноматоз плеври', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма плеври', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний плеврит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморрагичний плеврит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бронхопневмонія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину трупа чоловіка, що страждав на крупозну пневмонію і помер від пневмококового сепсису, у правій плевральній порожнині містилося 900 мл каламутної зеленувато-жовтого кольору рідини. Листки плеври тьмяні, повнокровні. Назвіть клінікоморфологічну форму запалення в плевральній порожнині:', 'medium', 150, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий абсцес', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний абсцес', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флегмона', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозне запалення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині тіла померлого 49-ти років, який хворів на крупозну пневмонію і помер від пневмококового сепсису, в лівій плевральній порожнині містилось до 700 мл каламутної рідини зеленувато-жовтого кольору з неприємним запахом. Листки плеври тьмяні, повнокровні. Назвіть клініко-морфологічну форму запалення в плевральній порожнині:', 'medium', 151, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флегмона', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емпієма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий абсцес', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний абсцес', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фі6ринознє запалення', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 40 років, мʼясник, помер від сепсису. Обʼєктивно спостерігається: на правій щоці візуалізується конусоподібний, щільний, томно-червоний інфільтрат 6 см із чорною кірочкою в центрі. Права половина обличчя, шиї різко набряклі, щільні. Під час мікроскопічного дослідження в інфільтраті визначається вкрай гостре серозно-геморагічне запалення, у центрі інфільтрату спостерігається некроз епідермісу і підлеглих шарів. Який найімовірніший діагноз?', 'medium', 152, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флегмона шиї', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сибірка', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Чума', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фурункул', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туляремія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У 30-ти річного чоловіка, який хворів на гостре респіраторне захворювання та загинув при явищах гострої легенево-серцевої недостатності, під час розтину знайдено фібринозно-геморагічне запалення в слизовій оболонці гортані та трахеї, деструктивний панбронхіт, збільшені легені, яки мають пістрявий вигляд за рахунок абсцесів, крововиливів, некрозу. Який з перелічених діагнозів найбільш вірогідний?', 'medium', 153, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденовірусна інфекція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парагрип', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Респіраторно-синцитіальна інфекція', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Грип', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кір', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Робітник тваринницької ферми гостро захворів і при наростаючих явищах інтоксикації помер. На розтині встановлено: селезінка збільшена, в’яла, на розрізі темно-вишневого кольору, зішкріб пульпи рясний. М’які мозкові оболонки на склепінні та основі мозку набряклі, просякнуті кров’ю, мають темно-червоний колір (''шапочка кардинала''). Мікроскопічно: серозно- геморагічне запалення оболонок і тканин головного мозку з руйнуванням стінок дрібних судин. Поставте діагноз:', 'medium', 154, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туляремія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холера', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Чума', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бруцельоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сибірка', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Патологоанатом у біоптаті шкіри побачив гостре серозно-геморагічне запалення й ділянку некрозу. З анамнезу: захворювання почалося з появи невеликої червоної плями, у центрі якої утворився міхур із серозно-геморагічною рідиною. Згодом центральна частина стала чорною. Який діагноз найбільш вірогідний?', 'medium', 155, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хімічний дерматит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Карбункул стрептококовий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергічний дерматит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сибірковий карбункул', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Актиномікоз шкіри', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження біоптату шкіри виявлено гранульоми, що складаються з макрофагальних вузликів із наявністю лімфоцитів та плазматичних клітин. Крім того, трапляються великі макрофаги з жировими вакуолями, які містять збудників захворювання, запакованих у вигляді куль (клітини Вірхова). Грануляційна тканина добре васкуляризована. Для якого захворювання характерна описана гранульома?', 'medium', 156, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілісу', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепри', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклероми', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бруцельозу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження внутрішньогрудних лімфовузлів виявлено: епітеліоїдно-клітинні гранулеми без ознак казеозного некрозу. Гранульома складається з високодиференційованих мононуклеарних фагоцитів (епітеліоїдних і гігантських клітин) і лімфоцитів. Центральна частина гранульоми складається переважно з CD4+ лімфоцитів, тоді як СD8+ лімфоцити представлені в периферійній зоні. Для якого захворювання характерні виявлені зміни?', 'medium', 157, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострого лімфаденіту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфосаркоми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Саркоїдозу', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфоми Ходжкіна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження біоптату виявлена гранульома, що складається з лімфоцитів, плазматичних клітин, макрофагів із пінистою цитоплазмою (клітинами Мікуліча), багато гіалінових куль. Яке захворювання можна припустити?', 'medium', 158, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклерома', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепра', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Актиномікоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифіліс', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопічного дослідження легень пацієнта віком 52 роки виявлені вогнища некрозу, оточені валом епітеліоїдних клітин і лімфоцитів. Між лімфоцитами та епітеліоїдними клітинами розміщені великі клітини округлої форми з великою кількістю ядер, розміщених на периферії. Як називається виявлене утворення?', 'medium', 159, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітична гранульома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозна гранульома', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Саркоїдозна гранульома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепрозна гранульома', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ракова перлина', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопії біоптату печінки виявлено гранульоми, які складаються із плазматичних, лімфоїдних, гігантських багатоядерних клітин типу Пирогова- Лангханса, дрібних судин із ознаками ендо- і периваскуліту, трапляються осередки казеозного некрозу. Для якого захворювання характерні такі гранульоми?', 'medium', 160, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифіліс', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклероми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепри', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сапу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з субфебрильною температурою тіла в біоптаті збільшеного лімфатичного вузла виявлено численні гранульомі, які містять у центрі казеозний некроз, оточений епітеліоїдними клітинами, велетенськими багатоядерними клітинами Пирогова-Лангханса і лімфоцитами. Для якого захворювання характерні такі патогістологічні зміни?', 'medium', 161, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфолейкозу', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфогранулематозу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфосаркоми', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфаденіту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопічного дослідження біоптату шкіри виявляються гранульоми, що складаються з епітеліоїдних клітин, оточених в основному Т-лімфоцитами. Серед епітеліоїдних клітин розташовуються поодинокі гігантські багатоядерні клітини типу Пирогова-Лангханса. В центрі деяких гранульом виявляються ділянки казеозного некрозу. Кровоносні судини відсутні. Для якого захворювання характерні описані гранульоми?', 'medium', 162, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклероми', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілісу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сапу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепри', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому у ЛОР-відділенні проведено біопсію слизової оболонки носа. Гістологічно виявлено продуктивне запалення з формуванням гранульом, у складі яких переважають лімфоцити і плазмоцити, спостерігаються еозинофільні гіаліноподібні кулі та великі макрофаги із світлою цитоплазмою (клітини Мікуліча). Який збудник міг викликати описані зміни?', 'medium', 163, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бліда трепонема', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Золотистий стафілокок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мікобактерія лепри', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Респіраторно-синцитіальний вірус', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паличка Волковича-Фріша', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При томографії у хворого в середостінні знайдено збільшені лімфатичні вузли. При гістологічному дослідженні в лімфовузлі виявлено циркулярні розростання сполучної тканини, яка оточувала гранульомоподібні утворення з лімфоцитів, плазмоцитів і великих двоядерних клітин. Для якого захворювання характерні морфологічні дані?', 'medium', 164, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Саркоидоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфосаркома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфолейкоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфогранулематоз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У біоптаті потовщеної слизової обооонки носа жінки віком 29 років, яка скаржиться на утруднення носового дихання, виявлено: скупчення плазматичних і епітеліоїдних клітин та лімфоцитів, серед яких багато гіалінових куль (Русселівські тільця) та великих макрофагів зі світлою цитоплазмою (клітини Мікуліча). Яке запалення розвинулося в слизовій оболонці носа пацієнтки?', 'medium', 165, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Змішане', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ексудативне', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжне', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'З утворенням поліпів і гострокінцевих кондилом', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гранулематозне', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 65-ти років раптово втратив зір на одне око в зв''язку з відшаруванням сітківки. Хворому була проведена енуклеація. Під час гістологічного дослідження видаленого очі в сітківці і судинній оболонці виявлені комплекси атипових клітин з вираженим поліморфізмом клітин і ядер, з помірною кількістю мітозів, враховуючи патологічні. У цитоплазмі клітин і міжклітинної середовищі виявляється пігмент коричневого кольору, що дає позитивну реакцію ДОФА. Реакція Перлса негативна. Який найбільш ймовірний діагноз?', 'medium', 166, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хвороба Вільсона-Коновалова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'пігментний невус', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цістоцеркоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'крововилив', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'меланома', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки на шкірі шиї спостерігається новоутворення на ніжці, кулястої форми, зморшкувате. У біоптаті з нього виявлена надмірна проліферація покривного епітелію та строми шкіри у вигляді сосочків, збережена полярність клітин, їх комплексність та базальна мембрана, характерний тканинний атипізм. Який найбільш імовірний діагноз?', 'medium', 167, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рак', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Невус', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Саркома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фіброма', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Папілома', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 46-ти років на шкірі визначалась темна пляма, яка вибухала та не спричиняла турбот. З часом пляма почала збільшуватись, з’явився біль, колір став чорно-коричневим і почав пальпуватися вузлик. При гістологічному дослідженні видаленої тканини визначалися веретеноподібні й поліморфні клітини з численними мітозами, цитоплазма яких вміщувала пігмент бурого кольору. Про яку пухлину йдеться?', 'medium', 168, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базаліома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланома', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Невус', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемангіома', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 45-ти років звернувся до лікаря з приводу бляшкоподібного утворення на шиї. У біоптаті шкіри гістологічно виявлено пухлинні клітини, розташовані гніздами, які мають круглу та овальну форму з вузьким ободком базофільної цитоплазми та схожі на клітини базального шару епідермісу. Як називається пухлина в пацієнта?', 'medium', 169, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідраденома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епідермальний рак', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сирінгоаденома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трихоепітеліома', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базаліома', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 69-ти років на шкірі в ділянці нижньої повіки з’явилося невелике бляшкоподібне утворення з наступним виразкуванням, яке було оперативно видалене. При мікроскопічному дослідженні утворення: в дермі шкіри комплекси з атипових епітеліальних клітин; периферії клітини розташовані перпендикулярно до базальної мембрани. Клітини темні, призматичної полігональної форми з гіперхромними ядрами з частими мітозами. Іноді зустрічаються утворення, подібні до волосяного фолікула. Яка гістологічна форма раку у хворого?', 'medium', 170, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плоскоклітинний рак без ороговіння', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденокарцинома', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плоскоклітинний рак з ороговінням', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недиференційований рак', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базально-клітинний рак', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В товщі шкіри макроскопічно виявлено рухливу пухлину. Мікроскопічно спостерігаються хаотично розташовані пучки колагенових волокон із невеликою кількістю веретеноподібних клітин. Яка пухлина виявлена?', 'medium', 171, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фіброма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейоміома', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломус-ангіома', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У товщі шкіри макроскопічно знайдена і видалена щільна пухлина, рухлива. При мікроскопії вона представлена хаотично розташованими пучками колагенових волокон з невеликою кількістю веретеноподі6них клітин. Яка пухлина видалена?', 'medium', 172, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іломус-ангіома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпома', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна фіброма', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Меланома', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейоміома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Деякі лікарські препарати за механізмом дії є активаторами або інгібіторами певних ферментів. Який з нижченаведених представників належить до групи інгібіторів?', 'medium', 173, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крохмаль', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміак', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сульфаніламіди', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпіди', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іони натрія, калія, магнія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування деяких інфекційних захворювань, викликаних бактеріями, застосовуються сульфаніламідні препарати, що блокують синтез фактора росту бактерій. Назвіть механізм їх дії:', 'medium', 174, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібують всмоктування фолієвої кислоти', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Є антивітамінами параамінобензойної кислоти', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Є алостеричними інгібіторами ферментів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Є алостеричними ферментами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Беруть участь в окисно-відновних процесах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої 38 років після прийому аспірину і сульфаніламідів спостерігається посилений гемоліз еритроцитів, викликаний недостатністю глюкозо-6-фосфатдегідрогенази. Порушенням утворення якого коферменту зумовлена ця патологія?', 'medium', 175, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Убіхінон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піридоксальфосфат', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'НАДФН', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ФМНН2', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ФАДН2', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Сульфаніламідні препарати нагадують по структурі параамінобензойну кислоту. В чому полягає молекулярна основа їх фармакологічного ефекту?', 'medium', 176, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В руйнуванні клітинної мембрани', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У зв''язуванні з ДНК', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В порушенні синтезу вітаміну', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У інгібуванні гліколізу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В активації ліполізу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після прийому сульфаніламідів у хворого виникли лихоманка, блювання і стул з кров’ю. У крові: лейк.-0,9 • 10^9 /л (гранул.- 0,7 • 10^9 /л), лейкоаглютиніни. Який з термінів найбільш точно характеризує виявлені зміни у крові?', 'medium', 177, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемодилюція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Агранулоцитоз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкопенія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоз', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з ослабленим імунітетом, віком 36 років, діагностовано простий герпес слизової оболонки губ. Як компонент комплексної терапії лікар призначив йому препарат місцевого застосування, що має противірусну активність. Укажіть цей лікарський засіб.', 'medium', 178, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерферон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацикловір', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амікацин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тималін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ремантадин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Школяр 8-ми років звернувся до стоматолога з герпетичним висипанням на нижній губі. Який найбільш ефективний засіб слід призначити?', 'medium', 179, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ампіцилін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацикловір', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Оксацилін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фурадонін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кетоконазол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта діагностовано герпетичний стоматит. Що слід призначити в даному випадку для лікування?', 'medium', 180, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сульфацил натрію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацикловір', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тетрациклін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клотримазол', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта після переохолодження у ділянці крил носа та верхньої губи з''явились герпетичні висипання. Для лікування була застосована мазь. Який противірусний засіб містить застосована мазь?', 'medium', 181, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацикловір', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індометацин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дексаметазон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Азидотимідин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерферон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта після переохолодження на губах з’явились герпетичні висипання. Для лікування призначений крем ацикловіру, терапевтичний ефект якого пояснюється здатністю:', 'medium', 182, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмувати активність протеази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмувати активність ДНК-полімерази', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушувати функцію зворотної транскриптази', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібувати нейрамінідазу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уповільнювати реплікацію РНК- і ДНК-геномних вірусів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: ревматоїдний артрит, декілька тижнів приймав препарати глюкокортикостероїдів, а потім раптово припинив їх приймати. Яке ускладнення може виникнути в цьому разі?', 'medium', 183, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром відміни', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загострення хронічних інфекційних процесів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виразкування слизової оболонки шлунка і дванадцятипалої кишки', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення артеріального тиску', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперглікемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий з інфекційним мононуклеозом протягом двох тижнів приймав глюкокортикостероїдні препарати. Настала ремісія, проте в нього виникло загострення хронічного тонзиліту. Результатом якої дії глюкокортикостероїдів є дане ускладнення?', 'medium', 184, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунодепресивна', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протишокова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антитоксична', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протизапальна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антиалергічна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'З метою пригнічення аутоімунних реакцій після трансплантації органів обов''язковим є проведення курсу гормонотерапії. Які гормони застосовують у цьому випадку?', 'medium', 185, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статеві гормони', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїди', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропний гормон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїди', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У клініці встановлено, що під час вагітності тяжкість симптомів ревматоїдного артриту різко знижується. Прискорення секреції яких гормонів, які мають протизапальну дію, спостерігається у цьому разі?', 'medium', 186, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естрогенів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Йодованих щитоподібної залози', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїдів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гонадотропних', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катехоламінів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої діагностували виразку шлунка. З анамнезу відомо, що вона тривалий час хворіє на ревматоїдний артрит. Прийом яких препаратів найбільш імовірно призвів до розвитку виразки?', 'medium', 187, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокатори Н2-рецепторів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антигіпертензивні препарати', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїди', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антигістамінні препарати', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антибіотики', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'З метою попередження відторгнення трансплантата після пересадки органів обов’язковим є проведення курсу гормонотерапії з метою імуносупресії. Які гормони застосовують з цією метою?', 'medium', 188, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катехоламіни', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статеві гормони', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїди', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреоїдні', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїди', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При тривалому використанні одного з гормональних препаратів у хворого виявлено ознаки остеопорозу, ерозії слизової шлунка, гіперглікемію, зменшення рівня АКТГ в крові. Препарат якої групи гормонів міг викликати ці явища?', 'medium', 189, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїдів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статевих гормонів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцитоніну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Иодвмісних гормонів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїдів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який отримав тривалий курс лікування глюкокортикоїдами, виявлено виразки в шлунку. Який механізм є головним у їхньому розвитку?', 'medium', 190, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження гістаміну в слизовій оболонці шлунка', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тонусу симпатичної нервової системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення продукції простагландинів Е1, Е2', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення секреції та кислотності шлункового соку', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження тонусу парасимпатичної нервової системи', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При обстеженні хворого, який тривалий час приймає глюкокортикоїди, виявлена лімфопенія. Як можна охарактеризувати функціональний стан імунної системи пацієнта?', 'medium', 191, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Толерантність до аутоантигенів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунодефіцит вторинний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілаксія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунодефіцит вроджений', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунодефіцит первинний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, що тривало приймав глюкокортикоїди, в результаті відміни препарату виникло загострення наявного захворювання, зниження артеріального тиску, слабкість. Ці явища можна пов’язати з розвитком:', 'medium', 192, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукцією АКТГ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатності наднирників', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляцією', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звикання до препарату', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізацією', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту, який знаходився в клініці з приводу пневмонії, ускладненої плевритом, у складі комплексної терапії вводили преднізолон. Протизапальна дія цього синтетичного глюкокортикоїда пов’язана з блокуванням вивільнення арахідонової кислоти шляхом гальмування:', 'medium', 193, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклооксигенази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпази A2', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоксигенази', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пероксидази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпази С', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При хронічному передозуванні глюкокортикоїдів розвивається гіперглікемія. Назвіть процес вуглеводного обміну, за рахунок якого збільшується концентрація глюкози в плазмі крові:', 'medium', 194, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глікогеноліз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюконеогенез', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аеробний гліколіз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шкогенез', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пентозофосфатний цикл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Людина за призначенням лікаря тривалий час приймала препарат з групи глюкокортикоїдних гормонів. Секреція якого (яких) з наведених гормонів буде пригнічена внаслідок цього?', 'medium', 195, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїди', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статеві', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортикотропний', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиротропний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, що тривалий час приймав глюкокортикоїди, в результаті відміни препарату виникло загострення наявного захворювання, зниження артеріального тиску, слабкість. Чим можна пояснити ці явища?', 'medium', 196, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукцією АКТГ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виникненням недостатності наднирників', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізацією', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляцією', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звиканням до препарату', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий тривалий час приймав глюкокортикоїди. Після різкої відміни препарату скаржиться на міалгію, підвищену стомлюваність, емоційну нестабільність, головний біль, безсоння, втрату апетиту, нудоту. Розвинувся синдром відміни глюкокортикоїдів. Призначення яких препаратів показано для корекції даного стану?', 'medium', 197, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкокортикоїди', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АКТГ', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортикостероїди', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінералокортикоїди', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Похідні птерину - аміноптерин і метотрексат є конкурситними інгібіторами дигідрофолатредуктази, вони пригнічують регенерацію тетрагідрофолієвої кислоти з дигідрофолату. Ці лікарські засоби призводять до гальмування міжмолекулярного транспорту одновуглецевих груп. Біосинтез якого полімеру при цьому пригнічується?', 'medium', 198, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліозидів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДНК', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глікозамуногліканів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гомополісахаридів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Онкологічному хворому призначили препарат метотрексат, до якого з часом клітини-мішені пухлини втратили чутливість. Експресія гену якого ферменту при цьому змінюється?', 'medium', 199, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дегідрофолатредуктаза', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дезаміназа', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолатдекарбоксилаза', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолатоксидаза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиміназа', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування злоякісних пухлин призначають метотрексат - структурний аналог фолієвої кислота, який є конкурентним інгібітором дигідрофолатредуктази і тому гальмує синтез:', 'medium', 200, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гліцерофосфатидів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Моносахаридів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глікогену', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирних кислот', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нуклеотидів ДНК', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування злоякісних пухлин призначають метотрексат - структурний аналог фолієвої кислоти, який є конкурентним інгібітором дигідрофолатредуктази. На якому рівні метотрексат пригнічує синтез нуклеїнових кислот?', 'medium', 201, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Транскрипція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процесинг', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реплікація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез мононуклеотидів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Репарація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік, хворий на бронхіальну астму, тривалий час приймає преднізолон. Який механізм дії препарату?', 'medium', 202, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмування активності фосфоліпази А2', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада натрієвих каналів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада лсйкотрієнових рецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада гістамінових рецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення активності дигідрофолатредуктази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора на бронхіальну астму приймала протягом 3-х місяців преднізолон у таблетках. Внаслідок значного покращення стану раптово припинила його прийом. Розвиток якого ускладнення високоймовірний у цьому випадку?', 'medium', 203, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнту віком 55 років проведено трансплантацію нирки. Який із нижченаведених імунотропних засобів найдоцільніше призначити у цьому разі?', 'medium', 204, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Левамізол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'gamma-глобулін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрія нуклеїнат', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрат вилочкової залози', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час тривалого використання лікарського засобу у хворого можуть спостерігатися остеопороз, ерозія слизової шлунку, гіпокаліємія, затримка натрію і води в організмі, зменшення вмісту кортикотропіну у крові. Який препарат може викликати таку побічну дію?', 'medium', 205, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рифампіцин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індометацин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотіазид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування ревматоїдного артриту жінці 65-ти років у складі комплексної терапії був призначений гормональний препарат, який має імунодепресивну дію. Визначте цей препарат:', 'medium', 206, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ферковен', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Супрастин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тималін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рибофлавін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 33-х років, яка тривалий час лікується з приводу хронічного поліартриту, скаржиться на підвищення артеріального тиску, зміни розподілу жирової тканини, порушення менструального циклу. Який препарат приймає хвора?', 'medium', 207, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Беклометазон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індометацин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бутадіон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синафлан', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При тривалому використанні препарату у хворого можуть мати місце остеопороз, ерозії слизової шлунка, гіпокаліємія, затримка натрію й води в організмі, зменшення вмісту кортикотропіну в крові. Укажіть цей препарат:', 'medium', 208, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотіазид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індометацин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому з гострою недостатністю надниркових залоз був призначений лікарський препарат, після застосування якого у нього з’явилися скарги на біль у кістках (двічі були переломи), часті простудні хвороби, набряки, повільне загоювання ран. Який препарат міг спричинити такі явища?', 'medium', 209, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естріол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретаболіл', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після введення пеніцилину в хворого розвився набряк Квінке. Який препарат екстреної терапії необхідно ввести хворому?', 'medium', 210, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аскорбінова кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рифампіцин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сульфацил-натрій', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Но-шпа', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після тривалого вживання одного з лікарських препаратів у хворого розвинулась підвищена чутливість до простудних захворювань. Який з вказаних нижче лікарських засобів міг сприяти зниженню імунітету?', 'medium', 211, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Настойка женьшеню', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сустак-форте', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клофелін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора на ревматоїдний артрит після трьохтижневого лікування преднізолоном почала скаржитись на перебої в роботі серця. З чим пов’язаний розвиток даного небажаного ефекту препарату?', 'medium', 212, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперглікемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокаліємія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперурікемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкаліємія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоглікемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий з нейродермітом протягом тривалого часу вживав преднізолон. При обстеженні в нього виявили підвищення рівня цукру в крові. Вплив препарату на яку ланку вуглеводного обміну призводить до виникнення цього ускладнення?', 'medium', 213, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація розщеплення інсуліну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилення всмоктування глюкози в кишечнику', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація глюконеогенезу', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення синтезу глікогену', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація глікогеногенезу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 45-ти років декілька років хворіє на системний червоний вовчак у легкій формі. При прогресуванні захворювання (з’явився міокардит) їй призначили преднізолон як імуносупресор. Через 2 місяці прийому у хворої виникла шлункова кровотеча. Яка найбільш імовірна її причина?', 'medium', 214, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення артеріального тиску', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подальше прогресування захворювання', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ульцерогенна дія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудження ЦНС', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення згортання крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на колагеноз після тривалого прийому преднізолону з’явився спастичний біль скелетних м’язів внаслідок розвитку гіпокаліємії. Який препарат треба використати для корекції обміну калію?', 'medium', 215, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дитилін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діазепам', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тирокальцитонін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ношпа', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панангін', true, 4, NOW(), NOW());

  RAISE NOTICE 'Додано питань: 216';
END $$;
