BEGIN;

-- Auto-generated from PDF with images
INSERT INTO courses (title, description, faculty, order_index, is_active)
SELECT 'Основи знань про органічні сполуки', 'Автоматично імпортований курс', 'pharmaceutical', 1, true
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Основи знань про органічні сполуки');

INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Вуглеводні та їх галогенопохідні', 'Автоматично імпортована тема', 1, true
FROM courses c
WHERE c.title = 'Основи знань про органічні сполуки'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Вуглеводні та їх галогенопохідні');

ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з представлених нижче сполук належить до аліциклічних вуглеводнів?', NULL, 'medium', 1, true, '/test-images/organic/tema1/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антрацен', false, 0),
  ((SELECT id FROM inserted_question), 'Нафтален', false, 1),
  ((SELECT id FROM inserted_question), 'Циклогексен', true, 2),
  ((SELECT id FROM inserted_question), 'Бензол', false, 3),
  ((SELECT id FROM inserted_question), 'Фенантрен', false, 4);

-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед представлених сполук визначте ту, яка належить до аліциклічних вуглеводнів:', NULL, 'medium', 2, true, '/test-images/organic/tema1/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циклогексен', true, 0),
  ((SELECT id FROM inserted_question), 'Бензен', false, 1),
  ((SELECT id FROM inserted_question), 'Антрацен', false, 2),
  ((SELECT id FROM inserted_question), 'Фенантрен', false, 3),
  ((SELECT id FROM inserted_question), 'Нафтален', false, 4);

-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук належить до нітропохідних вуглеводнів?', NULL, 'medium', 3, true, '/test-images/organic/tema1/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'С6Н5 - N = N - С6Н5', false, 0),
  ((SELECT id FROM inserted_question), 'С2Н5 - NH2', false, 1),
  ((SELECT id FROM inserted_question), 'С2Н5 - N0', false, 2),
  ((SELECT id FROM inserted_question), 'С3Н7 – О - N02', false, 3),
  ((SELECT id FROM inserted_question), 'С6Н5 - N02', true, 4);

-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для ароматичних вуглеводнів найбільш характерними є реакції:', NULL, 'medium', 4, true, '/test-images/organic/tema1/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Елімінування', false, 0),
  ((SELECT id FROM inserted_question), 'Нуклеофільного заміщення', false, 1),
  ((SELECT id FROM inserted_question), 'Радикального заміщення', false, 2),
  ((SELECT id FROM inserted_question), 'Електрофільного приєднання', false, 3),
  ((SELECT id FROM inserted_question), 'Електрофільного заміщення', true, 4);

-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При алкілуванні ароматичних вуглеводнів за Фріделем-Крафтсом як каталізатор використовують: o', NULL, 'medium', 5, true, '/test-images/organic/tema1/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaOH (сп. р-н.)', false, 0),
  ((SELECT id FROM inserted_question), 'Безводний AlCl3', true, 1),
  ((SELECT id FROM inserted_question), 'Pt', false, 2);

-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка із наведених сполук відноситься до нітропохідних вуглеводнів? o', NULL, 'medium', 6, true, '/test-images/organic/tema1/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'C6H5 − N = N − C6H5', false, 0),
  ((SELECT id FROM inserted_question), 'C6H5 − NO2', true, 1),
  ((SELECT id FROM inserted_question), 'C3H7 − O − NO2', false, 2),
  ((SELECT id FROM inserted_question), 'C2H5 − NO', false, 3),
  ((SELECT id FROM inserted_question), 'C2H5 − NH2', false, 4);

-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для ароматичних вуглеводнів найбільш характерними є реакції:', NULL, 'medium', 7, true, '/test-images/organic/tema1/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'SE', true, 0),
  ((SELECT id FROM inserted_question), 'SR', false, 1),
  ((SELECT id FROM inserted_question), 'SN', false, 2),
  ((SELECT id FROM inserted_question), 'E', false, 3),
  ((SELECT id FROM inserted_question), 'AE', false, 4);

-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених дієнових вуглеводнів оберіть спряжений дієн:', NULL, 'medium', 8, true, '/test-images/organic/tema1/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CH2 =CH-CH2 = CH2', true, 0),
  ((SELECT id FROM inserted_question), 'CH2 = C = CH-CH2', false, 1),
  ((SELECT id FROM inserted_question), 'CH2 = CH-CH2-CH =CH2', false, 2),
  ((SELECT id FROM inserted_question), '.CH2 =CH-CH2-CH2-CH=CH2', false, 3),
  ((SELECT id FROM inserted_question), '-', false, 4);

