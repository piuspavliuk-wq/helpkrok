BEGIN;

-- Тема: Оксигено- та сульфуровмісні органічні сполуки. Питання з Untitled document (2).txt + зображення з tema3.

-- Створити тему, якщо ще немає
INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Оксигено- та сульфуровмісні органічні сполуки', 'Оксигено- та сульфуровмісні сполуки', 3, true
FROM courses c
WHERE c.title = 'Основи знань про органічні сполуки'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки');

DELETE FROM question_options WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
);

DELETE FROM questions WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Зазначте правильне твердження щодо сполуки, яка має наступну будову:', NULL, 'medium', 1, true, '/test-images/organic/tema3/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відноситься до фосфоліпідів', false, 0),
  ((SELECT id FROM inserted_question), 'Є одноатомним спиртом', true, 1),
  ((SELECT id FROM inserted_question), 'Окиснюється до кетону', false, 2),
  ((SELECT id FROM inserted_question), 'Є багатоатомним спиртом', false, 3),
  ((SELECT id FROM inserted_question), 'Має бензенове кільце', false, 4);

-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Одним із методів лікування в разі отруєння метанолом є введення в організм (перорально чи внутрішньовенно) етанолу в кількостях, які у здорової людини викликають інтоксикацію. Чому цей спосіб лікування є ефективним?', NULL, 'medium', 2, true, '/test-images/organic/tema3/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Етанол блокує кофермент алкоголь- Дегідрогенази', false, 0),
  ((SELECT id FROM inserted_question), 'Етанол швидше розщеплюється, ніж метанол', false, 1),
  ((SELECT id FROM inserted_question), 'Етанол інактивує алкогольдегідрогеназу', false, 2),
  ((SELECT id FROM inserted_question), 'Етанол конкурує з метанолом за активний центр алкогольдегідрогенази', true, 3),
  ((SELECT id FROM inserted_question), 'Етанол пригнічує дифузію метанолу', false, 4);

-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хлорметан в медицині застосовують як місцевий знеболювальний засіб, а у виробництві деяких лікарських засобів він є проміжним продуктом технологічного ланцюга. Яка сполука утворюється в результаті лужного гідролізу хлорметану за наведеною схемою? CH3-Cl+NaOH \xrightarrow H2O ?', NULL, 'medium', 3, true, '/test-images/organic/tema3/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Етан', false, 0),
  ((SELECT id FROM inserted_question), 'b. Форміат натрію', false, 1),
  ((SELECT id FROM inserted_question), 'c. Метанол', true, 2),
  ((SELECT id FROM inserted_question), 'd. Метаналь', false, 3),
  ((SELECT id FROM inserted_question), 'e. Метан', false, 4);

-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод хроматографічного аналізу для розділення, ідентифікації та кількісного визначення метанолу й етанолу в суміші.', NULL, 'medium', 4, true, '/test-images/organic/tema3/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Панерова хромторафія', false, 0),
  ((SELECT id FROM inserted_question), 'Іонообмінна хроматографія', false, 1),
  ((SELECT id FROM inserted_question), 'Площинна хроматографія', false, 2),
  ((SELECT id FROM inserted_question), 'Осадова хроматографія', false, 3),
  ((SELECT id FROM inserted_question), 'Газорідинна хроматографія', true, 4);

-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У розчині якого спирту розчиняється міді (ІІ) гідроксид з утворенням синього забарвлення?', NULL, 'medium', 5, true, '/test-images/organic/tema3/page1_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Етанолу', false, 0),
  ((SELECT id FROM inserted_question), 'Метанолу', false, 1),
  ((SELECT id FROM inserted_question), 'Етан-1,2-діол', true, 2),
  ((SELECT id FROM inserted_question), 'Пропан-2-олу', false, 3),
  ((SELECT id FROM inserted_question), 'Пропан-1-олу', false, 4);

-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Кінцевим продуктом при нагріванні брометану з водним розчином калій гідроксиду є:', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Діетиловий етер', false, 0),
  ((SELECT id FROM inserted_question), 'Етен', false, 1),
  ((SELECT id FROM inserted_question), 'Етан', false, 2),
  ((SELECT id FROM inserted_question), 'Етанол', true, 3),
  ((SELECT id FROM inserted_question), 'Етанова кислота', false, 4);

-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Кінцевим продуктом нагрівання бромостану з водним розчином калій гідроксиду є:', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Етанол', true, 0),
  ((SELECT id FROM inserted_question), 'Етанова кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Етан', false, 2),
  ((SELECT id FROM inserted_question), 'Діетиловий етер', false, 3),
  ((SELECT id FROM inserted_question), 'Етен', false, 4);

-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Катіони третьої аналітичної групи (кислотно-основна класифікація) відокремлюють у систематичному ході аналізу за допомогою такого групового реагенту:', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1 М розчин сульфатної кислоти в присутності етанолу', true, 0),
  ((SELECT id FROM inserted_question), '1 М розчин хромату калію', false, 1),
  ((SELECT id FROM inserted_question), '0,1 М розчин карбонату натрію', false, 2),
  ((SELECT id FROM inserted_question), '0,1 М розчин оксалату амонію', false, 3),
  ((SELECT id FROM inserted_question), '1 М розчин карбонату амонію', false, 4);

-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити етанол (C2Н5ОН) від гліцерину (CH2OH–СНОН–CH2ОН)?', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'FeCl3', false, 0),
  ((SELECT id FROM inserted_question), 'НBr', false, 1),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 2),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 3),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 4);

-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для лікування алкоголізму лікар використав механізм пригнічення пристрасті до етанолу за принципом підсилення токсичної дії алкоголю. Який продукт окиснення етанолу є нейротоксичним?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аміак', false, 0),
  ((SELECT id FROM inserted_question), 'Ацетальдегід', true, 1),
  ((SELECT id FROM inserted_question), 'Піруват', false, 2),
  ((SELECT id FROM inserted_question), 'Лактат', false, 3),
  ((SELECT id FROM inserted_question), 'Вуглекислий газ', false, 4);

-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть речовину, що утворюється при здійсненні даної реакції:', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацетатна кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Етанол', false, 1),
  ((SELECT id FROM inserted_question), 'Етаналь', true, 2),
  ((SELECT id FROM inserted_question), 'Пропанон', false, 3),
  ((SELECT id FROM inserted_question), 'Пропаналь', false, 4);

