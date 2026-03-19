BEGIN;

-- Переконатися, що курс і тема існують (якщо ще не створені)
INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)
SELECT 'Система кровотворення й імунного захисту, кров', 'Автоматично імпортований курс', 'medical', 2, true, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Система кровотворення й імунного захисту, кров');

INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
SELECT c.id, 'Нормальний розвиток і структура, вікові зміни', 'Автоматично імпортована тема', 0, true, NOW(), NOW()
FROM courses c
WHERE c.title = 'Система кровотворення й імунного захисту, кров'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Нормальний розвиток і структура, вікові зміни');

-- Видалити старі питання теми Нормальний розвиток і структура, вікові зміни

DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
);

DELETE FROM questions
WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
);

-- Вставляємо питання з документа

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час пожежі людина отруїлася чадним газом. Які зміни у крові при цьому відбулися?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розвинувся ацидоз', false, 0),
  ((SELECT id FROM inserted_question), 'Утворення редукованого гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення карбоксигемоглобіну', true, 2),
  ((SELECT id FROM inserted_question), 'Утворення метгемоглобіну', false, 3),
  ((SELECT id FROM inserted_question), 'Утворення карбгемоглобіну', false, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У батьків, хворих на гемоглобінопатію (аутосомно-домінантний тип успадкування), народилася здорова дівчинка. Які генотипи батьків?', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'У обох батьків ген гемоглобінопатії відсутній', false, 0),
  ((SELECT id FROM inserted_question), 'Мати гетерозиготна за геном гемоглобінопатії, у батька цей ген відсутній', false, 1),
  ((SELECT id FROM inserted_question), 'Обоє гетерозиготні за геном гемоглобінопатії', true, 2),
  ((SELECT id FROM inserted_question), 'Обоє гомозиготні за геном гемоглобінопатії', false, 3),
  ((SELECT id FROM inserted_question), 'Батько гетерозиготний за геном гемоглобінопатії, у матері цей ген відсутній', false, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Що відображає колірний показник крові?', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Загальну кількість лейкоцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Концентранію фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Співвідношення сироватки крові до плазми', false, 2),
  ((SELECT id FROM inserted_question), 'Співвідношення формених елементів крові до плазми', false, 3),
  ((SELECT id FROM inserted_question), 'Співвідношення концентрації гемоглобіну до загальної кількості еритроцитів', true, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта відзначено підвищену чутливість до світла, ураження відкритих ділянок шкіри, неврологічний біль. У сечі спостерігається неспецифічне виведення порфіринів. Це захворювання належить до групи порфірій і є наслідком порушення:', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Розпаду гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Засвоєння вітаміну РР', false, 1),
  ((SELECT id FROM inserted_question), 'Синтезу гемоглобіну', true, 2),
  ((SELECT id FROM inserted_question), 'Утворення уробіліну', false, 3),
  ((SELECT id FROM inserted_question), 'Засвоєння рибофлавіну', false, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина хворіє на цукровий діабет, що супроводжується гіперглікемією натще понад 7,2 ммоль/л. Рівень якого білка плазми крові дозволяє ретроспективно (за попередні 4-8 тижні до обстеження) оцінити рівень глікемії?', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', false, 1),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 2),
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час адаптації до перебування в горах, в еритроцитах зростає синтез 2,3-дифосфогліцерату. Що стимулює ця речовина в організмі людини?', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Утворення оксигемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Дисоціацію оксигемоглобіну', true, 1),
  ((SELECT id FROM inserted_question), 'Утворення карбгемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинне дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Окисне фосфорилювання', false, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час клінічного та біохімічного обстеження пацієнта виявлено серповидноклітинну анемію. Визначення якого компонента крові було вирішальним для встановлення діагнозу?', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метгемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну F', false, 1),
  ((SELECT id FROM inserted_question), 'Гемоглобіну S', true, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіну A1', false, 3),
  ((SELECT id FROM inserted_question), 'Гемоглобіну С', false, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта шпиталізовано до реанімаційного відділення з підозрою на отруєння чадним газом. Яке похідне гемоглобіну буде виявлено під час спектрального аналізу?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Дезоксигемоглобін', false, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При дії окислювачів (перекис водню, оксиди азоту та інші), гемоглобін, до складу якого входить Fе2+, перетворюється на сполуку, що містить FеЗ+. Ця сполука не здатна переносити кисень і має назву?', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', true, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт тривалий час застосовував великі дози сульфаніламідних препаратів. Нещодавно в нього з''явилися: значна задишка в спокої, слабкість, втрата апетиту, порушення сну. Лабораторне дослідження крові виявило наявність в крові метгемоглобіну. Який механізм інактивації гемоглобіну в еритроцитах відбувається в пацієнта?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сполучення гемоглобіну з сульфаніламідами', false, 0),
  ((SELECT id FROM inserted_question), 'Блокада окисних ферментних систем', false, 1),
  ((SELECT id FROM inserted_question), 'Пошкодження білка в гемоглобіні', false, 2),
  ((SELECT id FROM inserted_question), 'Блокада відновних ферментних систем', false, 3),
  ((SELECT id FROM inserted_question), 'Окислення заліза в гемоглобіні', true, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Швидка допомога доставила до лікарні непритомного водія, який проспав у кабіні автомобіля з увімкненим двигуном протягом тривалого часу. Під час огляду шкірні покриви яскраво червоного кольору. Яка причина непритомності?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Накопичення відновленого гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Накопичення метгемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Накопичення вуглекислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Накопичення карбоксигемоглобіну', true, 3),
  ((SELECT id FROM inserted_question), 'Накопичення карбгемоглобіну', false, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після ремонту автомобілю в гаражному приміщенні водій потрапив до лікарні з симптомами отруєння вихлопними газами. Вміст якої речовини у крові буде підвищено?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Оксигемоглобін', false, 1),
  ((SELECT id FROM inserted_question), 'Метгемоглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Карбоксигемоглобін', true, 3),
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В приймальне відділення доставлена дитина 1,5 років з ознаками отруєння нітратами: стійкий ціаноз, задишка, судоми. Який патогенетичний механізм лежить в основі цих симптомів?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
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
  SELECT t.id, 'Людина довгий час проживала в умовах високогір’я. Які зміни в кровоносній системі будуть у неї?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення діаметра кровоносних судин', false, 0),
  ((SELECT id FROM inserted_question), 'Збільшення кількості гемоглобіну', true, 1),
  ((SELECT id FROM inserted_question), 'Збільшення кількості лейкоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Вповільнення пульсу', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження кількості лейкоцитів', false, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина знепритомніла у салоні автомобіля, де тривалий час очікувала приятеля при ввімкненому двигуні. В крові у неї знайдено сполуку гемоглобіну. Яку саме?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
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
  SELECT t.id, 'Щоденно в організмі людини 0,5% всього гемоглобіну перетворюється на метгемоглобін. Який фермент, що міститься в еритроцитах, каталізує відновлення метгемоглобіну до гемоглобіну?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метгемоглобінтрансфераза', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоксигеназа', false, 1),
  ((SELECT id FROM inserted_question), 'Глюкуронілтрансфераза', false, 2),
  ((SELECT id FROM inserted_question), 'Метгемоглобінредуктаза', true, 3),
  ((SELECT id FROM inserted_question), 'Білівердинредуктаза', false, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина хворіє на цукровий діабет, що супроводжується гіперглікемією натще понад 7,2 ммоль/л. Рівень якого білка плазми крові дозволяє ретроспективно (за попередні 4-8 тижні до обстеження) оцінити рівень глікемії?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', false, 1),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 2),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 3),
  ((SELECT id FROM inserted_question), 'Глікозильований гемоглобін', true, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарки звернувся чоловік віком 25 років із жовтяницею, загальною слабкістю та темною сечею, які з’явилися через кілька годин після вживання страви з бобів. В анамнезі: епізоди гемолітичних кризів після прийому деяких ліків. Під час лабораторного дослідження виявлено: знижений рівень гемоглобіну, підвищений уміст непрямого білірубіну та наявність гемоглобіну в сечі. Дефіцит якого ферменту спричинив цей стан?', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 0),
  ((SELECT id FROM inserted_question), 'Піруваткінази', false, 1),
  ((SELECT id FROM inserted_question), 'Каталази', false, 2),
  ((SELECT id FROM inserted_question), 'Феррокелатази', false, 3),
  ((SELECT id FROM inserted_question), 'Супероксиддисмутази', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Проведене медичне обстеження населення високогірного селища. Який показник характерний для цього адаптивного екологічного типу людей?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення концентрації холестерину в крові', false, 0),
  ((SELECT id FROM inserted_question), 'Підсилення потовиділення', false, 1),
  ((SELECT id FROM inserted_question), 'Зростання кисневої ємності крові', true, 2),
  ((SELECT id FROM inserted_question), 'Зниження показників основного обміну', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення рівня гемоглобіну', false, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина постійно живе високо в горах. Яку зміну показників крові можна виявити в неї?', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження кількості ретикулоцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження показників вмісту гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', true, 2),
  ((SELECT id FROM inserted_question), 'Зменшення колірного показника', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенію', false, 4);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий з пухлиною товстої кишки скаржиться на біль в животі, випорожнення з домішками крові, загальну слабкість. В крові: гемоглобін - 97 ммоль/л, еритроцити - 2,8-10^12/л, КП- 0,66, мікроцитоз, пойкілоцитоз, помірна кількість поліхроматофільних еритроцитів. Який вид анемії у хворого?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мегалобластична', false, 0),
  ((SELECT id FROM inserted_question), 'Арегенераторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпохромна', true, 2),
  ((SELECT id FROM inserted_question), 'Гіперрегенераторна', false, 3),
  ((SELECT id FROM inserted_question), 'Гіперхромна', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 45-ти років відсутні симптоми діабету, але натще визначається підвищений вміст глюкози в крові (7,2 ммоль/л). Наступним тестом має бути визначення:', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Толерантності до глюкози', true, 0),
  ((SELECT id FROM inserted_question), 'Залишкового азоту в крові', false, 1),
  ((SELECT id FROM inserted_question), 'Гліколізованого гемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Сечовини в крові', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкози у сечі', false, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Новонароджений хлопчик від 24-річної породіллі, що народжувала перший раз, мав жовтяницю на 8 годину життя. Група крові новонародженого А+, група крові матері 0+. Лабораторні дані виявили підвищений титр материнських анти-А антитіл, нормальний еритроцитарний глюкозо-6-фосфат і негативний тест на серпоподібні клітини. Гемоглобін новонародженого був 106 г/л. Яка з перерахованих причин є причиною жовтяниці?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дефіцит глюкозо-6-фосфатдегідрогенази', false, 0),
  ((SELECT id FROM inserted_question), 'Резус-конфлікт (закодовано на ЦТ)', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпербілірубінемія (коректна відповідь)', true, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна хвороба', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження рівню гемоглобіну', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дівчина віком 15 років скаржиться на швидку втомлюваність, слабкість, прискорене серцебиття. В аналізі крові виявлено: еритроцити - 2, 5 • 10^12/л, гемоглобін - 50 г/л, КП - 0,6, анізоцитоз зі схильністю до мікроцитозу. Вміст заліза в сироватці крові становив 5,4 ммоль. Яка гематологічна патологія спостерігається у пацієнтки?', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', true, 0),
  ((SELECT id FROM inserted_question), 'Набутий абсолютний еритроцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін В12-дефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові пацієнта спостерігається зниження кількості еритроцитів, гемоглобіну, кольорового показника, концентрації сироваткового заліза, мікроанізоцитоз і пойкілоцитоз. Ці зміни супроводжуються розвитком гіпоксії. Який вид гіпоксії спостерігається в цьому разі?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихальна', false, 0),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 3),
  ((SELECT id FROM inserted_question), 'Гемічна', true, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка під час обстеження в клініці виявлено різке зниження показників гемоглобіну. Яка функція крові порушується?', NULL, 'medium', 26, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Трофічна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', true, 1),
  ((SELECT id FROM inserted_question), 'Гомеостатична', false, 2),
  ((SELECT id FROM inserted_question), 'Гуморальна', false, 3);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Гемоглобін дорослої людини (HbA1) - білок-тетрамер, який складається з двох альфа- та двох бета-пептидних ланцюгів. Яку назву має така структура цього білка?', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вторинна', false, 0),
  ((SELECT id FROM inserted_question), 'Первинна', false, 1),
  ((SELECT id FROM inserted_question), 'Третинна', false, 2),
  ((SELECT id FROM inserted_question), 'Четвертинна', true, 3);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До відділення реанімації доставлено пацієнта, у крові якого виявлено високий вміст сульфгемоглобіну. Який тип гіпоксії наявний у цьому разі?', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторний тип', false, 0),
  ((SELECT id FROM inserted_question), 'Екзогенний тип', false, 1),
  ((SELECT id FROM inserted_question), 'Респіраторний тип', false, 2),
  ((SELECT id FROM inserted_question), 'Гемічний тип', true, 3),
  ((SELECT id FROM inserted_question), 'Тканинний тип', false, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту віком 57 років після обстеження встановлено діагноз: В12-дефіцитна анемія. За 3 доби після призначеного лікування зроблено контрольний аналіз крові. Який критерій укаже на підвищення еритропоезу?', NULL, 'medium', 29, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення рівня гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження кольорового показника', false, 1),
  ((SELECT id FROM inserted_question), 'Півищення кількості тромбоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення кількості ретикулоцитів', true, 3),
  ((SELECT id FROM inserted_question), 'Підвищення кількості лейкоцитів', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унаслідок тривалого перебування людини в горах на висоті 3000 м над рівнем моря у неї збільшилася киснева ємність крові. Посилене утворення в організмі яких речовин є безпосередньою причиною цього?', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2,3-дифосфогліцерату', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопоетинів', false, 1),
  ((SELECT id FROM inserted_question), 'Еритропоетинів', true, 2),
  ((SELECT id FROM inserted_question), 'Катехоламінів', false, 3),
  ((SELECT id FROM inserted_question), 'Карбгемоглобіну', false, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Проведене медичне обстеження населення високогірного селища. Який показник характерний для цього адаптивного екологічного типу людей?', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення концентрації холестерину в крові', false, 0),
  ((SELECT id FROM inserted_question), 'Підсилення потовиділення', false, 1),
  ((SELECT id FROM inserted_question), 'Зростання кисневої ємності крові', true, 2),
  ((SELECT id FROM inserted_question), 'Зниження показників основного обміну', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення рівня гемоглобіну', false, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий з пухлиною товстої кишки скаржиться на біль в животі, випорожнення з домішками крові, загальну слабкість. В крові: гемоглобін - 97 ммоль/л, еритроцити - 2,8-10^12/л, КП- 0,66, мікроцитоз, пойкілоцитоз, помірна кількість поліхроматофільних еритроцитів. Який вид анемії у хворого?', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мегалобластична', false, 0),
  ((SELECT id FROM inserted_question), 'Арегенераторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпохромна', true, 2),
  ((SELECT id FROM inserted_question), 'Гіперрегенераторна', false, 3),
  ((SELECT id FROM inserted_question), 'Гіперхромна', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 45-ти років відсутні симптоми діабету, але натще визначається підвищений вміст глюкози в крові (7,2 ммоль/л). Наступним тестом має бути визначення:', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Толерантності до глюкози', true, 0),
  ((SELECT id FROM inserted_question), 'Залишкового азоту в крові', false, 1),
  ((SELECT id FROM inserted_question), 'Гліколізованого гемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Сечовини в крові', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкози у сечі', false, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Новонароджений хлопчик від 24-річної породіллі, що народжувала перший раз, мав жовтяницю на 8 годину життя. Група крові новонародженого А+, група крові матері 0+. Лабораторні дані виявили підвищений титр материнських анти-А антитіл, нормальний еритроцитарний глюкозо-6-фосфат і негативний тест на серпоподібні клітини. Гемоглобін новонародженого був 106 г/л. Яка з перерахованих причин є причиною жовтяниці?', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дефіцит глюкозо-6-фосфатдегідрогенази', false, 0),
  ((SELECT id FROM inserted_question), 'Резус-конфлікт (закодовано на ЦТ)', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпербілірубінемія (коректна відповідь)', true, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна хвороба', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження рівню гемоглобіну', false, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дівчина віком 15 років скаржиться на швидку втомлюваність, слабкість, прискорене серцебиття. В аналізі крові виявлено: еритроцити - 2, 5 • 10^12/л, гемоглобін - 50 г/л, КП - 0,6, анізоцитоз зі схильністю до мікроцитозу. Вміст заліза в сироватці крові становив 5,4 ммоль. Яка гематологічна патологія спостерігається у пацієнтки?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', true, 0),
  ((SELECT id FROM inserted_question), 'Набутий абсолютний еритроцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін В12-дефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові пацієнта спостерігається зниження кількості еритроцитів, гемоглобіну, кольорового показника, концентрації сироваткового заліза, мікроанізоцитоз і пойкілоцитоз. Ці зміни супроводжуються розвитком гіпоксії. Який вид гіпоксії спостерігається в цьому разі?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихальна', false, 0),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 3),
  ((SELECT id FROM inserted_question), 'Гемічна', true, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта - гострий інфекційний процес, що супроводжується гарячкою. Температура тіла становить 39,5°С. У який бік зміститься крива дисоціації оксигемоглобіну внаслідок підвищення температури?', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вліво', false, 0),
  ((SELECT id FROM inserted_question), 'Вправо', true, 1),
  ((SELECT id FROM inserted_question), 'Вверх', false, 2),
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 3),
  ((SELECT id FROM inserted_question), 'Вниз', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка під час обстеження в клініці виявлено різке зниження показників гемоглобіну. Яка функція крові порушується?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Трофічна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', true, 1),
  ((SELECT id FROM inserted_question), 'Гомеостатична', false, 2),
  ((SELECT id FROM inserted_question), 'Гуморальна', false, 3);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Гемоглобін дорослої людини (HbA1) - білок-тетрамер, який складається з двох альфа- та двох бета-пептидних ланцюгів. Яку назву має така структура цього білка?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вторинна', false, 0),
  ((SELECT id FROM inserted_question), 'Первинна', false, 1),
  ((SELECT id FROM inserted_question), 'Третинна', false, 2),
  ((SELECT id FROM inserted_question), 'Четвертинна', true, 3);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіку 57 років після обстеження було поставлено діагноз: В_12-дефіцитна анемія - та призначено лікування. За 3 доби був зроблений контрольний аналіз крові. Що буде найадекватнішим критерієм підвищення еритропоезу?', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення кількості ретикулоцитів', true, 0),
  ((SELECT id FROM inserted_question), 'Зниження кольорового показника', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищення кількості тромбоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення кількості лейкоцитів', false, 3),
  ((SELECT id FROM inserted_question), 'Підвищення рівня гемоглобіну', false, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До відділення реанімації доставлено пацієнта, у крові якого виявлено високий вміст сульфгемоглобіну. Який тип гіпоксії наявний у цьому разі?', NULL, 'medium', 41, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторний тип', false, 0),
  ((SELECT id FROM inserted_question), 'Екзогенний тип', false, 1),
  ((SELECT id FROM inserted_question), 'Респіраторний тип', false, 2),
  ((SELECT id FROM inserted_question), 'Гемічний тип', true, 3),
  ((SELECT id FROM inserted_question), 'Тканинний тип', false, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унаслідок тривалого перебування людини в горах на висоті 3000 м над рівнем моря у неї збільшилася киснева ємність крові. Посилене утворення в організмі яких речовин є безпосередньою причиною цього?', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2,3-дифосфогліцерату', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопоетинів', false, 1),
  ((SELECT id FROM inserted_question), 'Еритропоетинів', true, 2),
  ((SELECT id FROM inserted_question), 'Катехоламінів', false, 3),
  ((SELECT id FROM inserted_question), 'Карбгемоглобін', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка віком 37 років скаржиться на головний біль, запаморочення, поганий сон, затерпання кінцівок. Упродовж 6 років працює на заводі газорозрядних ламп у свинцевому цеху. Під час лабораторного аналізу крові виявлено знижену кількість еритроцитів та гемоглобіну, підвищений в декілька разів уміст сироваткового заліза. Який вид анемії у жінки?', NULL, 'medium', 43, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 0),
  ((SELECT id FROM inserted_question), 'Метапластична', false, 1),
  ((SELECT id FROM inserted_question), 'Залізорефрактерна', true, 2),
  ((SELECT id FROM inserted_question), 'Анемія Мінковського-Шоффара', false, 3),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 40-ка років внаслідок посиленого гемолізу еритроцитів підвищився вміст заліза в плазмі крові. Який білок забезпечує його депонування в тканинах?', NULL, 'medium', 44, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
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
  SELECT t.id, 'У пацієнта віком 30 років під час лабораторного аналізу крові виявлено: кількість еритроцитів 6 на 10в12/л, гемоглобіну - 10,55 ммоль/л. Діагностовано хворобу Вакеза. Укажіть провідну ланку патогенезу.', NULL, 'medium', 45, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дефіцит вітаміну В12', false, 0),
  ((SELECT id FROM inserted_question), 'Ацидоз', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит заліза', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіперплазія еритроїдного відростка пухлинної природи', true, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 52 роки під час проведення загального аналізу крові виявлено зниження кількості еритроцитів та підвищення рівня вільного гемоглобіну в плазмі крові (гемоглобінемія), КП - 0,85. Який вид анемії спостерігається у пацієнтки?', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Анемія внаслідок порушення еритропоезу', false, 0),
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична', false, 1),
  ((SELECT id FROM inserted_question), 'Набута гемолітична', true, 2),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', false, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка під час обстеження в клініці виявлено різке зниження показників гемоглобіну. Яка функція крові порушується?', NULL, 'medium', 47, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гомеостатична', false, 0),
  ((SELECT id FROM inserted_question), 'Імморальна', false, 1),
  ((SELECT id FROM inserted_question), 'Дихальна', true, 2),
  ((SELECT id FROM inserted_question), 'Трофічна', false, 3),
  ((SELECT id FROM inserted_question), 'Захисна', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина постійно живе високо в горах. Яку зміну показників крові можна виявити у неї?', NULL, 'medium', 48, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення колірного показника', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження кількості ретикулоцитів', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження показників вмісту гемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', true, 3),
  ((SELECT id FROM inserted_question), 'Появу в крові еритробластів', false, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Аналіз крові виявив знижений вміст гемоглобіну. Яка функція крові порушиться?', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Транспорт гормонів', false, 0),
  ((SELECT id FROM inserted_question), 'Транспорт газів', true, 1),
  ((SELECT id FROM inserted_question), 'Забезпечення імунітету', false, 2),
  ((SELECT id FROM inserted_question), 'Зсідання', false, 3),
  ((SELECT id FROM inserted_question), 'Транспорт поживних речовин', false, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Судово-медичний експерт при розтині тіла 20-річної дівчини встановив смерть внаслідок отруєння ціанідами. Порушення якого процесу, найімовірніше, стало причиною смерті?', NULL, 'medium', 50, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Синтезу гемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Транспорту кисню гемоглобіном', false, 1),
  ((SELECT id FROM inserted_question), 'Транспорту амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинного дихання', true, 3),
  ((SELECT id FROM inserted_question), 'Синтезу сечовини', false, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 25-ти років на 4-й день після крововтрати в крові зросла кількість поліхроматофільних еритроцитів, ретикулоцитів і навіть з’явились поодинокі нормобласти. Про що свідчить такі гематологічні зміни?', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Процеси регенерації випереджають дозрівання клітин', true, 0),
  ((SELECT id FROM inserted_question), 'Ослаблені процеси еритропоезу', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищена спорідність гемоглобіну до кисню', false, 2),
  ((SELECT id FROM inserted_question), 'Знижена продукція еритропоезу в нирках', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшено об’єм плазми крові', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вивчення організму мешканця Паміру виявило високий рівень основного обміну, розширення грудної клітки, зростання кисневої ємності крові за рахунок збільшення еритроцитів, високий вміст гемоглобіну. До якого адаптивного екологічного типу слід віднести цього чоловіка?', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Субтропічний', false, 0),
  ((SELECT id FROM inserted_question), 'Тропічний', false, 1),
  ((SELECT id FROM inserted_question), 'Пустельний', false, 2),
  ((SELECT id FROM inserted_question), 'Арктичний', false, 3),
  ((SELECT id FROM inserted_question), 'Гірський', true, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 50-ти років при обстеженні було виявлено зниження кількості еритроцитів у крові та підвищення рівня вільного гемоглобіну в плазмі крові (гемоглобінемія). КП становив 0,85. Який вид анемії спостерігається у хворого?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 1),
  ((SELECT id FROM inserted_question), 'Набута гемолітична', true, 2),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', false, 3),
  ((SELECT id FROM inserted_question), 'Анемія внаслідок порушення еритропоезу', false, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Крива дисоціації оксигемоглобіну зміщена вправо. Які зміни в організмі людини можуть бути причиною цього?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпертермія', true, 0),
  ((SELECT id FROM inserted_question), 'Збільшення концентрації 2,3-дифосфогліцерату в еритроцитах', false, 1),
  ((SELECT id FROM inserted_question), 'Алкалоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпокапнія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоксемія', false, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людини внаслідок тривалого перебування у горах на висоті 3000 м над рівнем моря збільшилась киснева ємкість крові. Безпосередньою причиною цього є посилене утворення в організмі:', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритропоетинів', true, 0),
  ((SELECT id FROM inserted_question), 'Катехоламінів', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкопоетинів', false, 2),
  ((SELECT id FROM inserted_question), '2,3-дифосфогліцерату', false, 3),
  ((SELECT id FROM inserted_question), 'Карбгемоглобіну', false, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 52-х років при обстеженні було виявлено зниження кількості еритроцитів у крові та підвищення рівня вільного гемоглобіну в плазмі крові (гемоглобінемія). КП- 0,85. Який вид анемії спостерігається у хворої?', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Набута гемолітична', true, 1),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', false, 2),
  ((SELECT id FROM inserted_question), 'Анемія внаслідок порушення еритропоезу', false, 3),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людей, які постійно проживають в гірській місцевості, адаптація до ''кисневого голодування'' здійснюється шляхом полегшеної віддачі кисню гемоглобіном внаслідок:', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення pH крові', false, 0),
  ((SELECT id FROM inserted_question), 'Зростання парціального тиску CO2', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження температури крові', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищеного утворення 2,3- дифосфогліцерату в еритроцитах', true, 3),
  ((SELECT id FROM inserted_question), 'Зниженого утворення 2,3- дифосфогліцерату в еритроцитах', false, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після ремонту автомобіля в закритому приміщенні при працюючому двигуні у чоловіка з’явилися задишка, запаморочення, акроціаноз, частота дихання 24-26/хв. Газовий склад крові: pO2 - 60 мм рт.ст., pCO2 - 30 мм рт.ст.; у крові наявний карбоксигемоглобін. Про який вид гіпоксії можна думати?', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемічна', true, 0),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 2),
  ((SELECT id FROM inserted_question), 'Респіраторна', false, 3),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 4);


-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарки звернувся чоловік віком 25 років із жовтяницею, загальною слабкістю та темною сечею, які з’явилися через кілька годин після вживання страви з бобів. В анамнезі: епізоди гемолітичних кризів після прийому деяких ліків. Під час лабораторного дослідження виявлено: знижений рівень гемоглобіну, підвищений уміст непрямого білірубіну та наявність гемоглобіну в сечі. Дефіцит якого ферменту спричинив цей стан?', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 0),
  ((SELECT id FROM inserted_question), 'Піруваткінази', false, 1),
  ((SELECT id FROM inserted_question), 'Каталази', false, 2),
  ((SELECT id FROM inserted_question), 'Феррокелатази', false, 3),
  ((SELECT id FROM inserted_question), 'Супероксиддисмутази', false, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на малярію після вживання протималярійного препарату примахіну розвинулася гемолітична анемія. Спадкова недостатність якого ферменту в еритроцитах спостерігається при цьому?', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тріозофосфатізомерази', false, 0),
  ((SELECT id FROM inserted_question), 'Фосфофруктокінази', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпази', false, 2),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 3),
  ((SELECT id FROM inserted_question), 'Фруктозо-1-фосфатальдолази', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому з непереносимістю антибіотиків для лікування пневмонії призначений сульфален. Через кілька днів у хворого розвинувся гемоліз еритроцитів. Недостатність якого ферменту в організмі хворого сприяла розвитку цього побічного ефекту?', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'N-ацетилтрансферази', false, 0),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 1),
  ((SELECT id FROM inserted_question), 'Уридиндифосфатглюкуронової трансферази', false, 2),
  ((SELECT id FROM inserted_question), 'Холінестерази', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетальдегіддегідрогенази', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що в осіб із генетично обумовленою недостатністю глюкозо-6-фосфатдегідрогенази еритроцитів у відповідь на призначення деяких протималярійних препаратів може розвиватися гемоліз еритроцитів. Як називається цей прояв атипових реакцій на лікарські засоби?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тахіфілаксія', false, 0),
  ((SELECT id FROM inserted_question), 'Алергія', false, 1),
  ((SELECT id FROM inserted_question), 'Ідіосинкразія', true, 2),
  ((SELECT id FROM inserted_question), 'Сенсибілізація', false, 3),
  ((SELECT id FROM inserted_question), 'Толерантність', false, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 38 років після прийому аспірину і сульфаніламідів спостерігається посилений гемоліз еритроцитів, викликаний недостатністю глюкозо-6-фосфатдегідрогенази. Порушенням утворення якого коферменту зумовлена ця патологія?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Убіхінон', false, 0),
  ((SELECT id FROM inserted_question), 'Піридоксальфосфат', false, 1),
  ((SELECT id FROM inserted_question), 'НАДФН', true, 2),
  ((SELECT id FROM inserted_question), 'ФМНН2', false, 3),
  ((SELECT id FROM inserted_question), 'ФАДН2', false, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У трирічної дитини з підвищеною температурою тіла після прийому аспірину спостерігається посилений гемоліз еритроцитів. Вроджена недостатність якого ферменту могла викликати у дитини гемолітичну анемію?', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікогенфосфорилаза', false, 0),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатаза', false, 1),
  ((SELECT id FROM inserted_question), 'γ-глутамілтрансфераза', false, 2),
  ((SELECT id FROM inserted_question), 'Гліцеролфосфатдегідрогеназа', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогеназа', true, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В пробірку, що містить розчин NaCl 0,9%, додали краплю крові. Що відбудеться з еритроцитами?', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зморшкування', false, 0),
  ((SELECT id FROM inserted_question), 'Осмотичний гемоліз', false, 1),
  ((SELECT id FROM inserted_question), 'Біологічний гемоліз', false, 2),
  ((SELECT id FROM inserted_question), 'Залишаться без змін', true, 3),
  ((SELECT id FROM inserted_question), 'Набухання', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У резус-негативної дитини, народженої від резус-позитивної матері, виникла гемолітична хвороба новонароджених. Які з класів антитіл викликають гемоліз еритроцитів і, таким чином, мають провідну ланку в патогенезі захворювання?', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgA', false, 1),
  ((SELECT id FROM inserted_question), 'IgE', false, 2),
  ((SELECT id FROM inserted_question), 'IgD', false, 3),
  ((SELECT id FROM inserted_question), 'IgM', false, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У семирічної дитини встановлено діагноз: анемія. Під час лабораторного обстеження виявлено дефіцит піруваткінази в еритроцитах. Порушення якого процесу відіграє основну роль у розвитку анемії в цієї дитини?', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Анаеробного глікогенолізу', false, 0),
  ((SELECT id FROM inserted_question), 'Дезамінування амінокислот', false, 1),
  ((SELECT id FROM inserted_question), 'Декарбоксилювання амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Анаеробного гліколізу', true, 3),
  ((SELECT id FROM inserted_question), 'Глюконеогенезу', false, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з діагнозом: гемолітична анемія, виявлено дефіцит піруваткінази в еритроцитах. Яка причина розвитку гемолізу еритроцитів за цих умов?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення активності Na+, К+-АТФ-ази', true, 0),
  ((SELECT id FROM inserted_question), 'Надлишок К+ в еритроцитах', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит спектрину', false, 2),
  ((SELECT id FROM inserted_question), 'Генетичні дефекти глікофорину А', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача Na+ в еритроцитах', false, 4);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дівчинки 7-ми років ознаки анемії. Лабораторно встановлений дефіцит піруваткінази в еритроцитах. Порушення якого процесу грає головну роль в розвитку анемії у дівчинки?', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Анаеробний гліколіз', true, 0),
  ((SELECT id FROM inserted_question), 'Розклад пероксидів', false, 1),
  ((SELECT id FROM inserted_question), 'Тканинне дихання', false, 2),
  ((SELECT id FROM inserted_question), 'Дезамінування амінокислот', false, 3),
  ((SELECT id FROM inserted_question), 'Окислювальне фосфорилювання', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 50 років із загостренням хронічного гнійного середнього отиту лікувався сульфаніламідами протягом 3-х тижнів. На 20-й день лікування антибіотиками у нього з’явилися симптоми анемії. Аналіз сироватки крові виявив антитіла до еритроцитів. Укажіть основний механізм розвитку анемії в цьому разі.', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемоліз еритроцитів', true, 0),
  ((SELECT id FROM inserted_question), 'Дефіцит заліза', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічна крововтрата', false, 2),
  ((SELECT id FROM inserted_question), 'Пригнічення кровотворення', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоплазія кісткового мозку', false, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини 7-ми років, хворої на ангіну, був взятий матеріал (мазок з поверхні мигдаликів) і засіяний на кров’яний агар. Через добу виросли колонії стрептококів, навколо яких середовище стало прозорим. Наявність якого фактору патогенності у збудника виявило це дослідження?', NULL, 'medium', 71, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкоцидин', false, 0),
  ((SELECT id FROM inserted_question), 'Бета -лактамаза', false, 1),
  ((SELECT id FROM inserted_question), 'Ендотоксин', false, 2),
  ((SELECT id FROM inserted_question), 'Нейрамінідаза', false, 3),
  ((SELECT id FROM inserted_question), 'Гемолізин', true, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 40-ка років було встановлено діагноз: серпоподібноклітинна анемія. Який механізм приводить до зменшення кількості еритроцитів в крові у цього хворого?', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Внутрішньосудинний гемоліз', false, 0),
  ((SELECT id FROM inserted_question), 'Позасудинний гемоліз', true, 1),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну B12 і фолієвої кислоти', false, 2),
  ((SELECT id FROM inserted_question), 'Нестача заліза в організмі', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача білка', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У резус-негативної дитини, народженої від резус-позитивної матері, виникла гемолітична хвороба новонароджених. Які з класів антитіл викликають гемоліз еритроцитів і, таким чином, мають провідну ланку в патогенезі захворювання?', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgD', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgG', true, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 50 років після отруєння грибами виникла гемолітична анемія. Де первинно відбуватиметься гемоліз еритроцитів у цьому разі?', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'У нирках', false, 0),
  ((SELECT id FROM inserted_question), 'У лімфоїдній тканині', false, 1),
  ((SELECT id FROM inserted_question), 'У печінці та селезінці', false, 2),
  ((SELECT id FROM inserted_question), 'У кістковому мозку', false, 3),
  ((SELECT id FROM inserted_question), 'У кровоносному руслі', true, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З метою перевірки якості чистоти повітря в операційній проведено висів повітря на ряд живильних середовищ за допомогою апарата Кротова. Після інкубування на деяких із них виросли колонії, оточені чіткою зоною гемолізу. Яке середовище використано для перевірки повітря?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кров''яний МПА', true, 0),
  ((SELECT id FROM inserted_question), 'Вісмут-сульфіт агар', false, 1),
  ((SELECT id FROM inserted_question), 'Жовтково-сольовий агар', false, 2),
  ((SELECT id FROM inserted_question), 'Середовище Ендо', false, 3),
  ((SELECT id FROM inserted_question), 'Сироватковий МПА', false, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 32-х років після оперативного втручання розвинувся гнійний процес. Із гною рани виділено культуру S. aureus. Який з перерахованих тестів найдоцільніше використати для диференціації S. aureus від S. epidermidis?', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Колір колонії', false, 0),
  ((SELECT id FROM inserted_question), 'Ферментація арабінози', false, 1),
  ((SELECT id FROM inserted_question), 'Гемоліз на кров’яному агарі', false, 2),
  ((SELECT id FROM inserted_question), 'Оксидазний тест', false, 3),
  ((SELECT id FROM inserted_question), 'Плазмокоагулазна активність', true, 4);


-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки поступив чоловік 40-ка років, якого укусила гадюка. Де переважно буде проходити гемоліз еритроцитів у цьому випадку?', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'У кровоносному руслі', true, 0),
  ((SELECT id FROM inserted_question), 'У паренхімі нирок', false, 1),
  ((SELECT id FROM inserted_question), 'У клітинах селезінки', false, 2),
  ((SELECT id FROM inserted_question), 'У кістковому мозку', false, 3),
  ((SELECT id FROM inserted_question), 'У клітинах печінки', false, 4);


-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 40-ка років внаслідок посиленого гемолізу еритроцитів підвищився вміст заліза в плазмі крові. Який білок забезпечує його депонування в тканинах?', NULL, 'medium', 78, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Транскортин', false, 1),
  ((SELECT id FROM inserted_question), 'Феритин', true, 2),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумін', false, 4);


-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У трирічної дитини з підвищеною температурою тіла після прийому аспірину спостерігається посилений гемоліз еритроцитів. Вроджена недостатність якого ферменту могла викликати у дитини гемолітичну анемію?', NULL, 'medium', 79, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікогенфосфорилаза', false, 0),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатаза', false, 1),
  ((SELECT id FROM inserted_question), 'γ-глутамілтрансфераза', false, 2),
  ((SELECT id FROM inserted_question), 'Гліцеролфосфатдегідрогеназа', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогеназа', true, 4);


-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка віком 60 років, який хворий на хронічний гепатит, часто спостерігаються кровотечі з носа і ясен, спонтанно з''являються геморагічні висипання на шкірі і слизових оболонках. Що є причиною виникнення цих явищ?', NULL, 'medium', 80, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення вмісту амінотрансфераз', false, 0),
  ((SELECT id FROM inserted_question), 'Поява в крові макроглобулінів і кріоглобулінів', false, 1),
  ((SELECT id FROM inserted_question), 'Зменшення синтезу протромбіну і фібриногену', true, 2),
  ((SELECT id FROM inserted_question), 'Зменшення утворення сироваткових альбумінів', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення в крові рівня холінестерази', false, 4);


-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 34 роки звернувся до лікаря-стоматолога із приводу зубного болю. Після видалення декількох зубів почалася кровотеча, що тривала понад 15 хвилин. Із анамнезу відомо: у пацієнта хронічний гепатит С. Яка ймовірна причина продовження кровотечі?', NULL, 'medium', 81, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження вмісту фібриногену в крові', true, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження вмісту альбумінів у крові', false, 3);


-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки напередодні пологів ШОЕ 40 мм / год. Така величина ШОЕ обумовлена тим, що в крові підвищений вміст:', NULL, 'medium', 82, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритроцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриногену', true, 1),
  ((SELECT id FROM inserted_question), 'Альбумінів', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 3),
  ((SELECT id FROM inserted_question), 'Білків', false, 4);


-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У шестимісячної дитини спостерігалися часті та сильні підшкірні кровотечі. Призначення синтетичного аналога вітаміну К (вікасола) дало позитивний ефект. У γ-карбоксилюванні глутамінової кислоти якого з нижченаведених білків згортальної системи крові бере участь цей вітамін?', NULL, 'medium', 83, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Протромбіну', true, 0),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Фактора Розенталя', false, 2),
  ((SELECT id FROM inserted_question), 'Антигемофільного глобуліна А', false, 3),
  ((SELECT id FROM inserted_question), 'Фактора Хагемана', false, 4);


-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 6-місячної дитини спостерігались часті та сильні підшкірні кровотечі. Призначення синтетичного аналога вітаміну К (вікасола) дало позитивний ефект. В гамма-карбоксилюванні глутамінової кислоти якого з перерахованих нижче білків згортальної системи крові бере участь цей вітамін?', NULL, 'medium', 84, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антигемофільного глобуліну А', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Фактора Хагемана', false, 2),
  ((SELECT id FROM inserted_question), 'Фактора Розенталя', false, 3),
  ((SELECT id FROM inserted_question), 'Протромбіну', true, 4);


-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На останньому місяці вагітності вміст фібриногену в плазмі крові в 2 рази вище за норму. Яку швидкість осідання еритроцитів слід при цьому очікувати?', NULL, 'medium', 85, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '5-10 мм/годину', false, 0),
  ((SELECT id FROM inserted_question), '3-12 мм/годину', false, 1),
  ((SELECT id FROM inserted_question), '10-15 мм/годину', false, 2),
  ((SELECT id FROM inserted_question), '40-50 мм/годину', true, 3),
  ((SELECT id FROM inserted_question), '0-5 мм/годину', false, 4);


-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 3-х років з вираженим геморагічним синдромом відсутній антигемофільний глобулін А (фактор VIII) у плазмі крові. Яка фаза гемостазу первинно порушена у цього хворого?', NULL, 'medium', 86, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перетворення протромбіну в тромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Зовнішній механізм активації протромбінази', false, 1),
  ((SELECT id FROM inserted_question), 'Перетворення фібриногену в фібрин', false, 2),
  ((SELECT id FROM inserted_question), 'Внутрішній механізм активації протромбінази', true, 3),
  ((SELECT id FROM inserted_question), 'Ретракція кров’яного згустку', false, 4);


-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Видалення зуба в пацієнта з хронічним персистуючим гепатитом ускладнилось тривалою кровотечею. Яка причина геморагічного синдрому?', NULL, 'medium', 87, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення синтезу фібриногену', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення утворення фібрину', false, 1),
  ((SELECT id FROM inserted_question), 'Зменшення утворення тромбіну', true, 2),
  ((SELECT id FROM inserted_question), 'Посилення фібринолізу', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення утворення тромбопластину', false, 4);


-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для розвитку гарячкових станів характерним є зростання рівня білків ''гострої фази'' церулоплазміну, фібриногену, С-реактивного протеїну. Вкажіть можливий механізм цього явища:', NULL, 'medium', 88, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стимулюючий вплив ІЛ-1 на гепатоцити', true, 0),
  ((SELECT id FROM inserted_question), 'Проліферативна дія ІЛ-2 на Т-лімфоцити', false, 1),
  ((SELECT id FROM inserted_question), 'Руйнівна дія підвищеної температури на клітини організму', false, 2),
  ((SELECT id FROM inserted_question), 'Дегрануляція тканинних базофілів', false, 3);


-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові хворого виявлено низький рівень альбумінів та фібриногену. Зниження активності яких органел гепатоцитів найбільш вірогідно обумовлює це явище?', NULL, 'medium', 89, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Агранулярна ендоплазматична сітка', false, 0),
  ((SELECT id FROM inserted_question), 'Комплекс Гольджі', false, 1),
  ((SELECT id FROM inserted_question), 'Лізосоми', false, 2),
  ((SELECT id FROM inserted_question), 'Гранулярна ендоплазматична сітка', true, 3),
  ((SELECT id FROM inserted_question), 'Мітохондрії', false, 4);


-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 2-річної дитини кишковий дисбактеріоз, на фоні якого виник геморагічний синдром. Що є найбільш імовірною причиною геморагій у цієї дитини?', NULL, 'medium', 90, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активація тромбопластину тканин', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Гіповітаміноз РР', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну К', true, 4);


-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В крові хворого виявлено низький рівень альбумінів і фібриногену. Зниження активності яких органел гепатоцитів печінки найбільш вірогідно обумовлює це явище?', NULL, 'medium', 91, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексу Гольджі', false, 0),
  ((SELECT id FROM inserted_question), 'Лізосом', false, 1),
  ((SELECT id FROM inserted_question), 'Гранулярної ендоплазматичної сітки', true, 2),
  ((SELECT id FROM inserted_question), 'Мітохондрій', false, 3),
  ((SELECT id FROM inserted_question), 'Агранулярної ендоплазматичної сітки', false, 4);


-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 43 років на фоні септичного шоку визначається тромбоцитопенія, зменшення фібриногену, поява в крові продуктів деградації фібрину, петехіальні крововиливи. Яка найбільш вірогідна причина цих змін?', NULL, 'medium', 92, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Екзогенна інтоксикація', false, 0),
  ((SELECT id FROM inserted_question), 'ДВЗ-синдром', true, 1),
  ((SELECT id FROM inserted_question), 'Геморагічний діатез', false, 2),
  ((SELECT id FROM inserted_question), 'Аутоімунна тромбоцитопенія', false, 3),
  ((SELECT id FROM inserted_question), 'Порушення виробляння тромбоцитів', false, 4);


-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обстеженні хворого з гемофілією виявлено зміна деяких показників крові. Яка з перерахованих ознак відповідає цьому захворюванню?', NULL, 'medium', 93, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Афібриногенемією', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенією', false, 1),
  ((SELECT id FROM inserted_question), 'Еритроцитозом', false, 2),
  ((SELECT id FROM inserted_question), 'Еозинофілією', false, 3),
  ((SELECT id FROM inserted_question), 'Сповільнення зсідання крові', true, 4);


-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На останньому місяці вагітності вміст фібриногену в плазмі крові в 2 рази вище за норму. Яку швидкість осідання еритроцитів слід при цьому очікувати?', NULL, 'medium', 94, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '0-5 мм/годину', false, 0),
  ((SELECT id FROM inserted_question), '3-12 мм/годину', false, 1),
  ((SELECT id FROM inserted_question), '40-50 мм/годину', true, 2),
  ((SELECT id FROM inserted_question), '10-15 мм/годину', false, 3),
  ((SELECT id FROM inserted_question), '5-10 мм/годину', false, 4);


-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 2-х років з вираженим геморагічним синдромом відсутній антигемофільний глобулін А (фактор VIII) у плазмі крові. Яка фаза гемостазу первинно порушена у цього хворого?', NULL, 'medium', 95, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зовнішній механізм активації протромбінази', false, 0),
  ((SELECT id FROM inserted_question), 'Перетворення протромбіну в тромбін', false, 1),
  ((SELECT id FROM inserted_question), 'Перетворення фібриногену в фібрин', false, 2),
  ((SELECT id FROM inserted_question), 'Ретракція кров’яного згустку', false, 3),
  ((SELECT id FROM inserted_question), 'Внутрішній механізм активації протромбінази', true, 4);


-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?', NULL, 'medium', 96, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Концентрації фібриногену', false, 0),
  ((SELECT id FROM inserted_question), 'Активованого часткового тромбопластинового часу (коректна відповідь)', true, 1),
  ((SELECT id FROM inserted_question), 'Міжнародного нормалізованого відношення', false, 2),
  ((SELECT id FROM inserted_question), 'ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Протромбінового часу', false, 4);


-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 3-х років з вираженим геморагічним синдромом відсутній антигемофільний глобулін А (фактор VIII) у плазмі крові. Яка фаза гемостазу первинно порушена у цього хворого?', NULL, 'medium', 97, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Внутрішній механізм активації протромбінази', true, 0),
  ((SELECT id FROM inserted_question), 'Перетворення протромбіну в тромбін', false, 1),
  ((SELECT id FROM inserted_question), 'Перетворення фібриногену в фібрин', false, 2),
  ((SELECT id FROM inserted_question), 'Зовнішній механізм активації протромбінази', false, 3),
  ((SELECT id FROM inserted_question), 'Ретракція кров’яного згустку', false, 4);


-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини спостерігається геморагічний синдром, діагностована гемофілія В. Дефіцитом якого фактора зумовлене це захворювання?', NULL, 'medium', 98, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ІІ (протромбіну)', false, 0),
  ((SELECT id FROM inserted_question), 'ІХ (Крістмаса)', true, 1),
  ((SELECT id FROM inserted_question), 'ХІІ (Хагемана)', false, 2),
  ((SELECT id FROM inserted_question), 'ХІ (протромбопластину)', false, 3),
  ((SELECT id FROM inserted_question), 'ѴІ (антигемофільного глобуліну)', false, 4);


-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт скаржиться на часті кровотечі з ясен. Під час аналізу крові виявлено дефіцит ІІ фактора зсідання крові (протромбіну). Яка фаза зсідання крові насамперед порушена у людини?', NULL, 'medium', 99, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Утворення протромбінази', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриноліз', false, 1),
  ((SELECT id FROM inserted_question), 'Утворення фібрину', false, 2),
  ((SELECT id FROM inserted_question), 'Утворення тромбіну', true, 3),
  ((SELECT id FROM inserted_question), 'Ретракція згустку', false, 4);


-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини, яка страждає на геморагічний синдром, діагностована гемофілія В. Вона зумовлена дефіцитом фактора:', NULL, 'medium', 100, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'XII (Хагемана)', false, 0),
  ((SELECT id FROM inserted_question), 'VІІІ (антигемофільного глобуліну)', false, 1),
  ((SELECT id FROM inserted_question), 'II (протромбіну)', false, 2),
  ((SELECT id FROM inserted_question), 'IX (Крістмаса)', true, 3),
  ((SELECT id FROM inserted_question), 'XI (протромбопластину)', false, 4);


-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Лікар-гематолог призначив пацієнту з кровотечею коагулянт, який діє шляхом підвищення синтезу протромбіну та інших факторів зсідання крові переважно в печінці і є синтетичним водорозчинним вітаміном. Який препарат призначив лікар?', NULL, 'medium', 101, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин', false, 0),
  ((SELECT id FROM inserted_question), 'Менадіону натрію біосульфат', true, 1),
  ((SELECT id FROM inserted_question), 'Кальцію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Етамзилат', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбін', false, 4);


-- Question 102
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після видалення зуба у пацієнта виникла кровотеча. Аналіз крові виявив зниження протромбінового індексу. Дефіцит якого вітаміну може бути причиною такого стану?', NULL, 'medium', 102, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'K', true, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'B', false, 3),
  ((SELECT id FROM inserted_question), 'D', false, 4);


-- Question 103
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обтураційній жовтяниці і жовчних норицях часто спостерігається протромбінова недостатність. З дефіцитом в організмі якого вітаміну це пов’язано?', NULL, 'medium', 103, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'В6', false, 0),
  ((SELECT id FROM inserted_question), 'A', false, 1),
  ((SELECT id FROM inserted_question), 'E', false, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'K', true, 4);


-- Question 104
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що введення в організм людини лікарського препарату дикумаролу викликає різке зниження в крові вмісту протромбіну і ряду інших білкових факторів згортання крові. Антивітаміном якого вітаміну є дикумарол?', NULL, 'medium', 104, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін P', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін K', true, 1),
  ((SELECT id FROM inserted_question), 'Вітамін E', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін H', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін C', false, 4);


-- Question 105
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого спостерігаються геморагії, в крові знижена концентрація протромбіну. Недостатність якого вітаміну призвела до порушення синтезу цього фактору згортання крові?', NULL, 'medium', 105, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'D', false, 0),
  ((SELECT id FROM inserted_question), 'C', false, 1),
  ((SELECT id FROM inserted_question), 'A', false, 2),
  ((SELECT id FROM inserted_question), 'K', true, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 106
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 70-ти років атеросклероз ускладнився тромбозом судин нижніх кінцівок, виникла гангрена пальців лівої стопи. Початок тромбоутворення, найбільш вірогідно, пов’язаний з:', NULL, 'medium', 106, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Адгезією тромбоцитів', true, 0),
  ((SELECT id FROM inserted_question), 'Перетворенням фібриногену в фібрин', false, 1),
  ((SELECT id FROM inserted_question), 'Зниженням синтезу гепарину', false, 2),
  ((SELECT id FROM inserted_question), 'Перетворенням протромбіну в тромбін', false, 3),
  ((SELECT id FROM inserted_question), 'Активацією протромбінази', false, 4);


-- Question 107
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унаслідок посттрансляційних змін деяких білків, що приймають участь у зсіданні крові, зокрема протромбіну, вони набувають здатності зв’язувати кальцій. У цьому процесі бере участь вітамін:', NULL, 'medium', 107, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'В1', false, 0),
  ((SELECT id FROM inserted_question), 'А', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'B2', false, 3),
  ((SELECT id FROM inserted_question), 'K', true, 4);


-- Question 108
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з захворюванням печінки виявлено зниження вмісту протромбіну в крові. Це призведе, перш за все, до порушення:', NULL, 'medium', 108, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Судинно-тромбоцитарного гемостазу', false, 0),
  ((SELECT id FROM inserted_question), 'Фібринолізу', false, 1),
  ((SELECT id FROM inserted_question), 'Першої фази коагуляційного гемостазу', false, 2),
  ((SELECT id FROM inserted_question), 'Антикоагулянтних властивостей крові', false, 3),
  ((SELECT id FROM inserted_question), 'Другої фази коагуляційного гемостазу', true, 4);


-- Question 109
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 2-річної дитини кишковий дисбактеріоз, на фоні якого виник геморагічний синдром. Що є найбільш імовірною причиною геморагій у цієї дитини?', NULL, 'medium', 109, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активація тромбопластину тканин', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Гіповітаміноз РР', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну К', true, 4);


-- Question 110
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Студент використав консервовану донорську кров для визначення часу її зсідання. Однак, будь-якого позитивного результату він отримати не зміг. Причиною цього є відсутність в крові:', NULL, 'medium', 110, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фі6риногєну', false, 0),
  ((SELECT id FROM inserted_question), 'Фактора Хагемана', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбопластину', false, 2),
  ((SELECT id FROM inserted_question), 'Вітаміну K', false, 3),
  ((SELECT id FROM inserted_question), 'Іонізованого кальцію', true, 4);


-- Question 111
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Видалення зуба в пацієнта з хронічним персистуючим гепатитом ускладнилось тривалою кровотечею. Яка причина геморагічного синдрому?', NULL, 'medium', 111, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення синтезу фібриногену', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення утворення фібрину', false, 1),
  ((SELECT id FROM inserted_question), 'Зменшення утворення тромбіну', true, 2),
  ((SELECT id FROM inserted_question), 'Посилення фібринолізу', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення утворення тромбопластину', false, 4);


-- Question 112
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Мікротравмування слизової оболонки порожнини рота виникають щодня під час вживання їжі, проте кровотеча швидко припиняється за допомогою:', NULL, 'medium', 112, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарину', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбопластину', true, 1),
  ((SELECT id FROM inserted_question), 'Муцину', false, 2),
  ((SELECT id FROM inserted_question), 'Лізоциму', false, 3),
  ((SELECT id FROM inserted_question), 'Антигепаринового фактору', false, 4);


-- Question 113
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 42 роки незначне пошкодження шкіри внаслідок побутової травми призвело до активації судинно-тромбоцитарного гемостазу, завдяки чому кровотеча зупинилася протягом п''яти хвилин. Який із нижченаведених факторів є ключовим на стадії адгезії тромбоцитів під час формування тромбоцитарного тромбу?', NULL, 'medium', 113, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фактор Флетчера (Прекалікреїн)', false, 0),
  ((SELECT id FROM inserted_question), 'Фактор Віллебранда', true, 1),
  ((SELECT id FROM inserted_question), 'Фактор Хагемана', false, 2),
  ((SELECT id FROM inserted_question), 'Лабільний фактор (Проакцелерин)', false, 3),
  ((SELECT id FROM inserted_question), 'Фактор Стюарта-Прауера', false, 4);


-- Question 114
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта діагностовано гемофілію А. Дефіцит якого фактора зсідання крові є причиною цієї патології?', NULL, 'medium', 114, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IX', false, 0),
  ((SELECT id FROM inserted_question), 'XII', false, 1),
  ((SELECT id FROM inserted_question), 'V, X', false, 2),
  ((SELECT id FROM inserted_question), 'І, II', false, 3),
  ((SELECT id FROM inserted_question), 'VIII', true, 4);


-- Question 115
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини, яка страждає на геморагічний синдром, діагностована гемофілія В. Вона зумовлена дефіцитом фактора:', NULL, 'medium', 115, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'XII (Хагемана)', false, 0),
  ((SELECT id FROM inserted_question), 'VІІІ (антигемофільного глобуліну)', false, 1),
  ((SELECT id FROM inserted_question), 'II (протромбіну)', false, 2),
  ((SELECT id FROM inserted_question), 'IX (Крістмаса)', true, 3),
  ((SELECT id FROM inserted_question), 'XI (протромбопластину)', false, 4);


-- Question 116
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 3-х років з вираженим геморагічним синдромом відсутній антигемофільний глобулін А (фактор VIII) у плазмі крові. Яка фаза гемостазу первинно порушена у цього хворого?', NULL, 'medium', 116, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перетворення протромбіну в тромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Зовнішній механізм активації протромбінази', false, 1),
  ((SELECT id FROM inserted_question), 'Перетворення фібриногену в фібрин', false, 2),
  ((SELECT id FROM inserted_question), 'Внутрішній механізм активації протромбінази', true, 3),
  ((SELECT id FROM inserted_question), 'Ретракція кров’яного згустку', false, 4);


-- Question 117
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 2-х років з вираженим геморагічним синдромом відсутній антигемофільний глобулін А (фактор VIII) у плазмі крові. Яка фаза гемостазу первинно порушена у цього хворого?', NULL, 'medium', 117, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зовнішній механізм активації протромбінази', false, 0),
  ((SELECT id FROM inserted_question), 'Перетворення протромбіну в тромбін', false, 1),
  ((SELECT id FROM inserted_question), 'Перетворення фібриногену в фібрин', false, 2),
  ((SELECT id FROM inserted_question), 'Ретракція кров’яного згустку', false, 3),
  ((SELECT id FROM inserted_question), 'Внутрішній механізм активації протромбінази', true, 4);


-- Question 118
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт страждає на геморагічний синдром, що проявляється частими носовими кровотечами, посттравматичними та спонтанними внутрішньошкірними та внутрішньосуглобовими крововиливами. Після лабораторного обстеження було діагностовано гемофілію В. Дефіцит якого фактора згортання крові обумовлює дане захворювання?', NULL, 'medium', 118, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'V', false, 0),
  ((SELECT id FROM inserted_question), 'IX', true, 1),
  ((SELECT id FROM inserted_question), 'XI', false, 2),
  ((SELECT id FROM inserted_question), 'VIII', false, 3),
  ((SELECT id FROM inserted_question), 'VII', false, 4);


-- Question 119
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Посттрансляційна модифікація вітамінозалежних факторів зсідання крові полягає у перетворенні залишку глутамінової кислоти в гамма-карбоксиглутаміназу. Укажіть необхідний для цього вітамін.', NULL, 'medium', 119, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'К', true, 0),
  ((SELECT id FROM inserted_question), 'D', false, 1),
  ((SELECT id FROM inserted_question), 'A', false, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 120
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 37-ми років на фоні тривалого застосування антибіотиків спостерігається підвищена кровоточивість при невеликих пошкодженнях. У крові - зниження активності факторів згортання крові ІІ, VII, IX, X, подовження часу згортання крові. Недостатністю якого вітаміну обумовлені зазначені зміни?', NULL, 'medium', 120, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін А', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін D', false, 1),
  ((SELECT id FROM inserted_question), 'Вітамін С', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін Е', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін К', true, 4);


-- Question 121
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 2-річної дитини кишковий дисбактеріоз, на фоні якого виник геморагічний синдром. Що є найбільш імовірною причиною геморагій у цієї дитини?', NULL, 'medium', 121, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активація тромбопластину тканин', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Гіповітаміноз РР', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну К', true, 4);


-- Question 122
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Посттрансляційна модифікація вітамінозалежних факторів зсідання крові полягає у перетворенні залишку глутамінової кислоти в гамма-карбоксиглутаміназу. Укажіть необхідний для цього вітамін.', NULL, 'medium', 122, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'К', true, 0),
  ((SELECT id FROM inserted_question), 'D', false, 1),
  ((SELECT id FROM inserted_question), 'A', false, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 123
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дослідження пацієнта віком 49 років виявлено суттєве збільшення часу зсідання крові, шлунково-кишкові кровотечі та підшкірні крововиливи. Нестачею якого вітаміну можна пояснити такі симптоми?', NULL, 'medium', 123, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'PP', false, 0),
  ((SELECT id FROM inserted_question), 'B1', false, 1),
  ((SELECT id FROM inserted_question), 'K', true, 2),
  ((SELECT id FROM inserted_question), 'H', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 124
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого виявлена серповидноклітинна анемія. Заміна якої амінокислоти в поліпептидному ланцюгу Нb на валін призводить до цього захворювання?', NULL, 'medium', 124, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Треоніну', false, 0),
  ((SELECT id FROM inserted_question), 'Глутамінової кислоти', true, 1),
  ((SELECT id FROM inserted_question), 'Лейцину', false, 2),
  ((SELECT id FROM inserted_question), 'Аргініну', false, 3),
  ((SELECT id FROM inserted_question), 'Аспарагінової кислоти', false, 4);


-- Question 125
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для запобігання післяопераційної кровотечі 6-ти річній дитині рекомендовано приймати вікасол, який є синтетичним аналогом вітаміну K. Вкажіть, які посттрансляційні зміни факторів згортання крові активуються під впливом вікасолу?', NULL, 'medium', 125, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фосфорилювання радикалів серину', false, 0),
  ((SELECT id FROM inserted_question), 'Карбоксилювання глутамінової кислоти', true, 1),
  ((SELECT id FROM inserted_question), 'Частковий протеоліз', false, 2),
  ((SELECT id FROM inserted_question), 'Глікозилювання', false, 3),
  ((SELECT id FROM inserted_question), 'Полімеризація', false, 4);


-- Question 126
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Посттрансляційна модифікація вітамінозалежних факторів зсідання крові полягає у перетворенні залишку глутамінової кислоти в у-карбоксиглутамінову. Укажіть необхідний для цього вітамін.', NULL, 'medium', 126, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'D', false, 0),
  ((SELECT id FROM inserted_question), 'К', true, 1),
  ((SELECT id FROM inserted_question), 'Е', false, 2),
  ((SELECT id FROM inserted_question), 'С', false, 3),
  ((SELECT id FROM inserted_question), 'A', false, 4);


-- Question 127
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в анамнезі: з дитинства відмічався знижений рівень гемоглобіну. Лікування препаратами заліза не дає ефекту. У крові: ер.- 3,1 • 10^12/л, ретик.-16%, Hb- 85 г/л, КП0,75; в мазку крові анізоцити, пойкілоцити, мішенеподібні еритроцити, еритроцити з базофільною зернистістю, рівень заліза у сироватці 30 мкмоль/л. Для якої патології системи крові характерні такі дані?', NULL, 'medium', 127, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фолієводефіцитна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'B12-дефіцитна анемія', false, 4);


-- Question 128
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 19-ти років з дитинства відмічалося зниження гемоглобіну до 90-95 г/л. У крові під час госпіталізації: ер.- 3, 2 • 10^12/л, Hb- 85 г/л, КП- 0,78; лейк.- 5, 6 • 10^9/л, тромб.- 210 • 10^9 /л. У мазку: анізоцитоз, пойкілоцитоз, мішенеподібні еритроцити. Ретикулоцити - 6%. Лікування препаратами заліза було неефективне. Яку патологію системи крові можна запідозрити в даному випадку?', NULL, 'medium', 128, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мембранопагія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Ферментопатія', false, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 4);


-- Question 129
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 35 років зі встановленим діагнозом: гіпохромна анемія - дослідження крові показало, що в еритроцитах знаходиться 45% HbS та 55% HbA1 .Яка форма анемії у пацієнтки?', NULL, 'medium', 129, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Таласемія', false, 0),
  ((SELECT id FROM inserted_question), 'Мікроцитарна', false, 1),
  ((SELECT id FROM inserted_question), 'Апластична', false, 2),
  ((SELECT id FROM inserted_question), 'Серповидноклітинна', true, 3),
  ((SELECT id FROM inserted_question), 'Анемія Адісона-Бірмера', false, 4);


-- Question 130
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з хронічним гіпоацидним гастритом спостерігаються симптоми гіпохромної анемії. Під час мікроскопічного дослідження мазку крові виявлено: анулоцити, мікроанізоцитоз, пойкілоцитоз. Який вид анемії спостерігається у пацієнта?', NULL, 'medium', 130, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', false, 1),
  ((SELECT id FROM inserted_question), 'Серповидноклітинна', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', true, 3),
  ((SELECT id FROM inserted_question), 'Перніціозна', false, 4);


-- Question 131
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дослідження первинної структури молекули глобіну виявлено заміну глутамінової кислоти на валін. Для якої спадкової патології це характерно?', NULL, 'medium', 131, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хвороба Мінковського-Шоффара', false, 0),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіноз', false, 3),
  ((SELECT id FROM inserted_question), 'Таласемія', false, 4);


-- Question 132
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта час від часу суттєво знижується вміст гемоглобіну та еритроцитів у крові, з''являється жовтяниця. З анамнезу з''ясовано, що ці напади завжди виникають після вживання кінських бобів. На яку форму анемії вказують такі симптоми пацієнта?', NULL, 'medium', 132, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Набуту гемолітичну анемію', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитну анемію', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкову мембранопатію', false, 2),
  ((SELECT id FROM inserted_question), 'Спадкову ферментопатію', true, 3),
  ((SELECT id FROM inserted_question), 'Спадкову гемоглобінопатію', false, 4);


