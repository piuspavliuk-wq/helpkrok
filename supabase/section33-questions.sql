-- SQL для додавання питань до розділу 33: Нормальний розвиток і структура, вікові зміни
-- Автоматично згенеровано
-- Кількість питань: 250

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо або створюємо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Сечова система'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    INSERT INTO courses (title, faculty, description, order_index, is_active, created_at, updated_at)
    VALUES (
      'Сечова система',
      'medical',
      'Сечова система',
      15,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_course_id;
    RAISE NOTICE 'Створено курс "%s" з ID: %', 'Сечова система', v_course_id;
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
  VALUES (v_topic_id, 'У пацієнта порушена функція нирок. Для перевірки стану фільтраційної здатності нирок йому призначено визначення кліренсу:', 'medium', 0, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрокарбонату', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індолу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутаміну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечової кислоти', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У реанімаційному відділенні знаходиться хворий у коматозному стані. При дослідженні крові відзначено збільшення концентрації іонів K+ і зменшення - Ca++, ацидоз, збільшення рівнів сечовини, сечової кислоти. Який вид коми за етіологією найбільш імовірний?', 'medium', 1, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркова', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Печінкова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоглікемічна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діабетична', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейрогенна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час видалення правого яєчника хірург замість яєчникової артерії прев’язав орган, розміщений поряд. Який орган перев’язав хірург?', 'medium', 2, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовід', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нижню порожнисту вену', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аорту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальну клубову артерію', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час оперативного втручання на малому тазі жінки виникла необхідність перев’язати яєчникову артерію. Яке з утворень може бути випадково перев’язаним разом з нею?', 'medium', 3, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечівник', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маткова труба', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовід', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішня клубова вена', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кругла зв’язка матки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У ході хірургічної операції на нирці із заднього доступу (з боку спини) виникла необхідність перетиснути ниркову артерію. У якій послідовності розташовані елементи ниркової ніжки у її воротах ззаду наперед?', 'medium', 4, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вена, артерія, сечовід', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артерія, вена, сечовід', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовід, артерія, вена', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артерія, сечовід, вена', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вена, сечовід, артерія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Слизова оболонка трубчастого органу вкрита перехідним епітелієм, утворює поздовжні складки. М’язова оболонка складається з двох шарів у верхній половині і трьох у нижній. Який це орган?', 'medium', 5, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовий міхур', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пряма кишка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стравохід', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовід', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маткова труба', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки 37 років під час оперативного втручання на органах малого тазу виникла необхідність перев’язати маткову артерію. Яке з утворень може бути випадково перев’язаним разом з нею?', 'medium', 6, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечівник', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішня клубова вена', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовід', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маткова труба', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кругла зв’язка матки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Повільне наповнення шлунка чи сечового міхура в межах фізіологічної норми не викликає підвищення тиску в цих органах. Яка властивість гладеньких м''язів лежить в основі цього явища?', 'medium', 7, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Автоматія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скоротливість', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рефрактерність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збудливість', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пластичність', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта після катетеризації сечового міхура в загальному аналізі сечі зʼявилася велика кількість свіжих еритроцитів, що ймовірно, повʼязано з пошкодженням найвужчої частини сечовипускного каналу. Яка частина сечівника пошкоджена?', 'medium', 8, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передміхурова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ближча', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дальша', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перетинчаста', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Губчаста', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У полі зору цистоскопа гладка поверхня слизової оболонки без складок. Яка частина сечового міхура у полі зору?', 'medium', 9, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тіло.', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхуровий трикутник', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шийка.', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Верхівка.', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дно', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на хронічний цистит у біоптаті слизової оболонки сечового міхура разом з перехідним епітелієм виявлені вогнища багатошарового плоского незроговілого епітелію. Який процес лежить в основі зазначених змін в епітелії?', 'medium', 10, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаплазія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистрофія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дисплазія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперплазія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперкератоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'За якої умови можливо виконати пункцію сечового міхура через передню черевну стінку, не займаючи очеревину?', 'medium', 11, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у чоловіків', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у жінок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У разі спустошеного сечового міхура', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У разі наповненого сечового міхура', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у дітей', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час тяжких пологів відбувся розрив лобкового симфізу. Який орган найбільш імовірно буде травмований?', 'medium', 12, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Матка', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Яєчники', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маткові труби', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пряма кишка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовий міхур', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої після видалення матки розвинулась гостра анурія (немає виділення сечі). Які анатомічні структури найімовірніше було пошкоджено при операції?', 'medium', 13, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зовнішній сфінктер сечівника', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішній сфінктер сечівника', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечівник', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цибулинно-губчастий м’яз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечоводи', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пункцію сечового міхура через передню черевну стінку, не займаючи очеревину, можливо виконати:', 'medium', 14, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'При наповненому сечовому міхурі', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'При пустому сечовому міхурі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у чоловіків', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у дітей', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тільки у жінок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час проведення хромоцистоскопії лікарка повинна знайти вічка сечоводів. Яке з анатомічних утворень може слугувати орієнтиром для цієї маніпуляції?', 'medium', 15, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Trigonum vesicae', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Apex vesicae', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Corpus vesicae', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Cervix vesicae', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Urachus', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого сечокам’яна хвороба. При видаленні конкременту з правого сечоводу хірург розрізав стінку сечоводу. В яке анатомічне утворення потрапить сеча?', 'medium', 16, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково-міхурове заглиблення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Заочеревинний простір', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Правий бічний канал', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Правий брижовий синус', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лівий бічний канал', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Сечокам’яна хвороба ускладнилася виходом камінця з нирки. На якому рівні сечовода, найімовірніше, він може зупинитися?', 'medium', 17, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'На 2 см вище впадіння в сечовий міхур', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У середній черевній частині', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У мисці', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'На межі черевної та тазової частин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'На 5 см вище тазової частини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінці 58-ми років проведене повне видалення матки з придатками, після чого виділення сечі припинилося. При цистоскопії: міхур сечі не містить, з устів сечоводів сеча не надходить. Який відділ сечовидільної системи було ушкоджено в ході операції?', 'medium', 18, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ureter', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Pelvis renalis', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ren', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Vesica urinaria', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Uretra', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком б5 років звернувся до лікаря-уролога зі скаргами на утруднене сечовиділення. Після огляду встановлено, що гіпертрофовано орган, який охоплює проксимальний відділ уретри. Який орган гіпертрофований?', 'medium', 19, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Придаток яєчка', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передміхурова залоза', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цибулина статевого члена', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бульбо-уретральна залоза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сім’яні пухирці', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий скаржиться на часте та утруднене сечовиділення. Порушення структури якого з наведених утворень є причиною цього?', 'medium', 20, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Придатки яєчка', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Яєчка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бульбоуретральні залози', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простата', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сім’яні міхурці', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікаря-педіатра звернулись батьки новонародженої дитини зі скаргами на виділення рідини (сечі) в ділянці пупка. Яка вроджена вада у дитини?', 'medium', 21, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пахвинна грижа', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дивертикул Меккеля', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розщеплення сечівника', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Незрощена сечова протока', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пупкова грижа', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після травматичного ураження промежини у потерпілого спостерігається нетримання сечі. Який м’яз був травмований?', 'medium', 22, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зовнішній стискач сечівника', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сіднично-печеристий м’яз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поверхневий поперечний м’яз промежини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішній стискач відхідника', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глибокий поперечний м’яз промежини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Парубок звернувся до лікарні зі скаргами на порушення сечовипускання. Під час обстеження зовнішіх статевих органів виявлено, що сечівник розщеплений зверху і сеча витікає крізь цей отвір. Який вид аномали розвитку зовнішніх статевих органів спостерігається у цьому разі?', 'medium', 23, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парафімоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фімоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обстеження зовнішніх статевих органів у хлопчика виявлено повне закриття уретри зверху. Сечівник залишається відкритим знизу і має вигляд невеликої щілини. Який вид аномалії розвитку зовнішніх статевих органів спостерігається у дитини?', 'medium', 24, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парафімоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фімоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Молодий чоловік звернувся до лікарні зі скаргами на порушення сечовипускання. Під час обстеження зовнішніх статевих органів виявлено, що сечівник розщеплений зверху й сеча витікає через цей отвір. Який вид аномалії розвитку зовнішніх статевих органів спостерігається у цьому випадку?', 'medium', 25, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парафімоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фімоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У новонародженого хлопчика під час огляду зовнішніх статевих органів виявлена розщілина сечівника, яка відкривається на нижній поверхні статевого члена. Про яку аномалію йдеться?', 'medium', 26, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крипторхізм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Монорхізм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У сечі пацієнта віком 30 років виявлено глюкозу за нормальної її кількості у крові. Які структурно-функціональні механізми нирок пошкоджено?', 'medium', 27, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в тонкому канальці', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі нефрону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі в результаті недостатності секреції АДГ', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес фільтрації', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в проксимальному відділі нефрону', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При диспансерному обстеженні у хворого знайдено цукор в сечі. Який найбільш імовірний механізм виявлених змін, якщо вміст цукру в крові нормальний?', 'medium', 28, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення реабсорбції глюкози в канальцях нефрона', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція глюкокортикоїдів наднирниками', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатня продукція інсуліну підшлунковою залозою', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулінорезистентність рецепторів клітин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення фільтрації глюкози в клубочковому відділі нефрона', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, який скаржиться на поліурію і полідипсію, знайдено цукор в сечі. Вміст цукру в плазмі крові у нормі. З чим пов’язаний механізм глюкозурії у хворого?', 'medium', 29, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулінорезистентність рецепторів клітин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення реабсорбції глюкози в канальцях нефрону', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція глюкокортикоїдів наднирниками', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатня продукція інсуліну підшлунковою залозою', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення фільтрації глюкози в клубочковому відділі нефрону', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на цукровий діабет розвинулась діабетична нефропатія з розвитком уремії. Швидкість клубочкової фільтрації 9 мл/хв. Який найбільш імовірний механізм зниження швидкості клубочкової фільтрації і розвитку хронічної ниркової недостатності у пацієнта?', 'medium', 30, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення маси діючих нефронів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження системного артеріального тиску', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спазм артеріол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Закупорка просвіту канальців нефрону гіаліновими циліндрами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розвиток ацидозу в тканинах', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з діагнозом: хронічний дифузний гломерулонефрит, розвинулася хронічна ниркова недостатність. На термінальній стадії ХНН розвивається оліго- та анурія, що спричиняється:', 'medium', 31, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дисемінованим внутрішньосудинним зсіданням крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемією коркової речовини нирок унаслідок спазму судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням реабсорбції води в дистальних канальцях', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженням кількості функціонуючих нефронів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням фільтраційного тиску та фільтрації', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У сечі пацієнта віком 30 років виявлено глюкозу за нормальної її кількості у крові. Які структурно-функціональні механізми нирок пошкоджено?', 'medium', 32, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес фільтрації', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в тонкому канальці', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі в результаті недостатності секреції АДГ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції у проксимальному відділі нефрону', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з гострою нирковою недостатністю на 6-й день проведення терапевтичних заходів виникла поліурія. Чим зумовлене зростання діурезу на початку поліуричної стадії гострої ниркової недостатності?', 'medium', 33, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відновлення фільтрації в нефронах', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням об’єму циркулюючої крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням натрійуретичного фактора', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням альдостерону в плазмі', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням вазопресину в плазмі', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на хронічний гломерулонефрит швидкість клубочкової фільтрації (ШКФ) знижена до 20% від нормальної. Що є основною причиною зниження ШКФ у даному випадку?', 'medium', 34, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемія нирок', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулопатія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обтурація сечовивідних шляхів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення кількості функціонуючих нефронів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоз ниркових артерій', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта встановлено порушення синтезу альдостерону. У якому відділі нефрона порушиться сечоутворення?', 'medium', 35, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальному звивистому канальці', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочку', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тонкій частині петлі Генле', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Товстій частині петлі Генле', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збірній трубочці', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 30 років, який шпиталізований із діагнозом: гострий гломерулонефрит – спостерігалася протеїнурія. Яке порушення спричинило це явище?', 'medium', 36, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску на стінку капілярів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності клубочкової мембрани', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження кількості нефронів,що функціонують', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Затримка виведення продуктів азотистого обміну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з хронічною нирковою недостатністю встановлено зменшення кліренсу за інуліном до 60 мл/хв. З порушенням якої функції нирок це пов''язано?', 'medium', 37, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в проксимальному відділі нефрону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в збиральних ниркових трубочках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в дистальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочкової фільтрації', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцевої секреції', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Піддослідному собаці ввели гормон, що призвело до збільшення швидкості клубочкової фільтрації за рахунок розширення приносної артеріоли і зменшення реабсорбції іонів натрію і води в канальцях нефрона. Який гормон було введено?', 'medium', 38, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердний натрійуретичний гормон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта діагностовано хронічний гломерулонефрит. Унаслідок значних склеротичних змін маса функціональних нефронів зменшилася до 10%. Яке з нижченаведених порушень лежить в основі наростаючого уремічного синдрому?', 'medium', 39, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Азотемія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення осмотичного гемостазу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення водного гемостазу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна гіпертензія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркова остеодистрофія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На електронній мікрофотографії ділянки нирки у стінці приносної та виносної артеріол визначаються клітини з великими секреторними гранулами в цитоплазмі. Визначте структурне утворення нирки, до складу якого входять ці клітини:', 'medium', 40, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальний відділ нефрона', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Петля нефрона', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистальний відділ нефрона', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярний апарат', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'рН артеріальної крові - 7,4; первинної сечі - 7,4; кінцевої сечі - 5,8. Зниження рН кінцевої сечі є наслідком секреції у канальцях нефрона:', 'medium', 41, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іонів водню', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іонів калію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Іонів гідрокарбонату', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з хронічною нирковою недостатністю встановлено зменшення кліренсу за інуліном до 60 мл/хв. З порушенням якої функції нирок це пов’язано?', 'medium', 42, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочкової фільтрації', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцевої секреції', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в проксимальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в дистальному відділі нефрону', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в збиральних ниркових трубочках', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта встановлено порушення синтезу та виділення вазопресину. В якому відділі нефрона найбільше порушиться процес сечоутворення?', 'medium', 43, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тонка частина петлі Генле', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Товста частина петлі Генле', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальний звивистий каналець', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збірна трубочка', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На препараті нирки розрізняються нефрони, які лежать на межі між кірковою та мозковою речовиною, мають однаковий діаметр приносних і виносних артеріол. Назвіть, яка функція буде порушена при їхньому пошкодженні?', 'medium', 44, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез простагландинів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шунтування крові при інтенсивному кровообігу', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез реніну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активність натрієвого рецептора', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синтез еритропоетину', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При гістологічному дослідженні нирки в кірковій речовині визначається каналець, вистелений одношаровим кубічним облямівчастим епітелієм, цитоплазма якого забарвлена оксифільно. Який сегмент нефрону виявлений у препараті?', 'medium', 45, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистальний прямий каналець', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збірна трубочка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистальний звивистий каналець', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Петля Генле', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальний звивистий каналець', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з масивними опіками розвинулась гостра недостатність нирок, що характеризується значним і швидким зменшенням швидкості клубочкової фільтрації. Який механізм її розвитку?', 'medium', 46, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення кількості функціонуючих нефронів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ниркового кровотоку', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення тиску канальцевої рідини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодження клубочкового фільтра', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емболія ниркової артерії', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На гістологічному препараті нирки представлена ділянка дистального канальцю нефрону, що проходить між приносною та виносною артеріолами. У клітинах, що складають стінку канальця, наявні ущільнені ядра, відсутня базальна мембрана. Як зветься це структурне утворення?', 'medium', 47, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкставаскулярні клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіальні клітини', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярні клітини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Гурмагтіга', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щільна пляма', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При лабораторному дослідженні сечі в нормі в ній не виявляються формені елементи крові. Яка структура нефрону найбільше перешкоджає їх надходженню до первинної сечі?', 'medium', 48, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіальні клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епітелій зовнішнього листка капсули клубочка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епітелій петлі Генле', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Базальна мембрана капілярів клубочка', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкставаскулярні клітини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Мама одинадцятирічної дівчинки скаржиться на слабкість та набряклість обличчя її дитини уродовж 3-х днів, хоча до цього вона завжди була здоровою та активною. Під час фізикального обстеження виявлено генералізований набряк обличчя, якщо натискати на набряк нижніх кінцівок, залишається ямка, яка поступово згладжується. Під час збору анамнезу дівчинка зазначає пінистий вигляд сечі, але заперечує домішки крові у сечі, ніктурію або біль під час сечовиділення. Лабораторні дослідження виявили протеїнурію та мікрогематурію. Що з нижченаведеного є ймовірною причиною змін у лабораторному аналізі сечі?', 'medium', 49, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в клубочку', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску плазми крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в капсулі Шумлянського-Боумена', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності стінки клубочкового капіляра', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час мікроскопії нирки патолоанатом виявив, що приблизно у 80% клубочків спостерігається розмноження епітелію зовнішнього листка капсули Шумлянського, що формує «півмісяці». Він дійшов висновку що така картина відповідає:', 'medium', 50, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтракапілярному ексудативному гломерулонефриту', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстракапілярному проліферативному (швидкопрогресуючому) гломерулонефриту', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібропластичному гломерулонефриту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екстракапілярному ексудативному гломерулонефриту', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтракапілярному проліферативному гломерулонефриту', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Дівчинка 11 років прийшла на прийом до лікаря із мамою, яка скаржиться на слабкість та набряклість обличчя її дитини протягом 3 днів. Мати стверджує, що до початку симптомів її дитина завжди була здоровою та активною. Під час фізикального обстеження виявлено генералізований набряк обличчя, якщо натискати на набряк нижніх кінцівок, залишається ямка, яка поступово згладжується. Під час збору анамнезу дівчинка зазначає пінистий вигляд сечі, але заперечує домішки крові у сечі, ніктурію або біль під час сечовиділення. Лабораторні дослідження виявили протеїнурію та мікрогематурію. Що з наведеного є найімовірнішою причиною змін у лабораторному аналізі сечі?', 'medium', 51, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску у капсулі Шумлянського-Боумена', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску плазми крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску у клубочку', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності стінки клубочкового капіляру', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Введення пацієнту знеболювального перед екстракцією зуба призвело до розвитку анафілактичного шоку, який супроводжувався розвитком олігурії. Який патогенетичний механізм зумовив зменшення діурезу в даній клінічній ситуації?', 'medium', 52, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження гідростатичного тиску в капілярах клубочків', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження клубочкового фільтру', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення кількості функціонуючих нефронів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення онкотичного тиску крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску в капсулі Шумлянського-Боумена', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Важливою складовою частиною ниркового фільтраційного бар''єру є тришарова базальна мембрана, середній електронно-щільний шар якої має сітчасту будову. Де розташована ця базальна мембрана?', 'medium', 53, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У дистальних звивистих канальцях', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У нирковому тільці', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У проксимальних канальцях', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У дистальних прямих канальцях', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'У тонких канальцях', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Важливою складовою частиною ниркового фільтраційного бар’єру є тришарова базальна мембрана, яка має спеціальну сітчасту будову її середнього електроннощільного шару. Де міститься ця базальна мембрана?', 'medium', 54, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тонкі канальці', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Капіляри перитубулярної капілярної сітки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистальні прямі канальці', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркове тільце', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальні канальці', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому поставлений діагноз: гострий пієлонефрит із запаленням стінок ниркових чашечок і мисок. Який епітелій зазнав пошкодження?', 'medium', 55, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Одношаровий призматичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багатошаровий плоский зроговілий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багатошаровий кубічний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перехідний', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багаторядний війчастим', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При лабораторному дослідженні крові пацієнта 44-х років виявлено, що вміст білків в плазмі становить 40 г/л. Як це впливає на транскапілярний обмін води?', 'medium', 56, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшуються фільтрація та реабсорбція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшується фільтрація, зменшується реабсорбція', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обмін не змінюється', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшуються фільтрація та реабсорбція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшується фільтрація, збільшується реабсорбція', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час лабораторного дослідження крові пацієнта виявлено, що вміст білків у плазмі становить 40 г/л. Як це вплине на транскапілярний обмін води в мікроциркуляторному судинному руслі?', 'medium', 57, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться і фільтрація, і реабсорбція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшиться фільтрація, зменшиться реабсорбція', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшиться і фільтрація, і реабсорбція', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обмін не зміниться', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться фільтрація, збільшиться реабсорбція', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 24 років потрапила до лікарні зі скаргами на головний біль, біль у поперековій ділянці, набряки на обличчі, загальну слабкість. Місяць тому перенесла ангіну. На час надходження: АТ - 180/110 мм рт.ст., у сечі виявлено виражену протеінурію, мікрогематурію, лейкоцитурію. На яку форму гіпертензії страждає хвора?', 'medium', 58, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічну хворобу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркову', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Есенціальну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендокринну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Укажіть клітини ендокринного комплексу нирки, що знаходяться під ендотелієм у стінці приносної та виносної артеріоли, у цитоплазмі містять гранули реніну, що сприяє підвищенню кровʼяного тиску.', 'medium', 59, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерстиційні клітини', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярні', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини щільної плями', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Гурмагтіга', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Клітини ендокринного комплексу нирки знаходяться під ендотелієм у стінці приносної та виносної артеріоли, у цитоплазмі містять гранули реніну, який сприяє підвищенню кров''яного тиску. Які це клітини?', 'medium', 60, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Гурмагтіга', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини щільної плями', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярні', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерстиційні клітини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На електронній мікрофотографії фрагменту нирки представлена приносна артеріола, у якій під ендотелієм видно великі клітини, що містять секреторні гранули. Назвіть даний вид клітин:', 'medium', 61, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярні', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіальні', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкставаскулярні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інтерстиційні', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гладеньком’язові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з хронічною нирковою недостатністю встановлено зменшення кліренсу за інуліном до 60 мл/хв. З порушенням якої функції нирок це пов’язано?', 'medium', 62, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочкової фільтрації', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцевої секреції', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в проксимальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в дистальному відділі нефрону', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в збиральних ниркових трубочках', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 58 років із кардіогенним шоком спостерігалося зменшення добової кількості сечі — олігурія. Який механізм цього явища?', 'medium', 63, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження клубочкової фільтрації', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску на стінку капілярів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження кількості функціональних клубочків', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження проникності клубочкової мембрани', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час лабораторного обстеження чоловіка 54 років було встановлено, що його кліренс інуліну становить 120 мл/хв. Це означає, що в нього в нормі такий показник:', 'medium', 64, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковий кровотік', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковий плазмотік', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцева реабсорбція', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцева секреція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкість клубочкової фільтрації', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з хронічною нирковою недостатністю встановлено зменшення кліренсу за інуліном до 60 мл/хв. З порушенням якої функції нирок це пов''язано?', 'medium', 65, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в проксимальному відділі нефрону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в збиральних ниркових трубочках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбції в дистальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочкової фільтрації', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцевої секреції', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Білому щуру ввели під шкіру сулему в дозі 5 мг/кг маси тіла. За 24 години в плазмі крові концентрація креатиніну збільшилася в декілька разів. Який механізм ретенційної азотемії у цьому разі?', 'medium', 66, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зростання реабсорбції креатиніну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення утворення креатиніну в м''язах', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зростання клубочкової фільтрації', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення секреції креатиніну в канальцях нирок', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження клубочкової фільтрації', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При отруєнні етиленгліколем у пацієнта розвинулася гостра ниркова недостатність: З’явилася нудота, блювання, потьмарення свідомості, артеріальна гіпотензія, аритмія та анурія. Що спричинило зменшення клубочкової фільтрації в пацієнта?', 'medium', 67, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення гідростатнчного тиску в кубочках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення загальної площі фільтрації', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тканинного тиску в нирках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення проникності стінки клубочків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Піддослідному собаці ввели гормон, що призвело до збільшення швидкості клубочкової фільтрації за рахунок розширення приносної артеріоли і зменшення реабсорбції іонів натрію і води в канальцях нефрона. Який гормон було введено?', 'medium', 68, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердний натрійуретичний гормон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Група дослідників, що вивчають фізіологію серця, виявили, що надмірне розтягнення передсердь серця веде до зниження реабсорбції натрію в дистальному звивистому канальці та підвищення швидкості клубочкової фільтрації. Що із перерахованого є ймовірною причиною фізіологічних змін, виявлених дослідниками?', 'medium', 69, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійуретичний гормон', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка швидкість клубочкової фільтрації 180 мл/хв (норма -125±25 мл/хв).Причиною цього може бути зменшення:', 'medium', 70, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ефективного фільтраційного тиску', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідростатичного тиску крові в капілярах клубочків', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проникності ниркового фільтру', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркового кровотоку', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Онкотичного тиску плазми крові', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час експерименту тварині зменшили кровопостачання нирок. За деякий час у тварини різко підвищився кров''яний тиск. Що було причиною цього явища?', 'medium', 71, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення клубочкової фільтрації', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення продукції реніну', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ефективного фільтраційного тиску', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення процесів реабсорбції в дистальних звивистих канальцях', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення процесів реабсорбції в проксимальних звивистих канальцях', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 58-ми років з гострою серцевою недостатністю спостерігається зменшення добової кількості сечі - олігурія. Який механізм цього явища?', 'medium', 72, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'При отруєнні етиленгліколем у пацієнта розвинулася гостра ниркова недостатність: З’явилася нудота, блювання, потьмарення свідомості, артеріальна гіпотензія, аритмія та анурія. Що спричинило зменшення клубочкової фільтрації в пацієнта?', 'medium', 73, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення гідростатнчного тиску в кубочках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення загальної площі фільтрації', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тканинного тиску в нирках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення проникності стінки клубочків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Піддослідному собаці ввели гормон, що призвело до збільшення швидкості клубочкової фільтрації за рахунок розширення приносної артеріоли і зменшення реабсорбції іонів натрію і води в канальцях нефрона. Який гормон було введено?', 'medium', 74, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тироксин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердний натрійуретичний гормон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з масивними опіками розвинулась гостра недостатність нирок, що характеризується значним і швидким зменшенням швидкості клубочкової фільтрації. Який механізм її розвитку?', 'medium', 75, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення кількості функціонуючих нефронів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення ниркового кровотоку', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення тиску канальцевої рідини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ушкодження клубочкового фільтра', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Емболія ниркової артерії', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого знижений синтез вазопресину, що призводить до поліурії і, як наслідок, до вираженої дегідратації організму. У чому полягає механізм розвитку поліурії?', 'medium', 76, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження канальцевої реабсорбції білку', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження канальцевої реабсорбції іонів Na', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження канальцевої реабсорбції води', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження реабсорбції глюкози', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення швидкості клубочкової фільтрації', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини внаслідок тривалого голодування швидкість клубочкової фільтрації зросла на 20%. Найбільш імовірною причиною змін фільтрації в зазначених умовах є:', 'medium', 77, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску плазми крові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення системного артеріального тиску', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення ниркового плазмотоку', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення коефіцієнту фільтрації', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення проникності ниркового фільтру', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У разі зниження концентрації Na+ у плазмі крові в нирках посилюється його реабсорбція. Який основний механізм регуляції стимулює цей процес?', 'medium', 78, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатичні рефлекси', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатичні рефлекси', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійуретичний гормон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Якщо концентрація Na+ у плазмі крові знижується, у нирках посилюється його реабсорбція. Який основний механізм регуляції стимулює цей процес?', 'medium', 79, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійуретичний гормон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парасимпатичні рефлекси', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатичні рефлекси', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час лабораторного обстеження чоловіка 54 років було встановлено, що його кліренс інуліну становить 120 мл/хв. Це означає, що в нього в нормі такий показник:', 'medium', 80, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковий кровотік', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковий плазмотік', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцева реабсорбція', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Канальцева секреція', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкість клубочкової фільтрації', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У нирках досліджуваного збільшена реабсорбція іонів кальцію і зменшена - фосфатних іонів. Впливом якого гормону це зумовлено?', 'medium', 81, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тирокальцитонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратгормон', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гормональна форма вітаміну D3', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці віком 45 років було встановлено діагноз: недостатність прищитоподібних залоз. Як зміниться робота нирок при цій патології?', 'medium', 82, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшиться синтез простагландинів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться реабсорбція кальцію в дистальних канальцях', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться фільтрація кальцію в ниркових клубочках', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшиться синтез урокінази', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшиться синтез вітаміну B_6', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У сечі пацієнта віком 30 років виявлено глюкозу за нормальної її кількості у крові. Які структурно-функціональні механізми нирок пошкоджено?', 'medium', 83, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес фільтрації', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в тонкому канальці', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі нефрону', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції в дистальному відділі в результаті недостатності секреції АДГ', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Процес реабсорбції у проксимальному відділі нефрону', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На гістологічному препараті нирки в дистальному звивистому канальці виявляються клітини, які щільно прилягають до ниркового тільця. Базальна мембрана їх дуже тонка і не утворює складок. Ці клітини відчувають зміни вмісту натрію у сечі та впливають на секрецію реніну юкстагломерулярними клітинами. Які це клітини?', 'medium', 84, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подоцити', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини щільної плями', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезангіальні клітини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендотелій капілярів клубочка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Юкстагломерулярні клітини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Однією з причин виникнення мембранного потенціалу спокою є різниця концентрації іонів по обидва боки клітинної мембрани. Який механізм забезпечує іонну асиметрію всередині та зовні клітини?', 'medium', 85, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Полегшена дифузія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піноцитоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активний транспорт', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фільтрування', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Відомо, що однією з причин виникнення мембранного потенціалу спокою є різниця концентрації іонів по обидві сторони клітинної мембрани. Який механізм забезпечує іонну асиметрію всередині і зовні клітини?', 'medium', 86, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активний транспорт', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Полегшена дифузія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піноцитоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фільтрування', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки обмежений кровотік у нирках, підвищений артеріальний тиск. Гіперсекреція якого гормону зумовила підвищення тиску?', 'medium', 87, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еритропоетин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з підвищеним артеріальним тиском, тремором, тахікардією, була діагностовано доброякісна пухлина мозкової речовини наднирників. Гіперсекреція якого гормону викликає таку симптоматику?', 'medium', 88, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У людини зменшений діурез, гіпернатріємія, гіпокаліємія. Гіперсекреція якого гормону може бути причиною таких змін?', 'medium', 89, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передсердний натрійуретичний фактор', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратгормон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини внаслідок втрати 1,5 л крові різко зменшився діурез. Посилена секреція якого гормону спричинила зміни діурезу?', 'medium', 90, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортикотропіну', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратгормон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійуретичний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 24 років через півтори тижні після важкої стрептококової ангіни проявилася набряклість обличчя, підвищився артеріальний тиск. Гематурія і протеїнурія 1,2 г / л. У крові виявлено антистрептококові антитіла і зниження компонентів комплементу. У мікросудинах яких структур найбільш імовірна локалізація скупчень імунних комплексів, що зумовили розвиток нефропатії?', 'medium', 91, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Петля Генле', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочки', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піраміди', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спадний відділ канальців', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальний відділ канальців', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У водія, який потрапив у ДТП, отримав травму та знаходиться в стані шоку, спостерігається зменшення добової кількості сечі до 300 мл. Який основний патогенетичний фактор цієї зміни діурезу?', 'medium', 92, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У хворого після важкої травми розвинувся шок і з''явилися ознаки гострої ниркової недостатності. Що є провідним механізмом розвитку гострої ниркової недостатності в даному випадку?', 'medium', 93, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення відтоку сечі', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Падіння артеріального тиску', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тиску в ниркових артеріях', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення тиску в капсулі клубочка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При отруєнні етиленгліколем у пацієнта розвинулася гостра ниркова недостатність: З’явилася нудота, блювання, потьмарення свідомості, артеріальна гіпотензія, аритмія та анурія. Що спричинило зменшення клубочкової фільтрації в пацієнта?', 'medium', 94, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення гідростатнчного тиску в кубочках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення загальної площі фільтрації', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тканинного тиску в нирках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення проникності стінки клубочків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт віком 60 років звернувся до лікарки з підвищеним артеріальним тиском, який складно коригується стандартними антигіпертензивними препаратами. Під час обстеження лікарка помітила, що в пацієнта є високий рівень ендотеліальної дисфункції. Який із нижченаведених пептидів має виражену гіпотензивну дію, впливаючи на гладкі м’язи?', 'medium', 95, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Інгібітори ангіотензин-перетворювального ферменту (АПФ) широко застосовують як гіпотензивні засоби. Яку систему вазоактивних пептидів, що регулюють артеріальний тиск та водно-сольовий обмін, вони коригують?', 'medium', 96, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Унаслідок передозування вазодилятатором у пацієнта артеріальний тиск знизився до 60/40 мм рт. ст. та виник колапс. До якої патології це може призвести?', 'medium', 97, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої дихальної недостатності', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсульту', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої ниркової недостатності', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострої печінкової недостатності', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркту міокарда', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнтки віком 45 років, якій діагностовано пієлонефрит, лікар виявив стійку артеріальну гіпертензію Який механізм виникнення цього стану?', 'medium', 98, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Під час експерименту собаці змоделювали артеріальну гіпертензію шляхом звуження ниркових артерій. При цьому збільшилась активність ренін-ангіотензин-альдостеронової системи. Який компонент цієї системи викликає найсильніший пресорний ефект?', 'medium', 99, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У чоловіка 60 років під час об''єктивного обстеження виявлено набряки на ногах, асцит, збільшення печінки, що свідчить про недостатність кровообігу за правошлуночковим типом. В анамнезі вказаний перенесений ревматизм. Одним з основних факторів розвитку набряків є активація системи ренін-ангіотензин-альдостерон, яка є наслідком:', 'medium', 100, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення хвилинного об’єму серця', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліцитемічної гіперволемії', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утруднення дифузії речовин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Розширення посткапілярних вен', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацидозу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У тварини через 2 тижні після експериментального звуження ниркової артерії підвищився артеріальний тиск. З посиленням дії на судини якого чинника гуморальної регуляції це пов’язане?', 'medium', 101, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин II', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дев''ятирічного хлопчика виявлено ураження нирок та підвищенний артеріальний тиск. Підвищення рівня якого біологічно активного пептиду спричинив цей стан?', 'medium', 102, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсуліну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензину ІІ', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антидіуретичного гормона', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Калідину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагону', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У тварини через 2 тижні після експериментального звуження ниркової артерії підвищився артеріальний тиск. Зі збільшенням дії на судини якого фактора гуморальної регуляції це пов’язано?', 'medium', 103, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дофамін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин II', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Інгібітори ангіотензин-перетворювального ферменту (АПФ) широко застосовують як гіпотензивні засоби. Яку систему вазоактивних пептидів, що регулюють артеріальний тиск та водно-сольовий обмін, вони коригують?', 'medium', 104, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Обстеження пацієнта з високим артеріальним тиском показало в нього вторинну артеріальну гіпертензію. Причиною такого стану є ренін-продукуюча пухлина нирки. Що є головною ланкою в патогенезі вторинної артеріальної гіпертензії в хворого?', 'medium', 105, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнтці віком 62 років з діагнозом: артеріальна гіпертензія, призначили інгібітор ангіотензинперетворюючого ферменту. Утворення якої біологічно активної речовини зменшиться у цьому разі?', 'medium', 106, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнтці з гіпертонічною хворобою лікар призначив лозартан. Яка фармакологічна властивість цього препарату забезпечує терапевтичний ефект?', 'medium', 107, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У пацієнта виявлено високий рівень альдостерону в крові. Яка з фізіологічно активних речовин найімовірніше призвела до цього?', 'medium', 108, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ангіотензин ІІ', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'цГМФ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійуретичний фактор', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простагландин Е2', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'цАМФ', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 48-ми років на хронічний гломерулонефрит наявні набряки, АТ-210/100 мм рт.ст., ЧСС- 85/хв., межі серця розширені. Який механізм розвитку артеріальної гіпертензії є головним?', 'medium', 109, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'До серцево-судинного відділення надійшов хворий зі скаргами на постійний головний біль у потиличній ділянці, шум у вухах, запаморочення. При обстеженні: АТ-180/110 мм рт.ст., ЧСС- 95/хв. Рентгенологічно визначено звуження однієї з ниркових артерій. Активація якої з перерахованих систем викликала гіпертензивний стан хворого?', 'medium', 110, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Симпатоадреналова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кінінова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ренін-ангіотензинова', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемостатична', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Артеріальна гіпертензія у хворого обумовлена стенозом ниркових артерій. Активація якої системи є головною ланкою в патогенезі цієї форми гіпертензії?', 'medium', 111, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У пацієнта, який тривалий час вживає препарати, що блокують вироблення ангіотензину II, виникли брадикардія, порушення серцевого ритму. Можливою причиною цих розладів є:', 'medium', 112, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У людини з хронічним захворюванням нирок порушена їх видільна функція. рН венозної крові становить 7,33. Для корекції кислотно-лужного стану пацієнту доцільно внутрішньовенно ввести розчин:', 'medium', 113, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду калію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду кальцію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкози', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хлориду натрію', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Бікарбонату натрію', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В гістопрепараті представлений паренхіматозний орган, поверхневий шар кіркової речовини якого формують клубочки, утворені ендокриноцитами. Якому органу належить дана морфологічна ознака?', 'medium', 114, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфатичний вузол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щитовидна залоза', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Селезінка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Яєчник', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Наднирник', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який тривалий час приймав глюкокортикоїди, унаслідок відміни препарату виникло загострення існую чого захворювання, спостерігається зниження артеріального тиску та слабкість. З розвитком якого патологічного стану можна пов''язати ці явища?', 'medium', 115, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатністю наднирників', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукцію АКТГ', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кумуляцією', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Звиканням до лікарського засобу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сенсибілізацією', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У гістопрепараті представлено паренхіматозний орган, що має кіркову та мозкову речовину. Кіркова речовина утворена тяжами епітеліоцитів, між якими проходять кровоносні капіляри; тяжі формують три зони. Мозкова речовина складається з хромафіноцитів та венозних синусоїдів. Який орган має зазначені морфологічні ознаки?', 'medium', 116, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Щитовидна залоза', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тимус', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лімфатичний вузол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Наднирник', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час оперативного втручання на наднирниковій залозі лікар-хірург зупиняє кровотечу з a. Suprarenalis inferior. Гілкою якої артерії є a. Suprarenalis inferior?', 'medium', 117, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A.tesicularis', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'B.Aorta abdominalis', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A.renalis', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. phrenica inferior', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Truncus coeliacus', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта стався крововилив у клубочкову зону кори наднирника. Зменшення виділення якого гормону спостерігається в цьому разі?', 'medium', 118, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерону', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Норадреналіну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизолу', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Оперуючи на наднирниковій залозі, хірург зупиняє кровотечу з артерії, що відходить до наднирникової залози від черевної аорти. Назвіть цю артерію:', 'medium', 119, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. phrenica inferior', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. renalis', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. suprarenalis superior', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. suprarenalis media', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'A. Suprarenalis inferior', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 50 років, який пʼє багато води через сильну спрагу, спостерігається виражена поліурія. Глюкоза крові - 4,8 ммоль/л, у сечі глюкози та ацетону не виявлено, сеча безбарвна, питома вага — 1,002-1,004. Яка причина поліурії?', 'medium', 120, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреотоксикоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостеронізм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Недостатність антидіуретичного гормону', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулінова недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотиреоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після споживания солоної їжі в людини значно зменшилася кількість сечі. Який із нижченаведених гормонів уплинув на функцію нирок?', 'medium', 121, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АКТТ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматостатн', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антидіуретичний', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта спостерігається зниження продукції і виділення антидіуретичного гормону внаслідок пошкодження нейрогіпофізу. Які симптоми характерні для цієї патології?', 'medium', 122, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Олігурія, набряки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія, гіпостенурія, полідипсія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія, гіперстенурія, полідипсія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Олігурія, протеїнурія, гематурія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкозурія, поліурія, полідипсія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гострого експерименту собаці під наркозом увели вазопресин, унаслідок чого зменшилася кількість сечі. Як діє цей антидіуретичний гормон при його застосуванні?', 'medium', 123, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшує реабсорбцію кальцію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшує реабсорбцію води', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилює реабсорбцію натрію', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Посилює реабсорбцію води', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшує реабсорбцію кальцію', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Стресовий стан і больове відчуття у пацієнта перед візитом до стоматолога супроводжуються анурією (відсутністю сечовиділення). Це явище зумовлене збільшенням:', 'medium', 124, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Секреції вазопресину та зменшенням адреналіну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активності антиноціцептивної системи', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Секреції вазопресину та адреналіну', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Секреції адреналіну та зменшенням вазопресину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Активності парасимпатичної нервової системи', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У результаті побутової травми у пацієнта виникла значна крововтрата, що супроводжувалося зниженням артеріального тиску. Дія яких гормонів забезпечує швидке відновлення кров’яного тиску, викликаного крововтратою?', 'medium', 125, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статеві', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін, вазопресин', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з підвищеним артеріальним тиском, тремором, тахікардією, була діагностовано доброякісна пухлина мозкової речовини наднирників. Гіперсекреція якого гормону викликає таку симптоматику?', 'medium', 126, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У хворої жінки після парентерального введення гормону відбулося підвищення артеріального тиску і також підвищилися рівні глюкози та ліпідів у крові. Який гормон було введено?', 'medium', 127, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолікулін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У результаті побутової травми у пацієнта виникла значна крововтрата, що супроводжувалося зниженням артеріального тиску. Дія яких гормонів забезпечує швидке відновлення кров’яного тиску, викликаного крововтратою?', 'medium', 128, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Статеві', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін, вазопресин', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з феохромоцитомою після психічного навантаження виникає тахікардія, підвищується артеріальний тиск, з''являється різкий біль у надчеревній ділянці. У зв''язку з чим виникають ці напади?', 'medium', 129, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У ході біохімічного аналізу крові пацієнта виявлено: натрій 115 ммоль/л, хлориди 85 ммоль/л, глюкоза 6 ммоль/л, загальний білок 65 г/л. Зменшення якого показника стане наслідком цих змін?', 'medium', 130, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обʼєму циркулюючої крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Осмотичного тиску крові', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'pH крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкості осідання еритроцитів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: гіпертонічна хвороба приймає еналаприл. Який механізм дії цього гіпотензивного препарату?', 'medium', 131, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор фосфодієстерази', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор циклооксигенази', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокатор Ca2+-каналів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібітор ангіотензинперетворювального ферменту', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антагоніст ангіотензинових рецепторів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці віком 57 років призначено лікарський засіб із групи інгібіторів ангіотензинперетворювального фермента, що не зазнає метаболічних перетворень в організмі та використовується для лікування артеріальної гіпертензії на тлі діабетичної нефропатії. Який із нижченаведених препаратів було призначено?', 'medium', 132, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Раміприл', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спіронолактон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Еналаприл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Каптоприл', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лізиноприл', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт із діагнозом: гіпертонічна хвороба - приймає еналаприл. Який механізм дії цього гіпотензивного препарату?', 'medium', 133, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У хворого 48-ми років, на тлі хронічного гломерулонефриту, розвинулася стійка артеріальна гіпертензія. Вкажіть групу найбільш ефективних лікарських засобів для лікування цього пацієнта:', 'medium', 134, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У пацієнта віком 50 років після резекції шлунка посилилися процеси гниття білків у кишечнику. Підвищення якого показника в сечі вказує на цей стан?', 'medium', 135, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечової кислоти', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Оксипроліну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тваринного індикану', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеркобіліногену', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на жовтяницю у крові підвищений вміст прямого білірубіну та жовчних кислот; у сечі відсутній стеркобіліноген. При якій жовтяниці можлива наявність цих ознак?', 'medium', 136, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Надпечінкова', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Печінкова', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Механічна', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемолітична', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паренхіматозна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому з прогресуючою м’язовою дистрофією було проведено біохімічне дослідження сечі. Поява якої речовини у великій кількості в сечі може підтвердити захворювання м’язів у даного хворого?', 'medium', 137, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпурова кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порфірини', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В відділення травматології доставлений хворий з розчавленням м''язової тканини. Який біохімічний показник сечі при цьому буде збільшений?', 'medium', 138, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкоза', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінеральні солі', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальні ліпіди', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта порушена функція нирок. Для перевірки стану фільтраційної здатності нирок йому призначено визначення кліренсу:', 'medium', 139, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрокарбонату', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Індолу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глутаміну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечової кислоти', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка має виражену прогресивну м''язову дистрофію. Назвіть показники азотного обміну в сечі, які характерні для такого стану:', 'medium', 140, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амонійні солі', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловікові, у якого є підозра на прогресуючу м’язову дистрофію, було зроблено аналіз сечі. Яка сполука в сечі підтверджує діагноз цього пацієнта?', 'medium', 141, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порфирін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатин', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міоглобін', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Колаген', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому з прогресуючою м’язовою дистрофією було проведено біохімічне дослідження сечі. Поява якої речовини у великій кількості в сечі може підтвердити захворювання м’язів у даного хворого?', 'medium', 142, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатин', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порфірини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпурова кислота', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До відділення травматології надійшов хворий із значним пошкодженням м’язової тканини. Який біохімічний показник сечі буде збільшений при цьому?', 'medium', 143, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Загальні ліпіди', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкоза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мінеральні солі', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Стан вагітної жінки ускладнився гестозом. Під час лабораторного обстеження виявлено кетонурію. Яка речовина з''явилася в сечі пацієнтки?', 'medium', 144, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лактат', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піруват', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетоацетат', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Урати', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта виявлено гострий гломерулонефрит. Поява якої речовини в сечі свідчить про ушкодження базальної мембрани капілярів клубочків нирок у разі цієї патології?', 'medium', 145, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоцитів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '17-кетостероїдів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкози р', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатину', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Стан вагітної жінки ускладнився токсикозом. Під час лабораторного обстеження виявлено кетонурію. Яка речовина зʼявилася в сечі пацієнтки?', 'medium', 146, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лактат', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піруват', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Урати', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ацетоацетат', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 36-ти років страждає на колагеноз. Збільшення вмісту якого метаболіту найбільш вірогідно буде встановлено у сечі?', 'medium', 147, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Пацієнт 64-х років має гостру серцеву недостатність, артеріальний тиск - 80/60 мм рт.ст., добовий діурез - 530 мл, істотно збільшену концентрацію сечовини та креатиніну в крові. Назвіть патогенетичний механізм розвитку азотемії та олігоурії:', 'medium', 148, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення продукції вазопресину', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення фільтраційного тиску в нирках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спазм приносних артеріол клубочка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпернатріємія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення об’єму циркулюючої крові', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В сечі новонародженого визначається цитрулін та високий рівень аміаку. Вкажіть, утворення якої речовини, найімовірніше, порушене у цього малюка:', 'medium', 149, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміак', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На основі лабораторного аналізу у хворого підтверджено діагноз - подагра. Для встановлення діагнозу було проведено визначення вмісту:', 'medium', 150, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Залишкового азоту в крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечової кислоти в крові та сечі', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовини в крові та сечі', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміаку в сечі', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатиніну в сечі', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта цироз печінки. Дослідження якої з перелічених речовин, що екскретуються з сечею, може характеризувати стан антитоксичної функції печінки?', 'medium', 151, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амінокислоти', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амонійні солі', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпурова кислота', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта цироз печінки. Дослідження якої з перелічених речовин, що екскретуються з сечею, може характеризувати стан антитоксичної функції печінки?', 'medium', 152, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амонійні солі', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпурова кислота', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амінокислоти', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Провідними симптомами первинного гіперпаратиреозу є остеопороз та ураження нирок із розвитком сечокам''яної хвороби. Які речовини складають основу каменів під час цього захворювання?', 'medium', 153, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фосфат кальцію', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цистин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У разі спадкового дефекту ферментів синтезу гема хворий має підвищену чутливість шкіри до сонячного світла, сечу червоного кольору. Накопичення яких метаболітів обміну гемоглобіну викликає ці симптоми?', 'medium', 154, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубіну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уробіліногенів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порфіриногенів', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезобіліногенів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеркобіліногенів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 20-ти років з жовтяницею встановлено: підвищення у плазмі крові вмісту загального білірубіну за рахунок непрямого (вільного), в калі та сечі - високий вміст стеркобіліну, рівень прямого (зв’язаного) білірубіну в плазмі крові в межах норми. Про який вид жовтяниці можна думати?', 'medium', 155, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемолітична', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паренхіматозна (печінкова)', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Механічна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовтяниця немовлят', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хвороба Жильбера', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 28 років потрапила до інфекційної лікарні з приводу пожовтіння шкіри, склер, слизових оболонок. Лабораторно встановлено підвищення рівня прямого білірубіну в крові. У сечі виявлені уробіліноген і білірубін. Для якого з наведених захворювань характерні такі зміни?', 'medium', 156, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз нирки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт нирки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Механічна жовтяниця', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паренхіматозна жовтяниця', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемолітична жовтяниця', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка, у якого яскраво виражена жовтушність шкіри, склер та слизових оболонок, сеча має колір темного пива, кал ахолічний. У крові виявлено підвищений вміст прямого білірубіну. У сечі - білірубін. Який тип жовтяниці у пацієнта?', 'medium', 157, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Екскреційна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Обтураційна', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паренхіматозна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кон''югаційна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемолітична', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт звернувся до лікаря зі скаргами на задишку, що виникала після фізичного навантаження. Клінічне обстеження виявило анемію та наявність парапротеїну в зоні гамма-глобулінів. Який показник у сечі необхідно визначити для підтвердження діагнозу мієломи?', 'medium', 158, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гемоглобін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білок Бенс-Джонса', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Антитрипсин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Церулоплазмін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта камінь загальної жовчної протоки перекрив надходження жовчі до кишечника. Зниження якого пігменту в сечі при цьому буде спостерігається?', 'medium', 159, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некон’югованого білірубіну', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уробіліну', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кон’югованого білірубіну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білівердину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеркобіліну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, '52-річну пацієнтку протягом останніх декількох днів турбують напади болю в правому підребер''ї після прийому жирної їжі. Візуально визначається пожовтіння склер і шкіри, ахолічний кал, сеча "кольору пива"? Присутність якої речовини в сечі пацієнтки зумовило темний колір сечі при обтураційній жовтяниці?', 'medium', 160, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубінглюкуронідів', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кетонових тел', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уробіліну', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стеркобіліну', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкози', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При аналізі крові у хворого залишковий азот склав 48 ммоль/л, сечовина 15,3 ммоль/л. Про захворювання якого органу свідчать результати цього аналізу?', 'medium', 161, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирки', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Селезінка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кишечник', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Печінка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Шлунок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого на подагру виявлено значне підвищення рівня сечової кислоти в крові. Кінцевим продуктом обміну яких речовин є сечова кислота?', 'medium', 162, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жирних кислот', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глобулінів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тригліцеридів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пуринових основ', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альбумінів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Яка сполука є кінцевим продуктом катаболізму пуринових нуклеотидів у людини?', 'medium', 163, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоксантин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ксантин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пурин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алантоїн', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 55-ти років, що скаржиться на біль в ділянці нирок, надійшов в лікарню. В ході ультразвукового обстеження пацієнта виявлено наявність ниркових каменів. Наявність в сечі якої з наведених речовин є найбільш імовірною причиною утворення каменів уданого пацієнта?', 'medium', 164, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатинін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білівердин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уробілін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 65-ти років, який страждає на подагру, скаржиться на біль в ділянці нирок. При ультразвуковому обстеженні встановлена наявність ниркових каменів. Підвищення концентрації якої речовини є найбільш вірогідною причиною утворення каменів у даному випадку?', 'medium', 165, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цистин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечова кислота', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сечовина', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білірубін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Холестерин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, '43-річний хворий надійшов в нефрологічне відділення з масивними набряками. Два роки лікувався амбулаторно, при цьому постійно відзначався підвищений артеріальний тиск. Двічі лікувався преднізолоном, з позитивним ефектом. У сечі: відносна щільність - 1017, білок - 4,0 г/л, еритроцити - 15-18 в полі зору (вилужені), лейкоцити - 5-7 в полі зору. Яка переважно функція нирок порушена у хворого?', 'medium', 166, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інкреторна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Секреторна', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Концентраційна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фільтраційна', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Реабсорбційна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого в обох щелепах рентгенологічно виявлено численні дефекти у вигляді гладкостінних округлих отворів. При гістологічному дослідженні - явища остеолізису і остеопорозу при явищах слабкого кісткоутворення. В сечі хворого знайдено білок Бенс-Джонса. Назвіть захворювання:', 'medium', 167, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий мієлолейкоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мієломна хвороба', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий недиференційований лейкоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний мієлолейкоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний еритромієлоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У фізично здорових молодих курсантів після важкого фізичного навантаження при одноденному пішому переході на 50 км в сечі виявлено білок, рівень якого в середньому не перевищував 1 г/л. Який різновид протеїнурії мав місце?', 'medium', 168, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аліментарна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Маршова', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Органічна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Несправжня', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дегідратаційна', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 62 років скаржиться на частий біль у ділянці грудної клітки та хребта, переломи ребер. Лікар припустив мієломну хворобу (плазмоцитому). Який з перерахованих нижче лабораторних показників буде мати найбільше діагностичне значення?', 'medium', 169, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопротеїнемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпогло6улінємія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперальбумінемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парапротеїнемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Внаслідок захворювання нирок у пацієнта відзначаються набряки. В аналізах сечі визначається масивна протеїнурія. Який механізм є основним у виникненні набряків у такого пацієнта?', 'medium', 170, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску плазми крові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску тканин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску лімфи', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення осмотичного тиску плазми крові', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження фільтраційного тиску в нирках', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 55-ти років хворіє на хронічний гломерулонефрит протягом 15-ти років. Які зміни складу крові або сечі найбільш характерно свідчать про обмеження секреторної функції нирок?', 'medium', 171, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопротеїнемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпо-, ізостенурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперглікемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперазотемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 24 років через півтори тижні після важкої стрептококової ангіни проявилася набряклість обличчя, підвищився артеріальний тиск. Гематурія і протеїнурія 1,2 г / л. У крові виявлено антистрептококові антитіла і зниження компонентів комплементу. У мікросудинах яких структур найбільш імовірна локалізація скупчень імунних комплексів, що зумовили розвиток нефропатії?', 'medium', 172, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Петля Генле', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клубочки', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піраміди', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Спадний відділ канальців', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Проксимальний відділ канальців', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При патології нирок в сечі з''являються патологічні складові частини. Поява яких патологічних складових частин сечі свідчить про підвищення проникності клубочкової мембрани?', 'medium', 173, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Алкаптонурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкозурія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аміноацидурія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, '3 роки тому хворій 34 років було встановлено діагноз хронічного гломерулонефриту. За останні 6 місяців з’явилися набряки. Що лежить в основі їх розвитку?', 'medium', 174, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперосмолярність плазми', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперальдостеронізм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення білковоутворюючої функції печінки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція вазопресину', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У юнака 20-ти років, через 2 тижні після перенесеної лакунарної ангіни, з’явилися скарги на загальну слабкість, набряки під очима. Після обстеження хворому встановлено діагноз: гострий гломерулонефрит. Які патологічні зміни в складі сечі найбільш вірогідні?', 'medium', 175, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Наявність свіжих еритроцитів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піурія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циліндрурія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Натрійурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворій 34 років 3 роки тому було встановлено діагноз гломерулонефриту. За останні 6 місяців з''явилися набряки. Що лежить в основі їх розвитку?', 'medium', 176, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперальдостеронізм', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення білковоутворюючої функції печінки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперосмолярність плазми', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперпродукція вазопресину', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 30 років, який шпиталізований із діагнозом: гострий гломерулонефрит – спостерігалася протеїнурія. Яке порушення спричинило це явище?', 'medium', 177, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску на стінку капілярів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникності клубочкової мембрани', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження кількості нефронів,що функціонують', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Затримка виведення продуктів азотистого обміну', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У людини вміст глюкози в крові 15 ммоль/л (поріг реабсорбції - 10 ммоль/л). Наслідком цього буде:', 'medium', 178, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення реабсорбції глюкози', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення секреції альдостерону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення секреції вазопресину', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення діурезу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкозурія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого нефритом виявлена глюкозурія і аміноацидурія. Порушення якого механізму реабсорбції глюкози і амінокислот є причиною цього?', 'medium', 179, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинного Na+ - залежного транспорту', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фагоцитозу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинного активного транспорту', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Піноцитозу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Простої дифузії', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 46-ти років скаржиться на сухість в роті, спрагу, часте сечовипускання, загальну слабкість. У крові: гіперглікемія, гіперкетонемія. У сечі: глюкоза, кетонові тіла. На ЕКГ: дифузні зміни в міокарді. Який найбільш імовірний діагноз?', 'medium', 180, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аліментарна гіперглікемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нецукровий діабет', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Немічна хвороба серця', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цукровий діабет', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий панкреатит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині виявлено, що нирки збільшені в розмірах, поверхня крупногорбиста за рахунок наявності численних порожнин з гладенькою стінкою, заповнених прозорою рідиною. Яке захворювання нирок мало місце у хворого?', 'medium', 181, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Полікістоз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інфаркт', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловікам віком 72 роки, який помер від ускладнень гіпертонічної хвороби, виявлено маленькі, щільні нирки з дрібнозернистою поверхнею, паренхіма та коркова речовина атрофічні. Укажіть морфологічну назву цих нирок?', 'medium', 182, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинно-зморщені', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Агенезія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинно-зморщені', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефротично-зморщені', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдно-зморщені', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На аутопсії хворого, померлого від отруєння етиленгліколем, нирки дещо збільшені у розмірах, набряклі, їх капсула знімається дуже легко, кіркова речовина широка, блідо-сіра, мозкова речовина - темно-червона. Яка патологія нирок розвинулась у хворого?', 'medium', 183, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдний нефроз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий тубуло-інтерстиціальний нефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При розтині тіла чоловіка, померлого від опікової хвороби, знайдено набряк головного мозку, збільшення печінки, а також нирок, кірковий шар яких широкий, блідо-сірий, мозковий - повнокровний. Мікроскопічно: некроз епітелію канальців головних відділів з деструкцією базальних мембран, набряк інтерстицію з лейкоцитарною інфільтрацією та крововиливами. Який з перелічених діагнозів найбільш імовірний?', 'medium', 184, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулоінтерстиціальний нефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мієломна нирка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Подагрична нирка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого, який знаходиться у клініці з ознаками отруєння ртуттю, у нирках відмічаються наступні процеси: вогнищеві некротичні зміни канальців головних відділів, набряк, лейкоцитарна інфільтрація та геморагії інтерстицію, венозний застій. Який стан розвився у хворого?', 'medium', 185, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий некротичний нефроз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічна ниркова недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта, який отримав множинні травми під час ДТП, розвинувся шок із гострою нирковою недостатністю, у результаті чого він помер. Під час розтину тіла виявлено: обидві нирки збільшені в розмірах та набряклі; корковий шар блідо-сірий, мозковий - темно-червоний. Який патологічний процес спричинив ниркову недостатність?', 'medium', 186, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідронефроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла померлої півторарічної дитини виявлено: геморагічні висипання на шкірі, помірна гіперемія та набряк слизової носоглотки, дрібні крововиливи в слизових оболонках і внутрішніх органах, різкі дистрофічні зміни в печінці, міокарді, гострий некротичний нефроз, масивні крововиливи в наднирниках. Для якого захворювання характерні ці симптоматичні явища?', 'medium', 187, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Висипний тиф', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кір', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифтерія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Скарлатина', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Менінгококова інфекція', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину трупа дівчинки 12-ти років виявлено: множинні крововиливи у шкірі (переважно сідниць, нижніх кінцівок), серозних та слизових оболонок, у головному мозку. У наднирниках вогнищевий некроз та масивні крововиливи, у нирках - некротичний нефроз, гнійний артрит, іридоцикліт, васкуліт. Який найбільш вірогідний діагноз?', 'medium', 188, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Променева хвороба', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Системний червоний вівчак', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Менінгококцемія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вузликовий періартеріїт', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Висипний тиф', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дівчинки 12 років при розтині виявлені множинні крововиливи в шкірі (переважно сідниць, нижніх кінцівок), серозних і слизових оболонках, в головному мозку. У надниркових залозах - вогнищевий некроз і масивні крововиливи, в нирках - некротичний нефроз, гнійний артрит, іридоцикліт, васкуліт. Який найбільш ймовірний діагноз?', 'medium', 189, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У хворого підвищений вміст глюкози в крові; є цукор в сечі. Під час пункційної біопсії нирки виявлено: розширення мезангія з осередковим накопиченням мембраноподібної речовини з перигломерулярним склерозом деяких клубочків, гіаліноз та плазматичне просякання артеріол, лімфогістіоцитарна інфільтрація строми з наявністю поліморфноядерних лейкоцитів; глікогенна інфільтрація нефроцитів вузького сегмента. Який найбільш вірогідний діагноз?', 'medium', 190, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підгострий гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діабетичний гломерулосклероз', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла жінки віком 35 років виявлено: нирки збільшені з гладкою поверхнею, строкаті за рахунок чергування світлих ділянок із вогнищами петехіальних крововиливів. Мікроскопічно спостерігається: у клубочках окремі судинні петлі в стані фібриноїдного некрозу, базальні мембрани капілярів потовщені, мають вигляд «дротяних петель», у просвітах деяких капілярів містяться гіалінові тромби. Для якого захворювання характерні ці зміни?', 'medium', 191, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діабетичний гломерулосклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкопрогресуючий гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вовчаковий нефрит', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Постінфекційний гломерулонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка віком 60 років, який довгий час хворів на гіпертонічну хворобу і помер від хронічної ниркової недостатності, під час аутопсії виявлено: обидві дві нирки значно зменшені у розмірах, їхня поверхня дрібно-зерниста, гістологічно - більшість клубочків гіалінізовано, частина склерозовані, окремі гіперплазовані. У стромі поля склерозу, артеріоло- та артеріосклероз, еластофіброз великих гілок ниркових артерій. Укажіть виявлені зміни нирок.', 'medium', 192, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріолосклеротичний нефросклероз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклеротичний нефросклероз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинно зморщена нирка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 65 років зі встановленим діагнозом: фіброзно-кавернозний туберкульоз легень помер від хронічної легенево-серцевої недостатності. Протягом останніх місяців спостерігалася виражена протеїнурія. На розтині нирки збільшені, щільні, восковидні на поверхні і всередині. Які зміни в нирках при цій формі туберкульозу могли викликати протеїнурію?', 'medium', 193, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефролітіаз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Туберкульоз нирок', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла чоловіка, який хворів на фіброзно-кавернозний туберкульоз і помер від ниркової недостатності, виявлені збільшені в розмірах нирки, щільні на дотик, сіруватого кольору, на розрізі мають сальний вигляд. Який діагноз можна припустити?', 'medium', 194, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефросклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мієломна нирка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлоневрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий, що страждав хронічним гнійним остеомієлітом, помер від хронічної ниркової недостатності. При розтині виявлено великі щільні нирки біло-жовтого кольору з сальним блиском на зрізі. Який найбільш вірогідний діагноз?', 'medium', 195, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підгострий гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий некротичний нефроз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Септичний нефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час проведення аутопсії жінки віком 58 років, яка хворіла на цукровий діабет, при гістологічному дослідженні нирок виявлено у клубочках сегментарні гомогенні оксифільні відкладення, стінки артеріол дифузно потовщені, гомогенні, оксифільні. Який патологічний стан виник у клубочках і судинах нирок?', 'medium', 196, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мукоїдне набухання', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліноз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліново-крапельна дистрофія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібриноїдне набухання', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії чоловіка віком 60 років, який тривалий час хворів на фіброзно-кавернозний туберкульоз легень, виявлено збільшені у розмірах нирки масою по 180 гр кожна. Тканина нирок щільна, біло-сіра, з «сальним» блиском. Під час гістологічного дослідження у клубочках нирки та у стінці окремих артерій малого калібру виявлено гомогенні оксифільні маси, які під час забарвлення за конго-червоним зафарбувались у червоно-оранжевий колір. Які морфологічні зміни спостерігаються у нирках?', 'medium', 197, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Старечий амілоїдоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіопатичний амілоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Локальний пухлиноподібний амілоїдоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний гіаліноз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка протягом 8 років хворіла на туберкульоз, померла в стаціонарі при ознаках хронічної ниркової недостатності. На розтині – нирки збільшені, поверхня розрізу має сальний вигляд; гістологічно виявлено масивні відкладання безструктурних гомогенних еозинофільних мас, при забарвленні Конго-рот спостерігається їх виражена метахромазія. Який патологічний процес розвинувся у нирках?', 'medium', 198, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Токсичний нефрит на фоні антибіотикотерапії', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефросклероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гематогенний туберкульоз нирок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На аутопсії тіла жінки, яка хворіла на хронічну дизентерію, під час гістологічного дослідження внутрішніх органів у стромі та паренхімі міокарда, нирок, у слизовій оболонці шлунка та в сполучній тканині легень виявлені аморфні відкладення фіолетового кольору, що дають позитивну реакцію за Коссом. Яке ускладнення розвинулося у хворої?', 'medium', 199, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дистрофічне звапнення', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаболічне звапніння', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метастатичне звапнення', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіаліноз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У 35-річного наркомана, який тривало хворів на фіброзно-кавернозний туберкульоз легень, під час патологоана- томічного дослідження встановлено, що нирки та селезінка збільшені в розмірах, щільної консистенції, на розрізі тканина із сірим відтінком та ''сальним” блиском. Мікроскопічно вичвлено в білій та червоній пульпі селезінки, у інтерстиції та мезангіумі клубочків нирок депозити Конго-рот-позитивних мас. Діагностуйте вид ураження внутрішніх органів:', 'medium', 200, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Старечий амілоїдоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіопатичний амілоїдоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний гіаліноз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Локальний пухлиноподібний амілоїдоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Молодий чоловік 19-ти років страждав з раннього дитинства на бронхоектатичну хворобу, помер від ниркової недостатності. На розтині окрім множинних бронхоектатичних каверн, заповнених гнійним ексудатом, виявлено збільшені в розмірах нирки щільної консистенції, кірковий шар потовщений, білого кольору, щільний. Піраміди нирки анемічні, чіткі. Назвіть процес, який розвинувся в нирках:', 'medium', 201, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вроджений кістоз нирок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний нефросклероз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині тіла померлого від ниркової недостатності, який протягом останніх 5-ти років хворів на бронхоектатичну хворобу, виявлені збільшені в розмірах нирки щільної консистенції з потовщеним кірковим шаром білого кольору та сальним блиском. Про яке захворювання нирок можна думати?', 'medium', 202, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 40-а років протягом 10 років після перелому великогомілкової кістки страждав на хронічний остеомієліт. Три роки тому з’явився нефротичний синдром. Смерть настала від уремії. На секції: нирки щільні, білі, з рубцями в кірковому шарі на розрізі з сальним блиском. Яка патологія нирок розвинулася?', 'medium', 203, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний амілоїдоз', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинний амілоїдоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ідіопатичний амілоїдоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 45-ти років, що лікувався від застудного захворювання великими дозами парацетамолу, з''явилися симптоми олігурії, азотемії. Через 5 днів настала смерть при явищах ГНН. При гістологічному дослідженні нирок виявлений дифузний набряк проміжної тканини мозкового шару нирок, його інфільтрація лімфоцитами, еозинофілами, окремими нейтрофілами, руйнування епітелію канальців, клубочки мало змінені. Найбільш імовірний тип ураження нирок:', 'medium', 204, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некронефроз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулоінтерстиційний нефрит', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротичний синдром', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На розтині виявлено зменшені в розмірах нирки, вага 50,0 г, їх поверхня дрібнозерниста, кора рівномірно стоншена. Під час мікроскопічного дослідження спостерігається: стінки артеріол значно потовщені внаслідок відкладення в них гомогенних безструктурних рожевого кольору мас, просвіт їх різко звужений, клубочки зменшені, склерозовані, канальці атрофічні. Для якого захворювання характерні описані зміни?', 'medium', 205, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий некротичний нефроз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит зі зморщуванням нирок', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертонічна хвороба', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При пункційній біопсії в трансплантованій нирці виявлена дифузна інфільтрація строми лімфоцитами, плазмоцитами, лімфобластами, плазмобластами, а також некротичний артеріїт. Який патологічний процес розвинувся у трансплантаті?', 'medium', 206, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемічне пошкодження нирки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунне відторгнення', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулонекроз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При мікроскопічному дослідженні нирок померлої від ниркової недостатності жінки 36-ти років, в клубочках виявлено проліферацію нефротелію капсули, подоцитів та макрофагів з утворенням "півмісяців", некроз капілярних петель, фібринові тромби в їх просвітах, а також склероз та гіаліноз клубочків, атрофію канальців та фіброз строми нирок. Який з перелічених діагнозів найбільш вірогідний?', 'medium', 207, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підгострий гломерулонефрит', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фокальний сегментарний склероз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мембранозна нефропатія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 15 років через 14 днів після перенесеного гострого тонзиліту з''явилися набряки на обличчі зранку, підвищення артеріального тиску. Імуногістохімічне дослідження біоптату нирки виявило відкладання імунних комплексів на базальних мембранах капілярів та у мезангії клубочків. Яке захворювання розвинулося у пацієнта?', 'medium', 208, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий інтерстиціальний нефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдний нефроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 28-ми років відзначалися підвищення артеріального тиску, гематурія та набряки на обличчі. Незважаючи на лікування, наростали явища ниркової недостатності. Через 6 місяців хворий помер від уремії. Мікроскопічно при дослідженні нирок у клубочках виявлена проліферація нефротелію капсули, подоцитів з утворенням "півмісяців", склероз та гіаліноз клубочків. Який найбільш вірогідний діагноз?', 'medium', 209, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підгострий гломерулонефрит', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротичний синдром', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта виявлено гострий гломерулонефрит. Поява якої речовини в сечі свідчить про ушкодження базальної мембрани капілярів клубочків нирок у разі цієї патології?', 'medium', 210, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоцитів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '17-кетостероїдів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкози р', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Креатину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білка', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після введення великої дози антитіл до базальної мембрани клубочків нирок у піддослідної тварини розвинувся гострий гломерулонефрит. Який вид алергічної реакції, за класифікацією Кумбса і Джелла, лежить в основі цієї патології?', 'medium', 211, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунокомплексний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитотоксичний', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперчутливість сповільненого типу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактичний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулювальний', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтці у якої наявні протеїнурія, гематурія, набряки й артеріальна гіпертензія, поставлено діагноз: гострий гломерулонефрит. Назвіть алергічні реакції за Кумбсом і Джеллом, які у 80% випадків є причиною гломерулонефриту.', 'medium', 212, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактичні', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперчутливості сповільненого типу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитотоксичні', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулювального типу', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунокомплексні', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У десятирічної дитини за два тижні після перенесеної ангіни зʼявився біль на ділянці нирок, незначні набряки, розвинувся сечовий синдром. Проведено нефробіопсію та мікроскопічно виявлено інтракапілярне проліферативне запалення. Під час електронної мікроскопії виявлено великі електронно-щільні субепітеліальні депозити (<<горби>>). Яке захворювання розвинулося у дитини?', 'medium', 213, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдний нефроз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит, що швидко прогресує', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Постінфекційний гломерулонефрит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гнійний проміжний нефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мембранозний гломерулонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 30 років скаржиться на слабкість, жагу, головний біль та біль у попереку. Місяць тому перехворів бактеріальним тонзилітом. На обличчі набряки. Пульс - 84/хв, АТ - 175/100 мм рт. ст. В загальному аналізі сечі: еритроцити - 40-52 в полі зору, лейкоцити - 1-2 в полі зору, білок - 4 г/л. Встановлено діагноз: гострий дифузний гломерулонефрит. Який основний механізм ураження нирок у цього пацієнта?', 'medium', 214, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення уродинаміки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення гемодинаміки в нирках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження канальців', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пряме пошкодження клубочків мікроорганізмами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунне пошкодження клубочків', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарні госпіталізовано потерпілого під час ДТП з артеріальним тиском 70/40 мм рт. ст. Пацієнт без свідомості. Добовий діурез близько 550 мл. Яке порушення функції нирок розвинулося у чоловіка?', 'medium', 215, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічна ниркова недостатність', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулопатія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий дифузний гломерулонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра ниркова недостатність', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого після автомобільної травми артеріальний тиск - 70/40 мм рт. ст. Хворий у непритомному стані. За добу виділяє близько 550 мл сечі. Яке порушення функції нирок спостерігається у хворого?', 'medium', 216, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулопатія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра ниркова недостатність', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічна ниркова недостатність', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий дифузний гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 25-ти років діагностований гострий дифузний гломерулонефрит. З анамнезу: за 18 днів до прояву хвороби переніс ангіну. Який механізм ураження ниркових клубочків буде спостерігатися у цьому випадку?', 'medium', 217, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунний', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротоксичний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемічний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Медикаментозний', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 36-ти років після перенесеної стрептококової інфекції діагностовано гострий гломерулонефрит. Найбільш імовірно, що ураження базальної мембрани ниркових тілець виникає внаслідок алергічної реакції такого типу:', 'medium', 218, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитотоксична', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сповільнена', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулююча', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунокомплексна', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактична', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Після перенесеної стрептококової інфекції у чоловіка діагностовано гострий гломерулонефрит. Найбільш імовірно, що ураження базальної мембрани ниркових тілець виникає внаслідок алергічної реакції такого типу:', 'medium', 219, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анафілактична', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сповільнена', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунокомплексна', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимулююча', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Цитотоксична', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'При мікроскопічному дослідженні нефробіоптата виявлено наявність півмісяців більш ніж в 50% клубочків, капілярні петлі некротизовані, в просвіті їх виявлено фібринові тромби, виражений тубуло-інтерстиціальний компонент. Про яке захворювання нирок слід думати?', 'medium', 220, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Некротичний нефроз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амилоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдний нефроз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкопрогресуючий гломерулонефрит', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У молодої особи впродовж року прогресувала ниркова недостатність зі смертельним наслідком. При розтині тіла виявлені великі строкаті нирки з червоними дрібними краплинами в жовто-сірому корковому шарі. Гістологічно в клубочках виявлені «півмісяці» з проліферуючого нефротелія. Який найбільш імовірний діагноз?', 'medium', 221, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рак нирки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крововилив в нирки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гнійний нефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Швидкопрогресуючий гломерулонефрит', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 62 роки помер від хронічної ниркової недостатності. На секції виявлено: нирки зменшені, щільної консистенції, фіброзна капсула знімається важко, поверхня зерниста, коркова речовина витончена. Гістологічно - в частині клубочків проліферація ендотеліальних та мезангіальних клітин, потовщення мембран капілярів клубочків, деякі клубочки слерозовані та гіалізовані. В стромі нечисленні лімфоїдні інфільтрати. Який імовірний діагноз?', 'medium', 222, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклеротично зморщена нирка', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий екстракапілярний ексудативний гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріолосклеротичний нефросклероз (первинно зморщена нирка)', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла чоловіка віком 46 років виявлено: нирки зменшені в розмірі, масою 75 г, щільної консистенції, поверхня дрібнозерниста. З анамнезу відомо, що чоловік хворів на хронічний гломерулонефрит. Як називається описана макроскопічна картина нирок?', 'medium', 223, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріонефросклероз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинно зморщені нирки', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїднозморщені нирки', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинно зморщені нирки', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефритично зморщені нирки', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнт віком 32 роки впродовж чотирьох років хворіє на хронічний гломерулонефрит. Шпиталізований із ознаками анасарки: АТ - 185/105 мм рт. ст. В аналізі крові виявлено: гемоглобін - 110 г/л, еритроцити - 2,6*10^12/л, лейкоцити - 9,5*10^ 9/л, залишковий азот - 32 ммоль/л, загальний білок - 50 г/л. Яка зміна з найбільшою вірогідністю вказує на гломерулонефрит із нефротичним синдромом?', 'medium', 224, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейкоцитоз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анасарка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопротеїнемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперазотемія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта діагностовано хронічний гломерулонефрит. Унаслідок значних склеротичних змін маса функціональних нефронів зменшилася до 10%. Яке з нижченаведених порушень лежить в основі наростаючого уремічного синдрому?', 'medium', 225, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Азотемія', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення осмотичного гемостазу', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення водного гемостазу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Артеріальна гіпертензія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ниркова остеодистрофія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 50 років з діагнозом: хронічний дифузний гломерулонефрит, розвинулась ниркова недостатність. Які зміни в лабораторних показниках свідчать про порушення концентраційної функції нирок?', 'medium', 226, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Циліндрурія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперсульфатемія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпо- та ізостенурія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперазотемія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гематурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік 32-х років чотири роки страждає на хронічний гломерулонефрит з нефротичним синдромом. Відзначаються набряки на обличчі, в останній час з’явилися набряки на ногах та тулубі. Який із нижченаведених механізмів найхарактерніший для розвитку набряку у чоловіка?', 'medium', 227, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску крові в капілярах', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення онкотичного тиску тканинної рідини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Утруднення лімфовідтоку', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення проникливості капілярів', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта з діагнозом: хронічний дифузний гломерулонефрит, розвинулася хронічна ниркова недостатність. На термінальній стадії ХНН розвивається оліго- та анурія, що спричиняється:', 'medium', 228, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дисемінованим внутрішньосудинним зсіданням крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ішемією коркової речовини нирок унаслідок спазму судин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням реабсорбції води в дистальних канальцях', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниженням кількості функціонуючих нефронів', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням фільтраційного тиску та фільтрації', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час розтину тіла чоловіка 56 років, який тривалий час хворів на хронічний гломерулонефрит, на поверхні епікарда і перикарда виявили сірувато-білуваті ворсинчасті нашарування («волосате» серце). Про який патологічний процес йдеться?', 'medium', 229, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Жінка 49 років тривалий час хворіла на хронічний гломерулонефрит, унаслідок чого настала смерть. На розтині встановлено, що нирки мають розміри 7x3x2,5 см, масу 65,0 г, щільні, дрібнозернисті. Також виявлено фібринозне запалення серозних і слизових оболонок, дистрофічні зміни паренхіматозних органів, набряк головного мозку. Яке ускладнення призвело до вказаних змін серозних оболонок і внутрішніх органів?', 'medium', 230, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тромбоцитопенія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Уремія', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'ДВЗ-синдром', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Анемія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сепсис', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 55-ти років хворіє на хронічний гломерулонефрит протягом 15-ти років. Які зміни складу крові або сечі найбільш характерно свідчать про обмеження секреторної функції нирок?', 'medium', 231, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопротеїнемія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпо-, ізостенурія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперглікемія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіперазотемія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Протеїнурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого 48-ми років на хронічний гломерулонефрит наявні набряки, АТ-210/100 мм рт.ст., ЧСС- 85/хв., межі серця розширені. Який механізм розвитку артеріальної гіпертензії є головним?', 'medium', 232, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У добовій сечі хворого знайдені вилужені еритроцити. Для якої патології нирок найбільш притаманний виявлений симптом?', 'medium', 233, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротичний синдром', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дифузний гломерулонефрит', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пієлонефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гостра ниркова недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нирковокам’яна хвороба', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Чоловік віком 30 років скаржиться на слабкість, жагу, головний біль та біль у попереку. Місяць тому перехворів бактеріальним тонзилітом. На обличчі набряки. Пульс - 84/хв, АТ - 175/100 мм рт. ст. В загальному аналізі сечі: еритроцити - 40-52 в полі зору, лейкоцити - 1-2 в полі зору, білок - 4 г/л. Встановлено діагноз: гострий дифузний гломерулонефрит. Який основний механізм ураження нирок у цього пацієнта?', 'medium', 234, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення уродинаміки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Порушення гемодинаміки в нирках', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пошкодження канальців', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пряме пошкодження клубочків мікроорганізмами', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Імунне пошкодження клубочків', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У десятирічної дитини за два тижні після перенесеної ангіни зʼявився біль на ділянці нирок, незначні набряки, розвинувся сечовий синдром. Проведено нефробіопсію та мікроскопічно виявлено інтракапілярне проліферативне запалення. Під час електронної мікроскопії виявлено великі електронно-щільні субепітеліальні депозити (<<горби>>). Яке захворювання розвинулося у дитини?', 'medium', 235, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ліпоїдний нефроз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит, що швидко прогресує', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Постінфекційний гломерулонефрит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гнійний проміжний нефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мембранозний гломерулонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла померлої жінки виявлено, що права нирка збільшена в розмірі, порожнини мисок розширені, заповнені каламутним умістом. Під час гістологічного дослідження ниркової тканини виявлено: вогнища інфільтрації нейтрофілами, гіперемія мисок, набряк і запальна інфільтрація інтерстицію. Який найімовірніший діагноз?', 'medium', 236, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефролітіаз', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження нирки виявлено. що вона набрякла, повнокровна, капсула легко знімається, порожнини мисок і чашечок розширені, заповнені каламутною сечею, їх слизова оболонка тьмяна, з вогнищами крововиливів. На розрізі тканина нирки строката, жовто-сірі ділянки оточені зоною повнокрів''я і геморагій. Якому захворюванню відповідає такий макроскопічний вид нирки?', 'medium', 237, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдоз нирок', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефролітіаз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Полікістоз нирок', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворому поставлений діагноз: гострий пієлонефрит із запаленням стінок ниркових чашечок і мисок. Який епітелій зазнав пошкодження?', 'medium', 238, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Одношаровий призматичний', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багатошаровий плоский зроговілий', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багатошаровий кубічний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Перехідний', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Багаторядний війчастим', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час аутопсії тіла жінки, яка померла від уремії, виявлено: нирки різних розмірів, поверхня їх великобугриста, між нирковою поверхнею та капсулою нирок щільні спайки. Мікроскопічно в нирковій тканині спостерігаються інкапсульовані абсцеси, розростання сполучної тканини з лімфогістіоцитарною інфільтрацією, осередки метаплазії перехідного епітелію в багатошаровий, дистрофія та атрофія канальців. Який із нижченаведених діагнозів найвірогідніший?', 'medium', 239, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубулоінтерстиціальний нефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий гломерулонефрит', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У біоптаті нирки 45-річного чоловіка, що має хронічну хворобу нирок, виявлено: склероз, лімфо-плазмоцитарна інфільтрація стінок мисок та чашок, дистрофія та атрофія канальців. Збережені канальці розширені, розтягнені колоїдоподібними масами, епітелій сплющений (’’щитоподібна” нирка). Який діагноз найбільш імовірний?', 'medium', 240, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гломерулонефрит', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тубуло-інтерстиційний нефрит', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефросклероз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На аутопсії померлої, яка тривалий час хворіла циститом і дискінезією сечоводів, виявлено морфологічні ознаки уремії. Нирка була нерівномірно рубцево-зморщена. У просвіті мисок містилися дрібні уратні камені і пісок. Гістологічно виявлено “щитовидну нирку", вогнища інтерстиційного запалення. Який із нижчеперерахованих діагнозів є найбільш вірогідний?', 'medium', 241, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий пієлонефрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинно зморщена нирка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атеросклеротично зморщена нирка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний пієлонефрит', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Амілоїдно зморщена нирка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий на хронічний пієлонефрит помер від хронічної ниркової недостатності. При житті аускультативно відмічено "шум тертя перикарду? На розтині виявлено. що епікард тьмяний, шорсткий, ніби покритий волосяним покривом. Який перикардит за характером запалення має місце?', 'medium', 242, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'При отруєнні етиленгліколем у пацієнта розвинулася гостра ниркова недостатність: З’явилася нудота, блювання, потьмарення свідомості, артеріальна гіпотензія, аритмія та анурія. Що спричинило зменшення клубочкової фільтрації в пацієнта?', 'medium', 243, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення онкотичного тиску крові', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення гідростатнчного тиску в кубочках', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення загальної площі фільтрації', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшення тканинного тиску в нирках', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшення проникності стінки клубочків', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Унаслідок гострої ниркової недостатності в чоловіка виникла олігурія. Яка добова кількість сечі відповідає цьому симптому?', 'medium', 244, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '100-500 мл', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '50-90 мл', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '1500-2000 мл', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '1000-1500 мл', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '500-1000 мл', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта віком 58 років із кардіогенним шоком спостерігалося зменшення добової кількості сечі — олігурія. Який механізм цього явища?', 'medium', 245, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження клубочкової фільтрації', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення гідростатичного тиску на стінку капілярів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження онкотичного тиску крові', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження кількості функціональних клубочків', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження проникності клубочкової мембрани', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта спостерігається зниження продукції і виділення антидіуретичного гормону внаслідок пошкодження нейрогіпофізу. Які симптоми характерні для цієї патології?', 'medium', 246, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Олігурія, набряки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія, гіперстенурія, полідипсія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Поліурія, гіпостенурія, полідипсія', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкозурія, поліурія, полідипсія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Олігурія, протеїнурія, гематурія', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворого з гострою нирковою недостатністю на 6-й день проведення терапевтичних заходів виникла поліурія. Чим зумовлене зростання діурезу на початку поліуричної стадії гострої ниркової недостатності?', 'medium', 247, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Відновлення фільтрації в нефронах', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням об’єму циркулюючої крові', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Збільшенням натрійуретичного фактора', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням альдостерону в плазмі', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зменшенням вазопресину в плазмі', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хворий 50 років скаржиться на спрагу, п''є багато води, виражена поліурія. Глюкоза крові 4,8 ммоль/л, в сечі глюкози і ацетону немає, сеча безбарвна, питома вага 1,002-1,004. Яка причина поліурії?', 'medium', 248, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреотоксикоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нестача вазопресину', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотиреоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інсулінова недостатність', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостеронізм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнта турбують поліурія (7л на добу) й полідипсія. При обстеженні не виявлено ніяких розладів вуглеводного обміну. Дисфункція якої ендокринної залози може бути причиною даних порушень?', 'medium', 249, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Аденогіпофіз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Острівці підшлункової залози', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кора наднирників', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мозкова речовина наднирників', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нейрогіпофіз', true, 4, NOW(), NOW());

  RAISE NOTICE 'Додано питань: 250';
END $$;