-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який кінцевий продукт утворюється в результаті реакції естерифікації етанолу з оцтовою кислотою за наведеною нижче схемою?', NULL, 'medium', 12, true, '/test-images/organic/tema3/page3_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', true, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити Етанол (С2Н5ОН) від гліцерину ( CH2OH – CHOH - CH2OH)?', NULL, 'medium', 13, true, '/test-images/organic/tema3/page3_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'KMnO4', false, 0),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 1),
  ((SELECT id FROM inserted_question), 'Сu(OH)2', true, 2),
  ((SELECT id FROM inserted_question), 'HBr', false, 3),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 4);

-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання пропанола-2 з ацетону:', NULL, 'medium', 14, true, '/test-images/organic/tema3/page3_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2(Ni)', true, 0),
  ((SELECT id FROM inserted_question), 'CH3OH', false, 1),
  ((SELECT id FROM inserted_question), 'CH3I', false, 2),
  ((SELECT id FROM inserted_question), 'HCN', false, 3),
  ((SELECT id FROM inserted_question), 'HCOH', false, 4);

-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання пропанолу - 2 з ацетону', NULL, 'medium', 15, true, '/test-images/organic/tema3/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2', true, 0),
  ((SELECT id FROM inserted_question), 'CH3OH', false, 1),
  ((SELECT id FROM inserted_question), 'CH3I', false, 2),
  ((SELECT id FROM inserted_question), 'HCN', false, 3),
  ((SELECT id FROM inserted_question), 'HCOH', false, 4);

-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Застосування якого реагенту дозволяє одержати етиленгліколь за нижченаведеною схемою перетворення?', NULL, 'medium', 16, true, '/test-images/organic/tema3/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NH3', false, 0),
  ((SELECT id FROM inserted_question), 'H2O (H+)', true, 1),
  ((SELECT id FROM inserted_question), 'HClO4', false, 2),
  ((SELECT id FROM inserted_question), 'CH3COOH', false, 3),
  ((SELECT id FROM inserted_question), 'NaCl', false, 4);

-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку пару сполук можна відрізнити за допомогою реакції «срібного дзеркала»?', NULL, 'medium', 17, true, '/test-images/organic/tema3/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1,3-Бутадієн і 1,2-бутадієн', false, 0),
  ((SELECT id FROM inserted_question), 'Етанол і етиленгліколь', false, 1),
  ((SELECT id FROM inserted_question), 'Пропаналь і пропанон', true, 2),
  ((SELECT id FROM inserted_question), 'н-Бутан і ізобутан', false, 3),
  ((SELECT id FROM inserted_question), 'Пропан і пропен', false, 4);

-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При систематичних інтенсивних фізичних навантаженнях вміст жиру в жировій тканині зменшується. Він виходить із клітин у кров у формі:', NULL, 'medium', 18, true, '/test-images/organic/tema3/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вільних жирних кислот і гліцерину', true, 0),
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 2),
  ((SELECT id FROM inserted_question), 'Кетонових тіл', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкози', false, 4);

-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту віком 55 років для швидкого усунення нападу стенокардії призначено препарат із групи органічних нітратів. Укажіть цей препарат.', NULL, 'medium', 19, true, '/test-images/organic/tema3/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гліцерину тринітрат', true, 0),
  ((SELECT id FROM inserted_question), 'Пропранололу гідрохлорид', false, 1),
  ((SELECT id FROM inserted_question), 'Дигоксин', false, 2),
  ((SELECT id FROM inserted_question), 'Верапамілу гідрохлорид', false, 3);

-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При надходженні жирів до організму відбувається їх перетравлення та всмоктування. Які продукти гідролізу жирів всмоктуються у кишківнику?', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гліцерин,жирнікислоти', true, 0),
  ((SELECT id FROM inserted_question), 'Моноцукри', false, 1),
  ((SELECT id FROM inserted_question), 'Амінокислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїди', false, 3),
  ((SELECT id FROM inserted_question), 'Поліпептиди', false, 4);

-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які речовини можна одержати при лужному гідролізі трипальмітину?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрій пальмітат і гліцерин', true, 0),
  ((SELECT id FROM inserted_question), 'Гліцерин і пальмітинова кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Пальмітинова кислота і натрій гідроксид', false, 2),
  ((SELECT id FROM inserted_question), 'Гліцерин і натрій стеарат', false, 3),
  ((SELECT id FROM inserted_question), 'Натрій пальмітат і вода', false, 4);

-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для виявлення гліцерину може бути використана реакція дегідратації, в результаті якої утворюється речовина з різким подразнюючим запахом. Ця речовина:', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Диетиловий ефір', false, 0),
  ((SELECT id FROM inserted_question), 'Ацетон', false, 1),
  ((SELECT id FROM inserted_question), 'Акролеїн', true, 2),
  ((SELECT id FROM inserted_question), 'Оцтовий альдегід', false, 3),
  ((SELECT id FROM inserted_question), 'Аміак', false, 4);

-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Внутрішньоклітинний метаболізм гліцерину починається з його активації. Яка сполука утворюється в першій реакції його перетворення?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Холін', false, 0),
  ((SELECT id FROM inserted_question), 'Піруват', false, 1),
  ((SELECT id FROM inserted_question), 'Альфа-гліцеролфосфат', true, 2),
  ((SELECT id FROM inserted_question), 'Ацетилкоензим А', false, 3),
  ((SELECT id FROM inserted_question), 'Лактат', false, 4);

-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити етанол від гліцерину?', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 0),
  ((SELECT id FROM inserted_question), 'HBr', false, 1),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 2),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 3),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 4);

-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При очищенні гліцерину, який входить до складу багатьох лікарських форм, використовують активне вугілля. Яке явище лежить в основі цього процесу?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Адсорбція', true, 0),
  ((SELECT id FROM inserted_question), 'Когезія', false, 1),
  ((SELECT id FROM inserted_question), 'Адгезія', false, 2),
  ((SELECT id FROM inserted_question), 'Змочування', false, 3),
  ((SELECT id FROM inserted_question), 'Капілярна конденсація', false, 4);

-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Обмін гліцерину у тканинах тісно пов’язаний з гліколізом. Який метаболіт проміжного обміну гліцерину безпосередньо включається в гліколіз?', NULL, 'medium', 26, true, '/test-images/organic/tema3/page6_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дигідроксиацетонфосфат', true, 0),
  ((SELECT id FROM inserted_question), 'Піруват', false, 1),
  ((SELECT id FROM inserted_question), 'Триацилгліцерол', false, 2),
  ((SELECT id FROM inserted_question), 'Діацилгліцерол', false, 3),
  ((SELECT id FROM inserted_question), 'Фосфоенолпіровиноградна кислота', false, 4);