-- Question 133
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Юнак віком 15 років скаржиться на загальну слабкість, запаморочення, швидку стомлюваність. Під час обстеження виявлено еритроцити зміненої форми, кількість їх знижена. Попередній діагноз: серповидноклітинна анемія. Яка амінокислотна заміна в гемоглобіні зумовлює розвиток цього патологічного стану?', NULL, 'medium', 133, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глутамату на аланін', false, 0),
  ((SELECT id FROM inserted_question), 'Глутамату на аспартат', false, 1),
  ((SELECT id FROM inserted_question), 'Валіну на глутамат', false, 2),
  ((SELECT id FROM inserted_question), 'Глутамату на валін', true, 3),
  ((SELECT id FROM inserted_question), 'Валіну на аспартат', false, 4);


-- Question 134
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У разі спадкового дефекту ферментів синтезу гема хворий має підвищену чутливість шкіри до сонячного світла, сечу червоного кольору. Накопичення яких метаболітів обміну гемоглобіну викликає ці симптоми?', NULL, 'medium', 134, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Білірубіну', false, 0),
  ((SELECT id FROM inserted_question), 'Уробіліногенів', false, 1),
  ((SELECT id FROM inserted_question), 'Порфіриногенів', true, 2),
  ((SELECT id FROM inserted_question), 'Мезобіліногенів', false, 3),
  ((SELECT id FROM inserted_question), 'Стеркобіліногенів', false, 4);


