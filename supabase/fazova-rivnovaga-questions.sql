BEGIN;

-- Курс "Теоретичні основи фармацевтичного аналізу" (якщо ще немає в БД)
INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Теоретичні основи фармацевтичного аналізу', 'Комплексний курс з теоретичних основ фармацевтичного аналізу.', 'pharmaceutical', 2, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Теоретичні основи фармацевтичного аналізу');

-- Тема: Фазова рівновага

INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Фазова рівновага', 'Фазова рівновага', 0, true
FROM courses c
WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Фазова рівновага');

DELETE FROM question_options WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
);

DELETE FROM questions WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хіміко-аналітичній лабораторії спеціаліст досліджує суміш катіонів V аналітичної групи. При додаванні розчину натрію гідрофосфату утворюється білий кристалічний осад. Про наявність якого катіону свідчить цей аналітичний ефект?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Mg2+', true, 0),
  ((SELECT id FROM inserted_question), 'Fe2+', false, 1),
  ((SELECT id FROM inserted_question), 'Cr3+', false, 2),
  ((SELECT id FROM inserted_question), 'Cu2+', false, 3),
  ((SELECT id FROM inserted_question), 'Fe3+', false, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хіміко-аналітичній лабораторії проводять титриметричне визначення загальної твердості води методом комплексонометрії. Розчин якого титранту використовують у цьому методі?', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію перманганату', false, 0),
  ((SELECT id FROM inserted_question), 'Магнію сульфату', false, 1),
  ((SELECT id FROM inserted_question), 'Трилону Б', true, 2),
  ((SELECT id FROM inserted_question), 'Барію нітрату', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію хлориду', false, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який розчин використовують у хіміко-аналітичній лабораторії для ідентифікації катіону амонію за специфічною реакцією?', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сульфату калію', false, 0),
  ((SELECT id FROM inserted_question), 'Хлоридної кислоти', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроксиду натрію', true, 2),
  ((SELECT id FROM inserted_question), 'Хлориду натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Сульфатної кислоти', false, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик досліджує розчин, що містить аніони ІІІ аналітичної групи. Після додавання антипірину розчин набув смарагдово-зеленого кольору. Які аніони присутні в розчині?', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацетат', false, 0),
  ((SELECT id FROM inserted_question), 'Оксалат', false, 1),
  ((SELECT id FROM inserted_question), 'Арсенат', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфат', false, 3),
  ((SELECT id FROM inserted_question), 'Нітрит', true, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хіміко-аналітичній лабораторії проводять ідентифікацію катіонів нікелю за допомогою реакції з диметил-гліоксимом. Укажіть колір осаду, що утворився.', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жовтий', false, 0),
  ((SELECT id FROM inserted_question), 'Білий', false, 1),
  ((SELECT id FROM inserted_question), 'Зелений', false, 2),
  ((SELECT id FROM inserted_question), 'Синій', false, 3),
  ((SELECT id FROM inserted_question), 'Червоний', true, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для встановлення якості жирних олій контрольно-аналітична лабораторія використовує певні хімічні показники. За яким хімічним показником можна встановити висихання жирних олій?', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Йодне число', true, 0),
  ((SELECT id FROM inserted_question), 'Число омилення', false, 1),
  ((SELECT id FROM inserted_question), 'Ефірне число', false, 2),
  ((SELECT id FROM inserted_question), 'Перекисне число', false, 3),
  ((SELECT id FROM inserted_question), 'Кислотне число', false, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Спеціаліст відділу біохімічних досліджень медичної лабораторії в рамках внутрішньолабораторної програми оцінювання компетентності отримав "сліпий" зразок сироватки крові, концентрація загального холестерину в якому становить 7,0 ммоль/л. Вимога до точності вимірювання загального холестерину встановлена в лабораторії у вигляді загальної аналітичної похибки на рівні 10%. В який діапазон має потрапити результат вимірювання, наданий спеціалістом, компетентність якого оцінюється, для того, щоб його результат було визнано прийнятним?', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '6,0-8,0 ммоль/л', false, 0),
  ((SELECT id FROM inserted_question), '5,6-8,4 ммоль/л', false, 1),
  ((SELECT id FROM inserted_question), '6,5-7,5 ммоль/л', false, 2),
  ((SELECT id FROM inserted_question), '7,0-10,0 ммоль/л', false, 3),
  ((SELECT id FROM inserted_question), '6,3-7,7 ммоль/л', true, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналітична лабораторія отримала на аналіз зразок амінокислоти метіоніну. Який реактив слід використати хіміку-аналітику для ідентифікації цієї субстанції?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нінгідрин', true, 0),
  ((SELECT id FROM inserted_question), 'Бензен', false, 1),
  ((SELECT id FROM inserted_question), 'Анілін', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію нітрат', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію бромід', false, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик проводить якісний аналіз катіонів четвертої аналітичної групи. Для чого додають 3% розчин пероксиду водню?', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Переведення іонів у вищий ступінь окислення', true, 0),
  ((SELECT id FROM inserted_question), 'Переведення іонів у нижчий ступінь окислення', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення забарвлених сполук', false, 2),
  ((SELECT id FROM inserted_question), 'Утворення осаду', false, 3),
  ((SELECT id FROM inserted_question), 'Видалення газу', false, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік контрольно-аналітичної лабораторії отримав завдання приготувати еталони каламутності згідно вимог фармакопеї. Які речовини він має використовувати для цього у якості вихідних?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фурацилін і кальцію хлорид', false, 0),
  ((SELECT id FROM inserted_question), 'Натрію хлорид і кальцію нітрат', false, 1),
  ((SELECT id FROM inserted_question), 'Калію хлорид і барію сульфат', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію сульфат і гліцерин', false, 3),
  ((SELECT id FROM inserted_question), 'Гексаметилентетрамін і гідразину сульфат', true, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В хіміко-аналітичній лабораторії спеціаліст досліджував розчини, що містять суміші катіонів. В якому з розчинів містяться лише катіони II аналітичної групи?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ag+, Hg2+, Pb2+', true, 0),
  ((SELECT id FROM inserted_question), 'Hg3+, NH4, Ag+', false, 1),
  ((SELECT id FROM inserted_question), 'Na+ , Pb+ , Ni2+', false, 2),
  ((SELECT id FROM inserted_question), 'Na+, Hg2+,NH4+', false, 3),
  ((SELECT id FROM inserted_question), 'Pb2+, Ag+', false, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У контрольно-аналітичній лабораторії хіміку необхідно провести стандартизацію розчину натрію гідроксиду. Який первинний стандартний розчин може бути для цього використаний?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію хлорид', false, 0),
  ((SELECT id FROM inserted_question), 'Натрію тетраборат', false, 1),
  ((SELECT id FROM inserted_question), 'Оцтова кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Щавлева кислота', true, 3),
  ((SELECT id FROM inserted_question), 'Хлороводнева кислота', false, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик проводить якісний систематичний аналіз суміші катіонів першої аналітичної групи. Який катіон визначають на початку дослідження специфічною реакцією?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', false, 0),
  ((SELECT id FROM inserted_question), 'Літію', false, 1),
  ((SELECT id FROM inserted_question), 'Арґентуму', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Амонію', true, 4);


-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В хіміко-аналітичній лабораторії спеціаліст досліджує суміш катіонів V аналітичної групи. При додаван- ні тіоціонат-іонів розчин забарвлюється в червоний колір. Про наявність якого катіону свідчить даний аналітичний ефект?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Mg2+', false, 0),
  ((SELECT id FROM inserted_question), 'Fe2+', false, 1),
  ((SELECT id FROM inserted_question), 'Bi3+', false, 2),
  ((SELECT id FROM inserted_question), 'Fe3+', false, 3),
  ((SELECT id FROM inserted_question), 'Mn2+', true, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В хіміко-аналітичній лабораторії проводять ідентифікацію катіона алюмінію за допомогою реакції з алізарином, з утворенням "алюмінієвого лаку". Який колір має сполука, що утворюється?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Яскраво-червоний', true, 0),
  ((SELECT id FROM inserted_question), 'Яскраво-фіолетовий', false, 1),
  ((SELECT id FROM inserted_question), 'Яскраво-зелений', false, 2),
  ((SELECT id FROM inserted_question), 'Яскраво-синій', false, 3),
  ((SELECT id FROM inserted_question), 'Яскраво-жовтий', false, 4);


-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В контрольно-аналітичній лабораторії хіміку необхідно провести стандартизацію розчину гідроксиду натрію. Який первинний стандартний розчин він може для цього використати?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оксалатної кислоти', true, 0),
  ((SELECT id FROM inserted_question), 'Ацетатної кислоти', false, 1),
  ((SELECT id FROM inserted_question), 'Хлоридної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Тетраборату натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Хлориду натрію', false, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Спеціаліст відділу біохімічних досліджень медичної лабораторії в рамках внутрішньолабораторної програми оцінювання компетентності отримав ''сліпий'' зразок сироватки крові, концентрація загального холестерину в якому становить 7,0 ммоль/л. Вимога до точності вимірювання загального холестерину встановлена в лабораторії у вигляді загальної аналітичної похибки на рівні 10%. В який діапазон має потрапити результат вимірювання, наданий спеціалістом, компетентність якого оцінюється, для того, щоб його результат було визнано прийнятним?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '6,3-7,7 ммоль/л', true, 0),
  ((SELECT id FROM inserted_question), '7,0-10,0 ммоль/л', false, 1),
  ((SELECT id FROM inserted_question), '5,6-8,4 ммоль/л', false, 2),
  ((SELECT id FROM inserted_question), '6,5-7,5 ммоль/л', false, 3),
  ((SELECT id FROM inserted_question), '6,0-8,0 ммоль/л', false, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик проводить якісний аналіз фосфат-іонів за допомогою фармакопейної реакції, внаслідок якої утворився жовтий осад. Який реактив використав спеціаліст?', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Срібла нітрат', true, 0),
  ((SELECT id FROM inserted_question), 'Калію нітрату', false, 1),
  ((SELECT id FROM inserted_question), 'Калію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію нітрат', false, 3),
  ((SELECT id FROM inserted_question), 'Хлоридну кислоту', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час транспортування лікарських засобів з групи алкалоїдів було пошкоджено маркування на упаковці. Під час проведення групових якісних реакцій на алкалоїди виявилося, що позитивний результат дала реакція Віталі-Морена. До похідних якої групи належить аналізований лікарський засіб?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Індолу', false, 0),
  ((SELECT id FROM inserted_question), 'В. Тропану', true, 1),
  ((SELECT id FROM inserted_question), 'С. Ізохіноліну', false, 2),
  ((SELECT id FROM inserted_question), 'D. Хінуклідину', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Пурину', false, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевтична фабрика отримала партію сировини - корені алтеї. Для проведення якісного аналізу виберіть реактив для проведення гістохімічної реакції на слиз:', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1% розчин флороглюцину', false, 0),
  ((SELECT id FROM inserted_question), '1% розчин залізоамонійних галунів', false, 1),
  ((SELECT id FROM inserted_question), 'СРозчин судану III', false, 2),
  ((SELECT id FROM inserted_question), 'Спиртовий розчин метиленового синього', true, 3),
  ((SELECT id FROM inserted_question), 'Реактив Драгендорфа', false, 4);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який специфічний реагент застосовують під час якісного аналізу на катіони Fe^2+ ?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'K3[Fe(CN)6]', true, 0),
  ((SELECT id FROM inserted_question), 'K2Na[Co(NO2)6]', false, 1),
  ((SELECT id FROM inserted_question), 'NH4ОH', false, 2),
  ((SELECT id FROM inserted_question), 'K4[Fe(CN)6]', false, 3),
  ((SELECT id FROM inserted_question), 'NaOH', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі характерною реакцією на катіони срібла є:', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакція утворення жовтого осаду, що розчиняється у надлишку аміаку', false, 0),
  ((SELECT id FROM inserted_question), 'Реакція утворення сирнистого осаду AgCl, що розчиняється в розчині аміаку, який знову утворюється у разі додавання НNО3', true, 1),
  ((SELECT id FROM inserted_question), 'Реакція утворення сирнистого осаду АgCl, що розчиняється у кислотах', false, 2),
  ((SELECT id FROM inserted_question), 'Реакція утворення осаду, що розчиняється у розчині лугу', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція утворення комплексу, який руйнується під дією розчину HNO3', false, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В аналітичній практиці якісного аналізу використовують специфічні реакції, які дають можливість:', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Виявити певну групу іонів', false, 0),
  ((SELECT id FROM inserted_question), 'Виявити тільки аніони', false, 1),
  ((SELECT id FROM inserted_question), 'Виявити іон без попереднього відділення інших іонів', true, 2),
  ((SELECT id FROM inserted_question), 'Виявити тільки катіони', false, 3),
  ((SELECT id FROM inserted_question), 'Виявити іон після попереднього відділення', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні якісного хімічного аналізу субстанції кислоти нікотинової провели реакцію, в результаті якої з’являється синє забарвлення. Який реактив при цьому використаний?', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реактив Неслера', false, 0),
  ((SELECT id FROM inserted_question), 'Розчин міді (II) сульфату', true, 1),
  ((SELECT id FROM inserted_question), 'Розчин натрію гідроксиду', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин заліза (III) хлориду', false, 3),
  ((SELECT id FROM inserted_question), 'Роданбромідний реактив', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик проводить якісний аналіз катіонів четвертої аналітичної групи. Для чого додають 3% розчин пероксиду водню?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Переведення іонів у вищий ступінь окислення', true, 0),
  ((SELECT id FROM inserted_question), 'Переведення іонів у нижчий ступінь окислення', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення забарвлених сполук', false, 2),
  ((SELECT id FROM inserted_question), 'Утворення осаду', false, 3),
  ((SELECT id FROM inserted_question), 'Видалення газу', false, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізору контрольно-аналітичної лабораторії під час проведення якісного аналізу осадження сульфатів катіонів третьої аналітичної групи (Са2+, Sr2+, Ba2+) потрібно зменшити розчинність сульфатів. Яку речовину він має використати для цього?', NULL, 'medium', 26, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аміловий спирт', false, 0),
  ((SELECT id FROM inserted_question), 'Хлороформ', false, 1),
  ((SELECT id FROM inserted_question), 'Дистильована вода', false, 2),
  ((SELECT id FROM inserted_question), 'Етиловий спирт', true, 3),
  ((SELECT id FROM inserted_question), 'Бензол', false, 4);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі при певних умовах специфічним реагентом на катіони Fe3+ є K4[Fe(CN)6]. Якого кольору утворюється осад при їх взаємодії?', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Синій', true, 0),
  ((SELECT id FROM inserted_question), 'Білий', false, 1),
  ((SELECT id FROM inserted_question), 'Бурий', false, 2),
  ((SELECT id FROM inserted_question), 'Червоний', false, 3),
  ((SELECT id FROM inserted_question), 'Чорний', false, 4);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі при осадженні сульфатів катіонів третьої аналітичної групи (Ca2+, Sr2+, Ba2+) з метою зменшення розчинності сульфатів у розчин додають:', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Етиловий спирт', true, 0),
  ((SELECT id FROM inserted_question), 'Дистильовану воду', false, 1),
  ((SELECT id FROM inserted_question), 'Бензол', false, 2),
  ((SELECT id FROM inserted_question), 'Хлороформ', false, 3),
  ((SELECT id FROM inserted_question), 'Аміловий спирт', false, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі при дії надлишку групового реагенту (розчин гідроксиду натрію) на катіони IV аналітичної групи, іони хрому (III) утворюють:', NULL, 'medium', 29, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гексагідроксохромат натрію (III)', true, 0),
  ((SELECT id FROM inserted_question), 'Гідроксид хрому (III)', false, 1),
  ((SELECT id FROM inserted_question), 'Оксид хрому (III)', false, 2),
  ((SELECT id FROM inserted_question), 'Гідроксид хрому (II)', false, 3),
  ((SELECT id FROM inserted_question), 'Оксид хрому (II)', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить експрес-аналіз протикашльової мікстури, до складу якої входять натрію гідрокарбонат та екстракт трави термопсису. Яким методом можна визначити кількісний вміст натрію гідрокарбонату в цій мікстурі?', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітритометрії', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрії', true, 1),
  ((SELECT id FROM inserted_question), 'Церіметрії', false, 2),
  ((SELECT id FROM inserted_question), 'Перманганатометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрії', false, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить аналіз субстанції хлорамфенікол (левоміцетин) і для розрахунку кількісного вмісту використовує значення питомого показника поглинання. Який метод він застосував для кількісного визначення?', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рефрактометрії', false, 0),
  ((SELECT id FROM inserted_question), 'Полярографії', false, 1),
  ((SELECT id FROM inserted_question), 'Спектрофотометрії', true, 2),
  ((SELECT id FROM inserted_question), 'Поляриметрії', false, 3),
  ((SELECT id FROM inserted_question), 'Фотоколориметрії', false, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До складу мікстури відхаркувальної дії входять натрію гідрокарбонат, калію йодид та амонію хлорид. Укажіть метод кількісного визначення натрію гідрокарбонату під час експрес-аналізу цієї лікарської форми:', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Ацидиметрія', true, 2),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик відділу контролю якості аналізує субстанцію фенолу. Який метод кількісного визначення він використовує?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрії', false, 0),
  ((SELECT id FROM inserted_question), 'Меркуриметрії', false, 1),
  ((SELECT id FROM inserted_question), 'Перманганатометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрії', true, 3),
  ((SELECT id FROM inserted_question), 'Комплексонометрії', false, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Інтерн проводить огляд наукових статей, публікацій та інших джерел інформації щодо лікування алергічного риніту для отримання сумарних статистичних показників результатів досліджень. Який кількісний систематичний огляд проводить інтерн:', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Експеримент', false, 0),
  ((SELECT id FROM inserted_question), 'Витрати-вигода', false, 1),
  ((SELECT id FROM inserted_question), 'Метааналіз', true, 2),
  ((SELECT id FROM inserted_question), 'Спостереження', false, 3),
  ((SELECT id FROM inserted_question), 'Витрати-ефективність', false, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На аналіз до контрольно-аналітичної лабораторії надійшла гентаміцину мазь. Який метод використовують для кількісного визначення гентаміцину сульфату згідно з вимогами ДФУ?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометричний', false, 0),
  ((SELECT id FROM inserted_question), 'Мікробіологічний', true, 1),
  ((SELECT id FROM inserted_question), 'Фотоколориметричний', false, 2),
  ((SELECT id FROM inserted_question), 'Поляриметричний', false, 3),
  ((SELECT id FROM inserted_question), 'Хроматографічний', false, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод хроматографічного аналізу для розділення, ідентифікації та кількісного визначення метанолу й етанолу в суміші.', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Панерова хромторафія', false, 0),
  ((SELECT id FROM inserted_question), 'Іонообмінна хроматографія', false, 1),
  ((SELECT id FROM inserted_question), 'Площинна хроматографія', false, 2),
  ((SELECT id FROM inserted_question), 'Осадова хроматографія', false, 3),
  ((SELECT id FROM inserted_question), 'Газорідинна хроматографія', true, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить експрес-аналіз 2%-го розчину борної кислоти. Який метод він використовує для кількісного визначення діючої речовини?', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрії', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексонометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Алкаліметрії', true, 2),
  ((SELECT id FROM inserted_question), 'Ацидиметрії', false, 3),
  ((SELECT id FROM inserted_question), 'Нітритометрії', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть титриметричний метод аналізу для визначення кількісного вмісту магній хлориду в суміші, що містить хлориди калію і магнію?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Меркурометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У якому методі кількісного аналізу титрантом є розчин лугу?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрії', false, 0),
  ((SELECT id FROM inserted_question), 'Нітритометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Броматометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Алкаліметрії', true, 3),
  ((SELECT id FROM inserted_question), 'Меркурометрії', false, 4);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод інструментального аналізу для кількісного визначення хлоридної і боратної кислот у суміші.', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ІЧ-спектроскопія', false, 0),
  ((SELECT id FROM inserted_question), 'Хроматографія', false, 1),
  ((SELECT id FROM inserted_question), 'Спсктрофотометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Поляриметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Потенціометрія', true, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик здійснює експрес-аналіз очних крапель протизапальної дії, які містять калію йодид. Яким методом він проводить кількісне визначення діючої речовини?', NULL, 'medium', 41, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрії', true, 0),
  ((SELECT id FROM inserted_question), 'Алкаліметрії', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексонометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Нітритометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Ацидиметрії', false, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить аналіз субстанції хлорамфенікол (левоміцетин) і для розрахунку кількісного вмісту використовує значення питомого показника поглинання. Який метод він застосував для кількісного визначення?', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометрії', true, 0),
  ((SELECT id FROM inserted_question), 'Поляриметрії', false, 1),
  ((SELECT id FROM inserted_question), 'Фотоколориметрії', false, 2),
  ((SELECT id FROM inserted_question), 'Рефрактометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Полярографії', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При кількісному визначенні камфори в камфорному спирті згідно з вимогами Державної Фармакопеї України проводять вимірювання оптичної густини випробовуваного розчину та розчину порівняння за довжини хвилі 290 нм. Для якого методу аналізу характерний такий алгоритм роботи ?', NULL, 'medium', 43, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ротаційної віскозиметрії', false, 0),
  ((SELECT id FROM inserted_question), 'Прямої кондуктометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Атомно-емісійної спектрометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Прямої потенціометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Абсорбційної спектрофотометрії', true, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Кількісний вміст антигістамінного засобу «Дифенгідраміну гідрохлорид» визначають методом алкаліметрії. Який розчин використовують в якості титранту в цьому аналізі?', NULL, 'medium', 44, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кислоти хлористоводневої', false, 0),
  ((SELECT id FROM inserted_question), 'Натрію тіосульфату', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію гідроксиду', true, 2),
  ((SELECT id FROM inserted_question), 'Калію бромату', false, 3),
  ((SELECT id FROM inserted_question), 'Калію перманганату', false, 4);


-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить експрес-аналіз 2%-го розчину борної кислоти. Який метод він має застосувати для кількісного визначення діючої речовини?', NULL, 'medium', 45, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Ацидиметрії', false, 0),
  ((SELECT id FROM inserted_question), 'В. Аргентометрії', false, 1),
  ((SELECT id FROM inserted_question), 'С. Комплексонометрії', false, 2),
  ((SELECT id FROM inserted_question), 'D. Алкаліметрії', true, 3),
  ((SELECT id FROM inserted_question), 'Е. Нітритометрії', false, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії на аналіз надійшла субстанція кислоти аскорбінової. Відповідно до вимог ДФУ кількісний вміст кислоти аскорбінової визначають методом:', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Ацидиметрії', false, 0),
  ((SELECT id FROM inserted_question), 'В. Нітритометрії', false, 1),
  ((SELECT id FROM inserted_question), 'С. Ацидиметрії у неводних середовищах', false, 2),
  ((SELECT id FROM inserted_question), 'D. Комплексонометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Йодометрії', true, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії на аналіз надійшла субстанція глібенкламіду. Відповідно до вимог ДФУ, кількісний вміст глібенкламіду визначають методом:', NULL, 'medium', 47, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Йодометрії', false, 0),
  ((SELECT id FROM inserted_question), 'В. Алкаліметрії', true, 1),
  ((SELECT id FROM inserted_question), 'С. Йодхлорметрії', false, 2),
  ((SELECT id FROM inserted_question), 'D. Броматометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Ацидиметрії', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який титриметричний метод аналізу застосовують для кількісного визначення хлориду Кальцію?', NULL, 'medium', 48, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перманганатометрії, пряме титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрії, зворотне титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Нітритометрії, пряме титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Цериметрії, пряме титрування', false, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрії, зворотне титрування', true, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У контрольно-аналітичній лабораторії проводиться фармакопейний аналіз лікарського засобу «Кислоти ацетилсаліцилової таблетки». Для визначення кількісного вмісту діючої речовини використовують метод УФ-спектрофотометрії. Для цього вимірюють:', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оптичну густину', true, 0),
  ((SELECT id FROM inserted_question), 'Температуру плавлення', false, 1),
  ((SELECT id FROM inserted_question), 'Показник заломлення', false, 2),
  ((SELECT id FROM inserted_question), 'В’язкість', false, 3),
  ((SELECT id FROM inserted_question), 'Кут обертання', false, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для кількісного визначення сульфатіазолу (норсульфазолу) може бути використане пряме аргентометричне титрування за методом Мора. Який індикатор застосовують для такого аналізу?', NULL, 'medium', 50, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Крохмаль', false, 0),
  ((SELECT id FROM inserted_question), 'В. Тропеолін 00', false, 1),
  ((SELECT id FROM inserted_question), 'С. Бромфеноловий синій', false, 2),
  ((SELECT id FROM inserted_question), 'D. Метиленовий синій', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Калію хромат', true, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який метод кількісного визначення за вимогами ДФУ необхідно використати для аналізу субстанції ізоніазиду?', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Ацидиметрія у неводному середовищі', false, 0),
  ((SELECT id FROM inserted_question), 'В. Алкаліметрія', false, 1),
  ((SELECT id FROM inserted_question), 'C. Фотоколориметрія', false, 2),
  ((SELECT id FROM inserted_question), 'D. Броматометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Е. Нітритометрія після лужного гідролізу', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який фізико-хімічний метод аналізу використовується для кількісного визначення калію дихромату?', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поляриметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Флуориметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Кулонометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Турбідиметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Спектрофотометрія', true, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Проводиться експрес-аналіз мікстури, що містить кальцію хлорид і натрію бромід. Який метод треба використати для сумарного кількісного визначення інгредієнтів цієї лікарської форми?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрію', true, 0),
  ((SELECT id FROM inserted_question), 'Алкаліметрію', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексонометрію', false, 2),
  ((SELECT id FROM inserted_question), 'Поляриметрію', false, 3),
  ((SELECT id FROM inserted_question), 'Нітритометрію', false, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фармацевт-аналітик проводить експрес-аналіз 2%-го розчину борної кислоти. Який метод він має застосувати для кількісного визначення діючої речовини?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Ацидиметрії', false, 0),
  ((SELECT id FROM inserted_question), 'В. Аргентометрії', false, 1),
  ((SELECT id FROM inserted_question), 'С. Комплексонометрії', false, 2),
  ((SELECT id FROM inserted_question), 'D. Алкаліметрії', true, 3),
  ((SELECT id FROM inserted_question), 'Е. Нітритометрії', false, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії на аналіз надійшла субстанція глібенкламіду. Відповідно до вимог ДФУ, кількісний вміст глібенкламіду визначають методом:', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Йодометрії', false, 0),
  ((SELECT id FROM inserted_question), 'В. Алкаліметрії', true, 1),
  ((SELECT id FROM inserted_question), 'С. Йодхлорметрії', false, 2),
  ((SELECT id FROM inserted_question), 'D. Броматометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Ацидиметрії', false, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лабораторії з контролю якості лікарських засобів на аналіз надійшов сульфацид-натрію. Вкажіть, який саме метод використовується, згідно з ДФХ для кількісного визначення сульфаніламідів:', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітритометрії', true, 0),
  ((SELECT id FROM inserted_question), 'Гравіметричний', false, 1),
  ((SELECT id FROM inserted_question), 'Перманганатометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Йодометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексонометрії', false, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким методом титриметричного аналізу проводиться кількісне визначення стрептоциду (сульфаніламіду) розчином КВrОз у присутності КВr?', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ванадатометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Дихроматометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик проводить аналіз натрію диклофенаку. Вкажіть метод кількісного його визначення згідно з вимогами ДФУ:', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацидиметрія у водному середовищі', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрія у неводному середовищі', true, 1),
  ((SELECT id FROM inserted_question), 'Алкаліметрія у спирто-хлороформній суміші', false, 2),
  ((SELECT id FROM inserted_question), 'Алкаліметрія у неводному середовищі', false, 3),
  ((SELECT id FROM inserted_question), 'Алкаліметрія у водному середовищі', false, 4);


-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть метод оптичного аналізу, який застосовують для визначення кількісного вмісту кожної з речовин в багатокомпонентній суміші:', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Багатохвильова спектрофотометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Потенціометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Флюориметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Кондуктометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Поляриметрія', false, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Методом броматометрії можна провести кількісний аналіз такого лікарського засобу:', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'β-аланіну', false, 0),
  ((SELECT id FROM inserted_question), 'Кислоти глутамінової', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію саліцилата', true, 2),
  ((SELECT id FROM inserted_question), 'Кислоти бензойної', false, 3),
  ((SELECT id FROM inserted_question), 'Калію ацетату', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик здійснює кількісний аналіз ізоніазиду методом прямої броматометрії з використанням титрованого розчину калію бромату, калію броміду, хлоридної кислоти та індикатора метилового червоного. В основі цього методу лежить реакція:', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бромування піридинового циклу', false, 0),
  ((SELECT id FROM inserted_question), 'Окиснення гідразино-групи бромом', true, 1),
  ((SELECT id FROM inserted_question), 'Окиснення залишку гідразину калій бромідом', false, 2),
  ((SELECT id FROM inserted_question), 'Відновлення залишку гідразину бромом', false, 3),
  ((SELECT id FROM inserted_question), 'Розкриття піридинового циклу', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який метод кількісного аналізу заснований на утворенні комплексних сполук галогенід-іонів із солями Нg2+?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Меркуриметрія', true, 1),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які індикатори застосовують під час комплексонометричного методу кількісного аналізу?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Редокс-індикатори', false, 0),
  ((SELECT id FROM inserted_question), 'Адсорбційні індикатори', false, 1),
  ((SELECT id FROM inserted_question), 'Металохромні індикатори', true, 2),
  ((SELECT id FROM inserted_question), 'рН-індикатори', false, 3),
  ((SELECT id FROM inserted_question), 'Хемілюмінесцентні індикатори', false, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Субстанцію дибазолу аналізують на кількісний вміст діючої речовини методом ацидиметрії в неводному середовищі. Який титрант та індикатор використовують в цьому методі?', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин натрію метилату, тимоловий синій', false, 0),
  ((SELECT id FROM inserted_question), 'Розчин кислоти нітратної, кристалічний фіолетовий', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин натрію гідроксиду, фенолфталеїн', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин кислоти перхлоратної, кристалічний фіолетовий', true, 3),
  ((SELECT id FROM inserted_question), 'Розчин кислоти сульфатної, нафтол-бензеїн', false, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізору-аналітику необхідно провести аналіз очних крапель, до складу яких входить калію йодид. Для його кількісного визначення використовується такий метод:', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кислотно-основне титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Аргентометрія', true, 2),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Субстанцію дибазолу аналізують на кількісний вміст діючої речовини методом ацидиметрії в неводному середовищі. Який титрант та індикатор використовують в цьому методі?', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин кислоти перхлоратної, кристалічний фіолетовий', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин натрію гідроксиду, фенолфталеїн', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин кислоти сульфатної, нафтолбензеїн', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин натрію метилату, тимоловий синій', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин кислоти нітратної, кристалічний фіолетовий', false, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть електрохімічний метод кількісного аналізу, що заснований на вимірюванні кількості електричного струму, витраченого на електрохімічне відновлення або окислення іонів або елементів, що визначають в процесі електролізу:', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кулонометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Полярографія', false, 1),
  ((SELECT id FROM inserted_question), 'Кондуктометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Амперометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Потенціометрія', false, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик проводить фармакопейний аналіз субстанції тимолу. Кількісне визначення згідно вимог Фармакопеї проводиться таким методом:', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зворотня ацидіметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Зворотня йодометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Пряма броматометрія', true, 2),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Зворотня комплексонометрія', false, 4);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хіміко-токсикологічному аналізі для кількісного визначення ртуті в біологічному матеріалі рекомендовано екстракційно-фотометричний метод, який базується на реакції з такою речовиною:', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дитізон', true, 0),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазид', false, 1),
  ((SELECT id FROM inserted_question), 'Тіосульфат натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Сульфід натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Тіосечовина', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для аналізу надійшов розчин калію дихромату. Для його кількісного визначення був використаний один із фізико-хімічних методів аналізу, а саме:', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Флуориметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Поляриметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Кулонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Турбідиметрія', false, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На аналіз надійшов розчин калію дихромату. Для його кількісного визначення був використаний один з фізикохімічних методів аналізу:', NULL, 'medium', 71, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поляриметричний', false, 0),
  ((SELECT id FROM inserted_question), 'Кулонометричний', false, 1),
  ((SELECT id FROM inserted_question), 'Турбідиметричний', false, 2),
  ((SELECT id FROM inserted_question), 'Флуориметричний', false, 3),
  ((SELECT id FROM inserted_question), 'Спектрофотометричний', true, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод кількісного аналізу, заснований на вимірюванні кількості електрики, витраченої на проведення електрохімічної реакції:', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кулонометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Кондуктометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Амперометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Потенціометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Полярографія', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До судово-хімічної лабораторії надійшов об''єкт, при дослідженні якого необхідно провести кількісне визначення меркурію за реакцією із дитизоном. Який фізико-хімічний метод використовується при такому аналізі?', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хроматографія в тонкому шарі сорбенту', false, 0),
  ((SELECT id FROM inserted_question), 'ІЧ-спектрофотометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Екстракційна фотоколориметрія', true, 2),
  ((SELECT id FROM inserted_question), 'УФ-спектрофотометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Газо-рідинна хроматографія', false, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який статистичний метод обробки даних треба обрати для того, щоб кількісно визначити лінійну залежність, яка може існувати між незалежною змінною Х і залежною змінною Y?', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '-', false, 0),
  ((SELECT id FROM inserted_question), 'Лінійний регресійний аналіз', true, 1),
  ((SELECT id FROM inserted_question), 'Кореляційний аналіз (коефіцієнт кореляції Пірсона)', false, 2),
  ((SELECT id FROM inserted_question), 'Кореляційний аналіз (коефіцієнт рангової кореляції Спірмена)', false, 3),
  ((SELECT id FROM inserted_question), 'Частотний аналіз', false, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізору-аналітику аптечного складу на аналіз надійшла субстанция пероксиду водню. Кількіснє визначення цього лікарського засобу він повинен виконати перманганатометричним методом. До появи якого забарвлення розчину проводиться титрування згідно аналітичних нормативних документів?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Безбарвне', false, 0),
  ((SELECT id FROM inserted_question), 'Рожеве', true, 1),
  ((SELECT id FROM inserted_question), 'Жовте', false, 2),
  ((SELECT id FROM inserted_question), 'Синє', false, 3),
  ((SELECT id FROM inserted_question), 'Зелене', false, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії на аналіз надійшла субстанція лимонної кислоти. У відповідності до вимог ДФУ кількісний вміст кислоти лимонної можна визначити методом:', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкаліметрії', true, 0),
  ((SELECT id FROM inserted_question), 'Йодометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Ацидиметрії', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Йодхлорметрії', false, 4);


-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Спеціаліст контрольно-аналітичної лабораторії проводить кількісне визначення Ca2+ в субстанції кальцію панто-тенату. Вкажіть цей метод аналізу:', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', true, 2),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 4);


-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На аналіз надійшла субстанція анальгіну. Оберіть метод, за допомогою якого можна визначити кількісний вміст анальгіну:', NULL, 'medium', 78, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Йодометрія', true, 1),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 4);


-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час проведення хіміко-токсикологічного аналізу на пестициди використовуються методи кількісного визначення речовин в органічних екстрактах. Який метод є найбільш чутливим при проведенні кількісного аналізу хлорофосу:', NULL, 'medium', 79, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Планіметричний', false, 0),
  ((SELECT id FROM inserted_question), 'Аргентометричний', false, 1),
  ((SELECT id FROM inserted_question), 'Фотометричний', false, 2),
  ((SELECT id FROM inserted_question), 'Біохімічний', true, 3),
  ((SELECT id FROM inserted_question), 'Гравіметричний', false, 4);


-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії на аналіз надійшла субстанція натрію тетраборату. За допомогою якого методу, у відповідності до вимог ДФУ можна визначити кількісний вміст натрію тетраборату?', NULL, 'medium', 80, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Йодхлорометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', true, 4);


-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До контрольно-аналітичної лабораторії для аналізу надійшли ампули тестостерону пропіонату. Кількісне визначення відповідно до вимог АНД провізор-аналітик повинен проводити наступним методом:', NULL, 'medium', 81, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поляриметричний', false, 0),
  ((SELECT id FROM inserted_question), 'УФ-спектрофотометричний', true, 1),
  ((SELECT id FROM inserted_question), 'Гравіметричний', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометричний', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометричний', false, 4);


-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Необхідно провести кількісне визначення натрію гідрокарбонату в препараті. Яким із методів титриметричного аналізу його можна визначити?', NULL, 'medium', 82, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кислотно-основне титрування', true, 0),
  ((SELECT id FROM inserted_question), 'Окислювально-відновне титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Осаджувальне титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Неводне титрування', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексонометричне титрування', false, 4);


-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик здійснює аналіз 10% розчину глюкози. Для кількісного визначення він використовує один з фізико-хімічних методів, вимірюючи кут обертання розчину за допомогою:', NULL, 'medium', 83, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поляриметру', true, 0),
  ((SELECT id FROM inserted_question), 'Потенціометру', false, 1),
  ((SELECT id FROM inserted_question), 'Газового хроматографу', false, 2),
  ((SELECT id FROM inserted_question), 'Рефрактометру', false, 3),
  ((SELECT id FROM inserted_question), 'УФ-спектрофотометру', false, 4);


-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час систематичного аналізу суміші катіонів катіони заліза (III) можна визначити дробним методом. Який реактив для цього треба використати?', NULL, 'medium', 84, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Азотну кислоту', false, 0),
  ((SELECT id FROM inserted_question), 'Хлористоводневу кислоту', false, 1),
  ((SELECT id FROM inserted_question), 'Калію гексаціаноферат (II)', true, 2),
  ((SELECT id FROM inserted_question), 'Натрію дигідрофосфат', false, 3),
  ((SELECT id FROM inserted_question), 'Калію хлорид', false, 4);


-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які інформаційні джерела мають найвищу інформаційну цінність з урахуванням рівня доказовості?', NULL, 'medium', 85, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оглядова стаття та мета-аналіз', false, 0),
  ((SELECT id FROM inserted_question), 'Мета-аналіз та систематичний огляд', true, 1),
  ((SELECT id FROM inserted_question), 'Оглядова стаття та систематичний огляд', false, 2),
  ((SELECT id FROM inserted_question), 'Оригінальна стаття з результатами кореляційного дослідження та систематичний огляд', false, 3),
  ((SELECT id FROM inserted_question), 'Мета-аналіз та оригінальна стаття з результатами кореляційного дослідження', false, 4);


-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Інтерн проводить огляд наукових статей, публікацій та інших джерел інформації щодо лікування алергічного риніту для отримання сумарних статистичних показників результатів досліджень. Який кількісний систематичний огляд проводить інтерн:', NULL, 'medium', 86, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Експеримент', false, 0),
  ((SELECT id FROM inserted_question), 'Витрати-вигода', false, 1),
  ((SELECT id FROM inserted_question), 'Метааналіз', true, 2),
  ((SELECT id FROM inserted_question), 'Спостереження', false, 3),
  ((SELECT id FROM inserted_question), 'Витрати-ефективність', false, 4);


-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть груповий реагент для відокремлення катіонів ІІІ аналітичної групи за кислотно-основною класифікацією при проведенні систематичного аналізу суміші.', NULL, 'medium', 87, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хлоридна кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Сульфатна кислота', true, 1),
  ((SELECT id FROM inserted_question), 'Амоніак', false, 2),
  ((SELECT id FROM inserted_question), 'Барій хлорид', false, 3),
  ((SELECT id FROM inserted_question), 'Луг та гідроген пероксид', false, 4);


-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Із якою метою в систематичному ході аналізу катіонів ІV групи разом із груповим реагентом додають пероксид водню?', NULL, 'medium', 88, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Для повного осадження цих катіонів', false, 0),
  ((SELECT id FROM inserted_question), 'Для утворення гідроксо- та оксоаніонів цих елементів у найнижчих ступенях окиснення', false, 1),
  ((SELECT id FROM inserted_question), 'Для утворення пероксидних сполук цих катіонів', false, 2),
  ((SELECT id FROM inserted_question), 'Для руйнування гідратних комплексів', false, 3),
  ((SELECT id FROM inserted_question), 'Для утворення гідроксо- та оксоаніонів цих елементів у найвищих ступенях окиснення', true, 4);


-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Що є первинними джерелами інформації в доказовій медицині?', NULL, 'medium', 89, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Клінічні рекомендації', false, 0),
  ((SELECT id FROM inserted_question), 'Метааналізи', false, 1),
  ((SELECT id FROM inserted_question), 'Оригінальні дослідження', true, 2),
  ((SELECT id FROM inserted_question), 'Систематичні огляди', false, 3),
  ((SELECT id FROM inserted_question), 'Формулярні довідники', false, 4);


-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час систематичного аналізу суміші катіонів катіони заліза (III) можна визначити дробним методом. Який реактив для цього треба використати?', NULL, 'medium', 90, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Азотну кислоту', false, 0),
  ((SELECT id FROM inserted_question), 'Хлористоводневу кислоту', false, 1),
  ((SELECT id FROM inserted_question), 'Калію гексаціаноферат (II)', true, 2),
  ((SELECT id FROM inserted_question), 'Натрію дигідрофосфат', false, 3),
  ((SELECT id FROM inserted_question), 'Калію хлорид', false, 4);


-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В роботі епідеміолога використовується систематичний та безперервно діючий збір, облік, складання та аналіз, тлумачення, поширення даних медико-санітарного призначення, епідемічного благополуччя населення і показників середовища життєдіяльності для оцінки і прийняття необхідних відповідних заходів в сфері громадського здоров’я. Як називається така система?', NULL, 'medium', 91, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Епідеміологічний нагляд', true, 0),
  ((SELECT id FROM inserted_question), 'Епідеміологічний аналіз', false, 1),
  ((SELECT id FROM inserted_question), 'Моніторинг', false, 2),
  ((SELECT id FROM inserted_question), 'Епідеміологічне обстеження', false, 3),
  ((SELECT id FROM inserted_question), 'Оцінка', false, 4);


-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реагентом в систематичному ході аналізу можна розділити хлориди арґентуму та меркурію (І) і водночас виявити катіони меркурію (І)?', NULL, 'medium', 92, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин аміаку', true, 0),
  ((SELECT id FROM inserted_question), 'Гаряча вода', false, 1),
  ((SELECT id FROM inserted_question), 'Надлишок концентрованої хлоридної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин нітратної кислоти', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин лугу', false, 4);


-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні систематичного ходу аналізу на розчин подіяли груповим реагентом 1M H2SO4 у присутності етилового спирту, утворився білий осад. Катіони якої групи присутні у розчині?', NULL, 'medium', 93, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'III', true, 0),
  ((SELECT id FROM inserted_question), 'І', false, 1),
  ((SELECT id FROM inserted_question), 'II', false, 2),
  ((SELECT id FROM inserted_question), 'IV', false, 3),
  ((SELECT id FROM inserted_question), 'VI', false, 4);


-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реагентом в систематичному ході аналізу можна розділити хлориди арґентуму та меркурію (I) і водночас виявити катіони меркурію ( I)?', NULL, 'medium', 94, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин аміаку', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин лугу', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин нітратної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Надлишок концентрованої хлоридної кислоти', false, 3),
  ((SELECT id FROM inserted_question), 'Гаряча вода', false, 4);


-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик проводить якісний систематичний аналіз суміші катіонів першої аналітичної групи. Який катіон визначають на початку дослідження специфічною реакцією?', NULL, 'medium', 95, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', false, 0),
  ((SELECT id FROM inserted_question), 'Літію', false, 1),
  ((SELECT id FROM inserted_question), 'Арґентуму', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Амонію', true, 4);


-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні систематичного ходу аналізу на розчин подіяли груповим реагентом 1М H2SO4 у присутності етилового спирту, утворився білий осад. Катіони якої групи присутні у розчині?', NULL, 'medium', 96, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'III', true, 0),
  ((SELECT id FROM inserted_question), 'IV', false, 1),
  ((SELECT id FROM inserted_question), 'II', false, 2),
  ((SELECT id FROM inserted_question), 'VI', false, 3),
  ((SELECT id FROM inserted_question), 'I', false, 4);


-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реагентом можна відокремити магній-катіони від інших катіонів V аналітичної групи в систематичному ході аналізу?', NULL, 'medium', 97, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Насичений розчин амонію хлориду', true, 0),
  ((SELECT id FROM inserted_question), 'Надлишок концентрованого розчину амоніаку', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроген пероксид', false, 2),
  ((SELECT id FROM inserted_question), 'Нітратна кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин лугу', false, 4);


-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аналізі аніонів I-III аналітичних груп систематичний хід аналізу необхідний при сумісній присутності:', NULL, 'medium', 98, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сульфат-, сульфіт-, тіосульфат- і сульфід-іонів', true, 0),
  ((SELECT id FROM inserted_question), 'Сульфат-, ацетат-, фосфат-іонів', false, 1),
  ((SELECT id FROM inserted_question), 'Сульфат-, нітрат-, хлорид-іонів', false, 2),
  ((SELECT id FROM inserted_question), 'Сульфат-, оксалат-, ацетат-іонів', false, 3),
  ((SELECT id FROM inserted_question), 'Сульфат-, арсенат-, нітрат-іонів', false, 4);


-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Розділення катіонів V і VI аналітичних груп (кислотно-основна класифікація) в систематичному ході аналізу проводять при дії надлишку:', NULL, 'medium', 99, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Концентрованого розчину амоніаку', true, 0),
  ((SELECT id FROM inserted_question), 'Розчину натрій гідроксиду', false, 1),
  ((SELECT id FROM inserted_question), 'Розчину хлоридної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Розчину калій гідроксиду', false, 3),
  ((SELECT id FROM inserted_question), 'Розчину сульфатної кислоти', false, 4);


-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Катіони третьої аналітичної групи (кислотно-основна класифікація) відокремлюють у систематичному ході аналізу за допомогою такого групового реагенту:', NULL, 'medium', 100, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1 М розчин сульфатної кислоти в присутності етанолу', true, 0),
  ((SELECT id FROM inserted_question), '1 М розчин хромату калію', false, 1),
  ((SELECT id FROM inserted_question), '0,1 М розчин карбонату натрію', false, 2),
  ((SELECT id FROM inserted_question), '0,1 М розчин оксалату амонію', false, 3),
  ((SELECT id FROM inserted_question), '1 М розчин карбонату амонію', false, 4);


-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Визначте психотерапевтичні техніки, що характерні для поведінкового підходу.', NULL, 'medium', 101, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргументи <<за>> та <<проти>>, сократівський діалог, переоцінка фактів, декатастрофізація', false, 0),
  ((SELECT id FROM inserted_question), 'Систематична десенсибілізація, імплозивна терапія, метод інструкцій, імітаційне навчання', true, 1),
  ((SELECT id FROM inserted_question), 'Техніка повторів, парадоксальна інтенція, дерефлексія, концентрування уваги на почуттях', false, 2),
  ((SELECT id FROM inserted_question), 'Персональне знаходження позиції, зміщення перспективи, дерефлексія, метод укріплення волі', false, 3),
  ((SELECT id FROM inserted_question), 'Інтерпретація, аналіз опору, аналіз трансферу, метод вільних асоціацій', false, 4);


-- Question 102
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Константа швидкості хімічної реакції чисельно дорівнює швидкості реакції за умови, що молярні концентрації:', NULL, 'medium', 102, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реагентів дорівнюють одиниці', true, 0),
  ((SELECT id FROM inserted_question), 'Реагентів відрізняються на одиницю', false, 1),
  ((SELECT id FROM inserted_question), 'Продуктів одинакові', false, 2),
  ((SELECT id FROM inserted_question), 'Продуктів відрізняються на одиницю', false, 3),
  ((SELECT id FROM inserted_question), '-', false, 4);


-- Question 103
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У трьох пронумерованих пробірках відбуваються реакції з утворенням газів: 1-етилену, 2-ацетилену, 3-пропену, які пропускали через аміачний розчин при взаємодії із вказаним реагентом аргентум оксиду. Газ із якої пробірки при взаємодії із вказаним реагентом утворить білий осад?', NULL, 'medium', 103, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лише з 3-ї', false, 0),
  ((SELECT id FROM inserted_question), 'Лише з 1-ї', false, 1),
  ((SELECT id FROM inserted_question), 'З 1-ї та 3-ї', false, 2),
  ((SELECT id FROM inserted_question), 'Лише з 2-ї', true, 3),
  ((SELECT id FROM inserted_question), 'З 2-ї та 3-ї', false, 4);


-- Question 104
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть реагент для ідентифікації катіонів плюмбуму згідно з ДФУ.', NULL, 'medium', 104, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин формальдегіду', false, 0),
  ((SELECT id FROM inserted_question), 'Калій йодид', true, 1),
  ((SELECT id FROM inserted_question), 'Сечовина', false, 2),
  ((SELECT id FROM inserted_question), 'Натрій сульфіт', false, 3),
  ((SELECT id FROM inserted_question), 'Натрій гідроксид', false, 4);


-- Question 105
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який специфічний реагент застосовують для ідентифікації катіонів Fe2+?', NULL, 'medium', 105, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NH4OH', false, 0),
  ((SELECT id FROM inserted_question), 'NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'K3[Fe(CN)6]', true, 2),
  ((SELECT id FROM inserted_question), 'K2Na[Co(NO2)6]', false, 3),
  ((SELECT id FROM inserted_question), 'H2SO4', false, 4);


-- Question 106
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть груповий реагент для відокремлення катіонів ІІІ аналітичної групи за кислотно-основною класифікацією при проведенні систематичного аналізу суміші.', NULL, 'medium', 106, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хлоридна кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Сульфатна кислота', true, 1),
  ((SELECT id FROM inserted_question), 'Амоніак', false, 2),
  ((SELECT id FROM inserted_question), 'Барій хлорид', false, 3),
  ((SELECT id FROM inserted_question), 'Луг та гідроген пероксид', false, 4);


-- Question 107
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть спільний реагент для ідентифікації саліцилат- та бензоат-йонів.', NULL, 'medium', 107, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентум нітрат', false, 0),
  ((SELECT id FROM inserted_question), 'Натрій гідроксид', false, 1),
  ((SELECT id FROM inserted_question), 'Ферум (ІІІ) хлорид', true, 2),
  ((SELECT id FROM inserted_question), 'Резорцин', false, 3),
  ((SELECT id FROM inserted_question), 'Барій хлорид', false, 4);


-- Question 108
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Плоди жостеру проносного містять похідні антрацену. Якісна реакція з яким реагентом вказує на наявність цих речовин у лікарській рослинній сировині?', NULL, 'medium', 108, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З лугом', true, 0),
  ((SELECT id FROM inserted_question), 'З реактивом Моліша', false, 1),
  ((SELECT id FROM inserted_question), 'З реактивом Фелінга', false, 2),
  ((SELECT id FROM inserted_question), 'Із сульфатом заліза(ІІ)', false, 3),
  ((SELECT id FROM inserted_question), 'Із залізоамонійним галуном', false, 4);