-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До якого класу органічних сполук можна віднести продукт повного ацетилювання гліцерину?', NULL, 'medium', 27, true, '/test-images/organic/tema3/page6_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Складний ефір', true, 0),
  ((SELECT id FROM inserted_question), 'Простий ефір', false, 1),
  ((SELECT id FROM inserted_question), 'Кетон', false, 2),
  ((SELECT id FROM inserted_question), 'Ацеталь', false, 3),
  ((SELECT id FROM inserted_question), 'Фенол', false, 4);

-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До якої групи органічних речовин належить глюкоза?', NULL, 'medium', 28, true, '/test-images/organic/tema3/page6_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Багатоатомних альдегідоспиртів', true, 0),
  ((SELECT id FROM inserted_question), 'Жирів', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроксикислот', false, 2),
  ((SELECT id FROM inserted_question), 'Багатоатомних фенолів', false, 3),
  ((SELECT id FROM inserted_question), 'Багатоатомних кетоспиртів', false, 4);

-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть сполуку із назвою 2-амінооцтова кислота:', NULL, 'medium', 29, true, '/test-images/organic/tema3/page6_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CH3-CH2-NH2', false, 0),
  ((SELECT id FROM inserted_question), 'CH3COOC2H5', false, 1),
  ((SELECT id FROM inserted_question), 'C2H5-O-CH3', false, 2),
  ((SELECT id FROM inserted_question), '*пятикутник*N-H', false, 3),
  ((SELECT id FROM inserted_question), 'NH2-CH2-COOH', true, 4);

-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утвориться внаслідок декарбоксилювання щавлевої кислоти НООС-СООН?', NULL, 'medium', 30, true, '/test-images/organic/tema3/page6_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оцтова кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Мурашина кислота', true, 1),
  ((SELECT id FROM inserted_question), 'Янтарний ангідрид', false, 2),
  ((SELECT id FROM inserted_question), 'Сукцинімід', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетон', false, 4);

-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У контрольно-аналітичній лабораторії хіміку необхідно провести стандартизацію розчину натрію гідроксиду. Який первинний стандартний розчин може бути для цього використаний?', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію хлорид', false, 0),
  ((SELECT id FROM inserted_question), 'Натрію тетраборат', false, 1),
  ((SELECT id FROM inserted_question), 'Оцтова кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Щавлева кислота', true, 3),
  ((SELECT id FROM inserted_question), 'Хлороводнева кислота', false, 4);

-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При взаємодії ацетилену з водою утворюється:', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензиловий спирт', false, 0),
  ((SELECT id FROM inserted_question), 'Етиленгліколь', false, 1),
  ((SELECT id FROM inserted_question), 'Етиловий спирт', false, 2),
  ((SELECT id FROM inserted_question), 'Оцтовий альдегід', true, 3),
  ((SELECT id FROM inserted_question), 'Щавлева кислота', false, 4);

-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сполука складу С7H8O до похідних ароматичних вуглеводів та не утворює забарвлення з FeCl3 , при окисненні вона утворює бензойну кислоту. Що це за сполука?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензиловий спирт', true, 0),
  ((SELECT id FROM inserted_question), 'Метилфеніловий ефір', false, 1),
  ((SELECT id FROM inserted_question), 'о-Крезол', false, 2),
  ((SELECT id FROM inserted_question), 'м-Крезол', false, 3),
  ((SELECT id FROM inserted_question), 'п-Крезол', false, 4);

-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть вид ізомерії, характерний для олеїнової кислоти:', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Цис-транс-стереомерія', true, 0),
  ((SELECT id FROM inserted_question), 'Оптична', false, 1),
  ((SELECT id FROM inserted_question), 'Кето-енольна таутомерія', false, 2),
  ((SELECT id FROM inserted_question), 'Енантіомерія', false, 3),
  ((SELECT id FROM inserted_question), 'Лактим-лактамна таутомерія', false, 4);

-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якої з наведених сполук можлива оптична ізомерія?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Йодфторхлорметан (CHJFCl)', true, 0),
  ((SELECT id FROM inserted_question), 'Метан (CH4)', false, 1),
  ((SELECT id FROM inserted_question), 'Хлороформ (CHCl3)', false, 2),
  ((SELECT id FROM inserted_question), 'Дихлорметан (CH2Cl2)', false, 3),
  ((SELECT id FROM inserted_question), 'Тетрахлорметан (CСl4 )', false, 4);

-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якої з наведених сполук можлива геометрична ізомерія?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Органічна сполука 2-бром-2,3- дихлорбутан є оптично активною. Укажіть кількість її оптичних ізомерів.', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4', true, 0),
  ((SELECT id FROM inserted_question), '3', false, 1),
  ((SELECT id FROM inserted_question), '8', false, 2),
  ((SELECT id FROM inserted_question), '2', false, 3),
  ((SELECT id FROM inserted_question), '6', false, 4);

-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізору контрольно-аналітичної лабораторії під час проведення якісного аналізу осадження сульфатів катіонів третьої аналітичної групи (Са2+, Sr2+, Ba2+) потрібно зменшити розчинність сульфатів. Яку речовину він має використати для цього?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аміловий спирт', false, 0),
  ((SELECT id FROM inserted_question), 'Хлороформ', false, 1),
  ((SELECT id FROM inserted_question), 'Дистильована вода', false, 2),
  ((SELECT id FROM inserted_question), 'Етиловий спирт', true, 3),
  ((SELECT id FROM inserted_question), 'Бензол', false, 4);

-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який амін при взаємодії з нітритною кислотою утворює етиловий спирт?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'C2H5 − NH2', true, 0),
  ((SELECT id FROM inserted_question), 'CH3 − NH − CH3', false, 1),
  ((SELECT id FROM inserted_question), 'C2H5 − NH − C2H5', false, 2),
  ((SELECT id FROM inserted_question), '(CH3)3N', false, 3),
  ((SELECT id FROM inserted_question), '(C2H5)3N', false, 4);

-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З якою метою поряд з використанням групового реактиву III аналітичної групи використовують етиловий спирт?', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Для подальшого розчинення утворених осадів', false, 0),
  ((SELECT id FROM inserted_question), 'Для запобігання комплексоутворення', false, 1),
  ((SELECT id FROM inserted_question), 'Для зміни рН середовища', false, 2),
  ((SELECT id FROM inserted_question), 'Для забезпечення повноти осадження всіх катіонів цієї групи', true, 3),
  ((SELECT id FROM inserted_question), 'Для дробного осадження катіонів', false, 4);

-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При йодиметричному визначенні формальдегіду у формаліні застосовують зворотне титрування. Надлишок йоду відтитровують стандартним розчином:', NULL, 'medium', 41, true, '/test-images/organic/tema3/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію тіосульфату', true, 0),
  ((SELECT id FROM inserted_question), 'Натрію нітрату', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію сульфату', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію карбонату', false, 3),
  ((SELECT id FROM inserted_question), 'Натрію фосфату', false, 4);

