BEGIN;

-- Auto-generated from: /Users/bohdanpavliuk/Downloads/Untitled document.txt
-- Questions parsed: 145

INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
SELECT c.id, 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття', 'Імпорт із Untitled document.txt для розділу 17', 16, true, NOW(), NOW()
FROM courses c
WHERE c.title = 'Фундаментальні медико-біологічні знання'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття');

-- Delete previous questions/options in this topic
DELETE FROM question_options
WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
);

DELETE FROM questions
WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  LIMIT 1
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла плода від другої вагітності Rh-негативної матері, який помер внутрішньоутробно на сьомому місяці вагітності, виявлено поширені набряки підшкірної клітковини та головного мозку, асцит, збільшену печінку та селезінку, атрофію тимуса та гіпертрофію міокарда. Мікроскопічно спостерігається: осередки екстрамедулярного кровотворення, дистрофічні та некробіотичні зміни у внутрішніх органах. Для якого', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вродженої жовтяничної форма гемолітичної хвороби', false, 0),
  ((SELECT id FROM inserted_question), 'Анемічної форми гемолітичної хвороби', false, 1),
  ((SELECT id FROM inserted_question), 'Геморагічної хвороби новонароджених', false, 2),
  ((SELECT id FROM inserted_question), 'Набрякової форми гемолітичної хвороби', true, 3),
  ((SELECT id FROM inserted_question), 'Післяпологової жовтяничної форми гемолітичної хвороби', false, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У резус-негативної дитини, народженої від резус-позитивної матері, виникла гемолітична хвороба новонароджених. Які з класів антитіл викликають гемоліз еритроцитів і, таким чином, мають провідну ланку в патогенезі захворювання?', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgA', false, 0),
  ((SELECT id FROM inserted_question), 'IgE', false, 1),
  ((SELECT id FROM inserted_question), 'IgD', false, 2),
  ((SELECT id FROM inserted_question), 'IgM', false, 3),
  ((SELECT id FROM inserted_question), 'IgG', true, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки з III (B), Rh (-) групою крові народилася дитина з ІІ (А) групою. У дитини діагностовано гемолітичну хворобу новонароджених, спричинену резус-конфліктом. Яка група крові та резус-фактор можливі у батька?', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'II (A), Rh (-)', false, 0),
  ((SELECT id FROM inserted_question), 'IIІ (В), Rh (+)', false, 1),
  ((SELECT id FROM inserted_question), 'I (0), Rh (-)', false, 2),
  ((SELECT id FROM inserted_question), 'I (0), Rh (+)', false, 3),
  ((SELECT id FROM inserted_question), 'II (A), Rh (+)', true, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки з резус-негативною кров''ю ІІ групи народилася дитина з ІV групою, у якої діагностували гемолітичну хворобу внаслідок резус-конфлікту. Яка група крові можлива у батька дитини?', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IV (AB), резус-негативна', false, 0),
  ((SELECT id FROM inserted_question), 'III (B), резус-негативна', false, 1),
  ((SELECT id FROM inserted_question), 'III (B), резус-позитивна', true, 2),
  ((SELECT id FROM inserted_question), 'I (O), резус-позитивна', false, 3),
  ((SELECT id FROM inserted_question), 'II (A), резус-позитивна', false, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини з гемолітичною хворобою новонародженого розвинулася енцефалопатія. Збільшення вмісту якої речовини в крові спричинило ураження центральної нервової системи (ЦНС)?', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жовчної кислоти', false, 0),
  ((SELECT id FROM inserted_question), 'Комплексу білірубін-альбуміну', false, 1),
  ((SELECT id FROM inserted_question), 'Білірубін-глюкуроніду', false, 2),
  ((SELECT id FROM inserted_question), 'Вільного білірубіну', true, 3),
  ((SELECT id FROM inserted_question), 'Вердоглобіну', false, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 20-ти років з жовтяницею встановлено: підвищення у плазмі крові вмісту загального білірубіну за рахунок непрямого (вільного), в калі та сечі - високий вміст стеркобіліну, рівень прямого (зв’язаного) білірубіну в плазмі крові в межах норми. Про який вид жовтяниці можна думати?', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', true, 0),
  ((SELECT id FROM inserted_question), 'Паренхіматозна (печінкова)', false, 1),
  ((SELECT id FROM inserted_question), 'Механічна', false, 2),
  ((SELECT id FROM inserted_question), 'Жовтяниця немовлят', false, 3),
  ((SELECT id FROM inserted_question), 'Хвороба Жильбера', false, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на мікросфероцитарну гемолітичну анемію (хворобу Мінковського-Шоффара) внаслідок підвищення проникності мембрани еритроцитів у клітину надходять іони натрію й вода. Еритроцити набувають форми сфероцитів і легко руйнуються. Який провідний механізм пошкодження еритроцитів у цьому разі?', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кальцієвий', false, 0),
  ((SELECT id FROM inserted_question), 'Нуклеїновий', false, 1),
  ((SELECT id FROM inserted_question), 'Електролітно-осмотичний', true, 2),
  ((SELECT id FROM inserted_question), 'Протеїновий', false, 3),
  ((SELECT id FROM inserted_question), 'Ацидотичний', false, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на малярію після вживання протималярійного препарату примахіну розвинулася гемолітична анемія. Спадкова недостатність якого ферменту в еритроцитах спостерігається при цьому?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тріозофосфатізомерази', false, 0),
  ((SELECT id FROM inserted_question), 'Фосфофруктокінази', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпази', false, 2),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', true, 3),
  ((SELECT id FROM inserted_question), 'Фруктозо-1-фосфатальдолази', false, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого час від часу суттєво знижується вміст гемоглобіну і еритроцитів в крові, з’являється жовтяниця. З анамнезу з’ясовано, що ці напади завжди виникають після вживання кінських бобів. Яка з форм анемії має місце у даного хворого?', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Спадкова гемоглобінопатія', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкова ферментопатія', true, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Спадкова мембранопатія', false, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час проведення морфологічного дослідження периферичної крові хворого було помічено, що у еритроцитів забарвлена лише периферична частина, а в центрі є незабарвлене прояснення. Кольоровий показник - 0,56. Яка анемія найімовірніша у цього пацієнта?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сидеробластна', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', true, 1),
  ((SELECT id FROM inserted_question), 'В₁₂ - фолієводефіцитна', false, 2),
  ((SELECT id FROM inserted_question), 'Апластична', false, 3),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В аналізі крові 35-річного хворого: Нb = 58 г/л, еритроцити = 1,3•10^12/л, колірний показник = 1,3, лейкоцити = 2,8•10^9/л, тромбоцити = 1,1•10^9/л, ретикулоцити = 2%, ШОЕ = 35 мм/год. Визначаються полісегментовані нейтрофіли, а також тільця Жоллі, кільця Кебота, мегалоцити. Яка це анемія?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 0),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', true, 1),
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 2),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 3),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 36-ти років, яка лікувалася сульфаніламідами з приводу респіраторної вірусної інфекції, в крові спостерігаються гіпорегенераторна нормохромна анемія, лейкопенія, тромбоцитопенія. В кістковому мозку - зменшення кількості мієлокаріоцитів. Яка це анемія?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', true, 1),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 2),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 3),
  ((SELECT id FROM inserted_question), 'В 12-фолієводефіцитна', false, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 12-ти років поступив в клініку з гемартрозом колінного суглоба, з раннього дитинства страждає кровоточивістю. Яка хвороба у хлопчика?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемофілія', true, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенічна пурпура', false, 1),
  ((SELECT id FROM inserted_question), 'Геморагічний васкуліт', false, 2),
  ((SELECT id FROM inserted_question), 'B12 фолієво-дефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Гемолітична анемія', false, 4);


