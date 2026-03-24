BEGIN;

-- Auto-generated from: /Users/bohdanpavliuk/Downloads/Untitled document (1).txt
-- Target: курс «Система кровотворення й імунного захисту, кров», тема «Біохімія крові» (order_index 1 = тест 16 після тесту 15)
-- Questions parsed: 101

INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
SELECT c.id, 'Біохімія крові', 'Імпорт із Untitled document (1).txt (розділ 16)', 1, true, NOW(), NOW()
FROM courses c
WHERE c.title = 'Система кровотворення й імунного захисту, кров'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Біохімія крові');

DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
);

DELETE FROM questions
WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  LIMIT 1
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час адаптації до перебування в горах, в еритроцитах зростає синтез 2,3-дифосфогліцерату. Що стимулює ця речовина в організмі людини?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Утворення оксигемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Дисоціацію оксигемоглобіну', true, 1),
  ((SELECT id FROM inserted_question), 'Утворення карбгемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинне дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Окисне фосфорилювання', false, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта відзначено підвищену чутливість до світла, ураження відкритих ділянок шкіри, неврологічний біль. У сечі спостерігається неспецифічне виведення порфіринів. Це захворювання належить до групи порфірій і є наслідком порушення:', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розпаду гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Засвоєння вітаміну РР', false, 1),
  ((SELECT id FROM inserted_question), 'Синтезу гемоглобіну', true, 2),
  ((SELECT id FROM inserted_question), 'Утворення уробіліну', false, 3),
  ((SELECT id FROM inserted_question), 'Засвоєння рибофлавіну', false, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час пожежі людина отруїлася чадним газом. Які зміни у крові при цьому відбулися?', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розвинувся ацидоз', false, 0),
  ((SELECT id FROM inserted_question), 'Утворення редукованого гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення карбоксигемоглобіну', true, 2),
  ((SELECT id FROM inserted_question), 'Утворення метгемоглобіну', false, 3),
  ((SELECT id FROM inserted_question), 'Утворення карбгемоглобіну', false, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина хворіє на цукровий діабет, що супроводжується гіперглікемією натще понад 7,2 ммоль/л. Рівень якого білка плазми крові дозволяє ретроспективно (за попередні 4-8 тижні до обстеження) оцінити рівень глікемії?', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', false, 1),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 2),
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Що відображає колірний показник крові?', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відносний вміст гемоглобіну в еритроциті', true, 0),
  ((SELECT id FROM inserted_question), 'Співвідношення вмісту гемоглобіну до гематокриту', false, 1),
  ((SELECT id FROM inserted_question), 'Співвідношення сироватки крові до плазми', false, 2),
  ((SELECT id FROM inserted_question), 'Співвідношення гематокриту до кількості еритроцитів', false, 3),
  ((SELECT id FROM inserted_question), 'Співвідношення формених елементів крові до плазми крові', false, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час клінічного та біохімічного обстеження пацієнта виявлено серповидноклітинну анемію. Визначення якого компонента крові було вирішальним для встановлення діагнозу?', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метгемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну F', false, 1),
  ((SELECT id FROM inserted_question), 'Гемоглобіну S', true, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіну A1', false, 3),
  ((SELECT id FROM inserted_question), 'Гемоглобіну С', false, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт тривалий час застосовував великі дози сульфаніламідних препаратів. Нещодавно в нього з''явилися: значна задишка в спокої, слабкість, втрата апетиту, порушення сну. Лабораторне дослідження крові виявило наявність в крові метгемоглобіну. Який механізм інактивації гемоглобіну в еритроцитах відбувається в пацієнта?', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сполучення гемоглобіну з сульфаніламідами', false, 0),
  ((SELECT id FROM inserted_question), 'Блокада окисних ферментних систем', false, 1),
  ((SELECT id FROM inserted_question), 'Пошкодження білка в гемоглобіні', false, 2),
  ((SELECT id FROM inserted_question), 'Блокада відновних ферментних систем', false, 3),
  ((SELECT id FROM inserted_question), 'Окислення заліза в гемоглобіні', true, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Щоденно в організмі людини 0,5% всього гемоглобіну перетворюється на метгемоглобін. Який фермент, що міститься в еритроцитах, каталізує відновлення метгемоглобіну до гемоглобіну?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Білівердинредуктаза', false, 0),
  ((SELECT id FROM inserted_question), 'Глюкуронілтрансфераза', false, 1),
  ((SELECT id FROM inserted_question), 'Метгемоглобінредуктаза', true, 2),
  ((SELECT id FROM inserted_question), 'Гемоксигеназа', false, 3),
  ((SELECT id FROM inserted_question), 'Метгемоглобінтрансфераза', false, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В приймальне відділення надійшла дитина 1,5 років з ознаками отруєння нітратами: стійкий ціаноз, задишка, судоми. Утворення якої форми гемоглобіну лежить в основі цих симптомів?', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метгемоглобіну', true, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Карбгемоглобіну', false, 3),
  ((SELECT id FROM inserted_question), 'Редукованого гемоглобіну', false, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Швидка допомога доставила до лікарні непритомного водія, який проспав у кабіні автомобіля з увімкненим двигуном протягом тривалого часу. Під час огляду шкірні покриви яскраво червоного кольору. Яка причина непритомності?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Накопичення відновленого гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Накопичення метгемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Накопичення вуглекислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Накопичення карбоксигемоглобіну', true, 3),
  ((SELECT id FROM inserted_question), 'Накопичення карбгемоглобіну', false, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта шпиталізовано до реанімаційного відділення з підозрою на отруєння чадним газом. Яке похідне гемоглобіну буде виявлено під час спектрального аналізу?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Дезоксигемоглобін', false, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При дії окислювачів (перекис водню, оксиди азоту та інші), гемоглобін, до складу якого входить Fе2+, перетворюється на сполуку, що містить FеЗ+. Ця сполука не здатна переносити кисень і має назву?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', true, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В приймальне відділення доставлена дитина 1,5 років з ознаками отруєння нітратами: стійкий ціаноз, задишка, судоми. Який патогенетичний механізм лежить в основі цих симптомів?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Оксигемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Карбгемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Відновленого гемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Метгемоглобіну', true, 3),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобіну', false, 4);


-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після ремонту автомобілю в гаражному приміщенні водій потрапив до лікарні з симптомами отруєння вихлопними газами. Вміст якої речовини у крові буде підвищено?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина знепритомніла у салоні автомобіля, де тривалий час очікувала приятеля при ввімкненому двигуні. В крові у неї знайдено сполуку гемоглобіну. Яку саме?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Дезоксигемоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', true, 4);


-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина довгий час проживала в умовах високогір’я. Які зміни в кровоносній системі будуть у неї?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення діаметра кровоносних судин', false, 0),
  ((SELECT id FROM inserted_question), 'Збільшення кількості гемоглобіну', true, 1),
  ((SELECT id FROM inserted_question), 'Збільшення кількості лейкоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Вповільнення пульсу', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження кількості лейкоцитів', false, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарки звернувся чоловік віком 25 років із жовтяницею, загальною слабкістю та темною сечею, які з’явилися через кілька годин після вживання страви з бобів. В анамнезі: епізоди гемолітичних кризів після прийому деяких ліків. Під час лабораторного дослідження виявлено: знижений рівень гемоглобіну, підвищений уміст непрямого білірубіну та наявність гемоглобіну в сечі. Дефіцит якого ферменту спричинив цей стан?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 0),
  ((SELECT id FROM inserted_question), 'Піруваткінази', false, 1),
  ((SELECT id FROM inserted_question), 'Каталази', false, 2),
  ((SELECT id FROM inserted_question), 'Феррокелатази', false, 3),
  ((SELECT id FROM inserted_question), 'Супероксиддисмутази', false, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта час від часу суттєво знижується вміст гемоглобіну та еритроцитів у крові, з''являється жовтяниця. З анамнезу з''ясовано, що ці напади завжди виникають після вживання кінських бобів. На яку форму анемії вказують такі симптоми пацієнта?', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Набуту гемолітичну анемію', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитну анемію', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкову мембранопатію', false, 2),
  ((SELECT id FROM inserted_question), 'Спадкову ферментопатію', true, 3),
  ((SELECT id FROM inserted_question), 'Спадкову гемоглобінопатію', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта - гострий інфекційний процес, що супроводжується гарячкою. Температура тіла становить 39,5°С. У який бік зміститься крива дисоціації оксигемоглобіну внаслідок підвищення температури?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вліво', false, 0),
  ((SELECT id FROM inserted_question), 'Вправо', true, 1),
  ((SELECT id FROM inserted_question), 'Вверх', false, 2),
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 3),
  ((SELECT id FROM inserted_question), 'Вниз', false, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка під час обстеження в клініці виявлено різке зниження показників гемоглобіну. Яка функція крові порушується?', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Трофічна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', true, 1),
  ((SELECT id FROM inserted_question), 'Гомеостатична', false, 2),
  ((SELECT id FROM inserted_question), 'Гуморальна', false, 3);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До відділення реанімації доставлено пацієнта, у крові якого виявлено високий вміст сульфгемоглобіну. Який тип гіпоксії наявний у цьому разі?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторний тип', false, 0),
  ((SELECT id FROM inserted_question), 'Екзогенний тип', false, 1),
  ((SELECT id FROM inserted_question), 'Респіраторний тип', false, 2),
  ((SELECT id FROM inserted_question), 'Гемічний тип', true, 3),
  ((SELECT id FROM inserted_question), 'Тканинний тип', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Гемоглобін дорослої людини (HbA1) - білок-тетрамер, який складається з двох альфа- та двох бета-пептидних ланцюгів. Яку назву має така структура цього білка?', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вторинна', false, 0),
  ((SELECT id FROM inserted_question), 'Первинна', false, 1),
  ((SELECT id FROM inserted_question), 'Третинна', false, 2),
  ((SELECT id FROM inserted_question), '-', false, 3),
  ((SELECT id FROM inserted_question), 'Четвертинна', true, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Юнак віком 15 років скаржиться на загальну слабкість, запаморочення, швидку стомлюваність. Під час обстеження виявлено еритроцити зміненої форми, кількість їх знижена. Попередній діагноз: серповидноклітинна анемія. Яка амінокислотна заміна в гемоглобіні зумовлює розвиток цього патологічного стану?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глутамату на аланін', false, 0),
  ((SELECT id FROM inserted_question), 'Глутамату на аспартат', false, 1),
  ((SELECT id FROM inserted_question), 'Валіну на глутамат', false, 2),
  ((SELECT id FROM inserted_question), 'Глутамату на валін', true, 3),
  ((SELECT id FROM inserted_question), 'Валіну на аспартат', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У разі спадкового дефекту ферментів синтезу гема хворий має підвищену чутливість шкіри до сонячного світла, сечу червоного кольору. Накопичення яких метаболітів обміну гемоглобіну викликає ці симптоми?', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Білірубіну', false, 0),
  ((SELECT id FROM inserted_question), 'Уробіліногенів', false, 1),
  ((SELECT id FROM inserted_question), 'Порфіриногенів', true, 2),
  ((SELECT id FROM inserted_question), 'Мезобіліногенів', false, 3),
  ((SELECT id FROM inserted_question), 'Стеркобіліногенів', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналіз крові виявив знижений вміст гемоглобіну. Яка функція крові порушиться?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Транспорт гормонів', false, 0),
  ((SELECT id FROM inserted_question), 'Транспорт газів', true, 1),
  ((SELECT id FROM inserted_question), 'Забезпечення імунітету', false, 2),
  ((SELECT id FROM inserted_question), 'Зсідання', false, 3),
  ((SELECT id FROM inserted_question), 'Транспорт поживних речовин', false, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 19-ти років з дитинства спостерігалося зниження гемоглобіну до 9095 г/л. Аналіз крові під час госпіталізації: еритроцити - 3,2 • 10^12/л, гемоглобін - 85 г/л, КП- 0,78; лейкоцити - 5,6 • 10^9/л, тромбоцити - 210 • 10^9/л. В мазку: анізоцитоз, пойкілоцитоз, мішенеподібні еритроцити. Ретикулоцити - 6%. Лікування препаратами заліза не ефективне. Яку патологію системи крові можна припустити в даному випадку?:', NULL, 'medium', 26, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Мембранопатія', false, 1),
  ((SELECT id FROM inserted_question), 'Ферментопатія', false, 2),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 3),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 4);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вивчення організму мешканця Паміру виявило високий рівень основного обміну, розширення грудної клітки, зростання кисневої ємності крові за рахунок збільшення еритроцитів, високий вміст гемоглобіну. До якого адаптивного екологічного типу слід віднести цього чоловіка?', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Субтропічний', false, 0),
  ((SELECT id FROM inserted_question), 'Тропічний', false, 1),
  ((SELECT id FROM inserted_question), 'Пустельний', false, 2),
  ((SELECT id FROM inserted_question), 'Арктичний', false, 3),
  ((SELECT id FROM inserted_question), 'Гірський', true, 4);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після ремонту автомобіля в закритому приміщенні при працюючому двигуні у чоловіка з’явилися задишка, запаморочення, акроціаноз, частота дихання 24-26/хв. Газовий склад крові: pO2 - 60 мм рт.ст., pCO2 - 30 мм рт.ст.; у крові наявний карбоксигемоглобін. Про який вид гіпоксії можна думати?', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемічна', true, 0),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 2),
  ((SELECT id FROM inserted_question), 'Респіраторна', false, 3),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людей, які постійно проживають в гірській місцевості, адаптація до ''кисневого голодування'' здійснюється шляхом полегшеної віддачі кисню гемоглобіном внаслідок:', NULL, 'medium', 29, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення pH крові', false, 0),
  ((SELECT id FROM inserted_question), 'Зростання парціального тиску CO2', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження температури крові', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищеного утворення 2,3- дифосфогліцерату в еритроцитах', true, 3),
  ((SELECT id FROM inserted_question), 'Зниженого утворення 2,3- дифосфогліцерату в еритроцитах', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в анамнезі: з дитинства відмічався знижений рівень гемоглобіну. Лікування препаратами заліза не дає ефекту. У крові: ер.- 3,1 • 10^12/л, ретик.-16%, Hb- 85 г/л, КП0,75; в мазку крові анізоцити, пойкілоцити, мішенеподібні еритроцити, еритроцити з базофільною зернистістю, рівень заліза у сироватці 30 мкмоль/л. Для якої патології системи крові характерні такі дані?', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фолієводефіцитна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'B12-дефіцитна анемія', false, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Мати звернулася до лікаря з приводу того, що у дитини 5-ти років під дією сонячних променів на шкірі з’являються еритеми, везикулярний висип, свербіж шкіри. Лабораторні дослідження виявили зменшення вмісту заліза в сироватці крові, збільшення виділення з сечею уропорфіриногену І. Найбільш вірогідною спадковою патологією в дитини є:', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритропоетична порфірія', true, 0),
  ((SELECT id FROM inserted_question), 'Печінкова порфірія', false, 1),
  ((SELECT id FROM inserted_question), 'Копропорфірія', false, 2),
  ((SELECT id FROM inserted_question), 'Метгемоглобінемія', false, 3),
  ((SELECT id FROM inserted_question), 'Інтермітуюча порфірія', false, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт звернувся до лікаря зі скаргами на задишку, що виникала після фізичного навантаження. Клінічне обстеження виявило анемію та наявність парапротеїну в зоні гамма-глобулінів. Який показник у сечі необхідно визначити для підтвердження діагнозу мієломи?', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Білірубін', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Білок Бенс-Джонса', true, 2),
  ((SELECT id FROM inserted_question), 'Антитрипсин', false, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У районах Південної Африки у людей розповсюджена серпоподібноклітинна анемія, при якій еритроцити мають форму серпа внаслідок заміни в молекулі гемоглобіну амінокислоти глутаміну на валін. Чим викликана ця хвороба?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кросинговер', false, 0),
  ((SELECT id FROM inserted_question), 'Трансдукція', false, 1),
  ((SELECT id FROM inserted_question), 'Генна мутація', true, 2),
  ((SELECT id FROM inserted_question), 'Геномні мутації', false, 3),
  ((SELECT id FROM inserted_question), 'Порушення механізмів реалізації генетичної інформації', false, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки надійшла дитина 4-х років з ознаками тривалого білкового голодування: затримка росту, анемія, набряки, розумова відсталість. Причиною розвитку набряків у цієї дитини є зниження синтезу:', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікопротеїнів', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для запобігання віддалених результатів чотиридобової малярії пацієнту 42-х років призначили примахін. Вже на 3 добу від початку лікування терапевтичними дозами препарату в пацієнта з’явилися біль у животі та в ділянці серця, диспепсичні розлади, загальний ціаноз, гемоглобінурія. Що стало причиною розвитку побічної дії препарату?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сповільнення екскреції препарату з сечею', false, 0),
  ((SELECT id FROM inserted_question), 'Потенціювання дії іншими препаратами', false, 1),
  ((SELECT id FROM inserted_question), 'Кумуляція лікарського засобу', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження активності мікросомальних ферментів печінки', false, 3),
  ((SELECT id FROM inserted_question), 'Генетична недостатність глюкозо-6-фосфат-дегідрогенази', true, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Споживання пацієнтом протягом тривалого часу забруднених овочів та фруктів призвело до отруєння нітратами. Яке похідне гемоглобіну утворилося у крові даного хворого?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Hb-OH', true, 0),
  ((SELECT id FROM inserted_question), 'Hb NHCOOH', false, 1),
  ((SELECT id FROM inserted_question), 'Hb O2', false, 2),
  ((SELECT id FROM inserted_question), 'Hb СО', false, 3),
  ((SELECT id FROM inserted_question), 'Hb CN', false, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дослідження первинної структури молекули глобіну виявлено заміну глутамінової кислоти на валін. Для якої спадкової патології це характерно?', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хвороба Мінковського-Шоффара', false, 0),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіноз', false, 3),
  ((SELECT id FROM inserted_question), 'Таласемія', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У семирічної дитини встановлено діагноз: анемія. Під час лабораторного обстеження виявлено дефіцит піруваткінази в еритроцитах. Порушення якого процесу відіграє основну роль у розвитку анемії в цієї дитини?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Анаеробного глікогенолізу', false, 0),
  ((SELECT id FROM inserted_question), 'Дезамінування амінокислот', false, 1),
  ((SELECT id FROM inserted_question), 'Декарбоксилювання амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Анаеробного гліколізу', true, 3),
  ((SELECT id FROM inserted_question), 'Глюконеогенезу', false, 4);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з діагнозом: гемолітична анемія, виявлено дефіцит піруваткінази в еритроцитах. Яка причина розвитку гемолізу еритроцитів за цих умов?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення активності Na+, К+-АТФ-ази', true, 0),
  ((SELECT id FROM inserted_question), 'Надлишок К+ в еритроцитах', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит спектрину', false, 2),
  ((SELECT id FROM inserted_question), 'Генетичні дефекти глікофорину А', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача Na+ в еритроцитах', false, 4);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з гемолітичною анемією виявлено дефіцит піруваткінази в еритроцитах. За цих умов причиною розвитку гемолізу еритроцитів є:', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нестача Na+ в еритроцитах', false, 0),
  ((SELECT id FROM inserted_question), 'Генетичні дефекти глікофорину А', false, 1),
  ((SELECT id FROM inserted_question), 'Надлишок К + в еритроцитах', false, 2),
  ((SELECT id FROM inserted_question), 'Дефіцит спектрину', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення активності Na+, К+ -АТФ-ази', true, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 40-ка років було встановлено діагноз: серпоподібноклітинна анемія. Який механізм приводить до зменшення кількості еритроцитів в крові у цього хворого?', NULL, 'medium', 41, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Внутрішньосудинний гемоліз', false, 0),
  ((SELECT id FROM inserted_question), 'Позасудинний гемоліз', true, 1),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну B12 і фолієвої кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Нестача заліза в організмі', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача білка', false, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 50 років із загостренням хронічного гнійного середнього отиту лікувався сульфаніламідами протягом 3-х тижнів. На 20-й день лікування антибіотиками у нього з’явилися симптоми анемії. Аналіз сироватки крові виявив антитіла до еритроцитів. Укажіть основний механізм розвитку анемії в цьому разі.', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемоліз еритроцитів', true, 0),
  ((SELECT id FROM inserted_question), 'Дефіцит заліза', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічна крововтрата', false, 2),
  ((SELECT id FROM inserted_question), 'Пригнічення кровотворення', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоплазія кісткового мозку', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 50 років після отруєння грибами виникла гемолітична анемія. Де первинно відбуватиметься гемоліз еритроцитів у цьому разі?', NULL, 'medium', 43, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'У нирках', false, 0),
  ((SELECT id FROM inserted_question), 'У лімфоїдній тканині', false, 1),
  ((SELECT id FROM inserted_question), 'У печінці та селезінці', false, 2),
  ((SELECT id FROM inserted_question), 'У кістковому мозку', false, 3),
  ((SELECT id FROM inserted_question), 'У кровоносному руслі', true, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 40-ка років внаслідок посиленого гемолізу еритроцитів підвищився вміст заліза в плазмі крові. Який білок забезпечує його депонування в тканинах?', NULL, 'medium', 44, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Транскортин', false, 1),
  ((SELECT id FROM inserted_question), 'Феритин', true, 2),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 4);


-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 38 років після прийому аспірину і сульфаніламідів спостерігається посилений гемоліз еритроцитів, викликаний недостатністю глюкозо-6-фосфатдегідрогенази. Порушенням утворення якого коферменту зумовлена ця патологія?', NULL, 'medium', 45, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Убіхінон', false, 0),
  ((SELECT id FROM inserted_question), 'Піридоксальфосфат', false, 1),
  ((SELECT id FROM inserted_question), 'НАДФН', true, 2),
  ((SELECT id FROM inserted_question), 'ФМНН2', false, 3),
  ((SELECT id FROM inserted_question), 'ФАДН2', false, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Посттрансляційна модифікація вітамінозалежних факторів зсідання крові полягає у перетворенні залишку глутамінової кислоти в гамма-карбоксиглутаміназу. Укажіть необхідний для цього вітамін.', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'К', true, 0),
  ((SELECT id FROM inserted_question), 'D', false, 1),
  ((SELECT id FROM inserted_question), 'A', false, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта діагностовано гемофілію А. Дефіцит якого фактора зсідання крові є причиною цієї патології?', NULL, 'medium', 47, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'V, X', false, 0),
  ((SELECT id FROM inserted_question), 'IX', false, 1),
  ((SELECT id FROM inserted_question), 'XIІ', false, 2),
  ((SELECT id FROM inserted_question), 'VIІІ', true, 3),
  ((SELECT id FROM inserted_question), 'І, ІІ', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт скаржиться на часті кровотечі з ясен. Під час аналізу крові виявлено дефіцит ІІ фактора зсідання крові (протромбіну). Яка фаза зсідання крові насамперед порушена у людини?', NULL, 'medium', 48, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Утворення тромбіну', true, 0),
  ((SELECT id FROM inserted_question), 'Ретракція згустку', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення протромбінази', false, 2),
  ((SELECT id FROM inserted_question), 'Фібриноліз', false, 3),
  ((SELECT id FROM inserted_question), 'Утворення фібрину', false, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Лікар-гематолог призначив пацієнту з кровотечею коагулянт, який діє шляхом підвищення синтезу протромбіну та інших факторів зсідання крові переважно в печінці і є синтетичним водорозчинним вітаміном. Який препарат призначив лікар?', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин', false, 0),
  ((SELECT id FROM inserted_question), 'Менадіону натрію біосульфат', true, 1),
  ((SELECT id FROM inserted_question), 'Кальцію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Етамзилат', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбін', false, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини спостерігається геморагічний синдром, діагностована гемофілія В. Дефіцитом якого фактора зумовлене це захворювання?', NULL, 'medium', 50, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ІІ (протромбіну)', false, 0),
  ((SELECT id FROM inserted_question), 'ІХ (Крістмаса)', true, 1),
  ((SELECT id FROM inserted_question), 'ХІІ (Хагемана)', false, 2),
  ((SELECT id FROM inserted_question), 'ХІ (протромбопластину)', false, 3),
  ((SELECT id FROM inserted_question), 'ѴІ (антигемофільного глобуліну)', false, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 42 роки незначне пошкодження шкіри внаслідок побутової травми призвело до активації судинно-тромбоцитарного гемостазу, завдяки чому кровотеча зупинилася протягом п''яти хвилин. Який із нижченаведених факторів є ключовим на стадії адгезії тромбоцитів під час формування тромбоцитарного тромбу?', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фактор Флетчера (Прекалікреїн)', false, 0),
  ((SELECT id FROM inserted_question), 'Фактор Віллебранда', true, 1),
  ((SELECT id FROM inserted_question), 'Фактор Хагемана', false, 2),
  ((SELECT id FROM inserted_question), 'Лабільний фактор (Проакцелерин)', false, 3),
  ((SELECT id FROM inserted_question), 'Фактор Стюарта-Прауера', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У шестимісячної дитини спостерігалися часті та сильні підшкірні кровотечі. Призначення синтетичного аналога вітаміну К (вікасола) дало позитивний ефект. У γ-карбоксилюванні глутамінової кислоти якого з нижченаведених білків згортальної системи крові бере участь цей вітамін?', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Протромбіну', true, 0),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Фактора Розенталя', false, 2),
  ((SELECT id FROM inserted_question), 'Антигемофільного глобуліна А', false, 3),
  ((SELECT id FROM inserted_question), 'Фактора Хагемана', false, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Концентрації фібриногену', false, 0),
  ((SELECT id FROM inserted_question), 'Активованого часткового тромбопластинового часу (коректна відповідь)', false, 1),
  ((SELECT id FROM inserted_question), 'Міжнародного нормалізованого відношення', false, 2),
  ((SELECT id FROM inserted_question), 'ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Протромбінового часу', true, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обтураційній жовтяниці і жовчних норицях часто спостерігається протромбінова недостатність. З дефіцитом в організмі якого вітаміну це пов’язано?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'В6', false, 0),
  ((SELECT id FROM inserted_question), 'A', false, 1),
  ((SELECT id FROM inserted_question), 'E', false, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'K', true, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого, який знаходиться на лікуванні з приводу вірусного гепатиту В, з’явилися ознаки печінкової недостатності. Які зміни крові, що свідчать про порушення білкового обміну, найбільш вірогідно спостерігатимуться у цьому випадку?', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Абсолютна гіперальбумінемія', false, 0),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперфібриногенемія', false, 1),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперглобулінемія', false, 2),
  ((SELECT id FROM inserted_question), 'Білковий склад крові не змінений', false, 3),
  ((SELECT id FROM inserted_question), 'Абсолютна гіпоальбумінемія', true, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Периферичні набряки при цирозі печінки викликані переважним дефіцитом білка, частка якого порівняно з іншими білками крові переважає у створенні онкотичного тиску крові. Укажіть цей білок.', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альбуміну', true, 0),
  ((SELECT id FROM inserted_question), 'Протромбіну', false, 1),
  ((SELECT id FROM inserted_question), 'Гепарину', false, 2),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 3),
  ((SELECT id FROM inserted_question), 'Гобуліну', false, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 27 років після тривалого голодування спостерігається виникнення набряків. Укажіть найімовірнішу причину цього патологічного стану.', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації глобулінів', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищення онкотичного тиску крові внаслідок збільшення концентрації альбумінів', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення онкотичного тиску крові внаслідок збільшення концентрації фібриногену', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації альбумінів', true, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта швидко розвиваються набряки. Зниження кількості яких білків сироватки крові призводить до їх виникнення?', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 0),
  ((SELECT id FROM inserted_question), 'β-глобулінів', false, 1),
  ((SELECT id FROM inserted_question), 'α1-глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'α2-глобулінів', false, 3),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 4);


-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки надійшла дитина 4-х років з ознаками тривалого білкового голодування: затримка росту, анемія, набряки, розумова відсталість. Причиною розвитку набряків у цієї дитини є зниження синтезу:', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікопротеїнів', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з хронічною серцевою недостатністю розвинувся цироз печінки з асцитом і набряками нижніх кінцівок. Які зміни складу крові спричиняють асцит у цього пацієнта?', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпохолестеринемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпергаммаглобулінемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпопротромбінемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоальбумінемія', true, 3),
  ((SELECT id FROM inserted_question), 'Макроглобулінемія', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яке ускладення виникне у пацієнта з діагнозом цироз печінки і значним зниженням в сироватці крові вмісту альбуміну та глобуліну?', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Енцефалопатія', false, 0),
  ((SELECT id FROM inserted_question), 'Геморагічний синдром', false, 1),
  ((SELECT id FROM inserted_question), 'Набряки', true, 2),
  ((SELECT id FROM inserted_question), 'Анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Аміноацидурія', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При тривалому лікуванні голодуванням у пацієнта зменшилось співвідношення альбумінів і глобулінів в плазмі. Що з наведеного буде наслідком цих змін?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення гематокриту', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження гематокриту', false, 1),
  ((SELECT id FROM inserted_question), 'Гіперкоагуляція', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення ШОЕ', true, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 34 роки звернувся до лікаря-стоматолога із приводу зубного болю. Після видалення декількох зубів почалася кровотеча, що тривала понад 15 хвилин. Із анамнезу відомо: у пацієнта хронічний гепатит С. Яка ймовірна причина продовження кровотечі?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження вмісту фібриногену в крові', true, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження вмісту альбумінів у крові', false, 3),
  ((SELECT id FROM inserted_question), '-', false, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка віком 60 років, який хворий на хронічний гепатит, часто спостерігаються кровотечі з носа і ясен, спонтанно з''являються геморагічні висипання на шкірі і слизових оболонках. Що є причиною виникнення цих явищ?', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення вмісту амінотрансфераз', false, 0),
  ((SELECT id FROM inserted_question), 'Поява в крові макроглобулінів і кріоглобулінів', false, 1),
  ((SELECT id FROM inserted_question), 'Зменшення синтезу протромбіну і фібриногену', true, 2),
  ((SELECT id FROM inserted_question), 'Зменшення утворення сироваткових альбумінів', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення в крові рівня холінестерази', false, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для дослідження білків сироватки крові застосовують різні фізичні та фізико-хімічні методи. За допомогою якого методу можна розділити альбуміни і глобуліни сироватки крові?', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електрофорезу', true, 0),
  ((SELECT id FROM inserted_question), 'Діалізу', false, 1),
  ((SELECT id FROM inserted_question), 'Рефрактометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Полярографії', false, 3),
  ((SELECT id FROM inserted_question), 'Спектрофотометрії', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Електрофоретичне дослідження сироватки крові хворого пневмонією показало збільшення одної з білкових фракцій. Вкажіть її:', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'β-глобуліни', false, 0),
  ((SELECT id FROM inserted_question), 'α1 -глобуліни', false, 1),
  ((SELECT id FROM inserted_question), 'γ-глобуліни', true, 2),
  ((SELECT id FROM inserted_question), 'α2 -глобуліни', false, 3),
  ((SELECT id FROM inserted_question), 'Альбуміни', false, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 58-ми років хворіє на атеросклероз судин головного мозку. При обстеженні виявлена гіперліпідемія. Вміст якого класу ліпопротеїдів у сироватці крові даного чоловіка найбільш вірогідно буде підвищений?', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ліпопротеїди низької щільності', true, 0),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 1),
  ((SELECT id FROM inserted_question), 'Комплекси жирних кислот з альбумінами', false, 2),
  ((SELECT id FROM inserted_question), 'Холестерин', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїди високої щільності', false, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові хворого виявлено низький рівень альбумінів та фібриногену. Зниження активності яких органел гепатоцитів найбільш вірогідно обумовлює це явище?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Агранулярна ендоплазматична сітка', false, 0),
  ((SELECT id FROM inserted_question), 'Комплекс Гольджі', false, 1),
  ((SELECT id FROM inserted_question), 'Лізосоми', false, 2),
  ((SELECT id FROM inserted_question), 'Гранулярна ендоплазматична сітка', true, 3),
  ((SELECT id FROM inserted_question), 'Мітохондрії', false, 4);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 58 років клінічна картина гострого панкреатиту. Підвищення в сечі якої з нижчеперерахованих речовин буде підтвердженням діагнозу?', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сечовина', false, 0),
  ((SELECT id FROM inserted_question), 'Амілаза', true, 1),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 2),
  ((SELECT id FROM inserted_question), 'Залишковий азот', false, 3),
  ((SELECT id FROM inserted_question), 'Сечова кислота', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки напередодні пологів ШОЕ 40 мм / год. Така величина ШОЕ обумовлена тим, що в крові підвищений вміст:', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритроцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриногену', true, 1),
  ((SELECT id FROM inserted_question), 'Альбумінів', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 3),
  ((SELECT id FROM inserted_question), 'Білків', false, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При активації запального процесу, деяких аутоімунних та інфекційних захворюваннях у плазмі крові різко зростає рівень білків гострої фази. Який із наведених нижче білків здатний утворювати гель при охолодженні сироватки?', NULL, 'medium', 71, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', false, 1),
  ((SELECT id FROM inserted_question), 'а2-макроглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Кріоглобулін', true, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 49-ти років на гострий панкреатит виникала загроза некрозу підшлункової залози, що супроводжувалось надходженням у кров і тканини активних панкреатичних протеїназ і розщеплення тканинних білків. Які захисні фактори організму можуть інгібувати ці процеси?', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'α2-макроглобулін, α1 –антитрипсин', true, 0),
  ((SELECT id FROM inserted_question), 'Імуноглобуліни', false, 1),
  ((SELECT id FROM inserted_question), 'Кріоглобулін, інтерферон', false, 2),
  ((SELECT id FROM inserted_question), 'Церулоплазмін, трансферин', false, 3),
  ((SELECT id FROM inserted_question), 'Гемоплексин, гаптоглобін', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У плазмі крові здорової людини знаходиться декілька десятків білків. При захворюванні організму з’являються нові білки, зокрема "білок гострої фази". Таким білком є:', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Протромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 1),
  ((SELECT id FROM inserted_question), 'Імуноглобулін G', false, 2),
  ((SELECT id FROM inserted_question), 'Імуноглобулін А', false, 3),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', true, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При хворобі Вільсона-Коновалова порушується транспорт міді, що призводить до накопичення цього металу в клітинах мозку та печінки. З порушенням синтезу якого білку це пов’язано?', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Транскобаламін', false, 0),
  ((SELECT id FROM inserted_question), 'Металотіонеїн', false, 1),
  ((SELECT id FROM inserted_question), 'Сидерофілін', false, 2),
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін', true, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 27 років виявлені патологічні зміни печінки і головного мозку. У плазмі крові виявлено різке зниження, а в сечі збільшення вмісту міді. Поставлено діагноз - хвороба Вільсона. Активність якого ферменту в сироватці крові необхідно дослідити для підтвердження діагнозу?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Церулоплазміну', true, 0),
  ((SELECT id FROM inserted_question), 'Алкогольдегідрогенази', false, 1),
  ((SELECT id FROM inserted_question), 'Карбоангідрази', false, 2),
  ((SELECT id FROM inserted_question), 'Ксантиноксидази', false, 3),
  ((SELECT id FROM inserted_question), 'Лейцинамінопептидази', false, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка віком 35 років зі встановленим діагнозом: гепатоцеребральна дистрофія в сироватці крові знижений вміст церулоплазміну. Накопичення якого елемента в печінці, мозку та нирках спостерігається в пацієнта?', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', false, 0),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Міді', true, 3),
  ((SELECT id FROM inserted_question), 'Заліза', false, 4);


-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людини трапляється спадкова хвороба, симптомокомплекс якої поєднує в собі цироз печінки та дистрофічні процеси головного мозку. Вона супроводжується зменшенням вмісту церулоплазміну в плазмі крові та порушенням обміну міді в організмі. Це хвороба:', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жильбера', false, 0),
  ((SELECT id FROM inserted_question), 'Вільсона-Коновалова', true, 1),
  ((SELECT id FROM inserted_question), 'Тея-Сакса', false, 2),
  ((SELECT id FROM inserted_question), 'Марфана', false, 3),
  ((SELECT id FROM inserted_question), 'Німанна-Піка', false, 4);


-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для розвитку гарячкових станів характерним є зростання рівня білків "гострої фази" - церулоплазміну, фібриногену, С-реактивного протеїну. Укажіть можливий механізм цього явища:', NULL, 'medium', 78, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стимулювальний вплив ІЛ-1 на гепатоцити', true, 0),
  ((SELECT id FROM inserted_question), 'Руйнівна дія підвищеної температури на клітини організму', false, 1),
  ((SELECT id FROM inserted_question), 'Дегрануляція тканинних базофілів', false, 2),
  ((SELECT id FROM inserted_question), '-', false, 3),
  ((SELECT id FROM inserted_question), 'Проліферативна дія ІЛ-2 на Т-лімфоцити', false, 4);


-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Біохімічний аналіз сироватки крові пацієнта з гепатолентикулярною дегенерацією (хвороба Вільсона-Коновалова) виявив зниження вмісту церулоплазміну. У цього пацієнта в сироватці крові буде підвищена концентрація таких іонів:', NULL, 'medium', 79, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калій', false, 0),
  ((SELECT id FROM inserted_question), 'Мідь', true, 1),
  ((SELECT id FROM inserted_question), 'Кальцій', false, 2),
  ((SELECT id FROM inserted_question), 'Натрій', false, 3),
  ((SELECT id FROM inserted_question), 'Фосфор', false, 4);


-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка 33 років страждає на гепатоцеребральну дистрофію (хвороба Вільсона). У крові - знижений вміст церулоплазміну. У сечі - різко підвищений вміст амінокислот. Посиленням якого процесу зумовлені ці зміни?', NULL, 'medium', 80, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексоутворення амінокислот з міддю', true, 0),
  ((SELECT id FROM inserted_question), 'Розпад тканинних 6ілків', false, 1),
  ((SELECT id FROM inserted_question), 'Переамінування амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Синтез сечовини', false, 3),
  ((SELECT id FROM inserted_question), 'Глюконеогенез', false, 4);


-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта 28-ми років, який знаходиться в пульмонологічному відділенні, діагностовано емфізему легенів, яка виникла внаслідок розщеплення міжальвеолярних перетинок тканинним трипсином. Уроджена недостатність якого білка спричинила розвиток захворювання?', NULL, 'medium', 81, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 1),
  ((SELECT id FROM inserted_question), 'а2-макроглобулін', false, 2),
  ((SELECT id FROM inserted_question), 'аі-протеїназний інгібітор', true, 3),
  ((SELECT id FROM inserted_question), 'Кріоглобулін', false, 4);


-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 38-ми років ревматизм в активній фазі. Визначення якого лабораторного показника сироватки крові має діагностичне значення при даній патології?', NULL, 'medium', 82, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сечовина', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', true, 1),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 2),
  ((SELECT id FROM inserted_question), 'Креатинін', false, 3),
  ((SELECT id FROM inserted_question), 'Сечова кислота', false, 4);


-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У плазмі крові здорової людини знаходиться декілька десятків білків. При захворюванні організму з’являються нові білки, зокрема "білок гострої фази". Таким білком є:', NULL, 'medium', 83, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Протромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 1),
  ((SELECT id FROM inserted_question), 'Імуноглобулін G', false, 2),
  ((SELECT id FROM inserted_question), 'Імуноглобулін А', false, 3),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', true, 4);


-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнтка віком 45 років скаржиться на біль у дрібних суглобах кистей, що посилюється вранці, набряклість суглобів, ранкову скутість. Лабораторно виявлено ревматоїдний фактор та С-реактивний білок. Під час біопсії ураженої синовіальної оболонки виявлено: розростання ворсин, руйнування хряща: судинна гіперемія, лімфоплазмоцитарна інфільтрація, утворення панусу, що пошкоджує хрящ і субхондральну кістку. Який найімовірніший діагноз?', NULL, 'medium', 84, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Подагричний артрит', false, 0),
  ((SELECT id FROM inserted_question), 'Ревматоїдний артрит', true, 1),
  ((SELECT id FROM inserted_question), 'Септичний артрит', false, 2),
  ((SELECT id FROM inserted_question), 'Остеоартроз', false, 3),
  ((SELECT id FROM inserted_question), 'Реактивний артрит', false, 4);


-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У півторарічної дитини діагностовано імунодефіцит. Встановлено, що кількість В-лімфоцитів у нормі, але вони функціонально неактивні. Який фактор захисту ротової порожнини буде відсутній у цієї дитини?', NULL, 'medium', 85, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фібронектин', false, 0),
  ((SELECT id FROM inserted_question), 'Лактозо-пероксидазна система', false, 1),
  ((SELECT id FROM inserted_question), 'Секреторний імуноглобулін А', true, 2),
  ((SELECT id FROM inserted_question), 'Інтерферон', false, 3),
  ((SELECT id FROM inserted_question), 'Лізоцим', false, 4);


-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У забезпеченні імунного захисту новонароджених важливу роль відіграють імуноглобуліни матері, які проходять через плацентарний бар’єр у кров плода. Який це тип імуноглобулінв?', NULL, 'medium', 86, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgG', true, 1),
  ((SELECT id FROM inserted_question), 'IgM', false, 2),
  ((SELECT id FROM inserted_question), 'IgD', false, 3),
  ((SELECT id FROM inserted_question), 'IgE', false, 4);


-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Коли чужорідний агент потрапляє в організм, синтез двох класів імуноглобулінів починається майже паралельно, але в одного з них зростання і падіння кількості концентрації відбувається швидше. Які це два класи імуноглобулінів?', NULL, 'medium', 87, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG і IgD', false, 0),
  ((SELECT id FROM inserted_question), 'IgA і IgD', false, 1),
  ((SELECT id FROM inserted_question), 'IgM і IgD', false, 2),
  ((SELECT id FROM inserted_question), 'IgA і IgG', false, 3),
  ((SELECT id FROM inserted_question), 'IgM і IgG', true, 4);


-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Профілактичні щеплення проти поліомієліту провели інактивованою вакциною, яку вводили парентерально. Які імуноглобуліни відповідають у цьому випадку за створення поствакцинального імунітету?', NULL, 'medium', 88, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сироваткові Ig А, Ig M', false, 0),
  ((SELECT id FROM inserted_question), 'Ig M, Ig G', true, 1),
  ((SELECT id FROM inserted_question), 'Ig Е, Ig M', false, 2),
  ((SELECT id FROM inserted_question), 'Ig M, секреторні Ig A', false, 3),
  ((SELECT id FROM inserted_question), 'Ig G, секреторні Ig A', false, 4);


-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки діагностовано гострий період захворювання на ГРВІ. Імуноглобуліни якого класу, ймовірно, будуть присутні в крові пацієнтки?', NULL, 'medium', 89, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgG', false, 1),
  ((SELECT id FROM inserted_question), 'IgE', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', true, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 90, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgM', false, 1),
  ((SELECT id FROM inserted_question), 'IgD', false, 2),
  ((SELECT id FROM inserted_question), 'IgG', true, 3),
  ((SELECT id FROM inserted_question), 'IgE', false, 4);


-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 27-ми років закрапала в очі краплі, до складу яких входить пеніцилін. Через декілька хвилин з’явився свербіж та печіння тіла, набряк губ та повік, свистячий кашель; став падати артеріальний тиск. Які імуноглобуліни беруть участь в розвитку даної алергічної реакції?', NULL, 'medium', 91, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG та IgD', false, 0),
  ((SELECT id FROM inserted_question), 'IgA та IgM', false, 1),
  ((SELECT id FROM inserted_question), 'IgE та IgG', true, 2),
  ((SELECT id FROM inserted_question), 'IgM та IgD', false, 3),
  ((SELECT id FROM inserted_question), 'IgM та IgG', false, 4);


-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Спадкова гіперліпопротеїнемія І типу обумовлена недостатністю ліпопротеїнліпази. Підвищення рівня яких транспортних форм ліпідів в плазмі навіть натщесерце є характерним?', NULL, 'medium', 92, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ліпопротеїни високої густини', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпопротеїни низької густини', false, 1),
  ((SELECT id FROM inserted_question), 'Хіломікрони', true, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїни дуже низької густини', false, 3),
  ((SELECT id FROM inserted_question), 'Модифіковані ліпопротеїни', false, 4);


-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини діагностовано хворобу Танжера. Укажіть сполуку відсутність якої у сироватці крові дозволила встановити такий діагноз.', NULL, 'medium', 93, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ЛПВЩ', true, 0),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 1),
  ((SELECT id FROM inserted_question), 'ЛПНЩ', false, 2),
  ((SELECT id FROM inserted_question), 'ЛПДНЩ', false, 3),
  ((SELECT id FROM inserted_question), 'ЛППЩ', false, 4);


-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта сироватка крові має молочий вигляд. Під час біохімічного досліджения виявлено високий рівень триацилгліцеролів і хіломікронів. Спадковий дефект якого ферменту викликає цей стан?', NULL, 'medium', 94, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тканинної гормон-чутливої Ліпази', false, 0),
  ((SELECT id FROM inserted_question), 'Панкреатичної ліпази', false, 1),
  ((SELECT id FROM inserted_question), 'Фосфоліпази', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфодіестрази', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнліпази', true, 4);