-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сполука відноситься до похідних ароматичних вуглеводнів, не утворює забарвлення з FeCl3 , при окисненні утворює бензойну кислоту. Це:', NULL, 'medium', 9, true, '/test-images/organic/tema1/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);
-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Алкадієнами називають вуглеводні аліфатичного ряду, що містять два подвійні зв’язки. Оберіть загальну формулу гомологічного ряду алкадієнів:', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CnH2n−2', true, 0),
  ((SELECT id FROM inserted_question), 'Cn H2n+2', false, 1),
  ((SELECT id FROM inserted_question), 'CnH2n', false, 2),
  ((SELECT id FROM inserted_question), 'CnH2n+1', false, 3),
  ((SELECT id FROM inserted_question), 'CnH2n−1', false, 4);

-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що травлення білків, жирів та вуглеводнів здійснюється за допомогою, відповідно, протеаз, ліпаз та амілаз. У якому із травних соків містяться всі три групи ферментів у достатній для травлення кількості?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сiк підшлункової залози', true, 0),
  ((SELECT id FROM inserted_question), 'Слина', false, 1),
  ((SELECT id FROM inserted_question), 'Шлунковий сiк', false, 2),
  ((SELECT id FROM inserted_question), 'Жовч', false, 3),
  ((SELECT id FROM inserted_question), 'Сiк товстої кишки', false, 4);

-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Зростання виділення інсуліну підшлунковою залозою відбувається після вживання вуглеводної їжі. Активність якого ферменту регулює інсулін?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альдолаза', false, 0),
  ((SELECT id FROM inserted_question), 'Енолаза', false, 1),
  ((SELECT id FROM inserted_question), 'Піруваткіназа', false, 2),
  ((SELECT id FROM inserted_question), 'Лактатдегідрогеназа', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкокіназа', true, 4);

-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Поверхнева активність дифільних молекул описується правилом Траубе-Дюкло. Як зміниться поверхнева активність жирних кислот у зоні низьких концентрацій, якщо довжина вуглеводного радикала зросте на три групи - СН2-?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшиться у 3 рази', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшиться у 27 разів', false, 1),
  ((SELECT id FROM inserted_question), 'Збільшиться у 27 разів', true, 2),
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшиться у 9 разів', false, 4);

-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта діагностовано акромегалію (еозинофільну аденому гіпофіза, що продукує соматотропін). Яке саме порушення вуглеводного обміну типове для цього стану?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпоглікемія', false, 0),
  ((SELECT id FROM inserted_question), 'Підвищення толерантності до глюкози', false, 1),
  ((SELECT id FROM inserted_question), 'Ожиріння', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження толерантності до глюкози', true, 3);

-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з представлених нижче сполук належить до аліциклічних вуглеводнів?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антрацен', false, 0),
  ((SELECT id FROM inserted_question), 'Нафтален', false, 1),
  ((SELECT id FROM inserted_question), 'Циклогексен', true, 2),
  ((SELECT id FROM inserted_question), 'Бензол', false, 3),
  ((SELECT id FROM inserted_question), 'Фенантрен', false, 4);

-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Нелегальні емігранти із Сомалі були затримані на українському кордоні. Під час медичного огляду дитини 3 років виявлено гіпотонію та дистрофію м’язів, депігментацію шкіри, знижений тургор, живіт збільшений у розмірі, дефіцит маси тіла. Встановлено діагноз квашіоркор. До якого виду часткового голодування відносять цю патологію?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамінного', false, 0),
  ((SELECT id FROM inserted_question), 'Білкового', true, 1),
  ((SELECT id FROM inserted_question), 'Енергетичного', false, 2),
  ((SELECT id FROM inserted_question), 'Вуглеводного', false, 3),
  ((SELECT id FROM inserted_question), 'Жирового', false, 4);

-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук належить до нітропохідних вуглеводнів?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'С6Н5 - N = N - С6Н5', false, 0),
  ((SELECT id FROM inserted_question), 'С2Н5 - NH2', false, 1),
  ((SELECT id FROM inserted_question), 'С2Н5 - N0', false, 2),
  ((SELECT id FROM inserted_question), 'С3Н7 – О - N02', false, 3),
  ((SELECT id FROM inserted_question), 'С6Н5 - N02', true, 4);

-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед представлених сполук визначте ту, яка належить до аліциклічних вуглеводнів:', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нафтален', false, 0),
  ((SELECT id FROM inserted_question), 'Бензен', false, 1),
  ((SELECT id FROM inserted_question), 'Антрацен', false, 2),
  ((SELECT id FROM inserted_question), 'Фенантрен', false, 3),
  ((SELECT id FROM inserted_question), 'Циклогексен', true, 4);