-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з жовтяницею встановлено: підвищення у плазмі крові вмісту загального білірубіну за рахунок непрямого (вільного), в калі та сечі - високий вміст стеркобіліну, рівень прямого (зв’язаного) білірубіну в плазмі крові в межах норми. Про який вид жовтяниці можна думати?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Механічна', false, 0),
  ((SELECT id FROM inserted_question), 'Жовтяниця немовлят', false, 1),
  ((SELECT id FROM inserted_question), 'Хвороба Жильбера', false, 2),
  ((SELECT id FROM inserted_question), 'Гемолітична', true, 3),
  ((SELECT id FROM inserted_question), 'Паренхіматозна (печінкова)', false, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 52-х років при обстеженні було виявлено зниження кількості еритроцитів у крові та підвищення рівня вільного гемоглобіну в плазмі крові (гемоглобінемія). КП- 0,85. Який вид анемії спостерігається у хворої?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', false, 0),
  ((SELECT id FROM inserted_question), 'Набута гемолітична', true, 1),
  ((SELECT id FROM inserted_question), 'Анемія внаслідок порушення еритропоезу', false, 2),
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична', false, 3),
  ((SELECT id FROM inserted_question), 'Іостра постгеморагічна', false, 4);


-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з гемолітичною анемією виявлено дефіцит піруваткінази в еритроцитах. За цих умов причиною розвитку гемолізу еритроцитів є:', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нестача Na+ в еритроцитах', false, 0),
  ((SELECT id FROM inserted_question), 'Генетичні дефекти глікофорину А', false, 1),
  ((SELECT id FROM inserted_question), 'Надлишок К + в еритроцитах', false, 2),
  ((SELECT id FROM inserted_question), 'Дефіцит спектрину', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення активності Na+, К+ -АТФ-ази', true, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 50-ти років при обстеженні було виявлено зниження кількості еритроцитів у крові та підвищення рівня вільного гемоглобіну в плазмі крові (гемоглобінемія). КП становив 0,85. Який вид анемії спостерігається у хворого?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 1),
  ((SELECT id FROM inserted_question), 'Набута гемолітична', true, 2),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', false, 3),
  ((SELECT id FROM inserted_question), 'Анемія внаслідок порушення еритропоезу', false, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 20-ти років з жовтяницею встановлено: підвищення у плазмі крові вмісту загального білірубіну за рахунок непрямого (вільного), в калі та сечі - високий вміст стеркобіліну, рівень прямого (зв’язаного) білірубіну в плазмі крові в межах норми. Про який вид жовтяниці можна думати?', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Паренхіматозна (печінкова)', false, 0),
  ((SELECT id FROM inserted_question), 'Жовтяниця немовлят', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична', true, 2),
  ((SELECT id FROM inserted_question), 'Механічна', false, 3),
  ((SELECT id FROM inserted_question), 'Хвороба Жильбера', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з’явилися жовтушність шкіри, склер та слизових оболонок. У плазмі крові підвищений рівень загального білірубіну, в калі - рівень стеркобіліну, в сечі - уробіліну. Який вид жовтяниці у хворого?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Паренхіматозна', false, 0),
  ((SELECT id FROM inserted_question), 'Хвороба Жільбера', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична', true, 2),
  ((SELECT id FROM inserted_question), 'Холестатична', false, 3),
  ((SELECT id FROM inserted_question), 'Обтураційна', false, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого виявлена аутоімунна гемолітична анемія, що розвивається за цитотоксичним типом. Які речовини є антигенами при алергічних реакціях II типу?', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сироваткові білки', false, 0),
  ((SELECT id FROM inserted_question), 'Модифіковані рецептори клітинних мембран', true, 1),
  ((SELECT id FROM inserted_question), 'Гормони', false, 2),
  ((SELECT id FROM inserted_question), 'Антибіотики', false, 3),
  ((SELECT id FROM inserted_question), 'Модулятори запалення', false, 4);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 56-ти років потрапив до клініки зі скаргами на загальну слабкість, біль і печіння в язиці, відчуття оніміння в кінцівках. У минулому переніс резекцію кардіального відділу шлунка. У крові: Hb- 80 г/л; ер.- 2,0 • 10^12/л; КП-1,2, лейк.- 3,5 • 10^9 /л. Який вид анемії у цього хворого?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 1),
  ((SELECT id FROM inserted_question), 'Апластична', false, 2),
  ((SELECT id FROM inserted_question), 'В12 –фолієводефіцитна', true, 3),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка 55-ти років звернулася зі скаргами на тривалі циклічні маткові кровотечі протягом року, слабкість, запаморочення. Об’єктивно: блідість шкіри. У крові: Hb- 70 г/л, ер.- 3,2•10^12/л, КП- 0,6, лейк.- 6,0•10^9 /л, ретикулоцити -1%; гіпохромія еритроцитів. Яка анемія у хворої?', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Апластична', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', true, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 3),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого відзначається підвищена чутливість шкіри до сонячного світла. Його сеча при тривалому стоянні набуває темно-червоного кольору. Яка найбільш імовірна причина такого стану?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Алкаптонурія', false, 0),
  ((SELECT id FROM inserted_question), 'Порфірія', true, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична жовтяниця', false, 2),
  ((SELECT id FROM inserted_question), 'Альбінізм', false, 3),
  ((SELECT id FROM inserted_question), 'Пелагра', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час гемотрансфузій рекомендується переливати кров лише відповідної групи. Вкажіть, чим зумовлена приналежність до певної групи крові за системою АВ0.', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вуглеводними детермінантами мембран лейкоцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Білками сироватки крові', false, 1),
  ((SELECT id FROM inserted_question), 'Вуглеводними детермінантами мембран еритроцитів', true, 2),
  ((SELECT id FROM inserted_question), 'Білковими детермінантами мембран еритроцитів', false, 3),
  ((SELECT id FROM inserted_question), 'Білково-полісахаридними компонентами лейкоцитів', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінці під час пологів було проведено гемотрансфузію кровʼю донора, який прибув із Південної Африки. За два тижні у реципієнтки виникла лихоманка. Встановлено попередній діагноз:малярія. Яке лабораторне дослідження потрібно провести для підтвердження діагнозу?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вивчення пунктату лімфатичних вузлів', false, 0),
  ((SELECT id FROM inserted_question), 'Вивчення лейкоцитарної формули', false, 1),
  ((SELECT id FROM inserted_question), 'Визначення збудника методом посіву крові на живильне середовище', false, 2),
  ((SELECT id FROM inserted_question), 'Проведення серологічних досліджень', false, 3),
  ((SELECT id FROM inserted_question), 'Вивчення мазка і товстої краплі крові для виявлення еритроцитарних стадій збудника', true, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого переливання крові ускладнилося розвитком гемотрансфузійного шоку. Назвіть тип алергічної реакції, що лежить в основі даної патології:', NULL, 'medium', 26, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперчутливість сповільненого типу', false, 0),
  ((SELECT id FROM inserted_question), 'Анафілактичний', false, 1),
  ((SELECT id FROM inserted_question), 'Рецептороопосередкований', false, 2),
  ((SELECT id FROM inserted_question), 'Імунокомплексний', false, 3),
  ((SELECT id FROM inserted_question), 'Цитотоксичний', true, 4);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У вагітної жінки 24-х років після тривалого блювання було зареєстровано зниження об’єму циркулюючої крові. Про яку зміну загальної кількості крові може йти мова?', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поліцитемічна гіповолемія', true, 0),
  ((SELECT id FROM inserted_question), 'Олігоцитемічна гіповолемія', false, 1),
  ((SELECT id FROM inserted_question), 'Олігоцитемічна гіперволемія', false, 2),
  ((SELECT id FROM inserted_question), 'Проста гіповолемія', false, 3),
  ((SELECT id FROM inserted_question), 'Поліцитемічна гіперволемія', false, 4);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта віком 35 років шпиталізовано з великою крововтратою через автодорожню пригоду. У нього спостерігається: пульс – 110/хв, ЧД — 22/хв, АТ - 100/60 мм рт. Ст. Які зміни у крові пацієнта відбудуться через годину після крововтрати?', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпохромія еритроцитів', false, 1),
  ((SELECT id FROM inserted_question), '-', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпопротеінемія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіповолемія', true, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки доставили пацієнта 32-х років з масивною крововтратою внаслідок ДТП. Ps- 110/хв., ЧДР- 22 за 2 хв, АТ- 100/60 мм рт.ст. Яка зміна крові з перерахованих буде найбільш характерною через 1 годину після крововтрати?', NULL, 'medium', 29, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопротеїнемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпохромія еритроцитів', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіповолемія', true, 3),
  ((SELECT id FROM inserted_question), 'Еритропенія', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіка 49 років доставили з місця автомобільної аварії в лікарню в непритомному стані. Шкірні покриви бліді, пульс частий і поверхневий. Переломів кісток і пошкодження головного мозку не виявлено. При пункції черевної порожнини отримано значну кількість крові. Первинною причиною тяжкого стану потерпілого є', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпокатріємія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопротеїнемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіповолемія', true, 2),
  ((SELECT id FROM inserted_question), 'Еритропенія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоінсулінемія', false, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У лікарні у хворого діагностована анемія. Під час збору анамнезу виявлено, що пацієнт вже декілька років хворий на виразкову хворобу шлунка. Який вид анемії, скоріше за все, у цього хворого?', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна анемія', true, 0),
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкова гемолітична анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна анемія', false, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, '50-річна жінка скаржиться на часті головні болі, запаморочення і задишку під час фізичного навантаження. Протягом 3 останніх років у неї були довгі та рясні менструації. Під час фізикального обстеження пацієнтка нормостенічна, її шкіра бліда та суха. Аналіз крові: Нв – 90 г/л, еритроцити – 3,7 х 1012/л кольоровий показник – 0,7, ШОЕ 20 мм/год, ознаки гіпохромії еритроцитів, анізоцитоз, пойкілоцитоз. Який тип анемії найімовірніша у пацієнтки?', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 1),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', true, 2),
  ((SELECT id FROM inserted_question), 'Серповидно-клітинна', false, 3),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка 55-ти років звернулася зі скаргами на тривалі циклічні маткові кровотечі протягом року, слабкість, запаморочення. Об’єктивно: блідість шкіри. У крові: Hb- 70 г/л, ер.- 3,2•10^12/л, КП- 0,6, лейк.- 6,0•10^9 /л, ретикулоцити -1%; гіпохромія еритроцитів. Яка анемія у хворої?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Апластична', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічна постгеморагічна', true, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 3),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в анамнезі: з дитинства відмічався знижений рівень гемоглобіну. Лікування препаратами заліза не дає ефекту. У крові: ер.- 3,1 • 10^12/л, ретик.-16%, Hb- 85 г/л, КП0,75; в мазку крові анізоцити, пойкілоцити, мішенеподібні еритроцити, еритроцити з базофільною зернистістю, рівень заліза у сироватці 30 мкмоль/л. Для якої патології системи крові характерні такі дані?', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фолієводефіцитна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'B12-дефіцитна анемія', false, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 19-ти років з дитинства відмічалося зниження гемоглобіну до 90-95 г/л. У крові під час госпіталізації: ер.- 3, 2 • 10^12/л, Hb- 85 г/л, КП- 0,78; лейк.- 5, 6 • 10^9/л, тромб.- 210 • 10^9 /л. У мазку: анізоцитоз, пойкілоцитоз, мішенеподібні еритроцити. Ретикулоцити - 6%. Лікування препаратами заліза було неефективне. Яку патологію системи крові можна запідозрити в даному випадку?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мембранопагія', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', true, 1),
  ((SELECT id FROM inserted_question), 'Ферментопатія', false, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 35 років зі встановленим діагнозом: гіпохромна анемія - дослідження крові показало, що в еритроцитах знаходиться 45% HbS та 55% HbA1 .Яка форма анемії у пацієнтки?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Таласемія', false, 0),
  ((SELECT id FROM inserted_question), 'Мікроцитарна', false, 1),
  ((SELECT id FROM inserted_question), 'Апластична', false, 2),
  ((SELECT id FROM inserted_question), 'Серповидноклітинна', true, 3),
  ((SELECT id FROM inserted_question), 'Анемія Адісона-Бірмера', false, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з гіпохромною анемією в еритроцитах знаходиться 45% Hb S та 55% Hb А1. Яка форма анемії у пацієнта?', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мікросфероцитарна', false, 0),
  ((SELECT id FROM inserted_question), 'Хвороба Аддісон-Бірмера', false, 1),
  ((SELECT id FROM inserted_question), 'alpha-таласемія', false, 2),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', true, 3),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогеназодефіцитна', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дослідження первинної структури молекули глобіну виявлено заміну глутамінової кислоти на валін. Для якої спадкової патології це характерно?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хвороба Мінковського-Шоффара', false, 0),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', true, 1),
  ((SELECT id FROM inserted_question), 'Фавізм', false, 2),
  ((SELECT id FROM inserted_question), 'Гемоглобіноз', false, 3),
  ((SELECT id FROM inserted_question), 'Таласемія', false, 4);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта час від часу суттєво знижується вміст гемоглобіну та еритроцитів у крові, з''являється жовтяниця. З анамнезу з''ясовано, що ці напади завжди виникають після вживання кінських бобів. На яку форму анемії вказують такі симптоми пацієнта?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спадкову ферментопатію', true, 0),
  ((SELECT id FROM inserted_question), 'Набуту гемолітичну анемію', false, 1),
  ((SELECT id FROM inserted_question), 'Спадкову гемоглобінопатію', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитну анемію', false, 3),
  ((SELECT id FROM inserted_question), 'Спадкову мембранопатію', false, 4);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У п`ятирічної дитини виявлена спадкова мембранопатія (хвороба Мінковського-Шоффара). Яка зміна осмотичної резистентності еритроцитів спостерігатиметься в цьому разі?', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження резистентності', true, 0),
  ((SELECT id FROM inserted_question), 'Розширення амплітуди резистентності', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження амплітуди резистентності', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення резистентності', false, 3),
  ((SELECT id FROM inserted_question), 'Збільшення зони резистентності', false, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з хронічним гіпоацидним гастритом спостерігаються симптоми гіпохромної анемії. Під час мікроскопічного дослідження мазку крові виявлено: анулоцити, мікроанізоцитоз, пойкілоцитоз. Який вид анемії спостерігається у пацієнта?', NULL, 'medium', 41, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна', false, 0),
  ((SELECT id FROM inserted_question), 'Таласемія', false, 1),
  ((SELECT id FROM inserted_question), 'Серповидноклітинна', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', true, 3),
  ((SELECT id FROM inserted_question), 'Перніціозна', false, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки, яка має розлади менструального циклу, що супроводжуються тривалими кровотечами, виявлено гіпохромію, зниження кількості ретикулоцитів, мікроцитоз та гіпосидеремію. До якої групи за патогенезом відноситься цей вид анемії?', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', true, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 2),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 3),
  ((SELECT id FROM inserted_question), 'Метапластична', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дівчина віком 15 років скаржиться на швидку втомлюваність, слабкість, прискорене серцебиття. В аналізі крові виявлено: еритроцити - 2, 5 • 10^12/л, гемоглобін - 50 г/л, КП - 0,6, анізоцитоз зі схильністю до мікроцитозу. Вміст заліза в сироватці крові становив 5,4 ммоль. Яка гематологічна патологія спостерігається у пацієнтки?', NULL, 'medium', 43, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', true, 0),
  ((SELECT id FROM inserted_question), 'Набутий абсолютний еритроцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гостра постгеморагічна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін В12-дефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Набута гемолітична анемія', false, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнтка 58-ми років скаржиться на підвищену втомлюваність, зниження працездатності, сонливість, задишку під час швидкої ходи. У крові: ер.-4,6•10^12/л, Hb- 92 г/л, КП- 0,6. У мазку крові - велика кількість анулоцитів та мікроцитів. Для якої анемії це характерно?', NULL, 'medium', 44, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перніціозна', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', true, 1),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 2),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 3),
  ((SELECT id FROM inserted_question), 'Серповидноклітинна', false, 4);


-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта віком 65 років шпиталізовано до лікарні зі скаргами на відчуття тяжкості в підреберних ділянках, збільшення лімфатичних вузлів, загальну слабкість, головний біль. Під час обстеження виявлено: гепатоспленомегалія, еритроцити - 2,3-10*12/л, лейкоцити- 90 - 10*9/ л, лімфоцити - 75%, ШОЕ-35 мм/год, в мазку периферичної крові багато тіней Гумпрехта. Для якого захворювання характерна така картина ?', NULL, 'medium', 45, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитної анемії', false, 0),
  ((SELECT id FROM inserted_question), 'Гострого лімфолейкозу', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічного лімфолейкозу', true, 2),
  ((SELECT id FROM inserted_question), 'Гострого мієлолейкозу', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічного мієлолейкозу', false, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка віком 37 років скаржиться на головний біль, запаморочення, поганий сон, затерпання кінцівок. Упродовж 6 років працює на заводі газорозрядних ламп у свинцевому цеху. Під час лабораторного аналізу крові виявлено знижену кількість еритроцитів та гемоглобіну, підвищений в декілька разів уміст сироваткового заліза. Який вид анемії у жінки?', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 0),
  ((SELECT id FROM inserted_question), 'Метапластична', false, 1),
  ((SELECT id FROM inserted_question), 'Залізорефрактерна', true, 2),
  ((SELECT id FROM inserted_question), 'Анемія Мінковського-Шоффара', false, 3),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 65 років тривалий час скаржиться на симптоми, характерні для хронічного гастриту. Під час лабораторного аналізу в крові виявлено мегалоцити, у кістковому мозку виявлений мегалобластичний еритропоез. Який діагноз є найімовірнішим у цьому разі?', NULL, 'medium', 47, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична анемія', false, 2),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна анемія', true, 3),
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В ході біохімічного аналізу еритроцитів немовляти встановлено виражену недостатність глутатіонпероксидази і низький рівень відновленого глутатіону. Який патологічний стан може розвинутися у цієї дитини?', NULL, 'medium', 48, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серпоподібно-клітинна анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична анемія', true, 2),
  ((SELECT id FROM inserted_question), 'Перніціозна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Мегалобластна анемія', false, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 36-ти років, яка лікувалася сульфаніламідами з приводу респіраторної вірусної інфекції, в крові спостерігаються гіпорегенераторна нормохромна анемія, лейкопенія, тромбоцитопенія. В кістковому мозку - зменшення кількості мієлокаріоцитів. Яка це анемія?', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', true, 1),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 2),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 3),
  ((SELECT id FROM inserted_question), 'В 12-фолієводефіцитна', false, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в крові: ер.- 3,0 • 10^12/л; Hb- 90г/л; ретикулоцити - 0,5%. В мазку: пойкілоцити, гіпохромні еритроцити. Залізо сироватки крові - 80 мкмоль/л. Для якої патології це характерно?', NULL, 'medium', 50, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'B12-дефіцитна анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Серпоподібноклітинна анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Залізорефрактерна анемія', true, 3),
  ((SELECT id FROM inserted_question), 'Хвороба Мінковського-Шоффара', false, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 13 років знаходиться на стаціонарному лікуванні в гематологічному відділенні обласної дитячої лікарні з діагнозом залізодефіцитна анемія. Який тип гіпоксії має місце у цієї хворої?', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 1),
  ((SELECT id FROM inserted_question), 'Гемічна', true, 2),
  ((SELECT id FROM inserted_question), 'Змішана', false, 3),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 65 років тривалий час скаржиться на симптоми, характерні для хронічного гастриту. Під час лабораторного аналізу в крові виявлено мегалоцити, у кістковому мозку виявлений мегалобластичний еритропоез. Який діагноз є найімовірнішим у цьому разі?', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична анемія', false, 2),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна анемія', true, 3),
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Показники аналізу крові 35-річного чоловіка: НЬ — 58 г/л, еритроцити — 1,3 • 10,2/л, колірний показник - 1,3, лейкоцити - 2,8 • 109/л, тромбоцити - 1,1* 109/л, ретикулоцити - 2%, ШОЕ - 35 мм/год. Визначаються полісегментовані нейтрофіли, а також тільця Жоллі, кільця Кебота. мегалоцити. Яка це анемія?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', true, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 3),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого, що переніс 5 років тому субтотальну резекцію шлунка, розвинулась В12-фолієводефіцитна анемія. Який механізм є провідним у розвитку такої анемії?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дефіцит фолієвої кислоти', false, 0),
  ((SELECT id FROM inserted_question), 'Порушення всмоктування вітаміну В в тонкій кишці', false, 1),
  ((SELECT id FROM inserted_question), 'Відсутність зовнішнього фактора Касла', false, 2),
  ((SELECT id FROM inserted_question), 'Дефіцит транскобаламіну', false, 3),
  ((SELECT id FROM inserted_question), 'Відсутність внутрішнього фактора Касла', true, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, '50-річна жінка скаржиться на часті головні болі, запаморочення і задишку під час фізичного навантаження. Протягом 3 останніх років у неї були довгі та рясні менструації. Під час фізикального обстеження пацієнтка нормостенічна, її шкіра бліда та суха. Аналіз крові: Нв – 90 г/л, еритроцити – 3,7 х 1012/л кольоровий показник – 0,7, ШОЕ 20 мм/год, ознаки гіпохромії еритроцитів, анізоцитоз, пойкілоцитоз. Який тип анемії найімовірніша у пацієнтки?', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', false, 1),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', true, 2),
  ((SELECT id FROM inserted_question), 'Серповидно-клітинна', false, 3),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дівчинці віком 13 років лікар призначив для лікування мегалобластної анемії препарат, що стимулює перехід мегалобластного типу кровотворення в нормобластний та бере участь у синтезі пурино- і піримідинових основ, активізує синтез білка, метіоніну. Який препарат призначено пацієнтці?', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Плоди шипшини', false, 0),
  ((SELECT id FROM inserted_question), 'Заліза сульфат', false, 1),
  ((SELECT id FROM inserted_question), 'Еритропоетин', false, 2),
  ((SELECT id FROM inserted_question), 'Ціанокобаламін', true, 3),
  ((SELECT id FROM inserted_question), 'Гемостимулін', false, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікаря акушера-гінеколога звернулась вагітна жінка, у якої діагностували мегалобластну анемію. Який з нижченаведених засобів доцільно призначити?', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метилурацил', false, 0),
  ((SELECT id FROM inserted_question), 'Стрептокіназа', false, 1),
  ((SELECT id FROM inserted_question), 'Глауцин', false, 2),
  ((SELECT id FROM inserted_question), 'Пентоксил', false, 3),
  ((SELECT id FROM inserted_question), 'Ціанокобаламін', true, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 43 років спостерігається хронічний атрофічний гастрит, мегалобластна гіперхромна анемія. Підвищено виділення метилмалонової кислоти з сечею. Недостатністю якого вітаміну обумовлене виникнення зазначеного симптомокомплексу?', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін В1', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін В12', true, 1),
  ((SELECT id FROM inserted_question), 'Вітамін В3', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін В2', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін В5', false, 4);


-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора надійшла до клініки зі скаргами на загальну слабкість, запаморочення, задишку. Незадовго до звернення у клініку вона приймала левоміцетин для профілактики кишкових інфекцій. У крові: ер.- 1,9*10^12/л, Hb- 58 г/л, колірний показник- 0,9; лейк.- 2,2*10^9/л. Про яку анемію це свідчить?', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', true, 1),
  ((SELECT id FROM inserted_question), 'Метапластична', false, 2),
  ((SELECT id FROM inserted_question), 'Апластична', false, 3),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина постійно живе високо в горах. Яку зміну показників крові можна виявити у неї?', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення колірного показника', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження кількості ретикулоцитів', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження показників вмісту гемоглобіну', false, 2),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', true, 3),
  ((SELECT id FROM inserted_question), 'Появу в крові еритробластів', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнтки віком 24 роки діагностовано гнійне ураження ясен. Які зміни в загальному аналізі крові будуть найбільш типовими при цьому патологічному стані?', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритропенія', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', true, 2),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпопротеїнемія', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові чоловіка 26 років виявлено 18% еритроцитів сферичної, сплощеної, кулеподібної та остистої форми. Інші еритроцити були у формі двоввігнутих дисків. Як називається таке явище?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фізіологічний пойкілоцитоз', true, 0),
  ((SELECT id FROM inserted_question), 'Патологічний пойкілоцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Патологічний анізоцитоз', false, 2),
  ((SELECT id FROM inserted_question), 'Фізіологічний анізоцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', false, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В приймально - діагностичне відділення доставлена жінка 38 років з матковою кровотечею. Які найбільш ймовірні зміни з боку крові відбудуться?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Зменшення гематокритного числа', true, 2),
  ((SELECT id FROM inserted_question), 'Збільшення гематокритного числа', false, 3),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', false, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обстеженні хворого на гемофілію виявлено зміну деяких показників крові. Яка з перерахованих ознак відповідає цьому захворюванню?', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еозинофілія', false, 0),
  ((SELECT id FROM inserted_question), 'Афібриногенемія', false, 1),
  ((SELECT id FROM inserted_question), 'Час згортання крові вповільнений', true, 2),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', false, 3),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', false, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Ураження хворого одноразовою дозою іонізуючого випромінювання спричинило розвиток кістково-мозкової форми променевої хвороби. Які патологічні прояви з боку крові будуть характерними в період удаваного благополуччя?', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Анемія, лейкопенія', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія, лейкоцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Перерозподільчий лейкоцитоз, лімфоцитоз', false, 2),
  ((SELECT id FROM inserted_question), 'Наростаюча лімфопенія, лейкопенія', true, 3),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія, анемія', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий з ревматоїдним артритом приймає диклофенак натрій. Після чергового аналізу крові лікар відмінив цей препарат. Яке ускладнення з боку крові викликав диклофенак натрій?', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження гемокоагуляції', false, 1),
  ((SELECT id FROM inserted_question), 'Посилення гемокоагуляції', false, 2),
  ((SELECT id FROM inserted_question), 'Еозинофілія', false, 3),
  ((SELECT id FROM inserted_question), 'Лейкопенія', true, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Людина отримала дозу іонізуючого опромінення 4 Гр. Яка зміна в крові потерпілого характерна насамперед?', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкопенія', true, 0),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Нейтропенія', false, 3),
  ((SELECT id FROM inserted_question), 'Лімфопенія', false, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові пацієнта, який хворіє на лейкопенію, виявили антилейкоцитарні антитіла. Який тип алергічної реакції за Кумбсом і Джеллом виник у чоловіка?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперчутливість сповільненого типу', false, 0),
  ((SELECT id FROM inserted_question), 'Цитотоксичний', true, 1),
  ((SELECT id FROM inserted_question), 'Анафілактичний', false, 2),
  ((SELECT id FROM inserted_question), 'Імунокомплексний', false, 3),
  ((SELECT id FROM inserted_question), 'Стимулюючий', false, 4);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На 8-й день після введення протиправцевої сироватки з приводу брудної рани стопи у пацієнта підвищилася температура тіла до 38°C, з’явилися біль у суглобах, висипка, свербіж. У крові - лейкопенія і тромбоцитопенія. Який тип алергічної реакції розвинувся?', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперчутливість уповільненого типу', false, 0),
  ((SELECT id FROM inserted_question), 'Цитотоксична', false, 1),
  ((SELECT id FROM inserted_question), 'Імунокомплексна гіперчутливість', true, 2),
  ((SELECT id FROM inserted_question), 'Анафілактична', false, 3),
  ((SELECT id FROM inserted_question), 'Стимулююча', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Батьки для профілактики кишкових інфекцій у дитини 3-х років тривало застосовували антибіотики. Через місяць стан дитини погіршився. У крові - виражена лейкопенія і гранулоцитопенія. Який найбільш вірогідний механізм виявлених змін у крові?', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітичний', false, 0),
  ((SELECT id FROM inserted_question), 'Віковий', false, 1),
  ((SELECT id FROM inserted_question), 'Аутоімунний', false, 2),
  ((SELECT id FROM inserted_question), 'Мієлотоксичний', true, 3),
  ((SELECT id FROM inserted_question), 'Перерозподільний', false, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 36-ти років, яка лікувалася сульфаніламідами з приводу респіраторної вірусної інфекції, в крові гіпорегенераторна нормохромна анемія, лейкопенія, тромбоцитопенія. В кістковому мозку - зменшення кількості мієлокаріоцитів. Яка це анемія?', NULL, 'medium', 71, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Залізодефіцитна', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпопластична', true, 1),
  ((SELECT id FROM inserted_question), 'Гемолітична', false, 2),
  ((SELECT id FROM inserted_question), 'Постгеморагічна', false, 3),
  ((SELECT id FROM inserted_question), 'В12-фолієводефіцитна', false, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після прийому сульфаніламідів у хворого виникли лихоманка, блювання і стул з кров’ю. У крові: лейк.-0,9 • 10^9 /л (гранул.- 0,7 • 10^9 /л), лейкоаглютиніни. Який з термінів найбільш точно характеризує виявлені зміни у крові?', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемодилюція', false, 0),
  ((SELECT id FROM inserted_question), 'Агранулоцитоз', true, 1),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 2),
  ((SELECT id FROM inserted_question), '-', false, 3),
  ((SELECT id FROM inserted_question), 'Лейкоз', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 26-ти років перебуває в торпідній стадії шоку внаслідок автомобільної аварії. У крові: лейк.- 3, 2 • 109 /л. Який головний механізм у розвитку лейкопенії?', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перерозподіл лейкоцитів у судинному руслі', true, 0),
  ((SELECT id FROM inserted_question), 'Руйнування лейкоцитів у кровотворних органах', false, 1),
  ((SELECT id FROM inserted_question), 'Порушення виходу зрілих лейкоцитів з кісткового мозку в кров', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення виділення лейкоцитів з організму', false, 3),
  ((SELECT id FROM inserted_question), 'Пригнічення лейкопоезу', false, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта на фоні впливу іонізуючого опромінення у крові визначено зменшення кількості гранулоцитів. Чим зумовлений агранулоцитоз?', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пригніченням лейкопоезу', true, 0),
  ((SELECT id FROM inserted_question), 'Порушенням виходу зрілих лейкоцитів з кісткового мозку', false, 1),
  ((SELECT id FROM inserted_question), 'Розвитком аутоімунного процесу', false, 2),
  ((SELECT id FROM inserted_question), 'Збільшенням переходу гранулоцитів у тканини', false, 3),
  ((SELECT id FROM inserted_question), 'Підвищенням руйнування лейкоцитів', false, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 20 років періодично з''являються слабкість, жовтушність шкіри та склер. Діагностовано хворобу Мінковського-Шоффара. Що є характерним для показників крові у разі цього захворювання?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мікросфероцитоз', true, 0),
  ((SELECT id FROM inserted_question), 'Анулоцитоз', false, 1),
  ((SELECT id FROM inserted_question), 'Макроцитоз', false, 2),
  ((SELECT id FROM inserted_question), 'Агранулоцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоцитоз', false, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час роботи щодо ліквідації наслідків аварії на АЕС, робітник одержав дозу опромінення 500 рентген. Скаржиться на головний біль, нудоту, запаморочення. Які зміни кількості лейкоцитів можна очікувати в хворого через 10 годин після опромінення?', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Агранулоцитоз', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкемія', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфоцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Нейтрофільний лейкоцитоз', true, 4);


-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнтки віком 24 роки діагностовано гнійне ураження ясен. Які зміни в загальному аналізі крові будуть найбільш типовими при цьому патологічному стані?', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еритропенія', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', true, 2),
  ((SELECT id FROM inserted_question), 'Еритроцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпопротеїнемія', false, 4);


-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'З метою оцінки адаптації до фізичного навантаження лікар провів обстеження робітників після виконання важкої праці. Які зміни в загальному аналізі крові можна виявити?', NULL, 'medium', 78, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпоальбумінемія', false, 0),
  ((SELECT id FROM inserted_question), 'Анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Лейкопенія', false, 2),
  ((SELECT id FROM inserted_question), 'Перерозподільчий лейкоцитоз', true, 3),
  ((SELECT id FROM inserted_question), 'Зсув лейкоцитарної формули вліво', false, 4);


-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час сінокосу в селянина з''явилася кропив''янка та підвищилася температура тіла. У результатах лабораторних досліджень виявлено лейкоцитоз. Який вид лейкоцитозу спостерігається у цьому разі?', NULL, 'medium', 79, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лімфоцитарний', false, 0),
  ((SELECT id FROM inserted_question), 'Базофільний', false, 1),
  ((SELECT id FROM inserted_question), 'Еозинофільний', true, 2),
  ((SELECT id FROM inserted_question), 'Нейтрофільний', false, 3),
  ((SELECT id FROM inserted_question), 'Моноцитарний', false, 4);


-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 25-річного пацієнта на тлі гострого запалення легень із температурою тіла 40,1^oC визначено лейкоцитоз 14,9 г/л із чітким зсувом лейкоформули вліво. Який із наведених чинників безпосередньо підвищує в кістковому мозку і проліферацію, і диференціацію лейкоцитів?', NULL, 'medium', 80, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Колонієстимулюючий чинник', true, 0),
  ((SELECT id FROM inserted_question), 'Пухлинний некротичний чинник', false, 1),
  ((SELECT id FROM inserted_question), 'Інтерлейкін-10', false, 2),
  ((SELECT id FROM inserted_question), 'Інтерлейкін-1', false, 3),
  ((SELECT id FROM inserted_question), 'Простациклін', false, 4);


-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт упродовж 15 років хворіє на бронхіальну астму. Які зміни лейкоцитарної формули у пацієнта може спричинити це захворювання?', NULL, 'medium', 81, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еозинофілію', true, 0),
  ((SELECT id FROM inserted_question), 'Базофілію', false, 1),
  ((SELECT id FROM inserted_question), 'Зсув лейкоцитарної формули вліво', false, 2),
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Лейкопенію', false, 4);


-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час аналізу крові виявлено фізіологічний лейкоцитоз. Причиною цього може бути те, що перед дослідженням людина:', NULL, 'medium', 82, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поснідала', true, 0),
  ((SELECT id FROM inserted_question), 'Запальний процес', false, 1),
  ((SELECT id FROM inserted_question), 'Випила води', false, 2),
  ((SELECT id FROM inserted_question), 'Палила тютюн', false, 3),
  ((SELECT id FROM inserted_question), 'Не снідала', false, 4);


-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У студента через добу після іспиту в аналізі крові виявили лейкоцитоз без істотної зміни в лейкоцитарній формулі Який механізм найімовірніше зумовив розвиток виявленої пиши в периферичній крові?', NULL, 'medium', 83, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Посилення лейкопоезу', false, 0),
  ((SELECT id FROM inserted_question), 'Перерозподіл лейкоцитів в організмі', true, 1),
  ((SELECT id FROM inserted_question), 'Уповільнення еміграції лейкоцитів до тканин', false, 2),
  ((SELECT id FROM inserted_question), 'Зменшення руйнування лейкоцитів', false, 3);


-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обстеженні в аналізі крові пацієнта виявлено лейкоцитоз, лімфоцитоз, клітини Боткіна- Гумпрехта на тлі анемії. Про яку хворобу слід думати лікарю?', NULL, 'medium', 84, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лімфогранулематоз', false, 0),
  ((SELECT id FROM inserted_question), 'Інфекційний мононуклеоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий мієлолейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', true, 3),
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', false, 4);


-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого через добу після апендектомії при аналізі крові виявили нейтрофільний лейкоцитоз з регенеративним зсувом вліво. Який найбільш імовірний механізм розвитку абсолютного лейкоцитозу у периферичній крові хворого?', NULL, 'medium', 85, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Посилення лейкопоезу', true, 0),
  ((SELECT id FROM inserted_question), 'Активація імунітету', false, 1),
  ((SELECT id FROM inserted_question), 'Перерозподіл лейкоцитів в організмі', false, 2),
  ((SELECT id FROM inserted_question), 'Уповільнення еміграції лейкоцитів у тканині', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення руйнування лейкоцитів', false, 4);


-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в лейкограмі: лейкоцити - 14 • 10^9 /л; мієлобласти - 71%, промієлоцити, мієлоцити, метамієлоцити - 0%, паличкоядерні нейтрофіли - 6%, сегментоядерні -13%; лімфоцити - 7%, моноцити - 3%. Яка патологія у хворого?', NULL, 'medium', 86, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Мієлобластний лейкоз', true, 1),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфобластний лейкоз', false, 3),
  ((SELECT id FROM inserted_question), 'Нейтрофільний лейкоцитоз', false, 4);


-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У студента через 2 години після іспиту в аналізі крові виявлено лейкоцитоз без істотних змін у лейкоцитарній формулі. Який найбільш вірогідний механізм розвитку лейкоцитозу?', NULL, 'medium', 87, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Посилення лейкопоезу та зменшення руйнування лейкоцитів', false, 0),
  ((SELECT id FROM inserted_question), 'Посилення лейкопоезу', false, 1),
  ((SELECT id FROM inserted_question), 'Уповільнення руйнування лейкоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Перерозподіл лейкоцитів в організмі', true, 3),
  ((SELECT id FROM inserted_question), 'Уповільнення міграції лейкоцитів у тканини', false, 4);


-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 45 років в період цвітіння трав з''явилося гостре запальне захворювання верхніх дихальних шляхів і очей: гіперемія, набряк, слизові виділення. Який вид лейкоцитозу буде найбільш характерним при цьому?', NULL, 'medium', 88, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Моноцитоз', false, 0),
  ((SELECT id FROM inserted_question), 'Нейтрофілія', false, 1),
  ((SELECT id FROM inserted_question), 'Еозинофілія', true, 2),
  ((SELECT id FROM inserted_question), 'Базофілія', false, 3),
  ((SELECT id FROM inserted_question), 'Лімфоцитоз', false, 4);


-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На час профогляду у людини, НЕ має скарг на стан здоров''я, виявили лейкоцитоз. Причиною цього може бути те, що кров для аналізу здана після:', NULL, 'medium', 89, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відпочинку на курорті', false, 0),
  ((SELECT id FROM inserted_question), 'Розумової роботи', false, 1),
  ((SELECT id FROM inserted_question), 'Значного споживання води', false, 2),
  ((SELECT id FROM inserted_question), 'Вживання алкоголю', false, 3),
  ((SELECT id FROM inserted_question), 'Фізичного навантаження', true, 4);


-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час сінокосу в селянина з''явилася кропив''янка та підвищилася температура тіла. У результатах лабораторних досліджень виявлено лейкоцитоз. Який вид лейкоцитозу спостерігається у цьому разі?', NULL, 'medium', 90, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еозинофільний', true, 0),
  ((SELECT id FROM inserted_question), 'Базофільний', false, 1),
  ((SELECT id FROM inserted_question), 'Моноцитарний', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфоцитарний', false, 3),
  ((SELECT id FROM inserted_question), 'Нейтрофільний', false, 4);


-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час мікроскопічного дослідження збільшеного шийного лімфатичного вузла визначається стертя його структури, лімфоїдні фолікули відсутні, усі поля зору представлені клітинами з округлими ядрами і вузьким обідком базофільної цитоплазми. З клінічних даних відомо, що збільшені й інші групи лімфовузлів, а також селезінка та печінка. Про яке захворювання слід думати?', NULL, 'medium', 91, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лімфоїдний лейкоз', true, 0),
  ((SELECT id FROM inserted_question), 'Лімфогранулематоз', false, 1),
  ((SELECT id FROM inserted_question), 'Лімфосаркома', false, 2),
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', false, 3),
  ((SELECT id FROM inserted_question), 'Мієлоїдний лейкоз', false, 4);


-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час гематологічного дослідження крові пацієнта отримано такі результати: еритроцити — 2,8×10^12/л, гемоглобін - 80г/л, КП — 0,85, ретикулоцити 0,1%, тромбоцити — 160 тис. у мкл., лейкоцити — 60×10^9, базофіли —2%, еозинофіли - 8%,промієлоцити — 5%, мієлоцити - 5%, юні — 16%, паличкоядерні нейтрофіли - 20%. Сегментоядерні нейтрофіли - 34%, лімфоцити — 5%, Моноцити - 5%. Про яку форму патології крові свідчать ці результати дослідження?', NULL, 'medium', 92, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемолітичну анемію', false, 0),
  ((SELECT id FROM inserted_question), 'Недиференційований лейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічний мієлоїдний лейкоз', true, 2),
  ((SELECT id FROM inserted_question), 'Гіпопластичну анемію', false, 3),
  ((SELECT id FROM inserted_question), 'Гострий мієлоїдний лейкоз.', false, 4);


-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину трупа чоловіка 48-ми років виявлено, що кістковий мозок пласких кісток, діафізів та епіфізів трубчастих кісток соковитий, сіро-червоний або сіро-жовтий гноєподібний (піоїдний кістковий мозок). Селезінка масою - 7 кг. На розрізі вона темно-червоного кольору, з ішемічними інфарктами. Всі лімфатичні вузли збільшені, м’які, сіро-червоного кольору. В печінці жирова дистрофія і лейкемічні інфільтрати. Який найбільш імовірний діагноз?', NULL, 'medium', 93, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний мієлоїдний лейкоз', true, 0),
  ((SELECT id FROM inserted_question), 'Гострий мієлоїдний лейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий лімфоїдний лейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', false, 3),
  ((SELECT id FROM inserted_question), 'Лімфогранулематоз', false, 4);


-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині тіла померлого виявлена гіперплазія кісткового мозку плоских і трубчастих кісток (піоїдний кістковий мозок), спленомегалія (6 кг), гепатомегалія (5 кг), збільшення всіх груп лімфатичних вузлів. Якому захворюванню відповідають виявлені зміни?', NULL, 'medium', 94, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Справжня поліцитемія', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфогрануломатоз', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', true, 4);


-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час гематологічного дослідження крові пацієнта, отримано такі результати: еритроцити - 2,8*10^12/л, НЬ - 80 г/л, КП - 0,85, ретикулоцити - 0,1%, тромбоцити - 160 тис. в мкл, лейкоцити - 60 • 10^9, базофіли - 2%, еозинофіли - 8%, промієлоцити - 5%, мієлоцити-5%, юні - 16%, паличкоядерні – 20% , сегментоядерні - 34%, лімфоцити - 5%, моноцити - 5%. Про яку форму патології крові свідчать ці результати дослідження?', NULL, 'medium', 95, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпопластична анемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гемолітична анемія', false, 1),
  ((SELECT id FROM inserted_question), 'Недиференційований лейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', true, 3),
  ((SELECT id FROM inserted_question), 'Гострий мієлолейкоз', false, 4);


-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта віком 65 років шпиталізовано до лікарні зі скаргами на відчуття важкості в підреберних ділянках, збільшення лімфатичних вузлів, загальну слабкість, головний біль. Під час обстеження виявлено: гепатоспленомегалія, еритроцити - 2,3*10^12/л, лейкоцити - 90*10^9/л, лімфоцити - 75%, ШОЕ - 35 мм/год, в мазку периферичної крові багато тіней Гумпрехта. Для якого захворювання характерна така клінічна картина?', NULL, 'medium', 96, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий мієлолейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', true, 2),
  ((SELECT id FROM inserted_question), 'Залізодефіцитна анемія', false, 3),
  ((SELECT id FROM inserted_question), 'Гострий лімфолейкоз', false, 4);


-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт протягом останнього року став помічати підвищену втомлюваність, загальну слабкість. Результати аналізу крові: еритроцити -4,1*10^12/л, НЬ - 119 г/л, кольоровий показник - 0,87, лейкоцити - 57 • 10^9/л, лейкоформула: юні -0%. паличкоядерні -0%, сегментоядерні - 9%, еозинофіли - 0%. базофіли - 0%, лімфобласти - 2%, пролімфоцити -5%, лімфоцити - 81%, моноцити - 3%, тромбоцити - 160 • 10^9/л. У мазку виявлено: нормохромія, велика кількість тіней Боткіна-Гумпрехта. Про яку патологію системи крові свідчить така гемограма?', NULL, 'medium', 97, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий лімфобластний лейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний монолейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гострий мієлобластний лейкоз', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', true, 4);


-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 62-х років блідий, всі групи лімфовузлів збільшені. В крові: Hb- 60 г/л, еритроцити - 1,9 Т/л, лейкоцити - 29 Г/л, тромбоцити - 110 Г/л. Лейкоцитарна формула: сегментоядерні лейкоцити - 10%, лімфоцити - 8%, моноцити - 2%, бластних клітин - 80%. Цитохімічні дослідження бластних клітин: позитивна реакція на глікоген, негативна – на ліпіди і пероксидазу. Дайте заключення про патологію:', NULL, 'medium', 98, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий мієлобластний лейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Гострий промієлоцитарний лейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий мегакаріоцитарний лейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гострий лімфобластний лейкоз', true, 3),
  ((SELECT id FROM inserted_question), 'Гострий монобластний лейкоз', false, 4);


-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в лейкограмі: лейкоцити - 14 • 10^9 /л; мієлобласти - 71%, промієлоцити, мієлоцити, метамієлоцити - 0%, паличкоядерні нейтрофіли - 6%, сегментоядерні -13%; лімфоцити - 7%, моноцити - 3%. Яка патологія у хворого?', NULL, 'medium', 99, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Мієлобластний лейкоз', true, 1),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфобластний лейкоз', false, 3),
  ((SELECT id FROM inserted_question), 'Нейтрофільний лейкоцитоз', false, 4);


-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При обстеженні в аналізі крові пацієнта виявлено лейкоцитоз, лімфоцитоз, клітини Боткіна-Гумпрехта на тлі анемії. Про яку хворобу слід думати лікарю?', NULL, 'medium', 100, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', false, 0),
  ((SELECT id FROM inserted_question), 'Лімфогранулематоз', false, 1),
  ((SELECT id FROM inserted_question), 'Інфекційний мононуклеоз', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', true, 3),
  ((SELECT id FROM inserted_question), 'Гострий мієлолейкоз', false, 4);


-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 43-х років скаржиться на слабкість, підвищення температури до 38 — 40 C. Об’єктивно: печінка і селезінка збільшені. У крові: Hb- 100 г/л, ер.- 2,9•1012/л, лейк.- 4,4•109 /л, тромб.-48 • 109 /л, нейтрофіли сегментоядерні -17%, лімфоцити - 15%, бластні клітини - 68%. Всі цитохімічні реакції негативні. Дайте гематологічний висновок:', NULL, 'medium', 101, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Гострий еритромієлоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий мієлобластний лейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Недиференційований лейкоз', true, 3),
  ((SELECT id FROM inserted_question), 'Гострий лімфобластний лейкоз', false, 4);


-- Question 102
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У збільшеному шийному лімфатичному вузлі дівчинки віком 14 років мікросконічно було виявлено, що тканинна будова вузла порушена, лімфоїдні фолікули відсутні, є ділянки склерозу та вогнища некрозу, клітинний склад вузла поліморфний, присутні лімфоцити, еозинофіли, атипові клітини великих розмірів з багаточасточковими ядрами (клітини Березовського-Штернберга) та одноядерні клітини також великих розмірів. Який найімовірніший діагноз?', NULL, 'medium', 102, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний лімфолейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Лімфома Беркітта', false, 1),
  ((SELECT id FROM inserted_question), 'Грибоподібний мікоз', false, 2),
  ((SELECT id FROM inserted_question), 'Лімфогранулематоз', true, 3),
  ((SELECT id FROM inserted_question), 'Гострий лімфолейкоз', false, 4);


-- Question 103
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого в обох щелепах рентгенологічно виявлено численні дефекти у вигляді гладкостінних округлих отворів. При гістологічному дослідженні - явища остеолізису і остеопорозу при явищах слабкого кісткоутворення. В сечі хворого знайдено білок Бенс-Джонса. Назвіть захворювання:', NULL, 'medium', 103, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий недиференційований лейкоз', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний мієлолейкоз', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий мієлолейкоз', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний еритромієлоз', false, 3),
  ((SELECT id FROM inserted_question), 'Мієломна хвороба', true, 4);


-- Question 104
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого скарги на загальну слабкість, підвищену втому, зниження апетиту і маси тіла. В анамнезі часті пневмонії. На підставі клінічних даних та результатів дослідження периферійної крові у нього діагностовано хронічний лімфолейкоз. Які дегенеративні зміни лейкоцитів характерні для даного захворювання?', NULL, 'medium', 104, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тільця Князькові-Деле', false, 0),
  ((SELECT id FROM inserted_question), 'Токсична зернистість', false, 1),
  ((SELECT id FROM inserted_question), 'Зерна Амато', false, 2),
  ((SELECT id FROM inserted_question), 'Палички Ауера', false, 3),
  ((SELECT id FROM inserted_question), 'Тіні Боткіна-Гумпрехта', true, 4);


-- Question 105
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на гострий мієлобластний лейкоз виявлено: збільшення печінки, селезінки, анемія, мієлобласти в периферичній крові. Яка принципова ознака дозволяє відрізнити гострий мієлобластний лейкоз від хронічного?', NULL, 'medium', 105, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лейкемічний провал', true, 0),
  ((SELECT id FROM inserted_question), 'Бластні клітини в периферичній крові', false, 1),
  ((SELECT id FROM inserted_question), 'Анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Панцитопенія', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', false, 4);


-- Question 106
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У ліквідатора наслідків на АЕС під час перебігу гострої променевої хвороби виник геморагічний синдром. Що має найбільше значення в патогенезі цього синдрому?', NULL, 'medium', 106, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення активності факторів зсідання крові', false, 0),
  ((SELECT id FROM inserted_question), 'Підвищення активності факторів фібринолізу', false, 1),
  ((SELECT id FROM inserted_question), 'Порушення структури сінки судин', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення активності факторів систем протизсідання крові', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоцитопенія', true, 4);


-- Question 107
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час посмертного розтину тіла чоловіка, який проходив військову службу на підводному атомному човні, виявлено такі патології: спустошення в кістковому мозку (панмієлофтиз), анемія, лейкопенія, тромбоцитопенія, розпад лімфоцитів у лімфатичних вузлах, селезінці, лімфатичному апараті шлунково-кишкового тракту, крововиливи наднирники. Яке захворювання розвинулося у чоловіка?', NULL, 'medium', 107, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостра променева хвороба', true, 0),
  ((SELECT id FROM inserted_question), 'Вібраційна хвороба', false, 1),
  ((SELECT id FROM inserted_question), 'Гостра анемія', false, 2),
  ((SELECT id FROM inserted_question), 'Кесонна хвороба', false, 3),
  ((SELECT id FROM inserted_question), 'Гострий лейкоз', false, 4);


-- Question 108
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Недостатність в організмі лінолевої та ліноленової кислот призводить до ушкоджень шкіри, випадіння волосся, сповільненого загоювання ран, тромбоцитопенії, зниження опірності до інфекційних захворювань. Порушення синтезу яких речовин найімовірніше зумовлює вказані симптоми?', NULL, 'medium', 108, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інтерлейкіни', false, 0),
  ((SELECT id FROM inserted_question), 'Кортикостероїди', false, 1),
  ((SELECT id FROM inserted_question), 'Ейкозаноїди', true, 2),
  ((SELECT id FROM inserted_question), 'Катехоламіни', false, 3),
  ((SELECT id FROM inserted_question), 'Інтерферони', false, 4);


-- Question 109
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Через рік після субтотальної резекції шлунка з приводу виразки малої кривизни виявлені зміни в аналізі крові - анемія, лейко- і тромбоцитопенія, КП=1.3, наявність мегалобластів та мегалоцитів. Дефіцит якого фактору обумовив розвиток цієї анемії?', NULL, 'medium', 109, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Іастрин', false, 0),
  ((SELECT id FROM inserted_question), 'Хлороводнева кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Пепсин', false, 2),
  ((SELECT id FROM inserted_question), 'Фактор Касла', true, 3),
  ((SELECT id FROM inserted_question), 'Муцин', false, 4);


-- Question 110
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої 43-х років на фоні септичного шоку відзначається тромбоцитопенія, зниження фібриногену, поява в крові продуктів дегенерації фібрину, поява петехіальних крововиливів. Вкажіть причину виникнення даних змін:', NULL, 'medium', 110, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ДВЗ-синдром', true, 0),
  ((SELECT id FROM inserted_question), 'Автоімунна тромбоцитопенія', false, 1),
  ((SELECT id FROM inserted_question), 'Порушення утворення тромбоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Геморагічний діатез', false, 3),
  ((SELECT id FROM inserted_question), 'Екзогенна інтоксикація', false, 4);


-- Question 111
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Абсолютний дефіцит вітаміну К в організмі призводить до:', NULL, 'medium', 111, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпокоагуляції', true, 0),
  ((SELECT id FROM inserted_question), 'Гіперкоагуляції', false, 1),
  ((SELECT id FROM inserted_question), 'Порушення адгезії тромбоцитів', false, 2),
  ((SELECT id FROM inserted_question), 'Дисбактеріозу кишечника', false, 3);


-- Question 112
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з опіковою хворобою як ускладнення розвинувся ДВЗ-синдром. Яку стадію ДВЗ-синдрому можна припустити, якщо відомо, що час згортання крові хворого за Лі-Уайтом становить менше, ніж 3 хвилини?', NULL, 'medium', 112, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перехідну', false, 0),
  ((SELECT id FROM inserted_question), 'Термінальну', false, 1),
  ((SELECT id FROM inserted_question), 'Фібринолізу', false, 2),
  ((SELECT id FROM inserted_question), 'Гіперкоагуляції', true, 3),
  ((SELECT id FROM inserted_question), 'Гіпокоагуляцїї', false, 4);


-- Question 113
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнтці з діагнозом: ішемічна хвороба серця, призначено ацетилсаліцилову кислоту. Синтез якої ендогенної речовини зумовлює антиагрегантну дію цього препарату?', NULL, 'medium', 113, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Простагландину E1', false, 0),
  ((SELECT id FROM inserted_question), 'Простагландину E2', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбоксану А2', true, 2),
  ((SELECT id FROM inserted_question), 'Лейкотрієнів', false, 3),
  ((SELECT id FROM inserted_question), 'Простагландину I2 (простацикліну)', false, 4);


-- Question 114
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після лікування прямим антикоагулянтом із приводу тромбоемболії в пацієнта з''явилися ознаки кишкової кровотечі. Який препарат став причиною ускладнення?', NULL, 'medium', 114, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин натрію', true, 0),
  ((SELECT id FROM inserted_question), 'Протаміну сульфат', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Кальцію добезилат', false, 3),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 4);


-- Question 115
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Як антикоагулянти використовують різноманітні речовини, у тому числі полісахарид природного походження. Укажіть серед нижченаведених речовин полісахарид природного походження.', NULL, 'medium', 115, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин', true, 0),
  ((SELECT id FROM inserted_question), 'Вітамін К', false, 1),
  ((SELECT id FROM inserted_question), 'Гіалуронова кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Еноксапарин', false, 3),
  ((SELECT id FROM inserted_question), 'Декстран', false, 4);


-- Question 116
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час гострого тромбозу показана антикоагулянтна терапія. Назвіть антикоагулянт прямої дії, який застосовується в разі загрози тромбозу.', NULL, 'medium', 116, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин', true, 0),
  ((SELECT id FROM inserted_question), 'Фраксипарин', false, 1),
  ((SELECT id FROM inserted_question), 'Дипіридамол', false, 2),
  ((SELECT id FROM inserted_question), 'Варфарин', false, 3);


-- Question 117
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для попередження зсідання крові пацієнта, взятої для аналізу, її змішали з розчином гепарину. Цей антикоагулянт за хімічною структурою належить до:', NULL, 'medium', 117, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемопротеїнів', false, 0),
  ((SELECT id FROM inserted_question), 'Глікозаміногліканів', true, 1),
  ((SELECT id FROM inserted_question), 'Триацилгліцеролів', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфоліпідів', false, 3),
  ((SELECT id FROM inserted_question), 'Простих білків', false, 4);


-- Question 118
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту з діагнозом: гострий інфаркт міокарда, призначено антикоагулянтну терапію. Вимірювання якого показника системи згортання крові потрібне в разі приймання гепарину, щоб попередити можливі ускладнення через його передозування?', NULL, 'medium', 118, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Концентрації фібриногену', false, 0),
  ((SELECT id FROM inserted_question), 'Активованого часткового тромбопластинового часу (коректна відповідь)', false, 1),
  ((SELECT id FROM inserted_question), 'Міжнародного нормалізованого відношення', false, 2),
  ((SELECT id FROM inserted_question), 'ШОЕ', false, 3),
  ((SELECT id FROM inserted_question), 'Протромбінового часу', true, 4);


-- Question 119
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Застосування антикоагулянтного засобу викликало крововиливи на слизових оболонках, макрогематурію, зменшення часу згортання крові. Введення протаміну сульфату усунуло ці порушення. Який засіб було призначено?', NULL, 'medium', 119, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гепарин', true, 0),
  ((SELECT id FROM inserted_question), 'Вікасол', false, 1),
  ((SELECT id FROM inserted_question), 'Фібринолізин', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію цитрат', false, 3),
  ((SELECT id FROM inserted_question), 'Неодикумарин', false, 4);


-- Question 120
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінці 46-ти років планується провести об’ємне оперативне втручання в щелепно-лицьовій області. Відомо, що хвора схильна до підвищеної гемокоа-гуляції. Який природний антикоагулянт може бути застосований з метою запобігання тромбоутворенню?', NULL, 'medium', 120, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жодна з наведених речовин', false, 0),
  ((SELECT id FROM inserted_question), 'Цитрат натрію', false, 1),
  ((SELECT id FROM inserted_question), 'Фібринолізин', false, 2),
  ((SELECT id FROM inserted_question), 'Гірудин', false, 3),
  ((SELECT id FROM inserted_question), 'Гепарин', true, 4);


-- Question 121
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для профілактики та лікування тромбозу застосовуються засоби, що знижують згортання крові (антикоагулянти). Укажіть антикоагулянт, у разі передозування якого застосовують як антагоніст протаміну сульфат:', NULL, 'medium', 121, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію гідроцитрат', false, 0),
  ((SELECT id FROM inserted_question), 'Синкумар', false, 1),
  ((SELECT id FROM inserted_question), 'Фенілін', false, 2),
  ((SELECT id FROM inserted_question), 'Гепарин', true, 3),
  ((SELECT id FROM inserted_question), 'Неодикумарин', false, 4);


-- Question 122
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 66-ти років скаржиться на 6іль у гомілці, який підсилюється при ходьбі. Об’єктивно: набряк та почервоніння по ходу вени. Лікар призначив антикоагулянт прямої дії для місцевого вживання. Який препарат можна використати з цією метою?', NULL, 'medium', 122, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбін', false, 0),
  ((SELECT id FROM inserted_question), 'Мазь троксевазинова', false, 1),
  ((SELECT id FROM inserted_question), 'Мазь саліцилова', false, 2),
  ((SELECT id FROM inserted_question), 'Мазь гепаринова', true, 3),
  ((SELECT id FROM inserted_question), 'Мазь бутадіонова', false, 4);


-- Question 123
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому, що страждає на тромбоемболічну хворобу, призначений штучний антикоагулянт пелентан. Антагоністом якого вітаміну є цей препарат?', NULL, 'medium', 123, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін Е', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін D', false, 1),
  ((SELECT id FROM inserted_question), 'Вітамін С', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін А', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін К', true, 4);


-- Question 124
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту з діагнозом: гострий інфаркт міокарда — в комплексній терапії призначено гепарин. За деякий час після введення лікарського засобу у пацієнта з’явилася гематурія. Який антагоніст гепарину треба ввести пацієнту для усунення цього ускладнення?', NULL, 'medium', 124, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амінокапронову кислоту', false, 0),
  ((SELECT id FROM inserted_question), 'Вікасол', false, 1),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 2),
  ((SELECT id FROM inserted_question), 'Протаміну сульфат', true, 3),
  ((SELECT id FROM inserted_question), 'Неодикумарин', false, 4);


-- Question 125
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Восьмирічній дитині рекомендовано проведення тонзилектомії. Лабораторний аналіз крові виявив, що час згортання крові збільшено до 7 хвилин. Який лікарський засіб треба призначити дитині для зменшення крововтрати під час операції?', NULL, 'medium', 125, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дицинон', false, 0),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію хлорид', false, 2),
  ((SELECT id FROM inserted_question), 'Вікасол', true, 3),
  ((SELECT id FROM inserted_question), 'Амінокапронову кислоту', false, 4);


-- Question 126
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому на гострий інфаркт міокарда у комплексній терапії було призначено гепарин. Через деякий час після введення даного препарату з’явилася гематурія. Який антагоніст гепарину необхідно ввести хворому для усунення даного ускладнення?', NULL, 'medium', 126, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амінокапронова кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Протаміну сульфат', false, 1),
  ((SELECT id FROM inserted_question), 'Фібриноген', false, 2),
  ((SELECT id FROM inserted_question), 'Вікасол', true, 3),
  ((SELECT id FROM inserted_question), 'Неодикумарин', false, 4);


-- Question 127
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 35 років звернувся до лікарні зі скаргою на носові кровотечі. Лікар призначив пацієнту препарат, який є коагулянтом непрямого типу дії. Визначте цей препарат:', NULL, 'medium', 127, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Заліза сульфат', false, 0),
  ((SELECT id FROM inserted_question), 'Фраксипарин', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбін', false, 2),
  ((SELECT id FROM inserted_question), 'Кислота амінокапронова', false, 3),
  ((SELECT id FROM inserted_question), 'Вікасол', true, 4);


-- Question 128
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінці 50-ти років, яка хворіє на тромбофлебіт, ввели гепарин, що спровокував кишкову кровотечу. Який препарат потрібно призначити?', NULL, 'medium', 128, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Натрію цитрат', false, 0),
  ((SELECT id FROM inserted_question), 'Кислоту амінокапронову', false, 1),
  ((SELECT id FROM inserted_question), 'Протаміну сульфат', true, 2),
  ((SELECT id FROM inserted_question), 'Стрептокіназу', false, 3),
  ((SELECT id FROM inserted_question), 'Вікасол', false, 4);


-- Question 129
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому, що страждає на стенокардію та приймає ізосорбіду мононітрат, було додатково призначено лікарський засіб з дезагрегантним ефектом. Визначте цей препарат:', NULL, 'medium', 129, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ніфедипін', false, 0),
  ((SELECT id FROM inserted_question), 'Нітрогліцерин', false, 1),
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', true, 2),
  ((SELECT id FROM inserted_question), 'Анаприлін', false, 3),
  ((SELECT id FROM inserted_question), 'Валідол', false, 4);


-- Question 130
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт на ранніх етапах гострого інфаркту міокарда для відновлення кровопостачання ішемізованих тканин потребує тромболітичної терапії з використанням рекомбінантного активатора ппазміногену тканинного типу. Який із нижченаведених препаратів потрібно ввести пацієнту?', NULL, 'medium', 130, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Варфарин', false, 1),
  ((SELECT id FROM inserted_question), 'Гепарин', false, 2),
  ((SELECT id FROM inserted_question), 'Стрептокіназа', false, 3),
  ((SELECT id FROM inserted_question), 'Альтеплаза', true, 4);


-- Question 131
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарні звернулася жінка віком 71 рік, яка після прийому ацетилсаліцилової кислоти, що вживає з метою профілактики тромбозу, відчула такі симтоми: гострий біль в епігастрії, нудоту, печію, закрепи. Лікар діагностував виразку шлунка. Який механізм ульцерогенної дії ацетилсаліцилової кислоти лежить в основі розвитку виразки у цієї пацієнтки?', NULL, 'medium', 131, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активація входження Са +в клітини', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення утворення простагландинів', true, 1),
  ((SELECT id FROM inserted_question), 'Пригнічення синтезу фосфоліпази А2', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення синтезу шлункового соку', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення утворення лейкотрієнів', false, 4);


-- Question 132
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіку після інфаркту міокарда призначено ацетилсаліцилову кислоту, 75 мг щоденно. З якою метою призначено препарат?', NULL, 'medium', 132, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення агрегації тромбоцитів', true, 0),
  ((SELECT id FROM inserted_question), 'Зменшення запалення', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження температури', false, 2),
  ((SELECT id FROM inserted_question), 'Розширення коронарних судин', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення болю', false, 4);


-- Question 133
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки віком 40 років, яка систематично вживала ацетилсаліцилову кислоту, з''явилися крововиливи. Виявлено порушення функціональної активності тромбоцитів. З пригніченням якого ферменту це пов''язано?', NULL, 'medium', 133, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Na+, K+-АТФази', false, 0),
  ((SELECT id FROM inserted_question), 'Циклооксигенази', true, 1),
  ((SELECT id FROM inserted_question), 'Холінестерази', false, 2),
  ((SELECT id FROM inserted_question), 'Глюкозо-6-фосфатдегідрогенази', false, 3),
  ((SELECT id FROM inserted_question), 'Цитохромоксидази', false, 4);


-- Question 134
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнтки, яка приймає неодикумарин у звʼязку із тромбофлебітом, виникла кровоточивість. Який препарат необхідно призначити?', NULL, 'medium', 134, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дипіридамол', false, 0),
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Протаміну сульфат', false, 2),
  ((SELECT id FROM inserted_question), 'Пентоксифілін', false, 3),
  ((SELECT id FROM inserted_question), 'Вікасол', true, 4);


-- Question 135
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після вживання ацетилсаліцилової кислоти у пацієнта зʼявився біль у ділянці шлунка як наслідок загострення виразкової хвороби. Що лежить в основі ульцерогенності цього препарату?', NULL, 'medium', 135, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жовчогінна дія', false, 0),
  ((SELECT id FROM inserted_question), 'Стимулює дію пепсину', false, 1),
  ((SELECT id FROM inserted_question), 'Спазм судин', false, 2),
  ((SELECT id FROM inserted_question), 'Антипростагландинова дія', true, 3),
  ((SELECT id FROM inserted_question), 'Імунодепресивний ефект', false, 4);


-- Question 136
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіку, після інфаркту міокарда, призначено ацетилсаліцилову кислоту, 75 мг щоденно. З якою метою призначено препарат?', NULL, 'medium', 136, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення запалення', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення болю', false, 1),
  ((SELECT id FROM inserted_question), 'Розширення коронарних судин', false, 2),
  ((SELECT id FROM inserted_question), 'Зменшення агрегації тромбоцитів', true, 3),
  ((SELECT id FROM inserted_question), 'Зниження температури', false, 4);


-- Question 137
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту проведено оперативне втручання з протезування мітрального клапана. Оберіть препарат для попередження тромбоутворення для цього пацієнта.', NULL, 'medium', 137, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Урокіназа', false, 0),
  ((SELECT id FROM inserted_question), 'Варфарин', true, 1),
  ((SELECT id FROM inserted_question), 'Парацетамол', false, 2),
  ((SELECT id FROM inserted_question), 'Дипіридамол', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', false, 4);


-- Question 138
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що ацетилсаліцилова кислота та глюкокортикоїди мають виражену протизапальну дію. Укажіть на синтез яких біологічно активних речовин не впливає ацетилсаліцилова кислота на відміну від глюкокортикоїдів.', NULL, 'medium', 138, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Простагландинів Е', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкотрієнів', true, 1),
  ((SELECT id FROM inserted_question), 'Простациклінів', false, 2),
  ((SELECT id FROM inserted_question), 'Тромбоксанів', false, 3),
  ((SELECT id FROM inserted_question), 'Простагландинів F', false, 4);


-- Question 139
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому на тромбофлебіт призначено комплексну терапію, яка діє на різні етапи тромбоутворення. Яке з перелічених засобів сприяє відновленню прохідності судини?', NULL, 'medium', 139, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', false, 0),
  ((SELECT id FROM inserted_question), 'Гепарин', false, 1),
  ((SELECT id FROM inserted_question), 'Дипіридамол', false, 2),
  ((SELECT id FROM inserted_question), 'Неодикумарин', false, 3),
  ((SELECT id FROM inserted_question), 'Фібринолізин', true, 4);


-- Question 140
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого тромбоз коронарних судин. Необхідно введення речовини, що відновлює їх прохідність. Яка з перелічених речовин має необхідні властивостями?', NULL, 'medium', 140, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пентоксифілін', false, 0),
  ((SELECT id FROM inserted_question), 'Фенілін', false, 1),
  ((SELECT id FROM inserted_question), 'Стрептокіназа', true, 2),
  ((SELECT id FROM inserted_question), 'Гепарин', false, 3),
  ((SELECT id FROM inserted_question), 'Ацетилсаліцилова кислота', false, 4);


-- Question 141
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 37-ми років на фоні тривалого застосування антибіотиків спостерігається підвищена кровоточивість при невеликих пошкодженнях. У крові - зниження активності факторів згортання крові ІІ, VII, IX, X, подовження часу згортання крові. Недостатністю якого вітаміну обумовлені зазначені зміни?', NULL, 'medium', 141, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін А', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін D', false, 1),
  ((SELECT id FROM inserted_question), 'Вітамін С', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін Е', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін К', true, 4);


-- Question 142
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 2-річної дитини кишковий дисбактеріоз, на фоні якого виник геморагічний синдром. Що є найбільш імовірною причиною геморагій у цієї дитини?', NULL, 'medium', 142, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активація тромбопластину тканин', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпокальціємія', false, 1),
  ((SELECT id FROM inserted_question), 'Дефіцит фібриногену', false, 2),
  ((SELECT id FROM inserted_question), 'Гіповітаміноз РР', false, 3),
  ((SELECT id FROM inserted_question), 'Нестача вітаміну К', true, 4);


-- Question 143
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що введення в організм людини лікарського препарату дикумаролу викликає різке зниження в крові вмісту протромбіну і ряду інших білкових факторів згортання крові. Антивітаміном якого вітаміну є дикумарол?', NULL, 'medium', 143, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін P', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін K', true, 1),
  ((SELECT id FROM inserted_question), 'Вітамін E', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін H', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін C', false, 4);


-- Question 144
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому, що страждає на тромбоемболічну хворобу, призначений штучний антикоагулянт пелентан. Антагоністом якого вітаміну є цей препарат?', NULL, 'medium', 144, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вітамін Е', false, 0),
  ((SELECT id FROM inserted_question), 'Вітамін D', false, 1),
  ((SELECT id FROM inserted_question), 'Вітамін С', false, 2),
  ((SELECT id FROM inserted_question), 'Вітамін А', false, 3),
  ((SELECT id FROM inserted_question), 'Вітамін К', true, 4);


-- Question 145
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дослідження пацієнта віком 49 років виявлено суттєве збільшення часу зсідання крові, шлунково-кишкові кровотечі та підшкірні крововиливи. Нестачею якого вітаміну можна пояснити такі симптоми?', NULL, 'medium', 145, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'PP', false, 0),
  ((SELECT id FROM inserted_question), 'B1', false, 1),
  ((SELECT id FROM inserted_question), 'K', true, 2),
  ((SELECT id FROM inserted_question), 'H', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


COMMIT;
