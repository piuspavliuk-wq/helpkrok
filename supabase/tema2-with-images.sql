BEGIN;

-- Auto-generated from PDF with images
INSERT INTO courses (title, description, faculty, order_index, is_active)
SELECT 'Основи знань про органічні сполуки', 'Автоматично імпортований курс', 'pharmaceutical', 1, true
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Основи знань про органічні сполуки');

INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Нітрогеновмісні органічні сполуки', 'Автоматично імпортована тема', 2, true
FROM courses c
WHERE c.title = 'Основи знань про органічні сполуки'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Нітрогеновмісні органічні сполуки');

ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якій із наведених сполук присутня первинна ароматична аміногрупа? Якою реакцією можна це підтвердити?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '(CH3)2NH (диметиламін). Реакція з HCI', false, 0),
  ((SELECT id FROM inserted_question), '(C6H5)2NH (дифеніламін). Реакція діазотування', false, 1),
  ((SELECT id FROM inserted_question), '(CH3)3С–NH2 (трет-бутиламін). Реакція діазотування та азосполучення', false, 2),
  ((SELECT id FROM inserted_question), '(СН3)3N (триметиламін). Реакція з HCl', false, 3),
  ((SELECT id FROM inserted_question), 'C6H5–NH2 (анілін). Реакція діазотування та азосполучення', true, 4);

-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які з перерахованих реакцій треба провести, щоб одержати азобарвник із ароматичного аміну?', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Діазотування і азосполучення', true, 0),
  ((SELECT id FROM inserted_question), 'Відновлення і діазотування', false, 1),
  ((SELECT id FROM inserted_question), 'Діазотування і взаємодія з ціанідом калію', false, 2),
  ((SELECT id FROM inserted_question), 'Солеутворення і нітрування', false, 3),
  ((SELECT id FROM inserted_question), 'Алкілювання і нітрозування', false, 4);

-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При вивченні хімічних властивостей органічної сполуки встановлено, що вона проявляє основні властивості та легко вступає в реакції галогенування й діазотування. Укажіть сполуку, що відповідає вказаним критеріям.', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нафтален', false, 0),
  ((SELECT id FROM inserted_question), 'Бензен', false, 1),
  ((SELECT id FROM inserted_question), 'Толуен', false, 2),
  ((SELECT id FROM inserted_question), 'Фенол', false, 3),
  ((SELECT id FROM inserted_question), 'Анілін', true, 4);

-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Азобарвники утворюються в результаті реакції:', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітрування', false, 0),
  ((SELECT id FROM inserted_question), 'Азосполучення', true, 1),
  ((SELECT id FROM inserted_question), 'Діазотування', false, 2),
  ((SELECT id FROM inserted_question), 'Нітрозування', false, 3),
  ((SELECT id FROM inserted_question), 'Амінування', false, 4);

-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який з наведених амінів НЕ утворює солі діазонію в умовах реакції діазотування', NULL, 'medium', 5, true, '/test-images/organic/tema2/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А', true, 0),
  ((SELECT id FROM inserted_question), 'Б', false, 1),
  ((SELECT id FROM inserted_question), 'В', false, 2),
  ((SELECT id FROM inserted_question), 'Г', false, 3),
  ((SELECT id FROM inserted_question), 'Д', false, 4);

-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Більшість нітритометричних визначень ґрунтується на реакціях діазотування:', NULL, 'medium', 6, true, '/test-images/organic/tema2/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альдегідів', false, 0),
  ((SELECT id FROM inserted_question), 'Карбонових кислот', false, 1),
  ((SELECT id FROM inserted_question), 'Первинних ароматичних амінів', true, 2),
  ((SELECT id FROM inserted_question), 'Кетонів', false, 3),
  ((SELECT id FROM inserted_question), 'Спиртів', false, 4);

-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При визначенні стрептоциду (ароматичного аміну) методом нітритометрії для прискорення реакції діазотування додають каталізатор. Вкажіть речовину, яка виконує роль каталізатора:', NULL, 'medium', 7, true, '/test-images/organic/tema2/page2_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калій бромід', true, 0),
  ((SELECT id FROM inserted_question), 'Хлоридна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Сульфатна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Натрій нітрит', false, 3),
  ((SELECT id FROM inserted_question), 'Натрій гідроксид', false, 4);