-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До органічних сполук рослинної клітини невуглеводної природи відносять:', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Воски', true, 0),
  ((SELECT id FROM inserted_question), 'Інулін', false, 1),
  ((SELECT id FROM inserted_question), 'Клітковину', false, 2),
  ((SELECT id FROM inserted_question), 'Слиз', false, 3),
  ((SELECT id FROM inserted_question), 'Пектини', false, 4);

-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Поверхнева активність - це один з факторів біодоступності лікарських препаратів. У скільки разів зросте поверхнева активність при подовженні вуглеводневого радикалу ПАР на групу CH2?', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '3,2', true, 0),
  ((SELECT id FROM inserted_question), '1,5', false, 1),
  ((SELECT id FROM inserted_question), '6,4', false, 2),
  ((SELECT id FROM inserted_question), '2,8', false, 3),
  ((SELECT id FROM inserted_question), '0,5', false, 4);
-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Алкадієнами називають вуглеводні аліфатичного ряду, що містять два подвійні зв’язки. Оберіть загальну формулу гомологічного ряду алкадієнів:', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CnH2n−2', true, 0),
  ((SELECT id FROM inserted_question), 'Cn H2n+2', false, 1),
  ((SELECT id FROM inserted_question), 'CnH2n', false, 2),
  ((SELECT id FROM inserted_question), 'CnH2n+1', false, 3),
  ((SELECT id FROM inserted_question), 'CnH2n−1', false, 4);

-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджувана суміш містить іони Cl-,Br- та І- в еквімолярних калькотях.Послідовність утворення осадів при аргентометричному титруванні буде визначатися:', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Добутком розчинності відповідних галогенідів срібла', true, 0),
  ((SELECT id FROM inserted_question), 'Величиною редокс-потенціалів', false, 1),
  ((SELECT id FROM inserted_question), 'Вибором способу титрування - прямим чи зворотнім', false, 2),
  ((SELECT id FROM inserted_question), 'Величиною рухливості відповідних аніонів', false, 3),
  ((SELECT id FROM inserted_question), 'Іонною силою розчину', false, 4);

-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У якому середовищі проводять кількісне визначення галогенід-іонів методом Фольгарда (тіоціанометрія)?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтральному', false, 0),
  ((SELECT id FROM inserted_question), 'Сильнолужному', false, 1),
  ((SELECT id FROM inserted_question), 'Слаболужному', false, 2),
  ((SELECT id FROM inserted_question), 'Нітратнокислому', true, 3),
  ((SELECT id FROM inserted_question), 'Фосфатнокислому', false, 4);

-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При вивченні хімічних властивостей органічної сполуки встановлено, що вона проявляє основні властивості та легко вступає в реакції галогенування й діазотування. Укажіть сполуку, що відповідає вказаним критеріям.', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нафтален', false, 0),
  ((SELECT id FROM inserted_question), 'Бензен', false, 1),
  ((SELECT id FROM inserted_question), 'Толуен', false, 2),
  ((SELECT id FROM inserted_question), 'Фенол', false, 3),
  ((SELECT id FROM inserted_question), 'Анілін', true, 4);

-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який лікарський засіб із групи галогеновмісних сполук із високою поверхневою активністю потрібно запропонувати відвідувачу аптеки для антисептичної обробки шкіри рук та стоп після відвідування басейну?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Менадіон', false, 0);

-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За яких умов відбувається реакція галогенування толуолу з утворенням бензилхлориду (механізм SR)? o', NULL, 'medium', 26, true, '/test-images/organic/tema1/page7_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'hv', true, 0),
  ((SELECT id FROM inserted_question), 'к. HNO3', false, 1),
  ((SELECT id FROM inserted_question), 'к. H2SO4', false, 2),
  ((SELECT id FROM inserted_question), 'p. H2SO4', false, 3),
  ((SELECT id FROM inserted_question), 'AlCl3', false, 4);

-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У якому середовищі треба проводити визначення галогенід-іонів аргентометрично згідно з методом Фольгарда?', NULL, 'medium', 27, true, '/test-images/organic/tema1/page7_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Азотнокислому', true, 0),
  ((SELECT id FROM inserted_question), 'Оцтовокислому', false, 1),
  ((SELECT id FROM inserted_question), 'Слаболужному', false, 2),
  ((SELECT id FROM inserted_question), 'Нейтральному', false, 3),
  ((SELECT id FROM inserted_question), 'Сильнолужному', false, 4);