-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть продукти, які утворюються при нагріванні мурашиної кислоти із концентрованою сульфатною кислотою:', NULL, 'medium', 42, true, '/test-images/organic/tema3/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CO2 + H2O', false, 0),
  ((SELECT id FROM inserted_question), 'CO + H2', false, 1),
  ((SELECT id FROM inserted_question), 'CO + CO2 + H2O', false, 2),
  ((SELECT id FROM inserted_question), 'CO2 + H2', false, 3),
  ((SELECT id FROM inserted_question), 'CO + H2O', true, 4);

-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Мурашину та оцтову кислоти можна розрізнити за допомогою:', NULL, 'medium', 43, true, '/test-images/organic/tema3/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакції "срібного дзеркала"з [Ag(NH3)2]OH', true, 0),
  ((SELECT id FROM inserted_question), 'Взаємодії з NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'Реакції з бромною водою', false, 2),
  ((SELECT id FROM inserted_question), 'Реакції з NaHCO3', false, 3),
  ((SELECT id FROM inserted_question), 'Реакції з NH3', false, 4);

-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених сполук вкажіть резорцин (1,3-дигідроксибензен):', NULL, 'medium', 44, true, '/test-images/organic/tema3/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4.', false, 0),
  ((SELECT id FROM inserted_question), '5.', false, 1),
  ((SELECT id FROM inserted_question), '1.', true, 2),
  ((SELECT id FROM inserted_question), '3.', false, 3),
  ((SELECT id FROM inserted_question), '2.', false, 4);

-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджувана суміш містить катіони Mg2+, Ni2+, Co2+. За допомогою якого реактиву можна виявити катіони Ni2+ у цій суміші?', NULL, 'medium', 45, true, '/test-images/organic/tema3/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Диметилгліоксим', true, 0),
  ((SELECT id FROM inserted_question), 'Амоніак', false, 1),
  ((SELECT id FROM inserted_question), '1- нітрозо-2-нафтол', false, 2),
  ((SELECT id FROM inserted_question), 'Магнезон-1', false, 3),
  ((SELECT id FROM inserted_question), 'Алізарин', false, 4);

-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При нагріванні феноляту натрію в тоці CO2 утворюється карбонова кислота. Назвіть цю сполуку:', NULL, 'medium', 46, true, '/test-images/organic/tema3/page10_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Саліцилова кислота»', false, 0),
  ((SELECT id FROM inserted_question), 'Етилсаліцилат', false, 1),
  ((SELECT id FROM inserted_question), 'Амінофенол', false, 2),
  ((SELECT id FROM inserted_question), 'Фенілсаліцилат', false, 3),
  ((SELECT id FROM inserted_question), 'Бензойна кислота', false, 4);

-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що деякі хімічні сполуки роз’єднують тканинне дихання та окисне фосфорилювання. Назвіть одну з таких сполук:', NULL, 'medium', 47, true, '/test-images/organic/tema3/page11_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2,4-динітрофенол', true, 0),
  ((SELECT id FROM inserted_question), 'Чадний газ', false, 1),
  ((SELECT id FROM inserted_question), 'Антиміцин А', false, 2),
  ((SELECT id FROM inserted_question), 'Молочна кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетил-КоА', false, 4);

-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До аптеки звернувся спортсмен-бодібілдер зі скаргами на гіпертермію. Відомо, що він для покращення спортивних результатів ужив заборонену допінг-сполуку 2,4-динітрофенол, що роз’єднує окисне фосфорилювання. Який механізм дії цієї сполуки на мітохондрії пояснює такі симптоми ?', NULL, 'medium', 48, true, '/test-images/organic/tema3/page11_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення споживання кисню та активація синтезу АТФ', false, 0),
  ((SELECT id FROM inserted_question), 'Збільшення рівня ацетил-КоА та Стимуляція ЦТК', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження синтезу АТФ та виділення енергії у вигляді тепла', true, 2),
  ((SELECT id FROM inserted_question), 'Зниження споживання кисню та пригнічення синтезу АТФ', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення використання АТФ для синтезу цАМФ', false, 4);

-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Реакція нітрування фенолу протікає з утворенням орто- і паранітрофенолу. До якого типу реакцій її відносять?', NULL, 'medium', 49, true, '/test-images/organic/tema3/page11_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Паралельна', true, 0),
  ((SELECT id FROM inserted_question), 'Послідовна', false, 1),
  ((SELECT id FROM inserted_question), 'Спряжена', false, 2),
  ((SELECT id FROM inserted_question), 'Зворотня', false, 3),
  ((SELECT id FROM inserted_question), 'Ланцюгова', false, 4);

-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утворюється в результаті реакції бромування нафталіну?', NULL, 'medium', 50, true, '/test-images/organic/tema3/page11_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '5.', false, 0),
  ((SELECT id FROM inserted_question), '2.', false, 1),
  ((SELECT id FROM inserted_question), '1.', true, 2),
  ((SELECT id FROM inserted_question), '4.', false, 3),
  ((SELECT id FROM inserted_question), '3.', false, 4);

-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Бромування якої із наведених сполук буде перебігати із найбільшою швидкістю?', NULL, 'medium', 51, true, '/test-images/organic/tema3/page11_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
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
  SELECT t.id, 'Вкажіть, у присутності якого з замісників Х бромування перебігає з утворенням трибромпохідного?', NULL, 'medium', 52, true, '/test-images/organic/tema3/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Х = OH', true, 0),
  ((SELECT id FROM inserted_question), 'Х = COOH', false, 1),
  ((SELECT id FROM inserted_question), 'Х = NO2', false, 2),
  ((SELECT id FROM inserted_question), 'Х = CHO', false, 3),
  ((SELECT id FROM inserted_question), 'Х = SO3H', false, 4);

-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який електрофільний реагент застосовується для сульфування піролу і фурану?', NULL, 'medium', 53, true, '/test-images/organic/tema3/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'b. Концентрована сульфатна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'c. Розбавлена сульфатна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'd. Піридинсульфотриоксид', true, 3),
  ((SELECT id FROM inserted_question), 'e. Суміш сульфатної і нітратної кислот', false, 4);

-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для сульфування ацидофобних сполук, зокрема фурану, використовують:', NULL, 'medium', 54, true, '/test-images/organic/tema3/page12_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'Розведену сірчану кислоту', false, 1),
  ((SELECT id FROM inserted_question), 'Піридинсульфотриоксид C6H5N • SO3', true, 2),
  ((SELECT id FROM inserted_question), 'Концентровану сірчану кислоту', false, 3),
  ((SELECT id FROM inserted_question), '”Царську горілку”', false, 4);