-- Question 135
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого час від часу суттєво знижується вміст гемоглобіну і еритроцитів в крові, з’являється жовтяниця. З анамнезу з’ясовано, що ці напади завжди виникають після вживання кінських бобів. Яка з форм анемії має місце у даного хворого?', NULL, 'medium', 135, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Спадкова гемоглобінопатія', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкова ферментопатія', true, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Спадкова мембранопатія', false, 4);


-- Question 136
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 19-ти років з дитинства спостерігалося зниження гемоглобіну до 9095 г/л. Аналіз крові під час госпіталізації: еритроцити - 3,2 • 10^12/л, гемоглобін - 85 г/л, КП- 0,78; лейкоцити - 5,6 • 10^9/л, тромбоцити - 210 • 10^9/л. В мазку: анізоцитоз, пойкілоцитоз, мішенеподібні еритроцити. Ретикулоцити - 6%. Лікування препаратами заліза не ефективне. Яку патологію системи крові можна припустити в даному випадку?:', NULL, 'medium', 136, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Мембранопатія', false, 1),
  ((SELECT id FROM inserted_question), 'Ферментопатія', false, 2),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 3),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 4);


-- Question 137
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в анамнезі: з дитинства відмічався знижений рівень гемоглобіну. Лікування препаратами заліза не дає ефекту. У крові: ер.- 3,1 • 10^12/л, ретик.-16%, Hb- 85 г/л, КП0,75; в мазку крові анізоцити, пойкілоцити, мішенеподібні еритроцити, еритроцити з базофільною зернистістю, рівень заліза у сироватці 30 мкмоль/л. Для якої патології системи крові характерні такі дані?', NULL, 'medium', 137, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фолієводефіцитна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'B12-дефіцитна анемія', false, 4);