-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який метод кількісного аналізу заснований на утворенні комплексних сполук галогенід-іонів із солями Нg2+?', NULL, 'medium', 28, true, '/test-images/organic/tema1/page7_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Меркуриметрія', true, 1),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 4);

-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод, який базується на реакціях осадження галогенідів у вигляді малорозчинних солей ртуті (І):', NULL, 'medium', 29, true, '/test-images/organic/tema1/page7_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Меркурометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Трилонометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Роданометрія', false, 3);

-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які аніони заважають визначенню галогенідіонів методом Фольгарда через утворення міцного безбарвного комплексу з іонами феруму (ІІІ)?', NULL, 'medium', 30, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NO2-', false, 0),
  ((SELECT id FROM inserted_question), 'NO3-', false, 1),
  ((SELECT id FROM inserted_question), 'SO32-', false, 2),
  ((SELECT id FROM inserted_question), 'F-', true, 3),
  ((SELECT id FROM inserted_question), 'MnO4-', false, 4);

-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть метод кількісного аналізу, заснований на утворенні комплексних сполук галогенід-іонів з солями Hg2+:', NULL, 'medium', 31, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Меркуриметрія', true, 4);

-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка якісна реакція підтверджує ненасиченість лінолевої кислоти? o', NULL, 'medium', 32, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Знебарвлення бромної води (Br2;H2O)', true, 0),
  ((SELECT id FROM inserted_question), 'Гідрогалогенування (HCl)', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція ”срібного дзеркала” з [Ag(NH3)2]OH', false, 2),
  ((SELECT id FROM inserted_question), 'Декарбоксилювання', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція з FeCl3', false, 4);

-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка якісна реакція підтверджує ненасиченість лінолевої кислоти? CH3(CH2)4CH=CH-СH2-CH=CH(CH2)7COOH', NULL, 'medium', 33, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Знебарвлення бромної води (Br2; H2O)', true, 0),
  ((SELECT id FROM inserted_question), 'Декарбоксилювання', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція з FeCl3', false, 2),
  ((SELECT id FROM inserted_question), 'Реакція "срібного дзеркала" з [Ag(NH3)2]OH', false, 3),
  ((SELECT id FROM inserted_question), 'Гідрогалогенування (HCl)', false, 4);

-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Атоми галогенів у органічній сполуці можна виявити:', NULL, 'medium', 34, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пробою Бельштейна', true, 0),
  ((SELECT id FROM inserted_question), 'Пробою Моліша', false, 1),
  ((SELECT id FROM inserted_question), 'Пробою Байєра', false, 2),
  ((SELECT id FROM inserted_question), 'Пробою Лукаса', false, 3),
  ((SELECT id FROM inserted_question), 'Йодоформною пробою', false, 4);

-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хімічному відношенні етери (прості ефіри) є досить інертними сполуками. Під дією якої з галогеноводневих кислот етери розщеплюються вже при кімнатній температурі?', NULL, 'medium', 35, true, '/test-images/organic/tema1/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HI', true, 0),
  ((SELECT id FROM inserted_question), 'HBr', false, 1);

-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть продукти, які утворюються при дегалогенуванні віцинальних дигалогеналканів при дії металів (цинку або магнію): o', NULL, 'medium', 36, true, '/test-images/organic/tema1/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкени', true, 0),
  ((SELECT id FROM inserted_question), 'Алкани', false, 1),
  ((SELECT id FROM inserted_question), 'Алкіни', false, 2),
  ((SELECT id FROM inserted_question), 'Реактиви Гріньяра', false, 3),
  ((SELECT id FROM inserted_question), 'Галогеналкани', false, 4);

-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених нижче сполук належить до аліфатичних? o', NULL, 'medium', 37, true, '/test-images/organic/tema1/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А', false, 0),
  ((SELECT id FROM inserted_question), 'B', true, 1),
  ((SELECT id FROM inserted_question), 'С', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'Е', false, 4);

-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Загальна формула алкінів CnH2n−2. Який клас сполук є ізомерними алкінами?', NULL, 'medium', 38, true, '/test-images/organic/tema1/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкадієни', true, 0);

-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть продукти, які утворюються при дегалогенуванні віцинальних дигалогеналканів при дії металів (цинку або магнію): o', NULL, 'medium', 39, true, '/test-images/organic/tema1/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкени', true, 0),
  ((SELECT id FROM inserted_question), 'Алкани', false, 1),
  ((SELECT id FROM inserted_question), 'Алкіни', false, 2),
  ((SELECT id FROM inserted_question), 'Реактиви Гріньяра', false, 3),
  ((SELECT id FROM inserted_question), 'Галогеналкани', false, 4);

-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Первинні та вторинні нітроалкани є таутомерними сполуками. Яка таутомерія характерна для цих сполук?', NULL, 'medium', 40, true, '/test-images/organic/tema1/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Азольна', false, 0),
  ((SELECT id FROM inserted_question), 'Аци-нітротаутомерія', true, 1),
  ((SELECT id FROM inserted_question), 'Кето-енольна', false, 2),
  ((SELECT id FROM inserted_question), 'Лактам-лактамна', false, 3),
  ((SELECT id FROM inserted_question), 'Аміно-імінна', false, 4);

-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Визначте, яка з наведених циклічних сполук відноситься до карбоциклічних:', NULL, 'medium', 41, true, '/test-images/organic/tema1/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензол', true, 0),
  ((SELECT id FROM inserted_question), 'Фуран', false, 1),
  ((SELECT id FROM inserted_question), 'Тетрагідрофуран', false, 2),
  ((SELECT id FROM inserted_question), 'Піридин', false, 3),
  ((SELECT id FROM inserted_question), 'Гексан', false, 4);

-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених гетероциклічних сполук виявляє найсильніші основні властивості?', NULL, 'medium', 42, true, '/test-images/organic/tema1/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фуран', false, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Пірол', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3);