-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого хлопчика 12-ти років вміст холестерину в сироватці крові до 25 ммоль/л. В анамнезі - спадкова сімейна гіперхолестеринемія, причиною якої є порушення синтезу білків-рецепторів до:', NULL, 'medium', 95, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів високої щільності', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів низької щільності', true, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів проміжної щільності', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів дуже низької щільності', false, 4);


-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 58 років є ознаки атеросклеротичного ураження серцево-судинної системи. Збільшення якого з наведених показників біохімічного аналізу крові найхарактерніше для цього стану:', NULL, 'medium', 96, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рівня ЛПВЩ', false, 0),
  ((SELECT id FROM inserted_question), 'Активності сукципатдегідрогенази', false, 1),
  ((SELECT id FROM inserted_question), 'Рівня ЛПНЩ', true, 2),
  ((SELECT id FROM inserted_question), 'Активності аланінамінотрансферази', false, 3),
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 4);


-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?', NULL, 'medium', 97, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Високої щільності', false, 0),
  ((SELECT id FROM inserted_question), 'Холестерину', false, 1),
  ((SELECT id FROM inserted_question), 'Проміжної щільності', false, 2),
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 3),
  ((SELECT id FROM inserted_question), 'Низької щільності', true, 4);


-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обстеження підлітка, що страждає на ксантоматоз, виявлена сімейна гіперхолестеринемія. Концентрація яких ліпопротеїнів значно підвищена в крові при цій патології?', NULL, 'medium', 98, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ЛПВЩ', false, 0),
  ((SELECT id FROM inserted_question), 'ЛПНЩ', true, 1),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 2),
  ((SELECT id FROM inserted_question), 'ЛПДНЩ', false, 3),
  ((SELECT id FROM inserted_question), 'НЕЖК', false, 4);