-- Question 138
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час клінічного та біохімічного обстеження пацієнта виявлено серповидноклітинну анемію. Визначення якого компонента крові було вирішальним для встановлення діагнозу?', NULL, 'medium', 138, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метгемоглобіну', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну F', false, 1),
  ((SELECT id FROM inserted_question), 'Гемоглобіну S', true, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіну A1', false, 3),
  ((SELECT id FROM inserted_question), 'Гемоглобіну С', false, 4);


-- Question 139
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого виявлена серповидноклітинна анемія. Заміна якої амінокислоти в поліпептидному ланцюгу Нb на валін призводить до цього захворювання?', NULL, 'medium', 139, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Треоніну', false, 0),
  ((SELECT id FROM inserted_question), 'Глутамінової кислоти', true, 1),
  ((SELECT id FROM inserted_question), 'Лейцину', false, 2),
  ((SELECT id FROM inserted_question), 'Аргініну', false, 3),
  ((SELECT id FROM inserted_question), 'Аспарагінової кислоти', false, 4);


-- Question 140
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У деяких, майже клінічно здорових людей, в умовах високогір''я виявляються ознаки анемії. При аналізі крові в них виявляють серповидні еритроцити. Генотип цих людей:', NULL, 'medium', 140, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ХсХс', false, 0),
  ((SELECT id FROM inserted_question), 'АА', false, 1),
  ((SELECT id FROM inserted_question), 'ХСХс', false, 2),
  ((SELECT id FROM inserted_question), 'Aa', true, 3),
  ((SELECT id FROM inserted_question), 'аа', false, 4);