-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Шестичленні нітрогенвмісні гетероциклічні сполуки проявляють основні властивості. Вкажіть сполуку, що має найбільш сильні основні властивості:', NULL, 'medium', 43, true, '/test-images/organic/tema1/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піперазин', true, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 2),
  ((SELECT id FROM inserted_question), 'Піразин', false, 3),
  ((SELECT id FROM inserted_question), 'Піридазин', false, 4);

-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка гетероциклічна структура входить до складу бактерицидного лікарського препарату риванолу?', NULL, 'medium', 44, true, '/test-images/organic/tema1/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антрацену', false, 0),
  ((SELECT id FROM inserted_question), 'Акридину', true, 1),
  ((SELECT id FROM inserted_question), 'Фенатрену', false, 2),
  ((SELECT id FROM inserted_question), 'Хіноліну', false, 3),
  ((SELECT id FROM inserted_question), 'Ізохіноліну', false, 4);

-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який вид таутомерії характерний для гетероциклічних сполук із двома гетероатомами? o', NULL, 'medium', 45, true, '/test-images/organic/tema1/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кето-польна', false, 0),
  ((SELECT id FROM inserted_question), 'Лактам-лактимна', false, 1),
  ((SELECT id FROM inserted_question), 'Азольна', true, 2),
  ((SELECT id FROM inserted_question), 'Аміно-імінна', false, 3),
  ((SELECT id FROM inserted_question), 'Нітро-аци-нітро', false, 4);

-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які два гетероциклічні кільця містить у своєму складі вітамін В1 (тіамін)?', NULL, 'medium', 46, true, '/test-images/organic/tema1/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піразинове та тіофенове', false, 0),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіофенове', false, 1),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіазольне', false, 2),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіофенове', false, 3),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіазольне', true, 4);
-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які функціональні групи містяться в циклічних формах рибози та дезоксирибози?', NULL, 'medium', 47, true, '/test-images/organic/tema1/page13_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідроксильні й альдегідні', false, 0),
  ((SELECT id FROM inserted_question), 'Лише альдегідні', false, 1),
  ((SELECT id FROM inserted_question), 'Лише гідроксильні', true, 2),
  ((SELECT id FROM inserted_question), 'Лише карбоксильні', false, 3),
  ((SELECT id FROM inserted_question), 'Гідроксильні та карбоксильні', false, 4);

-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які продукти реакції, що утворюються за механізмом радикального заміщення вказані на нижченаведеній схемі перетворень?', NULL, 'medium', 48, true, '/test-images/organic/tema1/page13_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1-феніл-1-хлоретан ; 1-феніл-1,1-дихлоретан', true, 0),
  ((SELECT id FROM inserted_question), 'Орто-хлоретилбензен; мета-хлоретилбензен', false, 1),
  ((SELECT id FROM inserted_question), 'Бензилхлорид; бензиліденхлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Орто-хлоретилбензен; пара-хлоретилбензен', false, 3),
  ((SELECT id FROM inserted_question), '1-феніл-1-хлорпропан; 1-феніл-1,1-дихлорпропан', false, 4);
  ((SELECT id FROM inserted_question), 'Орто-хлоретилбензен; мета-хлоретилбензен', false, 0),
  ((SELECT id FROM inserted_question), 'Бензилхлорид; бензиліденхлорид', false, 1),
  ((SELECT id FROM inserted_question), 'Орто-хлоретилбензен; пара-хлоретилбензен', false, 2);