-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аміди є слабкими NH-кислотами. Під час взаємодії з яким з наведених реагентів вони утворюють солі?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaNH2 (Na мет.)', true, 0),
  ((SELECT id FROM inserted_question), 'NaOH (H2O)', false, 1),
  ((SELECT id FROM inserted_question), 'P2O5 (to)', false, 2),
  ((SELECT id FROM inserted_question), 'NaOBr (Br2 + NaOH)', false, 3),
  ((SELECT id FROM inserted_question), 'LiAlH4', false, 4);

-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть реагенти, що дозволять підтвердити наявність первинної аміногрупи в молекулі n-амінобензойної кислоти за допомогою ізонітрильної проби:', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaHCO3', false, 0),
  ((SELECT id FROM inserted_question), 'Вr2, Н2О', false, 1),
  ((SELECT id FROM inserted_question), 'КМпО4', false, 2),
  ((SELECT id FROM inserted_question), 'СНСІз, NaOH', true, 3),
  ((SELECT id FROM inserted_question), 'І2, NaOH', false, 4);

-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку з наведених реакцій можна використовувати для ідентифікації первинної аміногрупи?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ізонітрильна проба (CHCl3 + NaOH)', true, 0),
  ((SELECT id FROM inserted_question), 'Реакція з нітритом натрію', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція з бромною водою', false, 2),
  ((SELECT id FROM inserted_question), 'Реакція з Cu(OH)2', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція з FeCl3', false, 4);

-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні реакції нітрування аніліну його попередньо ацилюють з метою захисту аміногрупи від процесів окиснення. Який з нижче перерахованих реагентів при цьому використовують?', NULL, 'medium', 11, true, '/test-images/organic/tema2/page4_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '(CH3CO)2O', true, 0),
  ((SELECT id FROM inserted_question), 'CH3CHO', false, 1),
  ((SELECT id FROM inserted_question), 'C2H5Cl', false, 2),
  ((SELECT id FROM inserted_question), 'HNO2', false, 3),
  ((SELECT id FROM inserted_question), 'CHCl3 + NaOH', false, 4);

-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Біохімічний сенс трансамінування полягає у тому, що аміногрупи від різних амінокислот збираються у вигляді однієї з амінокислот. Яка це амінокислота?', NULL, 'medium', 12, true, '/test-images/organic/tema2/page5_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глутамінова', true, 0),
  ((SELECT id FROM inserted_question), 'Гліцин', false, 1),
  ((SELECT id FROM inserted_question), 'Валін', false, 2),
  ((SELECT id FROM inserted_question), 'Лейцин', false, 3),
  ((SELECT id FROM inserted_question), 'Аргінін', false, 4);

-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В процесі декарбоксилювання 5- гідрокситриптофану утворюється біогенний амін, що має судинозвужуючу дію. Назвіть даний біогенний амін:', NULL, 'medium', 13, true, '/test-images/organic/tema2/page5_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серотонін', true, 0),
  ((SELECT id FROM inserted_question), 'Гістамін', false, 1),
  ((SELECT id FROM inserted_question), 'Гамма-аміномасляна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Путресцин', false, 3),
  ((SELECT id FROM inserted_question), 'Кадаверин', false, 4);

-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Амінокислоти беруть участь у реакціях метилювання під час синтезу ряду біологічно активних речовин – адреналіну, мелатоніну, фосфатидилхоліну, креатину. Активна форма якої амінокислоти використовується для синтезу цих сполук?', NULL, 'medium', 14, true, '/test-images/organic/tema2/page5_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аланіну', false, 0),
  ((SELECT id FROM inserted_question), 'Фенілаланіну', false, 1),
  ((SELECT id FROM inserted_question), 'Треоніну', false, 2),
  ((SELECT id FROM inserted_question), 'Валіну', false, 3),
  ((SELECT id FROM inserted_question), 'Метіоніну', true, 4);

-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для піридину характерні реакції електрофільного (SE ) та нуклеофільного (SN ) заміщення. Низька реакційна здатніть піридину в реакціях SE обумовлена: o', NULL, 'medium', 15, true, '/test-images/organic/tema2/page5_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електроноакцепторними властивостями атому нітрогену', true, 0),
  ((SELECT id FROM inserted_question), 'Ароматичним характером піридинового ядра', false, 1),
  ((SELECT id FROM inserted_question), 'Основними властивостями', false, 2),
  ((SELECT id FROM inserted_question), 'Гібридизацією атомів карбону', false, 3),
  ((SELECT id FROM inserted_question), 'Розміром циклу', false, 4);

-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На фармацевтичне підприємство надійшла партія рослинної сировини, яка за зовнішніми ознаками має вірусне ураження. Який сучасний метод діагностики доцільно використати з метою специфічного виявлення вірусних нуклеїнових кислот у рослин?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакцію гемаглютинації', false, 0),
  ((SELECT id FROM inserted_question), 'Реакцію затримки гемаглютинації', false, 1),
  ((SELECT id FROM inserted_question), 'Імуноферментний аналіз', false, 2),
  ((SELECT id FROM inserted_question), 'Молекулярну гібридизацію', true, 3),
  ((SELECT id FROM inserted_question), 'Реакцію непрямої гемаглютинації', false, 4);

-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який препарат із групи органічних нітратів використовують для купірування приступів стенокардії?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кофеїн-бензоат натрія', false, 0),
  ((SELECT id FROM inserted_question), 'Валідол', false, 1),
  ((SELECT id FROM inserted_question), 'Верапаміл', false, 2),
  ((SELECT id FROM inserted_question), 'Нітрогліцерин', true, 3),
  ((SELECT id FROM inserted_question), 'Дігоксин', false, 4);

-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту віком 55 років для швидкого усунення нападу стенокарді призначено препарат із групи органічних нітратів. Укажіть цей препарат.', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лабеталол', false, 0),
  ((SELECT id FROM inserted_question), 'Нітрогліцерин', true, 1),
  ((SELECT id FROM inserted_question), 'Празозин', false, 2),
  ((SELECT id FROM inserted_question), 'Октадин', false, 3),
  ((SELECT id FROM inserted_question), 'Ніфедипін', false, 4);