-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 30 років діагностовано ішемічна хвороба серця. Напади стенокардії турбують вже 3 роки. Виявлено спадковий характер захворювання. Який вид гіперліпопротеїдемії найбільш ймовірно буде виявлено у хворого?', NULL, 'medium', 99, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'V (гіперпребеталіпопротеїдемія і гіперхіломікронемія).', false, 0),
  ((SELECT id FROM inserted_question), 'I (гіперхіломікронемія)', false, 1),
  ((SELECT id FROM inserted_question), 'III (дисбеталіпопротеідемія)', false, 2),
  ((SELECT id FROM inserted_question), 'IV (гіперпребеталіпопротеїдемія)', false, 3),
  ((SELECT id FROM inserted_question), 'II (гіпербеталіпопротеїдемія)', true, 4);


-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 67-ми років вживає з їжею переважно яйця, сало, вершкове масло, молоко, м’ясо. У крові виявлено холестерин 12,3 ммоль/л, загальні ліпіди - 8,2 г/л, підвищені фракції ліпопротеїнів низької щільності (ЛПНЩ). Яка гіпер-ліпопротеїнемія спостерігається у хворого?', NULL, 'medium', 100, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія IV типу', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія І типу', false, 1),
  ((SELECT id FROM inserted_question), 'Холестерин, гіперліпопротеїнемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія ІІа типу', true, 3),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія IIb типу', false, 4);