-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При сульфуванні нафталіну концентрованою сульфатною кислотою при температурі вищій за 160oC утворюється:', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2-нафталінсульфокислота', true, 0),
  ((SELECT id FROM inserted_question), '1-нафталінсульфокислота', false, 1),
  ((SELECT id FROM inserted_question), '3-нафталінсульфокислота', false, 2),
  ((SELECT id FROM inserted_question), '4-нафталінсульфокислота', false, 3),
  ((SELECT id FROM inserted_question), '5-нафталінсульфокислота', false, 4);

-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть індикатори для ацидіметричного визначення речовин у суміші NaOH та Na2CO3:', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фенолфталеїн, метиловий оранжевий', true, 0),
  ((SELECT id FROM inserted_question), 'Калію хромат, залізоамонійні квасці', false, 1),
  ((SELECT id FROM inserted_question), 'Еозин, флюоресцеїн', false, 2),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазон, дифенлікарбазид', false, 3),
  ((SELECT id FROM inserted_question), 'Тропеолін 00, метиленовий синій', false, 4);

-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сполука якого кольору утворюється внаслідок взаємодії саліцилат-іонів з іонами Fe3+ в кислому середовищі?', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Коричневого', false, 0),
  ((SELECT id FROM inserted_question), 'Чорного', false, 1),
  ((SELECT id FROM inserted_question), 'Фіолетового', true, 2),
  ((SELECT id FROM inserted_question), 'Зеленого', false, 3),
  ((SELECT id FROM inserted_question), 'Синього', false, 4);

-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених речовин при додаванні розчину FeCl3 дає темно- фіолетове забарвлення?', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У трьох пронумерованих пробірках відбуваються реакції з утворенням газів: 1-етилену, 2-ацетилену, 3-пропену, які пропускали через аміачний розчин при взаємодії із вказаним реагентом аргентум оксиду. Газ із якої пробірки при взаємодії із вказаним реагентом утворить білий осад?', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лише з 3-ї', false, 0),
  ((SELECT id FROM inserted_question), 'Лише з 1-ї', false, 1),
  ((SELECT id FROM inserted_question), 'З 1-ї та 3-ї', false, 2),
  ((SELECT id FROM inserted_question), 'Лише з 2-ї', true, 3),
  ((SELECT id FROM inserted_question), 'З 2-ї та 3-ї', false, 4);

-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні систематичного ходу аналізу на розчин подіяли груповим реагентом 1М H2SO4 у присутності етилового спирту, утворився білий осад. Катіони якої групи присутні у розчині?', NULL, 'medium', 60, true, '/test-images/organic/tema3/page14_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'III', true, 0),
  ((SELECT id FROM inserted_question), 'IV', false, 1),
  ((SELECT id FROM inserted_question), 'II', false, 2),
  ((SELECT id FROM inserted_question), 'VI', false, 3),
  ((SELECT id FROM inserted_question), 'I', false, 4);

-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При взаємодії фенолу з водним розчином брому утворюється:', NULL, 'medium', 61, true, '/test-images/organic/tema3/page14_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2,4,6-трибромфенол', true, 0),
  ((SELECT id FROM inserted_question), 'м-бромфенол', false, 1),
  ((SELECT id FROM inserted_question), '2,5-дибромфенол', false, 2),
  ((SELECT id FROM inserted_question), '3,5-дибромфенол', false, 3),
  ((SELECT id FROM inserted_question), '2,4,5-трибромфенол', false, 4);

-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'D-галактоза вступає в реакцію з амоніачним розчином аргентум оксиду. Укажіть функціональну групу, за рахунок якої відбувається ця реакція.', NULL, 'medium', 62, true, '/test-images/organic/tema3/page15_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карбоксильна', false, 0),
  ((SELECT id FROM inserted_question), 'Етерна', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроксильна', false, 2),
  ((SELECT id FROM inserted_question), 'Альдегідна', true, 3),
  ((SELECT id FROM inserted_question), 'Естерна', false, 4);

-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При взаємодії ацетилену з водою утворюється:', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензиловий спирт', false, 0),
  ((SELECT id FROM inserted_question), 'Етиленгліколь', false, 1),
  ((SELECT id FROM inserted_question), 'Етиловий спирт', false, 2),
  ((SELECT id FROM inserted_question), 'Оцтовий альдегід', true, 3),
  ((SELECT id FROM inserted_question), 'Щавлева кислота', false, 4);

-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть правильну назву продукту реакції взаємодії оцтового альдегіду з гідразином:', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідразон оцтового альдегіду', true, 0),
  ((SELECT id FROM inserted_question), 'Оксим оцтового альдегіду', false, 1),
  ((SELECT id FROM inserted_question), 'Ацетальдимін', false, 2),
  ((SELECT id FROM inserted_question), 'Фенілгідразин оцтового альдегіду', false, 3),
  ((SELECT id FROM inserted_question), 'Семикарбазон оцтового альдегіду', false, 4);

-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт під час лікування метронідазолом вжив алкоголь, внаслідок чого розвинулося тяжке отруєння. Яка причина отруєння?', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Порушення функції нирок', false, 0),
  ((SELECT id FROM inserted_question), 'Неврологічний розлад', false, 1),
  ((SELECT id FROM inserted_question), 'Накопичення ацетальдегіду', true, 2),
  ((SELECT id FROM inserted_question), 'Серцево-судинна недостатність', false, 3),
  ((SELECT id FROM inserted_question), 'Алергічна реакція', false, 4);

-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт утворюється внаслідок взаємодії альдегідів і кетонів із первинними амінами?', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спирт', false, 0),
  ((SELECT id FROM inserted_question), 'Нітрил', false, 1),
  ((SELECT id FROM inserted_question), 'Діазин', false, 2),
  ((SELECT id FROM inserted_question), 'Азометин', true, 3),
  ((SELECT id FROM inserted_question), 'Тіол', false, 4);

-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть, до якого класу належать продукти конденсації альдегідів із, гідроксиламіном.', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідразиди', false, 0),
  ((SELECT id FROM inserted_question), 'Гідразони', false, 1),
  ((SELECT id FROM inserted_question), 'Напівацеталі', false, 2),
  ((SELECT id FROM inserted_question), 'Кетоксими', false, 3),
  ((SELECT id FROM inserted_question), 'Альдоксими', true, 4);

-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт утворюється внаслідок взаємодії аніліну з бензальдегідом?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ціангідрин', false, 0),
  ((SELECT id FROM inserted_question), 'N-бензиліденанілін', true, 1),
  ((SELECT id FROM inserted_question), 'Оксим', false, 2),
  ((SELECT id FROM inserted_question), 'N,N-диметиланілін', false, 3),
  ((SELECT id FROM inserted_question), 'Напівацеталь', false, 4);