-- Question 141
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Периферичні набряки при цирозі печінки викликані переважним дефіцитом білка, частка якого порівняно з іншими білками крові переважає у створенні онкотичного тиску крові. Укажіть цей білок.', NULL, 'medium', 141, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альбуміну', true, 0),
  ((SELECT id FROM inserted_question), 'Протромбіну', false, 1),
  ((SELECT id FROM inserted_question), 'Гепарину', false, 2),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 3),
  ((SELECT id FROM inserted_question), 'Гобуліну', false, 4);


-- Question 142
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого, який знаходиться на лікуванні з приводу вірусного гепатиту В, з’явилися ознаки печінкової недостатності. Які зміни крові, що свідчать про порушення білкового обміну, найбільш вірогідно спостерігатимуться у цьому випадку?', NULL, 'medium', 142, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Абсолютна гіперальбумінемія', false, 0),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперфібриногенемія', false, 1),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперглобулінемія', false, 2),
  ((SELECT id FROM inserted_question), 'Білковий склад крові не змінений', false, 3),
  ((SELECT id FROM inserted_question), 'Абсолютна гіпоальбумінемія', true, 4);


-- Question 143
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 27 років після тривалого голодування спостерігається виникнення набряків. Укажіть найімовірнішу причину цього патологічного стану.', NULL, 'medium', 143, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення онкотичного тиску крові внаслідок збільшення концентрації альбумінів', false, 0),
  ((SELECT id FROM inserted_question), 'Підвищення онкотичного тиску крові внаслідок збільшення концентрації фібриногену', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації фібриногену', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження онкотичного тиску крові внаслідок зменшення концентрації альбумінів', true, 4);


