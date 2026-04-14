-- SQL для додавання питань до розділу 35: Репродуктивна система
-- Автоматично згенеровано
-- Кількість питань: 58

DO $$
DECLARE
  v_course_id UUID;
  v_topic_id UUID;
  v_question_id UUID;
BEGIN
  -- Знаходимо або створюємо курс
  SELECT id INTO v_course_id
  FROM courses
  WHERE title = 'Репродуктивна система'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    INSERT INTO courses (title, faculty, description, order_index, is_active, created_at, updated_at)
    VALUES (
      'Репродуктивна система',
      'medical',
      'Репродуктивна система',
      17,
      true,
      NOW(),
      NOW()
    )
    RETURNING id INTO v_course_id;
    RAISE NOTICE 'Створено курс "%s" з ID: %', 'Репродуктивна система', v_course_id;
  END IF;

  -- Створюємо або знаходимо topic
  SELECT id INTO v_topic_id
  FROM topics
  WHERE course_id = v_course_id AND title = 'Репродуктивна система'
  LIMIT 1;

  IF v_topic_id IS NULL THEN
    INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
    VALUES (
      v_course_id,
      'Репродуктивна система',
      'Тести з репродуктивної системи',
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
  VALUES (v_topic_id, 'У немовляти виявлено мікроцефалію. Лікарі вважають, що це пов’язано із застосуванням жінкою під час вагітності актиноміцину Д. На який зародковий листок подіяв цей тератоген?', 'medium', 0, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерма', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерма та мезодерма', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Усі листки', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезодерма', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерма', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На мікропрепараті шкіри пальця дитини спостерігаємо, що епідерміс має ознаки недостатнього розвитку. Який ембріональний листок був пошкоджений у процесі розвитку?', 'medium', 1, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектомезенхіма', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезенхіма', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерма', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерма', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезодерма', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На мікропрепараті очного яблука плода спостерігається пошкодження рогівки. Частина якого зародкового листка була уражена в процесі ембріонального розвитку?', 'medium', 2, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Нефротом', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерма', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезодерма', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерма', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дерматом', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час дослідження мікропрепарату шкіри пальця дитини встановлено, що епідерміс має ознаки недостатнього розвитку. Який ембріональний листок був пошкоджений у процесі розвитку?', 'medium', 3, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезодерма', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектомезенхіма', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ентодерма', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерма', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезенхіма', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У новонародженої дитини виявлено вроджені вади розвитку травної системи, що пов’язано з дією тератогенних факторів на початку вагітності. На який зародковий листок подіяв тератоген?', 'medium', 4, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендодерма і мезодерма', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Усі листки', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мезодерма', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ектодерма', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендодерма', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У гістопрепараті яєчника жінки визначаються структури, що мають велику порожнину. Овоцит І порядку в них оточений прозорою оболонкою, променистим вінцем і розташований у яйценосному горбику, стінка утворена шаром фолікулярних клітин і текою. Вкажіть, якій структурі яєчника належать дані морфологічні ознаки:', 'medium', 5, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Примордіальний фолікул', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атретичне тіло', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинний фолікул', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зрілий (третинний) фолікул', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Жовте тіло', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'На препараті яєчника, забарвленому гематоксиліном-еозином, визначається фолікул, в якому клітини фолікулярного епітелію розміщені в 1-2 шари та мають кубічну форму, навколо овоциту наявна оболонка яскраво-червоного кольору. Назвіть цей фолікул:', 'medium', 6, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зрілий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вторинний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атретичний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Примордіальний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Первинний', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікар, здійснюючи маніпуляцію установлення внутрішньоматкового контрацептиву порушив правила асептики та в порожнину матки потрапила інфекція. Запалення якої оболонки матки, найімовірніше, розвинеться у жінки?', 'medium', 7, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Периметрію', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Параметрію', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ендометрію', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міометрію', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гістологічного дослідження слизової оболонки матки знайдено звивисті залози, пилко- та штопороподібні, подовжені, розростання строми з гіперплазією її клітин. Який найбільш вірогідний діагноз?', 'medium', 8, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гострий ендометрит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пухирний занос', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Плацентарний поліп', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Залозиста гіперплазія ендометрія', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лейоміома', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час біопсії ендометрію здорової жінки, взятого під час секреторної фази менструального циклу, у власній пластинці слизової оболонки виявлено клітини полігональної форми, багаті на ліпіди та глікоген. Що це за клітини?', 'medium', 9, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини ендотелію пошкоджених судин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гладкі міоцити', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міофібробласти', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фібробласти', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Децидуальні клітини', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час гінекологічного обстеження пацієнтці був поставлений діагноз ендометрит (запалення ендометрію). Яка частина маткової стінки уражена запальним процесом?', 'medium', 10, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Слизова оболонка', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Навколоматкова клітковина', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адвентиційна оболонка', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М ’язова оболонка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Серозна оболонка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінці з дисфункціональною матковою кровотечею зробили діагностичне вишкрябання. Гістологічно у зіскрібку виявлено велику кількість звивистих залоз, просвіти окремих залоз кістозно розширені. Назвіть різновид загальнопатологічного процесу в ендометрії:', 'medium', 11, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метаплазія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпертрофічні розростання', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Дисплазія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Атрофія', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Залозисто-кістозна гіперплазія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Хвора 45-ти років госпіталізована з підозрою на пухлину матки. Після обстеження встановлено діагноз - фіброміома матки. В якому шарі матки розміщується ця пухлина?', 'medium', 12, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Parametrium', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Perimetrium', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Mesometrium', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Endometrium', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Myometrium', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтку віком 45 років шпиталізовано з підозрою на пухлину матки. Після обстеження встановлено діагноз: фіброміома матки. У якому шарі матки розміщується ця пухлина?', 'medium', 13, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Perimetrium', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Endometrium', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Myometrium', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Mesometrium', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Parametrium', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Запальний процес видозміненої підсерозної основи навколо шийки матки спричинив інтенсивний больовий симптом у пацієнтки. Патологічний процес якої ділянки статевих органів встановив лікар?', 'medium', 14, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Mesometrium', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Parametrium', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Endometrium', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Perimetrium', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Myometrium', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Внаслідок травми низу передньої стінки живота у хворої ушкоджена зв’язка, що розташована у пахвинному каналі. Яка це зв’язка?', 'medium', 15, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ligamentum ovarium proprium', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ligamentum lacunare', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ligamentum inguinale', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ligamentum latum uteri', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ligamentum teres uteri', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої 28-ми років виявлена пухлина яєчника і показана операція по його видаленню. При здійсненні її необхідно розтинати зв’язку, що з’єднує яєчник з маткою. Яку зв’язку повинен перерізати хірург?', 'medium', 16, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Lig. Ovarii proprium', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Lig. Latum uteri', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Lig. umbilicale laterale', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Lig. Cardinali', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Lig. Suspensorium ovarii', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час оперативного втручання на малому тазі жінки виникла необхідність перев’язати яєчникову артерію. Яке з утворень може бути випадково перев’язаним разом з нею?', 'medium', 17, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У вагітної жінки 29-ти років лікар визначив розміри таза. За допомогою циркуля була виміряна відстань між двома верхніми передніми клубовими остями. Який розмір великого таза був визначений?', 'medium', 18, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Conjugata anatomica', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Conjugata vera', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia trochanterica', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia spinarum', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia cristarum', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У вагітної жінки лікар-акушер-гінеколог вимірює розміри таза. За допомогою циркуля була виміряна відстань між двома клубовими гребенями. Який розмір великого таза визначали?', 'medium', 19, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia throchanterica', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia cristarum', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Conjugata anatomica', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia spinarum', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Conjugata vera', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Лікар вимірює зовнішні розміри таза та визначає відстань між великими вертлюгами стегнових кісток. Який розмір визначив лікар?', 'medium', 20, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia intercristalis', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Conjugata externa', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia interspinosa', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Diameter oblique', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Distantia intertrochanterica', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої 53-х років внаслідок тупої травми живота діагностований розрив печінки. У якому анатомічному утворенні збереться кров, що вилилася?', 'medium', 21, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Правий брижовий синус', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково-маткове заглиблення', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхурово-маткове заглиблення', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лівий брижовий синус', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сальникова сумка', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В клініку поступила молода жінка зі скаргами на різкий біль внизу живота. При обстеженні у лікаря виникла підозра на розрив маткової труби в результаті позаматкової вагітності. Під час пункції через заднє склепіння піхви шприці виявили кров. В якому з утво-рень очеревини жінки накопичується кров в даному випадку?', 'medium', 22, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжсигмовидному поглибленні.', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково-міхурному поглибленні.', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Позадусліпокишковому поглибленні.', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхурно-матковому поглибленні.', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково-матковому поглибленні.', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 28-ми років доставлена до приймального відділення зі скаргами на різкий біль у нижній ділянці живота. Гінеколог при огляді припустив позаматкову вагітність. Яке анатомічне утворення потрібно пропунктувати для підтвердження діагнозу?', 'medium', 23, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Матково-міхурова заглибина', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково-маткова заглибина', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передміхуровий простір', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхурово-прямокишкова заглибина', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжсигмоподібний закуток', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки 28 років виявлена позаматкова вагітність, яка ускладнилася розривом маткової труби. У який простір очеревини можливе попадання крові?', 'medium', 24, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міхурово - матковий', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прямокишково – матковий', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Правий брижовий синус', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лівий брижовий синус', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Міжсигмовидний синус', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обстеження пацієнтки в лікарки виникла підозра на наявність гнійного випоту у прямокишково-матковій заглибленні. Через яке анатомічне утворення найкраще пропунктувати це заглиблення?', 'medium', 25, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ампулу прямої кишки', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Переднє склепіння піхви', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Заднє склепіння піхви', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Діафрагму таза', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передню стінку піхви', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До гінекологічного відділення шпиталізовано жінку з ознаками внурішньої кровотечі та підозрою на позаматкову вагітність. У якому анатомічному утворенні, ймовірно, є накопичення крові?', 'medium', 26, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Fosa ischio-analis', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Fossa paravesicalis', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Fossa ovarica', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Excavatio recto-uterina', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Excavatio vesico-uterina', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час обстеження зовнішніх статевих органів у хлопчика виявлено повне закриття уретри зверху. Сечівник залишається відкритим знизу і має вигляд невеликої щілини. Який вид аномалії розвитку зовнішніх статевих органів спостерігається у дитини?', 'medium', 27, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У новонародженого хлопчика під час огляду зовнішніх статевих органів виявлена розщілина сечівника, яка відкривається на нижній поверхні статевого члена. Про яку аномалію йдеться?', 'medium', 28, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Крипторхізм', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Монорхізм', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Парубок звернувся до лікарні зі скаргами на порушення сечовипускання. Під час обстеження зовнішіх статевих органів виявлено, що сечівник розщеплений зверху і сеча витікає крізь цей отвір. Який вид аномали розвитку зовнішніх статевих органів спостерігається у цьому разі?', 'medium', 29, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'У новонародженої дитини отвір крайньої плоті статевого члена за величою не перевищує діаметр сечовивідного каналу і перешкоджає вільному виходу голівки статевого члена. Як називається цей патологічний стан у дитини?', 'medium', 30, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парафімоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фімоз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У новонародженого малюка педіатр виявив, що отвір крайньої плоті за величиною не перевищує діаметр сечовивідного каналу і голівка статевого члена не може виходити через такий отвір. Як називається цей стан?', 'medium', 31, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гермафродитизм', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Епіспадія', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпоспадія', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фімоз', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парафімоз', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Молодий чоловік звернувся до лікарні зі скаргами на порушення сечовипускання. Під час обстеження зовнішніх статевих органів виявлено, що сечівник розщеплений зверху й сеча витікає через цей отвір. Який вид аномалії розвитку зовнішніх статевих органів спостерігається у цьому випадку?', 'medium', 32, true, NOW(), NOW())
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
  VALUES (v_topic_id, 'Під час статевого дозрівання клітини чоловічих статевих залоз починають продукувати чоловічий статевий гормон тестостерон, який обумовлює появу вторинних статевих ознак. Які клітини чоловічих статевих залоз продукують цей гормон?', 'medium', 33, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сперматозоїди', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Сертолі', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підтримуючі клітини', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Клітини Лейдіга', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Сустентоцити', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пацієнта встановлено діагноз: водянка яєчка (збільшення кількості рідини в серозній порожнині). Між якими оболонками яєчка локалізується патологічний вміст?', 'medium', 34, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Між внутрішньою сімʼяною фасцією і піхвовою оболонкою', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Між мʼясистою оболонкою і внутрішньою сімʼяною фасцією', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Між парієтальним і вісцеральним листками піхвової оболонки яєчка', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Між шкірою і мʼясистою оболонкою', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Між шкірою і мʼязом, що піднімає яєчко', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У чоловіка 50-ти років запалення яєчка ускладнилось його водянкою. Необхідне оперативне втручання. Яку з оболонок яєчка останньою розтинає хірург під час операції?', 'medium', 35, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зовнішня сім’яна фасція', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М ’ясиста оболонка', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Парієтальний листок піхвової оболонки яєчка', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'М’яз-підіймач яєчка', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Внутрішня сім’яна фасція', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Секреція яких гормонів гіпофізу гальмується після прийому оральних контрацептивів, які містять статеві гормони?', 'medium', 36, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреотропні', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гонадотропні', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Приймання оральних контрацептивів, які містять статеві гормони, пригнічує секрецію гормонів гіпофіза. Секреція якого з наведених гормонів пригнічується при прийманні оральних контрацептивів, які містять статеві гормони?', 'medium', 37, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропний', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолікулостимулюючий', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреотропний', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 26 років через рік після важких пологів з кровотечею скаржиться на загальну слабкість, втрату маси тіла на 18 кг, відсутність менструацій. Об''єктивно: гіпоплазія молочних залоз. Діагностовано хвороба Сіммондса. Що являється основним механізмом втрати ваги у жінки?', 'medium', 38, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпотиреоз', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження продукції гормонів аденогіпофізу', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження функції статевих залоз', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гіпопаратиреоз', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Зниження функції кіркового шару наднирників', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікаря звернулися батьки хлопчика 10-ти років, у якого відзначалося збільшення волосяного покриву на тілі, ріст бороди і вус, низький голос. Збільшення секреції якого гормону можна припустити?', 'medium', 39, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естроген', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У дівчинки діагностований адреногенітальний синдром (псевдогермафродитизм). Надмірна секреція якого гормону наднирників обумовила дану патологію?', 'medium', 40, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естроген', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Андроген', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортизол', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреналін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У гістологічному препараті яєчника визначається структура кулястої форми, яка складається з великих залозистих клітин, що містять пігмент лютеїн. Який гормон продукують клітини цієї структури?', 'medium', 41, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортикостерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естроген', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У хворої внаслідок запалення порушена ендокринна функція фолікулярних клітин фолікулів яєчника. Синтез яких гормонів буде пригнічений?', 'medium', 42, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолікулостимулюючий гормон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Фолістатин', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естрогени', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Лютропін', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У жінки віком 30 років з''явилися ознаки вірилізму (ріст волосся на тілі, облисіння скронь, порушення менструального циклу). Гіперпродукція якого гормону може спричинити такий стан?', 'medium', 43, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерону', true, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естріолу', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцину', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Релаксину', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікарки-гінекологині звернулася пацієнтка віком 32 роки зі скаргами на нерегулярні менструації, зниження лібідо, сухість вагіни та втому. В анамнезі - нормальні пологи 5 років тому, без гормональної терапії. Лабораторні дослідження виявили зниження рівня естрадіолу при нормальних показниках лютеїнізуючого гормону (ЛГ) і фолікулостимулюючого гормону (ФСГ). Яку основну функцію виконує естрадіол за фізіологічних умов?', 'medium', 44, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляція тестостерону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підтримка прогестерону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Підвищення пролактину', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Інгібування гонадотропінів', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляція росту фолікулів', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Під час лютеїнової фази менструального циклу утворюється жовте тіло. Синтез якого гормону стимулює ця тимчасова залоза внутрішньої секреції?', 'medium', 45, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Кортикостерону', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Паратгормону', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерону', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерону', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Альдостерону', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, '3 метою ранньої діагностики вагітності досліджується сеча жінки. Поява яких гормонів в сечі свідчить про ймовірну вагітність?', 'medium', 46, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, '17-бета-естрадіол', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естріол', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хоріонічний гонадотропін', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Тестостерон та його аналоги збільшують масу скелетних м’язів, що дозволяє використовувати їх для лікування дистрофій. Взаємодією з яким клітинним субстратом зумовлена ця дія?', 'medium', 47, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хроматин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Мембранні рецептори', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Рибосоми', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Ядерні рецептори', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Білки-активатори транскрипції', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До лікаря звернулася жінка 32-х років зі скаргами на відсутність лактації після народження дитини. Дефіцитом якого гормону можна пояснити дане порушення?', 'medium', 48, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреокальцитонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пролактин', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропін', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка віком 25 років за місяць після пологів звернулася до лікаря зі скаргою на зменшення кількості молока. Дефіцит якого гормону вплинув на вироблення грудного молока у жінки?', 'medium', 49, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматостатину', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пролактину', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адренокортикотропного гормона', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагону', false, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'В поліклініку до лікаря звернулася жінка 32-х років зі скаргами на відсутність в неї лактації після народження дитини. Дефіцитом якого гормону, найбільш імовірно, можна пояснити дане порушення?', 'medium', 50, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреокальцитонін', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропін', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пролактин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Глюкагон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Секреція яких гормонів гіпофізу гальмується після прийому оральних контрацептивів, які містять статеві гормони?', 'medium', 51, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Вазопресин', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тиреотропні', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Соматотропний', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гонадотропні', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтка віком 32 роки скаржиться на безпліддя, порушення менструального циклу, хронічну ановуляцію та полікістоз яєчників. Під час бімануального обстеження з обох сторін виявлено збільшені яєчники щільної консистенції, розмірами 5х6 см. Ці ж дані підтверджено при УЗД. Під час гістологічного дослідження виявлено потовщену фіброзну капсулу яєчника, що вкриває незліченні кістозні фолікули, вистелені гранульозними клітинами з гіперпластичною лютеїновою внутрішньою оболонкою (текою). Жовтих тіл немає. Що спричинило цей стан у пацієнтки?', 'medium', 52, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Хронічний двосторонній аднексит', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Синдром полікістозних яєчників (синдром Штейна-Левенталя)', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Адреногенітальний синдром', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передменструальний синдром', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Андробластома яєчників', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У препараті яєчника поряд з фолікулами різного порядку виявляються атретичні тіла і розвинуте жовте тіло. Якій стадії оваріально-ментруального циклу відповідає такий стан у яєчнику?', 'medium', 53, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Регенераторна', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Росту фолікула', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Постменструальна', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Менструальна', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Передменструальна', true, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Пацієнтку віком 28 років шпиталізовано до пологового відділення. Через слабкість пологової діяльності акушер-гінеколог призначив внутрішньовенну інфузію препарату, який посилює та збільшує частоту скорочень матки, що сприяло прогресуванню пологів. Який основний механізм дії цього препарату?', 'medium', 54, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада кальцієвих каналів', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Пригнічення синтезу простагландинів', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Блокада серотонінових рецепторів', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Стимуляція окситоцинових рецепторів', true, 3, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'Жінка 26-ти років поступила у пологове відділення в терміні вагітності 40 тижнів. Шийка матки розкрита, але скорочення матки відсутнє. Лікар дав засіб гормональної природи для посилення пологової діяльності. Назвіть засіб:', 'medium', 55, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АКТГ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', true, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрокортизон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естрон', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'У пологове відділення надійшла жінка 26-ти років, у якої за терміном вагітності (40 тижнів) вже мають розпочатися пологи. При огляді встановлено, що шийка матки розкрита, але скорочення матки відсутнє. Лікар дав засіб гормональної природи для посилення пологової діяльності. Назвіть цей засіб:', 'medium', 56, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Естрон', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрокортизон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', true, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Тестостерон', false, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АКТГ', false, 4, NOW(), NOW());
  INSERT INTO questions (topic_id, question_text, difficulty, order_index, is_active, created_at, updated_at)
  VALUES (v_topic_id, 'До пологового відділення надійшла вагітна жінка зі слабкою пологовою діяльністю. Призначте засіб гормональної природи для посилення пологової діяльності:', 'medium', 57, true, NOW(), NOW())
  RETURNING id INTO v_question_id;

  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'АКТГ', false, 0, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Гідрокортизон', false, 1, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Прогестерон', false, 2, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Окситоцин', true, 3, NOW(), NOW());
  INSERT INTO question_options (question_id, option_text, is_correct, order_index, created_at, updated_at)
  VALUES (v_question_id, 'Метандростенолон', false, 4, NOW(), NOW());

  RAISE NOTICE 'Додано питань: 58';
END $$;