-- Question 109
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У досліджуваному розчині знаходяться катіони магнію і купруму (IІ). За допомогою розчину якого реагенту можна розділити ці катіони?', NULL, 'medium', 109, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аміаку', true, 0),
  ((SELECT id FROM inserted_question), 'Сульфатної кислоти', false, 1),
  ((SELECT id FROM inserted_question), 'Хлоридної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Нітратної кислоти', false, 3),
  ((SELECT id FROM inserted_question), 'Калію хромату', false, 4);


-- Question 110
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дії групового реагенту AgNОз на аніони II аналітичної групи утворився жовтий осад, що не розчиняється в розчині аміаку. Укажіть склад цього осаду.', NULL, 'medium', 110, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'AgI', true, 0),
  ((SELECT id FROM inserted_question), 'Ag2S', false, 1),
  ((SELECT id FROM inserted_question), 'AgCl', false, 2),
  ((SELECT id FROM inserted_question), 'Ag2SO4', false, 3),
  ((SELECT id FROM inserted_question), 'AgNCS', false, 4);


-- Question 111
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Застосування якого реагенту дозволяє одержати етиленгліколь за нижченаведеною схемою перетворення?', NULL, 'medium', 111, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NH3', false, 0),
  ((SELECT id FROM inserted_question), 'H2O (H+)', true, 1),
  ((SELECT id FROM inserted_question), 'HClO4', false, 2),
  ((SELECT id FROM inserted_question), 'CH3COOH', false, 3),
  ((SELECT id FROM inserted_question), 'NaCl', false, 4);