-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У патогенезі розвитку II типу гіперліпопротеїнемії (сімейна гіперхолестеролемія) провідну роль відіграє дефіцит рецепторів до апобілка ЛПНЩ. Назвіть його:', NULL, 'medium', 101, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Біохімія крові'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апо В48', false, 0),
  ((SELECT id FROM inserted_question), 'Апо ВСІ', false, 1),
  ((SELECT id FROM inserted_question), 'Апо СІІ', false, 2),
  ((SELECT id FROM inserted_question), 'Апо В100', true, 3),
  ((SELECT id FROM inserted_question), 'Апо А1', false, 4);


-- Вирівняти order_index: норма=0, біохімія=1, патологія=2
UPDATE topics t
SET order_index = 0, updated_at = NOW()
FROM courses c
WHERE c.id = t.course_id AND c.title = 'Система кровотворення й імунного захисту, кров'
  AND t.title = 'Нормальний розвиток і структура, вікові зміни';

UPDATE topics t
SET order_index = 1, updated_at = NOW()
FROM courses c
WHERE c.id = t.course_id AND c.title = 'Система кровотворення й імунного захисту, кров'
  AND t.title = 'Біохімія крові';

UPDATE topics t
SET order_index = 2, updated_at = NOW()
FROM courses c
WHERE c.id = t.course_id AND c.title = 'Система кровотворення й імунного захисту, кров'
  AND t.title = 'Патологічні процеси';

COMMIT;