-- Question 144
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта швидко розвиваються набряки. Зниження кількості яких білків сироватки крові призводить до їх виникнення?', NULL, 'medium', 144, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'а2-глобулінів', false, 0),
  ((SELECT id FROM inserted_question), 'a1- глобулінів', false, 1),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'b- глобулінів', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 4);


-- Question 145
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з хронічною серцевою недостатністю розвинувся цироз печінки з асцитом і набряками нижніх кінцівок. Які зміни складу крові спричиняють асцит у цього пацієнта?', NULL, 'medium', 145, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпохолестеринемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпергаммаглобулінемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпопротромбінемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоальбумінемія', true, 3),
  ((SELECT id FROM inserted_question), 'Макроглобулінемія', false, 4);


-- Question 146
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При недостатньому харчуванні часто має місце білкове голодування, яке проявляється зниженням вмісту білка в плазмі крові й розвитком набряків. За рахунок яких білків плазми більшою мірою розвивається зниження онкотичного тиску при цьому?', NULL, 'medium', 146, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гамма-глобулінів', false, 0),
  ((SELECT id FROM inserted_question), 'Альфа-глобулінів', false, 1),
  ((SELECT id FROM inserted_question), 'Фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Бета-глобулінів', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 4);


-- Question 147
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При токсичному ушкодженні клітин печінки з порушенням її функцій у хворого з’явилися набряки. Які зміни складу плазми крові є провідною причиною розвитку набряків?', NULL, 'medium', 147, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення вмісту глобулінів', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження вмісту альбумінів', true, 1),
  ((SELECT id FROM inserted_question), 'Зменшення вмісту фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Збільшення вмісту альбумінів', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення вмісту глобулінів', false, 4);


-- Question 148
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого, який знаходиться на лікуванні з приводу вірусного гепатиту В, з’явилися ознаки печінкової недостатності. Які зміни крові, що свідчать про порушення білкового обміну, найбільш вірогідно спостерігатимуться у цьому випадку?', NULL, 'medium', 148, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Абсолютна гіперфібриногенемія', false, 0),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперальбумінемія', false, 1),
  ((SELECT id FROM inserted_question), 'Абсолютна гіпоальбумінемія', true, 2),
  ((SELECT id FROM inserted_question), 'Абсолютна гіперглобулінемія', false, 3),
  ((SELECT id FROM inserted_question), 'Білковий склад крові не змінений', false, 4);


-- Question 149
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки надійшла дитина 4-х років з ознаками тривалого білкового голодування: затримка росту, анемія, набряки, розумова відсталість. Причиною розвитку набряків у цієї дитини є зниження синтезу:', NULL, 'medium', 149, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Глікопротеїнів', false, 0),
  ((SELECT id FROM inserted_question), 'Гемоглобіну', false, 1),
  ((SELECT id FROM inserted_question), 'Глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів', false, 3),
  ((SELECT id FROM inserted_question), 'Альбумінів', true, 4);


-- Question 150
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яке ускладення виникне у пацієнта з діагнозом цироз печінки і значним зниженням в сироватці крові вмісту альбуміну та глобуліну?', NULL, 'medium', 150, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Енцефалопатія', false, 0),
  ((SELECT id FROM inserted_question), 'Геморагічний синдром', false, 1),
  ((SELECT id FROM inserted_question), 'Набряки', true, 2),
  ((SELECT id FROM inserted_question), 'Анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Аміноацидурія', false, 4);


-- Question 151
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При тривалому лікуванні голодуванням у пацієнта зменшилось співвідношення альбумінів і глобулінів в плазмі. Що з наведеного буде наслідком цих змін?', NULL, 'medium', 151, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення гематокриту', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження гематокриту', false, 1),
  ((SELECT id FROM inserted_question), 'Гіперкоагуляція', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення ШОЕ', true, 4);


-- Question 152
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для дослідження білків сироватки крові застосовують різні фізичні та фізико-хімічні методи. За допомогою якого методу можна розділити альбуміни і глобуліни сироватки крові?', NULL, 'medium', 152, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електрофорезу', true, 0),
  ((SELECT id FROM inserted_question), 'Діалізу', false, 1),
  ((SELECT id FROM inserted_question), 'Рефрактометрії', false, 2),
  ((SELECT id FROM inserted_question), 'Полярографії', false, 3),
  ((SELECT id FROM inserted_question), 'Спектрофотометрії', false, 4);


-- Question 153
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унаслідок токсичного ушкодження клітин печінки з порушенням білковосинтезуючої функції у пацієнта спостерігаються різко знижені кількість альбумінів у плазмі крові та онкотичний тиск. Яке явище буде наслідком цих змін?', NULL, 'medium', 153, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення діурезу', false, 0),
  ((SELECT id FROM inserted_question), 'Збільшення темпу діурезу', false, 1),
  ((SELECT id FROM inserted_question), 'Поява набряків', true, 2),
  ((SELECT id FROM inserted_question), 'Зменшення ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення густини крові', false, 4);


-- Question 154
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Електрофоретичне дослідження сироватки крові хворого пневмонією показало збільшення одної з білкових фракцій. Вкажіть її:', NULL, 'medium', 154, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'β-глобуліни', false, 0),
  ((SELECT id FROM inserted_question), 'α1 -глобуліни', false, 1),
  ((SELECT id FROM inserted_question), 'γ-глобуліни', true, 2),
  ((SELECT id FROM inserted_question), 'α2 -глобуліни', false, 3),
  ((SELECT id FROM inserted_question), 'Альбуміни', false, 4);


-- Question 155
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінці 36-ти років після хірургічного втручання внутрішньовенно ввели концентрований розчин альбуміну. Це спричинило посилений рух води в такому напрямку:', NULL, 'medium', 155, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Змін руху води не відбуватиметься', false, 0),
  ((SELECT id FROM inserted_question), 'Із капілярів до міжклітинної рідини', false, 1),
  ((SELECT id FROM inserted_question), 'З міжклітинної рідини до клітин', true, 2),
  ((SELECT id FROM inserted_question), 'Із клітин до міжклітинної рідини', false, 3),
  ((SELECT id FROM inserted_question), 'З міжклітинної рідини до капілярів', false, 4);


-- Question 156
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При тривалому лікуванні голодуванням у пацієнта зменшилося співвідношення альбумінів і глобулінів у плазмі крові. Що з наведеного буде наслідком цих змін?', NULL, 'medium', 156, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення гематокритного показника', false, 0),
  ((SELECT id FROM inserted_question), 'Збільшення ШОЕ', true, 1),
  ((SELECT id FROM inserted_question), 'Зниження гематокритного показника', false, 2),
  ((SELECT id FROM inserted_question), 'Гіперкоагуляція', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження ШОЕ', false, 4);


-- Question 157
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові хворого виявлено низький рівень альбумінів та фібриногену. Зниження активності яких органел гепатоцитів найбільш вірогідно обумовлює це явище?', NULL, 'medium', 157, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Агранулярна ендоплазматична сітка', false, 0),
  ((SELECT id FROM inserted_question), 'Комплекс Гольджі', false, 1),
  ((SELECT id FROM inserted_question), 'Лізосоми', false, 2),
  ((SELECT id FROM inserted_question), 'Гранулярна ендоплазматична сітка', true, 3),
  ((SELECT id FROM inserted_question), 'Мітохондрії', false, 4);


-- Question 158
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові хворого концентрація альбумінів складає 2,8 г/л, підвищена концентрація лактатдегідрогенази 5 (ЛДГ5). Про захворювання якого органа це свідчить?', NULL, 'medium', 158, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Печінка', true, 0),
  ((SELECT id FROM inserted_question), 'Серце', false, 1),
  ((SELECT id FROM inserted_question), 'Легеня', false, 2),
  ((SELECT id FROM inserted_question), 'Нирка', false, 3),
  ((SELECT id FROM inserted_question), 'Селезінка', false, 4);


