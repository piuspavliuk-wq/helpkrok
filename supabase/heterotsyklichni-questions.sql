BEGIN;

-- Тема: Гетероциклічні сполуки 28

INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Гетероциклічні сполуки 28', 'Гетероциклічні сполуки 28', 0, true
FROM courses c
WHERE c.title = 'Основи знань про органічні сполуки'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Гетероциклічні сполуки 28');

DELETE FROM question_options WHERE question_id IN (
  SELECT q.id FROM questions q
  JOIN topics t ON t.id = q.topic_id
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
);

DELETE FROM questions WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених гетероциклічних сполук виявляє найсильніші основні властивості?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фуран', false, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Пірол', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3),
  ((SELECT id FROM inserted_question), 'Піролідин', true, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які два гетероциклічні кільця містить у своєму складі вітамін В1 (тіамін)?', NULL, 'medium', 2, true, '/test-images/organic/heterotsyklichni/img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піразинове та тіофенове', false, 0),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіофенове', false, 1),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіазольне', false, 2),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіофенове', false, 3),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіазольне', true, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який вид таутомерії характерний для гетероциклічних сполук із двома гетероатомами?', NULL, 'medium', 3, true, '/test-images/organic/heterotsyklichni/img2.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кето-польна', false, 0),
  ((SELECT id FROM inserted_question), 'Лактам-лактимна', false, 1),
  ((SELECT id FROM inserted_question), 'Азольна', true, 2),
  ((SELECT id FROM inserted_question), 'Аміно-імінна', false, 3),
  ((SELECT id FROM inserted_question), 'Нітро-аци-нітро', false, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка гетероциклічна структура входить до складу бактерицидного лікарського препарату риванолу?', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Антрацену', false, 0),
  ((SELECT id FROM inserted_question), 'Акридину', true, 1),
  ((SELECT id FROM inserted_question), 'Фенатрену', false, 2),
  ((SELECT id FROM inserted_question), 'Хіноліну', false, 3),
  ((SELECT id FROM inserted_question), 'Ізохіноліну', false, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Шестичленні нітрогенвмісні гетероциклічні сполуки проявляють основні властивості. Вкажіть сполуку, що має найбільш сильні основні властивості:', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піперазин', true, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 2),
  ((SELECT id FROM inserted_question), 'Піразин', false, 3),
  ((SELECT id FROM inserted_question), 'Піридазин', false, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених структурних формул гетероциклічних сполук виберіть бензо-1,4-діазепін:', NULL, 'medium', 6, true, '/test-images/organic/heterotsyklichni/img3.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пірол відноситься до:', NULL, 'medium', 7, true, '/test-images/organic/heterotsyklichni/img4.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Конденсованих гетероциклів', false, 0),
  ((SELECT id FROM inserted_question), 'Шестичленних гетероциклів з одним гетероатомом', false, 1),
  ((SELECT id FROM inserted_question), 'П’ятичленних гетероциклів з двома гетероатомами', false, 2),
  ((SELECT id FROM inserted_question), 'П’ятичленних гетероциклів з одним гетероатомом', true, 3),
  ((SELECT id FROM inserted_question), 'Шестичленних гетероциклів з двома гетероатомами', false, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть назву п’ятичленного гетероциклу, що містить гетероатоми нітрогену пірольного та піридинового типу.', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Триазол', false, 0),
  ((SELECT id FROM inserted_question), 'Піперидин', false, 1),
  ((SELECT id FROM inserted_question), 'Піразолідин', false, 2),
  ((SELECT id FROM inserted_question), 'Тіазол', false, 3),
  ((SELECT id FROM inserted_question), 'Піразол', true, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для сульфування ацидофобних сполук, зокрема фурану, використовують:', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'Розведену сірчану кислоту', false, 1),
  ((SELECT id FROM inserted_question), 'Піридинсульфотриоксид C6H5N • SO3', true, 2),
  ((SELECT id FROM inserted_question), 'Концентровану сірчану кислоту', false, 3),
  ((SELECT id FROM inserted_question), '”Царську горілку”', false, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який електрофільний реагент застосовується для сульфування піролу і фурану?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'b. Концентрована сульфатна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'c. Розбавлена сульфатна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'd. Піридинсульфотриоксид', true, 3),
  ((SELECT id FROM inserted_question), 'e. Суміш сульфатної і нітратної кислот', false, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених гетероциклічних сполук виявляє найсильніші основні властивості?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фуран', false, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Пірол', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3),
  ((SELECT id FROM inserted_question), 'Піролідин', true, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Визначте, яка з наведених циклічних сполук відноситься до карбоциклічних:', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензол', true, 0),
  ((SELECT id FROM inserted_question), 'Фуран', false, 1),
  ((SELECT id FROM inserted_question), 'Тетрагідрофуран', false, 2),
  ((SELECT id FROM inserted_question), 'Піридин', false, 3),
  ((SELECT id FROM inserted_question), 'Гексан', false, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з вказаних сполук є найстійкішою до дії окисників?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нафталін', false, 0),
  ((SELECT id FROM inserted_question), 'Гексанол', false, 1),
  ((SELECT id FROM inserted_question), 'Толуол', false, 2),
  ((SELECT id FROM inserted_question), 'Фуран', false, 3),
  ((SELECT id FROM inserted_question), 'Бензол', true, 4);


-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук має ацидофобні властивості?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пірол', true, 0),
  ((SELECT id FROM inserted_question), 'Піразол', false, 1),
  ((SELECT id FROM inserted_question), 'Піридин', false, 2),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 3),
  ((SELECT id FROM inserted_question), 'Імідазол', false, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який гетероцикл має ацидофобні властивості?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хінолін', false, 0),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 1),
  ((SELECT id FROM inserted_question), 'Птеридин', false, 2),
  ((SELECT id FROM inserted_question), 'Пірол', true, 3),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 4);


-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При повному відновленні піролу одержують:', NULL, 'medium', 16, true, '/test-images/organic/heterotsyklichni/img5.png,/test-images/organic/heterotsyklichni/img6.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1.', true, 0),
  ((SELECT id FROM inserted_question), '2.', false, 1),
  ((SELECT id FROM inserted_question), '3.', false, 2),
  ((SELECT id FROM inserted_question), '4.', false, 3),
  ((SELECT id FROM inserted_question), '5.', false, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених нижче сполук вкажіть сполуку, що містить пірольний та піридиновий атоми азоту:', NULL, 'medium', 17, true, '/test-images/organic/heterotsyklichni/img7.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з реакцій свідчить про кислотні властивості піролу?', NULL, 'medium', 18, true, '/test-images/organic/heterotsyklichni/img8.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1.', true, 0),
  ((SELECT id FROM inserted_question), '3.', false, 1),
  ((SELECT id FROM inserted_question), '4.', false, 2),
  ((SELECT id FROM inserted_question), '5.', false, 3),
  ((SELECT id FROM inserted_question), '2.', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з нижченаведених гетероциклічних сполук виявляє найсильніші основні властивості?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фуран', false, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Пірол', false, 2),
  ((SELECT id FROM inserted_question), 'Тіофен', false, 3),
  ((SELECT id FROM inserted_question), 'Піролідин', true, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відповідно до правила Хюккеля критерієм ароматичності органічної сполуки є:', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Органічні сполуки, молекули яких складаються тільки з атомів Карбону та Гідрогену та утворюють незамкнений вуглецевий ланцюг', false, 0),
  ((SELECT id FROM inserted_question), 'Наявність циклогексанового кільця', false, 1),
  ((SELECT id FROM inserted_question), 'Наявність у структурі плоского циклу, який містить замкнену кон’юговану систему, що включає (4n+2) пі-електронів, де n = 0,1,2,3, і т.д.', true, 2),
  ((SELECT id FROM inserted_question), 'Наявність конденсованих ядер в молекулі', false, 3),
  ((SELECT id FROM inserted_question), 'Наявність в молекулі тільки одного замісника', false, 4);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У разі якого числового значення n виконується правило Хюккеля (4n+2) для нафталіну?', NULL, 'medium', 21, true, '/test-images/organic/heterotsyklichni/img9.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'n=4', false, 0),
  ((SELECT id FROM inserted_question), 'n=2', true, 1),
  ((SELECT id FROM inserted_question), 'n=8', false, 2),
  ((SELECT id FROM inserted_question), 'n=1', false, 3),
  ((SELECT id FROM inserted_question), 'n=0', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За якого числового значення n виконується правило Хюккеля (4n+2) для антрацену?', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'N=10', false, 0),
  ((SELECT id FROM inserted_question), 'N=0', false, 1),
  ((SELECT id FROM inserted_question), 'N=2', false, 2),
  ((SELECT id FROM inserted_question), 'N=3', true, 3),
  ((SELECT id FROM inserted_question), 'N=1', false, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть положення в молекулі піразолу, за яким проходять реакції електрофільного заміщення.', NULL, 'medium', 23, true, '/test-images/organic/heterotsyklichni/img10.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '2', false, 0),
  ((SELECT id FROM inserted_question), '1', false, 1),
  ((SELECT id FROM inserted_question), '3', false, 2),
  ((SELECT id FROM inserted_question), '4', true, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для піридину характерні реакції електрофільного (SE ) та нуклеофільного (SN ) заміщення. Низька реакційна здатніть піридину в реакціях SE обумовлена:', NULL, 'medium', 24, true, '/test-images/organic/heterotsyklichni/img11.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електроноакцепторними властивостями атому нітрогену', true, 0),
  ((SELECT id FROM inserted_question), 'Ароматичним характером піридинового ядра', false, 1),
  ((SELECT id FROM inserted_question), 'Основними властивостями', false, 2),
  ((SELECT id FROM inserted_question), 'Гібридизацією атомів карбону', false, 3),
  ((SELECT id FROM inserted_question), 'Розміром циклу', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які функціональні групи містяться в циклічних формах рибози та дезоксирибози?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гідроксильні й альдегідні', false, 0),
  ((SELECT id FROM inserted_question), 'Лише альдегідні', false, 1),
  ((SELECT id FROM inserted_question), 'Лише гідроксильні', true, 2),
  ((SELECT id FROM inserted_question), 'Лише карбоксильні', false, 3),
  ((SELECT id FROM inserted_question), 'Гідроксильні та карбоксильні', false, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених сполук вкажіть сукцинімід (імід янтарної кислоти):', NULL, 'medium', 26, true, '/test-images/organic/heterotsyklichni/img12.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хлорофіл - зелений пігмент рослин, є комплексною сполукою. Вкажіть іон комплексоутворювач у хлорофілі:', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Mg2', false, 0),
  ((SELECT id FROM inserted_question), 'Fe3', false, 1),
  ((SELECT id FROM inserted_question), 'Mn2', false, 2),
  ((SELECT id FROM inserted_question), 'F e2', false, 3),
  ((SELECT id FROM inserted_question), 'Ni2', true, 4);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Алкілювання за Фріделем-Крафтсом відбувається в присутності каталізаторів — кислот Льюїса. Які з наведених нижче сполук входять до їх переліку?', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'КОН, СаO', false, 0),
  ((SELECT id FROM inserted_question), 'KMnO4, Na2S2O3', false, 1),
  ((SELECT id FROM inserted_question), 'H2SO4, HNO3', false, 2),
  ((SELECT id FROM inserted_question), 'H2O, H2O2', false, 3),
  ((SELECT id FROM inserted_question), 'AlCl3, FeBr3', true, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При алкілуванні ароматичних вуглеводнів за Фріделем-Крафтсом як каталізатор використовують:', NULL, 'medium', 29, true, '/test-images/organic/heterotsyklichni/img13.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'NaOH (сп. р-н.)', false, 0),
  ((SELECT id FROM inserted_question), 'Безводний AlCl3', true, 1),
  ((SELECT id FROM inserted_question), 'Pt', false, 2),
  ((SELECT id FROM inserted_question), 'Cr2O3', false, 3),
  ((SELECT id FROM inserted_question), 'PCl5', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Які два гетероциклічні кільця містить у своєму складі вітамін В1 (тіамін)?', NULL, 'medium', 30, true, '/test-images/organic/heterotsyklichni/img1.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піразинове та тіофенове', false, 0),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіофенове', false, 1),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіазольне', false, 2),
  ((SELECT id FROM inserted_question), 'Піридазинове та тіофенове', false, 3),
  ((SELECT id FROM inserted_question), 'Піримідинове та тіазольне', true, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Водорозчинні вітаміни в організмі перетворюються у коферментні форми. Коферментною формою якого вітаміну є тіаміндифосфат (ТДФ)?', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'B1', true, 0),
  ((SELECT id FROM inserted_question), 'B2', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'B6', false, 3),
  ((SELECT id FROM inserted_question), 'B12', false, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Шестичленні нітрогенвмісні гетероциклічні сполуки проявляють основні властивості. Вкажіть сполуку, що має найбільш сильні основні властивості:', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піперазин', true, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 2),
  ((SELECT id FROM inserted_question), 'Піразин', false, 3),
  ((SELECT id FROM inserted_question), 'Піридазин', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чому дорівнює максимальна валентність нітрогену з урахуванням донорно-акцепторного механізму утворення ковалентного зв’язку?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '4', true, 0),
  ((SELECT id FROM inserted_question), '1', false, 1),
  ((SELECT id FROM inserted_question), '2', false, 2),
  ((SELECT id FROM inserted_question), '3', false, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для піридину характерні реакції електрофільного (SE ) та нуклеофільного (SN ) заміщення. Низька реакційна здатніть піридину в реакціях SE обумовлена:', NULL, 'medium', 34, true, '/test-images/organic/heterotsyklichni/img11.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електроноакцепторними властивостями атому нітрогену', true, 0),
  ((SELECT id FROM inserted_question), 'Ароматичним характером піридинового ядра', false, 1),
  ((SELECT id FROM inserted_question), 'Основними властивостями', false, 2),
  ((SELECT id FROM inserted_question), 'Гібридизацією атомів карбону', false, 3),
  ((SELECT id FROM inserted_question), 'Розміром циклу', false, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для сульфування ацидофобних сполук, зокрема фурану, використовують:', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'Розведену сірчану кислоту', false, 1),
  ((SELECT id FROM inserted_question), 'Піридинсульфотриоксид C6H5N • SO3', true, 2),
  ((SELECT id FROM inserted_question), 'Концентровану сірчану кислоту', false, 3),
  ((SELECT id FROM inserted_question), '”Царську горілку”', false, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який електрофільний реагент застосовується для сульфування піролу і фурану?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'a. Олеум', false, 0),
  ((SELECT id FROM inserted_question), 'b. Концентрована сульфатна кислота', false, 1),
  ((SELECT id FROM inserted_question), 'c. Розбавлена сульфатна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'd. Піридинсульфотриоксид', true, 3),
  ((SELECT id FROM inserted_question), 'e. Суміш сульфатної і нітратної кислот', false, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За замісною номенклатурою IUPAC нікотинова кислота має назву:', NULL, 'medium', 37, true, '/test-images/organic/heterotsyklichni/img14.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '3- карбоксипіридин', false, 0),
  ((SELECT id FROM inserted_question), '2- карбоксипіридин', false, 1),
  ((SELECT id FROM inserted_question), 'Піридин-3-карбонова кислота', true, 2),
  ((SELECT id FROM inserted_question), 'Піридин-4-карбонова кислота', false, 3),
  ((SELECT id FROM inserted_question), 'Піридин-2-карбонова кислота', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка назва відповідає наведеній формулі?', NULL, 'medium', 38, true, '/test-images/organic/heterotsyklichni/img15.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бензо [b] піридин', true, 0),
  ((SELECT id FROM inserted_question), 'Бензо [b] пірон-4', false, 1),
  ((SELECT id FROM inserted_question), 'Імідазопіримідин', false, 2),
  ((SELECT id FROM inserted_question), 'Піразинопіримідин', false, 3),
  ((SELECT id FROM inserted_question), 'Бензотіазол', false, 4);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утвориться в результаті окиснення З-метилпіридину за нижченаведеною схемою?', NULL, 'medium', 39, true, '/test-images/organic/heterotsyklichni/img16.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '3-гідроксипіридин', false, 0),
  ((SELECT id FROM inserted_question), 'Ізонікотинова кислота', false, 1),
  ((SELECT id FROM inserted_question), '2-гідроксипіридин', false, 2),
  ((SELECT id FROM inserted_question), 'Нікотинова кислота', true, 3),
  ((SELECT id FROM inserted_question), 'Піколінова кислота', false, 4);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка сполука утвориться в результаті окиснення 3-метилпіридину за наведеною нижче схемою?', NULL, 'medium', 40, true, '/test-images/organic/heterotsyklichni/img17.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нікотинова кислота', true, 0),
  ((SELECT id FROM inserted_question), 'Ізонікотинова кислота', false, 1),
  ((SELECT id FROM inserted_question), 'Піколінова кислота', false, 2),
  ((SELECT id FROM inserted_question), '3-Гідроксипіридин', false, 3),
  ((SELECT id FROM inserted_question), '2-Гідроксипіридин', false, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених нижче сполук відповідає піридину?', NULL, 'medium', 41, true, '/test-images/organic/heterotsyklichni/img18.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'А', false, 0),
  ((SELECT id FROM inserted_question), 'В', false, 1),
  ((SELECT id FROM inserted_question), 'С', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', true, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час взаємодії якого реагенту з піридином можна отримати 2-амінопіридин?', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амонію гідроксиду', false, 0),
  ((SELECT id FROM inserted_question), 'Гідразину', false, 1),
  ((SELECT id FROM inserted_question), 'Амонію хлориду', false, 2),
  ((SELECT id FROM inserted_question), 'Натрію аміду', true, 3),
  ((SELECT id FROM inserted_question), 'Амоніаку', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених нижче сполук вкажіть сполуку, що містить пірольний та піридиновий атоми азоту:', NULL, 'medium', 43, true, '/test-images/organic/heterotsyklichni/img7.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Серед наведених сполук вкажіть піридин:', NULL, 'medium', 44, true, '/test-images/organic/heterotsyklichni/img19.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'B', false, 0),
  ((SELECT id FROM inserted_question), 'C', false, 1),
  ((SELECT id FROM inserted_question), 'A', true, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'За яким механізмом відбувається реакція амінування піридину (реакція Чичибабіна)?', NULL, 'medium', 45, true, '/test-images/organic/heterotsyklichni/img20.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'SE', false, 0),
  ((SELECT id FROM inserted_question), 'SR', false, 1),
  ((SELECT id FROM inserted_question), 'SN', true, 2),
  ((SELECT id FROM inserted_question), 'AE', false, 3),
  ((SELECT id FROM inserted_question), 'AN', false, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Первинним акцептором водню при тканинному диханні виступають піридинзалежні дегідрогенази. Який з вітамінів необхідний для утворення відповідного коферменту (НАД+)?', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'B1', false, 0),
  ((SELECT id FROM inserted_question), 'B2', false, 1),
  ((SELECT id FROM inserted_question), 'PP', true, 2),
  ((SELECT id FROM inserted_question), 'C', false, 3),
  ((SELECT id FROM inserted_question), 'B6', false, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених реакцій вказує на основні властивості піридину?', NULL, 'medium', 47, true, '/test-images/organic/heterotsyklichni/img21.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених реакцій вказує на основні властивості піридину?', NULL, 'medium', 48, true, '/test-images/organic/heterotsyklichni/img22.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', true, 0),
  ((SELECT id FROM inserted_question), 'B', false, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених сполук має ацидофобні властивості?', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пірол', true, 0),
  ((SELECT id FROM inserted_question), 'Піразол', false, 1),
  ((SELECT id FROM inserted_question), 'Піридин', false, 2),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 3),
  ((SELECT id FROM inserted_question), 'Імідазол', false, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для піридину характерні реакції електрофільного (SE ) та нуклеофільного (SN ) заміщення. Низька реакційна здатніть піридину в реакціях SE обумовлена:', NULL, 'medium', 50, true, '/test-images/organic/heterotsyklichni/img11.png,/test-images/organic/heterotsyklichni/img23.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Електроноакцепторними властивостями атому нітрогену', true, 0),
  ((SELECT id FROM inserted_question), 'Ароматичним характером піридинового ядра', false, 1),
  ((SELECT id FROM inserted_question), 'Основними властивостями', false, 2),
  ((SELECT id FROM inserted_question), 'Гібридизацією атомів карбону', false, 3),
  ((SELECT id FROM inserted_question), 'Розміром циклу', false, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Шестичленні нітрогенвмісні гетероциклічні сполуки проявляють основні властивості. Вкажіть сполуку, що має найбільш сильні основні властивості:', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Піперазин', true, 0),
  ((SELECT id FROM inserted_question), 'Піридин', false, 1),
  ((SELECT id FROM inserted_question), 'Піримідин', false, 2),
  ((SELECT id FROM inserted_question), 'Піразин', false, 3),
  ((SELECT id FROM inserted_question), 'Піридазин', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для запобігання розвитку мʼязової дистрофії лікар призначив пацієнту калію оротат. Проміжним продуктом синтезу якої речовини є ця сполука?', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Холестерину', false, 0),
  ((SELECT id FROM inserted_question), 'Кетонових тіл', false, 1),
  ((SELECT id FROM inserted_question), 'Жовчних кислот', false, 2),
  ((SELECT id FROM inserted_question), 'Глюкози', false, 3),
  ((SELECT id FROM inserted_question), 'Піримідинових нуклеотидів', true, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У клітинах E.coli синтез піримідинових нуклеотидів здійснюється за схемою метаболічного шляху: CO2 + NH3 + 2АTФ > P1 > Р 2 > УТФ > ЦТФ. При збільшенні в клітині концентрації ЦТФ синтез піримідинових нуклеотидів зупиняється. Який вид регуляції описаний?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Приєднання білків інгібіторів', false, 0),
  ((SELECT id FROM inserted_question), 'Фосфорилювання молекули ферменту', false, 1),
  ((SELECT id FROM inserted_question), 'Відщеплення білків інгібіторів', false, 2),
  ((SELECT id FROM inserted_question), 'Частковий протеоліз', false, 3),
  ((SELECT id FROM inserted_question), 'Алостерична регуляція', true, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт прийняв велику дозу снодійного препарату ряду барбітуратів (аміталу), який є інгібітором НАД - залежної дегідрогенази дихального ланцюга. Який процес порушиться за цих умов у мітохондріях?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Синтез АТФ', true, 0),
  ((SELECT id FROM inserted_question), 'Синтез глікогену', false, 1),
  ((SELECT id FROM inserted_question), 'Синтез амінокислот', false, 2),
  ((SELECT id FROM inserted_question), 'Синтез ліпідів', false, 3),
  ((SELECT id FROM inserted_question), 'Синтез глюкози', false, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка, хворого на подагру, виявлено значне підвищення рівня сечової кислоти в крові. Кінцевим продуктом обміну яких речовин є сечова кислота?', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тригліцеридів', false, 0),
  ((SELECT id FROM inserted_question), 'Жирних кислот', false, 1),
  ((SELECT id FROM inserted_question), 'Глобулінів', false, 2),
  ((SELECT id FROM inserted_question), 'Альбумінів', false, 3),
  ((SELECT id FROM inserted_question), 'Пуринових основ', true, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Назвіть психостимулятор з аналептичними властивостями, похідне пуринів:', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Трамадол', false, 0),
  ((SELECT id FROM inserted_question), 'Медазепам', false, 1),
  ((SELECT id FROM inserted_question), 'Натрію бромід', false, 2),
  ((SELECT id FROM inserted_question), 'Сульпірид', false, 3),
  ((SELECT id FROM inserted_question), 'Кофеїн-бензоат натрію', true, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому на подагру призначено алопуринол, конкурентний інгібітор ксантиноксидази, термінального ферменту розпаду:', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вищих жирних кислот', false, 0),
  ((SELECT id FROM inserted_question), 'Глікопротеїнів', false, 1),
  ((SELECT id FROM inserted_question), 'Пуринових нуклеотидів', true, 2),
  ((SELECT id FROM inserted_question), 'Фосфоліпідів', false, 3),
  ((SELECT id FROM inserted_question), 'Гетерополісахаридів', false, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вкажіть продукт взаємодії пурину з натрій гідроксидом:', NULL, 'medium', 58, true, '/test-images/organic/heterotsyklichni/img24.png,/test-images/organic/heterotsyklichni/img25.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
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
  SELECT t.id, 'Виберіть правильну назву для даної сполуки:', NULL, 'medium', 59, true, '/test-images/organic/heterotsyklichni/img26.png,/test-images/organic/heterotsyklichni/img27.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '6-нітропурин', false, 0),
  ((SELECT id FROM inserted_question), '6-амінопурин', true, 1),
  ((SELECT id FROM inserted_question), '2-амінопурин', false, 2),
  ((SELECT id FROM inserted_question), '8-амінопурин', false, 3),
  ((SELECT id FROM inserted_question), '4-амінопурин', false, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік звернувся до лікаря з приводу сильного болю в суглобах. Аналіз сечі показав підвищений рівень сечової кислоти, що свідчить про:', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищену активність гліколізу', false, 0),
  ((SELECT id FROM inserted_question), 'Підвищений синтез кетонових тіл', false, 1),
  ((SELECT id FROM inserted_question), 'Підвищену активність глікогенолізу', false, 2),
  ((SELECT id FROM inserted_question), 'Інтенсивний розпад пуринових нуклеотидів', true, 3),
  ((SELECT id FROM inserted_question), 'Підвищену активність бета-окиснення жирних кислот', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Суглоби хворого збільшені за розміром, мають вигляд потовщених деформованих вузлів. У крові - підвищений вміст сечової кислоти та її солей. Порушення обміну яких речовин є причиною такого стану?', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пурини', true, 0),
  ((SELECT id FROM inserted_question), 'Піримідини', false, 1),
  ((SELECT id FROM inserted_question), 'Порфірини', false, 2),
  ((SELECT id FROM inserted_question), 'Холестерин', false, 3),
  ((SELECT id FROM inserted_question), 'Фосфоліпіди', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Алопуринол використовують для зниження утворення сечової кислоти під час лікування подагри. Який фермент інгібує цей лікарський засіб?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ксантиноксидазу', true, 0),
  ((SELECT id FROM inserted_question), 'Каталазу', false, 1),
  ((SELECT id FROM inserted_question), 'Аргінащу', false, 2),
  ((SELECT id FROM inserted_question), 'Лактатдегідрогеназу', false, 3),
  ((SELECT id FROM inserted_question), 'Амілазу', false, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для лікування подагри використовується алопуринол. Який механізм дії цього лікарського засобу?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Активатор ксантиноксидази', false, 0),
  ((SELECT id FROM inserted_question), 'Кофермент ксантиноксидази', false, 1),
  ((SELECT id FROM inserted_question), 'Інгібітор синтезу пуринових нуклеотидів', false, 2),
  ((SELECT id FROM inserted_question), 'Активатор катаболізму пуринових нуклеотидів', false, 3),
  ((SELECT id FROM inserted_question), 'Конкурентний інгібітор ксантиноксидази', true, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для якісного виявлення сечової кислоти та інших сполук, що містять пуринове ядро використовується:', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мурексидна реакція', true, 0),
  ((SELECT id FROM inserted_question), 'Реакція ”срібного дзеркала”', false, 1),
  ((SELECT id FROM inserted_question), 'Реактив Лукаса', false, 2),
  ((SELECT id FROM inserted_question), 'Реактив Фелінга', false, 3),
  ((SELECT id FROM inserted_question), 'Реакція ”мідного дзеркала”', false, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Біосинтез пуринового кільця відбувається на рибозо-5-фосфаті шляхом поступового нарощення атомів азоту і вуглецю та замикання кілець. Джерелом рибозофосфату є такий процес:', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гліконеогенез', false, 0),
  ((SELECT id FROM inserted_question), 'Глюконеогенез', false, 1),
  ((SELECT id FROM inserted_question), 'Пентозофосфатний цикл', true, 2),
  ((SELECT id FROM inserted_question), 'Глікогеноліз', false, 3),
  ((SELECT id FROM inserted_question), 'Гліколіз', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Відомо, що подагра є однією з найпоширеніших причин розвитку гострих і хронічних рецидивних артритів. Який із наведених лабораторних показників є провідним для диференційної діагностики подагричного артриту?', NULL, 'medium', 66, true, '/test-images/organic/heterotsyklichni/img28.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіполіпідемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперліпідемія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіперпротеїнемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіперурикемія', true, 3),
  ((SELECT id FROM inserted_question), 'Гіпопротеїнемія', false, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту для лікування ентеробіозу призначено антигельмінтний засіб широкого спектра дії. Укажіть препарат, механізм дії якого полягає в пригніченні полімеризації білка гельмінтів тубуліну, що призводить до порушення метаболізму та загибелі гельмінтів.', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ципрофлоксацину гідрохлорид', false, 0),
  ((SELECT id FROM inserted_question), 'Флуконазол', false, 1),
  ((SELECT id FROM inserted_question), 'Ізоніазид', false, 2),
  ((SELECT id FROM inserted_question), 'Метронідазол', false, 3),
  ((SELECT id FROM inserted_question), 'Альбендазол', true, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який протипротозойний лікарський засіб проявляє антихелікобактерну активність?', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ізоніазид', false, 0),
  ((SELECT id FROM inserted_question), 'Рифампіцин', false, 1),
  ((SELECT id FROM inserted_question), 'Метронідазол', true, 2),
  ((SELECT id FROM inserted_question), '—', false, 3),
  ((SELECT id FROM inserted_question), 'Альбендазол', false, 4);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту 28-ми років з виразкою шлунка призначили лікарський засіб, який пригнічує секрецію шлункового соку. Вкажіть препарат:', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лідокаїн', false, 0),
  ((SELECT id FROM inserted_question), 'Фенофібрат', false, 1),
  ((SELECT id FROM inserted_question), 'Омепразол', true, 2),
  ((SELECT id FROM inserted_question), 'Дуфалак', false, 3),
  ((SELECT id FROM inserted_question), 'Кислота етакринова', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому 37 років з метою комплексного лікування виразкової хвороби шлунка було призначено препарат, що знижує кислотність шлункового соку, інгібує +, +-АТФ-азу, знижує об’єм шлункової секреції і виділення пепсиногену. Відноситься до проліків. Назвіть препарат:', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гастроцепін', false, 0),
  ((SELECT id FROM inserted_question), 'Фамотидин', false, 1),
  ((SELECT id FROM inserted_question), 'Ранітидин', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфалюгель', false, 3),
  ((SELECT id FROM inserted_question), 'Омепразол', true, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка, який страждає на хронічну непрохідність кишечнику, посилюється гниття білків у товстому кишечнику. Яка токсична речовина утворюється у цьому випадку з триптофану?', NULL, 'medium', 71, true, '/test-images/organic/heterotsyklichni/img29.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Індол', true, 0),
  ((SELECT id FROM inserted_question), 'Білірубін', false, 1),
  ((SELECT id FROM inserted_question), 'Лактат', false, 2),
  ((SELECT id FROM inserted_question), 'Креатин', false, 3),
  ((SELECT id FROM inserted_question), 'Глюкоза', false, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Укажіть положення в молекулі індолу, за яким проходить реакція його нітрування.', NULL, 'medium', 72, true, '/test-images/organic/heterotsyklichni/img30.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1', false, 0),
  ((SELECT id FROM inserted_question), '2', false, 1),
  ((SELECT id FROM inserted_question), '3', true, 2),
  ((SELECT id FROM inserted_question), '4', false, 3),
  ((SELECT id FROM inserted_question), '5', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В процесі декарбоксилювання 5- гідрокситриптофану утворюється біогенний амін, що має судинозвужуючу дію. Назвіть даний біогенний амін:', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серотонін', true, 0),
  ((SELECT id FROM inserted_question), 'Гістамін', false, 1),
  ((SELECT id FROM inserted_question), 'Гамма-аміномасляна кислота', false, 2),
  ((SELECT id FROM inserted_question), 'Путресцин', false, 3),
  ((SELECT id FROM inserted_question), 'Кадаверин', false, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 55-ти років на 4-й день лікування індометацином виникла шлункова кровотеча внаслідок утворення виразки слизової оболонки шлунка. Ульцерогенна дія препарату пов’язана із зменшенням активності такого ферменту:', NULL, 'medium', 74, true, '/test-images/organic/heterotsyklichni/img31.png'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циклооксигеназа-2 ( ЦОГ -2)', false, 0),
  ((SELECT id FROM inserted_question), 'Циклооксигеназа-1 (ЦОГ-1)', true, 1),
  ((SELECT id FROM inserted_question), 'Тромбоксансинтетаза', false, 2),
  ((SELECT id FROM inserted_question), 'Ліпооксигеназа (ЛОГ)', false, 3),
  ((SELECT id FROM inserted_question), 'Простациклінсинтетаза', false, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До розчину катіонів пʼятої аналітичної групи додали аміачний буфер і розчин 8-оксихіноліну. Утворився осад жовто-зеленого кольору. Якому катіону відповідає ця якісна реакція?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мангану', false, 0),
  ((SELECT id FROM inserted_question), 'Амонію', false, 1),
  ((SELECT id FROM inserted_question), 'Кальцію', false, 2),
  ((SELECT id FROM inserted_question), 'Заліза (ІІ)', false, 3),
  ((SELECT id FROM inserted_question), 'Магнію', true, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Яка з наведених структурних формул відповідає хіноліну?', NULL, 'medium', 76, true, '/test-images/organic/heterotsyklichni/img32.jpeg'
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки'
    AND t.title = 'Гетероциклічні сполуки 28'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'A', false, 0),
  ((SELECT id FROM inserted_question), 'B', true, 1),
  ((SELECT id FROM inserted_question), 'C', false, 2),
  ((SELECT id FROM inserted_question), 'D', false, 3),
  ((SELECT id FROM inserted_question), 'E', false, 4);


COMMIT;