-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні реакції нітрування аніліну його попередньо ацилюють з метою захисту аміногрупи від процесів окиснення. Який з нижче перерахованих реагентів при цьому використовують?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '(CH3CO)2O', true, 0),
  ((SELECT id FROM inserted_question), 'CH3CHO', false, 1),
  ((SELECT id FROM inserted_question), 'C2H5Cl', false, 2),
  ((SELECT id FROM inserted_question), 'HNO2', false, 3),
  ((SELECT id FROM inserted_question), 'CHCl3 + NaOH', false, 4);

-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Продуктами реакції нітрування толуолу переважно будуть:', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Орто- та пара-нітротолуол', true, 0),
  ((SELECT id FROM inserted_question), 'Мета-нітротолуол', false, 1),
  ((SELECT id FROM inserted_question), 'Тільки орто-нітротолуол', false, 2),
  ((SELECT id FROM inserted_question), 'Тільки пара-нітротолуол', false, 3),
  ((SELECT id FROM inserted_question), 'Дінітропохідні толуолу', false, 4);

-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Реакція нітрування фенолу протікає з утворенням орто- і паранітрофенолу. До якого типу реакцій її відносять?', NULL, 'medium', 21, true, '/test-images/organic/tema2/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Паралельна', true, 0),
  ((SELECT id FROM inserted_question), 'Послідовна', false, 1),
  ((SELECT id FROM inserted_question), 'Спряжена', false, 2),
  ((SELECT id FROM inserted_question), 'Зворотня', false, 3),
  ((SELECT id FROM inserted_question), 'Ланцюгова', false, 4);

-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть положення, за яким переважно проходить реакція нітрування саліцилової кислоти? o', NULL, 'medium', 22, true, '/test-images/organic/tema2/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4', false, 0),
  ((SELECT id FROM inserted_question), '6', false, 1),
  ((SELECT id FROM inserted_question), '3 та 6', false, 2),
  ((SELECT id FROM inserted_question), '5', true, 3),
  ((SELECT id FROM inserted_question), '2', false, 4);

-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть положення в молекулі індолу, за яким проходить реакція його нітрування. o', NULL, 'medium', 23, true, '/test-images/organic/tema2/page8_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1', false, 0),
  ((SELECT id FROM inserted_question), '2', false, 1),
  ((SELECT id FROM inserted_question), '3', true, 2),
  ((SELECT id FROM inserted_question), '4', false, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);

-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якого класу органічних сполук характерна наявність -C≡N групи?', NULL, 'medium', 24, true, '/test-images/organic/tema2/page8_img2.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітрили', true, 0),
  ((SELECT id FROM inserted_question), 'Аміни', false, 1),
  ((SELECT id FROM inserted_question), 'Нітросполуки', false, 2),
  ((SELECT id FROM inserted_question), 'Спирти', false, 3),
  ((SELECT id FROM inserted_question), 'Альдегіди', false, 4);