-- Question 112
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик проводить ідентифікацію фенолу, використовуючи реакцію на фенольний гідроксил. Укажіть реагент, потрібний для проведення цієї реакції:', NULL, 'medium', 112, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Заліза(ІІІ) хлорид', true, 0),
  ((SELECT id FROM inserted_question), 'В. Кислота сірчана', false, 1),
  ((SELECT id FROM inserted_question), 'С. Кальцію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'D. Натрію сульфат', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Калію хлорид', false, 4);


-- Question 113
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити Етанол (С2Н5ОН) від гліцерину ( CH2OH – CHOH - CH2OH)?', NULL, 'medium', 113, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'KMnO4', false, 0),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 1),
  ((SELECT id FROM inserted_question), 'Сu(OH)2', true, 2),
  ((SELECT id FROM inserted_question), 'HBr', false, 3),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 4);


-- Question 114
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту можна відрізнити нижченаведену пару сполук?', NULL, 'medium', 114, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img2.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'FeCl3', false, 0),
  ((SELECT id FROM inserted_question), 'NaNO3+HCl', false, 1),
  ((SELECT id FROM inserted_question), 'NaOH', false, 2),
  ((SELECT id FROM inserted_question), 'HCl', false, 3),
  ((SELECT id FROM inserted_question), 'Ag(NH3)2OH', true, 4);


-- Question 115
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть реагент, за допомогою якого можна підтвердити приналежність аланіну до а-амінокислот:', NULL, 'medium', 115, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А. Розчин сірчаної кислоти', false, 0),
  ((SELECT id FROM inserted_question), 'B. Розчин барію гідроксиду', false, 1),
  ((SELECT id FROM inserted_question), 'С. Розчин сульфосаліцілової кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'D. Насичений розчин натрію гідрокарбонату', false, 3),
  ((SELECT id FROM inserted_question), 'Е. Розчин нінгідрину', true, 4);


-- Question 116
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть реагент, що вступає в реакцію з аміногрупою п-амінобензойної кислоти?', NULL, 'medium', 116, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img3.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaOH', false, 0),
  ((SELECT id FROM inserted_question), 'SOCl2', false, 1),
  ((SELECT id FROM inserted_question), '(CH3CO)2O', true, 2),
  ((SELECT id FROM inserted_question), 'NaHCO3', false, 3),
  ((SELECT id FROM inserted_question), 'Br2', false, 4);


-- Question 117
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під дією якого реагенту метиламонію хлорид перетвориться на метиламін?', NULL, 'medium', 117, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img4.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Br2', false, 0),
  ((SELECT id FROM inserted_question), 'N2', false, 1),
  ((SELECT id FROM inserted_question), 'O2', false, 2),
  ((SELECT id FROM inserted_question), 'HCl', false, 3),
  ((SELECT id FROM inserted_question), 'NaOH', true, 4);


-- Question 118
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть реагент, що вступає в реакцію з аміногрупою п-амінобензойної кислоти?', NULL, 'medium', 118, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img5.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaOH', false, 0),
  ((SELECT id FROM inserted_question), 'SOCl2', false, 1),
  ((SELECT id FROM inserted_question), '(CH3CO)2O', true, 2),
  ((SELECT id FROM inserted_question), 'NaHCO3', false, 3),
  ((SELECT id FROM inserted_question), 'Br2', false, 4);


-- Question 119
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук під час нагрівання з водовіднімальними реагентами утворює акролеїн?', NULL, 'medium', 119, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img6.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 120
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У кажіть найактивніший ацилюючий реагент.', NULL, 'medium', 120, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img7.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', true, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 121
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час взаємодії з яким реагентом фосфат- та арсенат-аніони утворюють аналогічні осади, нерозчинні у розчині аміаку?', NULL, 'medium', 121, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчином натрію гідроксиду', false, 0),
  ((SELECT id FROM inserted_question), 'Магнезіальною сумішню (розчином, що містить МgCl2, NH4CI, NH3)', true, 1),
  ((SELECT id FROM inserted_question), 'Розчином плюмбуму ацетату', false, 2),
  ((SELECT id FROM inserted_question), 'Реактивом Неслера', false, 3),
  ((SELECT id FROM inserted_question), 'Розчином кобальту сульфату', false, 4);


-- Question 122
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який електрофільний реагент застосовується для сульфування піролу і фурану?', NULL, 'medium', 122, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'b. Концентрована сульфатна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'c. Розбавлена сульфатна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'd. Піридинсульфотриоксид', true, 3),
  ((SELECT id FROM inserted_question), 'e. Суміш сульфатної і нітратної кислот', false, 4);


-- Question 123
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким буде порядок реакції, якщо один із реагентів, що бере участь у бімолекулярній реакції, було взято у великому надлишку?', NULL, 'medium', 123, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Третій', false, 0),
  ((SELECT id FROM inserted_question), 'Визначатиметься за речовиною, взятою в надлишку', false, 1),
  ((SELECT id FROM inserted_question), 'Буде більшим за молекулярність', false, 2),
  ((SELECT id FROM inserted_question), 'Дорівнюватиме молекулярності', false, 3),
  ((SELECT id FROM inserted_question), 'Псевдомономолекулярний', true, 4);


-- Question 124
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Білітраст – пероральний рентгеноконтрастний засіб для дослідження жовчних шляхів. Вкажіть реагент, за допомогою якого можна підтвердити наявність фенольного гідроксилу в його молекулі:', NULL, 'medium', 124, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин феруму (ІІІ) хлориду', true, 0),
  ((SELECT id FROM inserted_question), 'Спиртовий розчин йоду', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин йоду в калію йодиді', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин арґентуму нітрату', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин кислоти хлороводневої', false, 4);


-- Question 125
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук під час нагрівання з водовіднімальними реагентами утворює акролеїн?', NULL, 'medium', 125, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img8.jpeg,/test-images/pharmaceutical-analysis/fazova-rivnovaga/img9.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А', false, 0),
  ((SELECT id FROM inserted_question), 'B', true, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 126
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як називаються реакції та реагенти, що дають можливість за певних умов визначити певні іони в присутності інших іонів?', NULL, 'medium', 126, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вибіркові', false, 0),
  ((SELECT id FROM inserted_question), 'Характерні', false, 1),
  ((SELECT id FROM inserted_question), 'Групові', false, 2),
  ((SELECT id FROM inserted_question), 'Специфічні', true, 3),
  ((SELECT id FROM inserted_question), 'Загальні', false, 4);