-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених реакцій вкажіть реакцію Канніццаро (диспропорціонування альдегідів):', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'B', false, 0),
  ((SELECT id FROM inserted_question), 'C', true, 1),
  ((SELECT id FROM inserted_question), 'A', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як називається альдегід наступної будови:', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2 ,3-диметилгексеналь', false, 0),
  ((SELECT id FROM inserted_question), '3- метилгексаналь', false, 1),
  ((SELECT id FROM inserted_question), '1 ,2-диметилпентаналь', false, 2),
  ((SELECT id FROM inserted_question), '2 ,3-диметилгексаналь', true, 3),
  ((SELECT id FROM inserted_question), '2- метил-3-пропілбутаналь', false, 4);

-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт утворюється при взаємодії пропіонового альдегіду з PCl5?', NULL, 'medium', 71, true, '/test-images/organic/tema3/page18_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4.', false, 0),
  ((SELECT id FROM inserted_question), '5.', false, 1),
  ((SELECT id FROM inserted_question), '3.', false, 2),
  ((SELECT id FROM inserted_question), '1.', true, 3),
  ((SELECT id FROM inserted_question), '2.', false, 4);

-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реактивом можна одночасно визначити наявність альдегідної групи та глікольного фрагменту в молекулі глюкози?', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Br2', false, 0),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 1),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 2),
  ((SELECT id FROM inserted_question), 'AlCl3', false, 3),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 4);

-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт утворюється при взаємодії пропіонового альдегіду з PCl5?', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Бензальдегід в умовах реакції Канніццаро утворює:', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук у результаті лужного гідролізу (H2O, OH−) утворює пропіоновий альдегід?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту можна довести наявність альдегідної групи у молекулі фурфуролу?', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '[Ag(NH3)2]OH', true, 0),
  ((SELECT id FROM inserted_question), '(CH3CO)2O', false, 1),
  ((SELECT id FROM inserted_question), 'NaNO2', false, 2),
  ((SELECT id FROM inserted_question), 'NH3', false, 3),
  ((SELECT id FROM inserted_question), 'NaOH', false, 4);

-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Галактоза відноситься до альдегідоспиртів і подібно альдегідам взаємодіє з синильною кислотою (HCN ) за механізмом:', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A N', true, 0),
  ((SELECT id FROM inserted_question), 'SN 1', false, 1),
  ((SELECT id FROM inserted_question), 'SN 2', false, 2),
  ((SELECT id FROM inserted_question), 'AE', false, 3),
  ((SELECT id FROM inserted_question), 'SR', false, 4);

-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За яким механізмом відбувається реакція приєднання етанолу до оцтового альдегіду?', NULL, 'medium', 78, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'AN Нуклеофільне приєднання', true, 0),
  ((SELECT id FROM inserted_question), 'AE Електрофільне приєднання', false, 1),
  ((SELECT id FROM inserted_question), 'SE Електрофільне заміщення', false, 2),
  ((SELECT id FROM inserted_question), 'SN Нуклеофільне заміщення', false, 3),
  ((SELECT id FROM inserted_question), 'SR Радикальне заміщення', false, 4);

-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Назвіть продукт складноефірної конденсації ацетальдегіду (реакції Тищенка):', NULL, 'medium', 79, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Етилацетат', true, 0),
  ((SELECT id FROM inserted_question), 'Ацетон', false, 1),
  ((SELECT id FROM inserted_question), 'Кротоновий альдегід', false, 2),
  ((SELECT id FROM inserted_question), 'Малонова кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетооцтовий альдегід', false, 4);

-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З якою із наведених сполук реакції електрофільного заміщення (SE) відбуваються найлегше?', NULL, 'medium', 80, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фенол', true, 0),
  ((SELECT id FROM inserted_question), 'Толуол', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорбензол', false, 2),
  ((SELECT id FROM inserted_question), 'Бензальдегід', false, 3),
  ((SELECT id FROM inserted_question), 'Бензолсульфокислота', false, 4);

-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Молекула ізатину містить усвоєму складі кетонну групу. За допомогою якого реагенту можна це довести?', NULL, 'medium', 81, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NН2OН', true, 0),
  ((SELECT id FROM inserted_question), 'CH3C(О)Cl', false, 1),
  ((SELECT id FROM inserted_question), 'NaНCO3', false, 2),
  ((SELECT id FROM inserted_question), 'NaOH', false, 3),
  ((SELECT id FROM inserted_question), '[Ag(NH3)2]OH', false, 4);

-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Зазначте правильне твердження щодо сполуки, яка має наступну будову:', NULL, 'medium', 82, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відноситься до фосфоліпідів', false, 0),
  ((SELECT id FROM inserted_question), 'Є одноатомним спиртом', true, 1),
  ((SELECT id FROM inserted_question), 'Окиснюється до кетону', false, 2),
  ((SELECT id FROM inserted_question), 'Є багатоатомним спиртом', false, 3),
  ((SELECT id FROM inserted_question), 'Має бензенове кільце', false, 4);

-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених карбонільних сполук дає позитивну йодоформну пробу?', NULL, 'medium', 83, true, '/test-images/organic/tema3/page20_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які сполуки утворюються під час окислення первинних спиртів за наступною схемою:', NULL, 'medium', 84, true, '/test-images/organic/tema3/page21_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', true, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За значенням рКа наведених карбонових кислот виберіть найслабшу:', NULL, 'medium', 85, true, '/test-images/organic/tema3/page21_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Масляна (рКа = 4,82)', false, 0),
  ((SELECT id FROM inserted_question), 'Пропіонова (рКа = 4 , 9)', true, 1),
  ((SELECT id FROM inserted_question), 'Молочна (рКа = 3 , 9)', false, 2),
  ((SELECT id FROM inserted_question), 'Мурашина (рКа = 3 , 7)', false, 3),
  ((SELECT id FROM inserted_question), 'Оцтова (рКа = 4 , 7)', false, 4);

-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аміак - це дуже токсична речовина, насамперед для нервової системи. 3 яким метаболітом циклу трикарбонових кислот звʼязується аміак, утворюючи глутамат і глутамін?', NULL, 'medium', 86, true, '/test-images/organic/tema3/page21_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фумаратом', false, 0),
  ((SELECT id FROM inserted_question), 'Цитратом', false, 1),
  ((SELECT id FROM inserted_question), 'Малатом', false, 2),
  ((SELECT id FROM inserted_question), 'Сукцинатом', false, 3),
  ((SELECT id FROM inserted_question), 'α-кетоглутаратом', true, 4);