-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Первинні та вторинні нітроалкани є таутомерними сполуками. Яка таутомерія характерна для цих сполук?', NULL, 'medium', 25, true, '/test-images/organic/tema2/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Азольна', false, 0),
  ((SELECT id FROM inserted_question), 'Аци-нітротаутомерія', true, 1),
  ((SELECT id FROM inserted_question), 'Кето-енольна', false, 2),
  ((SELECT id FROM inserted_question), 'Лактам-лактамна', false, 3),
  ((SELECT id FROM inserted_question), 'Аміно-імінна', false, 4);

-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Ацетилсаліцилова кислота утворюється в результаті нижченаведеної реакції. До якого типу реакцій вона належить? o', NULL, 'medium', 26, true, '/test-images/organic/tema2/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відщеплення', false, 0),
  ((SELECT id FROM inserted_question), 'Електрофільного заміщення', false, 1),
  ((SELECT id FROM inserted_question), 'Приєднання', false, 2),
  ((SELECT id FROM inserted_question), 'Ацилювання', true, 3),
  ((SELECT id FROM inserted_question), 'Відновлення', false, 4);

-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених гетероциклічних сполук виявляє найсильніші основні властивості?', NULL, 'medium', 27, true, '/test-images/organic/tema2/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фуран', false, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Пірол', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3),
  ((SELECT id FROM inserted_question), 'Піролідин', true, 4);

-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть назву п’ятичленного гетероциклу, що містить гетероатоми нітрогену пірольного та піридинового типу.', NULL, 'medium', 28, true, '/test-images/organic/tema2/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Триазол', false, 0),
  ((SELECT id FROM inserted_question), 'Піперидин', false, 1),
  ((SELECT id FROM inserted_question), 'Піразолідин', false, 2),
  ((SELECT id FROM inserted_question), 'Тіазол', false, 3),
  ((SELECT id FROM inserted_question), 'Піразол', true, 4);

-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пірол відноситься до: o', NULL, 'medium', 29, true, '/test-images/organic/tema2/page9_img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'П''ятичленних гетероциклів з одним гетероатомом', true, 0),
  ((SELECT id FROM inserted_question), 'Конденсованих гетероциклів', false, 1),
  ((SELECT id FROM inserted_question), 'Шестичленних гетероциклів', false, 2),
  ((SELECT id FROM inserted_question), 'Ароматичних амінів', false, 3),
  ((SELECT id FROM inserted_question), 'Нітропохідних вуглеводнів', false, 4);

-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який гетероцикл із нижченаведених має ацидофобні властивості?', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піримідин', false, 0),
  ((SELECT id FROM inserted_question), 'Пірол', true, 1),
  ((SELECT id FROM inserted_question), 'Птеридин', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3),
  ((SELECT id FROM inserted_question), 'Хінолін', false, 4);

-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть тип хімічної реакції при титруванні тіосульфату натрію розчином йоду:', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', true, 0),
  ((SELECT id FROM inserted_question), 'Кислотно-основний', false, 1),
  ((SELECT id FROM inserted_question), 'Осадження', false, 2),
  ((SELECT id FROM inserted_question), 'Нуклеофільного заміщення', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);

-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До якого класу належить препарат нітрогліцерин, який застосовується при стенокардії?', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Складний ефір', true, 0),
  ((SELECT id FROM inserted_question), 'Нітровмісні спирти', false, 1),
  ((SELECT id FROM inserted_question), 'Прості ефіри', false, 2),
  ((SELECT id FROM inserted_question), 'Нітроалкани', false, 3),
  ((SELECT id FROM inserted_question), 'Багатоатомні спирти', false, 4);

-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Амінокислоти та їхні похідні в нейронах головного мозку виконують функцію нейромедіаторів. Який нейромедіатор утворюється з ароматичної амінокислоти?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метіонін', false, 0),
  ((SELECT id FROM inserted_question), 'Лейцин', false, 1),
  ((SELECT id FROM inserted_question), 'Дофамін', true, 2),
  ((SELECT id FROM inserted_question), 'Гліцин', false, 3),
  ((SELECT id FROM inserted_question), 'Таурин', false, 4);

-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Адреналін використовується для подовження дії новокаїну при інфільтраційній анестезії. З якою дією адреналіну пов’язаний цей ефект?', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Нітрогеновмісні органічні сполуки'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розширення судин', false, 0),
  ((SELECT id FROM inserted_question), 'Звуження судин', true, 1),
  ((SELECT id FROM inserted_question), 'Пригнічення тканинних естераз', false, 2),
  ((SELECT id FROM inserted_question), 'Пригнічення функцій нервових закінчень і провідників', false, 3),
  ((SELECT id FROM inserted_question), 'Потенціювання дії новокаїну на рівні ЦНС', false, 4);

COMMIT;