-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть положення в молекулі піразолу, за яким проходять реакції електрофільного заміщення. o', NULL, 'medium', 49, true, '/test-images/organic/tema1/page14_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2', false, 0),
  ((SELECT id FROM inserted_question), '1', false, 1),
  ((SELECT id FROM inserted_question), '3', false, 2),
  ((SELECT id FROM inserted_question), '4', true, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);

-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За якою реакцією і механізмом відбувається перетворення толуолу на бромметилбензол? o', NULL, 'medium', 50, true, '/test-images/organic/tema1/page14_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Br2 в присутності FeBr3, SE (заміщення електрофільне)', false, 0),
  ((SELECT id FROM inserted_question), 'Br2 в присутності Fe, SE (заміщення електрофільне)', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція з бромом, SR (заміщення радикальне)', true, 2),
  ((SELECT id FROM inserted_question), 'Br2 в присутності Fe, SR (заміщення радикальне)', false, 3),
  ((SELECT id FROM inserted_question), 'HBr при УФ-опроміненні, SR (заміщення радикальне)', false, 4);

-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Продуктами реакції нітрування толуолу переважно будуть: o', NULL, 'medium', 51, true, '/test-images/organic/tema1/page14_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);
-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Реакція нітрування фенолу протікає з утворенням орто- і паранітрофенолу. До якого типу реакцій її відносять?', NULL, 'medium', 52, true, '/test-images/organic/tema1/page16_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Паралельна', true, 0),
  ((SELECT id FROM inserted_question), 'Послідовна', false, 1),
  ((SELECT id FROM inserted_question), 'Спряжена', false, 2),
  ((SELECT id FROM inserted_question), 'Зворотня', false, 3),
  ((SELECT id FROM inserted_question), 'Ланцюгова', false, 4);

-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні реакції нітрування аніліну його попередньо ацилюють з метою захисту аміногрупи від процесів окиснення. Який з нижче перерахованих реагентів при цьому використовують?', NULL, 'medium', 53, true, '/test-images/organic/tema1/page16_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '(CH3CO)2O', true, 0),
  ((SELECT id FROM inserted_question), 'CH3CHO', false, 1),
  ((SELECT id FROM inserted_question), 'C2H5Cl', false, 2),
  ((SELECT id FROM inserted_question), 'HNO2', false, 3),
  ((SELECT id FROM inserted_question), 'CHCl3 + NaOH', false, 4);

-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть положення в молекулі індолу, за яким проходить реакція його нітрування. o', NULL, 'medium', 54, true, '/test-images/organic/tema1/page16_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1', false, 0),
  ((SELECT id FROM inserted_question), '2', false, 1),
  ((SELECT id FROM inserted_question), '3', true, 2),
  ((SELECT id FROM inserted_question), '4', false, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);

-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть положення, за яким переважно проходить реакція нітрування саліцилової кислоти? o', NULL, 'medium', 55, true, '/test-images/organic/tema1/page16_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4', false, 0),
  ((SELECT id FROM inserted_question), '6', false, 1),
  ((SELECT id FROM inserted_question), '3 та 6', false, 2),
  ((SELECT id FROM inserted_question), '5', true, 3),
  ((SELECT id FROM inserted_question), '2', false, 4);
-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У технології фармацевтичних препаратів важливу роль мають: тиск, температура, концентрація. Зниження температури якого процесу збільшує вихід продуктів реакції?', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Екзотермічний', true, 0),
  ((SELECT id FROM inserted_question), 'Ендотермічний', false, 1),
  ((SELECT id FROM inserted_question), 'Ізохорний', false, 2),
  ((SELECT id FROM inserted_question), 'Ізобарний', false, 3),
  ((SELECT id FROM inserted_question), 'Адіабатичний', false, 4);

-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Одним з факторів, що впливають на збільшення виходу лікарської речовини у процесі його синтезу, є зниження енергії активації реакції. Цьому сприяє:', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення концентрації', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення концентрації', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищення температури', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження температури', false, 3),
  ((SELECT id FROM inserted_question), 'Додавання каталізатора', true, 4);

