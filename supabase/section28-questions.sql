-- SQL для додавання питань до розділу 28: Серцево-судинна система, патологічні процеси
-- Автоматично згенеровано
-- Кількість питань: 425

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо або створюємо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Серцево-судинна система'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    INSERT INTO courses (title, faculty, description, order_index, is_active, created_at, updated_at)
    VALUES (
      'Серцево-судинна система',
      'medical',
      'Серцево-судинна система',
      10,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_course_id;
    RAISE NOTICE 'Створено курс "%s" з ID: %', 'Серцево-судинна система', v_course_id;
  END IF;

  -- Створюємо або знаходимо topic
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Серцево-судинна система, патологічні процеси'
  LIMIT 1;

  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Серцево-судинна система, патологічні процеси',
      'Тести з патології серцево-судинної системи',
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
  VALUES (v_topic_id, 'У хворого діагностовано ураження стулок правого передсердно-шлуночкового клапана. Внаслідок запального процесу якої анатомічної структури серця відбулися зміни у стулках?', 'medium', 0, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фіброзний перикард', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний перикард', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендокард', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокард', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епікард', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні стулки мітрального клапана серця виявлено: мукоїдний набряк, пошкодження ендотелію, утворення по замикаючому краю фібринових тромбів. Яка форма ревматичного ендокардиту спостерігається?', 'medium', 1, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий ендокардит', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний ендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно - виразковий ендокардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний ендокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотно - бородавчастий ендокардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла померлої в комі молодої людини, виявлено: поширений тромбоемболічний інфаркт лівої півкулі мозку, велика септична селезінка, імунокомплексний гломерулонефрит, виразки на стулках аортального клапану, що прикриті поліпоподібними тромбами з колоніями стафілококів. Яке захворювання викликало церебральну тромбоемболію?', 'medium', 2, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септикопіємія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматичний тромбендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септичний бактеріальний ендокардит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий ревматичний вальвуліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септицемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині виявлено: на зовнішній поверхні аортального клапана великі (1-2 см) буровато-червоні, крихкі нашарування, які прикривають виразкові дефекти. Який найбільш імовірний діагноз?', 'medium', 3, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний ендокардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зворотній бородавчастий ендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно-виразковий ендокардит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний ендокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий ендокардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з ендокардитом виявлено патологію клапанного апарата внутрішньої оболонки серця. Які тканини утворюють клапани серця?', 'medium', 4, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіалінова хрящова тканина, ендотелій', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еластична хрящова тканина, ендотелій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухка сполучна тканина, ендотелій', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серцева м''язова тканина, ендотелій', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна сполучна тканина, ендотелій', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження стулок мітрального клапана серця жінки 30-ти років було встановлено, що ендотеліальні клітини вогнищево десквамовані, у цих ділянках на поверхні стулки розташовані дрібні тромботичні нашарування, сполучна тканина стулки з явищами мукоїдного набухання з ділянками склерозу та васкуляризації. Діагностуйте вид клапанного ендокардиту:', 'medium', 5, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотнь-бородавчастий', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно-виразковий', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На електронній мікрофотографії міокарда видно клітини відростчатої форми, що містять мало органел, але мають добре розвинену гранулярну ендоплазматичну сітку та секреторні гранули. Вкажіть ці клітини.', 'medium', 6, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перехідні атипові клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини пучка Гіса', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Секреторні кардіоміоцити', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пейсмекерні клітини', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту при подразненні блукаючого нерва внаслідок стимуляції виходу ацетилхоліну в синаптичну щілину зменшується частота серцевих скорочень (ЧСС). Який механізм цих змін?', 'medium', 7, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тривалості потенціалу дії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення швидкості проведення збудження в АВ-вузлі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Деполяризація мембрани кардіоміоцитів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення тривалості потенціалу дії', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперполяризація мембрани кардіоміоцитів', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з широким інфарктом міокарда розвинулася серцева недостатність. Який патогенетичний механізм її розвитку?', 'medium', 8, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця об’ємом', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра тампонада серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реперфузійне ураження міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення маси функціонуючих кардіоміоцитів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця тиском', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У досліді ішемія ділянки серця тривалістю 2-3 хв призводила до пригнічення скорочень кардіоміоцитів, що відновлювалися одразу після реперфузії. Який механізм лежить в основі такого порушення скоротливої функції клітин серця?', 'medium', 9, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилення В-окиснення жирних кислот', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація АТФ-залежних К+-каналів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація фосфоліпази А2', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація потенціал-залежних Са+-каналів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація механізмів Nа/Са2+ іонообміну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На мікропрепараті серця розрізняються клітини прямокутної форми, розмірами від 50 до 120 мкм, з центрально розташованим ядром, розвиненими міофібрилами, зв’язані між собою вставними дисками. Яку функцію виконують ці клітини?', 'medium', 10, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Регенераторна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скорочення серця', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендокринна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Захисна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проведення імпульсів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з ендокардитом виявлено патологію клапанного апарата внутрішньої оболонки серця. Які тканини утворюють клапани серця?', 'medium', 11, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіалінова хрящова тканина, ендотелій', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еластична хрящова тканина, ендотелій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухка сполучна тканина, ендотелій', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серцева м''язова тканина, ендотелій', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна сполучна тканина, ендотелій', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого діагностовано септичний ендокардит. Температура тіла протягом 5-ти днів коливалася в межах 39,5oC -40,2oC. На 6-й день на тлі різкого зниження температури до35,2oC розвинувся колапс. Який головний механізм колапсу?', 'medium', 12, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазодилатація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилене потовиділення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпервентиляція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В гістологічному препараті стінки серця між ендокардом і міокардом визначаються великі клітини зі світлою цитоплазмою і ексцентрично розміщеним ядром. Які це клітини?', 'medium', 13, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендокринні клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Пуркіньє', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пейсмейкерні клітини', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливі кардіоміоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У померлого від хронічної серцево-судинної недостатності на розтині виявлене ''тигрове серце''. З боку ендокарду помітна жовтувато-біла посмугованість; міокард тьмяний, глинисто-жовтий. Який процес зумовив дану патологію?', 'medium', 14, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводна дистрофія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліново-краплинна дистрофія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова судинно-стромальна дистрофія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова паренхіматозна дистрофія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хворого 43-х років, померлого від ревматизму, поверхня епікарду ворсиста, покрита плівками сірого кольору, що легко відділяються. Після їх відділення визначається набрякла повнокровна поверхня епікарду. Який найбільш імовірний діагноз?', 'medium', 15, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний перикардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний перикардит', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферативний перикардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний перикардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральний перикардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка 56 років, який тривалий час хворів на хронічний гломерулонефрит, на поверхні епікарда і перикарда виявили сірувато-білуваті ворсинчасті нашарування («волосате» серце). Про який патологічний процес йдеться?', 'medium', 16, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Хворий на хронічний пієлонефрит помер від хронічної ниркової недостатності. При житті аускультативно відмічено "шум тертя перикарду? На розтині виявлено. що епікард тьмяний, шорсткий, ніби покритий волосяним покривом. Який перикардит за характером запалення має місце?', 'medium', 17, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнильний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини частота серцевих скорочень постійно утримується на рівні 40 разів за хвилину. Що є водієм ритму серця у неї?', 'medium', 18, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Гіса', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При дослідженні ізольованого кардіоміоциту встановлено, що він не генерує імпульси збудження автоматично. З якої структури серця отримано кардіоміоцит?', 'medium', 19, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночок', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Пса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час емоційного збудження частота серцевих скорочень (ЧСС) у людини 30-ти років досягла 112/хв. Зміна стану якої структури провідної системи серця є причиною збільшення ЧСС?', 'medium', 20, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Пса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому чоловіку 75-ти років, у якого частота серцевих скорочень була 40/хвилину, імплантували серцевий електростимулятор. Після цього частота серцевих скорочень зросла до 70/хв. Функцію якого відділу серця взяв на себе електростимулятор?', 'medium', 21, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна пучка Гіса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На ізольованому серці вивчалась швидкість проведення збудження у різних його ділянках. Де була виявлена найменша швидкість?', 'medium', 22, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокард передсердь', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокард шлуночків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта тривалість інтервалу P — Q на ЕКГ перевищує норму при нормальній тривалості зубця P. Причиною цього є зменшення швидкості проведення збудження:', 'medium', 23, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокнами Пуркін’є', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярним вузлом', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжками пучка Гіса', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальним вузлом', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучком Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті на ссавці зруйнували певну структуру серця, що призвело до припинення проведення збудження від передсердь до шлуночків. Що саме зруйнували?', 'medium', 24, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Аналіз ЕКГ хворого виявив відсутність зубця Р. Тривалість та амплітуда QRS комплексу та зубця Т відповідають нормі. Що є водієм ритму серця даного пацієнта?', 'medium', 25, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночковий вузол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусовий вузол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокард шлуночків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з серцевою недостатністю виникла аритмія у вигляді генерації позачергових імпульсів в пучку Гіса. Порушення якої функції серцевого м’язу спостерігається в даному випадку?', 'medium', 26, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість та провідність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизм', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливість', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту на собаці виникла потреба знизити збудливість міокарду. Який розчин для цього доцільно ввести тварині внутрішньовенно?', 'medium', 27, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкози', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бікарбонату натрію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду кальцію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду натрію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду калію', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До фізіологічних властивостей серцевого м’язу людини належать усі наведені, крім:', 'medium', 28, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливість', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еластичність', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В процесі експерименту на собаці виникла необхідність підвищити збудливість серцевого м’язу. За допомогою введення якого іону можливо досягти бажаного ефекту?', 'medium', 29, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Mg2+', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Cl-', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Са2+', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'К+', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Fe2+', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з серцевою недостатністю виникла аритмія, під час якої частота скорочень передсердь була 70, а шлуночків - 35/хв. Порушення якої функції провідної системи серця спостерігалося у хворого?', 'medium', 30, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизм', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість та провідність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливість', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Міокард являє собою функціональний синтицій, і збудження, що виникає у будь-якій ділянці, поширюється на всі інші відділи. У зв’язку з цією особливістю, збудження в серці підлягає закону:', 'medium', 31, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лапласа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Франка-Старлінга', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анрепа', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Усе або нічого', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При проведенні ехокардіографії в чоловіка віком 68 років із недостатністю півмісяцевих клапанів аорти встановлено такі показники лівого шлуночка: кінцево-діастолічний об’єм — 156 мл, кінцево-систолічний об’єм — 47 мл, систолічний об’єм — 109 мл, фракція вигнання — 70%. Який механізм регуляції діяльності серця зумовив збільшення показників систолічної продуктивності лівого шлуночка у хворого?', 'medium', 32, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Закон Франка-Старлінга', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефлекс Бецольда-Яриша', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Феномен (драбина) Боудічі', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефлекс Бейнбриджа', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефект Анрепа', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Швидка інфузія фізіологічного розчину анестезованій тварині з брадикардією призводить до збільшення частоти серцевих скорочень. Який рефлекс описує це явище?', 'medium', 33, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Франка-Старлінга', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ашнера', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Безольда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бейнбріджа', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Яріша', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: ревматичний міокардит, періодично відчуває перебої в роботі серця. На ЕКГ виявлено: нерегулярна поява ідіовентрикулярних екстрасистол. Який патогенетичний механізм зумовлює виникнення компенсаторної паузи у цьому разі?', 'medium', 34, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення функції синусового вузла', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Затримка збудження в атріовентрикулярному вузлі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретроградне проведення збудження до передсердь', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення скоротливої здатності міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефрактерність міокарда до сприйняття чергового імпульсу', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті на тварині досліджують серцевий цикл. Закриті усі клапани серця. Якій фазі циклу відповідає такий стан?', 'medium', 35, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повільного наповнення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протодіастолічний період', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асинхронного скорочення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізометричного скорочення', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкого наповнення', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У здорової дорослої людини проводять зондування порожнин серця і великих судин. Де розташований зонд, якщо протягом серцевого циклу зареєстровані зміни тиску від 0 до 120 мм рт.ст.?', 'medium', 36, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аорта', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лівий шлуночок', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легенева артерія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердя', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Правий шлуночок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При аналізі ЕКГ виявлено випадіння деяких серцевих циклів PQRST. Наявні зубці та комплекси не змінені. Назвать вид аритмії:', 'medium', 37, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистола', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньопередсердна блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини визначили частоту серцевих скорочень за пульсом. Вона дорівнює 120/хв. Якою при цьому є тривалість серцевого циклу?', 'medium', 38, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '0,8 с', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '1,0 с', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '0,9 с', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '0,7 с', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '0,5 с', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аналізу електрокардіограми встановлено, що тривалість серцевого циклу в людини дорівнює 1 секунді. Яка частота серцевих скорочень за хвилину?', 'medium', 39, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '60', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '50', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '80', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '70', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '100', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У здорової дорослої людини проводять зондування порожнин серця. Зонд знаходится у лівому шлуночку. Під час якої фази (періоду) серцевого циклу буде зареєстровано збільшення тиску від 8 до 70 мм рт.ст.?', 'medium', 40, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Період вигнання', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза ізометричного скорочення', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза повільного вигнання', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза асинхронного скорочення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза швидкого вигнання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 42 років надійшов до кардіологічного відділення з діагнозом стенокардія. До комплексу препаратів, призначених хворому, включений інгібітор ферменту фосфодіестерази. Концентрація якої речовини в серцевому м''язі буде збільшуватись?', 'medium', 41, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АДФ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ГМФ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АТФ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АМФ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цикло-АМФ', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки з ішемічною хворобою серця на ЕКГ виявлено: ЧСС - 230 уд./хв, зубець Р деформований, шлуночкові комплекси без змін. Яке порушения серцевого ритму виникло в пацієнтки?', 'medium', 42, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція передсердь', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тріпотіння передсердь', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна пароксизмальна тахікардія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистола', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До чого призводить екстрасистола, яка була спричинена виникненням збудження в одному зі шлуночків?', 'medium', 43, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'До підвищення швидкості проведення збудження по шлуночках', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'До повної блокади проведення збудження по шлуночках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'До компенсаторної паузи передсердь', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'До зниження швидкості проведення збудження по передсердях', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'До тривалої компенсаторної паузи шлуночка', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час ультразвукового обстеження серця лікар спостерігає за стулками мітрального клапана. Що відбувається з ними під час систоли передсердь?', 'medium', 44, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Притискаються до стінок передсердя', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Притискаються до стінки судини', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вивертаються в порожнину шлуночка', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стуляються, закриваючи просвіт отвору', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вивертаються в порожнину передсердя', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини зареєстрована електрокардіограма зі зниженою амплітудою зубця R. Що означає цей зубець на ЕКГ?', 'medium', 45, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження від передсердь до шлуночків', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження по шлуночках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження по передсердям', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електричну систолу серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електричну діастолу серця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У фізіологічному експерименті ізольоване серце тварини помістили в розчин КСІ з концентрацією 12 ммоль/л. До якого патологічного стану це призведе?', 'medium', 46, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зупиики серця в систолі', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зупинки серця в діастолі', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення частоти і сили скорочень', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніяк не вплине на роботу серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення частоти і сили скорочень', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Клітини водія ритму серця мають специфічну фазу ПД:', 'medium', 47, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повільну діастолічну деполяризацію', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидку систолічну деполяризацію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидку діастолічну деполяризацію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Систолічну рсполяризацію', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого спостерігається збільшений тонус артеріол за нормальних показників насосної функції серця. Як це вплине на величину артеріального тиску?', 'medium', 48, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться переважно діастолічний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться переважно систолічний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зросте переважно систолічний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиск не зміниться', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зросте переважно діастолічний', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 30 років на електрокардіограмі виявлено зниження амплітуди зубця R. Що означає цей зубець на ЕКГ?', 'medium', 49, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Деполяризацію шлуночків', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електричну діастолу серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження від передсердь до шлуночків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реполяризацію шлуночків', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Деполяризацію передсердь', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У передсердях продукується передсердний натрійуретичний пептид. Що є основним механізмом стимуляції секреції цього гормону?', 'medium', 50, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення частоти серцевих скорочень за рахунок вкорочення тривалості діастоли', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатична іннервація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розтягування або посилення напруження стінки міокарда', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилення роботи Na+/Ca2+ - помпи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вплив n. vagus', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На які зміни з боку ізольованого серця жаби можна очікувати після введення у перфузійний розчин надлишкової кількості хлориду кальцію?', 'medium', 51, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення частоти і сили скорочень', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зупинку серця в діастолі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення сили скорочень', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення частоти скорочень', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення сили скорочень', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При ультразвуковому обстеженні серця лікар спостерігає за півмісяцевими клапанами. Що відбувається з ними під час діастоли шлуночків?', 'medium', 52, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стуляються, закриваючи просвіт судин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вивертаються в порожнини шлуночків', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вивертаються в порожнини судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Притискаються до стінок судин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Притискаються до стінок шлуночка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з гострим міокардитом зʼявилися клінічні ознаки кардіогенного шоку. Який із нижченаведених патогенетичних механізмів є провідним у розвитку шоку?', 'medium', 53, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення периферичного опору судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження діастолічного притоку до серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення насосної функції серця', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Депонування крові в органах', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження судинного тонусу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Безпосередньо після переходу з горизонтального положення у вертикальне у чоловіка 23-х років частота серцевих скорочень збільшилася на 15 скорочень за хвилину, систолічний тиск не змінився, діастолічний зріс на 10 мм рт.ст. Яка рефлекторна реакція виконавчих структур є причиною збільшення діастолічного тиску?', 'medium', 54, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звуження резистивних та ємнісних судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення систолічного об''єму', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звуження судин опору', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення хвилинного об''єму крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звуження ємнісних судин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки, яка упродовж 15 років хворіє вираженою гіпертензією, з''явилися задишка, серцебиття, знизився систолічний тиск, діастолічний залишився без змін. Який основний механізм виникнення серцевої недостатності у жінки?', 'medium', 55, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним опором викиду крові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення регуляції серцевої діяльності', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодження міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення проведення імпульсу по міокарду', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним об''ємом крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який має важку форму порушення водно-сольового обміну, сталася зупинка серця у діастолі. Який найімовірніший механізм цього патологічного стану?', 'medium', 56, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпонатріємія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокаліємія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпернатріємія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкаліємія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпомагніємія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При вимірюванні артеріального тиску у чоловіка віком 56 років встановлено зростання діастолічного артеріального тиску до 100 мм рт. ст. Від якого із наведених факторів в основному залежить величина діастолічного артеріального тиску?', 'medium', 57, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Периферичного опору судин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкості кровотоку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Величини ударного об''єму лівого шлуночка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Величини кінцево-діастолічного об''єму лівого шлуночка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Об''єму циркулюючої крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта перед кардіологічною операцією зареєстровано тиск у всіх відділах серця. Який тиск в лівому шлуночку під час діастоли?', 'medium', 58, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '0 мм рт.ст.', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '100 мм рт.ст.', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '120 мм рт.ст.', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '80 мм рт.ст.', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '40 мм рт.ст.', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 65-ти років впродовж 15-ти років була виражена артеріальна гіпертензія. Останнім часом систолічний тиск почав знижуватися, а діастолічний залишився підвищеним. Який гемодинамічний тип артеріальної гіпертензії у хворого?', 'medium', 59, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкінетичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокінетичний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нормокінетичний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еукінетичний', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Одним із основних факторів, які забезпечують, насосну функцію серця, є чітка послідовність роботи його відділів. Із якої фази починається систола шлуночків?', 'medium', 60, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкого наповнення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асинхронного скорочения', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізоволюметричного скорочення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повільного вигнання', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкого вигнання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час систоли шлуночків серцевий м''яз не відповідає на додаткове подразнення тому, що знаходиться у фазі?', 'medium', 61, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субнормальної збудливості', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищеної збудливості', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відносної рефрактерності', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсолютної рефрактерності', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після загострення хронічного калькульозного холециститу гостро розвинулася жовтяниця. Під час ЕКГ-обстеження звернено увагу, що на тлі правильного синусового ритму (ЧСС - 51/хв.) періодично з''являються екстрасистоли. Який механізм, найімовірніше, викликав порушення електричної активності серця?', 'medium', 62, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подразнення рецепторів блукаючого нерва жовчними кислотами', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкоджуюча дія жовчних кислот на синусовий вузол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкоджуюча дія жовчних кислот на міокард', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подразнювальна дія жовчних кислот на синусовий вузол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подразнення провідної системи токсинами, які не були знешкоджені в печінці', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки 32 років після перенесеного міокардиту виявлено під час електрокардіографічного дослідження порушення серцевого ритму (ритм не синусовий). Функції яких кардіоміоцитів порушені?', 'medium', 63, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пейсмекерних клітин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливих кардіоміоцитів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідних кардіоміоцитів ніжок пучка Гіса', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перехідних провідних кардіоміоцитів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідних кардіоміоцитів пучка Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини необхідно оцінити стан клапанів серця. Яким з інструментальних методів дослідження доцільно скористатися для цього?', 'medium', 64, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зондування судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електрокардіографія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сфігмографія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фонокардіографія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Флебографія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої 45-ти років при електрокардіографічному обстеженні виявлено такі зміни: інтервал P — Q подовжений, при цьому випадає кожен другий або третій комплекс QRST. Яке саме порушення провідності серця спостерігається?', 'medium', 65, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоаурікулярна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішлуночкова блокада', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада I ступеня', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада III ступеня', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада повна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час емоційного перевантаження у пацієнтки віком 30 років частота серцевих скорочень сягнула 112/хв. Яка структура провідної системи серця спричинила цей стан?', 'medium', 66, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гса', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньошлуночковий вузол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркіньє', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гілки пучка Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На ізольованому серці шляхом охолодження припиняють функціонування окремих структур. Яку структуру охолодили, якщо серце внаслідок цього спочатку припинило скорочення, а потім відновило їх із частотою у 2 рази меншою ніж вихідна?', 'medium', 67, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркіньє', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому чоловіку 75-ти років, у якого частота серцевих скорочень була 40/хвилину, імплантували серцевий електростимулятор. Після цього частота серцевих скорочень зросла до 70/хв. Функцію якого відділу серця взяв на себе електростимулятор?', 'medium', 68, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна пучка Гіса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Ізольована клітина серця людини автоматично генерує імпульси збудження з частотою 60 разів за хвилину. З якої структури серця отримано цю клітину?', 'medium', 69, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердя', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини частота серцевих скорочень постійно утримується на рівні 40 разів за хвилину. Що є водієм ритму серця у неї?', 'medium', 70, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Гіса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін''є', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті на ссавці зруйнували певну структуру серця, що призвело до припинення проведення збудження від передсердь до шлуночків. Що саме зруйнували?', 'medium', 71, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніжки пучка Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті подразнюють гілочки блукаючого нерва, які іннервують серце. Це призвело до того, що припинилося проведення збудження від передсердь до шлуночків. Електрофізіологічні зміни в яких структурах серця є причиною цього?', 'medium', 72, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердя', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При дослідженні ізольованого кардіоміоциту встановлено, що він не генерує імпульси збудження автоматично. З якої структури серця отримано кардіоміоцит?', 'medium', 73, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночок', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркін’є', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Пса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гострому інфаркті в міокарді виникає декілька зон в осередку інфаркту: зона некрозу, зона ішемічного пошкодження і зона ішемії. Зоні пошкодження на ЕКГ відповідає:', 'medium', 74, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Негативний зубець T', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зміщення сегменту RS — T вище ізолінії', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глибокий зубець Q', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження зубця R', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплекс QRS типу QS', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Подразнення правого блукаючого нерва спричинило різке сповільнення атріовентрикулярного проведення. На ЕКГ при цьому буде подовжений:', 'medium', 75, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервал R — R', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплекс QRST', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зубець T', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зубець P', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервал P — Q', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На ЕКГ пацієнта мають місце такі зміни: зубець P - нормальний, інтервал P — Q - вкорочений, шлуночковий комплекс QRST - розширений, зубець R -двогорбий або двофазний. Яка із форм аритмії має місце у даного пацієнта?', 'medium', 76, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготіння шлуночків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром WPW (Вольфа-Паркінсона-Уайта)', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Фредеріка (тріпотіння передсердь)', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого виявлено екстрасистолію. На ЕКГ при екстрасистолічному скороченні відсутній зубець P, комплекс QRS деформований, є повна компенсаторна пауза. Які це екстрасистоли?', 'medium', 77, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусні', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкові', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час ЕКГ – дослідження хворої виявлено періодичну появу шлуночкової екстрасистоли. При цьому встановлено, що перед екстрасистолію відсутній зубець Р. Яка найбільш ймовірна причина його зникнення?', 'medium', 78, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада проведення імпульсу по передсердях', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виникнення рефрактерного періоду в передсерді', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада імпульсу в синусовому вузлі', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неможливість ретроградного проведення через AV-вузол', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини зареєстрована електрокардіограма зі зниженою амплітудою зубця R. Що означає цей зубець на ЕКГ?', 'medium', 79, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження від передсердь до шлуночків', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження по шлуночках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поширення збудження по передсердям', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електричну систолу серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електричну діастолу серця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Студенти на занятті з нормальної фізіології отримали завдання визначити на електрокардіограмі атріовентрикулярну затримку. Який показник на ЕКГ вони повинні проаналізувати? (некоректний тест)', 'medium', 80, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амплітуди зубців', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Напрямку зубців', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тривалості зубців', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тривалості комплексу QRST', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тривалості інтервалу R-R', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка віком 43 роки скаржиться на запаморочення та дискомфорт у ділянці серця. Під час ЕГК дослідження виявлено: ознаки АВ-блокади ІІ ступеня, типу Mobitz I. Укажіть, які ЕКГ-критерії властиві цьому порушенню провідності.', 'medium', 81, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поступове подовження інтервалу РQ перед випадінням одного або декількох комплексів QRS', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Незалежна ектопічна активність лівого передсердя', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подовження інтервалу Q-Т', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сталість інтервалу РQ і періодичне випадання одного або декількох комплексів ORS', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна роз’єднаність передсердних і шлуночкових комплексів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта із порушенням серцевого ритму під час проведення ЕКГ спостерігається: ЧСС — 60/хв, інтервал РQ подовжений, періодичне випадіння комплексу QRS. Яке порушення серцевого ритму виявлено у пацієнта?', 'medium', 82, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада правої ніжки пучка Гіса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна АV-блокада І ступеня', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром слабкості Синусового вузла', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна АV-блокада', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна АV-блокада ІІ ступеня', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 30 років під час проведення ЕКГ виявлено такі зміни: наявна ділянка аномального скорочення, в якій відсутній зубець Р комплекс, QRS деформований, зубець Т негативний і протилежно направлений комплексу ORS. Який тип аритмії виник у пацієнта?', 'medium', 83, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова аритмія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистолія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна екстрасистолія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна трахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта спостерігається зменшення швидкості проведення збудження по атріовентрикулярному вузлу. Збільшення тривалості якого компонента ЕКГ спостерігатиметься в цьому разі?', 'medium', 84, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу Р-Q', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу R-R', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зубця Р', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сегмента S-T', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплексу QRS', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнта шпиталізовано зі скаргами на періодичні напади серцебиття, які виникають раптово і так само раптово припиняються. Під час проведення ЕКГ виявлено епізод скорочень частотою 200/хв, який має такі ознаки: ритм правильний, зубець Р відсутній, комплекс QRS без змін, зубець Т деформований. Укажіть вид аритмії.', 'medium', 85, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АВ блокада І ступеня', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Суправентрикулярна пароксизмальна тахікардія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна АВ блокада', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистолія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час реєстрації ЕКГ пацієнта з гіперфункцією щитоподібної залози зареєстровано збільшення частоти серцевих скорочень. Скорочення якого елемента ЕКГ про це свідчить?', 'medium', 86, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сегмента P-Q', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплексу QRS', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу R-R', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу Р-Q', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу Р-Т', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого в інфекційному відділенні спостерігається підвищення температури до 39^oC) При ЕКГ дослідженні інтервал R-R вкорочений, зубець Р збережений перед кожним комплексом QRS. ЧСС- 120/хв. Порушення якої властивості серцевого м''яза призвело до вказаної форми патології ритму?', 'medium', 87, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Засвоєння ритму', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизм і провідність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизм', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність і засвоєння ритму', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка віком 35 років за 2 тижні після перенесеного COVID-19 проходила диспансерне спостереження. Під час проведення ЕКГ виявлено зниження вольтажу зубців, зубець Р не змінений і зв''язаний з QRS комплексом, тривалість інтервалу РQ - 0,32 с. Який тип аритмії розвинувся у пацієнтки?', 'medium', 88, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Вольфа-Паркінсона-Уайта', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріо-вентрикулярна блокада 1 ступеня', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріо-вентрикулярна блокада 3 ступеня', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріо-вентрикулярна блокада 2 ступеня', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 30 років під час проведення ЕКГ виявлено наступні зміни: ділянка аномального скорочення, в якій відсутній зубець Р, комплекс QRS деформований, зубець Т негативний і протилежно направлений комплексу QRS. Який патологічний стан спостерігається у пацієнта?', 'medium', 89, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистолія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна екстрасистолія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова аритмія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт віком 48 років перебуває у стані непритомності. Перед цим пацієнт кілька разів втрачав свідомість із появою судом. На ЕКГ зубці Р та деформовані комплекси QRS не пов''язані між собою. Частота скорочень передсердь близько 70/хв, шлуночків - 25-30/хв. Яка аритмія виникла у пацієнта?', 'medium', 90, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна передсердно-шлуночкова блокада', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньопередсердна блокада', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньошлуночкова блокада', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова блокада 1 ступеня', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова блокада 2 ступеня', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У студента перед іспитом збільшилася ЧСС. Які зміни на ЕКГ характерні для тахікардії?', 'medium', 91, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Укорочення інтервалу R-R', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подовження інтервалу R-R', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширення комплексу QRS', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подовження інтервалу P-Q', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подовження сегменту Q-T', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Підліток 15 років, скаржиться на недостачу повітря, загальну слабкість, серцебиття. ЧСС 130/хв, АТ-100/60 мм рт. ст. на ЕКГ, комплекс QRS нормальної форми та тривалості. Число зубців Р та шлункових комплексів однакове, зубець Т злитий з зубцем Р. Яка аритмія серця спостерігається у підлітка?', 'medium', 92, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна пароксизмальна тахікардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тремтіння передсердь', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мерехтіння передсердь', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова екстрасистолія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 68 років переніс інфаркт міокарду. Під час ЕКГ-обстеження спостерігається прогресивне збільшення тривалості інтервалу PQ аж до випадіння комплексу QRS, після чого інтервал PQ відновлюється. З порушенням якої функції серця пов''язане таке порушення серцевого ритму?', 'medium', 93, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідності', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизму', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливості', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливості', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При аналізі ЕКГ встановлено: ритм синусовий, число передсердних комплексів перевищує число шлуночкових комплексів; прогресуюче подовження інтервалу Р-Q від комплексу до комплексу; випадання окремих шлуночкових комплексів, через що після зубця Р йде довга пауза; зубці Р та комплекси QRST без змін. Назвіть тип порушення серцевого ритму:', 'medium', 94, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна атріовентрикулярна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна атріовентрикулярна блокада III ступеня', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна атріовентрикулярна блокада І ступеня', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна атріовентрикулярна блокада II ступеня', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При аналізі ЕКГ виявлено випадіння деяких серцевих циклів PQRST. Наявні зубці та комплекси не змінені. Назвать вид аритмії:', 'medium', 95, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистола', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньопередсердна блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Аналіз ЕКГ хворого виявив відсутність зубця P. Тривалість та амплітуда QRS комплексу та зубця Т відповідають нормі. Що є водієм ритму серця даного пацієнта?', 'medium', 96, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусовий вузол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Волокна Пуркіньє', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночковий вузол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокард шлуночків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 49-ти років звернулася до лікаря зі скаргами на підвищену втомлюваність та появу задишки під час фізичного навантаження. На ЕКГ: ЧСС-50/хв, інтервал PQ- подовжений, комплекс QRS - не змінений, кількість зубців P перевищує кількість комплексів QRS. Який вид аритмії в пацієнтки?', 'medium', 97, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова брадикардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрасистолія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Підліток 15 років скаржиться на брак повітря, загальну слабкість, серцебиття. ЧСС -130 уд./ хв., АТ -100/60 мм рт. ст, на ЕКГ комплекс QRS нормальної форми і тривалості. Число зубців Р і шлуночкових комплексів однакове, зубець Т злився з зубцем Р. Яка аритмія серця спостерігається у підлітка?', 'medium', 98, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова екстрасистолія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мерехтіння передсердь', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна пароксизмальна тахікардія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тремтіння передсердь', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При аналізі ЕКГ встановлено: ритм синусовий, правильний, інтервал RR скорочений, розташування і тривалість інших інтервалів, зубців і сегментів не змінені. Укажіть тип аритмії.', 'medium', 99, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіовентрикулярний ритм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова брадикардія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова аритмія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнта шпиталізовано зі скаргами на періодичні напади серцебиття, які виникають раптово і так само раптово припиняються. Під час проведення ЕКГ виявлено епізод скорочень частотою 200 уд/хв, який має такі ознаки: ритм правильний, зубець Р відсутній, комплекс QRS без змін, зубець Т деформований. Укажіть вид аритмії.', 'medium', 100, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АВ блокада І ст.', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна екстрасистолія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Суправентрикулярна пароксизмальна тахікардія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна АВ блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки з ішемічною хворобою серця ЧСС на ЕКГ становить 230/хв., зубець Р деформований, шлуночкові комплекси без змін. Які порушення серцевого ритму в хворої?', 'medium', 101, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердна пароксизмальна тахікардія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тріпотіння передсердь', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистола', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий надійшов у реанімаційне відділення в стані гіпоксії, що виникла внаслідок аспірації блювотних мас. Об’єктивно: стан важкий, шкірні покриви вологі, бліді, з акроціанозом. Спостерігаються тахіпное, тахікардія, зниження АТ. Який із наведених симптомів гіпоксії, що розвивається гостро, належить до термінових захисно-пристосувальних реакцій організму?', 'medium', 102, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення потовиділення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блідість шкірних покривів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження АТ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розвиток акроціанозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта на другу добу після розвитку трансмурального інфаркту міокарда відбулося різке падіння систолічного АТ до 60 мм рт.ст. з тахікардією 140/хв, задишкою і втратою свідомості. Який механізм є провідним у патогенезі шоку, що розвинувся?', 'medium', 103, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ударного об''єму серця', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження об''єму циркулюючої крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтоксикація продуктами некротичного розпаду', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактична реакція на міокардіальні білки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 45 років скаржиться на задишку при невеликому фізичному навантажені, набряки на ногах, в анамнезі часті ангіни, хворіє протягом двох років. Діагностовано недостатність кровообігу. Який гемодинамічний показник декомпенсації серця спостерігається в даному випадку?', 'medium', 104, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення хвилинного об’єму серця', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення об’єму циркулюючої крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення венозного тиску', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення артеріального тиску', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 55 років раптово виникло сильне серцебиття та біль у ділянці серця, різка слабкість, підвищення артеріального тиску, нерегулярний пульс з дефіцитом. На ЕКГ виявлено: відсутні хвилі Р і різна тривалість інтервалів R-R. Яке порушення серцевого ритму спостерігається у пацієнта?', 'medium', 105, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція передсердь', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поперечна блокада серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрасистолія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обстеження у юнака віком 16 років виявлено прискорення серцебиття під час вдиху, прискорення серцебиття під час вдиху, сповільнення - під час видиху. На ЕКГ спостерігається: вкорочення інтервалу R - R під час вдиху та подовження його під час видиху. Який вид аритмії спостерігається у пацієнта?', 'medium', 106, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова брадикардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіовентрикулярний ритм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова аритмія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який хворіє грипом спостерігаються: висока температура, задишка, тахікардія. Як зміниться спорідненість Hb до кисню за таких умов?', 'medium', 107, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Змін не відбувається', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшується', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спочатку зростає, а потім зменшується', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зростає', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 55 років раптово виникли сильне серцебиття та болі в серці, різка слабкість, підвищення артеріального тиску, нерегулярний пульс з дефіцитом. На ЕКГ відсутні хвилі Р і різна тривалість інтервалів R-R. Яке порушення серцевого ритму в хворого?', 'medium', 108, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дихальна аритмія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поперечна блокада серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрасистолія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта синусова тахікардія. Для відновлення ритму лікар призначив пацієнтові препарати калію та рекомендував споживання продуктів, багатих на калій. Який механізм дії калію на серце?', 'medium', 109, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищує пейсмекерну активність синусового вузла', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активує симпатичний відділ автономної нервової системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активує парасимпатичний відділ автономної нервової системи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічує симпатичний відділ автономної нервової системи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Знижує пейсмекерну активність синусового вузла', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Людина отримала електротравму При цьому струм пройшов крізь серцевий м’яз. Які небезпечні порушення в роботі серця можуть виникнути у цій ситуації, що вимагають термінового втручання?', 'medium', 110, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикардія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрасистолія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярна блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Підвищення внутрішньочерепного тиску у хворого з церебральною гематомою обумовило надмірну активність блукаючого нерва (ваготонію) та зміну частоти серцевих скорочені. Який вид аритмії серця виникає при ньому?', 'medium', 111, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова брадикардія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого збільшений основний обмін, підвищена температура тіла, тахікардія у стані спокою. Причиною цього може бути підвищена функція :', 'medium', 112, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підшлункової залози.', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статевих залоз.', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кіркової речовини наднирників.', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейрогіпофізу.', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щитовидної залози.', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінку 44-х років вжалила оса внаслідок чого розвинувся шок. В анамнезі вже була важка алергічна реакція на жалення оси. Об’єктивно: пульс -179/хв., слабкий, АТ- 80/40 ммрт.ст., ЧД-26/хв. Яка провідна ланка патогенезу анафілактичного шоку?', 'medium', 113, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження периферійного опору судин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ударного об’єму серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біль', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення об’єму циркулюючої крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на ішемічну хворобу серця відзначається гіпертрофія міокарда, тахікардія, зниження ХОК. Який з механізмів є провідним в ушкодженні кардіоміоцитів у даному випадку?', 'medium', 114, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження специфічних мембранних насосів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дегідратація кардіоміоцитів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення числа а та β-адренорецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Втрата Mg2+ кардіоміоцитами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Втрата Ca2+ кардіоміоцитами', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При проходженні профілактичного огляду у шахтаря лікар встановив зміни функціонального стану серця, що свідчать про серцеву недостатність у стадії компенсації. Що з нижче перерахованого є головним підтвердженням компенсації діяльності серця?', 'medium', 115, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертрофія міокарда', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ціаноз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення артеріального тиску', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Задишка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У разі різкого підвищення тиску в аорті знижується сила та частота серцевих скорочень. У складі якого нерва проходять чутливі волокна від барорецепторів дуги аорти?', 'medium', 116, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нерва Герінга', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зворотного нерва', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нерва Павлова', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блукаючого нерва', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Язико-глоткового нерва', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час операції на органах заднього середостіння існує ризик пошкодження нервів, розташованих поруч зі стравоходом. Назвіть ці нерви.', 'medium', 117, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжреберні нерви', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діафрагмові нерви', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Язикоглоткові нерви', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блукаючі нерви', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Додаткові нерви', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Унаслідок ДТП жінка отримала сильний удар в епігастральну ділянку, через що у неї сталася зупинка серця. Яка ймовірна причина зупинки серцевої діяльності?', 'medium', 118, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшене виділення альдостерону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тонусу симпатичної нервової системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшене виділення кортизолу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тонусу блукаючого нерва', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшене виділення адреналіну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У підлітка після перенесеного інфекційного захворювання з’явилася різко виражена аритмія з вкороченням інтервалу R-R під час вдиху і подовження його під час видиху. Що лежить в основі даного виду аритмії?', 'medium', 119, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефлекс Бейнбріджа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення функції провідності серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вплив мікробних токсинів на серце', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення фунції збудливості серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Коливання тонусу блукаючого нерва під час акту дихання', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту при подразненні блукаючого нерва внаслідок стимуляції виходу ацетилхоліну в синаптичну щілину зменшується частота серцевих скорочень (ЧСС). Який механізм цих змін?', 'medium', 120, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тривалості потенціалу дії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення швидкості проведення збудження в АВ-вузлі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Деполяризація мембрани кардіоміоцитів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення тривалості потенціалу дії', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперполяризація мембрани кардіоміоцитів', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті досліджували впливи симпатичної та парасимпатичної систем на серцево-судинну діяльність. Унаслідок подразнення блукаючого нерва спостерігалося зниження артеріального тиску. На чому переважно грунтується такий ефект парасимпатичної системи?', 'medium', 121, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні частоти серцевих скорочень', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширенні артеріол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні периферичного опору судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширенні вен', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні сили серцевих скорочень', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Подразнення правого блукаючого нерва спричинило різке сповільнення атріовентрикулярного проведення. На ЕКГ про це буде свідчити подовження:', 'medium', 122, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зубця Р', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу PQ', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтервалу RR', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплексу QRST', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зубця Т', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Підвищення внутрішньочерепного тиску у хворого з церебральною гематомою обумовило надмірну активність блукаючого нерва (ваготонію) та зміну частоти серцевих скорочені. Який вид аритмії серця виникає при ньому?', 'medium', 123, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова брадикардія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова тахікардія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночкова екстрасистолія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова блокада', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті подразнюють гілочки блукаючого нерва, які іннервують серце. Це призвело до того, що припинилося проведення збудження від передсердь до шлуночків. Електрофізіологічні зміни в яких структурах серця є причиною цього?', 'medium', 124, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальний вузол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріовентрикулярний вузол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердя', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлуночки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пучок Гіса', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту, внаслідок уведення тварині синтетичного аналога тиреоїдних гормонів, збільшилася частота серцевих скорочень, що опосередковано:', 'medium', 125, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматичною нервовою системою', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатичною нервовою системою', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метасимпатичною нервовою системою', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатичною нервовою системою', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У передсердях продукується передсердний натрійуретичний пептид. Що є основним механізмом стимуляції секреції цього гормону?', 'medium', 126, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення частоти серцевих скорочень за рахунок вкорочення тривалості діастоли', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатична іннервація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розтягування або посилення напруження стінки міокарда', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилення роботи Na+/Ca2+ - помпи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вплив n. vagus', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Які зміни процесів гемокоагуляції виникнуть у людини у разі підвищення активності симпатичної нервової системи?', 'medium', 127, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемокогуляція підсилиться', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемокоагуляція зменшиться', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноліз зменшиться', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемокоагуляція не зміниться', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антизсідальна система активується', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті досліджували впливи симпатичної та парасимпатичної систем на серцево-судинну діяльність. Унаслідок подразнення блукаючого нерва спостерігалося зниження артеріального тиску. На чому переважно грунтується такий ефект парасимпатичної системи?', 'medium', 128, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні частоти серцевих скорочень', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширенні артеріол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні периферичного опору судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширенні вен', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженні сили серцевих скорочень', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта виявлено порушення серцевого ритму. Для відновлення ритму лікар призначив хворому антагоністи кальцію. Як чином іони кальцію впливають на міокард?', 'medium', 129, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшують силу і частоту серцевих скорочень', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активують симпатичний відділ автономної нервової системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічують симпатичний відділ автономної нервової системи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активують парасимпатичний відділ автономної нервової системи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшують силу і частоту серцевих скорочень', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту подразнюють гілочки симпатичного нерва, які іннервують серце. Це спричинило збільшення сили серцевих скорочень, тому що через мембрану типових кардіоміоцитів збільшився:', 'medium', 130, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вхід іонів кальцію та калію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вихід іонів калію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вхід іонів калію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вхід іонів кальцію', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вихід іонів кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта синусова тахікардія. Для відновлення ритму лікар призначив пацієнтові препарати калію та рекомендував споживання продуктів, багатих на калій. Який механізм дії калію на серце?', 'medium', 131, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищує пейсмекерну активність синусового вузла', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активує симпатичний відділ автономної нервової системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активує парасимпатичний відділ автономної нервової системи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічує симпатичний відділ автономної нервової системи', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Знижує пейсмекерну активність синусового вузла', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Унаслідок стресу у похилої людини підвищився артеріальний тиск. Причиною цього є активація:', 'medium', 132, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпато-адреналової системи', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Функції щитоподібної залози', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатичного ядра блукаючого нерва', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Функції кори наднирників', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Функції гіпофізу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту, внаслідок уведення тварині синтетичного аналога тиреоїдних гормонів, збільшилася частота серцевих скорочень, що опосередковано:', 'medium', 133, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматичною нервовою системою', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатичною нервовою системою', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метасимпатичною нервовою системою', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатичною нервовою системою', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки віком 37 років зі встановленим діагнозом: феохромоцитома - після психічного навантаження виникла тахікардія, підвищення артеріального тиску, різкий біль у надчеревній ділянці. Чим зумовлений стан пацієнтки?', 'medium', 134, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією вегетативних ядер гіпоталамуса', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Масивним викиданням катехоламінів наднирниками', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищеним синтезом кортикотропіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звільненням норадреналіну симпатичними нервами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням секреції тиреоїдних гормонів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з феохромоцитомою після психічного навантаження виникає тахікардія, підвищується артеріальний тиск, з''являється різкий біль у надчеревній ділянці. У зв''язку з чим виникають ці напади?', 'medium', 135, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищеним синтезом адренокортикотропного гормону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Масивним викидом катехоламінів наднирниками', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням секреції тиреоїдних гормонів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією вегетативних ядер гіпоталамуса', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звільненням норадреналіну симпатичними нервами', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обробки атипових кардіоміоцитів синоатріального вузла біологічно активною речовиною, зареєстровано збільшення їх мембранного потенціалу через збільшену проникність для іонів калію. Яка біологічно активна речовина впливала на кардіоміоцити?', 'medium', 136, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилхолін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атріопептид', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Небезпечним моментом у патогенезі некрозу міокарда є подальше наростання зон некрозу, дистрофії та ішемії. Важлива роль у цьому процесі належить підвищенню споживання кисню міокардом. Які речовини сприяють цьому процесу?', 'medium', 137, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іони хлору', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катехоламіни', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилхолін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При взаємодії ацетилхоліну з М-холінорецепторами скоротливих кардіоміоцитів утворюється біологічно активна речовина, яка зумовлює інактивацію кальцієвих каналів, зменшення входу іонів кальцію в кардіоміоцит і розвиток негативного інотропного ефекту. Назвіть цю речовину:', 'medium', 138, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклічний гуанозинмонофосфат (цГМФ)', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклічний аденозинмонофосфат (цАМФ)', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклічний аденозинтрифосфат (цАТФ)', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклічний гуанозинтрифосфат (цГТФ)', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклічний аденозиндифосфат (цАДФ)', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У піддослідної тварини після внутрішньовенного уведення гормону відзначається розширення зіниць, тахікардія, зростання АТ, Гальмування моторики ШКТ. Який препарат уводили тварині?', 'medium', 139, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естрогени', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АДГ', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини внаслідок фізичного навантаження збільшилася швидкість зсідання крові. Збільшення концентрації у крові якого гормону є причиною цього?', 'medium', 140, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизолу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плазмінів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з підвищеним артеріальним тиском, тремором, тахікардією, була діагностовано доброякісна пухлина мозкової речовини наднирників. Гіперсекреція якого гормону викликає таку симптоматику?', 'medium', 141, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину на зовнішній поверхні аортального клапана, виявлені великі (1-2 см) буровато-червоні, крихкі нашарування, які прикривають виразкові дефекти. Який найбільш вірогідний діагноз?', 'medium', 142, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний ендокардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий ендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний ендокардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотній бородавчастий ендокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно-виразковий ендокардит', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла померлої в комі молодої людини, виявлено: поширений тромбоемболічний інфаркт лівої півкулі мозку, велика септична селезінка, імунокомплексний гломерулонефрит, виразки на стулках аортального клапану, що прикриті поліпоподібними тромбами з колоніями стафілококів. Яке захворювання викликало церебральну тромбоемболію?', 'medium', 143, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септикопіємія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматичний тромбендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септичний бактеріальний ендокардит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий ревматичний вальвуліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септицемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні стулки мітрального клапана серця виявлено: мукоїдний набряк, пошкодження ендотелію, утворення по замикаючому краю фібринових тромбів. Яка форма ревматичного ендокардиту спостерігається?', 'medium', 144, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий ендокардит', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний ендокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно - виразковий ендокардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний ендокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотно - бородавчастий ендокардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження стулок мітрального клапана серця жінки віком 30 років встановлено, що ендотеліальні клітини вогнищево десквамовані, у цих ділянках на поверхні стулки розташовані дрібні тромботичні нашарування, сполучна тканина стулки з явищами мукоїдного набухання з ділянками склерозу та васкуляризації. Який ймовірно вид клапанного ендокардиту в пацієнтки?', 'medium', 145, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно-виразковий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотньо-бородавчастий', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого діагностовано септичний ендокардит. Температура тіла протягом 5-ти днів коливалася в межах 39,5oC -40,2oC. На 6-й день на тлі різкого зниження температури до35,2oC розвинувся колапс. Який головний механізм колапсу?', 'medium', 146, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазодилатація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилене потовиділення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпервентиляція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на підгострий септичний ендокардит при огляді лікар відзначив загальну слабкість і іктеричність шкіри, склер і видимих слизових оболонок. У крові виявлена збільшена кількість непрямого білірубіну. Що зумовлює жовтяничність шкіри і слизових?', 'medium', 147, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Печінкова жовтяниця', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемосидероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Надпечінкова жовтяниця', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підпечінкова жовтяниця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова дистрофія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження стулок мітрального клапана серця жінки 30-ти років було встановлено, що ендотеліальні клітини вогнищево десквамовані, у цих ділянках на поверхні стулки розташовані дрібні тромботичні нашарування, сполучна тканина стулки з явищами мукоїдного набухання з ділянками склерозу та васкуляризації. Діагностуйте вид клапанного ендокардиту:', 'medium', 148, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий бородавчастий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поворотнь-бородавчастий', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпозно-виразковий', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії дитини, померлої від серцевої недостатності, виявлено: розширення порожнин шлуночків серця. Мікроскопічно спостерігається: у стромі міокарда повнокрів''я, набряк, розповсюджені інфільтрати з гістіоцитів, лімфоцитів, нейтрофілів, еозинофілів. Якому захворюванню відповідають такі патологічні зміни?', 'medium', 149, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Осередковому проміжному ексудативному міокардиту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжному продуктивному міокардиту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтеративному міокардиту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовому продуктивному міокардиту', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузнопроміжному ексудативному міокардиту', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 58-ми років помер від прогресуючої серцевої недостатності. На розтині: серце розширене у поперечнику, мляве, м’яз на розрізі нерівномірного кровонаповнення, пістрявий. При гістологічному дослідженні: у міокарді повнокров’я, у стромі лімфогістіоцитарні інфільтрати, що розсувають кардіоміоцити. Виявлені морфологічні зміни свідчать про:', 'medium', 150, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіосклероз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирову дистрофію міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Негнійний проміжний міокардит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Венозне повнокров’я', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині тіла дитини, померлої від серцевої недостатності, виявлено: розширення порожнин шлуночків серця. Мікроскопічно в стромі міокарда повнокров’я, набряк, розповсюджені інфільтрати з гістіоцитів, лімфоцитів, нейтрофілів, еозинофілів. Який найбільш імовірний діагноз?', 'medium', 151, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Осередковий проміжний ексудативний міокардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий продуктивний міокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузнопроміжний ексудативний міокардит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтернативний мюкардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжний продуктивний мюкардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий помер від прогресуючої серцевої недостатності. На розтині серце розширене у поперечнику, мляве, м’яз на розрізі нерівномірного кровонаповнення, пістрявий, при гістологічному дослідженні у міокарді повнокров’я, у стромі лімфогістіоцитарні інфільтрати, що розсувають кардіоміоцити. Виявлені морфологічні зміни свідчать про:', 'medium', 152, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Негнійний проміжний міокардит', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіосклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Венозне повнокрів’я', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирову дистрофії міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з важким перебігом респіраторної вірусної інфекції з’явилися клінічні ознаки прогресуючої серцевої недостатності, яка призвела до смерті хворого на 2-му тижні захворювання. На аутопсії: серце зі значним розширенням порожнин, в’яле. Гістологічно в міокарді виявляється повнокров’я мікросудин і дифузна інфільтрація строми лімфоцитами та гістіоцитами. Який найбільш вірогідний діагноз?', 'medium', 153, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стенокардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміопатія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра коронарна недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з гострим міокардитом зʼявилися клінічні ознаки кардіогенного шоку. Який із нижченаведених патогенетичних механізмів є провідним у розвитку шоку?', 'medium', 154, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення периферичного опору судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження діастолічного притоку до серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення насосної функції серця', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Депонування крові в органах', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження судинного тонусу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік з гострим міокардитом помер від серцево-судинної недостатності. В ході мікроскопічного дослідження внутрішніх органів виявлені: плазморагія, набряк, стази в капілярах, численні крововиливи, а також дистрофічні зміни в паренхімі. Наслідком чого є дані зміни?', 'medium', 155, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Місцеве артеріальне повнокрів’я', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний загальний венозний застій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий загальний венозний застій', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДВЗ -синдром', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальне артеріальне повнокрів’я', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хлопчика 8-ми років, що хворів на дифтерію зіва та мигдаликів і помер на другий тиждень від початку захворювання, виявлено зміни в міокарді у вигляді дрібновогнищевих некрозів міокардиоцитів, набряку строми з незначною лімфоцитарною інфільтрацією. Діагностуйте вид міокардиту:', 'medium', 156, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтеративний', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерстиційний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гранулематозний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септичний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вогнищевий проміжний ексудативний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 58-ми років, померлого при наростаючих явищах хронічної серцевої недостатності, діагностовано ревматичний гранульоматозний міокардит. Мікроскопічно в міокарді спостерігаються гранульоми, що складаються з макрофагів з гіперхромними ядрами та світлою цитоплазмою, в центрі - осередок некрозу. Який характер має некроз всередині гранульоми?', 'medium', 157, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїдний', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Казеозний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жировий', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ценкеровський', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колікваційний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На аутопсії померлого від грипу чоловіка відзначено, що серце дещо збільшене в розмірах, пастозне, на розрізі міокард тьмяний, з крапом. Мікроскопічно: у міокарді на всьому протязі ознаки паренхіматозної жирової й гідропічної дистрофії, строма набрякла, з незначною макрофагально-лімфоцитарною інфільтрацією, судини повнокровні; периваскулярно - петехіальні крововиливи. Який вид міокардиту розвинувся в даному випадку?', 'medium', 158, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний вогнищевий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний дифузний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гранулематозний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжний проліферативний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження коронарних артерій виявлені атеросклеротичні бляшки з кальцинозом, що закривають просвіт судин на 1/3. У м’язі дрібні множинні білуваті прошарки сполучної тканини. Як називається процес, виявлений у міокарді?', 'medium', 159, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Післяінфарктний кардіосклероз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний кардіосклероз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тигрове серце', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину трупа чоловіка 60-ти років у міокарді передньої стінки лівого шлуночка виявлене сіре неправильної форми щільне вогнище 5х4 см з чіткими межами, волокнистої структури. Який діагноз найбільш вірогідний?', 'medium', 160, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміопатія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Післяінфарктний міокардіосклероз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний дрібновогнищевий міокардіосклероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 45 років скаржиться на задишку при невеликому фізичному навантаженні, набряки на ногах, в анамнезі часті ангіни, хворіє протягом двох років. Діагностовано міокардит, комбінований мітральний порок серця, недостатність кровообігу. Який гемодинамічний механізм декомпенсації серця у хворої?', 'medium', 161, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження венозного тиску', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення обсягу циркулюючої крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення артеріального тиску', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення хвилинного об''єму серця', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який півтора місяця тому переніс інфаркт міокарда, діагностовано синдром Дреслера з характерною тріадою: перикардит, плеврит, пневмонія. Який головний механізм цього ускладнення?', 'medium', 162, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження резистентності до інфекційних агентів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтоксикація організму продуктами некрозу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація сапрофітної мікрофлори', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Викидання у кров міокардіальних ферментів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізація організму антигенами міокарда', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на хронічний пієлонефрит помер від хронічної ниркової недостатності. При житті аускультативно відмічено "шум тертя перикарду? На розтині виявлено. що епікард тьмяний, шорсткий, ніби покритий волосяним покривом. Який перикардит за характером запалення має місце?', 'medium', 163, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнильний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині в серці виявлено наступні зміни: великий осередок некрозу білого кольору з червоною облямівкою, який захоплює всю товщу серцевого м’яза. На зовнішній оболонці серця - ознаки фібринозного перикардиту. Який найбільш імовірний діагноз?', 'medium', 164, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтрамуральний інфаркт міокарда', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субендокардіальний інфаркт міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субепікардіальний інфаркт міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансмуральний інфаркт міокарда', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хворого 43-х років, померлого від ревматизму, поверхня епікарду ворсиста, покрита плівками сірого кольору, що легко відділяються. Після їх відділення визначається набрякла повнокровна поверхня епікарду. Який найбільш імовірний діагноз?', 'medium', 165, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний перикардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний перикардит', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферативний перикардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний перикардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Катаральний перикардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дівчинки 12 років при розтині виявлені множинні крововиливи в шкірі (переважно сідниць, нижніх кінцівок), серозних і слизових оболонках, в головному мозку. У надниркових залозах - вогнищевий некроз і масивні крововиливи, в нирках - некротичний нефроз, гнійний артрит, іридоцикліт, васкуліт. Який найбільш ймовірний діагноз?', 'medium', 166, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Променева хвороба', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Висипний тиф', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний червоний вовчак', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Менінгококцемія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження біоптату шкіри хворого на алергічний васкуліт знайдено: стінка судин потовщена, гомогенна, пікрофуксином забарвлюється у жовтий колір, ШІК-позитивна. Який патологічний процес розвинувся в стінках судин?', 'medium', 167, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпідоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мукоїдне набухання', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліноз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїдне набухання', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопії біоптату печінки виявлені гранульоми, які складаються з плазматичних, лімфоїдних, гігантських багатоядерних клітин типу Пирогова- Ланхганса, дрібних судин з ознаками ендо- і периваскуліту, зустрічаються осередки казеозного некрозу. Для якого захворювання характерно утворення таких гранульом?', 'medium', 168, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифіліс', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепра', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сап', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклерома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У померлого внаслідок серцевої недостатності на шкірі відзначаються сліди висипу у вигляді плям і крапок. У ділянці крижі, остистих відростків хребців - пролежні. При мікроскопічному дослідженні ЦНС, шкіри, надниркових залоз, у судинах мікроциркуляторного русла й дрібних артеріях - деструктивно-проліферативний ендотромбоваскуліт з наявністю гранульом Попова; у серці - інтерстиційний міокардит. Який з перелічених діагнозів найбільш вірогідний?', 'medium', 169, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ВІЛ-інфекція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Черевний тиф', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Висипний тиф', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ку -гарячка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з високим титром антинуклеарних антитіл смерть настала від наростаючої ниркової недостатності. При патологоанатомічному дослідженні виявлений мезангіопроліферативний гломерулонефрит, абактеріальний бородавчастий ендокардит; в селезінці - періартеріальний цибулинний склероз, в шкірі - продуктивнопроліферативний васкуліт. Який найбільш вірогідний діагноз?', 'medium', 170, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротичний синдром', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматоміозит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний червоний вовчак', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматизм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Через три тижні після пересадки серця у пацієнта різко погіршився стан. Смерть настала від гострої серцевої недостатності. Гістологічно в міокарді виявлено васкуліт, некрози та лімфоцитарну інфільтрацію. Назвіть причину таких змін:', 'medium', 171, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре відторгнення трансплантату', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне відторгнення трансплантату', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Найгостріше відторгнення трансплантату', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротизуючий васкуліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У біоптаті дужок м''якого піднебіння, який взяли на аналіз через підозру на пухлину (макроскопічно визначалася виразка зі щільним дном), виявлено некроз слизової оболонки з інфільтрацією підслизового шару лімфоцитами, епітеліоїдними клітинами, плазматичними клітинами, поодинокими нейтрофілами, наявність вираженого ендо- та периваскуліту. Для якого захворювання характерні ці симптоми?', 'medium', 172, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виразкового стоматиту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтерії зіву', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виразково-некротичного стоматиту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Афтозного стоматиту', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинного сифілісу', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта спостерігалися: висип у вигляді розеол і петехій на шкірі живота і грудної клітки, дрібнокрапковий кон''юн-ктивальний висип. Пацієнт помер на тлі явищ ураження мозку. Під час мікроскопічного дослідження секційного матеріалу в головному мозку (довгастий мозок, міст), шкірі, нирках і міокарді виявлено деструктивно-проліферативний ендотромбоваскуліт. Яке захворювання імовірно мав чоловік?', 'medium', 173, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Черевний тиф', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний червоний вовчак', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сепсис', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Висипний тиф', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 44 років перед смертю спостерігалося різке падіння артеріального тиску. На розтині виявлено аневризму дуги аорти до 10 см у діаметрі. Інтима аорти у висхідній частині та дузі має зморшкуватий вигляд, інтима аорти відшарована; між інтимою і середнім шаром аорти є згустки крові. Мікроскопічно спостерігається: в середньому шарі великовогнищева інфільтрація лімфоїдними, плазматичними і епітеліоїдними клітинами, руйнування еластичних волокон і розростання сполучної тканини, васкуліти emph vasa vasorum. Для якого захворювання характерні такі зміни?', 'medium', 174, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматичний аортит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий поліартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неспецифічний аортоартеріїт', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезаортит', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклеротична аневризма аорти', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дев''ятирічна дитина захворіла гостро: температура тіла - 39,5^oС, інтоксикація, петехіальний висип з некрозами в центрі на нижніх кінцівках, гнійне запалення оболонок ока, серцево-судинна недостатність із різким падінням артеріального тиску. Дитина померла. Під час розтину тіла було виявлено: на шкірі та у внутрішніх органах васкуліти з тромбозом, некрозами, крововиливами і гнійним запаленням; наднирники збільшені в розмірах, темно-червоні, з масивними крововиливами. Для якого захворювання характерні такі симптоми?', 'medium', 175, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний васкуліт', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кір', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Менінгококцемія з синдромом Вотергауза-Фредеріксена', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скарлатина', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий міліарний туберкульоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопії біоптату печінки виявлено гранульоми, які складаються зі плазматичних, лімфоїдних, гігантських багатоядерних клітин типу Пирогова-Лангханса, дрібних судин із ознаками ендо- і периваскуліту, трапляються осередки казеозного некрозу. Для якого захворювання характерні такі гранульоми?', 'medium', 176, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілісу', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Риносклероми', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепри', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сапу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні біоптату шкіри у хворого 24-х років виявлено казеозний некроз, оточений клітинним інфільтратом з лімфоцитів, серед яких зустрічаються окремі велетенські клітини, має місце розростання сполучної тканини, ендоваскуліти. Який характер патологічного процесу?', 'medium', 177, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Жінка віком 50 років померла від прогресуючої ниркової недостатності. Прижиттєві біохімічні аналізи показали високий титр антинуклеарних антитіл. Під час мікроскопічного дослідження було виявлено: мезангіопроліферативний гломерулонефрит, абактеріальний бородавчастий ендокардит, периартеріальний цибулеподібний склероз селезінки, у шкірі обличчя проліферативний васкуліт. Яке захворювання спричинило смерть жінки?', 'medium', 178, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротичий синдром', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра ревматична гарячка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний червоний вовчак', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматоміозит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на тромбофлебіт призначено комплексну терапію, яка діє на різні етапи тромбоутворення. Яке з перелічених засобів сприяє відновленню прохідності судини?', 'medium', 179, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилсаліцилова кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепарин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дипіридамол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неодикумарин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринолізин', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої, яка страждає на тромбофлебіт глибоких вен гомілки, раптово настала смерть. На розтині трупа у загальному стовбурі і біфуркації легеневої артерії знайдено червоні пухкі маси з тьмяною гофрованою поверхнею, що лежать вільно. Який патологічний процес виявив патологоанатом?', 'medium', 180, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова емболія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емболія стороннім тілом', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинна емболія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на тромбофлебіт нижніх кінцівок з’явився біль у грудній клітці, кровохаркання, наростаюча дихальна недостатність, при явищах якої він помер. На розтині діагностовано множинні інфаркти легень. Яка найбільш вірогідна причина їх розвитку в цьому випадку?', 'medium', 181, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз гілок легеневої артерії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія гілок легеневої артерії', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія бронхіальних артерій', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз бронхіальних артерій', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз легеневих вен', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Через дві доби після пологів у жінки розвинулася клініка шоку з ДВЗ-синдромом, внаслідок чого породілля померла. На аутопсії виявлений гнійний ендоміометрит, регіональний гнійний лімфангіт і лімфаденіт, гнійний тромбофлебіт. У паренхіматозних органах - дистрофічні зміни й проміжне запалення. Який діагноз найбільш вірогідний?', 'medium', 182, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхуровий занесок', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз статевих органів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сепсис', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Деструюючий міхуровий занесок', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифіліс', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з тромбофлебітом нижніх кінцівок раптово після навантаження виникли задишка, різкий біль у грудях, ціаноз, набухання шийних вен. Яке найбільш імовірне порушення кровообігу виникло у хворого?', 'medium', 183, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія вінцевих судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія мезентеріальних судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія ворітної вени', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія легеневої артерії', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболія судин головного мозку', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінці 50-ти років, яка хворіє на тромбофлебіт, ввели гепарин, що спровокував кишкову кровотечу. Який препарат потрібно призначити?', 'medium', 184, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію цитрат', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кислоту амінокапронову', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протаміну сульфат', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стрептокіназу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вікасол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки, яка приймає неодикумарин у зв''язку із тромбофлебітом, виникла кровоточивість. Який препарат необхідно призначити?', 'medium', 185, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протаміну сульфат', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дипіридамол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилсаліцилова кислота', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пентоксифілін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вікасол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка віком 65 років, яка хворіє на тромбофлебіт глибоких вен гомілки, раптово померла. Під час розтину тіла в загальному стовбурі та біфуркації легеневої артерії спостерігаються вільно лежачі червоні пухкі маси із тьмяною гофрованою поверхнею. Який патологічний процес у легеневій артерії виявлено?', 'medium', 186, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емболію сторонніми тілами', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирову емболію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинну емболію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоемболію', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У підлітка після перенесеного інфекційного захворювання з’явилася різко виражена аритмія з вкороченням інтервалу R-R під час вдиху і подовження його під час видиху. Що лежить в основі даного виду аритмії?', 'medium', 187, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефлекс Бейнбріджа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення функції провідності серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вплив мікробних токсинів на серце', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення фунції збудливості серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Коливання тонусу блукаючого нерва під час акту дихання', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 55 років раптово виникли сильне серцебиття та болі в серці, різка слабкість, підвищення артеріального тиску, нерегулярний пульс з дефіцитом. На ЕКГ відсутні хвилі Р і різна тривалість інтервалів R-R. Яке порушення серцевого ритму в хворого?', 'medium', 188, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дихальна аритмія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поперечна блокада серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстрасистолія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки, яка хворіє на ішемічну хворобу серця, розвинувся кардіосклероз, що супроводжується аритмією серця. Назвіть вид аритмії, за якого одночасно порушуються автоматизм і провідність:', 'medium', 189, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синоатріальна блокада', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова блокада', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньопередсердна блокада', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова аритмія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час об’єктивного обстеження хворого з діагнозом: атеросклеротичний міокардіосклероз, лікар встановив феномен дефіциту пульсу. При якій формі порушення серцевого ритму спостерігається такий феномен?', 'medium', 190, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Миготлива аритмія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синусова екстрасистолія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіовентрикулярний ритм', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Брадикардія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночковий ритм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після перевʼязки однієї з гілок вінцевих артерій у собаки розвинувся інфаркт міокарда, який супроводжувався проявами резорбційно-некротичного синдрому. Укажіть найхарактернішу ознаку розвитку цього синдрому.', 'medium', 191, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біль за грудниною', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження хвилинного обʼєму крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення у крові креатинкінази', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення у крові катехоламінів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки, яка упродовж 15 років хворіє вираженою гіпертензією, з''явилися задишка, серцебиття, знизився систолічний тиск, діастолічний залишився без змін. Який основний механізм виникнення серцевої недостатності у жінки?', 'medium', 192, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним опором викиду крові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення регуляції серцевої діяльності', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодження міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення проведення імпульсу по міокарду', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним об''ємом крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла пацієнта з діагнозом: мієломна хвороба, який помер з явищами серцевої недостатності, виявлено збільшене в розмірах серце з розширеними порожнинами. Міокард блідий, має щільну консистенцію і воскоподібний блиск. Мікроскопічно під час забарвлення конго-рот визначається позитивна реакція. Для якої патології серця характерні такі результати дослідження?', 'medium', 193, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '–', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальне серце', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тигрове серце', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ожиріння серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертензивне серце', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з хронічною серцевою недостатністю розвинувся цироз печінки з асцитом і набряками нижніх кінцівок. Які зміни складу крові спричиняють асцит у цього пацієнта?', 'medium', 194, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпохолестеринемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпергаммаглобулінемія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопротромбінемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоальбумінемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Макроглобулінемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У померлого від серцевої недостатності при патоморфологічному дослідженні виявлено: деформацію стулок мітрального клапана, їх потовщення, зрощення по краях; у сполучній тканині міокарда - дифузно розкидані вузлики з ділянками фібриноїдного некрозу, навколо яких скупчуються макрофагоцити, що нагадують гігантські багатоядерні клітини. Подібні вогнища оточені лімфоцитами та поодинокими плазматичними клітинами. Яка з перерахованих гранульом має місце у даного хворого?', 'medium', 195, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Актиномікотична', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітична', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульозна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лепрозна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматична', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки віком 60 років спостерігається застійна серцева недостатність зі збільшенням переднавантаження на серце. Яку біологічно активну речовину буде секретувати серце у цьому разі?', 'medium', 196, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердний натрійуретичний пептид', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин ІІ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлунковий інгібуючий пептид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Який із нижченаведених показників гемодинаміки лежить в основі патогенезу декомпенсації серцевої діяльності у пацієнтів із хронічною серцевою недостатністю?', 'medium', 197, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розвиток тахікардії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення периферичного опору судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення центрального венозного тиску', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тоногенна дилятація', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ударного об''єму', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з інфарктом міокарда артеріальний тиск знизився до 70/40 мм рт. ст. Що є первинним механізмом розвитку артеріальної гіпотензії за серцевої недостатності?', 'medium', 198, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення хвилинного обʼєму кровобігу', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Затримка калію в організмі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазоконстрикція периферичних судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Генералізована вазодилятація', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Втрата організмом натрію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 57-ми років померла від гострої легенево-серцевої недостатності. Під час розтину патологоанатом запідозрив жирову емболію легеневої артерії. Яким методом забарвлення мікропрепаратів потрібно скористатися для підтвердження такого діагнозу?', 'medium', 199, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метиленовим синім', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Конго-рот', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Суданом III', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пікрофуксином', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гематоксилін-еозином', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з діагнозом: серцева недостатність — розвинулися набряки на нижніх кінцівках. Який механізм розвитку дих набряків?', 'medium', 200, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску плазми крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску у венулах', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в артеріолах', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження осмотичного тиску плазми крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт віком 63 роки помер із ознаками гострої серцево-судинної недостатності. Під час аутопсії у передній стінці серця виявлено ділянку жовтувато-сірого кольору, оточену геморагічним вінчиком, а в передній міжшлуночковій артерії — тромб, який повністю закривав просвіт судини та був причиною ішемії міокарда. Яка ішемія за причиною і механізмом розвитку призвела до інфаркту міокарда?', 'medium', 201, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перерозподільча', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Компресійна', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Функціональна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіоспастична', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обтураційна', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтку віком 65 років, яка довгий час хворіла на стеноз аортального клапана, після перенесеної вірусної інфекції шпиталізовано з ознаками хронічної серцево-судинної недостатності, задишкою, ціанозом, набряками. Який тип гіпоксії спостерігається в пацієнтки?', 'medium', 202, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дихальний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циркуляторний', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемічний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоксичний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 63-x років, який протягом 15-ти років страждав на хронічну дифузну обструктивну емфізему легень, помер від прогресуючої серцевої недостатності. Під час розтину тіла виявлено: мускатний цироз печінки, ціанотична індурація нирок та селезінки, асцит, набряки нижніх кінцівок. Для якого типу серцевої недостатності характерні дані зміни у внутрішніх органах?', 'medium', 203, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра правошлуночкова недостатність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра лівошлуночкова недостатність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічна серцева недостатність', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра загальна серцева недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічна недостатність передсердь', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого за добу виділяється води з організму менше, ніж надходить. Яке захворювання може привести до такого стану?', 'medium', 204, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серцева недостатність', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепатит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цистит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфекційні хвороби', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панкреатит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на артеріальну гіпертензію наслідком гіпертонічного кризу стала гостра серцева недостатність. Який механізм серцевої недостатності є головним в даному випадку?', 'medium', 205, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця припливом крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсолютна коронарна недостатність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця опором', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодження міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відносна коронарна недостатність', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка, померлого від гострої серцево-судинної недостатності, виявлені заповнена кров’ю порожнина серцевої сорочки та розплавлений серцевого м’яза бічної поверхні лівого шлуночка. Яка безпосередня причина смерті?', 'medium', 206, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра лівошлуночкова недостатність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемотомпонада перикарда', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіогенний шок', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розрив хронічної аневризми серця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 50 років за місяць після перенесеного інфаркту міокарда розвинулася серцева недостатність. Невідповідність між навантаженням на серце та його здатністю виконувати роботу пов’язана в цьому разі з:', 'medium', 207, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаженням серця', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищеним опором вигнанню крові в легеневому стовбурі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодженням міокарда', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Змішаною формою серцевої недостатності', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищеним опором вигнанню крові в аорті', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дитина 3 років померла від гострої пневмонії на тлі хронічної серцевої недостатності. Під час аутопсії виявлено: дефект міжшлуночкової перегородки, стеноз гирла легеневої артерії, гіпертрофія правого шлуночка серця, декстрапозиція аорти. Яка вада серця у дитини була встановлена під час аутопсії?', 'medium', 208, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тетрада Фалло', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пентада Фалло', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Марфана', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Патау', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 48 років помер при явищах серцевої недостатності. Під час макроскопічного дослідження серця встановлено, що стулки мітрального клапану ущільнені, потовщені та помірно деформовані. Мікроскопічно виявлено пучки колагенових фібрил гомогенізовані, еозинофільні, оточені незначним макрофагальним інфільтратом, метахромазія не виявляється. У разі забарвлення пікрофуксином виявляються вогнища жовтого кольору. Діагностуйте вид ураження сполучної тканини:', 'medium', 209, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїдне набухання', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліноз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Склероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мукоїдне набухання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий з хронічною серцево- судинною недостатністю приймав дигоксин. Після призначення додаткової терапії розвинулися явища інтоксикації серцевими глікозидами. Який препарат може викликати підсилення інтоксикації серцевими глікозидами?', 'medium', 210, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розчин глюкози', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Магнію хлорид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцію хлорид', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аспаркам', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 55 років, який протягом багатьох років страждав на недостатність мітрального клапану, виникла гостра серцева недостатність. Який патофізіологічний варіант недостатності серця спостерігається у цьому разі?', 'medium', 211, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця тиском', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Коронарогенне ушкодження серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця об’ємом', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра тампонада серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоксичне ушкодження серця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 56 років із серцевою недостатністю спостерігається набряк стоп та гомілок, шкіра в місці набряку бліда і холодна. Яка провідна ланка патогенезу набряку у хворого?', 'medium', 212, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення лімфовідтоку', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності капілярів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в венулах', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Позитивний водний баланс', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску в капілярах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік з гострим міокардитом помер від серцево-судинної недостатності. В ході мікроскопічного дослідження внутрішніх органів виявлені: плазморагія, набряк, стази в капілярах, численні крововиливи, а також дистрофічні зміни в паренхімі. Наслідком чого є дані зміни?', 'medium', 213, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Місцеве артеріальне повнокрів’я', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний загальний венозний застій', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий загальний венозний застій', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДВЗ -синдром', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальне артеріальне повнокрів’я', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 70-ти років, який страждав на цукровий діабет та переніс інфаркт міокарда, помер при явищах прогресуючої серцево-судинної недостатності. На розтині ціанотична індурація селезінки та нирок, бура індурація легень та мускатна печінка. Який вид порушення кровообігу обумовив зміни внутрішніх органів?', 'medium', 214, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальна артеріальна гіперемія після анемії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Місцева хронічна венозна гіперемія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна ішемія в результаті перерозподілу крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальна хронічна венозна гіперемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальна гостра венозна гіперемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік з гострим міокардитом помер від серцево-судинної недостатності. В ході мікроскопічного дослідження внутрішніх органів виявлені: плазморагія, набряк, стази в капілярах, численні крововиливи, а також дистрофічні зміни в паренхімі. Наслідком чого є дані зміни?', 'medium', 215, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний загальний венозний застій', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальне артеріальне повнокрів’я', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДВ3-синдром', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Місцеве артеріальне повнокрів’я', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий загальний венозний застій', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з серцевою недостатністю виникла аритмія у вигляді генерації позачергових імпульсів в пучку Гіса. Порушення якої функції серцевого м’язу спостерігається в даному випадку?', 'medium', 216, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Провідність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість та провідність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматизм', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливість', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дитини, що померла від дифтерії з явищами серцевої недостатності, на розтині виявлено, що порожнини серця розширені в поперечнику; м’яз серця тьмяний, в’ялий, на розрізі строкатий, з жовтуватими ділянками. У цитоплазмі деяких кардіоміоцитів зі збереженою цитоплазмою спостерігаються дрібні вакуолі. На заморожених зрізах вакуолі забарвлюються у оранжевий колір суданом III. Який вид дистрофії виявлений у кардіоміоцитах?', 'medium', 217, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліново-крапельна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Балонна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідропічна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Через три тижні після пересадки серця у пацієнта різко погіршився стан. Смерть настала від гострої серцевої недостатності. Гістологічно в міокарді виявлено васкуліт, некрози та лімфоцитарну інфільтрацію. Назвіть причину таких змін:', 'medium', 218, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре відторгнення трансплантату', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне відторгнення трансплантату', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Найгостріше відторгнення трансплантату', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротизуючий васкуліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на есенціальну артеріальну гіпертензію розвинувся гіпертонічний криз, що призвело до нападу серцевої астми. Який механізм серцевої недостатності є провідним вданому випадку?', 'medium', 219, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсолютна коронарна недостатність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним об’ємом крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення надходження крові до серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця підвищеним опором', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині тіла померлого чоловіка 73-х років, який довго страждав на ішемічну хворобу серця з серцевою недостатністю, знайдено: ’’мускатна” печінка, бура індурація легень, ціанотична індурація нирок та селезінки. Який з видів порушення кровообігу найбільш імовірний?', 'medium', 220, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна гіперемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре малокрів’я', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне загальне венозне повнокрів’я', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне малокрів’я', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре загальне венозне повнокрів’я', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У спортсмена легкоатлета (бігуна на довгі дистанції) під час змагань розвинулась гостра серцева недостатність. В результаті чого виникла ця патологія?', 'medium', 221, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення вінцевого кровообігу', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця опором', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Патологія перикарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця об’ємом', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямого пошкодження міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хворого, що помер від серцевої недостатності, в інтимі аорти і коронарних судин виявлені жовтого кольору плями і смуги, що вибухають над поверхнею інтими сірувато-жовтуваті бляшки, а також вогнищеве виразкування даних бляшок з наявністю крововиливів, тромбозів і вогнищ звапнування. Для якого захворювання характерні вказані зміни судин?', 'medium', 222, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезаортит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічна хвороба', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 63-х років, що багато років страждав на атеросклероз і переніс раніше інфаркт міокарда, розвинувся напад загрудинного болю. Хворий госпіталізований, через 3 дні, на фоні прогресуючої серцево-судинної недостатності, помер. Під час розтину тіла у ділянці задньої стінки лівого шлуночка і міжшлуночкової перегородки виявлена ділянка білого кольору близько 3 см у діаметрі, волокниста, западаюча, з чіткою межею. Прозектор трактував ці зміни як:', 'medium', 223, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистрофія міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вогнищевий кардіосклероз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час тривалого бігу у чоловіка 35-ти років виникла гостра серцева недостатність. Які зміни іонного складу спостерігаються у серцевому м’язі при цьому стані?', 'medium', 224, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Накопичення в клітинах міокарда іонів Na+ і Ca2+', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення в позаклітинному просторі іонів K + і Mg2+', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення в позаклітинному просторі іонів Na+ і Ca2+', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Накопичення в клітинах міокарда іонів K + і Mg2+', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення в клітинах міокарда іонів Na+ і Ca2+', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження легень хворого, що помер від серцевої недостатності, виявлені вогнища запалення з заповненням альвеол рідиною, забарвленою у блідорожевий колір, місцями з наявністю тонких рожевих ниток, що утворюють дрібнопетлисту сітку з невеликою кількістю лімфоцитів. Який характер ексудату у легенях?', 'medium', 225, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозно-фібринозний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринозний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на ессенціальну артеріальну гіпертензію розвинувся гіпертонічний криз, що призвело до нападу серцевої астми. Який механізм серцевої недостатності є провідним в даному випадку?', 'medium', 226, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця підвищеним опором', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсолютна коронарна недостатність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення надходження крові до серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним об’ємом крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, що страждає на серцеву недостатність, спостерігаються збільшення печінки, набряки нижніх кінцівок, асцит. Який механізм є провідним в утворенні даного набряку?', 'medium', 227, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфогенний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мембраногенний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колоїдно-осмотичний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідродинамічний', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У померлого від хронічної серцево-судинної недостатності на розтині виявлене ''тигрове серце''. З боку ендокарду помітна жовтувато-біла посмугованість; міокард тьмяний, глинисто-жовтий. Який процес зумовив дану патологію?', 'medium', 228, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводна дистрофія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліново-краплинна дистрофія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова судинно-стромальна дистрофія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова паренхіматозна дистрофія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 58-ми років з гострою серцевою недостатністю спостерігається зменшення добової кількості сечі - олігурія. Який механізм цього явища?', 'medium', 229, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження проникності ниркового фільтру', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження кількості функціонуючих клубочків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження клубочкової фільтрації', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску крові в капілярах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з широким інфарктом міокарда розвинулася серцева недостатність. Який патогенетичний механізм її розвитку?', 'medium', 230, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця об’ємом', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра тампонада серця', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реперфузійне ураження міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення маси функціонуючих кардіоміоцитів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця тиском', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий госпіталізований з гострою серцево - судинної недостатністю. Який препарат необхідно використовувати в даному випадку?', 'medium', 231, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Строфантин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигітоксин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин в таблетках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 30 років діагностовано ішемічна хвороба серця. Напади стенокардії турбують вже 3 роки. Виявлено спадковий характер захворювання. Який вид гіперліпопротеїдемії найбільш ймовірно буде виявлено у хворого?', 'medium', 232, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'V (гіперпребеталіпопротеїдемія і гіперхіломікронемія).', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'I (гіперхіломікронемія)', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'III (дисбеталіпопротеідемія)', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'IV (гіперпребеталіпопротеїдемія)', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'II (гіпербеталіпопротеїдемія)', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік хворіє на ішемічну хворобу серця. Унаслідок цього порушується енергетичне забезпечення серцевого м''яза. Який процес є основним джерелом енергії для міокарда?', 'medium', 233, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окиснення жирних кислот', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гліколіз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюконеогенез', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеоліз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глікогеноліз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для профілактики атеросклерозу, ішемічної хвороби серця та порушень мозкового кровообігу людина повинна одержувати 2-6 г незамінних поліненасичених жирних кислот на добу. Ці кислоти необхідні для синтезу:', 'medium', 234, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовчних кислот', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стероїдів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамінів групи D', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагладинів', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?', 'medium', 235, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Високої щільності', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжної щільності', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хіломікронів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Низької щільності', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для профілактики атеросклерозу, ішемічної хвороби серця, порушень мозкового кровообігу рекомендується споживання жирів із високим вмістом поліненасичених жирних кислот. Однією з таких жирних кислот є:', 'medium', 236, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лінолева', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пальмітоолеїнова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеаринова', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Олеїнова', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лауринова', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 45 років після значного психоемоційного навантаження несподівано з''явився стискаючий біль в області серця з іррадіацією в ліву руку, шию, під ліву лопатку. Особа стала бліда, покрилася холодним потім. Нітрогліцерин зняв напад болю. Який процес розвинувся у хворого?', 'medium', 237, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стенокардія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсульт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Психогенний шок', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перфорація виразки шлунка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 49-ти років, водій за професією, скаржиться на нестерпний стискаючий біль за грудниною, що "віддає" у ділянку шиї. Біль виник 2 години тому. Об’єктивно: стан важкий, блідість, тони серця послаблені. Лабораторне обстеження показало високу активність креатинкінази та ЛДГ1 . Для якого захворювання характерні такі симптоми?', 'medium', 238, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий інфаркт міокарда', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цукровий діабет', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стенокардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовчнокам’яна хвороба', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий панкреатит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 42 років надійшов до кардіологічного відділення з діагнозом стенокардія. До комплексу препаратів, призначених хворому, включений інгібітор ферменту фосфодіестерази. Концентрація якої речовини в серцевому м''язі буде збільшуватись?', 'medium', 239, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АДФ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ГМФ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АТФ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АМФ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цикло-АМФ', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого стенокардія. Який антиангінальний засіб протипоказаний для лікування, якщо в пацієнта алергія на йод?', 'medium', 240, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітросорбід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дротаверин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку віком б5 років зі встановленим діагнозом: стабільна стенокардія напруги — додатково до терапії В-блокаторами був призначений ізосорбіду мононітрат, після чого напади стенокардії значно порідшали. Однак через З тижні прийому кількість нападів знову відновилася. Укажіть причину такої зміни реакції на препарат:', 'medium', 241, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Толерантність', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фармакологічна несумісність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фізична залежність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У результаті інфаркту міокарда відбулося пошкодження ділянки серцевого мʼяза, яке супроводжується масовою загибеллю кардіоміоцитів. Які клітинні елементи забезпечать заміщення утвореного дефекту в структурі міокарда?', 'medium', 242, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міосателітоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епітеліоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Непосмуговані міоцити', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібробласти', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гепатиту та інфаркту міокарда в плазмі крові пацієнтів різко зростає активність аланін- і аспартатамінотрансфераз. Які причини зростання активності цих ферментін у крові?', 'medium', 243, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нестача піридоксину', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зростання швидкості синтезу амінокислот у тканинах', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення активності ферментів гормонами', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкоджения мембран клітин і вихід ферментів у кров', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення швидкості розпаду амінокислот у тканинах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка віком 65 років госпіталізована до кардіологічного відділення клініки з діагнозом: синдром Дресслера. З анамнезу відомо, що у пацієнтки був інфаркт міокарда. Які додатокві клініко-лабораторні показники будуть підтвердження дігнозу: синдром Дреслера?', 'medium', 244, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення ШОЕ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення активності аспартатамінотрансферази в крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гарячка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення рівня автоантитіл крові', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоцитоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із гострим трансмуральним інфарктом міокарда лівого шлуночка помер від розриву серця і тампонади. Який процес у зоні інфаркту міг бути причиною розриву?', 'medium', 245, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Формування рубця із стоншенням стінки лівого шлуночка серця', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тиску в малому колі кровообігу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аутолітичні процеси з розплавленням тканини міокарда (міомаляція)', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стоншення рубцево зміненої стінки шлунка з формуванням аневризми', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Заміщення сполучною тканиною зі зниженням еластичності міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта на другу добу після розвитку трансмурального інфаркту міокарда відбулося різке падіння систолічного АТ до 60 мм рт.ст. з тахікардією 140/хв, задишкою і втратою свідомості. Який механізм є провідним у патогенезі шоку, що розвинувся?', 'medium', 246, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пароксизмальна тахікардія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ударного об''єму серця', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження об''єму циркулюючої крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтоксикація продуктами некротичного розпаду', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактична реакція на міокардіальні білки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку після інфаркту міокарда призначено ацетилсаліцилову кислоту, 75 мг щоденно. З якою метою призначено препарат?', 'medium', 247, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення агрегації тромбоцитів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення запалення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження температури', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширення коронарних судин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення болю', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: гострий інфаркт міокарда — в комплексній терапії призначено гепарин. За деякий час після введення лікарського засобу у пацієнта з’явилася гематурія. Який антагоніст гепарину треба ввести пацієнту для усунення цього ускладнення?', 'medium', 248, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амінокапронову кислоту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вікасол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноген', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протаміну сульфат', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неодикумарин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт на ранніх етапах гострого інфаркту міокарда для відновлення кровопостачання ішемізованих тканин потребує тромболітичної терапії з використанням рекомбінантного активатора ппазміногену тканинного типу. Який із нижченаведених препаратів потрібно ввести пацієнту?', 'medium', 249, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетилсаліцилова кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Варфарин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепарин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стрептокіназа', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альтеплаза', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнта віком 52 роки шпиталізовано до відділення невідкладної допомоги з діагнозом інфаркт міокарда. Які ізоформи лактатдегідрогенази (ЛДГ) будуть переважати в сироватці крові пацієнта протягом перших двох днів після госпіталізації ?', 'medium', 250, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛДГ-1', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛДГ-4', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛДГ-2', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛДГ-5', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛДГ-3', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого через 12 годин після гострого нападу загрудинного болю визначено різке підвищення активності АсАТ в сироватці крові. Яка з перерахованих патологій буде найбільш імовірною?', 'medium', 251, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колагенози', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нецукровий діабет', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цукровий діабет', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вірусний гепатит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При дослідженні крові хворого виявлено значне збільшення активності МВ - форм КФК (креатинфосфокінази) та ЛДГ-1. Яка найбільш ймовірна патологія?', 'medium', 252, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холецистит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ревматизм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панкреатит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гепатит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження серця померлого від гострої серцевої недостатності у міокарді лівого шлуночка виявлена ділянка омертвіння, відмежована від неушкодженої тканини зоною повнокровних судин, дрібних крововиливів та лейкоцитарною інфільтрацією. Який діагноз найбільш імовірний?', 'medium', 253, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Осередковий ексудативний міокардит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемічна дистрофія міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний ексудативний міокардит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Продуктивний міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину трупа чоловіка 60-ти років у міокарді передньої стінки лівого шлуночка виявлене сіре неправильної форми щільне вогнище 5х4 см з чіткими межами, волокнистої структури. Який діагноз найбільш вірогідний?', 'medium', 254, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміопатія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Післяінфарктний міокардіосклероз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний дрібновогнищевий міокардіосклероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 49-ти років, водій за професією, скаржиться на нестерпний стискаючий біль за грудниною, що "віддає" у ділянку шиї. Біль виник 2 години тому. Об’єктивно: стан важкий, блідість, тони серця послаблені. Лабораторне обстеження показало високу активність креатинкінази та ЛДГ1 . Для якого захворювання характерні такі симптоми?', 'medium', 255, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий інфаркт міокарда', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цукровий діабет', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стенокардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовчнокам’яна хвороба', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий панкреатит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині в серці виявлено наступні зміни: великий осередок некрозу білого кольору з червоною облямівкою, який захоплює всю товщу серцевого м’яза. На зовнішній оболонці серця - ознаки фібринозного перикардиту. Який найбільш імовірний діагноз?', 'medium', 256, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субепікардіальний інфаркт міокарда', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансмуральний інфаркт міокарда', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Субендокардіальний інфаркт міокарда', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтрамуральний інфаркт міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка, який помер від набряку легень, у міокарді було виявлено велике вогнище жовто-сірого кольору, а в коронарній артерії свіжий тромб. Для якого захворювання характерні такі симптоматичні явища?', 'medium', 257, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт міокарда', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміопатія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіосклероз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла чоловіка віком 62 роки, який хворів на атеросклероз і помер від гострої серцевої недостатності, у передній стінці лівого шлуночка серця виявлено ділянку біло-жовтого кольору, розміром 6х5 см, неправильної форми, яка чітко відмежована від навколишніх тканин геморагічним вінчиком. Якому захворюванню відповідають такі патологічні зміни?', 'medium', 258, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіоміопатії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міокардиту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркту міокарда', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Постінфарктному кардіосклерозу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дрібно-осередкованому кардіосклерозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла чоловіка віком 70 років у передній стінці лівого шлуночка визначається ділянка із тьмяною поверх нею білуватого кольору яка поширюється на всю товщу міокарда та оточена перифокальним геморагічним вінчиком. Під мікроскопом уражена ділянка відмежована від міокарда, що зберігся, зоною повнокрів’я і лейкоцитарною інфільтрацією (демаркаційне запалення), представлена некротизованою тканиною з наявністю периваскулярних «острівців» збережених кардіоміоцитів. Якому діагнозу відповідає така морфологічна картина?', 'medium', 259, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтрамуральний інфаркт міокарда', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вогнищевий міокардит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіосклероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міомаляція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансмуральний інфаркт міокарда', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 44 роки з інфарктом міокарда помер від лівошлуночкової недостатності. Під час аутопсії виявлено: набряк легень, дрібнокраплинні крововиливи у серозних та слизових оболонках. Мікроскопічно спостерігається: дистрофічні та некробіотичні зміни епітелію проксимальних канальців нирок, у печінці - центролобулярні крововиливи та осередки некрозу. На який вид порушення кровообігу вказують такі патологічні зміни?', 'medium', 260, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне малокрівʼя', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічне загальне венозне повнокрівʼя', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре малокрівʼя', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна гіперемія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре загальне венозне повнокрівʼя', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: гіпертонічна хвороба, помер від гострого інфаркту міокарда. Під час аутопсії у правій гемісфері головного мозку виявлено порожнину розміром 2 см у діаметрі, яка заповнена прозорою жовтуватою рідиною. Стінка порожнини гладка, іржаво-жовта. Яку патологію виявлено в головному мозку померлого?', 'medium', 261, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсцес', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ехінокок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кісту', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкулому', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіка віком 59 років шпиталізували у тяжкому стані з діагнозом: гострий інфаркт міокарда в ділянці задньої стінки лівого шлуночка та перегородки, початковий набряк легень. Який механізм є первинним у виникненні набряку легень у пацієнта?', 'medium', 262, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легенева венозна гіпертензія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легенева артеріальна гіпертензія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження альвеоло-капілярної дифузії кисню', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоксемія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лівошлуночкова недостатність', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після перевʼязки однієї з гілок вінцевих артерій у собаки розвинувся інфаркт міокарда, який супроводжувався проявами резорбційно-некротичного синдрому. Укажіть найхарактернішу ознаку розвитку цього синдрому.', 'medium', 263, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Біль за грудниною', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження хвилинного обʼєму крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення у крові креатинкінази', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення у крові катехоламінів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриляція шлуночків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Активність якого ферменту підвищується в крові пацієнта під час інфаркту міокарда?', 'medium', 264, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Карбамоілфосфатсинтетази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лужної фосфатази', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинфосфокінази ММ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинфосфокінази МВ', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинфосфокінази ВВ', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження міокарда було виявлено велику ділянку міокардіоцитів, у яких відсутні ядра. Цитоплазма клітин гомогенна, рожевого кольору. На периферії вогнища визначаються розширені, різко повнокровні судини і виражена інфільтрація сегментоядерними лейкоцитами. Про який процес свідчить ця гістологічна картина?', 'medium', 265, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інкапсуляцію інфаркту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Асептичний автоліз інфаркту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Організацію інфаркту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Демаркаційне запалення навколо інфаркту', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септичний розпад інфаркту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловікові 54 років діагностовано великовогнищевий інфаркт міокарда передньої стінки лівого шлуночка. В якій артерії порушений кровообіг? (Коректна відповідь - У передній міжшлуночковій гілці ЛІВОЇ вінцевої артерії)', 'medium', 266, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У правій вінцевій артерії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У задній міжшлуночковій гілці правої вінцевої артерії', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В огинальній гілці лівої вінцевої артерії', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У лівій вінцевій артерії', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У передній міжшлуночковій гілці правої вінцевої артерії (закодовано на ЦТ)', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку, після інфаркту міокарда, призначено ацетилсаліцилову кислоту, 75 мг щоденно. З якою метою призначено препарат?', 'medium', 267, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення запалення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення болю', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширення коронарних судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення агрегації тромбоцитів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження температури', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?', 'medium', 268, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Концентрації фібриногену', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активованого часткового тромбопластинового часу (коректна відповідь)', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжнародного нормалізованого відношення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ШОЕ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протромбінового часу', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Тромбоз коронарної артерії спричинив розвиток інфаркту міокарда. Які механізми ушкодження клітин є домінуючими під час цього захворювання?', 'medium', 269, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Електролітно-осмотичні', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцієві', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпідні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацидотичні', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До кардіологічного відділення госпіталізовано чоловіка з інфарктом міокарда в гострій фазі. Який фермент застосовують для лізису тромбів у коронарних судинах у перші години?', 'medium', 270, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трипсин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізоцим', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хімотрипсин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лідазу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стрептокіназу', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка на тлі інфаркту міокарда виникла пароксизмальна шлуночкова тахікардія. Який із нижченаведених протиаритмічних засобів треба обрати, щоб не зменшити серцевий викид?', 'medium', 271, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новокаїнамід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лідокаїну гідрохлорид', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: гострий інфаркт міокарда, у комплексній терапії призначено гепарин. За деякий час після введення лікарського засобу у пацієнта з''явилася гематурія. Який антагоніст гепарину треба ввести пацієнту для усунення цього ускладнення?', 'medium', 272, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неодикумарин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протаміну сульфат', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вікасол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноген', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амінокапронову кислоту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До відділення реанімації госпіталізовано пацієнта із діагнозом: інфаркт міокарда. Який лікарський засіб треба ввести пацієнту для купірування больового синдрому?', 'medium', 273, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анальгін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Промедол', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парацетамол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Налоксон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Целекоксиб', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла померлого чоловіка віком 43 роки було виявлено набряк легень. З анамнезу відомо, що пацієнт хворів на ІХС із розвитком інфаркту міокарда. Яка ймовірна причина набряку легень?', 'medium', 274, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостре загальне малокрів''я', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стаз крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія малого кола', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра правошлуночкова недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра лівошлуночкова недостатність', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після інфаркту міокарда передсердя і шлуночки стали скорочуватись незалежно одне від одного: з частотою 60-70 та 35-40 за хвилину. Назвіть вид блокади в даному випадку:', 'medium', 275, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сино-атріальна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньопередсердна', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Повна передсердно-шлуночкова', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неповна передсердно-шлуночкова', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішньошлуночкова', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для усунення больового синдрому пацієнту з інфарктом міокарда лікар призначив анальгетичний препарат. Стан хворого поліпшився, але з часом з’явилися ейфорія, міоз. Лікар виявив пригнічення дихання. Який лікарський засіб був призначений?', 'medium', 276, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Баралгін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парацетамол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мелоксикам', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ібупрофен', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Морфіну гідрохлорид', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому поставили попередній діагноз інфаркт міокарда. Характерною ознакою цього захворювання є суттєве підвищення в крові активності:', 'medium', 277, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинфосфокінази', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аргінази', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Г-6-ФДГ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каталази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альфа-амілази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У реанімаційне відділення надійшов хворий з гострим інфарктом міокарда, якому для зменшення болю ввели морфіну гідрохлорид. Механізм дії морфіну гідрохлориду обумовлений:', 'medium', 278, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляцією опіатних рецепторів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокадою гістамінових рецепторів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокадою фосфодіестерази', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокадою холінестерази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляцією аденілатциклази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 38-ми років раптово помер. На розтині: у задній стінці лівого шлуночка серця виявлено інфаркт міокарда. Які найбільш імовірні зміни у будові міокардіоцитів можна побачити у вогнищі інфаркту мікроскопічно?', 'medium', 279, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вуглеводна дистрофія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каріолізис', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирова дистрофія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білкова дистрофія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звапнування', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий переніс повторний інтрамуральний інфаркт міокарда. Після лікування та реабілітації виписаний у задовільному стані під нагляд дільничного терапевта. Через 2 роки загинув у автомобільній катастрофі. Який характер патологічного процесу в міокарді було встановлено на розтині?', 'medium', 280, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крупновогнищевий кардіосклероз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дрібновогнищевий кардіосклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атрофія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперплазія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У відділення реанімації був доставлений хворий з інфарктом міокарда. Який препарат необхідно ввести хворому для лікування больового шоку?', 'medium', 281, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Налоксон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анальгін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Целекоксиб', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Промедол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парацетамол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворого на трансмуральний інфаркт міокарда лівого шлуночка переведено до відділення реанімації у важкому стані. АТ-70/50 мм рт.ст., ЧСС- 56/хв., ЧД- 32/хв. Зазначте головну ланку в патогенезі кардіогенного шоку:', 'medium', 282, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крововтрата', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Втрата води', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Падіння периферичного судинного опору', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Падіння серцевого викиду', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Втрата електролітів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінці 54-х років поставили попередній діагноз: інфаркт міокарда. Характерною ознакою даного захворювання є суттєве підвищення в крові активності такого ферменту:', 'medium', 283, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Г-6-ФДГ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинфосфокіназа', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каталаза', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аргіназа', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альфа-амілаза', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, який скаржився на біль у ділянці лівої лопатки, був діагностований інфаркт міокарду. Назвіть вид болю у хворого?', 'medium', 284, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перший (протопатичний)', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фантомний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вісцеральний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Другий (епікритичний)', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іррадіюючий (відбитий)', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До кардіологічного відділення доставлений хворий з діагнозом: гострий інфаркт міокарда. Для усунення больового синдрому (нейролептанальгезії) пацієнту необхідно ввести таку комбінацію лікарських препаратів:', 'medium', 285, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміназин + діазепам', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анальгін + піпольфен', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Морфін + атропін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ношпа + димедрол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дроперидол + фентаніл', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До кардіологічного відділення надійшов хворий з інфарктом міокарда. Для усунення болю було вирішено потенціювати дію фентаніла нейролептиком. Який з перерахованих нейролептиків найбільш придатний для проведення нейролептаналгезії?', 'medium', 286, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трифтазін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сульпірид', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дроперидол', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Галоперидол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміназин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У клініці для лікування інфаркту міокарда пацієнту введено ембріональні стовбурові клітини, що одержано шляхом терапевтичного клонування в цього ж пацієнта. Як називається цей вид трансплантації?', 'medium', 287, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гетеротрансплантація', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ксенотрансплантація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алотрансплантація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізотрансплантація', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аутотрансплантація', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину трупа жінки 69 років підвищеного живлення, яка померла від гострого інфаркту міокарда, в інтимі коронарних артерій знайдені численні білуваті, щільні, вибухаючі формування, що різко звужують просвіт судин. Для якої стадії атеросклерозу властиві такі зміни?', 'medium', 288, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атерокальциноз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атероматоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стадія утворення атероматозної виразки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпосклероз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого інфаркт міокарда в ділянці передньої стінки лівого шлуночка. В басейні якої артерії виникло порушення кровообігу?', 'medium', 289, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передня міжшлуночкова гілка лівої вінцевої артерії', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліва крайова гілки лівої вінцевої артерії', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передні шлуночкові гілки правої вінце- вої артерії', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердно-шлуночкова гілка лівої вінцевої артерії', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Огинаюча гілка лівої вінцевої артерії', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з гострим інфарктом міокарда внутрішньовенно крапельно введено 1500 мл різних розчинів протягом 8 годин, кисень інтраназально. Смерть настала від набряку легень. Що спричинило набряк легень?', 'medium', 290, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгаляція кисню', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергічна реакція', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейрогенна реакція', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження лівого шлуночка об''ємом', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску за рахунок гемодилюції', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Трансмуральний інфаркт міокарда у хворого ускладнився розвитком гострої лівошлуночкової недостатності. Що є найбільш типовим для цього стану?', 'medium', 291, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Набряк кінцівок', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна гіпертензія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Набряк легенів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ціаноз', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий помер від інфаркту міокарда. При патогістологічному дослідженні міокарда виявлені значні контрактурні зміни в кардіоміоцитах. Це обумовлено нагромадженням в кардіоміоцитах іонів:', 'medium', 292, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Водню', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлора', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Магнію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцію', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка страждає на тяжку форму бронхіальної астми. За призначенням лікаря тривалий час отримує гормональну терапію. До яких ускладнень може призвести тривала терапія глюкортикоїдами?', 'medium', 293, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У пацієнта віком 65 років, який понад 20 років хворіє на артеріальну гіпертензію, спостерігається пароксизмальна нічна задишка та положення ортопное. Під час обстеження виявлено двосторонні хрипи в легенях і набряки на обох ногах. Який із нижченаведених патогенетичних механізмів порушень діяльності серцево-судинної системи є первинним у цього пацієнта?', 'medium', 294, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищений системний судинний опір', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення наповнення шлуночків', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення післянавантаження лівого шлуночка', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження скоротливості міокарда', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення хвилинного об’єму серця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Артеріальна гіпертензія в жінки віком 44 роки зумовлена наявністю феохромоцитоми — пухлини мозкового шару наднирників. Антигіпертензивні засоби якої групи найдоцільніше буде при- значити?', 'medium', 295, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В-адреноблокатори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліоблокатори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатолітики', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'А-адреноблокатори', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоністи кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці віком 62 років з діагнозом: артеріальна гіпертензія, призначили інгібітор ангіотензинперетворюючого ферменту. Утворення якої біологічно активної речовини зменшиться у цьому разі?', 'medium', 296, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензину |', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензиногену', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реніну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналіну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензину ІІ', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту собаці змоделювали артеріальну гіпертензію шляхом звуження ниркових артерій. При цьому збільшилась активність ренін-ангіотензин-альдостеронової системи. Який компонент цієї системи викликає найсильніший пресорний ефект?', 'medium', 297, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин І', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин ІІ', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Який основний механізм розвитку артеріальної гіпертензії у пацієнтів із гломерулонефритом?', 'medium', 298, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперсекреція реніну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперсекреція альдостерону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія ниркових клубочків', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення нейрогенного компоненту судинного тонусу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення продукції АДГ', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки віком 45 років, якій діагностовано пієлонефрит, лікар виявив стійку артеріальну гіпертензію Який механізм виникнення цього стану?', 'medium', 299, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація ренін-ангіотензинової системи', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація процесів ацидогенезу та амоніогенезу в нирках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активізація синтезу ангіотензинази в тканинах нирки', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження парціального тиску кисню в тканинах нирки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація центральних холінергічних механізмів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після тривалого психоемоційного напруження спостерігається підвищення артеріального тиску, що супроводжується серцебиттям, кардіалгіями, головним болем, запамороченням. Домінуючим у формуванні артеріальної гіпертензії у даному випадку є збільшення:', 'medium', 300, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серцевого викиду', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тонусу венул', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тонусу артеріол', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Частоти серцевих скорочень', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Об’єму циркулюючої крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 72-х років довготривала хронічна патологія легень призвела до недостатності клапанів легеневої артерії і трикуспідального клапану, недостатності кровообігу за правошлуночковим типом. Який тип артеріальної гіпертензії є причиною перевантаження серця об’ємом?', 'medium', 301, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефлексогенна гіпертензія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Легенева гіпертензія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Центрально-ішемічна гіпертензія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сольова гіпертензія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Есенціальна гіпертензія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Обстеження пацієнта з високим артеріальним тиском показало в нього вторинну артеріальну гіпертензію. Причиною такого стану є ренін-продукуюча пухлина нирки. Що є головною ланкою в патогенезі вторинної артеріальної гіпертензії в хворого?', 'medium', 302, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатня продукція вазопресину', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція кортизолу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція інсуліну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатня продукція катехоламінів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція ангіотензину 2, альдостерону', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 65-ти років впродовж 15-ти років була виражена артеріальна гіпертензія. Останнім часом систолічний тиск почав знижуватися, а діастолічний залишився підвищеним. Який гемодинамічний тип артеріальної гіпертензії у хворого?', 'medium', 303, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкінетичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокінетичний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нормокінетичний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еукінетичний', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 48-ми років, на тлі хронічного гломерулонефриту, розвинулася стійка артеріальна гіпертензія. Вкажіть групу найбільш ефективних лікарських засобів для лікування цього пацієнта:', 'medium', 304, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоністи кальцію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітори ангіотензинперетворюючого ферменту', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'а-адреноблокатори', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міотропні спазмолітики', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліоблокатори', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 48-ми років на хронічний гломерулонефрит наявні набряки, АТ-210/100 мм рт.ст., ЧСС- 85/хв., межі серця розширені. Який механізм розвитку артеріальної гіпертензії є головним?', 'medium', 305, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення продукції вазопресину', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення ОЦК', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення активності симпатичного відділу нервової системи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперфункція серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація ренин-ангіотензин-альдостеронової системи', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на ессенціальну артеріальну гіпертензію розвинувся гіпертонічний криз, що призвело до нападу серцевої астми. Який механізм серцевої недостатності є провідним в даному випадку?', 'medium', 306, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця підвищеним опором', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження міокарда', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Абсолютна коронарна недостатність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення надходження крові до серця', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перевантаження серця збільшеним об’ємом крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Артеріальна гіпертензія у хворого обумовлена стенозом ниркових артерій. Активація якої системи є головною ланкою в патогенезі цієї форми гіпертензії?', 'medium', 307, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калікреїн-кінінова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатоадреналова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатична', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоталамо-гіпофізарна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін-ангіотензинова', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При відтворенні артеріальної гіпертензії у собаки через 1 місяць товщина стінки лівого шлуночка зросла в 1,7 рази, а об’єм циркулюючої крові не змінився порівняно з вихідними даними. Яка стадія гіпертрофії міокарда спостерігається у тварини?', 'medium', 308, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Початкова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Декомпенсації', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аварійна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогресуючого кардіосклерозу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Закінчена гіпертрофія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Обстеження пацієнта з високим артеріальним тиском виявило у нього вторинну артеріальну гіпертензію. З’ясовано, що причиною такого стану пацієнта є гормонально активна пухлина кори наднирників. Гіперпродукція якого гормону є причиною вторинної артеріальної гіпертензії у хворого?', 'medium', 309, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Унаслідок передозування вазодилятатором у пацієнта артеріальний тиск знизився до 60/40 мм рт. ст. та виник колапс. До якої патології це може призвести?', 'medium', 310, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсульту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої печінкової недостатності', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої ниркової недостатності', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої дихальної недостатності', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркту міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розвитку колапсу спостерігаються розлади функцій нервової системи, порушення газообмінної функції легень, розлади системи крові і гемостазу. Первинне виникнення якої гіпоксії зумовлює ці прояви колапсу?', 'medium', 311, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тканинна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дихальна', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемічна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циркуляторна', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоксична', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого діагностовано грип. Після прийому антипіретиків стан його різко погіршився: свідомість потьмарена, АТ- 80/50 мм рт.ст., Ps-140/хв., температура тіла різко знизилась до 35,8*C. Яке ускладнення виникло в даного хворого?', 'medium', 312, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіповолемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертермія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колапс', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацидоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алкалоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого діагностовано септичний ендокардит. Температура тіла протягом 5-ти днів коливалася в межах 39,5oC -40,2oC. На 6-й день на тлі різкого зниження температури до35,2oC розвинувся колапс. Який головний механізм колапсу?', 'medium', 313, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазодилатація', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилене потовиділення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпервентиляція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарні швидкої допомоги госпіталізований чоловік 63-х років з явищами колапсу. Для боротьби з гіпотензією лікар вибрав норадреналін. Який механізм дії цього препарату?', 'medium', 314, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація β-адренорецепторів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація дофамінових рецепторів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація α1 –адренорецепторів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація серотонінових рецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада M-холінорецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарні швидкої допомоги госпіталізований чоловік 63-х років з явищами колапсу. Для боротьби з гіпотензією лікар вибрав норадреналін. Який механізм дії цього препарату?', 'medium', 315, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація β-адренорецепторів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація дофамінових рецепторів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація α-адренорецепторів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада M-холінорецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація серотонінових рецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В експерименті на білого щура подіяли стресовим фактором (електричним струмом) і спостерігали після цього гіпотонію м''язів, артеріальну гіпотензію, гіпотермію, гіпоглікемію. Який період загального адаптаційного синдрому у щура?', 'medium', 316, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза протишоку', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза шоку', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стадія резистентності', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стадія виснаження', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Відповідно до сучасної концепції атерогенезу «Response to injury», атеросклероз є проявом хронічного запалення в інтимі артерій. З якою стадією запалення пов’язано формування фіброзних бляшок при атеросклерозі:', 'medium', 317, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ексудація', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проліферація', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трансформація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинна альтерація', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинна альтерація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хворого, що помер від серцевої недостатності, в інтимі аорти і коронарних судин виявлені жовтого кольору плями і смуги, що вибухають над поверхнею інтими сірувато-жовтуваті бляшки, а також вогнищеве виразкування даних бляшок з наявністю крововиливів, тромбозів і вогнищ звапнування. Для якого захворювання характерні вказані зміни судин?', 'medium', 318, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезаортит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічна хвороба', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У водія, який потрапив у ДТП, отримав травму та знаходиться в стані шоку, спостерігається зменшення добової кількості сечі до 300 мл. Який основний патогенетичний фактор цієї зміни діурезу?', 'medium', 319, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний гіперальдостеронізм', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Падіння артеріального тиску', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення кількості функціонуючих клубочків', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У щурів, що знаходяться у стані стресу, підвищені м’язовий тонус та артеріальний тиск, збільшений вміст глюкози у крові, посилена секреція кортикотропіну і кортикостероїдів. У якій фазі стресу знаходяться ці тварини?', 'medium', 320, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Виснаження', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза шоку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фаза протишоку', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еректильна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Термінальна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження стінки аорти виявлено велику кількість ксантомних клітин, які розташовані переважно в інтимі. Для якого захворювання це характерно?', 'medium', 321, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклерозу', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичного мезаортиту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічної хвороби', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нодозного періартеріїту', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неспецифічного аортоартеріїту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла хворого, що помер від серцевої недостатності, в інтимі аорти і коронарних судин виявлені жовтого кольору плями і смуги, що вибухають над поверхнею інтими сірувато-жовтуваті бляшки, а також вогнищеве виразкування даних бляшок з наявністю крововиливів, тромбозів і вогнищ звапнування. Для якого захворювання характерні вказані зміни судин?', 'medium', 322, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезаортит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічна хвороба', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні стінки аорти виявлено велику кількість ксантомних клітин, розташованих переважно в інтимі. При якому захворюванні можлива така картина?', 'medium', 323, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічна хвороба', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Неспецифічний аортоартеріїт', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезаортит', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?', 'medium', 324, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гастрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Запалення легенів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий панкреатит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження нирок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 36-ти років одразу після перенесеного стафілококового сепсису з’явилися напади стенокардії. За допомогою коронарографії в лівій коронарній артерії було виявлено пристінковий тромбоз без ознак атеросклерозу. Утворення тромбу розпочалося внаслідок пошкодження ендотелію судини і вивільнення:', 'medium', 325, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фактора активації тромбоцитів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпази А2', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденозиндифосфату', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серотоніну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденозинтрифосфату', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, який на тлі атеросклерозу переніс ішемічний інсульт, спостерігається порушення рухової функції у вигляді геміплегії. Яка з перерахованих ознак є характерною для уражених кінцівок при даній патології?', 'medium', 326, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотонус м’язів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпорефлексія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонус м’язів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Трофічні розлади', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта після курсу лікування атеросклерозу в плазмі крові лабораторно доведено збільшення рівня антиатерогенної фракції ліпопротеїнів. Збільшення рівня яких ліпопротеїнів підтверджує ефективність терапії захворювання?', 'medium', 327, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛПНЩ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хіломікрони', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛПДНЩ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛППЩ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ЛПВЩ', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 70 років перебіг атеросклерозу ускладнився тромбозом судин нижніх кінцівок, виникла гангрена пальців лівої стопи. Початок тромбоутворення, найімовірніше, пов’язаний з:', 'medium', 328, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перетворенням фібриногену в фібрин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженням синтезу гепарину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перетворенням протромбіну в тромбін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адгезією тромбоцитів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активацією протромбінази', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для профілактики атеросклерозу, ішемічної хвороби серця та порушень мозкового кровообігу людина повинна одержувати 2-6 г незамінних поліненасичених жирних кислот на добу. Ці кислоти необхідні для синтезу:', 'medium', 329, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовчних кислот', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стероїдів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вітамінів групи D', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагладинів', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?', 'medium', 330, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Високої щільності', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерину', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проміжної щільності', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хіломікронів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Низької щільності', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині трупа чоловіка 47-ми років, померлого раптово, в інтимі черевного відділу аорти знайдені осередки жовтого кольору у вигляді плям та смуг, що не вибухають над поверхнею інтими. При фарбуванні суданом III спостерігається жовтогаряче забарвлення. Для якої стадії атеросклерозу характерні такі зміни?', 'medium', 331, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдозу', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпосклерозу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атерокальцинозу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стадія утворення атероматозної виразки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атероматозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 58-ми років хворіє на атеросклероз судин головного мозку. При обстеженні виявлена гіперліпідемія. Вміст якого класу ліпопротеїдів у сироватці крові даного чоловіка найбільш вірогідно буде підвищений?', 'medium', 332, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпопротеїди низької щільності', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хіломікрони', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Комплекси жирних кислот з альбумінами', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпопротеїди високої щільності', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У процесі онтогенезу у людини на організменному рівні проявилися наступні зміни: зменшилася життєва ємність легень, збільшився артеріальний тиск, розвинувся атеросклероз. Який період онтогенезу найбільш вірогідний у цьому випадку?', 'medium', 333, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підлітковий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Похилий вік', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юнацький', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Молодий вік', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Початок зрілого віку', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 65 років, який страждав на атеросклероз, госпіталізований в хірургічне відділення з приводу розлитого гнійного перитоніту. Під час операції діагностовано тромбоз брижових артерій. Яка найбільш ймовірна причина перитоніту?', 'medium', 334, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стазі', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія компресійна', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія ангіоспастична', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічний інфаркт', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемічний інфаркт', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині померлого, що страждав від атеросклерозу, в головному мозку виявлено тромбоз гілки внутрішньої сонної артерії і сірого кольору вогнище вологого розм''якшення тканин. Який патологічний процес виявлений в головному мозку?', 'medium', 335, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гематома', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Геморагічна інфільтрація', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухлина мозку', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Енцефаліт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемічний інфаркт', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Недостатність в організмі мікроелементу селену проявляється кардіоміопатією. Імовірною причиною такого стану є зниження активності такого селенвмісного ферменту:', 'medium', 336, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сукцинатдегідрогеназа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лактатдегідрогеназа', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутатіонпероксидаза', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каталаза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитохромоксидаза', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла жінки віком 63 роки, що хворіла на ревматизм і комбіновану мітральну ваду, виявлено: стулки мітрального клапана різко потовщені, зрощені між собою, кам''янистої щільності, під час розрізання визначається хрускіт. Який патологічний процес зумовив кам''янисту щільність клапана серця?', 'medium', 337, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистрофічне звапнення', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метастатичне звапнення', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаболічне звапнення', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїд', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині звертає на себе увагу наступне: тіло молодого чоловіка високого зросту, виражена блідість та еластичність шкіри, доліхоцефалічна будова голови, подовження і контрактура пальців верхніх і нижніх кінцівок (нагадують кінцівки павука), незначне вдавлення грудини всередину, помірно виражений сколіоз. При дослідженні органів грудної порожнини виявили розрив аневризми висхідної частини аорти. Яке захворювання, найімовірніше, мало місце в цьому випадку?', 'medium', 338, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Марфана', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклероз аорти', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сифілітичний мезоаортит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром Гудпасчера', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 38-ми років загинув при спробі підйому вантажу. Розвинувся колаптоїдний стан. На аутопсії виявлений розрив обширної аневризми грудного відділу аорти. За життя страждав на вісцеральний сифіліс. Який патологічний процес в даному випадку обумовив зменшення міцності стінки аорти, її розширення й розрив?', 'medium', 339, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнт віком 60 років звернувся до лікарки з підвищеним артеріальним тиском, який складно коригується стандартними антигіпертензивними препаратами. Під час обстеження лікарка помітила, що в пацієнта є високий рівень ендотеліальної дисфункції. Який із нижченаведених пептидів має виражену гіпотензивну дію, впливаючи на гладкі м’язи?', 'medium', 340, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У пацієнта віком 63 роки під час фізичних навантажень виникають напади стенокардії. Препарати якої групи треба призначити для їх профілактики?', 'medium', 341, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулятори дихання', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антигіпертензивні засоби', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кардіотоніки', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антиангінальні засоби', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якому з антигіпертензивних лікарських засобів лікар віддасть перевагу, якщо відомо, що артеріальна гіпертензія асоційована з бронхіальною астмою, цукровим діабетом 2-го типу та дисліпідемією?', 'medium', 342, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Чоловік віком 68 років хворіє на гіпертонічну хворобу та тривалий час приймає антигіпертензивний препарат, який раптово припинив вживати. Після цього стан пацієнта погіршився, розвинувся гіпертензивний криз. Який патологічний стан розвинувся у чоловіка після зупинки прийому препарату?', 'medium', 343, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром відміни', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Залежність', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Толерантність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізація', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Артеріальна гіпертензія в жінки віком 44 роки зумовлена наявністю феохромоцитоми — пухлини мозкового шару наднирників. Антигіпертензивні засоби якої групи найдоцільніше буде при- значити?', 'medium', 344, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'В-адреноблокатори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліоблокатори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатолітики', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'А-адреноблокатори', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоністи кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки віком 44 роки артеріальна гіпертензія обумовлена наявністю феохромоцитоми. Антигіпертензивні засоби якої групи необхідно призначити цій пацієнтці?', 'medium', 345, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'b-адреноблекатори', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоністи кальцію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'а-адреноблокатори', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гангліоблокатори', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатолітики', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки віком 45 років артеріальна гіпертензія з високою концентрацією ангіотензину-2 у крові. Який із нижченаведених антигіпертензивних засобів треба рекомендувати у цьому разі?', 'medium', 346, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки під час лікування гіпертонічної хвороби на тлі прийому антигіпертензивного препарату виник сухий кашель. Для якого лікарського засобу характерна така побічна дія?', 'medium', 347, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Но-шпа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазил', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дротаверин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому з артеріальною гіпертензією було призначено один з антигіпертензивних засобів. Артеріальний тиск нормалізувався, однак хворого почав турбувати постійний сухий кашель. Який з перерахованих препаратів має таку побічну дію?', 'medium', 348, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клофелін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на гіпертонічну хворобу разом з безсольовою дієтою та з антигіпертензивними засобами, довгий час приймав гідрохлортіазид, що зумовило порушення електролітного балансу. Яке порушення внутрішнього середовища виникло у хворого?', 'medium', 349, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення об’єму циркулюючої крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаболічний ацидоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпохлоремічний алкалоз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкаліємія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпермагніємія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 58-ми років впродовж 9-ти років хворіє на цукровий діабет, отримує для корекції гіперглікемії інсулін-семіленте. 10 днів тому почав лікування гіпертонічної хвороби анаприліном. Через годину після прийому антигіпертензивного препарату розвинулась гіпоглікемічна кома. Який механізм виникнення гіпоглікемії за умови прийому анаприліну?', 'medium', 350, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення періоду напіввиведення інсуліну-семіленте', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення глікогенолізу', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення періоду напіввиведення глюкагону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення всмоктування глюкози', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення біодоступності інсуліну-семіленте', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 46-ти років, хворий на гіпертонічну хворобу, разом з безсольовою дієтою та з антигіпертензивними засобами довгий час приймав гідрохлортіазид, що зумовило порушення електролітного балансу. Яке порушення внутрішнього середовища виникло у хворого?', 'medium', 351, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення об’єму циркулюючої крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкаліємія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаболічний ацидоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпохлоремічний алкалоз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпермагніємія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До кардіологічного відділення надійшов хворий з гіпертонічним кризом, йому внутрішньовенно ввели антигіпертензивний засіб - сіль лужноземельного металу. Який препарат ввели хворому?', 'medium', 352, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцію лактат', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію гідрокарбонат', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бензогексоній', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Магнію сульфат', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з гіпертонічною хворобою при систематичному лікуванні антигіпертензивним засобом з''явився кашель. Який з названих засобів може бути причиною даного побічного ефекту?', 'medium', 353, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клофелін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дихлортіазид', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еналаприл', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До сімейного лікаря звернувся пацієнт із скаргою на сильний головний біль. Обʼєктино спостерігається: АТ - 220/110 мм рт. ст., ЧСС - 88 уд./хв. ЧД - 18 уд./ха. Діагностовано неускладнений гіпертензивний криз. Для надання невідкладної допомоги лікар обирає препарат групи блокаторів кальцієних каналів короткої тривалості дії. Який препарат призначив лікар?', 'medium', 354, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каптоприл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Доксазозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Урапідил', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лозартан', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 52 років, хворіє на цукровий діабет, скаржиться на головний біль, стомлюваність, безсоння. Під час огляду встановлено високий рівень артеріального тиску - 200/100 мм рт. ст. Який препарат найбільш доцільно використовувати для швидкого зниження артеріального тиску?', 'medium', 355, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Папаверин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каптоприл', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на гіпертонічну хворобу II стадії з лікувальною метою приймав один з гіпотензивних препаратів. Через деякий час артеріальний тиск знизився, але хворий став скаржитися на в’ялість, сонливість, байдужість. Пізніше з’явився біль у шлунку. Було діагностовано виразкову хворобу. Який гіпотензивний препарат приймав хворий?', 'medium', 356, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дибазол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каптоприл', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: гіпертонічна хвороба - приймає еналаприл. Який механізм дії цього гіпотензивного препарату?', 'medium', 357, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор ангіотензинперетворювального ферменту', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокатор Са++-каналів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор циклооксигенази', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор фосфодіестерази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоніст ангіотензинових рецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта виникли артеріальна гіпертензія, тахіаритмія та стійкі порушення кровообігу серцевого м’яза. Прийом якого засобу доцільно призначити пацієнту з такою патологією?', 'medium', 358, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальбутамол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Медазепам', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нікетамід', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До кардіологічного відділення надійшов хворий на ішемічну хворобу серця. Для профілактики нападів стенокардії призначено лікарський засіб з групи β-адреноблокаторів. Назвіть цей препарат:', 'medium', 359, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атропіну сульфат', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Морфіну гідрохлорид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом артеріальна гіпертензія з явищами стенокардї — призначили препарат із групи антагоністів кальцію. Укажіть цей препарат.', 'medium', 360, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранолол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Молсидомін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пентоксифілін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта під час медичного обстеження виявлено стенокардію. Лікар призначив йому препарат метопролол, який знижує силу і частоту серцевих скорочень і, відповідно, потребу міокарда в кисні. Який механізм його лікуючої дії?', 'medium', 361, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада beta_2-адренорецепторів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада beta_1-адренорецепторів', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада М-холінорецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада Н-холінорецепторів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляція beta_1-адренорецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після видалення зуба з’явився стійкий біль за грудниною. Після сублінгвального вживання антиангінального засобу біль за грудниною зник, але хворий поскаржився на головний біль та запаморочення. Для якого препарату притаманні ці властивості?', 'medium', 362, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Валідол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після видалення зуба з''явився стійкий біль за грудиною. Після вживання під язик антиангінального засобу біль за грудиною зник, але хворий поскаржився на головний біль і запаморочення. Який препарат використав хворий?', 'medium', 363, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Валідол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт, який хворіє на ішемічну хворобу серця, не повідомив лікаря, що у нього трапляються напади бронхоспазму. Лікар призначив препарат, після приймання якого напади стенокардії порідшали, але почастішали напади бронхоспазму. Укажіть, який препарат був призначений.', 'medium', 364, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лозартан калію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гліцерину тринітрат', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутаміну гідрохлорид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранололу гідрохлорид', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аторвастатин кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт довгий час хворіє на бронхіальну астму. Останнім часом у нього зʼявилися напади стенокардії. Який із нижченаведених препаратів йому протипоказано призначати?', 'medium', 365, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'До сімейного лікаря звернувся чоловік віком 65 років з діагнозом ІХС. Після проведення обстеження у пацієнта виявилися підвищеними рівень холестерину та проатерогенних ліпопротеїдів. Лікар призначив пацієнту лікарський засіб, що пригнічує синтез холестерину в печінці. Який лікарський засіб призначив лікар?', 'medium', 366, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранолол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аторвастатин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якому з антигіпертензивних лікарських засобів лікар віддасть перевагу, якщо відомо, що артеріальна гіпертензія асоційована з бронхіальною астмою, цукровим діабетом 2-го типу та дисліпідемією?', 'medium', 367, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнт з діагнозом: гіпертонічна хвороба (АТ — 200/110 мм рт. Ст) — серед препаратів комплексної терапії лікар призначив анаприлін (пропранолол). За 2 тижні після початку приймання цього лікарського засобу пацієнт почав скаржитися на задишку та ускладнене дихання. Що є можливою причиною ускладнень і яку тактику потрібно вбрати в цій ситуації ?', 'medium', 368, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергічна реакція. Приймання препарату відмінити, призначити антигістамінні засоби', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада В1-адренорецепторів. Призначити селективний В2-адреноблокатор', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міотропна бронхостастична дія, Призначити теофілін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудження М-холінорецепторів. Призначити атропін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада В2-адренорецепторів. Призначити селективний В1-адреноблокатор', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якому з антигіпертензивних лікарських засобів лікар віддасть перевагу, якщо відомо, що артеріальна гіпертензія асоційована з бронхіальною астмою, цукровим діабетом 2-го типу та дисліпідемією?', 'medium', 369, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Який препарат належить до групи блокаторів кальцієвих каналів третього покоління?', 'medium', 370, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лозартан', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атенолол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Магнію сульфат', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До сімейного лікаря звернувся пацієнт із скаргою на сильний головний біль. Об''єктивно спостерігається: АТ - 220/110 мм рт. ст., ЧСС - 88/хв, ЧД - 18/хв. Діагностовано неускладнений гіпертензивний криз. Для надання невідкладної допомоги лікар обирає препарат групи блокаторів кальцієвих каналів короткої тривалості дії. Який препарат призначив лікар?', 'medium', 371, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лерканідипін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лацидипін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фелодипін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої при лікуванні гіпертонічної хвороби на фоні прийому препарату виник сухий кашель. Для якого препарату характерна така побічна дія?', 'medium', 372, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дротаверин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Но-шпа', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: гіпертензивна хвороба, у комплексній терапії призначено гідрохлортіазид. Який механізм дії цього препарату сприяє зниженню артеріального тиску?', 'medium', 373, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада ферменту карбоангідрази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення утворення ангіотензину II', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення виділення іонів натрію та води', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада кальцієвих каналів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення виділення іонів натрію та води', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловіку віком 39 років з ознаками гострого медикаментозного отруєння необхідно провести форсований діурез. Який препарат необхідно застосувати?', 'medium', 374, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триамтерен гідрохлортіазид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетазоламід', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Який препарат необхідно призначити пацієнту з симптомами гострої серцевої недостатності, що супроводжується набряком легень?', 'medium', 375, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Триамтерен', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетазоламід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якому з антигіпертензивних лікарських засобів лікар віддасть перевагу, якщо відомо, що артеріальна гіпертензія асоційована з бронхіальною астмою, цукровим діабетом 2-го типу та дисліпідемією?', 'medium', 376, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнту з діагнозом: гіпертензивна хвороба — у комплексній терапії призначено гідрохлортіазид. Який механізм дії цього препарату сприяє зниженню артеріального тиску?', 'medium', 377, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада кальцієвих каналів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення виділення іонів натрію та води', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада ферменту карбоангідрази', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення утворення ангіотензину ІІ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення виділення іонів натрію та води', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 50 років в анамнезі наявні часті епізоди ниркової кольки з кальцій-вмісними каменями в нирках. У результаті обстеження виявлено дефект проксимальної канальцевої реабсорбції кальцію, що призводить до високих концентрацій солей кальцію в сечі. Укажіть найоптимальніший діуретичний засіб для профілактики утворення кальцієвих ниркових конкрементів.', 'medium', 378, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетазоламід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маніт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування хронічної серцевої недостатності хворий приймає дигоксин. Який діуретичний засіб може збільшити токсичність дигоксину за рахунок посиленого виведення з організму іонів K+?', 'medium', 379, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Силібор', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панангін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В комплексному лікуванні гіпертонічної хвороби пацієнту призначено сечогінний препарат. За кілька днів АТ знизився але виникли ознаки гіпокаліємії. Який препарат міг викликати такі ускладнення?', 'medium', 380, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еналаприл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клонідин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час наркозу у хворого виникла загроза набряку мозку. Який препарат треба ввести у цьому разі?', 'medium', 381, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тріамтерен', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію бромід', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворій жінці із захворюванням нирок, що супроводжується вираженими набряками, призначили діуретичний препарат, що пригнічує реабсорбцію в нирках іонів Na+ і води, посилює виведення нирками іонів K+ і Mg++, викликає гіперурикемію, зумовлює потужний діуретичний ефект. Назвіть цей препарат:', 'medium', 382, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тріамтерен', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діакарб', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аллопуринол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для дегідратаційної терапії у разі набряку мозку та легень призначають препарат із потужною натрійуретичною дією. Укажіть цей препарат:', 'medium', 383, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маніт', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Теофілін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фуросемід', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кислота етакринова', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час лікування хронічного набрякового синдрому фуросемідом у пацієнта виникло порушення катіонного складу плазми крові. Який засіб потрібно використовувати для його корегувания?', 'medium', 384, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію хлорид', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцію хлорид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрію гідрокарбонат', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Літію карбонат', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому із загальним набряковим синдромом на тлі серцевої недостатності призначено фуросемід. Вплив на який процес забезпечує його терапевтичний ефект в цьому випадку?', 'medium', 385, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активний транспорт іонів крізь базальну мембрану', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Карбоангідразу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез натрієвих каналів в дистальних канальцях', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковий кровотік', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Транспорт іонів крізь апікальну мембрану', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з значними периферійними набряками почергове застосування діхлотіазида, етакринової кислоти і фуросеміду НЕ сприяло значному діуретичному ефекту. У крові значне підвищення кількості альдостерону. Вкажіть препарат вибору.', 'medium', 386, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілорид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клопамід', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці з гіпертонічною хворобою лікар призначив лозартан. Яка фармакологічна властивість цього препарату забезпечує терапевтичний ефект?', 'medium', 387, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада ангіотензинових рецепторів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібування ангіотензин перетворювального ферменту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада alpha-адренорецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагонізм з іонами кальцію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада beta-адренорецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки віком 45 років артеріальна гіпертензія з високою концентрацією ангіотензину-2 у крові. Який із нижченаведених антигіпертензивних засобів треба рекомендувати у цьому разі?', 'medium', 388, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Празозин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який тривалий час вживає препарати, що блокують вироблення ангіотензину II, виникли брадикардія, порушення серцевого ритму. Можливою причиною цих розладів є:', 'medium', 389, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокальціємія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпокаліємія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкальціємія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпернатріємія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкаліємія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці віком 72 роки, яка хворіє на гіпертонічну хворобу, з метою зниження АТ було рекомендовано препарат із групи блокаторів кальцієвих каналів. Як проявиться ефект цих ліків на функції міокарда шлуночків?', 'medium', 390, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням ЧСС', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням тривалості реполяризації', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефект буде відсутній', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням фази плато', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зростанням скоротливості', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Інгібітори ангіотензин-перетворювального ферменту (АПФ) широко застосовують як гіпотензивні засоби. Яку систему вазоактивних пептидів, що регулюють артеріальний тиск та водно-сольовий обмін, вони коригують?', 'medium', 391, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін-ангіотензинову', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібринолітичну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Коагулянтну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антикоагулянтну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калікреїн-кінінову', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з ІХС виникли порушення серцевого ритму, збільшився рівень глюкози у крові. Поруч з антиангінальними засобами, лікар призначив вітамінний препарат. Який з вітамінних засобів має кардіотрофічний та гіпоглікемічний ефект?', 'medium', 392, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ціанокобаламін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тіамін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рибофлавін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ретинол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ергокальциферол', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого стенокардія. Який антиангінальний засіб протипоказаний для лікування, якщо в пацієнта алергія на йод?', 'medium', 393, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітросорбід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дротаверин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 69 років зі встанонленим діагнозом: ішемічна хвороба серця — з’явився гострий стискальний біль за грудниною. Який препарат показаний у цьому разі з групи нітратів?', 'medium', 394, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метамізол натрію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дротаверин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атропін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ніфедипін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту під час нападу стенокардії призначили лікарський засіб у таблетках під язик. За 1 хвилину стискальний біль у серці послабшав, але з’явився головний біль, що пульсує. Визначте цей препарат:', 'medium', 395, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенігідин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нітрогліцерин', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Папаверин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Нітрогліцерин використовується для розширення коронарних судин та зменшення болю в серці. В організмі людини він розпадається з утворенням нітроген оксиду (NO). Активність якого ферменту підвищується в цьому разі?', 'medium', 396, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циклооксигенази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденілатциклази', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гуанілатциклази', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпооксигенази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфоліпази С', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта 48 років після сильного психоемоційного навантаження раптово з''явився гострий біль у ділянці серця з іррадіацією у ліву руку. Нітрогліцерин зняв напад болю через 10 хвилин. Який патогенетичний механізм є провідним у розвитку болю у даному випадку?', 'medium', 397, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення потреби міокарда у кисні', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширення периферичних судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стиснення коронарних судин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спазм коронарних судин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Закупорка коронарних судин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнту з діагнозом: артеріальна гіпертензія з явищами стенокардії, призначили препарат із групи антагоністів кальцію. Укажіть цей препарат.', 'medium', 398, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метопролол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Молсидомін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пентоксифілін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на атеросклероз приймає антисклеротичний засіб - фенофібрат. Який механізм дії має цей засіб?', 'medium', 399, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Знижує рівень хіломікронів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібує абсорбцію холестерину в ШКТ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищує захоплення ліпопротеїдів низької щільності та блокує біосинтез ендогенного холестерину', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поновлює негативний електричний заряд ендотелію судин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпшує мікроциркуляцію крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Серед гіполіпідемічних препаратів, що застосовуються з метою профілактики та лікування атеросклерозу, є ловастатин. Який механізм дії цього лікарського засобу?', 'medium', 400, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення всмоктування холестерину в кишківнику', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулювання екскреції холестерину з організму', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гальмування біосинтезу холестерину', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Усіма наведеними шляхами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активація метаболізму холестерину', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До сімейного лікаря звернувся чоловік віком 65 років з діагнозом ІХС. Після проведення обстеження у пацієнта виявилися підвищеними рівень холестерину та проатерогенних ліпопротеїдів. Лікар призначив пацієнту лікарський засіб, що пригнічує синтез холестерину в печінці. Який лікарський засіб призначив лікар?', 'medium', 401, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пропранолол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аторвастатин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амлодипін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієита з ішемічною хворобою серця виявлено підвищений вміст тригліцеридів і ліпопротеїнів низької щільності в плазмі крові. Який препарат необхідно призначити в цьому разі?', 'medium', 402, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенофібрат', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фамотидин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на ішемічну хворобу серця виявлено підвищений вміст тригліцеридів і ліпопротеїнів низької щільності в плазмі крові. Який препарат слід призначити?', 'medium', 403, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фамотидин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенофібрат', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому 68-ми років в комплекс лікування атеросклерозу, ускладненого ішемічною хворобою серця, лікар включив гіполіпідемічний засіб, який знижує вміст в крові переважно тригліцеридів. Який із вказаних препаратів було призначено хворому?', 'medium', 404, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Преднізолон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глібенкламід', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фенофібрат', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на атеросклероз приймає антисклеротичний засіб - фенофібрат. Який механізм дії має цей засіб?', 'medium', 405, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Знижує рівень хіломікронів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібує абсорбцію холестерину в ШКТ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищує захоплення ліпопротеїдів низької щільності та блокує біосинтез ендогенного холестерину', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поновлює негативний електричний заряд ендотелію судин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліпшує мікроциркуляцію крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після прийому препарату у хворого з серцевою недостатністю зменшилася частота скорочень серця, пул став кращого наповнення, зменшилися набряки, збільшився діурез. Вкажить, який препарат приймав хворий:', 'medium', 406, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дилтіазем', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому 50-ти років з хронічною серцевою недостатністю і тахіаритмією призначили кардіотонічний препарат. Який з препаратів призначили хворому?', 'medium', 407, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мілдронат', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому, що страждає на хронічну серцеву недостатність, лікар порадив провести профілактичний курс лікування кардіотонічним препаратом з групи серцевих глікозидів, який приймають ентерально. Який препарат було рекомендовано хворому?', 'medium', 408, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Строфантин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кордіамін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кордарон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий з хронічною серцево- судинною недостатністю приймав дигоксин. Після призначення додаткової терапії розвинулися явища інтоксикації серцевими глікозидами. Який препарат може викликати підсилення інтоксикації серцевими глікозидами?', 'medium', 409, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розчин глюкози', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Магнію хлорид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кальцію хлорид', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аспаркам', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому призначено препарат дигоксин. Через декілька днів у хворого виявлено ознаки передозування цим препаратом, його вміст у крові значно перевищував верхню межу терапевтичної концентрації. Як називається такий варіант дії лікарських речовин?', 'medium', 410, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагонізм', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляція', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахікардія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звикання', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Потенціювання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікар призначив хворому з гострою серцевою недостатністю неглікозидний кардіотонічний засіб, який безпосередньо стимулює в1-адренорецептори міокарда, що збільшує кровообіг, діурез. Застосовується лише внутрішньовенно крапельно внаслідок швидкої інактивації в організмі. Який препарат призначив лікар?', 'medium', 411, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування хронічної серцевої недостатності хворий приймає дигоксин. Який діуретичний засіб може збільшити токсичність дигоксину за рахунок посиленого виведення з організму іонів K+?', 'medium', 412, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Силібор', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панангін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий надійшов до стаціонару з гострою серцево-судинною недостатністю. Який препарат необхідно призначити хворому в даному випадку?', 'medium', 413, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигітоксин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин в таблетках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну гідрохлорид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Для лікування хронічної серцевої недостатності хворий приймає дигоксин. Який діуретичний засіб може збільшити токсичність дигоксину за рахунок посиленого виведення з організму іонів K+?', 'medium', 414, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Панангін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрохлортіазид', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Силібор', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на хронічну серцеву недостатність протягом декількох місяців приймав в амбулаторних умовах дигоксин. На певному етапі лікування в нього виникли симптоми передозування препарату. Яке явище лежить в основі розвитку цього ускладнення?', 'medium', 415, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Матеріальна кумуляція', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звикання', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізація', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Функціональна кумуляція', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 45-ти років на тлі трансмурального інфаркту міокарда розвинулася гостра лівошлуночкова недостатність. Який лікарський засіб доцільно застосувати у даній ситуації для покращення помпової функції серця?', 'medium', 416, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Промедол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еуфілін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ізадрин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефедрин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта гостра серцева недостатність із нечутливістю міокарда до серцевих глікозид. Який препарат необхідно призначити для лікування гострої серцевої недостатності?', 'medium', 417, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Резерпін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Строфантин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атропіну сульфат', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому з кардіогенним шоком, гіпотензією, ядухою і набряками ввели неглікозидний кардіотонік. Який саме препарат був введений хворому?', 'medium', 418, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Добутамін', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Етимізол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бемегрид', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кофеїн-бензоат натрію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кордіамін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому для купірування порушення серцевого ритму було введено препарат, який також застосовується у якості місцево анестезуючого засобу. Визначте препарат:', 'medium', 419, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кокаїну гідрохлорид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дикаїн', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анестезин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифенін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лідокаїну гідрохлорид', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка на тлі інфаркту міокарда виникла пароксизмальна шлуночкова тахікардія. Який із нижченаведених протиаритмічних засобів треба обрати, щоб не зменшити серцевий викид?', 'medium', 420, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Новокаїнамід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лідокаїну гідрохлорид', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верапаміл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калію хлорид', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анаприлін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому перед екстракцією зуба була проведена провідникова анестезія лідокаїном, після введення якого з’явилися набряк і гіперемія навколо місця уколу, свербіння шкіри, загальна слабкість, гіпотензія, рухове збудження. Визначте, як називається ускладнення, що виникло:', 'medium', 421, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лікарська залежність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Токсична дія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тахіфілаксія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Толерантність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алергічна реакція', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому на гостру серцеву недостатність було введено серцевий глікозид швидкої дії. Який з перелічених засобів було введено?', 'medium', 422, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адонізид', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигітоксин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Целанід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мілринон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий надійшов до стаціонару з гострою серцево-судинною недостатністю. Який препарат необхідно призначити хворому в даному випадку?', 'medium', 423, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміодарон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигітоксин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигоксин в таблетках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну гідрохлорид', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До приймального відділення лікарні доставлено хворого з вираженими явищами гострої серцевої недостатності. Який препарат, із зазначених нижче, слід використати в першу чергу?', 'medium', 424, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дитилін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фізостигмін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Етазол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дигітоксин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Корглікон', true, 4, NOW(), NOW());

  RAISE NOTICE 'Додано питань: 425';
END $$;