-- Question 127
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити етанол (C2Н5ОН) від гліцерину (CH2OH–СНОН–CH2ОН)?', NULL, 'medium', 127, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'FeCl3', false, 0),
  ((SELECT id FROM inserted_question), 'НBr', false, 1),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 2),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 3),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 4);


-- Question 128
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Молекула ізатину містить усвоєму складі кетонну групу. За допомогою якого реагенту можна це довести?', NULL, 'medium', 128, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img10.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NН2OН', true, 0),
  ((SELECT id FROM inserted_question), 'CH3C(О)Cl', false, 1),
  ((SELECT id FROM inserted_question), 'NaНCO3', false, 2),
  ((SELECT id FROM inserted_question), 'NaOH', false, 3),
  ((SELECT id FROM inserted_question), '[Ag(NH3)2]OH', false, 4);


-- Question 129
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під дією якого реагенту метиламонію хлорид перетвориться на метиламін?', NULL, 'medium', 129, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img11.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'О2', false, 0),
  ((SELECT id FROM inserted_question), 'Br2', false, 1),
  ((SELECT id FROM inserted_question), 'HCI', false, 2),
  ((SELECT id FROM inserted_question), 'N2', false, 3),
  ((SELECT id FROM inserted_question), 'NaOH', true, 4);


-- Question 130
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До шостої групи катіонів належать катіони Cu2+, Co2+, Ni2+, Cd2+, Hg2+. Який груповий реагент застосовується для визначення катіонів шостої групи?', NULL, 'medium', 130, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин HCI', false, 0),
  ((SELECT id FROM inserted_question), 'Розчин NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин H2SO4', false, 2),
  ((SELECT id FROM inserted_question), 'Надлишок розчину КОН', false, 3),
  ((SELECT id FROM inserted_question), 'Надлишок розчину аміаку концентрованого', true, 4);


-- Question 131
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджуваний розчин містить катіони амонію і натрію. Укажіть реагент, який дає змогу виявити в цьому розчині катіони натрію.', NULL, 'medium', 131, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Цинкуранілацетат', true, 0),
  ((SELECT id FROM inserted_question), 'Калію гідротартрат', false, 1),
  ((SELECT id FROM inserted_question), 'Калію оксалат', false, 2),
  ((SELECT id FROM inserted_question), 'Калію бензоат', false, 3),
  ((SELECT id FROM inserted_question), 'Калію тетрайодомеркурат (II)', false, 4);


-- Question 132
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З яким реагентом п-амінобензойна кислота реагує по аміногрупі?', NULL, 'medium', 132, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCl', true, 0),
  ((SELECT id FROM inserted_question), 'CH3COONa', false, 1),
  ((SELECT id FROM inserted_question), 'NaOH', false, 2),
  ((SELECT id FROM inserted_question), 'NH4OH', false, 3),
  ((SELECT id FROM inserted_question), 'KCN', false, 4);


-- Question 133
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У процесі аналізу катіонів VI аналітичної групи (кислотно-основна класифікація) під час дії групового реагенту можна не тільки відокремити групу, але й ідентифікувати іони:', NULL, 'medium', 133, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Cu (II)', true, 0),
  ((SELECT id FROM inserted_question), 'Cd (II)', false, 1),
  ((SELECT id FROM inserted_question), 'Co (II)', false, 2),
  ((SELECT id FROM inserted_question), 'Ni (II)', false, 3),
  ((SELECT id FROM inserted_question), 'Fе (II)', false, 4);


-- Question 134
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чому аніони третьої аналітичної групи аніонів не мають групового реагенту?', NULL, 'medium', 134, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З більшістю катіонів утворюють розчинні у воді солі', true, 0),
  ((SELECT id FROM inserted_question), 'Належать до токсичних елементів', false, 1),
  ((SELECT id FROM inserted_question), 'Мають великі іонні радіуси', false, 2),
  ((SELECT id FROM inserted_question), 'Мають близькі іонні радіуси', false, 3),
  ((SELECT id FROM inserted_question), 'Мають здатність утворювати розчинні кислоти', false, 4);


-- Question 135
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час взаємодії якого реагенту з піридином можна отримати 2-амінопіридин?', NULL, 'medium', 135, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амонію гідроксиду', false, 0),
  ((SELECT id FROM inserted_question), 'Гідразину', false, 1),
  ((SELECT id FROM inserted_question), 'Амонію хлориду', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію аміду', true, 3),
  ((SELECT id FROM inserted_question), 'Амоніаку', false, 4);


-- Question 136
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Більшість хімічних та фармацевтичних виробництв використовують каталітичні процеси. Як називають каталіз, за якого каталізатор і реагенти утворюють одну фазу?', NULL, 'medium', 136, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гомогенний', true, 0),
  ((SELECT id FROM inserted_question), 'Загальний кислотно-основний', false, 1),
  ((SELECT id FROM inserted_question), 'Ферментативний', false, 2),
  ((SELECT id FROM inserted_question), 'Гетерогенний', false, 3),
  ((SELECT id FROM inserted_question), 'Специфічний кислотно-основний', false, 4);


-- Question 137
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть реагент, за допомогою якого можна розрізнити фенол і метилфеніловий етер:', NULL, 'medium', 137, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img12.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'FeCl3', true, 0),
  ((SELECT id FROM inserted_question), 'HNO3', false, 1),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', false, 2),
  ((SELECT id FROM inserted_question), 'HCl', false, 3),
  ((SELECT id FROM inserted_question), 'I2', false, 4);


-- Question 138
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть спільний реагент, яким можна виявити NO2- і NO3-:', NULL, 'medium', 138, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антипірин', true, 0),
  ((SELECT id FROM inserted_question), 'Калій хлорид', false, 1),
  ((SELECT id FROM inserted_question), 'Резорцин', false, 2),
  ((SELECT id FROM inserted_question), 'Калій йодид', false, 3),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазон', false, 4);


-- Question 139
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть реагенти, що дозволять підтвердити наявність первинної аміногрупи в молекулі n-амінобензойної кислоти за допомогою ізонітрильної проби:', NULL, 'medium', 139, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaHCO3', false, 0),
  ((SELECT id FROM inserted_question), 'Вr2, Н2О', false, 1),
  ((SELECT id FROM inserted_question), 'КМпО4', false, 2),
  ((SELECT id FROM inserted_question), 'СНСІз, NaOH', true, 3),
  ((SELECT id FROM inserted_question), 'І2, NaOH', false, 4);


-- Question 140
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Провізор-аналітик аптеки проводить ідентифікацію оксациліну натрієвої солі. У якості реактивів він використовує розчин гідроксиламіну солянокислого у присутності розчину натрію гідроксиду і розчин купруму нітрату. Який структурний фрагмент молекули препарату виявляється за допомогою даних реагентів?', NULL, 'medium', 140, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фурановий цикл', false, 0),
  ((SELECT id FROM inserted_question), 'Тіазолідиновий цикл', false, 1),
  ((SELECT id FROM inserted_question), 'Тіадіазольний цикл', false, 2),
  ((SELECT id FROM inserted_question), 'Ізоксазольний цикл', false, 3),
  ((SELECT id FROM inserted_question), 'Бета-лактамний цикл', true, 4);


-- Question 141
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту можна відрізнити мальтозу (відновний дисахарид) від сахарози (невідновний дисахарид)?', NULL, 'medium', 141, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'FeCl3', false, 0),
  ((SELECT id FROM inserted_question), 'NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'K4[Fe(CN6)]', false, 2),
  ((SELECT id FROM inserted_question), 'Br2', false, 3),
  ((SELECT id FROM inserted_question), 'Реактив Толленса', true, 4);


-- Question 142
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чому катіони I аналітичної групи (кислотно-основна класифікація) не мають групового реагенту?', NULL, 'medium', 142, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мають великі іонні радіуси', false, 0),
  ((SELECT id FROM inserted_question), 'Мають близькі іонні радіуси', false, 1),
  ((SELECT id FROM inserted_question), 'Мають здатність утворювати розчинні основи', false, 2),
  ((SELECT id FROM inserted_question), 'Більшість їх солей розчинні у воді', true, 3),
  ((SELECT id FROM inserted_question), 'Належать до біологічно важливих елементів', false, 4);


-- Question 143
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які катіони IV групи знаходяться у розчині, якщо під дією розчину гідроксиду натрію утворюється забарвлений осад, розчинний у надлишку реагенту?', NULL, 'medium', 143, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хром', true, 0),
  ((SELECT id FROM inserted_question), 'Свинець', false, 1),
  ((SELECT id FROM inserted_question), 'Вісмут', false, 2),
  ((SELECT id FROM inserted_question), 'Цинк', false, 3),
  ((SELECT id FROM inserted_question), 'Манган', false, 4);


-- Question 144
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні систематичного ходу аналізу на розчин подіяли груповим реагентом 1M H2SO4 у присутності етилового спирту, утворився білий осад. Катіони якої групи присутні у розчині?', NULL, 'medium', 144, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'III', true, 0),
  ((SELECT id FROM inserted_question), 'І', false, 1),
  ((SELECT id FROM inserted_question), 'II', false, 2),
  ((SELECT id FROM inserted_question), 'IV', false, 3),
  ((SELECT id FROM inserted_question), 'VI', false, 4);


-- Question 145
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Тотожність кальцію лактату (Calcii lactas) - антиалергічного агента та антидота при отруєнні солями магнію, визначають у числі інших реакцій якісною реакцією на катіон Ca2+ з одним з вказаних реагентів по утворенню білого осаду. Назвіть цей реагент:', NULL, 'medium', 145, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію хлорид', false, 0),
  ((SELECT id FROM inserted_question), 'Барію хлорид', false, 1),
  ((SELECT id FROM inserted_question), 'Амонію оксалат', true, 2),
  ((SELECT id FROM inserted_question), 'Амонію карбонат', false, 3),
  ((SELECT id FROM inserted_question), 'Лантану нітрат', false, 4);


-- Question 146
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З яким реагентом п-амінобензойна кислота реагує по аміногрупі?', NULL, 'medium', 146, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCl', true, 0),
  ((SELECT id FROM inserted_question), 'NH4OH', false, 1),
  ((SELECT id FROM inserted_question), 'NaOH', false, 2),
  ((SELECT id FROM inserted_question), 'KCN', false, 3),
  ((SELECT id FROM inserted_question), 'CH3COONa', false, 4);


-- Question 147
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реагентом в систематичному ході аналізу можна розділити хлориди арґентуму та меркурію (І) і водночас виявити катіони меркурію (І)?', NULL, 'medium', 147, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин аміаку', true, 0),
  ((SELECT id FROM inserted_question), 'Гаряча вода', false, 1),
  ((SELECT id FROM inserted_question), 'Надлишок концентрованої хлоридної кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин нітратної кислоти', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин лугу', false, 4);


-- Question 148
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед перерахованих реагентів оберіть нуклеофільний:', NULL, 'medium', 148, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img13.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'k.H2SO4(SO3)', false, 0),
  ((SELECT id FROM inserted_question), 'NH3', true, 1),
  ((SELECT id FROM inserted_question), 'CH3 − Cl', false, 2),
  ((SELECT id FROM inserted_question), 'k.HNO3 + k. H2SO4', false, 3),
  ((SELECT id FROM inserted_question), 'Серед наведених сполук ацилюючим реагентом є:', false, 4);


-- Question 149
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З яким із реагентів за наведених умов відбувається відновлення ненасичених органічних сполук?', NULL, 'medium', 149, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HNO3, p, t', false, 0),
  ((SELECT id FROM inserted_question), 'H2, Ni, t', true, 1),
  ((SELECT id FROM inserted_question), 'H2O, Hg2+, H+', false, 2),
  ((SELECT id FROM inserted_question), 'K2Cr2O7, H+', false, 3),
  ((SELECT id FROM inserted_question), 'NaOH, H2O', false, 4);


-- Question 150
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До п’ятої групи катіонів належать катіони Fe3+, Fe2+, Mg2+, Mn2+, Bi3+, S b(I I I ), S b(V ). Груповим реагентом для п’ятої групи катіонів є розчин:', NULL, 'medium', 150, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NH3', true, 0),
  ((SELECT id FROM inserted_question), 'H2SO4', false, 1),
  ((SELECT id FROM inserted_question), 'H2S', false, 2),
  ((SELECT id FROM inserted_question), 'HNO3', false, 3),
  ((SELECT id FROM inserted_question), 'HCl', false, 4);


-- Question 151
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який реагент використовують для відокремлення осаду AgCl від AgI?', NULL, 'medium', 151, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Водний розчин амоніаку', true, 0),
  ((SELECT id FROM inserted_question), 'Концентрована нітратна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Розведена нітратна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Концентрований розчин калію хлориду', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин сульфатної кислоти', false, 4);


-- Question 152
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту можна здійснити наступне перетворення:', NULL, 'medium', 152, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img14.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaNO2(HCl)', true, 0),
  ((SELECT id FROM inserted_question), 'K2Cr2O7', false, 1),
  ((SELECT id FROM inserted_question), 'NaNO (H 2SO4 )', false, 2),
  ((SELECT id FROM inserted_question), 'KOH', false, 3),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', false, 4);


-- Question 153
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З яким із реагентів за наведених умов відбувається відновлення ненасичених органічних сполук?', NULL, 'medium', 153, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2, Ni, t', false, 0),
  ((SELECT id FROM inserted_question), 'H2O, Hg2+, H', false, 1),
  ((SELECT id FROM inserted_question), 'HNO3, t, p', false, 2),
  ((SELECT id FROM inserted_question), 'NaOH H2О', false, 3),
  ((SELECT id FROM inserted_question), 'K2Cr2O7, H', true, 4);


-- Question 154
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В розчині присутні йодид- і хлорид-іони. Виберіть реагент для виявлення йодид-іонів:', NULL, 'medium', 154, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вапняна вода', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпсова вода', false, 1),
  ((SELECT id FROM inserted_question), 'Баритова вода', false, 2),
  ((SELECT id FROM inserted_question), 'Сірководнева вода', false, 3),
  ((SELECT id FROM inserted_question), 'Хлорна вода', true, 4);


-- Question 155
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У розчині присутні катіони цинку і алюмінію. Вкажіть реагент, який дозволяє виявити в цьому розчині катіони цинку:', NULL, 'medium', 155, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин калію гексаціаноферату (II)', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин натрію гідроксиду', false, 1),
  ((SELECT id FROM inserted_question), 'Кобальту нітрат Co(NO3)2', false, 2),
  ((SELECT id FROM inserted_question), 'Надлишок 6М гідроксиду натрію в присутності пероксиду водню', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин сульфатної кислоти', false, 4);


-- Question 156
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Груповим реагентом на першу аналітичну групу аніонів є нітрат барію. Укажіть аніони першої групи:', NULL, 'medium', 156, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'PO3−, CO2−, SO2−', true, 0),
  ((SELECT id FROM inserted_question), 'BrO3−, Br−, ClO4−', false, 1),
  ((SELECT id FROM inserted_question), 'CH3COO−, S2−, I−', false, 2),
  ((SELECT id FROM inserted_question), 'NO3−, NO2−, HCOO−', false, 3),
  ((SELECT id FROM inserted_question), 'Cl−, Br−, OH', false, 4);


-- Question 157
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким реагентом можна відокремити магній-катіони від інших катіонів V аналітичної групи в систематичному ході аналізу?', NULL, 'medium', 157, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Насичений розчин амонію хлориду', true, 0),
  ((SELECT id FROM inserted_question), 'Надлишок концентрованого розчину амоніаку', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроген пероксид', false, 2),
  ((SELECT id FROM inserted_question), 'Нітратна кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин лугу', false, 4);


-- Question 158
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З яким реагентом п-амінобензойна кислота реагує по аміногрупі?', NULL, 'medium', 158, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img15.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCl', true, 0),
  ((SELECT id FROM inserted_question), 'NH4OH', false, 1),
  ((SELECT id FROM inserted_question), 'NaOH', false, 2),
  ((SELECT id FROM inserted_question), 'CH3COONa', false, 3),
  ((SELECT id FROM inserted_question), 'KCN', false, 4);


-- Question 159
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для розпізнавання фенолу і саліцилової кислоти використовують реагент:', NULL, 'medium', 159, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img16.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин натрій гідрогенкарбонату', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин ферум (III) хлориду', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин натрій гідроксиду', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин натрій хлориду', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин брому', false, 4);


-- Question 160
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту можна відрізнити етанол від гліцерину?', NULL, 'medium', 160, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img17.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Cu(OH)2', true, 0),
  ((SELECT id FROM inserted_question), 'HBr', false, 1),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 2),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 3),
  ((SELECT id FROM inserted_question), 'Ag2O', false, 4);


-- Question 161
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить катіони шостої аналітичної групи (кислотно-основна класифікація), додали розчин калію йодиду. Випав червоний осад, розчинний в надлишку реагенту. Які катіони присутні в розчині?', NULL, 'medium', 161, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ртуті (II)', true, 0),
  ((SELECT id FROM inserted_question), 'Нікелю', false, 1),
  ((SELECT id FROM inserted_question), 'Кобальту (II)', false, 2),
  ((SELECT id FROM inserted_question), 'Вісмуту', false, 3),
  ((SELECT id FROM inserted_question), 'Кадмію', false, 4);


-- Question 162
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У розчині, що містить катіони міді (II) і цинку, катіони міді можна визначити за допомогою надлишку такого реагенту:', NULL, 'medium', 162, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '6М розчин амоніаку', true, 0),
  ((SELECT id FROM inserted_question), '2М розчин сульфатної кислоти', false, 1),
  ((SELECT id FROM inserted_question), '6М розчин калію гідроксиду', false, 2),
  ((SELECT id FROM inserted_question), '2М розчин хлороводневої кислоти', false, 3),
  ((SELECT id FROM inserted_question), '2М розчин амонію карбонату', false, 4);


-- Question 163
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До п’ятої групи катіонів належать катіони Fe3+, Fe2+, Mg2+, Mn2+, Bi3+, Sb(III), Sb(V). Вкажіть груповий реагент для цієї групи катіонів:', NULL, 'medium', 163, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин амоніаку', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин H2SO4', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин H2S', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин HNO3', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин HCl', false, 4);


-- Question 164
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту можна розрізнити крохмаль та глюкозу?', NULL, 'medium', 164, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'I2', true, 0),
  ((SELECT id FROM inserted_question), 'Br2', false, 1),
  ((SELECT id FROM inserted_question), 'KMnO4', false, 2),
  ((SELECT id FROM inserted_question), 'K2Cr2O7', false, 3),
  ((SELECT id FROM inserted_question), 'FeCl3', false, 4);


-- Question 165
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик для ідентифікації катіонів цинку (II) використав розчин реагенту гексаціаноферату (II) калію (реакція фармакопейна). Якого кольору осад при цьому утворюється?', NULL, 'medium', 165, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Білий', true, 0),
  ((SELECT id FROM inserted_question), 'Жовтий', false, 1),
  ((SELECT id FROM inserted_question), 'Чорний', false, 2),
  ((SELECT id FROM inserted_question), 'Зелений', false, 3),
  ((SELECT id FROM inserted_question), 'Червоний', false, 4);