-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Перманґанатометрія використовується для визначення більшої кількості сполук неорганічної та органічної природи. Вкажіть основні переваги перед іншими оксидиметричними методами:', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Можливість використання різних типів індикаторів та необхідність в', false, 0),
  ((SELECT id FROM inserted_question), 'Легка можливість отримання перманґанту калію в чистому вигляді', false, 1),
  ((SELECT id FROM inserted_question), 'Висока селективність та чутливість визначення сполук', false, 2),
  ((SELECT id FROM inserted_question), 'Достатньо високий окисно-відновний потенціал та можливість', false, 3),
  ((SELECT id FROM inserted_question), 'Достатньо висока стійкість перманґанату калію та його розчинів', false, 4);

-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Ферменти (біологічні каталізатори) застосовують як фармакологічні препарати. Який механізм дії ферментів в біохімічних реакціях?', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Знижують енергію активації реакції', true, 0),
  ((SELECT id FROM inserted_question), 'Підвищують енергію активації реакції', false, 1),
  ((SELECT id FROM inserted_question), 'Інгібують процес реакції', false, 2),
  ((SELECT id FROM inserted_question), 'Змінюють константу швидкості реакції', false, 3),
  ((SELECT id FROM inserted_question), 'Змінюють порядок реакції', false, 4);

-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який механізм дії каталізатора у хімічній реакції?', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Змінює природу реагентів', false, 0);

-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для схеми перетворень крекінг відбувається на стадії: o', NULL, 'medium', 61, true, '/test-images/organic/tema1/page18_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1', true, 0),
  ((SELECT id FROM inserted_question), '2', false, 1),
  ((SELECT id FROM inserted_question), '3', false, 2),
  ((SELECT id FROM inserted_question), '4', false, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);

-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утворюється під час повного гідрування нафталіну?', NULL, 'medium', 62, true, '/test-images/organic/tema1/page18_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', true, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);
-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Перехід С2Н4 (алкен) —> С2Н6 (алкан) відбувається при проведенні реакції:', NULL, 'medium', 63, true, '/test-images/organic/tema1/page19_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідратації', false, 0),
  ((SELECT id FROM inserted_question), 'Дегідрування', false, 1),
  ((SELECT id FROM inserted_question), 'Гідрування', true, 2),
  ((SELECT id FROM inserted_question), 'Димеризацїї', false, 3),
  ((SELECT id FROM inserted_question), 'Дегідратації', false, 4);

-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час якої реакції відбувається перетворення С2H4 (алкен) – С2H6 (алкан)?', NULL, 'medium', 64, true, '/test-images/organic/tema1/page19_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідрування', true, 0),
  ((SELECT id FROM inserted_question), 'Димеризація', false, 1),
  ((SELECT id FROM inserted_question), 'Гідратація', false, 2),
  ((SELECT id FROM inserted_question), 'Дегідратація', false, 3),
  ((SELECT id FROM inserted_question), 'Дегідрування', false, 4);

-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При гідратації акрилової кислоти утворюється: o', NULL, 'medium', 65, true, '/test-images/organic/tema1/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених реакцій застосовується для ідентифікації кратних зв’язків в органічих сполуках?', NULL, 'medium', 66, true, '/test-images/organic/tema1/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакція Вагнера', true, 0),
  ((SELECT id FROM inserted_question), 'Перегрупування Гофмана', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція Кучерова', false, 2),
  ((SELECT id FROM inserted_question), 'Конденсація Кляйзена', false, 3);

-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть речовину, яка є вихідною сполукою в реакції полімеризації.', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Димер', false, 0),
  ((SELECT id FROM inserted_question), 'Нуклеофіл', false, 1),
  ((SELECT id FROM inserted_question), 'Мономер', true, 2),
  ((SELECT id FROM inserted_question), 'Полімер', false, 3),
  ((SELECT id FROM inserted_question), 'Поліпептид', false, 4);

-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час якого процесу ентропія системи зменшується?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сублімації', false, 0),
  ((SELECT id FROM inserted_question), 'Полімеризації', true, 1),
  ((SELECT id FROM inserted_question), 'Дисоціації', false, 2),
  ((SELECT id FROM inserted_question), 'Розчинення', false, 3),
  ((SELECT id FROM inserted_question), 'Випаровування', false, 4);

-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якої з наведених сполук можлива геометрична ізомерія?', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);
-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якої з наведених сполук можлива оптична ізомерія?', NULL, 'medium', 70, true, '/test-images/organic/tema1/page22_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Йодфторхлорметан (CHJFCl)', true, 0),
  ((SELECT id FROM inserted_question), 'Метан (CH4)', false, 1),
  ((SELECT id FROM inserted_question), 'Хлороформ (CHCl3)', false, 2),
  ((SELECT id FROM inserted_question), 'Дихлорметан (CH2Cl2)', false, 3),
  ((SELECT id FROM inserted_question), 'Тетрахлорметан (CСl4 )', false, 4);