-- Question 159
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як зміниться фармакологічна активність препарату з високою спорідненістю до білків плазми крові при виникненні гіпоальбумінемії?', NULL, 'medium', 159, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищиться', true, 0),
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 1),
  ((SELECT id FROM inserted_question), 'Суттєво зменшиться', false, 2),
  ((SELECT id FROM inserted_question), 'Зникне', false, 3),
  ((SELECT id FROM inserted_question), 'Дещо зменшиться', false, 4);


-- Question 160
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яке ускладення виникне у пацієнта з діагнозом цироз печінки і значним зниженням в сироватці крові вмісту альбуміну та глобуліну?', NULL, 'medium', 160, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аміноацидурія', false, 0),
  ((SELECT id FROM inserted_question), 'Набряки', true, 1),
  ((SELECT id FROM inserted_question), 'Енцефалопатія', false, 2),
  ((SELECT id FROM inserted_question), 'Геморагічний синдром', false, 3),
  ((SELECT id FROM inserted_question), 'Анемія', false, 4);


-- Question 161
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 49-ти років на гострий панкреатит виникала загроза некрозу підшлункової залози, що супроводжувалось надходженням у кров і тканини активних панкреатичних протеїназ і розщеплення тканинних білків. Які захисні фактори організму можуть інгібувати ці процеси?', NULL, 'medium', 161, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кріоглобулін, інтерферон', false, 0),
  ((SELECT id FROM inserted_question), 'Імуноглобуліни', false, 1),
  ((SELECT id FROM inserted_question), 'α2-макроглобулін, α1-антитрипсин', true, 2),
  ((SELECT id FROM inserted_question), 'Гемоплексин, гаптоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін, трансферин', false, 4);


-- Question 162
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта 28-ми років, який знаходиться в пульмонологічному відділенні, діагностовано емфізему легенів, яка виникла внаслідок розщеплення міжальвеолярних перетинок тканинним трипсином. Уроджена недостатність якого білка спричинила розвиток захворювання?', NULL, 'medium', 162, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 1),
  ((SELECT id FROM inserted_question), 'а2-макроглобулін', false, 2),
  ((SELECT id FROM inserted_question), 'аі-протеїназний інгібітор', true, 3),
  ((SELECT id FROM inserted_question), 'Кріоглобулін', false, 4);


-- Question 163
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 27 років виявлено патологічні зміни печінки і головного мозку. У плазмі крові спостерігається різке зниження вмісту міді, а в сечі — її підвищення. Встановлено діагноз: хвороба Вільсона. Активність якого ферменту необхідно дослідити в сироватці крові для підтвердження діагнозу?', NULL, 'medium', 163, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкогольдегідрогенази', false, 0),
  ((SELECT id FROM inserted_question), 'Церулоплазміну', true, 1),
  ((SELECT id FROM inserted_question), 'Ксантиноксидази', false, 2),
  ((SELECT id FROM inserted_question), 'Лейцинамінопептидази', false, 3),
  ((SELECT id FROM inserted_question), 'Карбоангідрази', false, 4);


-- Question 164
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При хворобі Вільсона-Коновалова порушується транспорт міді, що призводить до накопичення цього металу в клітинах мозку та печінки. З порушенням синтезу якого білку це пов’язано?', NULL, 'medium', 164, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Транскобаламін', false, 0),
  ((SELECT id FROM inserted_question), 'Металотіонеїн', false, 1),
  ((SELECT id FROM inserted_question), 'Сидерофілін', false, 2),
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін', true, 4);


-- Question 165
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка віком 35 років зі встановленим діагнозом: гепатоцеребральна дистрофія в сироватці крові знижений вміст церулоплазміну. Накопичення якого елемента в печінці, мозку та нирках спостерігається в пацієнта?', NULL, 'medium', 165, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калію', false, 0),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію', false, 2),
  ((SELECT id FROM inserted_question), 'Міді', true, 3),
  ((SELECT id FROM inserted_question), 'Заліза', false, 4);


-- Question 166
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для розвитку гарячкових станів характерним є зростання рівня білків "гострої фази" - церулоплазміну, фібриногену, С-реактивного протеїну. Укажіть можливий механізм цього явища:', NULL, 'medium', 166, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стимулювальний вплив ІЛ-1 на гепатоцити', true, 0),
  ((SELECT id FROM inserted_question), 'Руйнівна дія підвищеної температури на клітини організму', false, 1),
  ((SELECT id FROM inserted_question), 'Дегрануляція тканинних базофілів', false, 2),
  ((SELECT id FROM inserted_question), 'Проліферативна дія ІЛ-2 на Т-лімфоцити', false, 3);


-- Question 167
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людини трапляється спадкова хвороба, симптомокомплекс якої поєднує в собі цироз печінки та дистрофічні процеси головного мозку. Вона супроводжується зменшенням вмісту церулоплазміну в плазмі крові та порушенням обміну міді в організмі. Це хвороба:', NULL, 'medium', 167, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жильбера', false, 0),
  ((SELECT id FROM inserted_question), 'Вільсона-Коновалова', true, 1),
  ((SELECT id FROM inserted_question), 'Тея-Сакса', false, 2),
  ((SELECT id FROM inserted_question), 'Марфана', false, 3),
  ((SELECT id FROM inserted_question), 'Німанна-Піка', false, 4);


-- Question 168
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Біохімічний аналіз сироватки крові пацієнта з гепатолентикулярною дегенерацією (хвороба Вільсона-Коновалова) виявив зниження вмісту церулоплазміну. У цього пацієнта в сироватці крові буде підвищена концентрація таких іонів:', NULL, 'medium', 168, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Калій', false, 0),
  ((SELECT id FROM inserted_question), 'Мідь', true, 1),
  ((SELECT id FROM inserted_question), 'Кальцій', false, 2),
  ((SELECT id FROM inserted_question), 'Натрій', false, 3),
  ((SELECT id FROM inserted_question), 'Фосфор', false, 4);


-- Question 169
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка 33 років страждає на гепатоцеребральну дистрофію (хвороба Вільсона). У крові - знижений вміст церулоплазміну. У сечі - різко підвищений вміст амінокислот. Посиленням якого процесу зумовлені ці зміни?', NULL, 'medium', 169, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Комплексоутворення амінокислот з міддю', true, 0),
  ((SELECT id FROM inserted_question), 'Розпад тканинних 6ілків', false, 1),
  ((SELECT id FROM inserted_question), 'Переамінування амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Синтез сечовини', false, 3),
  ((SELECT id FROM inserted_question), 'Глюконеогенез', false, 4);


-- Question 170
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У плазмі крові здорової людини знаходиться декілька десятків білків. При захворюванні організму з’являються нові білки, зокрема "білок гострої фази". Таким білком є:', NULL, 'medium', 170, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Протромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 1),
  ((SELECT id FROM inserted_question), 'Імуноглобулін G', false, 2),
  ((SELECT id FROM inserted_question), 'Імуноглобулін А', false, 3),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', true, 4);


-- Question 171
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 38-ми років ревматизм в активній фазі. Визначення якого лабораторного показника сироватки крові має діагностичне значення при даній патології?', NULL, 'medium', 171, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сечовина', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', true, 1),
  ((SELECT id FROM inserted_question), 'Трансферин', false, 2),
  ((SELECT id FROM inserted_question), 'Креатинін', false, 3),
  ((SELECT id FROM inserted_question), 'Сечова кислота', false, 4);


-- Question 172
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнтка віком 45 років скаржиться на біль у дрібних суглобах кистей, що посилюється вранці, набряклість суглобів, ранкову скутість. Лабораторно виявлено ревматоїдний фактор та С-реактивний білок. Під час біопсії ураженої синовіальної оболонки виявлено: розростання ворсин, руйнування хряща: судинна гіперемія, лімфоплазмоцитарна інфільтрація, утворення панусу, що пошкоджує хрящ і субхондральну кістку. Який найімовірніший діагноз?', NULL, 'medium', 172, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Подагричний артрит', false, 0),
  ((SELECT id FROM inserted_question), 'Ревматоїдний артрит', true, 1),
  ((SELECT id FROM inserted_question), 'Септичний артрит', false, 2),
  ((SELECT id FROM inserted_question), 'Остеоартроз', false, 3),
  ((SELECT id FROM inserted_question), 'Реактивний артрит', false, 4);


-- Question 173
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При активації запального процесу, деяких аутоімунних та інфекційних захворюваннях у плазмі крові різко зростає рівень білків гострої фази. Який із наведених нижче білків здатний утворювати гель при охолодженні сироватки?', NULL, 'medium', 173, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаптоглобін', false, 0),
  ((SELECT id FROM inserted_question), 'С-реактивний білок', false, 1),
  ((SELECT id FROM inserted_question), 'а2-макроглобін', false, 2),
  ((SELECT id FROM inserted_question), 'Кріоглобулін', true, 3),
  ((SELECT id FROM inserted_question), 'Церулоплазмін', false, 4);


-- Question 174
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У забезпеченні імунного захисту новонароджених важливу роль відіграють імуноглобуліни матері, які проходять через плацентарний бар’єр у кров плода. Який це тип імуноглобулінв?', NULL, 'medium', 174, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgG', true, 1),
  ((SELECT id FROM inserted_question), 'IgM', false, 2),
  ((SELECT id FROM inserted_question), 'IgD', false, 3),
  ((SELECT id FROM inserted_question), 'IgE', false, 4);


-- Question 175
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Коли чужорідний агент потрапляє в організм, синтез двох класів імуноглобулінів починається майже паралельно, але в одного з них зростання і падіння кількості концентрації відбувається швидше. Які це два класи імуноглобулінів?', NULL, 'medium', 175, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG і IgD', false, 0),
  ((SELECT id FROM inserted_question), 'IgA і IgD', false, 1),
  ((SELECT id FROM inserted_question), 'IgM і IgD', false, 2),
  ((SELECT id FROM inserted_question), 'IgA і IgG', false, 3),
  ((SELECT id FROM inserted_question), 'IgM і IgG', true, 4);


-- Question 176
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Профілактичні щеплення проти поліомієліту провели інактивованою вакциною, яку вводили парентерально. Які імуноглобуліни відповідають у цьому випадку за створення поствакцинального імунітету?', NULL, 'medium', 176, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сироваткові Ig А, Ig M', false, 0),
  ((SELECT id FROM inserted_question), 'Ig M, Ig G', true, 1),
  ((SELECT id FROM inserted_question), 'Ig Е, Ig M', false, 2),
  ((SELECT id FROM inserted_question), 'Ig M, секреторні Ig A', false, 3),
  ((SELECT id FROM inserted_question), 'Ig G, секреторні Ig A', false, 4);


-- Question 177
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки діагностовано гострий період захворювання на ГРВІ. Імуноглобуліни якого класу, ймовірно, будуть присутні в крові пацієнтки?', NULL, 'medium', 177, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgG', false, 1),
  ((SELECT id FROM inserted_question), 'IgE', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', true, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 178
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 178, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 179
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 179, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 180
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 180, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 181
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 181, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 182
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 182, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 183
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 34-х років після перенесеної кишкової інфекції, викликаної сальмонелами, стали згасати симптоми захворювання. Імуноглобуліни якого класу будуть виявлені в крові хворого в період реконвалесценції?', NULL, 'medium', 183, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG', true, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgA', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgD', false, 4);


-- Question 184
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого діагностовано ГРВІ. У сироватці крові знайдено імуноглобуліни класу М. Який період інфекційного процесу в даному випадку?', NULL, 'medium', 184, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий', true, 0),
  ((SELECT id FROM inserted_question), 'Інкубаційний', false, 1),
  ((SELECT id FROM inserted_question), 'Мікробоносійство', false, 2),
  ((SELECT id FROM inserted_question), 'Продромальний', false, 3),
  ((SELECT id FROM inserted_question), 'Реконвалесценція', false, 4);


-- Question 185
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хлопчик на другому році життя став часто хворіти на респіраторні захворювання, стоматити, гнійничкові ураження шкіри. Навіть невеликі пошкодження ясен і слизової ускладнюються запаленням, що протікає тривало. Встановлено, що у крові дитини практично відсутні імуноглобуліни усіх класів. Зниження функціональної активності якої клітинної популяції лежить в основі описаного синдрому?', NULL, 'medium', 185, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'В-лімфоцити', true, 0),
  ((SELECT id FROM inserted_question), 'NK-лімфоцити', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтрофіли', false, 2),
  ((SELECT id FROM inserted_question), 'Макрофаги', false, 3),
  ((SELECT id FROM inserted_question), 'Т-лімфоцити', false, 4);


-- Question 186
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 27-ми років закрапала в очі краплі, до складу яких входить пеніцилін. Через декілька хвилин з’явився свербіж та печіння тіла, набряк губ та повік, свистячий кашель; став падати артеріальний тиск. Які імуноглобуліни беруть участь в розвитку даної алергічної реакції?', NULL, 'medium', 186, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgG та IgD', false, 0),
  ((SELECT id FROM inserted_question), 'IgA та IgM', false, 1),
  ((SELECT id FROM inserted_question), 'IgE та IgG', false, 2),
  ((SELECT id FROM inserted_question), 'IgM та IgD', false, 3),
  ((SELECT id FROM inserted_question), 'IgM та IgG', false, 4);