-- Question 166
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До другої групи катіонів належать катіони Pb2+, Ag+, Hg2+. Який розчин 2 буде груповим реагентом на другу групу катіонів:', NULL, 'medium', 166, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCl', true, 0),
  ((SELECT id FROM inserted_question), 'H2SO4', false, 1),
  ((SELECT id FROM inserted_question), 'HNO3', false, 2),
  ((SELECT id FROM inserted_question), 'NaOH', false, 3),
  ((SELECT id FROM inserted_question), 'NH3', false, 4);


-- Question 167
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аналізі фармпрепарату виявили аніони третьої аналітичної групи. Вкажіть реагенти для проведення реакції "бурого кільця":', NULL, 'medium', 167, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (кристалічний) та сульфатна кислота (конц.)', true, 0),
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (розчин) та сульфатна кислота (розведена)', false, 1),
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (розчин) та сульфатна кислота (конц.)', false, 2),
  ((SELECT id FROM inserted_question), 'Ферум (III) сульфат (розчин) та сульфатна кислота (розведена)', false, 3),
  ((SELECT id FROM inserted_question), 'Ферум (III) сульфат (розчин) та сульфатна кислота (конц.)', false, 4);


-- Question 168
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який із наведених реагентів використовують у синтезі фурациліну?', NULL, 'medium', 168, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img18.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2N−NH−C(O)−NH2', true, 0),
  ((SELECT id FROM inserted_question), 'H2N−OH', false, 1),
  ((SELECT id FROM inserted_question), 'H2N−C6H5', false, 2),
  ((SELECT id FROM inserted_question), 'H2N − NH − C(S) − NH2', false, 3),
  ((SELECT id FROM inserted_question), 'H2N − NH2', false, 4);


-- Question 169
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть реагент, що дозволяє при лужному гідролізі жирів (омиленні) отримати "рідке мило":', NULL, 'medium', 169, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'K2CO3', true, 0),
  ((SELECT id FROM inserted_question), 'NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'CaО', false, 2),
  ((SELECT id FROM inserted_question), 'PbO', false, 3),
  ((SELECT id FROM inserted_question), 'NaHCO3', false, 4);


-- Question 170
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою якого реагенту мо- жна відрізнити пропін (CH3 − C ≡ CH) від пропена (CH3 − CH = CH2)?', NULL, 'medium', 170, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '[Ag(NH3)2]OH', true, 0),
  ((SELECT id FROM inserted_question), 'Br2', false, 1),
  ((SELECT id FROM inserted_question), 'HCl', false, 2),
  ((SELECT id FROM inserted_question), 'Cu(OH)2', false, 3),
  ((SELECT id FROM inserted_question), 'Cl2', false, 4);


-- Question 171
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аналізі суміші катіонів IV аналітичної групи катіони Zn при певних умовах можна визначити дрібним методом з таким реагентом:', NULL, 'medium', 171, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дитизон', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин амоніаку', false, 1),
  ((SELECT id FROM inserted_question), 'Луги', false, 2),
  ((SELECT id FROM inserted_question), 'Карбонати лужних металів', false, 3),
  ((SELECT id FROM inserted_question), 'Диметилгліоксим', false, 4);


-- Question 172
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання ціангідрину ацетону:', NULL, 'medium', 172, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img19.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'HCN', true, 0),
  ((SELECT id FROM inserted_question), 'H2N-ОН', false, 1),
  ((SELECT id FROM inserted_question), 'H2N-NH2', false, 2),
  ((SELECT id FROM inserted_question), 'H2N−NH−C6H5', false, 3),
  ((SELECT id FROM inserted_question), 'H2N − CH3', false, 4);


-- Question 173
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аміди є слабкими NH-кислотами. Під час взаємодії з яким з наведених реагентів вони утворюють солі?', NULL, 'medium', 173, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaNH2 (Na мет.)', true, 0),
  ((SELECT id FROM inserted_question), 'NaOH (H2O)', false, 1),
  ((SELECT id FROM inserted_question), 'P2O5 (to)', false, 2),
  ((SELECT id FROM inserted_question), 'NaOBr (Br2 + NaOH)', false, 3),
  ((SELECT id FROM inserted_question), 'LiAlH4', false, 4);


-- Question 174
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджуваний розчин лікарського препарату містить катіони магнію (II) і алюмінію (III). За допомогою розчину якого реагенту можна розділити вказані катіони при аналізі цього препарату?', NULL, 'medium', 174, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин лугу', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин пероксиду водню в кислому середовищі', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин нітрату срібла', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин амоніаку', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин хлоридної кислоти', false, 4);


-- Question 175
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент, який можна використати для отримання пропанола-2 з ацетону:', NULL, 'medium', 175, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img20.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2(Ni)', false, 0),
  ((SELECT id FROM inserted_question), 'CH3OH', false, 1),
  ((SELECT id FROM inserted_question), 'CH3I', false, 2),
  ((SELECT id FROM inserted_question), 'HCN', false, 3),
  ((SELECT id FROM inserted_question), 'HCOH', false, 4);


-- Question 176
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дією якого реагенту з бензолу можна одержати дифенілметан?', NULL, 'medium', 176, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img21.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CH2Cl2', true, 0),
  ((SELECT id FROM inserted_question), 'C2H5Cl', false, 1),
  ((SELECT id FROM inserted_question), 'CH2O', false, 2),
  ((SELECT id FROM inserted_question), 'CH3COOH', false, 3),
  ((SELECT id FROM inserted_question), 'NaNH2', false, 4);


-- Question 177
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі при певних умовах специфічним реагентом на катіони Fe3+ є K4[Fe(CN)6]. Якого кольору утворюється осад при їх взаємодії?', NULL, 'medium', 177, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Синій', true, 0),
  ((SELECT id FROM inserted_question), 'Білий', false, 1),
  ((SELECT id FROM inserted_question), 'Бурий', false, 2),
  ((SELECT id FROM inserted_question), 'Червоний', false, 3),
  ((SELECT id FROM inserted_question), 'Чорний', false, 4);


-- Question 178
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагенти для виявлення сульфат-іонів у розчині, що містить карбонат, сульфат-, тіосульфат-, фосфат-аніони:', NULL, 'medium', 178, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ba(NO3)2, HCl', true, 0),
  ((SELECT id FROM inserted_question), 'Ba(NO3)2, NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'BaCl2, H2O', false, 2),
  ((SELECT id FROM inserted_question), 'CaCl2, NH4OH', false, 3),
  ((SELECT id FROM inserted_question), 'AgNO3, HNO3', false, 4);


-- Question 179
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагент для отримання гідразиду оцтової кислоти з етилацетату:', NULL, 'medium', 179, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img22.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'H2N − NH2', true, 0),
  ((SELECT id FROM inserted_question), 'NН3', false, 1),
  ((SELECT id FROM inserted_question), 'H2N − CH3', false, 2),
  ((SELECT id FROM inserted_question), 'C6H5NH2', false, 3),
  ((SELECT id FROM inserted_question), 'C6H5NHNH2', false, 4);


-- Question 180
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Запропонуйте реагенти для виявлення нітрит-іонів в присутності нітрат- іонів, що містяться в досліджуваному фармпрепараті:', NULL, 'medium', 180, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антипірин та хлоридна кислота (розв.)', true, 0),
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (розв.) та калій йодид', false, 1),
  ((SELECT id FROM inserted_question), 'Ферум (III) сульфат (конц.) та калій бромід', false, 2),
  ((SELECT id FROM inserted_question), 'Ферум (II) хлорид E. Ферум (III) хлорид', false, 3),
  ((SELECT id FROM inserted_question), 'Який фізико-хімічний метод аналізу використовується для кількісного визначення калію дихромату?', false, 4);


-- Question 181
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть фізико-хімічний метод аналізу, заснований на вимірюванні того, як змінюється внаслідок хімічної реакції електропровідність досліджуваних розчинів:', NULL, 'medium', 181, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Потенціометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Кулонометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Амперометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Кондуктометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Полярографія', false, 4);


-- Question 182
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для аналізу надійшов розчин калію дихромату. Для його кількісного визначення був використаний один із фізико-хімічних методів аналізу, а саме:', NULL, 'medium', 182, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Флуориметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Поляриметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Кулонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Турбідиметрія', false, 4);


-- Question 183
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На аналіз надійшов розчин калію дихромату. Для його кількісного визначення був використаний один з фізико-хімічних методів аналізу:', NULL, 'medium', 183, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометричний', true, 0),
  ((SELECT id FROM inserted_question), 'Поляриметричний', false, 1),
  ((SELECT id FROM inserted_question), 'Турбідиметричний', false, 2),
  ((SELECT id FROM inserted_question), 'Кулонометричний', false, 3),
  ((SELECT id FROM inserted_question), 'Флуориметричний', false, 4);


-- Question 184
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Фізико-хімічні методи використовують для кількісного визначення лікарських речовин. Якій з наведених нижче методів ґрунтується на визначенні оптичної густини розчину?', NULL, 'medium', 184, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спектрофотометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Полярографія', false, 1),
  ((SELECT id FROM inserted_question), 'Потенціометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Кулонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Електрогравіметрія', false, 4);


-- Question 185
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Одним з важливих етапів у вивченні фізико-хімічних властивостей води є аналіз її діаграми стану. Які фази знаходяться у рівновазі у потрійній точці на діаграмі стану води?', NULL, 'medium', 185, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рідка вода, лід, пара води', true, 0),
  ((SELECT id FROM inserted_question), 'Рідка вода, лід', false, 1),
  ((SELECT id FROM inserted_question), 'Рідка вода, пара води', false, 2),
  ((SELECT id FROM inserted_question), 'Лід, пара води', false, 3),
  ((SELECT id FROM inserted_question), 'Лід', false, 4);


-- Question 186
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У фізико-хімічній лабораторії були приготовані водні розчини сечовини, глюкози, сульфату натрію, сульфату алюмінію і бензоату натрію однакової молярної концентрації. Який з перелічених розчинів має найбільший осмотичний тиск при 298oK?', NULL, 'medium', 186, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сульфат алюмінію', true, 0),
  ((SELECT id FROM inserted_question), 'Сечовини', false, 1),
  ((SELECT id FROM inserted_question), 'Глюкози', false, 2),
  ((SELECT id FROM inserted_question), 'Бензоат натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Сульфат натрію', false, 4);


-- Question 187
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Сухий залишок, отриманий після упарювання розчину, що аналізується, забарвлює безколірне полум’я горілки у жовтий колір, а при розгляданні через синє скло - у фіолетовий. Які катіони знаходяться у сухому залишку?', NULL, 'medium', 187, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Na+, K', false, 0),
  ((SELECT id FROM inserted_question), 'Ca2+, K', false, 1),
  ((SELECT id FROM inserted_question), 'Na+, Sr2', false, 2),
  ((SELECT id FROM inserted_question), 'Li+, Ba2', false, 3),
  ((SELECT id FROM inserted_question), 'Na+, Ca2', true, 4);


-- Question 188
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Леткі сполуки кальцію забарвлюють безбарвне полум’я пальника в такий колір:', NULL, 'medium', 188, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зелений', false, 0),
  ((SELECT id FROM inserted_question), 'Жовтий', false, 1),
  ((SELECT id FROM inserted_question), 'Фіолетовий', false, 2),
  ((SELECT id FROM inserted_question), 'Червоний', true, 3),
  ((SELECT id FROM inserted_question), 'Жовто-зелений', false, 4);


-- Question 189
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час хімічного аналізу речовину прожарили над полум’ям пальника. Солі якого катіону забарвлюють полум’я у фіолетовий колір?', NULL, 'medium', 189, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', true, 0),
  ((SELECT id FROM inserted_question), 'Стронцію', false, 1),
  ((SELECT id FROM inserted_question), 'Барію', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 3),
  ((SELECT id FROM inserted_question), 'Натрію', false, 4);


-- Question 190
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унесені в полум’я пальника солі невідомого катіона забарвлюють його в цегляно-червоний колір. Який це катіон?', NULL, 'medium', 190, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амонію', false, 0),
  ((SELECT id FROM inserted_question), 'Свинцю', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію', true, 2),
  ((SELECT id FROM inserted_question), 'Мангану', false, 3),
  ((SELECT id FROM inserted_question), 'Магнію', false, 4);


-- Question 191
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Солі якого катіону забарвлюють полум’я у фіолетовий колір?', NULL, 'medium', 191, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кальцію', false, 0),
  ((SELECT id FROM inserted_question), 'Стронцію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Барію', false, 3),
  ((SELECT id FROM inserted_question), 'Калію', true, 4);


-- Question 192
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які реакції використовують у методах перманганатометрії, дихроматометрії, йодометрії?', NULL, 'medium', 192, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окисно-відновлювальні', true, 0),
  ((SELECT id FROM inserted_question), 'Осадження', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексоноутворення', false, 2),
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 3),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 4);


-- Question 193
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть тип хімічної реакції при титруванні тіосульфату натрію розчином йоду:', NULL, 'medium', 193, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', true, 0),
  ((SELECT id FROM inserted_question), 'Кислотно-основний', false, 1),
  ((SELECT id FROM inserted_question), 'Осадження', false, 2),
  ((SELECT id FROM inserted_question), 'Нуклеофільного заміщення', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 194
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка реакція лежить в основі титриметричного методу Фаянса-Ходакова?', NULL, 'medium', 194, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 1),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 2),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 3),
  ((SELECT id FROM inserted_question), 'Осадження', true, 4);


-- Question 195
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка реакція лежить в основі визначення кількості натрію бікарбонату за допомогою хлоридної кислоти?', NULL, 'medium', 195, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 0),
  ((SELECT id FROM inserted_question), 'Нейтралізації', true, 1),
  ((SELECT id FROM inserted_question), 'Осадження', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 3),
  ((SELECT id FROM inserted_question), 'Окиснення- відновлення', false, 4);


-- Question 196
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть тип хімічної реакції, яка лежить в основі визначення кальцію хлориду в препараті трилонометричним методом.', NULL, 'medium', 196, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 0),
  ((SELECT id FROM inserted_question), 'Осадження', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', true, 2),
  ((SELECT id FROM inserted_question), 'Ацилювання', false, 3),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 4);


-- Question 197
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В основі однієї з класифікацій титриметричних методів аналізу лежить хімізм реакції між досліджуваною речовиною та титрантом. Яка реакція лежить в основі визначення кількості натрію карбонату за допомогою хлористоводневої кислоти?', NULL, 'medium', 197, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Осадження', false, 0),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтралізації', true, 2),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 198
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть тип реакції, яка відбувається під час визначення аскорбінової кислоти у препараті йодометричним методом:', NULL, 'medium', 198, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', true, 0),
  ((SELECT id FROM inserted_question), 'Ацилювання', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 2),
  ((SELECT id FROM inserted_question), 'Осадження', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 199
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть тип реакції, яка застосовується для виявлення катіона Fe3+ :', NULL, 'medium', 199, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексоутворення', true, 0),
  ((SELECT id FROM inserted_question), 'Осадження', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроліз', false, 2),
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 3),
  ((SELECT id FROM inserted_question), 'Відновлення', false, 4);


-- Question 200
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які реакції використовують у методах перманганатометрії, дихроматометрії, йодометрії?', NULL, 'medium', 200, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окисно-відновлювальні', true, 0),
  ((SELECT id FROM inserted_question), 'Осадження', false, 1),
  ((SELECT id FROM inserted_question), 'Комплексоноутворення', false, 2),
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 3),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 4);


-- Question 201
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Кількісне визначення йоду здійснюють методом:', NULL, 'medium', 201, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Осаджувального титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Окисно-відновного титрування', true, 1),
  ((SELECT id FROM inserted_question), 'Комплексонометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Ацидиметрії', false, 3),
  ((SELECT id FROM inserted_question), 'Алкаліметрії', false, 4);


-- Question 202
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку пару електродів використовують для потенціометричного окисно-відновного титрування ?', NULL, 'medium', 202, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Платиновий електрод і хлорсрібний електрод', true, 0),
  ((SELECT id FROM inserted_question), 'Срібний електрод і платиновий електрод', false, 1),
  ((SELECT id FROM inserted_question), 'Скляний електрод і хлорсрібний електрод', false, 2),
  ((SELECT id FROM inserted_question), 'Сульфідосрібний електрод і хлорсрібний електрод', false, 3),
  ((SELECT id FROM inserted_question), 'Мідний електрод і цинковий електрод', false, 4);


-- Question 203
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якому методі окисно-відновного титрування для фіксації кінцевої точки титрування застосовують специфічні рН-індикатори?', NULL, 'medium', 203, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Броматометрія', true, 2),
  ((SELECT id FROM inserted_question), 'Цериметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 4);


-- Question 204
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку речовину можна визначити методом кислотно-основного титрування та методом окисно-відновного титрування?', NULL, 'medium', 204, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оксалатна кислота', true, 0),
  ((SELECT id FROM inserted_question), 'Натрію сульфат', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію нітрат', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію гідроксид', false, 3),
  ((SELECT id FROM inserted_question), 'Амонію хлорид', false, 4);


-- Question 205
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Перманґанатометрія використовується для визначення більшої кількості сполук неорганічної та органічної природи. Вкажіть основні переваги перед іншими оксидиметричними методами:', NULL, 'medium', 205, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Можливість використання різних типів індикаторів та необхідність в декількох випадках використання каталізаторів для прискорення реакції визначення сполук', false, 0),
  ((SELECT id FROM inserted_question), 'Легка можливість отримання перманґанту калію в чистому вигляді та доступність', false, 1),
  ((SELECT id FROM inserted_question), 'Висока селективність та чутливість визначення сполук', false, 2),
  ((SELECT id FROM inserted_question), 'Достатньо високий окисно-відновний потенціал та можливість безіндикаторної фіксації точки кінця титрування', true, 3),
  ((SELECT id FROM inserted_question), 'Достатньо висока стійкість перманґанату калію та його розчинів', false, 4);


-- Question 206
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Реакція перетворення толуолу в бензойну кислоту відбувається за умов:', NULL, 'medium', 206, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img23.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окислення калій перманганатом', true, 0),
  ((SELECT id FROM inserted_question), 'Нагрівання з сульфатною кислотою', false, 1),
  ((SELECT id FROM inserted_question), 'Дії гідроген пероксиду при кімнатній температурі', false, 2),
  ((SELECT id FROM inserted_question), 'Дії натрій гідроксиду при кімнатній температурі', false, 3),
  ((SELECT id FROM inserted_question), 'Кип’ятінні на повітрі', false, 4);


-- Question 207
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які сполуки утворюються під час окислення первинних спиртів за наступною схемою:', NULL, 'medium', 207, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img24.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', true, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 208
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Якісною реакцією на алкени є реакція окислення розчином KMnO4. Укажіть, що можна спостерігати, якщо крізь розчин KMnO4 пропускають етен:', NULL, 'medium', 208, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Знебарвлення розчину', true, 0),
  ((SELECT id FROM inserted_question), 'Виділення бурого газу', false, 1),
  ((SELECT id FROM inserted_question), 'Візуально нічого не спостерігається', false, 2),
  ((SELECT id FROM inserted_question), 'Розігрівання речовини', false, 3),
  ((SELECT id FROM inserted_question), 'Випадання жовтого осаду', false, 4);