-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для ароматичних вуглеводнів найбільш характерними є реакції:', NULL, 'medium', 71, true, '/test-images/organic/tema1/page22_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Елімінування', false, 0),
  ((SELECT id FROM inserted_question), 'Нуклеофільного заміщення', false, 1),
  ((SELECT id FROM inserted_question), 'Радикального заміщення', false, 2),
  ((SELECT id FROM inserted_question), 'Електрофільного приєднання', false, 3),
  ((SELECT id FROM inserted_question), 'Електрофільного заміщення', true, 4);

-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для відтворення карциноми Ерліха кролю щоденно наносилась певна кількість бензпірену (поліциклічний ароматичний вуглеводень) на депільовану ділянку шкіри. Який метод використовується для моделювання пухлини?', NULL, 'medium', 72, true, '/test-images/organic/tema1/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метод дії іонізуючого випромінювання', false, 0),
  ((SELECT id FROM inserted_question), 'Метод експлантації', false, 1),
  ((SELECT id FROM inserted_question), 'Метод введення гормонів', false, 2),
  ((SELECT id FROM inserted_question), 'Метод індукції', true, 3),
  ((SELECT id FROM inserted_question), 'Метод трансплатації', false, 4);
  ((SELECT id FROM inserted_question), 'Метод дії іонізуючого випромінювання', false, 0),
  ((SELECT id FROM inserted_question), 'Метод експлантації', false, 1),
  ((SELECT id FROM inserted_question), 'Метод введення гормонів', false, 2),
  ((SELECT id FROM inserted_question), 'Метод індукції', true, 3),
  ((SELECT id FROM inserted_question), 'Метод трансплатації', false, 4);

-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сполука складу С7H8O до похідних ароматичних вуглеводів та не утворює забарвлення з FeCl3 , при окисненні вона утворює бензойну кислоту. Що це за сполука?', NULL, 'medium', 73, true, '/test-images/organic/tema1/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензиловий спирт', true, 0),
  ((SELECT id FROM inserted_question), 'Метилфеніловий ефір', false, 1),
  ((SELECT id FROM inserted_question), 'о-Крезол', false, 2),
  ((SELECT id FROM inserted_question), 'м-Крезол', false, 3),
  ((SELECT id FROM inserted_question), 'п-Крезол', false, 4);

-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За якого числового значення n виконується правило Хюккеля (4n+2) для антрацену?', NULL, 'medium', 74, true, '/test-images/organic/tema1/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'N=10', false, 0),
  ((SELECT id FROM inserted_question), 'N=0', false, 1),
  ((SELECT id FROM inserted_question), 'N=2', false, 2),
  ((SELECT id FROM inserted_question), 'N=3', true, 3),
  ((SELECT id FROM inserted_question), 'N=1', false, 4);

-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У разі якого числового значення n виконується правило Хюккеля (4n+2) для нафталіну? o', NULL, 'medium', 75, true, '/test-images/organic/tema1/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'n=4', false, 0),
  ((SELECT id FROM inserted_question), 'n=2', true, 1),
  ((SELECT id FROM inserted_question), 'n=8', false, 2),
  ((SELECT id FROM inserted_question), 'n=1', false, 3),
  ((SELECT id FROM inserted_question), 'n=0', false, 4);
-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відповідно до правила Хюккеля критерієм ароматичності органічної сполуки є:', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Органічні сполуки, молекули яких складаються тільки з атомів', false, 0),
  ((SELECT id FROM inserted_question), 'Наявність циклогексанового кільця', false, 1),
  ((SELECT id FROM inserted_question), 'Наявність у структурі плоского циклу, який містить замкнену', false, 2),
  ((SELECT id FROM inserted_question), 'Наявність конденсованих ядер в молекулі', false, 3),
  ((SELECT id FROM inserted_question), 'Наявність в молекулі тільки одного замісника', false, 4);

-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В які положення гідроксильна група (-ОН) фенолу орієнтує входження наступних замісників в реакціях електрофільного заміщення (Se)?', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Вуглеводні та їх галогенопохідні'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Орто-, пара-', true, 0),
  ((SELECT id FROM inserted_question), 'Мета-', false, 1),
  ((SELECT id FROM inserted_question), 'Тільки пара-', false, 2),
  ((SELECT id FROM inserted_question), 'Орто-, мета-', false, 3),
  ((SELECT id FROM inserted_question), 'Пара-, мета-', false, 4);

COMMIT;