-- Question 187
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини 5-ти років діагностовано хворобу Брутона, яка проявляється у важкому перебігу бактеріальних інфекцій, відсутності В-лімфоцитів та плазматичних клітин. Які зміни вмісту імуноглобулінів будуть спостерігатися в сироватці крові цієї дитини?', NULL, 'medium', 187, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення IgA, IgM', true, 0),
  ((SELECT id FROM inserted_question), 'Збільшення IgD, IgE', false, 1),
  ((SELECT id FROM inserted_question), 'Збільшення IgA, IgM', false, 2),
  ((SELECT id FROM inserted_question), 'Змін не буде', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення IgD, IgE', false, 4);


-- Question 188
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обстеження хворого була виявлена недостатня кількість імуноглобулінів. Які з клітин імунної системи їх продукують?', NULL, 'medium', 188, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Плазмобласти', false, 0),
  ((SELECT id FROM inserted_question), 'Т-супресори', false, 1),
  ((SELECT id FROM inserted_question), 'Т-хелпери', false, 2),
  ((SELECT id FROM inserted_question), 'Плазматичні', true, 3),
  ((SELECT id FROM inserted_question), 'Т-кілери', false, 4);


-- Question 189
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед лімфоцитів розрізняють популяцію клітин, що мають мембранні рецептори до IgМ, під впливом специфічних антигенів активуються, мітотично розмножуються, диференціюються у плазматичні клітини, що виробляють антитіла (імуноглобуліни). Укажіть ці клітини.', NULL, 'medium', 189, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Т-лімфоцити памʼяті', false, 0),
  ((SELECT id FROM inserted_question), 'Т-лімфоцити супресори', false, 1),
  ((SELECT id FROM inserted_question), 'В-лімфоцити', true, 2),
  ((SELECT id FROM inserted_question), 'Т-лімфоцити кілери', false, 3);


-- Question 190
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У вагітної жінки виявлені IgM до вірусу краснухи, на підставі чого акушер-гінеколог рекомендував перервати вагітність через високу ймовірність тератогенного впливу на плід. Важливим було виявлення саме Ig M, так як імуноглобуліни цього класу:', NULL, 'medium', 190, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пов''язані з анафілактичними реакціями', false, 0),
  ((SELECT id FROM inserted_question), 'Є показником свіжого зараження', true, 1),
  ((SELECT id FROM inserted_question), 'Мають найбільшу молекулярну вагу', false, 2),
  ((SELECT id FROM inserted_question), 'Можуть долати плацентарний бар''єр', false, 3),
  ((SELECT id FROM inserted_question), 'Є основним фактором противірусного захисту', false, 4);


-- Question 191
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Профілактичні щеплення проти поліомієліту провели інактивованою вакциною, яку вводили парентерально. Які імуноглобуліни відповідають у цьому випадку за створення поствакцинального імунітету?', NULL, 'medium', 191, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сироваткові Ig А, Ig M', false, 0),
  ((SELECT id FROM inserted_question), 'Ig M, Ig G', true, 1),
  ((SELECT id FROM inserted_question), 'Ig Е, Ig M', false, 2),
  ((SELECT id FROM inserted_question), 'Ig M, секреторні Ig A', false, 3),
  ((SELECT id FROM inserted_question), 'Ig G, секреторні Ig A', false, 4);


-- Question 192
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Спадкова гіперліпопротеїнемія І типу обумовлена недостатністю ліпопротеїнліпази. Підвищення рівня яких транспортних форм ліпідів в плазмі навіть натщесерце є характерним?', NULL, 'medium', 192, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ліпопротеїни високої густини', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпопротеїни низької густини', false, 1),
  ((SELECT id FROM inserted_question), 'Хіломікрони', true, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїни дуже низької густини', false, 3),
  ((SELECT id FROM inserted_question), 'Модифіковані ліпопротеїни', false, 4);


-- Question 193
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини діагностовано хворобу Танжера. Укажіть сполуку відсутність якої у сироватці крові дозволила встановити такий діагноз.', NULL, 'medium', 193, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ЛПВЩ', true, 0),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 1),
  ((SELECT id FROM inserted_question), 'ЛПНЩ', false, 2),
  ((SELECT id FROM inserted_question), 'ЛПДНЩ', false, 3),
  ((SELECT id FROM inserted_question), 'ЛППЩ', false, 4);


-- Question 194
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта після курсу лікування атеросклерозу в плазмі крові лабораторно доведено збільшення рівня антиатерогенної фракції ліпопротеїнів. Збільшення рівня яких ліпопротеїнів підтверджує ефективність терапії захворювання?', NULL, 'medium', 194, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ЛПНЩ', false, 0),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 1),
  ((SELECT id FROM inserted_question), 'ЛПДНЩ', false, 2),
  ((SELECT id FROM inserted_question), 'ЛППЩ', false, 3),
  ((SELECT id FROM inserted_question), 'ЛПВЩ', true, 4);


-- Question 195
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Стеатоз виникає внаслідок накопичення триацилгліцеролів у гепатоцитах. Одним з механізмів розвитку цього захворювання є зменшення утилізації нейтрального жиру ЛПДНЩ. Які ліпотропні речовини попереджують розвиток стеатозу?', NULL, 'medium', 195, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Валін, B3 , B2', false, 0),
  ((SELECT id FROM inserted_question), 'Метіонін, B6 , B12', true, 1),
  ((SELECT id FROM inserted_question), 'Аргінін, B2 , B3', false, 2),
  ((SELECT id FROM inserted_question), 'Ізолейцин, B1 , B2', false, 3),
  ((SELECT id FROM inserted_question), 'Аланін, B1 , PP', false, 4);


-- Question 196
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обстеження підлітка, що страждає на ксантоматоз, виявлена сімейна гіперхолестеринемія. Концентрація яких ліпопротеїнів значно підвищена в крові при цій патології?', NULL, 'medium', 196, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ЛПВЩ', false, 0),
  ((SELECT id FROM inserted_question), 'ЛПНЩ', true, 1),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 2),
  ((SELECT id FROM inserted_question), 'ЛПДНЩ', false, 3),
  ((SELECT id FROM inserted_question), 'НЕЖК', false, 4);


-- Question 197
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 70-ти років хворіє на атеросклероз судин нижніх кінцівок та ішемічну хворобу серця. Під час обстеження виявлено порушення ліпідного складу крові. Надлишок яких ліпопротеїнів є головною ланкою в патогенезі атеросклерозу?', NULL, 'medium', 197, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Холестерин', false, 0),
  ((SELECT id FROM inserted_question), 'Проміжної щільності', false, 1),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 2),
  ((SELECT id FROM inserted_question), 'Низької щільності', true, 3),
  ((SELECT id FROM inserted_question), 'Високої щільності', false, 4);


-- Question 198
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обстеженні у хворого виявлено підвищений вміст ліпопротеїнів низької щільності в сироватці крові. Яке захворювання можна очікувати у цього хворого?', NULL, 'medium', 198, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гастрит', false, 0),
  ((SELECT id FROM inserted_question), 'Запалення легенів', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий панкреатит', false, 2),
  ((SELECT id FROM inserted_question), 'Атеросклероз', true, 3),
  ((SELECT id FROM inserted_question), 'Пошкодження нирок', false, 4);


-- Question 199
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта сироватка крові має молочний вигляд. Під час біохімічного дослідження виявлено високий рівень триацилгліцеролів і хіломікронів. Спадковий дефект якого ферменту викликає цей стан?', NULL, 'medium', 199, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Панкреатичної ліпази', false, 0),
  ((SELECT id FROM inserted_question), 'Тканинної гормон-чутливої ліпази', false, 1),
  ((SELECT id FROM inserted_question), 'Фосфоліпази', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнліпази', true, 3),
  ((SELECT id FROM inserted_question), 'Фосфодіестерази', false, 4);


-- Question 200
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 67-ми років вживає з їжею переважно яйця, сало, вершкове масло, молоко, м’ясо. У крові виявлено холестерин 12,3 ммоль/л, загальні ліпіди - 8,2 г/л, підвищені фракції ліпопротеїнів низької щільності (ЛПНЩ). Яка гіпер-ліпопротеїнемія спостерігається у хворого?', NULL, 'medium', 200, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія IV типу', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія І типу', false, 1),
  ((SELECT id FROM inserted_question), 'Холестерин, гіперліпопротеїнемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія ІІа типу', true, 3),
  ((SELECT id FROM inserted_question), 'Гіперліпопротеїнемія IIb типу', false, 4);


-- Question 201
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого хлопчика 12-ти років вміст холестерину в сироватці крові до 25 ммоль/л. В анамнезі - спадкова сімейна гіперхолестеринемія, причиною якої є порушення синтезу білків-рецепторів до:', NULL, 'medium', 201, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів високої щільності', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів низької щільності', true, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів проміжної щільності', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів дуже низької щільності', false, 4);


-- Question 202
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 30 років діагностовано ішемічна хвороба серця. Напади стенокардії турбують вже 3 роки. Виявлено спадковий характер захворювання. Який вид гіперліпопротеїдемії найбільш ймовірно буде виявлено у хворого?', NULL, 'medium', 202, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'V (гіперпребеталіпопротеїдемія і гіперхіломікронемія).', false, 0),
  ((SELECT id FROM inserted_question), 'I (гіперхіломікронемія)', false, 1),
  ((SELECT id FROM inserted_question), 'III (дисбеталіпопротеідемія)', false, 2),
  ((SELECT id FROM inserted_question), 'IV (гіперпребеталіпопротеїдемія)', false, 3),
  ((SELECT id FROM inserted_question), 'II (гіпербеталіпопротеїдемія)', true, 4);


-- Question 203
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 58-ми років хворіє на атеросклероз судин головного мозку. При обстеженні виявлена гіперліпідемія. Вміст якого класу ліпопротеїдів у сироватці крові даного чоловіка найбільш вірогідно буде підвищений?', NULL, 'medium', 203, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ліпопротеїди низької щільності', true, 0),
  ((SELECT id FROM inserted_question), 'Хіломікрони', false, 1),
  ((SELECT id FROM inserted_question), 'Комплекси жирних кислот з альбумінами', false, 2),
  ((SELECT id FROM inserted_question), 'Холестерин', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїди високої щільності', false, 4);


-- Question 204
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий на атеросклероз приймає антисклеротичний засіб - фенофібрат. Який механізм дії має цей засіб?', NULL, 'medium', 204, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Знижує рівень хіломікронів', false, 0),
  ((SELECT id FROM inserted_question), 'Інгібує абсорбцію холестерину в ШКТ', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищує захоплення ліпопротеїдів низької щільності та блокує біосинтез ендогенного холестерину', true, 2),
  ((SELECT id FROM inserted_question), 'Поновлює негативний електричний заряд ендотелію судин', false, 3),
  ((SELECT id FROM inserted_question), 'Поліпшує мікроциркуляцію крові', false, 4);


-- Question 205
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта сироватка крові має молочний вигляд. Під час біохімічного дослідження виявлено високий рівень триацилгліцеролів і хіломікронів. Спадковий дефект якого ферменту викликає цей стан?', NULL, 'medium', 205, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тканинної гормончутливої ліпази', false, 0),
  ((SELECT id FROM inserted_question), 'Фосфодіестерази', false, 1),
  ((SELECT id FROM inserted_question), 'Фосфоліпази', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнлінази', true, 3),
  ((SELECT id FROM inserted_question), 'Панкреатичної ліпази', false, 4);


-- Question 206
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хлопчика 11-ти років вміст холестерину в сироватці крові до 25 ммоль/л. В анамнезі - спадкова сімейна гіперхолестеринемія, причиною якої є порушення синтезу білків-рецепторів до:', NULL, 'medium', 206, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хіломікронів', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів низької щільності', true, 1),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів дуже низької щільності', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів високої щільності', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпопротеїнів проміжної щільності', false, 4);


-- Question 207
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з ішемічною хворобою серця виявлено підвищений вміст тригліцеридів і ліпопротеїнів низької щільності в плазмі крові. Який препарат необхідно призначити в цьому разі?', NULL, 'medium', 207, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Добутамін', false, 0),
  ((SELECT id FROM inserted_question), 'Аміодарон', false, 1),
  ((SELECT id FROM inserted_question), 'Фенофібрат', true, 2),
  ((SELECT id FROM inserted_question), 'Фамотидин', false, 3),
  ((SELECT id FROM inserted_question), 'Лізиноприл', false, 4);


-- Question 208
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на ішемічну хворобу серця виявлено підвищений вміст тригліцеридів і ліпопротеїнів низької щільності в плазмі крові. Який препарат слід призначити?', NULL, 'medium', 208, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Добутамін', false, 0),
  ((SELECT id FROM inserted_question), 'Аміодарон', false, 1),
  ((SELECT id FROM inserted_question), 'Лізиноприл', false, 2),
  ((SELECT id FROM inserted_question), 'Фамотидин', false, 3),
  ((SELECT id FROM inserted_question), 'Фенофібрат', true, 4);


-- Question 209
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У патогенезі розвитку II типу гіперліпопротеїнемії (сімейна гіперхолестеролемія) провідну роль відіграє дефіцит рецепторів до апобілка ЛПНЩ. Назвіть його:', NULL, 'medium', 209, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апо В48', false, 0),
  ((SELECT id FROM inserted_question), 'Апо ВСІ', false, 1),
  ((SELECT id FROM inserted_question), 'Апо СІІ', false, 2),
  ((SELECT id FROM inserted_question), 'Апо В100', true, 3),
  ((SELECT id FROM inserted_question), 'Апо А1', false, 4);


COMMIT;