-- Question 209
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з перелічених сполук при окисленні утворює фталеву кислоту?', NULL, 'medium', 209, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img25.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', true, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 210
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утвориться при окисленні 3-метилпіридину?', NULL, 'medium', 210, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нікотинова кислота', true, 0),
  ((SELECT id FROM inserted_question), '2-Гідроксипіридин', false, 1),
  ((SELECT id FROM inserted_question), '3-Гідроксипіридин', false, 2),
  ((SELECT id FROM inserted_question), 'Піколінова кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Ізонікотинова кислота', false, 4);


-- Question 211
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка кислота утворюється при окисленні орто-диметилбензолу (ксилолу) киснем повітря на каталізаторі:', NULL, 'medium', 211, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img26.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фенілоцтова кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Саліцилова кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Бензойна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Орто-Толуїлова кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Фталева кислота', true, 4);


-- Question 212
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка реакція є спільною з реакцією виявлення сполук арсену (III) і арсену (V)?', NULL, 'medium', 212, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З натрій нітратом', false, 0),
  ((SELECT id FROM inserted_question), 'З амоній молібдатом', false, 1),
  ((SELECT id FROM inserted_question), 'Відновлення до арсину', true, 2),
  ((SELECT id FROM inserted_question), '3 калій йодидом', false, 3),
  ((SELECT id FROM inserted_question), 'З йодом', false, 4);


-- Question 213
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть тип реакції, яка відбувається під час визначення аскорбінової кислоти у препараті йодометричним методом:', NULL, 'medium', 213, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', true, 0),
  ((SELECT id FROM inserted_question), 'Ацилювання', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 2),
  ((SELECT id FROM inserted_question), 'Осадження', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 214
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час повного відновлення піролу отримують:', NULL, 'medium', 214, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піролін', false, 0),
  ((SELECT id FROM inserted_question), 'Серотонін', false, 1),
  ((SELECT id FROM inserted_question), 'Піролідин', true, 2),
  ((SELECT id FROM inserted_question), 'Піразол', false, 3),
  ((SELECT id FROM inserted_question), 'Імідазол', false, 4);


-- Question 215
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дихромат калію K2Cr2O7 використовують у якості окислювача у кислому середовищі. Вкажіть продукт відновлення дихромат-іону Cr2O2− у цих умовах:', NULL, 'medium', 215, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Cr3', true, 0),
  ((SELECT id FROM inserted_question), 'Cr(OH)3', false, 1),
  ((SELECT id FROM inserted_question), 'Cr(OH)2', false, 2),
  ((SELECT id FROM inserted_question), '[Cr(OH)6]3−', false, 3),
  ((SELECT id FROM inserted_question), 'Cr2O3', false, 4);


-- Question 216
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утворюється при відновленні метилетилкетону?', NULL, 'medium', 216, true, '/test-images/pharmaceutical-analysis/fazova-rivnovaga/img27.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Цинк металевий', true, 0),
  ((SELECT id FROM inserted_question), 'Тетраборат натрію', false, 1),
  ((SELECT id FROM inserted_question), 'Гідроксид натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Оксалатна кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Дихромат калію', false, 4);


-- Question 217
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як називаються реакції та реагенти, що дають можливість за певних умов визначити певні іони в присутності інших іонів?', NULL, 'medium', 217, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вибіркові', false, 0),
  ((SELECT id FROM inserted_question), 'Характерні', false, 1),
  ((SELECT id FROM inserted_question), 'Групові', false, 2),
  ((SELECT id FROM inserted_question), 'Специфічні', true, 3),
  ((SELECT id FROM inserted_question), 'Загальні', false, 4);


-- Question 218
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як називається процес вилучення однієї або декількох речовин зі складних систем селективним розчинником?', NULL, 'medium', 218, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Диспергування', false, 0),
  ((SELECT id FROM inserted_question), 'Конденсація', false, 1),
  ((SELECT id FROM inserted_question), 'Екстракція', true, 2),
  ((SELECT id FROM inserted_question), 'Кристалізація', false, 3),
  ((SELECT id FROM inserted_question), 'Випарювання', false, 4);


-- Question 219
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Найкращим прикладом ідеального розчину, що підпорядковується закону Рауля, є розчин:', NULL, 'medium', 219, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Будь-який гранично розведений', true, 0),
  ((SELECT id FROM inserted_question), 'Ацетону у хлороформі', false, 1),
  ((SELECT id FROM inserted_question), 'Бензену у воді', false, 2),
  ((SELECT id FROM inserted_question), 'Бензену в етанолі', false, 3),
  ((SELECT id FROM inserted_question), 'Хлороформу у циклогексані', false, 4);


-- Question 220
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Присутність якого з іонів d-елементів у розчинах можна встановити за допомогою K4[Fe(CN)6]?', NULL, 'medium', 220, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Fe3', false, 0),
  ((SELECT id FROM inserted_question), 'Fe2', false, 1),
  ((SELECT id FROM inserted_question), 'Zn2', false, 2),
  ((SELECT id FROM inserted_question), 'Cr3', false, 3),
  ((SELECT id FROM inserted_question), 'Cu2', true, 4);


-- Question 221
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджувана суміш містить іони Cl-,Br- та І- в еквімолярних калькотях.Послідовність утворення осадів при аргентометричному титруванні буде визначатися:', NULL, 'medium', 221, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Добутком розчинності відповідних галогенідів срібла', true, 0),
  ((SELECT id FROM inserted_question), 'Величиною редокс-потенціалів', false, 1),
  ((SELECT id FROM inserted_question), 'Вибором способу титрування - прямим чи зворотнім', false, 2),
  ((SELECT id FROM inserted_question), 'Величиною рухливості відповідних аніонів', false, 3),
  ((SELECT id FROM inserted_question), 'Іонною силою розчину', false, 4);


-- Question 222
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У якому середовищі проводять кількісне визначення галогенід-іонів методом Фольгарда (тіоціанометрія)?', NULL, 'medium', 222, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтральному', false, 0),
  ((SELECT id FROM inserted_question), 'Сильнолужному', false, 1),
  ((SELECT id FROM inserted_question), 'Слаболужному', false, 2),
  ((SELECT id FROM inserted_question), 'Нітратнокислому', true, 3),
  ((SELECT id FROM inserted_question), 'Фосфатнокислому', false, 4);


-- Question 223
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У якому середовищі треба проводити визначення галогенід-іонів аргентометричного згідно з методом Фольгарда?', NULL, 'medium', 223, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтральному', false, 0),
  ((SELECT id FROM inserted_question), 'Сильнолужному', false, 1),
  ((SELECT id FROM inserted_question), 'Оцтовокислому', false, 2),
  ((SELECT id FROM inserted_question), 'Слаболужному', false, 3),
  ((SELECT id FROM inserted_question), 'Азотнокислому', true, 4);


-- Question 224
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який метод кількісного аналізу заснований на утворенні комплексних сполук галогенід-іонів із солями Нg2+?', NULL, 'medium', 224, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Меркуриметрія', true, 1),
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 4);


-- Question 225
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які аніони заважають визначенню галогенідіонів методом Фольгарда через утворення міцного безбарвного комплексу з іонами феруму (ІІІ)?', NULL, 'medium', 225, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NO2-', false, 0),
  ((SELECT id FROM inserted_question), 'NO3-', false, 1),
  ((SELECT id FROM inserted_question), 'SO32-', false, 2),
  ((SELECT id FROM inserted_question), 'F-', true, 3),
  ((SELECT id FROM inserted_question), 'MnO4-', false, 4);


-- Question 226
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть метод, який базується на реакціях осадження галогенідів у вигляді малорозчинних солей ртуті (І):', NULL, 'medium', 226, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Меркурометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Трилонометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Роданометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Вкажіть метод кількісного аналізу, заснований на утворенні комплексних сполук галогенід-іонів з солями Hg2+:', false, 4);


-- Question 227
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які катіони є в розчині, якщо після додавання до нього диметилгліоксиму (реактив Чугаєва) та аміачного буферного розчину утворюється внутрішньокомплексна сполука червоно-малинового кольору?', NULL, 'medium', 227, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кальцію', false, 0),
  ((SELECT id FROM inserted_question), 'Алюмінію', false, 1),
  ((SELECT id FROM inserted_question), 'Купруму', false, 2),
  ((SELECT id FROM inserted_question), 'Нікелю', true, 3),
  ((SELECT id FROM inserted_question), 'Кобальту', false, 4);


-- Question 228
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного лужного розчину катіонів ІV аналітичної групи додали розчин дитизону. Утворилася сполука, яка забарвлює не тільки органічну, але і водну фазу в червоний колір. На присутність якого катіону вказує цей аналітичний ефект?', NULL, 'medium', 228, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Cr3', false, 0),
  ((SELECT id FROM inserted_question), 'Zn2+', true, 1),
  ((SELECT id FROM inserted_question), 'Al3', false, 2),
  ((SELECT id FROM inserted_question), 'Bi3', false, 3),
  ((SELECT id FROM inserted_question), 'Fe3', false, 4);


-- Question 229
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що досліджується, додали хлоридну кислоту (HCl). Осад, що випав, відфільтрували та обробили на фільтрі гарячою водою, а після охолодження до фільтру додали розчин КІ. Який катіон присутній у розчині, якщо отриманий осад мав жовтий колір?', NULL, 'medium', 229, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Са', false, 0),
  ((SELECT id FROM inserted_question), 'Ag', false, 1),
  ((SELECT id FROM inserted_question), 'Ba', false, 2),
  ((SELECT id FROM inserted_question), 'Hg', false, 3),
  ((SELECT id FROM inserted_question), 'Pb', true, 4);


-- Question 230
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного розчину додали 2М розчин HCl. При цьому утворився білий осад, що при нагріванні розчинився. Який катіон присутній у розчині?', NULL, 'medium', 230, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Mg2', false, 0),
  ((SELECT id FROM inserted_question), 'Ag', false, 1),
  ((SELECT id FROM inserted_question), 'Pb2+', true, 2),
  ((SELECT id FROM inserted_question), 'Hg2', false, 3),
  ((SELECT id FROM inserted_question), 'Ba2', false, 4);


-- Question 231
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного розчину додали розчин калію хромату. Випав осад жовтого кольору, який розчиняється в оцтовій кислоті. Про присутність яких катіонів свідчить ця якісна реакція?', NULL, 'medium', 231, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стронцію', true, 0),
  ((SELECT id FROM inserted_question), 'Магнію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Амонію', false, 3),
  ((SELECT id FROM inserted_question), 'Калію', false, 4);


-- Question 232
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який із нижченаведених катіонів має найбільшу рухливість?', NULL, 'medium', 232, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амонію', false, 0),
  ((SELECT id FROM inserted_question), 'Калію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Літію', false, 3),
  ((SELECT id FROM inserted_question), 'Гідроксонію', true, 4);


-- Question 233
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За допомогою кристалічного діоксиду плюмбуму (IV) в присутності концентрованої нітратної кислоти визначають наявність в розчині катіонів мангану (II). Який візуальний аналітичний ефект спостерігається у цьому разі?', NULL, 'medium', 233, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин забарвлюється в рожевий колір', true, 0),
  ((SELECT id FROM inserted_question), 'Утворюється синій осад', false, 1),
  ((SELECT id FROM inserted_question), 'Розчин забарвлюється в жовтий колір', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин забарвлюється у зелений колір', false, 3),
  ((SELECT id FROM inserted_question), 'Утворюється білий осад', false, 4);


-- Question 234
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В розчині, що аналізують, містяться катіони стронцію та кальцію. Для ідентифікації у цьому розчині іонів стронцію необхідно:', NULL, 'medium', 234, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Додати розчин калію дихромату', false, 0),
  ((SELECT id FROM inserted_question), 'Додати насичений розчин амонію сульфату', false, 1),
  ((SELECT id FROM inserted_question), 'Додати гіпсову воду', true, 2),
  ((SELECT id FROM inserted_question), 'Додати розчин амонію оксалату', false, 3),
  ((SELECT id FROM inserted_question), 'Додати розчин натрію карбонату', false, 4);


-- Question 235
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У лабораторії для ідентифікації йодид-іонів у розчині провели реакцію з катіонами плюмбуму. Утворений осад розчинили під час нагрівання у воді, потім пробірку охолодили. Який аналітичний ефект спостерігався під час реакції?', NULL, 'medium', 235, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Утворення синього осаду', false, 0),
  ((SELECT id FROM inserted_question), 'b. Утворення білого осаду', false, 1),
  ((SELECT id FROM inserted_question), 'c. Утворення бурого осаду', false, 2),
  ((SELECT id FROM inserted_question), 'd. Утворення золотистих лусочок', true, 3),
  ((SELECT id FROM inserted_question), 'e. Виділення бульбашок газу', false, 4);


-- Question 236
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного розчину додали 2М розчин HCl. При цьому утворився білий осад, який при обробці розчином аміаку почорнів. Який катіон присутній у розчині?', NULL, 'medium', 236, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Mg2+', false, 0),
  ((SELECT id FROM inserted_question), 'Pb²⁺', false, 1),
  ((SELECT id FROM inserted_question), 'Ag+', false, 2),
  ((SELECT id FROM inserted_question), 'Ba2+', false, 3),
  ((SELECT id FROM inserted_question), 'Hg22+', true, 4);


-- Question 237
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який катіон V аналітичної групи (кислотно-основна класифікація) наявний у розчині, якщо під дією розчину хлориду олова (ІІ) у лужному середовищі випадає чорний осад?', NULL, 'medium', 237, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бісмут (III)', true, 0),
  ((SELECT id FROM inserted_question), 'Залізо (II)', false, 1),
  ((SELECT id FROM inserted_question), 'Залізо (III)', false, 2),
  ((SELECT id FROM inserted_question), 'Сурма (III)', false, 3),
  ((SELECT id FROM inserted_question), 'Марганець (II)', false, 4);


-- Question 238
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який із катіонів IV аналітичної групи можна виявити крапельним методом з алізарином із використанням аналітичного маскування?', NULL, 'medium', 238, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Sn[IV]', false, 0),
  ((SELECT id FROM inserted_question), 'Zn2+', false, 1),
  ((SELECT id FROM inserted_question), 'Al3+', true, 2),
  ((SELECT id FROM inserted_question), 'Sn2+', false, 3),
  ((SELECT id FROM inserted_question), 'Cr3+', false, 4);


-- Question 239
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі характерною реакцією на катіони срібла є:', NULL, 'medium', 239, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакція утворення жовтого осаду, що розчиняється у надлишку аміаку', false, 0),
  ((SELECT id FROM inserted_question), 'Реакція утворення сирнистого осаду AgCl, що розчиняється в розчині аміаку, який знову утворюється у разі додавання НNО3', true, 1),
  ((SELECT id FROM inserted_question), 'Реакція утворення сирнистого осаду АgCl, що розчиняється у кислотах', false, 2),
  ((SELECT id FROM inserted_question), 'Реакція утворення осаду, що розчиняється у розчині лугу', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція утворення комплексу, який руйнується під дією розчину HNO3', false, 4);


-- Question 240
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку сполуку додають при визначенні катіонів кальцію с індикатором мурексидом для створення рН>12?', NULL, 'medium', 240, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амонію гідроксид', false, 0),
  ((SELECT id FROM inserted_question), 'Уротропін', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію гідроксид', true, 2),
  ((SELECT id FROM inserted_question), 'Ацетатний буфер', false, 3),
  ((SELECT id FROM inserted_question), 'Аміачний буфер', false, 4);


-- Question 241
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До II аналітичної групи катіонів за кислотно-основною класифікацією належать такі катіони:', NULL, 'medium', 241, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентуму, плюмбуму, ртуті (І)', true, 0),
  ((SELECT id FROM inserted_question), 'Кальцію, стронцію, барію', false, 1),
  ((SELECT id FROM inserted_question), 'Цинку, алюмінію, хрому', false, 2),
  ((SELECT id FROM inserted_question), 'Алюмінію, магнію, цинку', false, 3),
  ((SELECT id FROM inserted_question), 'Калію, барію, бісмуту', false, 4);


-- Question 242
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка із наведених реакцій визначення катіонів амонію є специфічною?', NULL, 'medium', 242, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реакція з гідроксидами лужних металів при нагріванні', true, 0),
  ((SELECT id FROM inserted_question), 'Реакція з натрію гексанітрокобальтом (ІІІ)', false, 1),
  ((SELECT id FROM inserted_question), 'Реакція з натрію гексанітрокобальтом (ІІІ) у кислому середовищі', false, 2),
  ((SELECT id FROM inserted_question), 'Реакція з калію гексагідроксостибатом', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція з калію тетрайодогідраргіратом (ІІ) у лужному середовищі', false, 4);


-- Question 243
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Якого аналітичного ефекту слід чекати внаслідок дії калію гексаціаноферату (ІІ) па катіони Са2+?', NULL, 'medium', 243, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Утворення білого дрібнокристалічного осаду', true, 0),
  ((SELECT id FROM inserted_question), 'Утворення білого драглистого осаду', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення жовто-зелених кристалів', false, 2),
  ((SELECT id FROM inserted_question), 'Коричневе забарвлення розчину', false, 3),
  ((SELECT id FROM inserted_question), 'Утворення комплексної сполуки синього кольору', false, 4);


-- Question 244
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка спільна властивість сполук катіонів Al3+, Zn2+, Cr3+, Sn2+ об’єднує їх в IV аналітичну групу (кислотноосновна класифікація)?', NULL, 'medium', 244, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нерозчинність солей у воді', false, 0),
  ((SELECT id FROM inserted_question), 'Амфотерність гідроксидів', true, 1),
  ((SELECT id FROM inserted_question), 'Розчинність гідроксидів в кислотах', false, 2),
  ((SELECT id FROM inserted_question), 'Добра розчинність деяких солей', false, 3),
  ((SELECT id FROM inserted_question), 'Розчинність гідроксидів в надлишку розчину аміаку', false, 4);


-- Question 245
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чому катіони I аналітичної групи (кислотно-основна класифікація) не мають групового реагенту?', NULL, 'medium', 245, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мають великі іонні радіуси', false, 0),
  ((SELECT id FROM inserted_question), 'Мають близькі іонні радіуси', false, 1),
  ((SELECT id FROM inserted_question), 'Мають здатність утворювати розчинні основи', false, 2),
  ((SELECT id FROM inserted_question), 'Більшість їх солей розчинні у воді', true, 3),
  ((SELECT id FROM inserted_question), 'Належать до біологічно важливих елементів', false, 4);


-- Question 246
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного розчину додали розчин амонію тіоціанату. Розчин забарвився в червоний колір. На присутність якого катіону вказує цей аналітичний ефект?', NULL, 'medium', 246, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Меркурію ( I )', false, 0),
  ((SELECT id FROM inserted_question), 'Плюмбуму ( II )', false, 1),
  ((SELECT id FROM inserted_question), 'Меркурію ( II )', false, 2),
  ((SELECT id FROM inserted_question), 'Арґентуму', false, 3),
  ((SELECT id FROM inserted_question), 'Феруму ( III )', true, 4);


-- Question 247
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які катіони IV групи знаходяться у розчині, якщо під дією розчину гідроксиду натрію утворюється забарвлений осад, розчинний у надлишку реагенту?', NULL, 'medium', 247, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хром', true, 0),
  ((SELECT id FROM inserted_question), 'Свинець', false, 1),
  ((SELECT id FROM inserted_question), 'Вісмут', false, 2),
  ((SELECT id FROM inserted_question), 'Цинк', false, 3),
  ((SELECT id FROM inserted_question), 'Манган', false, 4);