-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених карбонових кислот є ароматичною монокарбоновою кислотою та застосовується у разі захворювань шкіри як зовнішній антисептичний та фунгіцидний засіб?', NULL, 'medium', 87, true, '/test-images/organic/tema3/page21_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a.Валеріанова', false, 0),
  ((SELECT id FROM inserted_question), 'b.Оцтова', false, 1),
  ((SELECT id FROM inserted_question), 'c.Мурашина', false, 2),
  ((SELECT id FROM inserted_question), 'd.Бензойна', true, 3),
  ((SELECT id FROM inserted_question), 'e.Масляна', false, 4);

-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт утворюється внаслідок взаємодії аніліну з бензальдегідом?', NULL, 'medium', 88, true, '/test-images/organic/tema3/page22_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ціангідрин', false, 0),
  ((SELECT id FROM inserted_question), 'N-бензиліденанілін', true, 1),
  ((SELECT id FROM inserted_question), 'Оксим', false, 2),
  ((SELECT id FROM inserted_question), 'N,N-диметиланілін', false, 3),
  ((SELECT id FROM inserted_question), 'Напівацеталь', false, 4);

-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання ціангідрину ацетону:', NULL, 'medium', 89, true, '/test-images/organic/tema3/page22_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCN', true, 0),
  ((SELECT id FROM inserted_question), 'H2N-ОН', false, 1),
  ((SELECT id FROM inserted_question), 'H2N-NH2', false, 2),
  ((SELECT id FROM inserted_question), 'H2N−NH−C6H5', false, 3),
  ((SELECT id FROM inserted_question), 'H2N − CH3', false, 4);

-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть, до якого класу належать продукти конденсації альдегідів із, гідроксиламіном.', NULL, 'medium', 90, true, '/test-images/organic/tema3/page22_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідразиди', false, 0),
  ((SELECT id FROM inserted_question), 'Гідразони', false, 1),
  ((SELECT id FROM inserted_question), 'Напівацеталі', false, 2),
  ((SELECT id FROM inserted_question), 'Кетоксими', false, 3),
  ((SELECT id FROM inserted_question), 'Альдоксими', true, 4);

-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть правильну назву продукту реакції взаємодії оцтового альдегіду з гідразином:', NULL, 'medium', 91, true, '/test-images/organic/tema3/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідразон оцтового альдегіду', true, 0),
  ((SELECT id FROM inserted_question), 'Оксим оцтового альдегіду', false, 1),
  ((SELECT id FROM inserted_question), 'Ацетальдимін', false, 2),
  ((SELECT id FROM inserted_question), 'Фенілгідразин оцтового альдегіду', false, 3),
  ((SELECT id FROM inserted_question), 'Семикарбазон оцтового альдегіду', false, 4);

-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який з наведених спиртів при окисненні утворює ацетон?', NULL, 'medium', 92, true, '/test-images/organic/tema3/page23_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сполука складу С7H8O до похідних ароматичних вуглеводів та не утворює забарвлення з FeCl3 , при окисненні вона утворює бензойну кислоту. Що це за сполука?', NULL, 'medium', 93, true, '/test-images/organic/tema3/page24_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензиловий спирт', true, 0),
  ((SELECT id FROM inserted_question), 'Метилфеніловий ефір', false, 1),
  ((SELECT id FROM inserted_question), 'о-Крезол', false, 2),
  ((SELECT id FROM inserted_question), 'м-Крезол', false, 3),
  ((SELECT id FROM inserted_question), 'п-Крезол', false, 4);

-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Бензальдегід в умовах реакції Канніццаро утворює:', NULL, 'medium', 94, true, '/test-images/organic/tema3/page25_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть порядок реакції розкладання ацетону:', NULL, 'medium', 95, true, '/test-images/organic/tema3/page25_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Третій', false, 0),
  ((SELECT id FROM inserted_question), 'Другий', false, 1),
  ((SELECT id FROM inserted_question), 'Перший', true, 2),
  ((SELECT id FROM inserted_question), 'Дробний', false, 3),
  ((SELECT id FROM inserted_question), 'Нульовий', false, 4);

-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У результаті якої з наведених реакцій утворюється ацетон?', NULL, 'medium', 96, true, '/test-images/organic/tema3/page26_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4.', false, 0),
  ((SELECT id FROM inserted_question), '3.', false, 1),
  ((SELECT id FROM inserted_question), '2.', false, 2),
  ((SELECT id FROM inserted_question), '5.', false, 3),
  ((SELECT id FROM inserted_question), '1.', true, 4);

-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть сполуку, із якої в одну стадію можна синтезувати ацетонітрил', NULL, 'medium', 97, true, '/test-images/organic/tema3/page26_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'C2H5-Cl', false, 0),
  ((SELECT id FROM inserted_question), 'CH3-OH', false, 1),
  ((SELECT id FROM inserted_question), 'C6H5CI', false, 2),
  ((SELECT id FROM inserted_question), 'CH4', false, 3),
  ((SELECT id FROM inserted_question), 'CH3-I', true, 4);

-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який з наведених спиртів при окисненні утворює ацетон?', NULL, 'medium', 98, true, '/test-images/organic/tema3/page27_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть сполуку, із якої в одну стадію можна синтезувати ацетонітрил CH3- C ≡ N', NULL, 'medium', 99, true, '/test-images/organic/tema3/page27_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CH3-I', true, 0),
  ((SELECT id FROM inserted_question), 'CH4', false, 1),
  ((SELECT id FROM inserted_question), 'CH3-OH', false, 2),
  ((SELECT id FROM inserted_question), 'C2H5-Cl', false, 3),
  ((SELECT id FROM inserted_question), 'C6H5Cl', false, 4);

-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання ціангідрину ацетону:', NULL, 'medium', 100, true, '/test-images/organic/tema3/page27_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCN', true, 0),
  ((SELECT id FROM inserted_question), 'H2N-ОН', false, 1),
  ((SELECT id FROM inserted_question), 'H2N-NH2', false, 2),
  ((SELECT id FROM inserted_question), 'H2N−NH−C6H5', false, 3),
  ((SELECT id FROM inserted_question), 'H2N − CH3', false, 4);

-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання пропанола-2 з ацетону:', NULL, 'medium', 101, true, '/test-images/organic/tema3/page28_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2(Ni)', true, 0),
  ((SELECT id FROM inserted_question), 'CH3OH', false, 1),
  ((SELECT id FROM inserted_question), 'CH3I', false, 2),
  ((SELECT id FROM inserted_question), 'HCN', false, 3),
  ((SELECT id FROM inserted_question), 'HCOH', false, 4);