-- Question 248
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні систематичного ходу аналізу на розчин подіяли груповим реагентом 1M H2SO4 у присутності етилового спирту, утворився білий осад. Катіони якої групи присутні у розчині?', NULL, 'medium', 248, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'III', true, 0),
  ((SELECT id FROM inserted_question), 'І', false, 1),
  ((SELECT id FROM inserted_question), 'II', false, 2),
  ((SELECT id FROM inserted_question), 'IV', false, 3),
  ((SELECT id FROM inserted_question), 'VI', false, 4);


-- Question 249
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з зазначених реакцій визначення катіонів амонію є специфічною?', NULL, 'medium', 249, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З гідроксидами лужних металів при нагріванні', true, 0),
  ((SELECT id FROM inserted_question), 'З калію гексагідроксостибіатом', false, 1),
  ((SELECT id FROM inserted_question), 'З натрію гексанітрокобальтатом (III)', false, 2),
  ((SELECT id FROM inserted_question), 'З натрію гексанітрокобальтатом (III) в кислому середовищі', false, 3),
  ((SELECT id FROM inserted_question), 'З калію тетрайодогідраргіратом (II) у лужному середовищі', false, 4);


-- Question 250
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Досліджувана суміш містить катіони Mg2+, Ni2+, Co2+. За допомогою якого реактиву можна виявити катіони Ni2+ у цій суміші?', NULL, 'medium', 250, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Диметилгліоксим', true, 0),
  ((SELECT id FROM inserted_question), 'Магнезон-1', false, 1),
  ((SELECT id FROM inserted_question), 'Амоніак', false, 2),
  ((SELECT id FROM inserted_question), '1-нітрозо-2-нафтол', false, 3),
  ((SELECT id FROM inserted_question), 'Алізарин', false, 4);


-- Question 251
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення якісного складу препарату на зразок досліджуваного розчину подіяли 2М розчином HCl. Випав білий осад, розчинний в водному розчині аміаку. На наявність яких катіонів вказує цей аналітичний ефект:', NULL, 'medium', 251, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стануму ( II )', false, 0),
  ((SELECT id FROM inserted_question), 'Арґентуму ( I )', true, 1),
  ((SELECT id FROM inserted_question), 'Меркурію ( I )', false, 2),
  ((SELECT id FROM inserted_question), 'Плюмбуму ( II )', false, 3),
  ((SELECT id FROM inserted_question), 'Меркурію ( II )', false, 4);


-- Question 252
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які катіони при взаємодії з сульфідом натрію утворюють осад чорного кольору?', NULL, 'medium', 252, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Цинку та кадмію', false, 0),
  ((SELECT id FROM inserted_question), 'Свинцю та срібла', true, 1),
  ((SELECT id FROM inserted_question), 'Амонію та алюмінію', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію та калію', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію та магнію', false, 4);


-- Question 253
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Солі якого катіону забарвлюють полум’я у фіолетовий колір?', NULL, 'medium', 253, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', true, 0),
  ((SELECT id FROM inserted_question), 'Барію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 3),
  ((SELECT id FROM inserted_question), 'Стронцію', false, 4);


-- Question 254
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В хіміко-аналітичній лабораторії спеціаліст досліджував розчини, що містять суміші катіонів. В якому з розчинів містяться лише катіони II аналітичної групи?', NULL, 'medium', 254, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ag+, Hg2+, Pb2+', true, 0),
  ((SELECT id FROM inserted_question), 'Hg3+, NH4, Ag+', false, 1),
  ((SELECT id FROM inserted_question), 'Na+ , Pb+ , Ni2+', false, 2),
  ((SELECT id FROM inserted_question), 'Na+, Hg2+,NH4+', false, 3),
  ((SELECT id FROM inserted_question), 'Pb2+, Ag+', false, 4);


-- Question 255
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Технологія виготовлення лікарських препаратів широко використовує явища адсорбції та іонного обміну. Який катіон із водного розчину найкраще адсорбується на негативно заряджених ділянках поверхні адсорбенту:', NULL, 'medium', 255, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Na+', false, 0),
  ((SELECT id FROM inserted_question), 'Cs+', true, 1),
  ((SELECT id FROM inserted_question), 'Li+', false, 2),
  ((SELECT id FROM inserted_question), 'К+', false, 3),
  ((SELECT id FROM inserted_question), 'Н+', false, 4);


-- Question 256
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В лабораторії необхідно ідентифікувати катіон амонію. Можна використати розчин:', NULL, 'medium', 256, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реактиву Несслера', true, 0),
  ((SELECT id FROM inserted_question), 'Цинку уранілацетату', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію сульфату', false, 2),
  ((SELECT id FROM inserted_question), 'Калію хромату', false, 3),
  ((SELECT id FROM inserted_question), 'Реактиву Чугаєва', false, 4);


-- Question 257
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з зазначених реакцій визначення катіонів амонію є специфічною?', NULL, 'medium', 257, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З калію гексагідроксоантимонатом', false, 0),
  ((SELECT id FROM inserted_question), 'З гідроксидами лужних металів при нагріванні', true, 1),
  ((SELECT id FROM inserted_question), 'З натрію гексанітрокобальтом (III)', false, 2),
  ((SELECT id FROM inserted_question), 'З натрію гексанітрокобальтом (III) у кислому середовищі', false, 3),
  ((SELECT id FROM inserted_question), 'З калію тетрайодогідраргиратом (II) у лужному середовищі', false, 4);


-- Question 258
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До п’ятої групи катіонів належать катіони Fe3+, Fe2+, Mg2+, Mn2+, Bi3+, S b(I I I ), S b(V ). Груповим реагентом для п’ятої групи катіонів є розчин:', NULL, 'medium', 258, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NH3', true, 0),
  ((SELECT id FROM inserted_question), 'H2SO4', false, 1),
  ((SELECT id FROM inserted_question), 'H2S', false, 2),
  ((SELECT id FROM inserted_question), 'HNO3', false, 3),
  ((SELECT id FROM inserted_question), 'HCl', false, 4);


-- Question 259
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До V аналітичної групи катіонів відносяться йони Mn2+. Якісною реакцією для цих катіонів є:', NULL, 'medium', 259, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окиснення в кислому середовищі', true, 0),
  ((SELECT id FROM inserted_question), 'Взаємодія з F e3+ в кислому середовищі', false, 1),
  ((SELECT id FROM inserted_question), 'Дія лугів', false, 2),
  ((SELECT id FROM inserted_question), 'Дія кислот', false, 3),
  ((SELECT id FROM inserted_question), 'Утворення нерозчинних комплексів', false, 4);


-- Question 260
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В хіміко-аналітичній лабораторії спеціаліст досліджує суміш катіонів V аналітичної групи. При додаванні тіоціонат-іонів розчин забарвлюється в червоний колір. Про наявність якого катіону свідчить даний аналітичний ефект?', NULL, 'medium', 260, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Fe3', false, 0),
  ((SELECT id FROM inserted_question), 'Fe2', false, 1),
  ((SELECT id FROM inserted_question), 'Mg2', false, 2),
  ((SELECT id FROM inserted_question), 'Bi3', false, 3),
  ((SELECT id FROM inserted_question), 'Mn2', true, 4);


-- Question 261
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У розчині присутні катіони цинку і алюмінію. Вкажіть реагент, який дозволяє виявити в цьому розчині катіони цинку:', NULL, 'medium', 261, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин калію гексаціаноферату (II)', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин натрію гідроксиду', false, 1),
  ((SELECT id FROM inserted_question), 'Кобальту нітрат Co(NO3)2', false, 2),
  ((SELECT id FROM inserted_question), 'Надлишок 6М гідроксиду натрію в присутності пероксиду водню', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин сульфатної кислоти', false, 4);


-- Question 262
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення лікарських засобів, які містять катіони магнію та кальцію, застосовують трилонометричне титрування. Який тип хімічної реакції при цьому відбувається?', NULL, 'medium', 262, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексоутворення', true, 0),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 1),
  ((SELECT id FROM inserted_question), 'Електрофільне заміщення', false, 2),
  ((SELECT id FROM inserted_question), 'Алкілування', false, 3),
  ((SELECT id FROM inserted_question), 'Осадження', false, 4);


-- Question 263
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Титрант методу комплексонометрії - розчин трилону Б - утворює з катіонами металів, незалежно від їх валентності, комплексні сполуки у молярному співвідношенні:', NULL, 'medium', 263, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1:1', true, 0),
  ((SELECT id FROM inserted_question), '1:3', false, 1),
  ((SELECT id FROM inserted_question), '1:2', false, 2),
  ((SELECT id FROM inserted_question), '2:1', false, 3),
  ((SELECT id FROM inserted_question), '3:1', false, 4);


-- Question 264
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аналізі суміші катіонів IV аналітичної групи катіони Zn при певних умовах можна визначити дрібним методом з таким реагентом:', NULL, 'medium', 264, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дитизон', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин амоніаку', false, 1),
  ((SELECT id FROM inserted_question), 'Луги', false, 2),
  ((SELECT id FROM inserted_question), 'Карбонати лужних металів', false, 3),
  ((SELECT id FROM inserted_question), 'Диметилгліоксим', false, 4);


-- Question 265
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який аналітичний ефект спостерігається під час визначення катіону калію розчином натрій гексанітрокобальтату (III)?', NULL, 'medium', 265, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жовтий кристалічний осад', true, 0),
  ((SELECT id FROM inserted_question), 'Білий кристалічний осад', false, 1),
  ((SELECT id FROM inserted_question), 'Жовте забарвлення розчину', false, 2),
  ((SELECT id FROM inserted_question), 'Чорний кристалічний осад', false, 3),
  ((SELECT id FROM inserted_question), 'Червоний кристалічний осад', false, 4);


-- Question 266
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У досліджуваній суміші знаходяться катіони феруму (III) та купруму (II). Дією якого групового реагенту можна розділити названі катіони:', NULL, 'medium', 266, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Концентрований розчин амоніаку', true, 0),
  ((SELECT id FROM inserted_question), 'Розчин гідроксиду натрію і пероксиду водню', false, 1),
  ((SELECT id FROM inserted_question), 'Концентрований розчин кислоти хлоридної', false, 2),
  ((SELECT id FROM inserted_question), 'Розчин гідроксиду натрію', false, 3),
  ((SELECT id FROM inserted_question), 'Концентрований розчин кислоти сульфатної', false, 4);


-- Question 267
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До досліджуваного розчину додали розчин хромату калію. Випав осад жовтого кольору, який не розчиняється в оцтовій кислоті. Це свідчить, що у досліджуваному розчині присутні катіони:', NULL, 'medium', 267, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Барію', true, 0),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Кобальту', false, 3),
  ((SELECT id FROM inserted_question), 'Магнію', false, 4);


-- Question 268
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якісному аналізі при дії надлишку групового реагенту (розчин гідроксиду натрію) на катіони IV аналітичної групи, іони хрому (III) утворюють:', NULL, 'medium', 268, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гексагідроксохромат натрію (III)', true, 0),
  ((SELECT id FROM inserted_question), 'Гідроксид хрому (III)', false, 1),
  ((SELECT id FROM inserted_question), 'Оксид хрому (III)', false, 2),
  ((SELECT id FROM inserted_question), 'Гідроксид хрому (II)', false, 3),
  ((SELECT id FROM inserted_question), 'Оксид хрому (II)', false, 4);


-- Question 269
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Катіони третьої аналітичної групи (кислотно-основна класифікація) відокремлюють у систематичному ході аналізу за допомогою такого групового реагенту:', NULL, 'medium', 269, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1 М розчин сульфатної кислоти в присутності етанолу', true, 0),
  ((SELECT id FROM inserted_question), '1 М розчин хромату калію', false, 1),
  ((SELECT id FROM inserted_question), '0,1 М розчин карбонату натрію', false, 2),
  ((SELECT id FROM inserted_question), '0,1 М розчин оксалату амонію', false, 3),
  ((SELECT id FROM inserted_question), '1 М розчин карбонату амонію', false, 4);


-- Question 270
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Розчин містить аніони органічних кислот. Після додавання розчину ферум (III) хлориду утворився осад рожево-жовтого кольору. Які аніони присутні у розчині?', NULL, 'medium', 270, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тетраборат', false, 0),
  ((SELECT id FROM inserted_question), 'Карбонат', false, 1),
  ((SELECT id FROM inserted_question), 'Бензоат', true, 2),
  ((SELECT id FROM inserted_question), 'Форміат', false, 3),
  ((SELECT id FROM inserted_question), 'Оксалат', false, 4);


-- Question 271
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дії групового реагенту AgNОз на аніони II аналітичної групи утворився жовтий осад, що не розчиняється в розчині аміаку. Укажіть склад цього осаду.', NULL, 'medium', 271, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'AgI', true, 0),
  ((SELECT id FROM inserted_question), 'Ag2S', false, 1),
  ((SELECT id FROM inserted_question), 'AgCl', false, 2),
  ((SELECT id FROM inserted_question), 'Ag2SO4', false, 3),
  ((SELECT id FROM inserted_question), 'AgNCS', false, 4);


-- Question 272
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хімік-аналітик досліджує розчин, що містить аніони ІІІ аналітичної групи. Після додавання антипірину розчин набув смарагдово-зеленого кольору. Які аніони присутні в розчині?', NULL, 'medium', 272, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацетат', false, 0),
  ((SELECT id FROM inserted_question), 'Оксалат', false, 1),
  ((SELECT id FROM inserted_question), 'Арсенат', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфат', false, 3),
  ((SELECT id FROM inserted_question), 'Нітрит', true, 4);


-- Question 273
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час взаємодії з яким реагентом фосфат- та арсенат-аніони утворюють аналогічні осади, нерозчинні у розчині аміаку?', NULL, 'medium', 273, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчином натрію гідроксиду', false, 0),
  ((SELECT id FROM inserted_question), 'Магнезіальною сумішню (розчином, що містить МgCl2, NH4CI, NH3)', true, 1),
  ((SELECT id FROM inserted_question), 'Розчином плюмбуму ацетату', false, 2),
  ((SELECT id FROM inserted_question), 'Реактивом Неслера', false, 3),
  ((SELECT id FROM inserted_question), 'Розчином кобальту сульфату', false, 4);


-- Question 274
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чому аніони третьої аналітичної групи аніонів не мають групового реагенту?', NULL, 'medium', 274, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'З більшістю катіонів утворюють розчинні у воді солі', true, 0),
  ((SELECT id FROM inserted_question), 'Належать до токсичних елементів', false, 1),
  ((SELECT id FROM inserted_question), 'Мають великі іонні радіуси', false, 2),
  ((SELECT id FROM inserted_question), 'Мають близькі іонні радіуси', false, 3),
  ((SELECT id FROM inserted_question), 'Мають здатність утворювати розчинні кислоти', false, 4);


-- Question 275
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які аніони заважають визначенню галогенідіонів методом Фольгарда через утворення міцного безбарвного комплексу з іонами феруму (ІІІ)?', NULL, 'medium', 275, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NO2-', false, 0),
  ((SELECT id FROM inserted_question), 'NO3-', false, 1),
  ((SELECT id FROM inserted_question), 'SO32-', false, 2),
  ((SELECT id FROM inserted_question), 'F-', true, 3),
  ((SELECT id FROM inserted_question), 'MnO4-', false, 4);


-- Question 276
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Класифікація аніонів базується на різній розчинності їх солей з іонами Ba2+ та Ag+. Аніони першої аналітичної групи утворюють малорозчинні у воді солі з іонами:', NULL, 'medium', 276, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ba2+ (лужне або нейтральне середовище)', true, 0),
  ((SELECT id FROM inserted_question), 'Ag+ (нейтральне середовище)', false, 1),
  ((SELECT id FROM inserted_question), 'Ag+ (лужне середовище)', false, 2),
  ((SELECT id FROM inserted_question), 'Ag+ (середовище аміачного буферу)', false, 3),
  ((SELECT id FROM inserted_question), 'Ag+ (кисле середовище)', false, 4);


-- Question 277
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить аніони першої аналітичної групи, додали розчин арґентум нітрату. Утворився жовтий осад. Це свідчить про присутність у розчині:', NULL, 'medium', 277, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Арсенат-іонів', false, 0),
  ((SELECT id FROM inserted_question), 'Сульфат-іонів', false, 1),
  ((SELECT id FROM inserted_question), 'Бромід-іонів', false, 2),
  ((SELECT id FROM inserted_question), 'Йодид-іонів', false, 3),
  ((SELECT id FROM inserted_question), 'Арсеніт-іонів', true, 4);


-- Question 278
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які аніони можна визначити за методом Мора?', NULL, 'medium', 278, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітрат та ацетат', false, 0),
  ((SELECT id FROM inserted_question), 'Форміат та нітрит', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорид та бромід', true, 2),
  ((SELECT id FROM inserted_question), 'Хромат та манґанат', false, 3),
  ((SELECT id FROM inserted_question), 'Йодид та тіоціанат', false, 4);


-- Question 279
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При проведенні проби на аніони нестійких кислот з характерним шипінням виділився безбарвний газ. Який аніон знаходився у розчині?', NULL, 'medium', 279, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'CH3COO−', false, 0),
  ((SELECT id FROM inserted_question), 'l−', false, 1),
  ((SELECT id FROM inserted_question), 'CO3 2-', true, 2),
  ((SELECT id FROM inserted_question), 'SiO3 2-', false, 3),
  ((SELECT id FROM inserted_question), 'SO4 2-', false, 4);


-- Question 280
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить аніони другої аналітичної групи, додали розчин хлорної води та органічний екстрагент. При цьому утворилось фіолетове забарвлення органічного шару. Які аніони присутні у розчині?', NULL, 'medium', 280, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бромід-іони', false, 0),
  ((SELECT id FROM inserted_question), 'Тіоціанат-іони', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорид-іони', false, 2),
  ((SELECT id FROM inserted_question), 'Йодид-іони', true, 3),
  ((SELECT id FROM inserted_question), 'Сульфід-іони', false, 4);


-- Question 281
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Груповим реагентом на першу аналітичну групу аніонів є нітрат барію. Укажіть аніони першої групи:', NULL, 'medium', 281, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'PO3−, CO2−, SO2−', true, 0),
  ((SELECT id FROM inserted_question), 'BrO3−, Br−, ClO4−', false, 1),
  ((SELECT id FROM inserted_question), 'CH3COO−, S2−, I−', false, 2),
  ((SELECT id FROM inserted_question), 'NO3−, NO2−, HCOO−', false, 3),
  ((SELECT id FROM inserted_question), 'Cl−, Br−, OH', false, 4);


-- Question 282
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аналізі фармпрепарату виявили аніони третьої аналітичної групи. Вкажіть реагенти для проведення реакції "бурого кільця":', NULL, 'medium', 282, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (кристалічний) та сульфатна кислота (конц.)', true, 0),
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (розчин) та сульфатна кислота (розведена)', false, 1),
  ((SELECT id FROM inserted_question), 'Ферум (II) сульфат (розчин) та сульфатна кислота (конц.)', false, 2),
  ((SELECT id FROM inserted_question), 'Ферум (III) сульфат (розчин) та сульфатна кислота (розведена)', false, 3),
  ((SELECT id FROM inserted_question), 'Ферум (III) сульфат (розчин) та сульфатна кислота (конц.)', false, 4);


-- Question 283
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить аніони другої аналітичної групи, додали розчин аргентуму нітрату. Утворився чорний осад, нерозчинний в розчині амоніаку, але розчинний при нагріванні в розведеній нітратній кислоті. Які аніони присутні в розчині?', NULL, 'medium', 283, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сульфід-іони', true, 0),
  ((SELECT id FROM inserted_question), 'Йодид-іони', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорид-іони', false, 2),
  ((SELECT id FROM inserted_question), 'Бромід-іони', false, 3),
  ((SELECT id FROM inserted_question), 'Арсеніт-іони', false, 4);


-- Question 284
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить аніони другої аналітичної групи, долили розчин аргентуму нітрату. Утворився блідо- жовтий осад, нерозчинний в азотній кислоті та частково розчинний в розчині амоніаку. Які аніони присутні в розчині?', NULL, 'medium', 284, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бромід-іони', true, 0),
  ((SELECT id FROM inserted_question), 'Йодид-іони', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорид-іони', false, 2),
  ((SELECT id FROM inserted_question), 'Сульфід-іони', false, 3),
  ((SELECT id FROM inserted_question), 'Арсеніт-іони', false, 4);


-- Question 285
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До підкисленого сульфатною кислотою розчину, що містить аніони третьої аналітичної групи, додали розчин йодиду калію. Спостерігається виділення вільного йоду. Які аніони присутні в розчині?', NULL, 'medium', 285, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нітрит-іони', true, 0),
  ((SELECT id FROM inserted_question), 'Карбонат-іони', false, 1),
  ((SELECT id FROM inserted_question), 'Сульфат-іони', false, 2),
  ((SELECT id FROM inserted_question), 'Бромід-іони', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетат-іони', false, 4);


-- Question 286
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналітичною ознакою дії розчину йодиду калію на безбарвні аніони- окисники у присутності хлороформу є:', NULL, 'medium', 286, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поява коричневого кольору вільного йоду', true, 0),
  ((SELECT id FROM inserted_question), 'Випадання осаду білого кольору', false, 1),
  ((SELECT id FROM inserted_question), 'Зміна агрегатного стану', false, 2),
  ((SELECT id FROM inserted_question), 'Виділення бульбашок газу', false, 3),
  ((SELECT id FROM inserted_question), 'Поява осаду і його розчинення у надлишку реагенту', false, 4);


-- Question 287
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть реагенти для виявлення сульфат-іонів у розчині, що містить карбонат, сульфат-, тіосульфат-, фосфат-аніони:', NULL, 'medium', 287, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ba(NO3)2, HCl', true, 0),
  ((SELECT id FROM inserted_question), 'Ba(NO3)2, NaOH', false, 1),
  ((SELECT id FROM inserted_question), 'BaCl2, H2O', false, 2),
  ((SELECT id FROM inserted_question), 'CaCl2, NH4OH', false, 3),
  ((SELECT id FROM inserted_question), 'AgNO3, HNO3', false, 4);


-- Question 288
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину, що містить аніони другої аналітичної групи, долили розчин аргентум нітрату. Утворився блідо-жовтий осад, нерозчинний в нітратній кислоті і частково розчинний в розчині амоніаку. Які аніони присутні в розчині?', NULL, 'medium', 288, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бромід-іони', true, 0),
  ((SELECT id FROM inserted_question), 'Йодид-іони', false, 1),
  ((SELECT id FROM inserted_question), 'Хлорид-іони', false, 2),
  ((SELECT id FROM inserted_question), 'Сульфід-іони', false, 3),
  ((SELECT id FROM inserted_question), 'Арсеніт-іони', false, 4);


-- Question 289
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналіз кристалогідрату натрію сульфату виконали гравіметричним методом, осаджуючи сульфат-іони розчином барію хлориду. Яку промивну рідину використовують під час декантації осаду барію сульфату після його дозрівання?', NULL, 'medium', 289, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин амонію сульфату', false, 0),
  ((SELECT id FROM inserted_question), 'Розчин барію хлориду', false, 1),
  ((SELECT id FROM inserted_question), 'Розведений розчин сірчаної кислоти', true, 2),
  ((SELECT id FROM inserted_question), 'Дистильовану воду', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин натрію сульфату', false, 4);


-- Question 290
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Суспензії як лікарську форму доволі часто використовують у педіатричній практиці. Для визначення розміру частинок під час осідання дисперсної фази суспензій застосовують:', NULL, 'medium', 290, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Седиментаційний аналіз', true, 0),
  ((SELECT id FROM inserted_question), 'Об’ємний аналіз', false, 1),
  ((SELECT id FROM inserted_question), 'Гравіметричний аналіз', false, 2),
  ((SELECT id FROM inserted_question), 'Фізико-хімічний аналіз', false, 3),
  ((SELECT id FROM inserted_question), 'Термічний аналіз', false, 4);


-- Question 291
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення вмісту магнію застосували гравіметричний метод осадження. Виберіть осаджувальну і гравіметричну форми:', NULL, 'medium', 291, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'MgNH4PO4, MgO', false, 0),
  ((SELECT id FROM inserted_question), 'MgNH4PO4, Mg2P2O7', true, 1),
  ((SELECT id FROM inserted_question), 'Mg(OH)2, MgO', false, 2),
  ((SELECT id FROM inserted_question), 'MgNH4PO4, Mg(OH)2', false, 3),
  ((SELECT id FROM inserted_question), 'Mg(OH)2, Mg2P2O7', false, 4);


-- Question 292
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення масової частки іонів барію в лікарському препараті використовують гравіметричний метод осадження. Гравіметричною формою в даному випадку є:', NULL, 'medium', 292, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Барію сульфат', true, 0),
  ((SELECT id FROM inserted_question), 'Барію сульфід', false, 1),
  ((SELECT id FROM inserted_question), 'Барію оксид', false, 2),
  ((SELECT id FROM inserted_question), 'Барію сульфіт', false, 3),
  ((SELECT id FROM inserted_question), 'Барію гідроксид', false, 4);


-- Question 293
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення масової частки кальцію в лікарському препараті застосували гравіметричний метод осадження. В якості осаджувача використали розчин амонію оксалату. Гравіметричною формою в даному випадку є:', NULL, 'medium', 293, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кальцію оксид', true, 0),
  ((SELECT id FROM inserted_question), 'Кальцію оксалат безводний', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію оксалат моноводний', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію карбонат', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію гідроксид', false, 4);


-- Question 294
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть титриметричний метод аналізу для визначення кількісного вмісту магній хлориду в суміші, що містить хлориди калію і магнію?', NULL, 'medium', 294, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Меркурометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Аргентометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 295
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який індикатор використовують для проведення титриметричного визначення речовин методом меркуриметрії (комплексонометрія)?', NULL, 'medium', 295, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метиловий оранжевий', false, 0),
  ((SELECT id FROM inserted_question), 'Фенолфталеїн', false, 1),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазид', true, 2),
  ((SELECT id FROM inserted_question), 'Хромат калію', false, 3),
  ((SELECT id FROM inserted_question), 'Крохмаль', false, 4);


-- Question 296
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка реакція лежить в основі титриметричного методу Фаянса-Ходакова?', NULL, 'medium', 296, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нейтралізації', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 1),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 2),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 3),
  ((SELECT id FROM inserted_question), 'Осадження', true, 4);


-- Question 297
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хіміко-аналітичній лабораторії проводять титриметричне визначення загальної твердості води методом комплексонометрії. Розчин якого титранту використовують у цьому методі?', NULL, 'medium', 297, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію перманганату', false, 0),
  ((SELECT id FROM inserted_question), 'Магнію сульфату', false, 1),
  ((SELECT id FROM inserted_question), 'Трилону Б', true, 2),
  ((SELECT id FROM inserted_question), 'Барію нітрату', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію хлориду', false, 4);


-- Question 298
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який індикатор використовують під час проведення титриметричного визначення речовин методом меркуриметричного титрування?', NULL, 'medium', 298, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крохмаль', false, 0),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазид', true, 1),
  ((SELECT id FROM inserted_question), 'Еріохром чорний Т', false, 2),
  ((SELECT id FROM inserted_question), 'Тропеолін 00', false, 3),
  ((SELECT id FROM inserted_question), 'Хромат калію', false, 4);


-- Question 299
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який титриметричний метод аналізу застосовують для кількісного визначення хлориду Кальцію?', NULL, 'medium', 299, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перманганатометрії, пряме титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрії, зворотне титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Нітритометрії, пряме титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Цериметрії, пряме титрування', false, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрії, зворотне титрування', true, 4);


-- Question 300
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким методом титриметричного аналізу проводиться кількісне визначення стрептоциду (сульфаніламіду) розчином КВrОз у присутності КВr?', NULL, 'medium', 300, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ванадатометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Дихроматометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 301
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку характеристику в титриметричних методах аналізу використовують під час вибору індикатору?', NULL, 'medium', 301, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інтервал переходу', true, 0),
  ((SELECT id FROM inserted_question), 'Стрибок титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Точка нейтралізації', false, 2),
  ((SELECT id FROM inserted_question), 'Константа індикатора', false, 3),
  ((SELECT id FROM inserted_question), 'Показник титрування', false, 4);


-- Question 302
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким методом титриметричного аналізу проводиться кількісне визначення стрептоциду (сульфаніламіду) розчином КВrОз у присутності КВr?', NULL, 'medium', 302, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ванадатометрія', false, 0),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Дихроматометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Броматометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 4);


-- Question 303
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В основі однієї з класифікацій титриметричних методів аналізу лежить хімізм реакції між досліджуваною речовиною та титрантом. Яка реакція лежить в основі визначення кількості натрію карбонату за допомогою хлористоводневої кислоти?', NULL, 'medium', 303, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Осадження', false, 0),
  ((SELECT id FROM inserted_question), 'Окиснення-відновлення', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтралізації', true, 2),
  ((SELECT id FROM inserted_question), 'Гідролізу', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 304
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яку сполуку можна використовувати як індикатор під час проведення титриметричного визначення речовин методом меркуриметричного титрування?', NULL, 'medium', 304, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еріохром чорний Т', false, 0),
  ((SELECT id FROM inserted_question), 'Крохмаль', false, 1),
  ((SELECT id FROM inserted_question), 'Хромат калію', false, 2),
  ((SELECT id FROM inserted_question), 'Тропеолін 00', false, 3),
  ((SELECT id FROM inserted_question), 'Дифенілкарбазид', true, 4);


-- Question 305
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Індикатор фенолфталеїн часто використовують у титриметричному аналізі. Вкажіть метод титрування, в якому його застосовують:', NULL, 'medium', 305, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Окисно-відновне титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Кислотно-основне титрування', true, 1),
  ((SELECT id FROM inserted_question), 'Комплексонометричне титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Осаджувальне титрування', false, 3),
  ((SELECT id FROM inserted_question), 'Метод перманганатометрії', false, 4);


-- Question 306
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть титриметричний метод кількісного визначення фенолу та його похідних:', NULL, 'medium', 306, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Броматометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Церіметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Аскорбінометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Нітритометрія', false, 4);


-- Question 307
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хіміку-аналітику потрібно визначити кількісний вміст хлоридної кислоти в суміші, яка містить нітратну кислоту. Який титриметричний метод аналізу він може використати?', NULL, 'medium', 307, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аргентометрію', true, 0),
  ((SELECT id FROM inserted_question), 'Комплексонометрію', false, 1),
  ((SELECT id FROM inserted_question), 'Йодометрію', false, 2),
  ((SELECT id FROM inserted_question), 'Перманганотометрію', false, 3),
  ((SELECT id FROM inserted_question), 'Кислотно-основне титрування', false, 4);


-- Question 308
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для дослідження взяли розчин, в якому містяться калію хлорид і магнію хлорид. Яким титриметричним методом можна визначити кількість магнію хлориду в суміші?', NULL, 'medium', 308, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Методом комплексонометрії', true, 0),
  ((SELECT id FROM inserted_question), 'Методом йодометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Методом меркурометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Методом аргентометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Методом перманганатометрії', false, 4);


-- Question 309
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Індикатор фенолфталеїн часто використовують у титриметричному аналізі. Укажіть метод титрування, в якому його застосовують:', NULL, 'medium', 309, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кислотно-основне титрування', true, 0),
  ((SELECT id FROM inserted_question), 'Метод перманганатометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Окисно-відновне титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Комплексонометричне титрування', false, 3),
  ((SELECT id FROM inserted_question), 'Підберіть посуд, що використовується в титриметричних методах аналізу для вимірювання точного об’єму титранту:', false, 4);


-- Question 310
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Оберіть індикатор та метод титриметричного аналізу для визначення гідроґенкарбонат-іонів в фармпрепараті:', NULL, 'medium', 310, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метилоранж, ацидиметрія', true, 0),
  ((SELECT id FROM inserted_question), 'Фенолфталеїн, алкаліметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Фенолфталеїн, ацидиметрія', false, 2),
  ((SELECT id FROM inserted_question), 'Мурексид, ацидиметрія', false, 3),
  ((SELECT id FROM inserted_question), 'Метилоранж, алкаліметрія', false, 4);


-- Question 311
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В якому із титриметричних методів аналізу використовують зовнішні і внутрішні індикатори?', NULL, 'medium', 311, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкаліметрія', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексонометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Перманґанатометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Нітритометрія', true, 3),
  ((SELECT id FROM inserted_question), 'Арґентометрія', false, 4);


-- Question 312
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У титриметричному аналізі використовують різні способи титрування. Якщо є можливість вибору, то яким методом слід скористатись, щоб одержати точніший результат?', NULL, 'medium', 312, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реверсійне титрування', false, 0),
  ((SELECT id FROM inserted_question), 'Комбіноване титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Замісникове титрування', false, 2),
  ((SELECT id FROM inserted_question), 'Пряме титрування', true, 3),
  ((SELECT id FROM inserted_question), 'Зворотнє титрування', false, 4);


-- Question 313
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На аналіз взято розчин сульфату цинку. Запропонуйте титриметричний метод для кількісного визначення ZnSO4 в розчині:', NULL, 'medium', 313, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексонометрія', true, 0),
  ((SELECT id FROM inserted_question), 'Перманганатометрія', false, 1),
  ((SELECT id FROM inserted_question), 'Йодометрія', false, 2),
  ((SELECT id FROM inserted_question), 'Арґентометрія', false, 3),
  ((SELECT id FROM inserted_question), 'Меркурометрія', false, 4);


-- Question 314
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Кількісне визначення гідроґен пероксиду проводять титриметричним методом:', NULL, 'medium', 314, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перманганатометрії', true, 0),
  ((SELECT id FROM inserted_question), 'Меркурометрії', false, 1),
  ((SELECT id FROM inserted_question), 'Меркуріметрії', false, 2),
  ((SELECT id FROM inserted_question), 'Аргентометрії', false, 3),
  ((SELECT id FROM inserted_question), 'Алкаліметрії', false, 4);


-- Question 315
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яким методом титриметричного аналізу можна провести кількісне визначення сірчаної кислоти розчином калію гідроксиду?', NULL, 'medium', 315, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкаліметрія', true, 0),
  ((SELECT id FROM inserted_question), 'Ацидиметрія', false, 1),
  ((SELECT id FROM inserted_question), 'Окислення-відновлення', false, 2),
  ((SELECT id FROM inserted_question), 'Осадження', false, 3),
  ((SELECT id FROM inserted_question), 'Комплексоутворення', false, 4);


-- Question 316
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як називається в аналізі прийом зв’язування сторонніх у розчині іонів?', NULL, 'medium', 316, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аналітичне вилучення', false, 0),
  ((SELECT id FROM inserted_question), 'Аналітичне маскування', true, 1),
  ((SELECT id FROM inserted_question), 'Аналітичне концентрування', false, 2),
  ((SELECT id FROM inserted_question), 'Аналітичне розділення', false, 3),
  ((SELECT id FROM inserted_question), 'Аналітичне співосадження', false, 4);


-- Question 317
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для взяття наважки при приготуванні вторинних стандартних розчинів використовують технохімічні терези. Точність зважування на технохімічних терезах:', NULL, 'medium', 317, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '±0,01a˜', true, 0),
  ((SELECT id FROM inserted_question), '±0 0001a˜', false, 1),
  ((SELECT id FROM inserted_question), '±0,002a˜', false, 2),
  ((SELECT id FROM inserted_question), '±0,001a˜', false, 3),
  ((SELECT id FROM inserted_question), 'Гравіметричне визначення вологи у фармацевтичних препаратах виконують методом:', false, 4);


-- Question 318
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Поясніть, чому йодиметричне визначення потрібно проводити в холоді:', NULL, 'medium', 318, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Під час нагрівання йод стає леткішим та зменшується чутливість індикатора крохмалю', true, 0),
  ((SELECT id FROM inserted_question), 'Під час нагрівання йод легко окислюється киснем повітря', false, 1),
  ((SELECT id FROM inserted_question), 'Під час нагрівання йод реагує з водою з утворенням йодноватистої кислоти (HIO)', false, 2),
  ((SELECT id FROM inserted_question), 'Реакції з йодом під час нагрівання є менш селективними', false, 3),
  ((SELECT id FROM inserted_question), 'Під час нагрівання йод розкладається з утворенням атомарного йоду', false, 4);


-- Question 319
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який метод титрувания треба використати для визначення леткої речовини?', NULL, 'medium', 319, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метод окремих наважок', false, 0),
  ((SELECT id FROM inserted_question), 'Титрування за замісником', false, 1),
  ((SELECT id FROM inserted_question), 'Зворотне титрування', true, 2),
  ((SELECT id FROM inserted_question), 'Титрування з інструментальним фіксуванням точки еквівалентності', false, 3),
  ((SELECT id FROM inserted_question), 'Пряме титрування', false, 4);


-- Question 320
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Виберіть відповідний метод титрування, якщо визначувана речовина летка:', NULL, 'medium', 320, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Титрування за замісником', false, 0),
  ((SELECT id FROM inserted_question), 'Спосіб прямого титрування', false, 1),
  ((SELECT id FROM inserted_question), 'Титрування з інструментальним фіксуванням точки еквівалентності', false, 2),
  ((SELECT id FROM inserted_question), 'Метод окремих наважок', false, 3),
  ((SELECT id FROM inserted_question), 'Спосіб зворотного титрування', true, 4);


-- Question 321
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення масової частки кальцію в лікарському препараті застосували гравіметричний метод осадження. В якості осаджувача використали розчин амонію оксалату. Гравіметричною формою в даному випадку є:', NULL, 'medium', 321, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кальцію оксид', true, 0),
  ((SELECT id FROM inserted_question), 'Кальцію оксалат безводний', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію оксалат моноводний', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію карбонат', false, 3),
  ((SELECT id FROM inserted_question), 'Кальцію гідроксид', false, 4);


-- Question 322
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для визначення масової частки іонів барію в лікарському препараті використовують гравіметричний метод осадження. Гравіметричною формою в даному випадку є:', NULL, 'medium', 322, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Барію сульфат', true, 0),
  ((SELECT id FROM inserted_question), 'Барію сульфід', false, 1),
  ((SELECT id FROM inserted_question), 'Барію оксид', false, 2),
  ((SELECT id FROM inserted_question), 'Барію сульфіт', false, 3),
  ((SELECT id FROM inserted_question), 'Барію гідроксид', false, 4);


-- Question 323
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналіз кристалогідрату натрію сульфату виконали гравіметричним методом, осаджуючи сульфат-іони розчином барію хлориду. Яку промивну рідину використовують під час декантації осаду барію сульфату після його дозрівання?', NULL, 'medium', 323, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Теоретичні основи фармацевтичного аналізу'
    AND t.title = 'Фазова рівновага'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розчин амонію сульфату', false, 0),
  ((SELECT id FROM inserted_question), 'Розчин барію хлориду', false, 1),
  ((SELECT id FROM inserted_question), 'Розведений розчин сірчаної кислоти', true, 2),
  ((SELECT id FROM inserted_question), 'Дистильовану воду', false, 3),
  ((SELECT id FROM inserted_question), 'Розчин натрію сульфату', false, 4);


COMMIT;