-- Question 102
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання пропанолу - 2 з ацетону', NULL, 'medium', 102, true, '/test-images/organic/tema3/page28_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2', true, 0),
  ((SELECT id FROM inserted_question), 'CH3OH', false, 1),
  ((SELECT id FROM inserted_question), 'CH3I', false, 2),
  ((SELECT id FROM inserted_question), 'HCN', false, 3),
  ((SELECT id FROM inserted_question), 'HCOH', false, 4);

-- Question 103
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При йодиметричному визначенні формальдегіду у формаліні застосовують зворотне титрування. Надлишок йоду відтитровують стандартним розчином:', NULL, 'medium', 103, true, '/test-images/organic/tema3/page28_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію тіосульфату', true, 0),
  ((SELECT id FROM inserted_question), 'Натрію нітрату', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію сульфату', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію карбонату', false, 3),
  ((SELECT id FROM inserted_question), 'Натрію фосфату', false, 4);

-- Question 104
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реактивом можна одночасно визначити наявність альдегідної групи та глікольного фрагменту в молекулі глюкози?', NULL, 'medium', 104, true, '/test-images/organic/tema3/page28_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Br2', false, 0),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 1),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 2),
  ((SELECT id FROM inserted_question), 'AlCl3', false, 3),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 4);

-- Question 105
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який із перелічених моносахаридів відноситься до кетоз?', NULL, 'medium', 105, true, '/test-images/organic/tema3/page29_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Маноза', false, 0),
  ((SELECT id FROM inserted_question), 'Глюкоза', false, 1),
  ((SELECT id FROM inserted_question), 'Рибоза', false, 2),
  ((SELECT id FROM inserted_question), 'Фруктоза', true, 3),
  ((SELECT id FROM inserted_question), 'Галактоза', false, 4);

-- Question 106
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який продукт буде утворюватися при гідролізі крохмалю?', NULL, 'medium', 106, true, '/test-images/organic/tema3/page29_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глюкоза', true, 0),
  ((SELECT id FROM inserted_question), 'Маноза', false, 1),
  ((SELECT id FROM inserted_question), 'Галактоза', false, 2),
  ((SELECT id FROM inserted_question), 'Фруктоза', false, 3),
  ((SELECT id FROM inserted_question), 'Рибоза', false, 4);

-- Question 107
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки, яка страждає на цукровий діабет І типу, розвинулася гіперглікемічна кома. Результати обстеження виявили метаболічний ацидоз. Накопичення яких речовин в крові призвело до розвитку цього стану?', NULL, 'medium', 107, true, '/test-images/organic/tema3/page29_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жовчних кислот', false, 0),
  ((SELECT id FROM inserted_question), 'Непрямого білірубіну', false, 1),
  ((SELECT id FROM inserted_question), 'Іонів амонію', false, 2),
  ((SELECT id FROM inserted_question), 'Кетонових тіл', true, 3),
  ((SELECT id FROM inserted_question), 'Залишкового азоту', false, 4);

-- Question 108
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка із наведених формул відповідає ацетооцтовій кислоті?', NULL, 'medium', 108, true, '/test-images/organic/tema3/page30_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);

-- Question 109
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед нижченаведених речовин укажіть сполуку, що не дає позитивної йодоформної проби.', NULL, 'medium', 109, true, '/test-images/organic/tema3/page30_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метилетилкетон', false, 0),
  ((SELECT id FROM inserted_question), 'Етаналь', false, 1),
  ((SELECT id FROM inserted_question), 'Ацетон', false, 2),
  ((SELECT id FROM inserted_question), 'Етанол', false, 3),
  ((SELECT id FROM inserted_question), 'Диметиловий етер', true, 4);

-- Question 110
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт скаржиться на збільшення добової кількості сечі та спрагу. Під час лабораторного аналізу у сечі виявлено ацетон і високий рівень цукру. Порушення секреції якого гормону викликало ці зміни?', NULL, 'medium', 110, true, '/test-images/organic/tema3/page31_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інсулін', true, 0),
  ((SELECT id FROM inserted_question), 'Тестостерон', false, 1),
  ((SELECT id FROM inserted_question), 'Альдостерон', false, 2),
  ((SELECT id FROM inserted_question), 'Глюкагон', false, 3),
  ((SELECT id FROM inserted_question), 'Вазопресин', false, 4);

-- Question 111
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У реанімаційне відділення доставили хворого без свідомості. Відмічаються запах ацетону з рота, різка гіперглікемія та кетонемія. Яке з ускладнень цукрового діабету має місце в даному випадку?', NULL, 'medium', 111, true, '/test-images/organic/tema3/page31_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Діабетична кома', true, 0),
  ((SELECT id FROM inserted_question), 'Нефрит', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпоглікемічна кома', false, 2),
  ((SELECT id FROM inserted_question), 'Катаракта', false, 3),
  ((SELECT id FROM inserted_question), 'Гостре отруєння ацетоном', false, 4);

-- Question 112
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть порядок реакції розкладання ацетону:', NULL, 'medium', 112, true, '/test-images/organic/tema3/page32_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Третій', false, 0),
  ((SELECT id FROM inserted_question), 'Другий', false, 1),
  ((SELECT id FROM inserted_question), 'Перший', true, 2),
  ((SELECT id FROM inserted_question), 'Дробний', false, 3),
  ((SELECT id FROM inserted_question), 'Нульовий', false, 4);

-- Question 113
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У результаті якої з наведених реакцій утворюється ацетон?', NULL, 'medium', 113, true, '/test-images/organic/tema3/page32_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4.', false, 0),
  ((SELECT id FROM inserted_question), '3.', false, 1),
  ((SELECT id FROM inserted_question), '2.', false, 2),
  ((SELECT id FROM inserted_question), '5.', false, 3),
  ((SELECT id FROM inserted_question), '1.', true, 4);

-- Question 114
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий доставлений у лікарню. При обстеженні: порушення свідомості по типу сопору, шкіра бліда, волога, тахіпноє, запах ацетону з рота. Рівень глікемії 22 ммоль/л, глюкоза в сечі. Який патологічний стан спостерігається у хворого?', NULL, 'medium', 114, true, '/test-images/organic/tema3/page32_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Оксигено- та сульфуровмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічна ниркова недостатність', false, 0),
  ((SELECT id FROM inserted_question), 'Кетоацидотична кома', true, 1),
  ((SELECT id FROM inserted_question), 'Тром6оєм6олія легеневої артерїї', false, 2),
  ((SELECT id FROM inserted_question), 'Гостре порушення мозкового кровообігу', false, 3),
  ((SELECT id FROM inserted_question), 'Інфаркт міокарда', false, 4);

COMMIT;
