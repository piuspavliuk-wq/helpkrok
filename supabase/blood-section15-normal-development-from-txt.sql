BEGIN;

-- Auto-generated from: /Users/bohdanpavliuk/Downloads/Нормальний розвиток і структура, вікові зміни.txt
-- Questions parsed: 208

INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)
SELECT c.id, 'Нормальний розвиток і структура, вікові зміни', 'Імпорт із файлу Нормальний розвиток і структура, вікові зміни.txt', 0, true, NOW(), NOW()
FROM courses c
WHERE c.title = 'Система кровотворення й імунного захисту, кров'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Нормальний розвиток і структура, вікові зміни');

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
  LIMIT 1
);

-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, '42-річний чоловік захворів гостро після переохолодження. Захворювання супроводжувалось серцево-дихальною недостатністю, від якої він помер. Під час розтину виявлено, що уся права легеня збільшена, гепатизована, на плеврі значні фібринозні накладення. На розрізі легеня сірого кольору, зерниста, з поверхні стікає каламутна рідина. Гістологічне дослідження виявило гостре запалення з наявністю у просвітах альвеол гнійно-фібринозного ексудату. Який із наведених діагнозів найімовірніший?', NULL, 'medium', 1, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стафілококова пневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Ідіопатичний фіброзуючий альвеоліт', false, 1),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 2),
  ((SELECT id FROM inserted_question), 'Осередкова пневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Інтерстиційна міжальвеолярна пневмонія', false, 4);


-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Верхня частка правої легені збільшена, сірого кольору, безповітряна, з поверхні розрізу стікає каламутна рідина, на плеврі багато фібринозних плівок; мікроскопічно в альвеолах виявляється ексудат з присутністю нейтрофілів, десквамованих альвеолоцитів і ниток фібрину. Стінка бронха інтактна. Який найбільш вірогідний діагноз?', NULL, 'medium', 2, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Абсцес легень', false, 0),
  ((SELECT id FROM inserted_question), 'Грипозна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Вогнищева пневмонія', false, 2),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна пневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 4);


-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині тіла померлого виявлено, що вся права легеня збільшена у розмірі, щільна, на плеврі нашарування фібрину, на розрізі тканина легені сірого кольору, з неї стікає каламутна рідина. Для якого захворювання легень характерна така картина?', NULL, 'medium', 3, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гангрена легені', false, 0),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 2),
  ((SELECT id FROM inserted_question), 'Фіброзуючий альвеоліт', false, 3),
  ((SELECT id FROM inserted_question), 'Вогнищева пневмонія', false, 4);


-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині тіла померлого виявлено, що вся права легеня збільшена, щільна, на плеврі нашарування фібрину, на розрізі тканина сірого кольору, з якої стікає каламутна рідина. Для якого захворювання легенів характерна така картина?', NULL, 'medium', 4, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 0),
  ((SELECT id FROM inserted_question), 'Вогнищева пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Фіброзувальний альвеоліт', false, 2),
  ((SELECT id FROM inserted_question), 'Гангрена легені', false, 3),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна пневмонія', false, 4);


-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині трупа чоловіка 50-ти років виявлено наступні зміни: права легеня у всіх відділах помірно щільна, на розрізі тканина безповітряна, дрібнозерниста, сухувата. Вісцеральна плевра з нашаруванням фібрину сіро-коричневого кольору. Який найбільш імовірний діагноз?', NULL, 'medium', 5, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пневмофіброз', false, 0),
  ((SELECT id FROM inserted_question), 'Бронхопневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна пневмонія', false, 2),
  ((SELECT id FROM inserted_question), 'Туберкульоз', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 4);


-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На судово-медичній експертизі знаходиться тіло чоловіка 58-ми років, який тривалий час зловживав алкоголем. Помер вдома. Макроскопічно: права легеня щільна і збільшена в розмірах, тканина на розрізі сіруватого кольору, однорідна, плевра вкрита сіруватими плівчастими нашаруваннями. Мікроскопічно - порожнини альвеол містять нитки фібрину, гемолізовані еритроцити. Діагностуйте захворювання:', NULL, 'medium', 6, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вогнищева пневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Інтерстиційна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Первинний туберкульоз легень', false, 2),
  ((SELECT id FROM inserted_question), 'Казеозна пневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 4);


-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла чоловіка віком 50 років виявлено такі зміни: права легеня помірно щільна в усіх відділах, на розрізі тканина безповітряна, дрібнозерниста, сухувата. Вісцеральна плевра має нашарування фібрину сіро-коричневого кольору. Для якого захворювання характерні такі патологічні зміни?', NULL, 'medium', 7, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозної пневмонії', true, 0),
  ((SELECT id FROM inserted_question), 'Бронхопневмонії', false, 1),
  ((SELECT id FROM inserted_question), 'Туберкульозу', false, 2),
  ((SELECT id FROM inserted_question), 'Інтерстиціальної пневмонії', false, 3),
  ((SELECT id FROM inserted_question), 'Пневмофіброзу', false, 4);


-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині тіла жінки 52 років, яка померла внаслідок легеневої недостатності, у легенях виявлено такі зміни: обидві частки лівої легені збільшені, щільні, безповітряні. На розрізі в різних відділах визначаються жовтуватого кольору великі вогнища з тьмяною поверхнею, що злегка кришиться, на плеврі є сіруватого кольору плівчасті відкладення. Під час гістологічного дослідження спостерігається: просвіти альвеол заповнені серозно-фібринозним і фібринозним ексудатом із наявністю безструктурних ділянок в ексудаті та тканині легенів. Серед безструктурних ділянок визначаються уламки ядер. Для якого захворювання характерні такі зміни в легенях?', NULL, 'medium', 8, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозної пневмонії', true, 0),
  ((SELECT id FROM inserted_question), 'Пневмонієподібного раку легені', false, 1),
  ((SELECT id FROM inserted_question), 'Казеозної пневмонії', false, 2),
  ((SELECT id FROM inserted_question), 'Інфільтративно-пневмонічного туберкульозу', false, 3),
  ((SELECT id FROM inserted_question), 'Лімфогранулематозу легенів', false, 4);


-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На судово-медичній експертизі знаходиться тіло чоловіка 58-ми років, який тривалий час зловживав алкоголем. Помер вдома. Макроскопічно: права легеня щільна і збільшена в розмірах, тканина на розрізі сіруватого кольору, однорідна, плевра вкрита сіруватими плівчастими нашаруваннями. Мікроскопічно - порожнини альвеол містять нитки фібрину, гемолізовані еритроцити. Діагностуйте захворювання:', NULL, 'medium', 9, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вогнищева пневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Інтерстиційна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Первинний туберкульоз легень', false, 2),
  ((SELECT id FROM inserted_question), 'Казеозна пневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', true, 4);


-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому на крупозну пневмонію внутрішньом’язово ввели бензилпеніцилін-натрій. Через кілька хвилин у пацієнта розвинувся анафілактичний шок. Який лікарський засіб необхідно ввести хворому?', NULL, 'medium', 10, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Норадреналіну гідротартрат', false, 0),
  ((SELECT id FROM inserted_question), 'Кофеїн-бензоат натрію', false, 1),
  ((SELECT id FROM inserted_question), 'Ефедрин', false, 2),
  ((SELECT id FROM inserted_question), 'Мезатон', false, 3),
  ((SELECT id FROM inserted_question), 'Адреналіну гідрохлорид', true, 4);


-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на крупозну пневмонію має місце гарячка з температурою тіла 39°С, при цьому добові коливання температури не перевищували 1°С впродовж 9-ти діб. До якого типу температурних кривих відноситься ця гарячка?', NULL, 'medium', 11, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Поворотна', false, 0),
  ((SELECT id FROM inserted_question), 'Постійна', true, 1),
  ((SELECT id FROM inserted_question), 'Гіперпіретична', false, 2),
  ((SELECT id FROM inserted_question), 'Гектична', false, 3),
  ((SELECT id FROM inserted_question), 'Ремітуюча', false, 4);


-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 45 років переніс лівосторонню крупозну пневмонію. Загинув від множинних травм у результаті ДТП. Під час розтину тіла виявлено, що нижня частка лівої легені в ділянці задньо-бічної стінки зрощена з грудною стінкою фіброзними спайками. Об''єм частки зменшений, вона щільна, м''ясистого вигляду на розрізі, має сірувато-рожевий колір, її шматочки тонуть у воді. Під час гістологічного дослідження у цих ділянках спостерігається дифузне розростання волокнистої сполучної тканини. Для якого ускладнення крупозної пневмонії характерні такі результати дослідження?', NULL, 'medium', 12, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гангрена', false, 0),
  ((SELECT id FROM inserted_question), 'Абсцес', false, 1),
  ((SELECT id FROM inserted_question), 'Карніфікація', true, 2),
  ((SELECT id FROM inserted_question), 'Ателектаз', false, 3),
  ((SELECT id FROM inserted_question), 'Емфізема', false, 4);


-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла чоловіка, який помер від крупозної пневмонії, виявлено: у плевральній порожнині непрозора рідина, на вісцеральній плеврі плівка сіруватого кольору. Який вид запалення на вісцеральній плеврі?', NULL, 'medium', 13, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Геморагічне', false, 0),
  ((SELECT id FROM inserted_question), 'Катаральне', false, 1),
  ((SELECT id FROM inserted_question), 'Фібринозне', true, 2),
  ((SELECT id FROM inserted_question), 'Гнійне', false, 3),
  ((SELECT id FROM inserted_question), 'Гранулематозне', false, 4);


-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У харкотинні хворого з підозрою на пневмонію виявлено грампозитивні диплококи, подовжені, з дещо загостреними протилежними кінцями. Які мікроорганізми виявлені у харкотинні?', NULL, 'medium', 14, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Neisseria meningitidis', false, 0),
  ((SELECT id FROM inserted_question), 'Staphylococcus aureus', false, 1),
  ((SELECT id FROM inserted_question), 'Klebsiella pneumoniae', false, 2),
  ((SELECT id FROM inserted_question), 'Streptococcus pneumoniae', true, 3),
  ((SELECT id FROM inserted_question), 'Neisseria gonorrhoeae', false, 4);


-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини діагностовано атипову пневмонію, яка не піддається лікуванню beta-лактамними антибіотиками. Після посіву мокротиння дитини на спеціальне середовище, отримано ріст мікроорганізмів, які утворюють мікроскопічні колонії зі щільним центром. Який мікроорганізм є збудником пневмонії у дитини?', NULL, 'medium', 15, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Chlamidia pneumoniae', false, 0),
  ((SELECT id FROM inserted_question), 'Mycoplasma pneumoniae', true, 1),
  ((SELECT id FROM inserted_question), 'Streptococcus pneumoniae', false, 2),
  ((SELECT id FROM inserted_question), 'Klebsiella pneumoniae', false, 3),
  ((SELECT id FROM inserted_question), 'Legionella pneumophila', false, 4);


-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час фарбування мазка з харкотиння хворого з підозрою на крупозну пневмонію були використані наступні барвники і реактиви: розчин генціанвіолету, розчин Люголя, 96° спирт, водний фуксин. Який спосіб фарбування застосований у даному випадку?', NULL, 'medium', 16, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'За Цилем-Нільсеном', false, 0),
  ((SELECT id FROM inserted_question), 'За Лефлером', false, 1),
  ((SELECT id FROM inserted_question), 'За Нейсером', false, 2),
  ((SELECT id FROM inserted_question), 'За Романовським', false, 3),
  ((SELECT id FROM inserted_question), 'За Грамом', true, 4);


-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 36-ти років розвинулася гарячка, яка супроводжувалася зміщенням установчої точки терморегуляційного центру на більш високий рівень, з послідовним чергуванням наступних стадій: Incrementi, fastigii, decrementi. При якому захворюванні можуть спостерігатися подібні зміни?', NULL, 'medium', 17, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостра пневмонія', true, 0),
  ((SELECT id FROM inserted_question), 'Акромегалія', false, 1),
  ((SELECT id FROM inserted_question), 'Цукровий діабет', false, 2),
  ((SELECT id FROM inserted_question), 'Ренальний діабет', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпертрофія міокарда', false, 4);


-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину трупа чоловіка зі злоякісною пухлиною шлунка, що помер від ракової інтоксикації, у задньонижніх відділах легень виявлені щільні сіро-червоного кольору неправильної форми осередки, які виступають над поверхнею розрізу. Мікроскопічно: у просвіті, стінках дрібних бронхів та альвеолах виявляється ексудат, у якому багато нейтрофілів. Про яке захворювання свідчать зміни в легенях померлого?', NULL, 'medium', 18, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Гостра серозна бронхопневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Гостра гнійна бронхопневмонія', true, 2),
  ((SELECT id FROM inserted_question), 'Гострий бронхіт', false, 3),
  ((SELECT id FROM inserted_question), 'Проміжна пневмонія', false, 4);


-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини 5-ти років гостра правобічна нижньодольова пневмонія. При посіві харкотиння виявлено, що збудник захворювання стійкий до пеніциліну, але чутливий до макролідів. Який препарат найбільш доцільно використати в даному випадку?', NULL, 'medium', 19, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гентаміцин', false, 0),
  ((SELECT id FROM inserted_question), 'Стрептоміцин', false, 1),
  ((SELECT id FROM inserted_question), 'Азитроміцин', true, 2),
  ((SELECT id FROM inserted_question), 'Тетрациклін', false, 3),
  ((SELECT id FROM inserted_question), 'Ампіцилін', false, 4);


-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 42-х років помер при явищах вираженої інтоксикації і дихальної недостатності. На розтині: тканина легень у всіх відділах строката, з множинними дрібновогнищевими крововиливами та вогнищами емфіземи. Гістологічно у легенях: геморагічна бронхопневмонія з абсцедуванням, у цитоплазмі клітин епітелію бронхів еозинофільні і базофільні включення. Діагностуйте виявлене на секції захворювання:', NULL, 'medium', 20, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Плевропневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Стафілококова бронхопневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Часткова пневмонія', false, 2),
  ((SELECT id FROM inserted_question), 'Грип', true, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', false, 4);


-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині трупа хворого, який помер від легеневої недостатності, виявлено збільшене легке з вогнищами темно - червоного, білого, рожево - жовтого кольору, некротичний трахеобронхіт. Яким захворюванням найбільш ймовірно страждав хворий?', NULL, 'medium', 21, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Токсична форма грипу', false, 0),
  ((SELECT id FROM inserted_question), 'Корова пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Грипозна пневмонія', true, 2),
  ((SELECT id FROM inserted_question), 'Фіброзуючий альвеоліт', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', false, 4);


-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У п''ятирічної дитини з''явилися висока температура, дрібноточковий висип та кон''юнктивіт. Вона померла від пневмонії, що виникла як ускладнення основного захворювання. Під час гістологічного дослідження легень виявлено ендо-, мезо- та панбронхіт і гігантоклітинну пневмонію. Для якого захворювання характерні ці симптоматичні явища?', NULL, 'medium', 22, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозна пневмонія', false, 0),
  ((SELECT id FROM inserted_question), 'Вітряна віспа', false, 1),
  ((SELECT id FROM inserted_question), 'Дифтерія', false, 2),
  ((SELECT id FROM inserted_question), 'Скарлатина', false, 3),
  ((SELECT id FROM inserted_question), 'Кір', true, 4);


-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аутопсії померлого на шкірі дистальних відділів нижніх кінцівок виявлено багряно - червоні плями, бляшки і вузли (саркома Капоші). Виявлена також гостра пневмонія, викликана пневмоцистами. Для якого захворювання характерні дані зміни?', NULL, 'medium', 23, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дифтерія', false, 0),
  ((SELECT id FROM inserted_question), 'СНІД', true, 1),
  ((SELECT id FROM inserted_question), 'Грип', false, 2),
  ((SELECT id FROM inserted_question), 'Кір', false, 3),
  ((SELECT id FROM inserted_question), 'Сибірська виразка', false, 4);


-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 30-ти річного чоловіка, який хворів на гостре респіраторне захворювання та загинув при явищах гострої легенево-серцевої недостатності, під час розтину знайдено фібринозно-геморагічне запалення в слизовій оболонці гортані та трахеї, деструктивний панбронхіт, збільшені легені, яки мають пістрявий вигляд за рахунок абсцесів, крововиливів, некрозу. Який з перелічених діагнозів найбільш вірогідний?', NULL, 'medium', 24, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аденовірусна інфекція', false, 0),
  ((SELECT id FROM inserted_question), 'Парагрип', false, 1),
  ((SELECT id FROM inserted_question), 'Респіраторно-синцитіальна інфекція', false, 2),
  ((SELECT id FROM inserted_question), 'Грип', true, 3),
  ((SELECT id FROM inserted_question), 'Кір', false, 4);


-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 63-х років захворювання почалось гостро з явищ гострого трахеїту і бронхіту, до яких приєдналася бронхопневмонія. На 10-ту добу хворий помер від легенево-серцевої недостатності. На розтині виявлений фібринозно-геморагічний ларинготрахеобронхіт; легені збільшені в об’ємі, на розрізі мають ''пістрявий'' вигляд за рахунок чергування ділянок бронхопневмонії, крововиливів у легеневу паренхіму, гострих абсцесів і ателектазів. У внутрішніх органах - дисциркуляторні та дистрофічні зміни. Який діагноз найбільш вірогідний?', NULL, 'medium', 25, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Респіраторно-синцитіальна інфекція', false, 0),
  ((SELECT id FROM inserted_question), 'Грип середньої важкості', false, 1),
  ((SELECT id FROM inserted_question), 'Парагрип', false, 2),
  ((SELECT id FROM inserted_question), 'Грип, важка форма', true, 3),
  ((SELECT id FROM inserted_question), 'Аденовірусна інфекція', false, 4);


-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий помер від інтоксикації на 4-у добу після вживання сирих яєць. На розтині: слизова оболонка шлунка і тонкої кишки запалена, вкрита слизовим ексудатом; в легенях, головному мозку і печінці знайдені абсцеси. Який діагноз найбільш імовірний?', NULL, 'medium', 26, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сальмонельоз (септична форма)', true, 0),
  ((SELECT id FROM inserted_question), 'Черевний тиф', false, 1),
  ((SELECT id FROM inserted_question), 'Сальмонельоз (інтестинальна форма)', false, 2),
  ((SELECT id FROM inserted_question), 'Сальмонельоз (черевнотифозна форма)', false, 3),
  ((SELECT id FROM inserted_question), 'Дизентерія', false, 4);


-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 40-ка років перебував у пульмонологічному відділенні з приводу рецидивуючої правосторонньої пневмонії. Помер від легенево-серцевої недостатності. На розтині в правій легені визначається ділянка круглої форми 3х4 см. Вона являє собою порожнину з нерівними шорсткими краями, заповнену каламутною вершкоподібною жовто-зеленою рідиною. Мікроскопічно: стінка порожнини утворена тканиною легені з дифузною інфільтрацією лейкоцитами. Визначте патологічний процес у легені:', NULL, 'medium', 27, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий абсцес', true, 0),
  ((SELECT id FROM inserted_question), 'Гангрена', false, 1),
  ((SELECT id FROM inserted_question), 'Інфаркт', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний абсцес', false, 3),
  ((SELECT id FROM inserted_question), 'Емпієма', false, 4);


-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після позалікарняного аборту у жінки пргресував гнійний ендо-міометрит зі смертельним наслідком. При розтині померлої виявлені чисельні абсцеси легень, субкапсулярні гнійнички в нирках, гіперплазія селезінки. Яка форма сепсису виникла у хворої?', NULL, 'medium', 28, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хроніосепсис', false, 0),
  ((SELECT id FROM inserted_question), 'Уросепсис', false, 1),
  ((SELECT id FROM inserted_question), 'Септицемія', false, 2),
  ((SELECT id FROM inserted_question), 'Септикопіємія', true, 3),
  ((SELECT id FROM inserted_question), 'Легеневий сепсис', false, 4);


-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік віком 37 років скаржиться на підвищення температури тіла, задишку, біль у правій половині грудної клітки. Після проведення плевральної пункції отримано 650 мл в’язкої рідини зеленувато-жовтого кольору. Який патологічний процес виник у пацієнта?', NULL, 'medium', 29, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гематогенний туберкульоз', false, 0),
  ((SELECT id FROM inserted_question), 'Продуктивний пневмосклероз', false, 1),
  ((SELECT id FROM inserted_question), 'Емпієма плеври', true, 2),
  ((SELECT id FROM inserted_question), 'Серозний плеврит', false, 3),
  ((SELECT id FROM inserted_question), 'Туберкульозний плеврит', false, 4);


-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого висока температура, задуха, біль у правій частині грудної клітини. Плевральна пункція дала 700 мл в''язкої рідини жовто-зеленого кольору. Який патологічний процес розвився у плевральній порожнині?', NULL, 'medium', 30, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карциноматоз плеври', false, 0),
  ((SELECT id FROM inserted_question), 'Емпієма плеври', true, 1),
  ((SELECT id FROM inserted_question), 'Серозний плеврит', false, 2),
  ((SELECT id FROM inserted_question), 'Геморрагичний плеврит', false, 3),
  ((SELECT id FROM inserted_question), 'Бронхопневмонія', false, 4);


-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину трупа чоловіка, що страждав на крупозну пневмонію і помер від пневмококового сепсису, у правій плевральній порожнині містилося 900 мл каламутної зеленувато-жовтого кольору рідини. Листки плеври тьмяні, повнокровні. Назвіть клінікоморфологічну форму запалення в плевральній порожнині:', NULL, 'medium', 31, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий абсцес', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний абсцес', false, 1),
  ((SELECT id FROM inserted_question), 'Флегмона', false, 2),
  ((SELECT id FROM inserted_question), 'Фібринозне запалення', false, 3),
  ((SELECT id FROM inserted_question), 'Емпієма', true, 4);


-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині тіла померлого 49-ти років, який хворів на крупозну пневмонію і помер від пневмококового сепсису, в лівій плевральній порожнині містилось до 700 мл каламутної рідини зеленувато-жовтого кольору з неприємним запахом. Листки плеври тьмяні, повнокровні. Назвіть клініко-морфологічну форму запалення в плевральній порожнині:', NULL, 'medium', 32, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Флегмона', false, 0),
  ((SELECT id FROM inserted_question), 'Емпієма', true, 1),
  ((SELECT id FROM inserted_question), 'Гострий абсцес', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний абсцес', false, 3),
  ((SELECT id FROM inserted_question), 'Фі6ринознє запалення', false, 4);


-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 38 років поступив у терапевтичне відділення з діагнозом: правосторонній ексудативний плеврит. Відкачана з плевральної порожнини грудної клітки рідина прозора, має відносну щільність 1.020; містить 55 г\л, білка альбуміно-глобуліновий коефіцієнт-1.6; загальна кількість клітин-2.8. в 1 мкл; pH-6.5.Який тип ексудату має місце у хворого?', NULL, 'medium', 33, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фібринозний', false, 0),
  ((SELECT id FROM inserted_question), 'Геморагічний', false, 1),
  ((SELECT id FROM inserted_question), 'Гнійний', false, 2),
  ((SELECT id FROM inserted_question), 'Гнилісний', false, 3),
  ((SELECT id FROM inserted_question), 'Серозний', true, 4);


-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта віком 45 років шпиталізовано до лікарні зі скаргами на температуру, біль під час дихання, задуху та кашель. Після лабораторної та рентгенодіагностики вставлено діагноз: плеврит. Для евакуації ексудату призначено плевральну пункцію. В якому місці плевральної порожнини знаходиться найбільша кількість ексудату?', NULL, 'medium', 34, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реберно-діафрагмальний синус', true, 0),
  ((SELECT id FROM inserted_question), 'Під куполом плеври', false, 1),
  ((SELECT id FROM inserted_question), 'Діафрагмально-медіастинальний синус', false, 2),
  ((SELECT id FROM inserted_question), 'Реберно-медіастинальний синус', false, 3),
  ((SELECT id FROM inserted_question), 'Під коренем легенів', false, 4);


-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 44 років надійшла до терапевтичного відділення з діагнозом правобічний плеврит. Обстеження підтвердило наявність рідини в плевральній порожнині. У якому закутку плеври буде найбільше накопичення серозної рідини?', NULL, 'medium', 35, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Правому середостінно-діафрагмальному', false, 0),
  ((SELECT id FROM inserted_question), 'Правому реберно-середостінному', false, 1),
  ((SELECT id FROM inserted_question), 'Лівому реберно-середостінному', false, 2),
  ((SELECT id FROM inserted_question), 'Лівому середостінно-діафрагмальному', false, 3),
  ((SELECT id FROM inserted_question), 'Правому реберно-діафрагмальному', true, 4);


-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 45 років госпіталізований до лікарні зі скаргами на високу температуру, біль під час дихання, задишку та кашель. Після обстеження, лабораторної та рентгенодіагностики було встановлено діагноз - плеврит. Для евакуації ексудату була призначена плевральна пункція. В якому місці плевральної порожнини буде знаходитися найбільша кількість ексудату?', NULL, 'medium', 36, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Під коренем легенів', false, 0),
  ((SELECT id FROM inserted_question), 'Реберно-медіастинальний синус', false, 1),
  ((SELECT id FROM inserted_question), 'Діафрагмально-медіастинальний синус', false, 2),
  ((SELECT id FROM inserted_question), 'Під куполом плеври', false, 3),
  ((SELECT id FROM inserted_question), 'Реберно-діафрагмальний синус', true, 4);


-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого запалення легень ускладнилось ексудативним плевритом. В якому з перелічених анатомічних утворень переважно може накопичуватися рідина?', NULL, 'medium', 37, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Sinus transversus pericardii', false, 0),
  ((SELECT id FROM inserted_question), 'Sinus costodiaphragmaticus pleurae', true, 1),
  ((SELECT id FROM inserted_question), 'Sinus obliquus pericardii', false, 2),
  ((SELECT id FROM inserted_question), 'Sinus costomediastinalis pleurae', false, 3),
  ((SELECT id FROM inserted_question), 'Sinus phrenicomediastinalis pleurae', false, 4);


-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 47-ми років впродовж останніх 3-х років хворіє на туберкульоз легень, скаржиться на задишку, важкість в області правого боку грудної стінки, температуру тіла 37,7°С. Виявлено правобічний ексудативний плеврит. Який тип клітин передбачається у плевральному пунктаті?', NULL, 'medium', 38, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Лімфоцити', true, 0),
  ((SELECT id FROM inserted_question), 'Еозинофіли', false, 1),
  ((SELECT id FROM inserted_question), 'Нейтрофіли', false, 2),
  ((SELECT id FROM inserted_question), 'Еритроцити', false, 3),
  ((SELECT id FROM inserted_question), 'Атипові клітини', false, 4);


-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого сухим плевритом вислуховується шум тертя плеври. При ураженні якого виду епітелію відзначається цей симптом?', NULL, 'medium', 39, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Багатошаровий епітелій', false, 0),
  ((SELECT id FROM inserted_question), 'Одношаровий плоский епітелій', true, 1),
  ((SELECT id FROM inserted_question), 'Одношаровий призматичний епітелій', false, 2),
  ((SELECT id FROM inserted_question), 'Перехідний епітелій', false, 3),
  ((SELECT id FROM inserted_question), 'Одношаровий кубічний епітелій', false, 4);


-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту, який знаходився в клініці з приводу пневмонії, ускладненої плевритом, у складі комплексної терапії вводили преднізолон. Протизапальна дія цього синтетичного глюкокортикоїда пов’язана з блокуванням вивільнення арахідонової кислоти шляхом гальмування такого ферменту:', NULL, 'medium', 40, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циклооксигеназа', false, 0),
  ((SELECT id FROM inserted_question), 'Пероксидаза', false, 1),
  ((SELECT id FROM inserted_question), 'Ліпоксигеназа', false, 2),
  ((SELECT id FROM inserted_question), 'Фосфоліпаза А2', true, 3),
  ((SELECT id FROM inserted_question), 'Фосфоліпаза C', false, 4);


-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта, який півтора місяця тому назад переніс інфаркт міокарда, діагностований синдром Дреслера з характерною тріадою: перикардит, плеврит, пневмонія. Причиною його розвитку вважається:', NULL, 'medium', 41, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження резистентності до інфекційних агентів', false, 0),
  ((SELECT id FROM inserted_question), 'Інтоксикація організму продуктами некрозу', false, 1),
  ((SELECT id FROM inserted_question), 'Активація сапрофітної мікрофлори', false, 2),
  ((SELECT id FROM inserted_question), 'Викид в кров міокардіальних ферментів', false, 3),
  ((SELECT id FROM inserted_question), 'Сенсибілізація організму антигенами міокарда', true, 4);


-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий з виразковою хворобою шлунка приймав антацидний препарат альмагель. Для лікування гострого бронхіту йому призначили антибіотик метициклін. Проте протягом 5- ти днів температура не знизилася, кашель і характер харкотиння не змінились. Лікар прийшов до висновку про несумісність ліків при їх взаємодії. Про який саме вид несумісності ліків йдеться?', NULL, 'medium', 42, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Прямий антагонізм', false, 0),
  ((SELECT id FROM inserted_question), 'Фармакокінетична на етапі біотрансформації', false, 1),
  ((SELECT id FROM inserted_question), 'Фармацевтична', false, 2),
  ((SELECT id FROM inserted_question), 'Фармакокінетична на етапі всмоктування', true, 3),
  ((SELECT id FROM inserted_question), 'Фармакодинамічна', false, 4);


-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 67 років, який 17 років хворіє на хронічний бронхіт, під час дослідження біоптату бронха виявлено циліндричне розширення бронхів, слизові залози кістоподібно змінені, визначаються ділянки заміщення призматичного епітелію на багатошаровий плоский. Який патологічний процес виявлено у слизовій оболонці бронхів?', NULL, 'medium', 43, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метаплазію', true, 0),
  ((SELECT id FROM inserted_question), 'Гетеротопію', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпертрофію', false, 2),
  ((SELECT id FROM inserted_question), 'Дисплазію', false, 3),
  ((SELECT id FROM inserted_question), 'Гіперплазію', false, 4);


-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У гістологічному препараті тканини бронха пацієнта, який зловживає тютюнопалінням, у потовщеній слизовій оболонці виявлено хронічний обструктивний бронхіт із ознаками трансформації одношарового війчастого епітелію в багатошаровий плоский епітелій. Для якого патологічного процесу характерна така перебудова епітелію?', NULL, 'medium', 44, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперплазії', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпертрофії', false, 1),
  ((SELECT id FROM inserted_question), 'Метаплазії', true, 2),
  ((SELECT id FROM inserted_question), 'Гетероплазії', false, 3),
  ((SELECT id FROM inserted_question), 'Лейкоплакії', false, 4);


-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 67 років клінічний діагноз: хронічний бронхіт, пневмосклероз, серцево-легенева недостатність. З підозрілої ділянки слизової оболонки правого бронха взято біоптат. Гістологічно встановлено: клітинний і тканинний атипізм, поява структур, що мають вигляд "ракових перлин". Для якого захворювання характерні ці гістологічні зміни?', NULL, 'medium', 45, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний поліпозний бронхіт', false, 0),
  ((SELECT id FROM inserted_question), 'Гострий бронхіт', false, 1),
  ((SELECT id FROM inserted_question), 'Плоскоклітинна метаплазія слизової бронху', false, 2),
  ((SELECT id FROM inserted_question), 'Плоскоклітинний рак бронху з ороговінням', true, 3),
  ((SELECT id FROM inserted_question), 'Бронхоектаз', false, 4);


-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 67-ми років з клінічним діагнозом хронічного бронхіту, пневмосклерозу, серцево-легеневої недостатності взято біоптат з підозрілої ділянки слизової оболонки правого бронха. Гістологічно встановлено клітинний і тканинний атипізм, появу структур у вигляді ''ракових перлин’.’ Якому патологічному процесу відповідають зазначені гістологічні зміни?', NULL, 'medium', 46, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гострий бронхіт', false, 0),
  ((SELECT id FROM inserted_question), 'Плоскоклітинна метаплазія слизової бронху', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічний поліпозний бронхіт', false, 2),
  ((SELECT id FROM inserted_question), 'Бронхоектаз', false, 3),
  ((SELECT id FROM inserted_question), 'Плоскоклітинний рак бронху з ороговінням', true, 4);


-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 50-ти років хворіє на хронічний бронхіт, скаржиться на задишку під час фізичного навантаження, постійний кашель з відходженням харкотиння. При обстеженні діагностовано ускладнення - емфізема легень. Чим вона зумовлена?', NULL, 'medium', 47, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зменшення альвеолярної вентиляції', false, 0),
  ((SELECT id FROM inserted_question), 'Порушення вентиляційно-перфузійного співвідношення в легенях', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження еластичних властивостей легень', true, 2),
  ((SELECT id FROM inserted_question), 'Зменшення перфузії легень', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення розтяжності легень', false, 4);


-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт віком 58 років звернувся зі скаргами на задишку, яка виникає під час видиху, ціаноз слизових оболонок шкіри , бочкоподібність грудної клітки та зменшення нею дихальних рухів. В анамнезі: пацієнт курить протягом 40-ка років і працює на вуглевидобувному заводі. Під час обстеження виявлено такі показники вентиляції легень: ЖЄЛ знижений, Ф3Є та ЗЄЛ більше норми, ДО не змінений. Що с причиною патофізіологічних змін стану здоров’я пацієнта?', NULL, 'medium', 48, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бронхіт', false, 0),
  ((SELECT id FROM inserted_question), 'Емфізема легень', true, 1),
  ((SELECT id FROM inserted_question), 'Ателектаз легень', false, 2),
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', false, 3),
  ((SELECT id FROM inserted_question), 'Пневмоторакс', false, 4);


-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіка віком 48 років із ознаками двостороннього спонтанного пневмотораксу, помер. Під час розтину в обох легенях виявлено: субплевральні пухирі діаметром 1-3 см, заповнені повітрям. Легені за межами пухирів мають підвищену повітряність, тканина ріжеться з хрустом. Яка патологія легень спостерігається в пацієнта?', NULL, 'medium', 49, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стареча емфізема легень', false, 0),
  ((SELECT id FROM inserted_question), 'Ідіопатична емфізема легень', false, 1),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна емфізема легень', false, 2),
  ((SELECT id FROM inserted_question), 'Дифузна обструктивна емфізема легень', false, 3),
  ((SELECT id FROM inserted_question), 'Бульозна емфізема легень', true, 4);


-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 60 років помер від правошлуночкової недостатності. Під час розтину спостерігається: легені збільшені в об’ємі, у ділянці верхівок визначаються субплевральні міхури діаметром до 1 см. Гістологічно в паренхімі виявлено стоншення, а подекуди повне руйнування стінок альвеол. Спостерігаються також ознаки супутнього бронхіоліту. Який це вид легеневої патології?', NULL, 'medium', 50, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Емфізема легень', true, 0),
  ((SELECT id FROM inserted_question), 'Пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічний бронхіт', false, 2),
  ((SELECT id FROM inserted_question), 'Пневмосклероз', false, 3),
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', false, 4);


-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 63-x років, який протягом 15-ти років страждав на хронічну дифузну обструктивну емфізему легень, помер від прогресуючої серцевої недостатності. Під час розтину тіла виявлено: мускатний цироз печінки, ціанотична індурація нирок та селезінки, асцит, набряки нижніх кінцівок. Для якого типу серцевої недостатності характерні дані зміни у внутрішніх органах?', NULL, 'medium', 51, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостра правошлуночкова недостатність', false, 0),
  ((SELECT id FROM inserted_question), 'Гостра лівошлуночкова недостатність', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічна серцева недостатність', true, 2),
  ((SELECT id FROM inserted_question), 'Гостра загальна серцева недостатність', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічна недостатність передсердь', false, 4);


-- Question 52
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіка 45 років протягом останніх 3 років турбував сухий кашель, наростали задишка, легенева недостатність, швидка втрата ваги. На розтині встановлено легеневе серце. У легенях різко виражений фіброз із наявністю порожнин, що створюють картину ''''медових стільників''''. Гістологічно спостерігається інтерстиціальний фіброз з вираженою інфільтрацією строми лімфогістіоцитами з домішкою нейтрофілів. Установіть діагноз:', NULL, 'medium', 52, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічна бульозна емфізема', false, 0),
  ((SELECT id FROM inserted_question), 'Бронхоектатична хвороба', true, 1),
  ((SELECT id FROM inserted_question), 'Пиловий пневмосклероз', false, 2),
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', false, 3),
  ((SELECT id FROM inserted_question), 'Післязапальний пневмосклероз', false, 4);


-- Question 53
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині легенева тканина має комірчастий вигляд через мішковидні та циліндричні розширення бронхів. Мікроскопічно у стінці цих бронхів спостерігається лейкоцитарна інфільтрація із переважанням нейтрофілів. Еластичні мʼязові волокна та хрящові пластини частково зруйновані і заміщені сполучною тканиною. Прилегла легенева тканина має осередки запалення, поля фіброзу та склерозу судин і ознаки емфіземи. У серці спостерігається гіпертрофія правого шлуночка. Для якого захворювання характерні такі патологічні зміни?', NULL, 'medium', 53, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Пневмофіброз', false, 0),
  ((SELECT id FROM inserted_question), 'Інтерстиціальна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Емфізема легень', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічний бронхіт', false, 3),
  ((SELECT id FROM inserted_question), 'Бронхоектатична хвороба', true, 4);


-- Question 54
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час аутопсії померлого від легенево-серцевої недостатності виявлено органічні зміни всіх шарів бронхіальних стінок із циліндричним розширенням бронхів на рівні бронхів VI-X порядку. Гістологічно в розширених бронхах виявляється гнійний ексудат, вогнища поліпозу і плоскоклітинної метаплазії. Базальна мембрана гіалінізована, має гофрований вигляд. Виявляються дистрофія і руйнування хрящової пластинки бронха, атрофія і руйнування м''язового й еластичного шарів, склероз і дифузна гістіолімфоцитарна запальна інфільтрація. У прилеглій легеневій паренхімі спостерігаються поля фіброзу. Для якого захворювання характерні такі патологічні зміни?', NULL, 'medium', 54, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бронхоектатичної хвороби', true, 0),
  ((SELECT id FROM inserted_question), 'Гострого бронхіту', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічного поліпозного бронхіту', false, 2),
  ((SELECT id FROM inserted_question), 'Хронічної обструктивної емфіземи легень', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічного обструктивного бронхіту', false, 4);


-- Question 55
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла чоловіка, який помер із явищами легенево-серцевої недостатності, виявлено, що бронхи деформовані, із мішковидними вип''ячуваннями стінки та гнійним запаленням. У серці виявлено гіпертрофію правого шлуночка, у нирках - амілоїдоз. Із анамнезу відомо, що протягом 8 років пацієнт скаржився на кашель із гнійним мокротинням та задуху, а його пальці рук нагадували барабанні палички. Якому захворюванню характерні такі патологічні зміни?', NULL, 'medium', 55, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бронхоектатичній хворобі', true, 0),
  ((SELECT id FROM inserted_question), 'Абсцесу', false, 1),
  ((SELECT id FROM inserted_question), 'Хронічному бронхіту', false, 2),
  ((SELECT id FROM inserted_question), 'Гострому броніту', false, 3),
  ((SELECT id FROM inserted_question), 'Туберкульозу', false, 4);


-- Question 56
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При аутопсії тіла чоловіка середніх років, що тривало страждав на бронхоектатичну хворобу, виявлено, що обидва наднирника різко з6ільшені в об’ємі за рахунок кіркового шару. Наднирники щільні, бліді, сального вигляду. Мікроскопічно по ходу ретикулярної строми, у стінках судин - відкладання безструктурних, гомогенних, еозинофільних мас і конго-рот - позитивних мас. Який процес зумовив ці зміни?', NULL, 'medium', 56, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ліпідоз', false, 0),
  ((SELECT id FROM inserted_question), 'Гіаліноз', false, 1),
  ((SELECT id FROM inserted_question), 'Амілоїдоз', true, 2),
  ((SELECT id FROM inserted_question), 'Фібриноїдне набухання', false, 3),
  ((SELECT id FROM inserted_question), 'Мукоїдне набухання', false, 4);


-- Question 57
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Молодий чоловік 19-ти років страждав з раннього дитинства на бронхоектатичну хворобу, помер від ниркової недостатності. На розтині окрім множинних бронхоектатичних каверн, заповнених гнійним ексудатом, виявлено збільшені в розмірах нирки щільної консистенції, кірковий шар потовщений, білого кольору, щільний. Піраміди нирки анемічні, чіткі. Назвіть процес, який розвинувся в нирках:', NULL, 'medium', 57, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вторинний амілоїдоз', true, 0),
  ((SELECT id FROM inserted_question), 'Вроджений кістоз нирок', false, 1),
  ((SELECT id FROM inserted_question), 'Гломерулонефрит', false, 2),
  ((SELECT id FROM inserted_question), 'Вторинний нефросклероз', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічний пієлонефрит', false, 4);


-- Question 58
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині тіла померлого від ниркової недостатності, який протягом останніх 5-ти років хворів на бронхоектатичну хворобу, виявлені збільшені в розмірах нирки щільної консистенції з потовщеним кірковим шаром білого кольору та сальним блиском. Про яке захворювання нирок можна думати?', NULL, 'medium', 58, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гломерулонефрит', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний пієлонефрит', false, 1),
  ((SELECT id FROM inserted_question), 'Вторинний амілоїдоз', true, 2),
  ((SELECT id FROM inserted_question), '-', false, 3),
  ((SELECT id FROM inserted_question), 'Некротичний нефроз', false, 4);


-- Question 59
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 53-х років, що тривало страждав на бронхоектатичну хворобу та кровохаркання, з’явилися набряки на обличчі і в ділянці попереку; у сечі - білок 33 мг/л. Смерть настала від легеневої кровотечі. Результати аутопсії: нирки збільшені в об’ємі, ущільнені, поверхня розрізу має сальний вигляд. Гістологічно відзначено відкладення у клубочках і по ходу канальців гомогенних еозинофільних мас, які вибірково забарвлюються конгорот і дають метахромазію з метиловим фіолетовим. Який патологічний процес мав місце в нирках у даному випадку?', NULL, 'medium', 59, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фібриноїдне набухання', false, 0),
  ((SELECT id FROM inserted_question), 'Гіаліноз', false, 1),
  ((SELECT id FROM inserted_question), 'Амілоїдоз', true, 2),
  ((SELECT id FROM inserted_question), 'Жирова дистрофія', false, 3),
  ((SELECT id FROM inserted_question), 'Мукоїдне набухання', false, 4);


-- Question 60
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка, при житті страждав бронхоектатичної хворобою, пневмосклерозом з вираженими явищами кахексії, на розтині серце зменшене в розмірах, стінки стоншені, в''ялої консистенції, на розрізі тканина бурого кольору. Відкладення якого пігменту спостерігається в міокарді?', NULL, 'medium', 60, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гематоїдин', false, 0),
  ((SELECT id FROM inserted_question), 'Ліпофусцин', true, 1),
  ((SELECT id FROM inserted_question), 'Гемосидерин', false, 2),
  ((SELECT id FROM inserted_question), 'Цероїд', false, 3),
  ((SELECT id FROM inserted_question), 'Ліпохром', false, 4);


-- Question 61
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла чоловіка, який помер із явищами гострої дихальної недостатності, виявлено: повнокровні, різко збільшені розмірах легені ватяної консистенції. У просвітах бронхів виявляються слизові пробки. Гістологічно в них спостерігаються пласти клітин бронхіального епітелію (спіралі Куршмана), численні еозинофіли та кристалоподібні утворення з білків еозинофілів (кристали Шарко-Лейдена). Базальні мембрани бронхіального епітелію потовщені, стінки бронхів набряклі, інфільтровані запальними клітинами, залози й пучки гладких м’язів гіпертрофовані. Якому патологічному стану відповідає описана гістологічна картина?', NULL, 'medium', 61, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дифузна Обструктивна Емфізема легень', false, 0),
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', true, 1),
  ((SELECT id FROM inserted_question), 'Бронхоектази', false, 2),
  ((SELECT id FROM inserted_question), 'Ателектази легень', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічний бронхіт', false, 4);


-- Question 62
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 15 років надійшов до алергологічного відділення з діагнозом ''бронхіальна астма''. Надмірне утворення яких антитіл обумовлює розвиток основних клінічних симптомів?', NULL, 'medium', 62, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'ІgD', false, 0),
  ((SELECT id FROM inserted_question), 'ІgА', false, 1),
  ((SELECT id FROM inserted_question), '-', false, 2),
  ((SELECT id FROM inserted_question), 'ІgЕ', true, 3),
  ((SELECT id FROM inserted_question), 'IgM', false, 4);


-- Question 63
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з періодичними нападами ядухи, які виникають при вдиханні різних ароматичних речовин, діагностована атопічна бронхіальна астма. Визначено збільшення Ig Е. Для якого типу реакцій це характерно?', NULL, 'medium', 63, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Імунокомплексні', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперчутливості сповільненого типу', false, 1),
  ((SELECT id FROM inserted_question), 'Анафілактичні', true, 2),
  ((SELECT id FROM inserted_question), 'Цитотоксичні', false, 3),
  ((SELECT id FROM inserted_question), 'Автоімунні', false, 4);


-- Question 64
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої на бронхіальну астму вірусне інфікування спровокувало астматичний статус зі смертельним наслідком. При гістологічному дослідженні легень виявлено: спазм і набрякання бронхіол, в їх стінках виражена інфільтрація лімфоцитами, еозинофілами та іншими лейкоцитами, а також дегрануляція лаброцитів. Який механізм гіперчутливості лежить в основі зазначених змін?', NULL, 'medium', 64, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Аутоімунний', false, 0),
  ((SELECT id FROM inserted_question), 'Імунокомплексний', false, 1),
  ((SELECT id FROM inserted_question), 'Імунозумовлений клітинний цитоліз', false, 2),
  ((SELECT id FROM inserted_question), 'Реагінова реакція', true, 3),
  ((SELECT id FROM inserted_question), 'Запальний', false, 4);


-- Question 65
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт хворіє на бронхіальну астму протягом 15-ти років. Які зміни в лейкоцитарній формулі може знайти лікар у цього пацієнта?', NULL, 'medium', 65, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Еозинофілію', true, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенію', false, 1),
  ((SELECT id FROM inserted_question), 'Базофілію', false, 2),
  ((SELECT id FROM inserted_question), 'Зсув лейкоцитарної формули вліво', false, 3),
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', false, 4);


-- Question 66
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік віком 38 років упродовж 15 років хворіє на бронхіальну астму. Які зміни в лейкоцитарній формулі може знайти лікар у цього пацієнта?', NULL, 'medium', 66, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зсув лейкоцитарної формули вліво', false, 0),
  ((SELECT id FROM inserted_question), 'Лейкопенію', false, 1),
  ((SELECT id FROM inserted_question), 'Базофілію', false, 2),
  ((SELECT id FROM inserted_question), 'Лейкоцитоз', false, 3),
  ((SELECT id FROM inserted_question), 'Еозинофілію', true, 4);


-- Question 67
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта діагностовано бронхіальну астму. Які зміни показників вентиляції легень будуть спостерігатися в цьому разі?', NULL, 'medium', 67, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Збільшення життєвої ємності легень', false, 0),
  ((SELECT id FROM inserted_question), 'Зменшення залишкового обʼєму легень', false, 1),
  ((SELECT id FROM inserted_question), 'Збільшення резервуарного обʼєму видиху', false, 2),
  ((SELECT id FROM inserted_question), 'Зменшення обʼєму форсованого видиху', true, 3),
  ((SELECT id FROM inserted_question), 'Збільшення обʼєму форсованого видиху', false, 4);


-- Question 68
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У біоптаті слизової оболонки пацієнта, хворого на бронхіальну астму, виявлено значну кількість клітин з численними метахроматичними гранулами. Вкажіть цю клітину.', NULL, 'medium', 68, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тканинний базофіл', true, 0),
  ((SELECT id FROM inserted_question), 'Ретикулоцит', false, 1),
  ((SELECT id FROM inserted_question), 'Фібробласт', false, 2),
  ((SELECT id FROM inserted_question), 'Макрофаг', false, 3);


-- Question 69
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У підлітка 12-ти років, який хворіє на бронхіальну астму, виник тяжкий напад астми: виражена експіраторна задишка, блідість шкірних покривів. Який вид порушення альвеолярної вентиляції має місце?', NULL, 'medium', 69, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Центральний', false, 0),
  ((SELECT id FROM inserted_question), 'Обструктивний', true, 1),
  ((SELECT id FROM inserted_question), 'Нервово-м’язовий', false, 2),
  ((SELECT id FROM inserted_question), 'Торако-діафрагмальний', false, 3),
  ((SELECT id FROM inserted_question), 'Рестриктивний', false, 4);


-- Question 70
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка 38 років померла під час нападу бронхіальної астми, який не вдалося зняти. В ході гістологічного дослідження у просвіті бронхів виявлені накопичення слизу, в стінці бронхів численні лаброцити, багато з них у стані дегрануляції, а також велика кількість еозинофілів. Який патогенез (механізм розвитку) цих змін у бронхах?', NULL, 'medium', 70, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Клітинно обумовлений цитоліз', false, 0),
  ((SELECT id FROM inserted_question), 'Гранулематоз', false, 1),
  ((SELECT id FROM inserted_question), 'Цитотоксична, цитолітична дія антитіл', false, 2),
  ((SELECT id FROM inserted_question), 'Атопія', true, 3),
  ((SELECT id FROM inserted_question), 'Імунокомплексний механізм', false, 4);


-- Question 71
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки 45 років, яка тривалий час хворіє на бронхіальну астму, виник напад задухи. Який патогенетичний механізм має це явище?', NULL, 'medium', 71, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Порушення рухомості грудної клітки', false, 0),
  ((SELECT id FROM inserted_question), 'Втрата еластичності легеневої тканини', false, 1),
  ((SELECT id FROM inserted_question), 'Спазм дрібних бронхів', true, 2),
  ((SELECT id FROM inserted_question), 'Порушення перфузїї легеневої тканини', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження чутливості дихального центру', false, 4);


-- Question 72
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з бронхіальною астмою за допомогою шкірних алергічних проб установлено сенсибілізацію алергеном тополиного пуху. Який фактор імунної системи відіграє вирішальну роль у розвитку цього імунопатологічного стану?', NULL, 'medium', 72, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'IgD', false, 0),
  ((SELECT id FROM inserted_question), 'IgE', true, 1),
  ((SELECT id FROM inserted_question), 'IgG', false, 2),
  ((SELECT id FROM inserted_question), 'Сенсибілізовані Т-лімфоцити', false, 3),
  ((SELECT id FROM inserted_question), 'IgM', false, 4);


-- Question 73
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на бронхіальну астму виникла гостра недостатність дихання. Який тип недостатності дихання виникає в цьому разі?', NULL, 'medium', 73, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 0),
  ((SELECT id FROM inserted_question), 'Дисрегуляторне порушення альвеолярної вентиляції', false, 1),
  ((SELECT id FROM inserted_question), 'Дифузний', false, 2),
  ((SELECT id FROM inserted_question), 'Рестриктивне порушення альвеолярної вентиляції', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивне порушення альвеолярної вентиляції', true, 4);


-- Question 74
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У підлітка 12-ти років, який хворіє на бронхіальну астму, розвинувся тяжкий напад астми: виражена експіраторна задишка. блідість шкірних покровів. Який вид порушення альвеолярної вентиляції має місце?', NULL, 'medium', 74, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивннй', false, 0),
  ((SELECT id FROM inserted_question), 'Нервово-м’язовий', false, 1),
  ((SELECT id FROM inserted_question), 'Центральний', false, 2),
  ((SELECT id FROM inserted_question), 'Торако-діафрагмальний', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивний', true, 4);


-- Question 75
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У результаті патологічного процесу в бронхах відбувається десквамація епітелію. За рахунок яких клітин відбуватиметься регенерація бронхіального епітелію?', NULL, 'medium', 75, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вставочні', false, 0),
  ((SELECT id FROM inserted_question), 'Келихоподібні', false, 1),
  ((SELECT id FROM inserted_question), 'Ендокринні', false, 2),
  ((SELECT id FROM inserted_question), 'Базальні', true, 3),
  ((SELECT id FROM inserted_question), 'Війчасті', false, 4);


-- Question 76
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий багато років страждав на бронхіальну астму та помер від нападу ядухи. Під час гістологічного дослідження легень виявлено: в просвіті бронхіол та дрібних бронхів багато слизу з домішкою еозинофілів, склероз міжальвеолярних перетинок, розширення просвіту альвеол. Який механізм розвитку реакції гіперчутливості мав місце?', NULL, 'medium', 76, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Реагінова реакція', true, 0),
  ((SELECT id FROM inserted_question), 'Цитоліз, обумовлений лімфоцитами', false, 1),
  ((SELECT id FROM inserted_question), 'Гранулематоз', false, 2),
  ((SELECT id FROM inserted_question), 'Цитотоксична реакція', false, 3),
  ((SELECT id FROM inserted_question), 'Імунокомплексна реакція', false, 4);


-- Question 77
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з періодичними нападами ядухи, які виникають при вдиханні різних ароматичних речовин, діагностована атопічна бронхіальна астма. Визначено збільшення Ig Е. Для якого типу реакцій це характерно?', NULL, 'medium', 77, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Імунокомплексні', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперчутливості сповільненого типу', false, 1),
  ((SELECT id FROM inserted_question), 'Анафілактичні', true, 2),
  ((SELECT id FROM inserted_question), 'Цитотоксичні', false, 3),
  ((SELECT id FROM inserted_question), 'Автоімунні', false, 4);


-- Question 78
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час оформлення дитини до школи для вирішення питання про необхідність ревакцинації поставлена проба Манту, яка виявилася негативною. Про що свідчить даний результат проби?', NULL, 'medium', 78, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Про відсутність клітинного імунітету до туберкульозу', true, 0),
  ((SELECT id FROM inserted_question), 'Про наявність антитіл до туберкульозних бактерій', false, 1),
  ((SELECT id FROM inserted_question), 'Про відсутність антитіл до туберкульозних бактерій', false, 2),
  ((SELECT id FROM inserted_question), 'Про наявність клітинного імунітету до туберкульозу', false, 3),
  ((SELECT id FROM inserted_question), 'Про відсутність антитоксичного імунітету до туберкульозу', false, 4);


-- Question 79
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на рентгенограмі легень виявлено затемнення. В ході діагностичної експрес-біопсії лімфатичного вузла бронха виявлено казеозний некроз, навколо якого розташовані епітеліоїдні та лімфоїдні пласти з домішками багатоядерних гігантських клітин. Вкажіть причину лімфаденіту:', NULL, 'medium', 79, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Туберкульоз', true, 0),
  ((SELECT id FROM inserted_question), 'Сифіліс', false, 1),
  ((SELECT id FROM inserted_question), 'Аденовірусна інфекція', false, 2),
  ((SELECT id FROM inserted_question), 'Пневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Метастази раку', false, 4);


-- Question 80
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині померлого, який хворів на туберкульоз, у верхній частці правої легені знайдено порожнину розмірами 3х2 см, яка сполучається з бронхом. Стінка порожнини щільна, має три шари: внутрішній -піогенний, середній - шар туберкульозної грануляційної тканини, зовнішній - сполучнотканинний. Який діагноз найбільш імовірний?', NULL, 'medium', 80, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фіброзно-кавернозний туберкульоз', true, 0),
  ((SELECT id FROM inserted_question), 'Гострий кавернозний тубеокульоз', false, 1),
  ((SELECT id FROM inserted_question), 'Фіброзно-осередковий туберкульоз', false, 2),
  ((SELECT id FROM inserted_question), 'Туберкульома', false, 3),
  ((SELECT id FROM inserted_question), 'Гострий осередковий туберкульоз', false, 4);


-- Question 81
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий, що страждав на туберкульоз, помер від прогресуючої легенево-серцевої недостатності. На розтині в ділянці верхівки правої легені визначається порожнина діаметром 5 см, яка сполучається з просвітом сегментарного бронха. Стінки порожнини з середини покриті сирнистими масами, під якими знаходяться епітеліоїдні клітини й клітини Пирогова-Лангханса. Вкажіть морфологічну форму туберкульозу:', NULL, 'medium', 81, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інфільтративний туберкульоз', false, 0),
  ((SELECT id FROM inserted_question), 'Казеозна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий кавернозний туберкульоз', true, 2),
  ((SELECT id FROM inserted_question), 'Гострий осередковий туберкульоз', false, 3),
  ((SELECT id FROM inserted_question), 'Туберкульома', false, 4);


-- Question 82
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на рентгенограмі легень виявлено затемнення. Під час діагностичної експресбіопсії лімфатичного вузла бронха виявлено: сирний некроз, навколо якого розташовані епітеліоїдні та лімфоїдні пласти з домішками багатоядерних гігантських клітин. Вкажіть причину лімфаденіту:', NULL, 'medium', 82, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Туберкульоз', true, 0),
  ((SELECT id FROM inserted_question), 'Метастази раку', false, 1),
  ((SELECT id FROM inserted_question), 'Аденовірусна інфекція', false, 2),
  ((SELECT id FROM inserted_question), 'Сифіліс', false, 3),
  ((SELECT id FROM inserted_question), 'Пневмонія', false, 4);


-- Question 83
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розтині померлого, який хворів на туберкульоз, у верхній частці правої легені знайдено порожнину розмірами 3x2 см, яка сполучається з бронхом. Стінка порожнини щільна, має три шари: внутрішній -піогенний, середній - шар туберкульозної грануляційної тканини, зовнішній - сполучнотканинний. Який діагноз найбільш імовірний?', NULL, 'medium', 83, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Туберкульома', false, 0),
  ((SELECT id FROM inserted_question), 'Фіброзно-кавернозний туберкульоз', true, 1),
  ((SELECT id FROM inserted_question), 'Фіброзно-осередковий туберкульоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гострий осередковий туберкульоз', false, 3),
  ((SELECT id FROM inserted_question), 'Гострий кавернозний тубеокульоз', false, 4);


-- Question 84
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Для лікування захворювань, збудники яких виділяють екзотоксин, застосовують антитоксичні сироватки. Для лікування якого з перерахованих захворювань антитоксичну сироватку застосувати НЕМОЖЛИВО?', NULL, 'medium', 84, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Правець', false, 0),
  ((SELECT id FROM inserted_question), 'Туберкульоз', true, 1),
  ((SELECT id FROM inserted_question), 'Газова гангрена', false, 2),
  ((SELECT id FROM inserted_question), 'Ботулізм', false, 3),
  ((SELECT id FROM inserted_question), 'Дифтерія', false, 4);


-- Question 85
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла дівчики 9 років у верхівці правої легені субплеврально було знайдене вогнище казеозного некрозу діаметром 15 мм, біфуркаційні лімфатичні вузли були збільшені містили дрібні вогнища некрозу коагуляційного типу. Мікроскопічно - у легеневому вогнищі та в лімфатичних вузлах навколо некротичних мас були розташовані епітеліоїдні клітини, лімфоцити та поодинокі багатоядерні гігантські клітини. Діагностуйте захворювання.', NULL, 'medium', 85, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Первинний туберкульоз', true, 0),
  ((SELECT id FROM inserted_question), 'Гематогенний туберкульоз з переважним ураженням легень', false, 1),
  ((SELECT id FROM inserted_question), 'Гематогенний генералізований туберкульоз', false, 2),
  ((SELECT id FROM inserted_question), 'Вторинний вогнищевий туберкульоз', false, 3),
  ((SELECT id FROM inserted_question), 'Вторинний фіброзно-вогнищевий туберкульоз', false, 4);


-- Question 86
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий, що страждав на туберкульоз, помер від прогресуючої легенево-серцевої недостатності. На розтині в ділянці верхівки правої легені визначається порожнина діаметром 5 см, яка сполучається з просвітом сегментарного бронха. Стінки порожнини з середини покриті сирнистими масами, під якими знаходяться епітеліоїдні клітини й клітини Пирогова-Лангханса. Вкажіть морфологічну форму туберкульозу:', NULL, 'medium', 86, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Туберкульома', false, 0),
  ((SELECT id FROM inserted_question), 'Казеозна пневмонія', false, 1),
  ((SELECT id FROM inserted_question), 'Гострий осередковий туберкульоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гострий кавернозний туберкульоз', true, 3),
  ((SELECT id FROM inserted_question), 'Інфільтративний туберкульоз', false, 4);


-- Question 87
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік віком 65 років зі встановленим діагнозом: фіброзно-кавернозний туберкульоз легень помер від хронічної легенево-серцевої недостатності. Протягом останніх місяців спостерігалася виражена протеїнурія. На розтині нирки збільшені, щільні, восковидні на поверхні і всередині. Які зміни в нирках при цій формі туберкульозу могли викликати протеїнурію?', NULL, 'medium', 87, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Нефролітіаз', false, 0),
  ((SELECT id FROM inserted_question), 'Гломерулонефрит', false, 1),
  ((SELECT id FROM inserted_question), 'Туберкульоз нирок', false, 2),
  ((SELECT id FROM inserted_question), 'Некротичний нефроз', false, 3),
  ((SELECT id FROM inserted_question), 'Амілоїдоз нирок', true, 4);


-- Question 88
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час аутопсії тіла померлого чоловіка віком 48 років у ділянці 1-го сегмента правої легені виявлено кругле утворення діаметром 5 см із чіткими контурами, оточене тонким прошарком сполучної тканини, заповнене білими крихкими масами. Для якої форми вторинного туберкульозу характерні такі ознаки?', NULL, 'medium', 88, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Фіброзно-кавернозний туберкульоз', false, 0),
  ((SELECT id FROM inserted_question), 'Туберкульома', true, 1),
  ((SELECT id FROM inserted_question), 'Гострий вогнищевий туберкульоз', false, 2),
  ((SELECT id FROM inserted_question), 'Гострий кавернозний туберкульоз', false, 3),
  ((SELECT id FROM inserted_question), 'Казеозна пневмонія', false, 4);


-- Question 89
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 43 роки, який тривалий час хворів на туберкульоз, розвинулася кровотеча з легень, що призвела до смерті. Під час аутопсії в легенях виявлено декілька порожнин овальної і круглої форм, стінка яких створена некротичними масами та тканиною легень. Для якої форми туберкульозу характерні такі паталогічні зміни?', NULL, 'medium', 89, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Казеозної пневмонії', false, 0),
  ((SELECT id FROM inserted_question), 'Гострої кавернозної', true, 1),
  ((SELECT id FROM inserted_question), 'Фіброзно-кавернозної', false, 2),
  ((SELECT id FROM inserted_question), 'Гострої вогнищевої', false, 3),
  ((SELECT id FROM inserted_question), 'Туберкуломи', false, 4);


-- Question 90
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У бактеріологічну лабораторію надійшло мокротиння пацієнта, який хворіє на туберкульоз. Який з методів фарбувания необхідно використати для бактеріоскопічного дослідження препаратів-мазків і виявлення туберкульозної палички?', NULL, 'medium', 90, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Здрадовського', false, 0),
  ((SELECT id FROM inserted_question), 'Буррі-Гінса', false, 1),
  ((SELECT id FROM inserted_question), 'Романовського-Гімзи', false, 2),
  ((SELECT id FROM inserted_question), 'Грама', false, 3),
  ((SELECT id FROM inserted_question), 'Ціля-Нільсена', true, 4);


-- Question 91
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час аутопсії чоловіка віком 60 років, який тривалий час хворів на фіброзно-кавернозний туберкульоз легень, виявлено збільшені у розмірах нирки масою по 180 гр кожна. Тканина нирок щільна, біло-сіра, з «сальним» блиском. Під час гістологічного дослідження у клубочках нирки та у стінці окремих артерій малого калібру виявлено гомогенні оксифільні маси, які під час забарвлення за конго-червоним зафарбувались у червоно-оранжевий колір. Які морфологічні зміни спостерігаються у нирках?', NULL, 'medium', 91, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Вторинний амілоїдоз', true, 0),
  ((SELECT id FROM inserted_question), 'Старечий амілоїдоз', false, 1),
  ((SELECT id FROM inserted_question), 'Ідіопатичний амілоїдоз', false, 2),
  ((SELECT id FROM inserted_question), 'Локальний пухлиноподібний амілоїдоз', false, 3),
  ((SELECT id FROM inserted_question), 'Дифузний гіаліноз', false, 4);


-- Question 92
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При підозрі на туберкульоз хворій дитині зробили пробу Манту Через 24 години у місці введення алергену з’явились припухлість, гіперемія і болісність. Які основні компоненти визначають цю реакцію організму?', NULL, 'medium', 92, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гранулоцити, Т-лімфоцити і IgG', false, 0),
  ((SELECT id FROM inserted_question), 'Плазматичні клітини, Т-лімфоцити і лімфокіни', false, 1),
  ((SELECT id FROM inserted_question), 'В-лімфоцити, IgM', false, 2),
  ((SELECT id FROM inserted_question), 'Макрофаги, В-лімфоцити і моноцити', false, 3),
  ((SELECT id FROM inserted_question), 'Мононуклеари, Т-лімфоцити і лімфокіни', true, 4);


-- Question 93
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Жінка протягом 8 років хворіла на туберкульоз, померла в стаціонарі при ознаках хронічної ниркової недостатності. На розтині – нирки збільшені, поверхня розрізу має сальний вигляд; гістологічно виявлено масивні відкладання безструктурних гомогенних еозинофільних мас, при забарвленні Конго-рот спостерігається їх виражена метахромазія. Який патологічний процес розвинувся у нирках?', NULL, 'medium', 93, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Токсичний нефрит на фоні антибіотикотерапії', false, 0),
  ((SELECT id FROM inserted_question), 'Нефросклероз', false, 1),
  ((SELECT id FROM inserted_question), 'Вторинний амілоїдоз', true, 2),
  ((SELECT id FROM inserted_question), 'Гострий гломерулонефрит', false, 3),
  ((SELECT id FROM inserted_question), 'Гематогенний туберкульоз нирок', false, 4);


-- Question 94
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У 35-річного наркомана, який тривало хворів на фіброзно-кавернозний туберкульоз легень, під час патологоана- томічного дослідження встановлено, що нирки та селезінка збільшені в розмірах, щільної консистенції, на розрізі тканина із сірим відтінком та ''сальним” блиском. Мікроскопічно вичвлено в білій та червоній пульпі селезінки, у інтерстиції та мезангіумі клубочків нирок депозити Конго-рот-позитивних мас. Діагностуйте вид ураження внутрішніх органів:', NULL, 'medium', 94, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Старечий амілоїдоз', false, 0),
  ((SELECT id FROM inserted_question), 'Ідіопатичний амілоїдоз', false, 1),
  ((SELECT id FROM inserted_question), 'Дифузний гіаліноз', false, 2),
  ((SELECT id FROM inserted_question), 'Вторинний амілоїдоз', true, 3),
  ((SELECT id FROM inserted_question), 'Локальний пухлиноподібний амілоїдоз', false, 4);


-- Question 95
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині тіла чоловіка, який хворів на фіброзно-кавернозний туберкульоз і помер від ниркової недостатності, виявлені збільшені в розмірах нирки, щільні на дотик, сіруватого кольору, на розрізі мають сальний вигляд. Який діагноз можна припустити?', NULL, 'medium', 95, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Амілоїдоз нирок', true, 0),
  ((SELECT id FROM inserted_question), 'Нефросклероз', false, 1),
  ((SELECT id FROM inserted_question), 'Мієломна нирка', false, 2),
  ((SELECT id FROM inserted_question), 'Гломерулонефрит', false, 3),
  ((SELECT id FROM inserted_question), 'Хронічний пієлоневрит', false, 4);


-- Question 96
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 34-х років страждає на туберкульоз легень з дитинства. Йому призначена операція. Під час операції у хворого була видалена середня доля правої легені. Які сегменти були видалені?', NULL, 'medium', 96, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Задній і передній', false, 0),
  ((SELECT id FROM inserted_question), 'Верхній язичковий і нижній язичковий', false, 1),
  ((SELECT id FROM inserted_question), 'Верхній і передній', false, 2),
  ((SELECT id FROM inserted_question), 'Медіальний базальний і латеральний базальний', false, 3),
  ((SELECT id FROM inserted_question), 'Латеральний і медіальний', true, 4);


-- Question 97
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При відборі для ревакцинації вакциною БЦЖ у школяра поставлено пробу Манту, яка виявилася негативною. Результат проби свідчить про такі особливості імунітету до туберкульозу:', NULL, 'medium', 97, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Відсутність гуморального імунітету', false, 0),
  ((SELECT id FROM inserted_question), 'Відсутність клітинного імунітету', true, 1),
  ((SELECT id FROM inserted_question), 'Наявність клітинного імунітету', false, 2),
  ((SELECT id FROM inserted_question), 'Наявність гуморального імунітету', false, 3),
  ((SELECT id FROM inserted_question), 'Відсутність антитоксичного імунітету', false, 4);


-- Question 98
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До клініки госпіталізована пацієнтка із скаргами на кровохаркання, пітливість. Рентгенологічно виявлено вогнище туберкульозу у верхній частці правої легені. Показана операція. Яку кількість сегментів можна видалити в складі верхньої частки правої легені?', NULL, 'medium', 98, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), '1', false, 0),
  ((SELECT id FROM inserted_question), '5', false, 1),
  ((SELECT id FROM inserted_question), '2', false, 2),
  ((SELECT id FROM inserted_question), '4', false, 3),
  ((SELECT id FROM inserted_question), '3', true, 4);


-- Question 99
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого із вираженим пневмосклерозом після перенесеного інфільтративного туберкульозу легень розвинулась дихальна недостатність. До якого патогенетичного типу вона відноситься?', NULL, 'medium', 99, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дисрегуляційний', false, 0),
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 1),
  ((SELECT id FROM inserted_question), 'Рестриктивний', true, 2),
  ((SELECT id FROM inserted_question), 'Рефлекторний', false, 3),
  ((SELECT id FROM inserted_question), 'Апнеїстичний', false, 4);


-- Question 100
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У баклабораторії під час мікроскопії мазків з харкотиння хворого на хронічне легеневе захворювання, забарвлених за Цілем-Нільсеном, виявлені червоні палички. Яка властивість туберкульозної палички виявлена при цьому?', NULL, 'medium', 100, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Спиртостійкість', false, 0),
  ((SELECT id FROM inserted_question), 'Кислотостійкість', true, 1),
  ((SELECT id FROM inserted_question), 'Капсулоутворення', false, 2),
  ((SELECT id FROM inserted_question), 'Спороутворення', false, 3),
  ((SELECT id FROM inserted_question), 'Лугостійкість', false, 4);


-- Question 101
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Значну роль у профілактиці туберкульозу відіграє планова масова вакцинація проти туберкульозу новонароджених дітей віком 5-7 днів життя. При цьому застосовують вакцину:', NULL, 'medium', 101, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'БЦЖ', true, 0),
  ((SELECT id FROM inserted_question), 'АДП', false, 1),
  ((SELECT id FROM inserted_question), 'АД', false, 2),
  ((SELECT id FROM inserted_question), 'АКП', false, 3),
  ((SELECT id FROM inserted_question), 'АКДП', false, 4);


-- Question 102
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В першому класі було проведене медичне обстеження учнів з метою відбору дітей для ревакцинації проти туберкульозу. Яку з наведених нижче проб при цьому використали?', NULL, 'medium', 102, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Проба Бюрне', false, 0),
  ((SELECT id FROM inserted_question), 'Проба Манту', true, 1),
  ((SELECT id FROM inserted_question), 'Нашкірна проба з тулярином', false, 2),
  ((SELECT id FROM inserted_question), 'Проба з антраксином', false, 3),
  ((SELECT id FROM inserted_question), 'Проба Шика', false, 4);


-- Question 103
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До навчального закладу вступив юнак 16-ти років з сільської місцевості. При плановому проведенні реакції Манту виявилося, що у цього юнака вона негативна. Яка найбільш раціональна тактика лікаря?', NULL, 'medium', 103, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Терміново ізолювати юнака з навчального колективу', false, 0),
  ((SELECT id FROM inserted_question), 'Повторити реакцію через 1 місяць', false, 1),
  ((SELECT id FROM inserted_question), 'Провести серодіагностику туберкульозу', false, 2),
  ((SELECT id FROM inserted_question), 'Провести прискорену діагностику туберкульозу методом Прайса', false, 3),
  ((SELECT id FROM inserted_question), 'Зробити щеплення БЦЖ', true, 4);


-- Question 104
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На практичному занятті з мікробіології студентам запропоновано пофарбувати готові зафіксовані мазки із мокротиння хворого на туберкульоз. Який метод фарбування треба використати у данному випадку?', NULL, 'medium', 104, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циля-Нільсена', true, 0),
  ((SELECT id FROM inserted_question), 'Грама', false, 1),
  ((SELECT id FROM inserted_question), 'Буррі', false, 2),
  ((SELECT id FROM inserted_question), 'Романовського-Гімза', false, 3),
  ((SELECT id FROM inserted_question), 'Гінса', false, 4);


-- Question 105
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла чоловіка 56 років, який страждав на фіброзно-кавернозний туберкульоз легень, знайдено збільшену у розмірах щільну селезінку. На розрізі тканина її коричнево-рожевого кольору, гладенька, з віскоподібною поверхнею. Який з перелічених патологічних процесів у селезінці найбільш вірогідний?', NULL, 'medium', 105, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Цианотична індурація', false, 0),
  ((SELECT id FROM inserted_question), 'Порфірна селезінка', false, 1),
  ((SELECT id FROM inserted_question), 'Сагова селезінка', false, 2),
  ((SELECT id FROM inserted_question), 'Глазурна селезінка', false, 3),
  ((SELECT id FROM inserted_question), 'Сальна селезінка', true, 4);


-- Question 106
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворому на туберкульоз, в анамнезі якого була відкрита легенева форма захворювання, проведено мікроскопічне дослідження мокротиння з метою визначення збудника. Який метод фарбування доцільно при цьому використовувати?', NULL, 'medium', 106, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Метод Романовського - Гімзи', false, 0),
  ((SELECT id FROM inserted_question), 'Метод Буррі - Гінса', false, 1),
  ((SELECT id FROM inserted_question), 'Метод Ціля – Нільсена', true, 2),
  ((SELECT id FROM inserted_question), 'Метод Грама', false, 3),
  ((SELECT id FROM inserted_question), 'Метод Нейсера', false, 4);


-- Question 107
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При забарвленні бакпрепаратів, виготовлених з харкотиння, методом Ціля-Нільсена виявлено наявність яскраво-червоних паличок, які розміщувалися поодиноко або групами, не чутливі до дії кислот. На живильних середовищах перші ознаки росту з’являються на 10-15-ту добу. До якої родини відносяться виявлені бактерії?', NULL, 'medium', 107, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Klebsiella rhinoscleromatis', false, 0),
  ((SELECT id FROM inserted_question), 'Yersinia pseudotuberculosis', false, 1),
  ((SELECT id FROM inserted_question), 'Histoplasma dubrosii', false, 2),
  ((SELECT id FROM inserted_question), 'Coxiella burnettii', false, 3),
  ((SELECT id FROM inserted_question), 'Mycobacterium tuberculosis', true, 4);


-- Question 108
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чотирирічна дитина померла від легенево-серцевої недостатності. Під час аутопсії виявлено ущільнення підшлункової залози, у бронхах обтураційні ателектази та бронхоектази, у печінці - жирова інфільтрація. Мікроскопічно в підшлунковій залозі спостерігається: кістозно розширені протоки, атрофія залозистої паренхіми, дифузний фіброз та лімфо-гістіоцитарна інфільтрація. Для якого захворювання характерні такі результати аутопсії?', NULL, 'medium', 108, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ембріонатія', false, 0),
  ((SELECT id FROM inserted_question), 'Хвороба Гіршпрунга', false, 1),
  ((SELECT id FROM inserted_question), 'Фетальний муковісцидоз', true, 2),
  ((SELECT id FROM inserted_question), 'Рамстопатія', false, 3),
  ((SELECT id FROM inserted_question), 'Інфекційна фетопатія', false, 4);


-- Question 109
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого виявлено різке зниження активності сурфактанту легень. Які зміни слід очікувати у цього хворого?', NULL, 'medium', 109, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зміна еластичних властивостей легенів', false, 0),
  ((SELECT id FROM inserted_question), 'Розростання сполучної тканини легенів', false, 1),
  ((SELECT id FROM inserted_question), 'Схильність альвеол до спадання і неможливість їх швидкого розправлення', true, 2),
  ((SELECT id FROM inserted_question), 'Порушення кровообігу в легенях', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшення трахеобронхіального секрету', false, 4);


-- Question 110
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При мікроскопічному дослідженні легені недоношеної дитини виявлено спадання стінок альвеол через відсутність сурфактанту. Вкажіть, з порушенням розвитку яких клітин стінки альвеоли це пов’язано:', NULL, 'medium', 110, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Альвеолярних макрофагів', false, 0),
  ((SELECT id FROM inserted_question), 'Альвеолоцитів І типу', false, 1),
  ((SELECT id FROM inserted_question), 'Фібробластів', false, 2),
  ((SELECT id FROM inserted_question), 'Альвеолоцитів II типу', true, 3),
  ((SELECT id FROM inserted_question), 'Секреторних клітин', false, 4);


-- Question 111
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У працівників хімічних комбінатів, де виробляють органічні розчинники, які здатні розчиняти фосфоліпіди, часто розвиваються захворювання легень. Який компонент аерогематичного бар’єру при цьому пошкоджується в першу чергу?', NULL, 'medium', 111, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Септальні клітини', false, 0),
  ((SELECT id FROM inserted_question), 'Сурфактант', true, 1),
  ((SELECT id FROM inserted_question), 'Альвеолярні макрофаги', false, 2),
  ((SELECT id FROM inserted_question), 'Респіраторні альвеолоцити', false, 3),
  ((SELECT id FROM inserted_question), 'Секреторні альвеолоцити', false, 4);


-- Question 112
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На електронній мікрофотографії представлені структури у вигляді відкритих міхурців, внутрішня поверхня яких вистелена одношаровим епітелієм, який утворений респіраторними та секреторними клітинами. Які це структури?', NULL, 'medium', 112, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Термінальні бронхіоли', false, 0),
  ((SELECT id FROM inserted_question), 'Ацинуси', false, 1),
  ((SELECT id FROM inserted_question), 'Альвеоли', true, 2),
  ((SELECT id FROM inserted_question), 'Альвеолярні ходи', false, 3),
  ((SELECT id FROM inserted_question), 'Бронхіоли', false, 4);


-- Question 113
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину в верхній долі правої легені виявлений крупний клиноподібний осередок темно-червоної, щільної тканини. При гістологічному дослідженні в ній виявлений некроз стінок альвеол, просвіт альвеол щільно заповнений еритроцитами. Який процес розвинувся в легенях?', NULL, 'medium', 113, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гангрена легенів', false, 0),
  ((SELECT id FROM inserted_question), 'Геморагічний інфаркт легень', true, 1),
  ((SELECT id FROM inserted_question), 'Крововилив в легені', false, 2),
  ((SELECT id FROM inserted_question), 'Карніфікація легких', false, 3),
  ((SELECT id FROM inserted_question), 'Ателектаз легенів', false, 4);


-- Question 114
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину в верхній частці правого легкого виявлений великий клиноподібний осередок темно - червоною щільною тканини. Під час гістологічного дослідження в ній виявлений некроз стінок альвеол, просвіт альвеол щільно заповнений еритроцитами. Який процес розвинувся в легенях?', NULL, 'medium', 114, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Карніфікація легких', false, 0),
  ((SELECT id FROM inserted_question), 'Гангрена легенів', false, 1),
  ((SELECT id FROM inserted_question), 'Геморагічний інфаркт легень', true, 2),
  ((SELECT id FROM inserted_question), 'Крововилив в легені', false, 3),
  ((SELECT id FROM inserted_question), 'Ателектаз легенів', false, 4);


-- Question 115
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий помер від наростаючої легенево-серцевої недостатності. При гістологічному дослідженні виявлено дифузне ураження легенів з інтерстиціальним набряком та інфільтрацією інтерстиціальної тканини лімфоцитами, макрофагами, плазмоцитами; наявні пневмофіброз та панацинарна емфізема. Поставте діагноз:', NULL, 'medium', 115, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', false, 0),
  ((SELECT id FROM inserted_question), 'Хронічний бронхіт', false, 1),
  ((SELECT id FROM inserted_question), 'Бронхопневмонія', false, 2),
  ((SELECT id FROM inserted_question), 'Ателектаз легенів', false, 3),
  ((SELECT id FROM inserted_question), 'Фіброзивний альвеоліт', true, 4);


-- Question 116
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий помер від наростаючої легенево-серцевої недостатності. При гістологічному дослідженні виявлено: дифузне ураження легенів з інтерстиціальним набряком, інфільтрацією інтерстиціальної тканини лімфоцитами, макрофагами, плазмоцидами; пневмофіброз, панацинарна емфізема. Який найбільш вірогідний діагноз?', NULL, 'medium', 116, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічний бронхіт', false, 0),
  ((SELECT id FROM inserted_question), 'Бронхіальна астма', false, 1),
  ((SELECT id FROM inserted_question), 'Ателектаз легенів', false, 2),
  ((SELECT id FROM inserted_question), 'Бронхопневмонія', false, 3),
  ((SELECT id FROM inserted_question), 'Фіброзуючий альвеоліт', true, 4);


-- Question 117
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнт помер від наростаючої легенево-серцевої недостатності. Під час гістологічного дослідження виявлено дифузне ураження легенів із інтерстиціальним набряком, інфільтрацією інтерстиціальної тканини лімфоцитами, макрофагами, плазмоцитами, пневмофіброз, панацинарна емфізема. Якому захворюванню відповідають такі патологічні зміни?', NULL, 'medium', 117, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Бронхопневмонії', false, 0),
  ((SELECT id FROM inserted_question), 'Бронхіальній астмі', false, 1),
  ((SELECT id FROM inserted_question), 'Ателектазу легенів', false, 2),
  ((SELECT id FROM inserted_question), 'Фіброзуючому альвеоліту', true, 3),
  ((SELECT id FROM inserted_question), 'Хронічному бронхіту', false, 4);


-- Question 118
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту, у якого діагностована гостра дихальна недостатність, проведено штучну вентиляцію легень при високому парціальному тиску кисню, внаслідок чого стан пацієнта погіршився з розвитком респіраторного дистрес-синдрому. Вкажіть можливу причину цього ускладнення.', NULL, 'medium', 118, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інтенсивне окислення сурфактанту легень', true, 0),
  ((SELECT id FROM inserted_question), 'Фіброз', false, 1),
  ((SELECT id FROM inserted_question), 'Ателектаз', false, 2),
  ((SELECT id FROM inserted_question), 'Застій крові в легенях', false, 3),
  ((SELECT id FROM inserted_question), 'Запальний процес', false, 4);


-- Question 119
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 50-ти років страждає на гіпертонічну хворобу. Під час фізичного навантаження у нього з’явилися відчуття м’язової слабкості, нестачі повітря, синюшність губ, шкіри, обличчя, дихання супроводжувалося відчутними на відстані вологими хрипами. Який механізм лежить в основі виникнення такого синдрому?', NULL, 'medium', 119, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Хронічна правошлуночкова недостатність', false, 0),
  ((SELECT id FROM inserted_question), 'Гостра лівошлуночкова недостатність', true, 1),
  ((SELECT id FROM inserted_question), 'Хронічна лівошлуночкова недостатність', false, 2),
  ((SELECT id FROM inserted_question), 'Тампонада серця', false, 3),
  ((SELECT id FROM inserted_question), 'Колапс', false, 4);


-- Question 120
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіка віком 59 років шпиталізували у тяжкому стані з діагнозом: гострий інфаркт міокарда в ділянці задньої стінки лівого шлуночка та перегородки, початковий набряк легень. Який механізм є первинним у виникненні набряку легень у пацієнта?', NULL, 'medium', 120, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Легенева венозна гіпертензія', false, 0),
  ((SELECT id FROM inserted_question), 'Легенева артеріальна гіпертензія', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження альвеоло-капілярної дифузії кисню', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксемія', false, 3),
  ((SELECT id FROM inserted_question), 'Лівошлуночкова недостатність', true, 4);


-- Question 121
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла померлого чоловіка віком 43 роки було виявлено набряк легень. З анамнезу відомо, що пацієнт хворів на ІХС із розвитком інфаркту міокарда. Яка ймовірна причина набряку легень?', NULL, 'medium', 121, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гостре загальне малокрів''я', false, 0),
  ((SELECT id FROM inserted_question), 'Стаз крові', false, 1),
  ((SELECT id FROM inserted_question), 'Ішемія малого кола', false, 2),
  ((SELECT id FROM inserted_question), 'Гостра правошлуночкова недостатність', false, 3),
  ((SELECT id FROM inserted_question), 'Гостра лівошлуночкова недостатність', true, 4);


-- Question 122
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка віком 36 років зі встановленим діагнозом: пухлина лівого головного бронха з’явилися скарги на затруднення проходження їжі. Який орган при цьому може бути залучений до пухлинного процесу?', NULL, 'medium', 122, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Трахея', false, 0),
  ((SELECT id FROM inserted_question), 'Загрудинна залоза', false, 1),
  ((SELECT id FROM inserted_question), 'Головні бронхи', false, 2),
  ((SELECT id FROM inserted_question), 'Серце', false, 3),
  ((SELECT id FROM inserted_question), 'Стравохід', true, 4);


-- Question 123
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 58-ми років надійшов у торакальне відділення з кровохарканням: при бронхоскопії виявлено звуження правого стовбурового бронха внаслідок розростання сірувато-білої тканини. В ході біопсії виявлена пухлина, що складається з дрібних клітин овальної й округлої форми з гіперхромними ядрами та незначною цитоплазмою, клітини справляють враження «голих ядер» Клітини пухлини ростуть пластами, тяжами. Гістологічна будова пухлини свідчить про те, що у хворого:', NULL, 'medium', 123, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Недиференційований рак', true, 0),
  ((SELECT id FROM inserted_question), 'Перехідноклітинний рак', false, 1),
  ((SELECT id FROM inserted_question), 'Пласкоклітинний незроговілий рак', false, 2),
  ((SELECT id FROM inserted_question), 'Базальноклітинний рак', false, 3),
  ((SELECT id FROM inserted_question), 'Пласкоклітинний зроговілий рак', false, 4);


-- Question 124
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час дорожньо-транспортної пригоди водій отримав травму шиї уламками скла з пошкодженням яремної вени. Яке порушення периферичного кровообігу може розвинутися у пацієнта?', NULL, 'medium', 124, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Повітряна емболія', true, 0),
  ((SELECT id FROM inserted_question), 'Газова емболія', false, 1),
  ((SELECT id FROM inserted_question), 'Обструктивна ішемія', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинна емболія', false, 3),
  ((SELECT id FROM inserted_question), 'Артеріальна гіперемія', false, 4);


-- Question 125
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час внутрішньовенної трансфузії фізіологічним розчином стан хворого різко погіршився і на фоні гострої ядухи настала смерть. При розтині померлого виявлено гостре венозне повнокров''я внутрішніх органів з різко розширеними правими відділами серця. При проколі правого шлуночка під водою виявляються пухирці. Який патологічний процес та його вид виник у хворого?', NULL, 'medium', 125, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Повітряна емболія', true, 0),
  ((SELECT id FROM inserted_question), 'Тромбоемболія', false, 1),
  ((SELECT id FROM inserted_question), 'Жирова емболія', false, 2),
  ((SELECT id FROM inserted_question), 'ГІазова емболія', false, 3),
  ((SELECT id FROM inserted_question), 'Тканинна емболія', false, 4);


-- Question 126
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік з кесонною хворобою помер з ознаками гострих порушень мозкового кровообігу в басейні a. meningea media лівої півкулі головного мозку. На розтині в зазначеній ділянці виявлено вогнище сірого розм''якшення мозку розмірами 6х7х3,4 см. Визначте характер процесу, що призвів до смерті людини:', NULL, 'medium', 126, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбоз', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоемболія', false, 1),
  ((SELECT id FROM inserted_question), 'Жирова емболія', false, 2),
  ((SELECT id FROM inserted_question), 'Газова емболія', true, 3),
  ((SELECT id FROM inserted_question), 'Атеросклероз судин', false, 4);


-- Question 127
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час гістологічного дослідження аутопсійного матеріалу від померлої вагітної жінки в мікроциркуляторному руслі легень виявлено клітини плоского епітелію шкіри ембріона, пушкове волосся, казеозну змазку і муцини з травного тракту ембріона. Також в легенях визначається набряк, дифузне ушкодження альвеол та системний тромбоз фібриновими тромбами. Який вид емболії розвинувся у жінки?', NULL, 'medium', 127, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбоемболія', false, 0),
  ((SELECT id FROM inserted_question), 'Амніотична', true, 1),
  ((SELECT id FROM inserted_question), 'Газова', false, 2),
  ((SELECT id FROM inserted_question), 'Повітряна', false, 3),
  ((SELECT id FROM inserted_question), 'Жирова', false, 4);


-- Question 128
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого 27-ми років з політравмою (закрита травма грудної клітини, закритий перелом правого стегна) через дві години після проведення скелетного витягнення різко погіршився стан і, на фоні гострої легенево-серцевої недостатності, настала смерть. При гістологічному дослідженні кровоносних судин легень та головного мозку померлого, при забарвленні суданом ІІІ, виявлені краплі помаранчевого кольору, які закупорюють просвіт судин. Яке ускладнення політравми розвинулося у хворого?', NULL, 'medium', 128, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мікробна емболія', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоемболія', false, 1),
  ((SELECT id FROM inserted_question), 'Жирова емболія', true, 2),
  ((SELECT id FROM inserted_question), 'Газова емболія', false, 3),
  ((SELECT id FROM inserted_question), 'Повітряна емболія', false, 4);


-- Question 129
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На розтині раптово померлого чоловіка віком 50 років у загальному стовбурі легеневої артерії виявлені вільно розташовані, щільні червоного кольору червоподібні маси з тьмяною поверхнею. Яка найімовірніша причина раптової смерті пацієнта?', NULL, 'medium', 129, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Мікробна емболія', false, 0),
  ((SELECT id FROM inserted_question), 'Тканинна емболія', false, 1),
  ((SELECT id FROM inserted_question), 'Емболія сторонніми масами', false, 2),
  ((SELECT id FROM inserted_question), 'Тромбоемболія легеневої артерії', true, 3),
  ((SELECT id FROM inserted_question), 'Жирова емболія', false, 4);


-- Question 130
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на тромбофлебіт нижніх кінцівок з’явилися біль в грудній клітці, кровохаркання, наростаюча дихальна недостатність, при явищах якої він помер. На розтині діагностовані множинні інфаркти легенів. Яка найімовірніша причина їх розвитку в цьому випадку?', NULL, 'medium', 130, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбоз гілок легеневої артерії', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоз бронхіальних артерій', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбоемболія гілок легеневої артерії', true, 2),
  ((SELECT id FROM inserted_question), 'Тромбоемболія бронхіальних артерій', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоз легеневих вен', false, 4);


-- Question 131
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 75-ти років був оперований з приводу рака передміхурової залози, помер раптово на 4-ту добу після оперативного втручання. При розтині тіла померлого у просвітах головного стовбура і біфуркації легеневої артерії були виявлені і легко видалені крихкі маси темно-червоного кольору з тьмяною поверхнею. Такі ж маси знаходились у порожнині правого шлуночка серця. Який різновид порушення кровообігу призвів до раптової смерті хворого?', NULL, 'medium', 131, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Парадоксальна емболія', false, 0),
  ((SELECT id FROM inserted_question), 'Інфаркт міокарда', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбоз легеневої артерії', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинна емболія', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоемболія легеневої артерії', true, 4);


-- Question 132
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворої, яка страждає на тромбофлебіт глибоких вен гомілки, раптово настала смерть. На розтині трупа у загальному стовбурі і біфуркації легеневої артерії знайдено червоні пухкі маси з тьмяною гофрованою поверхнею, що лежать вільно. Який патологічний процес виявив патологоанатом?', NULL, 'medium', 132, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Жирова емболія', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоз', false, 1),
  ((SELECT id FROM inserted_question), 'Емболія стороннім тілом', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинна емболія', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоемболія', true, 4);


-- Question 133
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого з тромбофлебітом нижніх кінцівок раптово після навантаження виникли задишка, різкий біль у грудях, ціаноз, набухання шийних вен. Яке найбільш імовірне порушення кровообігу виникло у хворого?', NULL, 'medium', 133, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбоемболія вінцевих судин', false, 0),
  ((SELECT id FROM inserted_question), 'Тромбоемболія мезентеріальних судин', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбоемболія ворітної вени', false, 2),
  ((SELECT id FROM inserted_question), 'Тромбоемболія легеневої артерії', true, 3),
  ((SELECT id FROM inserted_question), 'Тромбоемболія судин головного мозку', false, 4);


-- Question 134
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 55 років прооперований із приводу гострого апендициту. На 5-ту добу, піднявшись із ліжка, відчув брак повітря. У нього розвинувся різкий ціаноз обличчя. Пацієнт втратив свідомість. Після безрезультатної реанімації констатована смерть. На розтині виявлена тромбоемболія легеневого стовбура. Що могло бути найімовірнішим джерелом тромбоемболії?', NULL, 'medium', 134, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тромбоз брижових артерій', false, 0),
  ((SELECT id FROM inserted_question), 'Кулястий тромб передсердя', false, 1),
  ((SELECT id FROM inserted_question), 'Тромбоз ворітної вени', false, 2),
  ((SELECT id FROM inserted_question), 'Тромбоз у лівому шлуночку серця', false, 3),
  ((SELECT id FROM inserted_question), 'Тромбоз вен нижніх кінцівок', true, 4);


-- Question 135
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У водія 60-ти років довготривала хронічна патологія легень призвела до недостатності клапанів легеневої артерії і трикуспідального клапану, недостатності кровообігу за правошлуночковим типом. Який тип артеріальної гіпертензії є причиною перевантаження серця об’ємом?', NULL, 'medium', 135, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Сольова гіпертензія', false, 0),
  ((SELECT id FROM inserted_question), 'Центрально-ішемічна гіпертензія', false, 1),
  ((SELECT id FROM inserted_question), 'Ессенціальна гіпертензія', false, 2),
  ((SELECT id FROM inserted_question), 'Легенева гіпертензія', true, 3),
  ((SELECT id FROM inserted_question), 'Рефлексогенна гіпертензія', false, 4);


-- Question 136
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка 72-х років довготривала хронічна патологія легень призвела до недостатності клапанів легеневої артерії і трикуспідального клапану, недостатності кровообігу за правошлуночковим типом. Який тип артеріальної гіпертензії є причиною перевантаження серця об’ємом?', NULL, 'medium', 136, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рефлексогенна гіпертензія', false, 0),
  ((SELECT id FROM inserted_question), 'Легенева гіпертензія', true, 1),
  ((SELECT id FROM inserted_question), 'Центрально-ішемічна гіпертензія', false, 2),
  ((SELECT id FROM inserted_question), 'Сольова гіпертензія', false, 3),
  ((SELECT id FROM inserted_question), 'Есенціальна гіпертензія', false, 4);


-- Question 137
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У неврологічне відділення з приводу мозкового крововиливу поступив хворий 62-х років. Об’єктивно: стан важкий. Спостерігається наростання глибини і частоти дихання, а потім його зменшення до апное, після чого цикл дихальних рухів відновлюється. Який тип дихання у хворого?', NULL, 'medium', 137, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаспінг-дихання', false, 0),
  ((SELECT id FROM inserted_question), 'Апнейстичне', false, 1),
  ((SELECT id FROM inserted_question), 'Біота', false, 2),
  ((SELECT id FROM inserted_question), 'Чейна-Стокса', true, 3),
  ((SELECT id FROM inserted_question), 'Кусмауля', false, 4);


-- Question 138
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнта віком 60 років із геморагічним інсультом шпиталізовано до неврологічного відділення у тяжкому стані. Свідомість відсутня, спостерігається періодичне дихання типу Чейна-Стокса, що характеризується нерегулярними дихальними рухами, які поступово змінюються із прискорених і глибоких до сповільнених і поверхневих із наступним апное, після чого дихальний цикл повторюється. Що є основою патогенезу періодичного дихання?', NULL, 'medium', 138, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення збудливості дихального центру', false, 0),
  ((SELECT id FROM inserted_question), 'Порушення проведення нервового імпульсу', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження порогу збудливості дихального центру', false, 2),
  ((SELECT id FROM inserted_question), 'Підвищення порогу збудливості дихального центру', true, 3),
  ((SELECT id FROM inserted_question), 'Зростання концентрації вуглекислого газу в крові', false, 4);


-- Question 139
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловіка віком 47 років шпиталізовано до відділення інтенсивної терапії. 3 анамнезу відомо, що хворіє на цукровий діабет І типу впродовж 15 років. Під час огляду спостерігається: свідомість — кома І ст, наявне шумне прискорення дихання, при якому глибокі вдихи зміняються посиленими видихами за участю експіраторних м’язів. Який патологічний тип дихання спостерігається в пацієнта?', NULL, 'medium', 139, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Куссмауля', true, 0),
  ((SELECT id FROM inserted_question), 'Стенотичне', false, 1),
  ((SELECT id FROM inserted_question), 'Чейна-Стокса', false, 2),
  ((SELECT id FROM inserted_question), 'Біота', false, 3),
  ((SELECT id FROM inserted_question), 'Апнейстичне', false, 4);


-- Question 140
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з асфіксією після короткочасної зупинки дихання виникли поодинокі рідкі подихи з пасивним видихом, після чого дихання зупинилось зовсім. Який тип дихання спостерігався у пацієнта?', NULL, 'medium', 140, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апнейстичне', false, 0),
  ((SELECT id FROM inserted_question), 'Куссмауля', false, 1),
  ((SELECT id FROM inserted_question), 'Біота', false, 2),
  ((SELECT id FROM inserted_question), 'Гаспінг-дихання', true, 3),
  ((SELECT id FROM inserted_question), 'Чейна-Стокса', false, 4);


-- Question 141
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У палаті інтенсивної терапії інфекційного відділення лікар відзначає у пацієнта з менінгококовим менінгітом періоди тахіпное, які змінюються тривалими періодами апное. Який це тип патологічного дихання?', NULL, 'medium', 141, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гаспінг-дихання', false, 0),
  ((SELECT id FROM inserted_question), 'Дихання Біота', true, 1),
  ((SELECT id FROM inserted_question), 'Дихання Чейна-Стокса', false, 2),
  ((SELECT id FROM inserted_question), 'Апнейстичне лихання', false, 3),
  ((SELECT id FROM inserted_question), 'Дихання Грокко', false, 4);


-- Question 142
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарні машиною швидкої допомоги доставлено хворого в стані коми. В анамнезі указано цукровий діабет. Під час обстеження спостерігається шумне прискорене дихання, у якому глибокі вдихи чергуються із посиленими видохами за участю експіраторних м’язів. Яка форма порушення зовнішнього дихання спостерігається?', NULL, 'medium', 142, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апнейстичне дихання', false, 0),
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 1),
  ((SELECT id FROM inserted_question), 'Дихання Кусмауля', true, 2),
  ((SELECT id FROM inserted_question), 'Дихання Чейна-Стокса', false, 3),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 4);


-- Question 143
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У лікарню машиною швидкої допомоги доставлено хворого в стані коми. В анамнезі цукровий діабет. При обстеженні спостерігається шумне прискорене дихання, при якому глибокі вдихи чергуються з посиленими видохами за участю експіраторних м’язів. Яка форма порушення зовнішнього дихання спостерігається?', NULL, 'medium', 143, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихання Чейна-Стокса', false, 0),
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 1),
  ((SELECT id FROM inserted_question), 'Апнейстичне дихання', false, 2),
  ((SELECT id FROM inserted_question), 'Дихання Куссмауля', true, 3),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 4);


-- Question 144
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 23-х років надійшов до лікарні із черепно-мозковою травмою у важкому стані. Дихання характеризується судомним тривалим вдихом, який переривається коротким видихом. Для якого типу дихання це характерно?', NULL, 'medium', 144, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Куссмауля', false, 0),
  ((SELECT id FROM inserted_question), 'Біота', false, 1),
  ((SELECT id FROM inserted_question), 'Чейн-Стокса', false, 2),
  ((SELECT id FROM inserted_question), 'Апнейстичне', true, 3),
  ((SELECT id FROM inserted_question), 'Гаспінг-дихання', false, 4);


-- Question 145
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обіду дитина поперхнулася й аспірувала їжу. Почався сильний кашель, шкіра й слизові ціанотичні, пульс частий, дихання рідке, видих подовжений. Яке порушення зовнішнього дихання розвинулося у дитини?', NULL, 'medium', 145, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Експіраторна задишка при асфіксії', true, 0),
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 1),
  ((SELECT id FROM inserted_question), 'Інспіраторна задишка при асфіксії', false, 2),
  ((SELECT id FROM inserted_question), 'Альтернуюче дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 4);


-- Question 146
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обіду дитина похлинулася і аспірувала їжу. Почався сильний кашель, шкіра і слизові ціанотичні, пульс прискорений, дихання рідке, видих подовжений. Яке порушення зовнішнього дихання розвинулось у дитини?', NULL, 'medium', 146, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 0),
  ((SELECT id FROM inserted_question), 'Альтернуюче дихання', false, 1),
  ((SELECT id FROM inserted_question), 'Стадія інспіраторної задишки при асфіксії', false, 2),
  ((SELECT id FROM inserted_question), 'Стадія експіраторної задишки при асфіксії', true, 3),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 4);


-- Question 147
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хворий 62 років надійшов до неврологічного відділення з приводу мозкового крововиливу. Стан тяжкий. Спостерігається наростання глибини і частоти дихання, а потім його зменшення до апное, після чого цикл дихальних рухів відновлюється. Який тип дихання виник у хворого?', NULL, 'medium', 147, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Кусмауля', false, 0),
  ((SELECT id FROM inserted_question), 'Чейна–Стокса', true, 1),
  ((SELECT id FROM inserted_question), 'Апнеїстичне', false, 2),
  ((SELECT id FROM inserted_question), 'Гаспінг–дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Біота', false, 4);


-- Question 148
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 23-х років після ДТП надійшов до лікарні у важкому стані із черепно-мозковою травмою. Дихання характеризується судомним тривалим вдихом, який переривається коротким видихом. Для якого типу дихання це характерно?', NULL, 'medium', 148, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Апнейстичне', true, 0),
  ((SELECT id FROM inserted_question), 'Чейн-Стокса', false, 1),
  ((SELECT id FROM inserted_question), 'Біота', false, 2),
  ((SELECT id FROM inserted_question), 'Гаспінг-дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Кусмауля', false, 4);


-- Question 149
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В альпіністів, які без кисневого спорядження підіймалися на висоті 5000 метрів над рівнем моря, виникла тахікардія, знизився артеріальний тиск, а дихання стало частим. Який тип гіпоксії розвинувся в альпіністів?', NULL, 'medium', 149, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпоксемічна', true, 0),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 1),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 2),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 3),
  ((SELECT id FROM inserted_question), 'Гемічна', false, 4);


-- Question 150
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В підводному човні під час занурення порушилася система подачі кисню. У підводників збільшилися частота дихання і серцевих скорочень. Який вид гіпоксії розвинувся у підводників?', NULL, 'medium', 150, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серцево-судинна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 1),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксична', true, 3),
  ((SELECT id FROM inserted_question), 'Кров’яна', false, 4);


-- Question 151
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Лікар-дослідник у складі альпіністської експедиції піднявся у базовий табір, розташований на висоті 5000 м. На 3-й день перебування у нього з’явилися ознаки гірської хвороби: задишка, головний біль, втрата апетиту, загальна слабкість, ціаноз. Який тип гіпоксії має місце в цьому випадку?', NULL, 'medium', 151, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпоксична', true, 0),
  ((SELECT id FROM inserted_question), 'Змішана', false, 1),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 2),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 3),
  ((SELECT id FROM inserted_question), 'Іемічна', false, 4);


-- Question 152
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У крові пацієнта спостерігається зниження кількості еритроцитів, гемоглобіну, кольорового показника, концентрації сироваткового заліза, мікроанізоцитоз і пойкілоцитоз. Ці зміни супроводжуються розвитком гіпоксії. Який вид гіпоксії спостерігається в цьому разі?', NULL, 'medium', 152, true, NULL
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


-- Question 153
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Після ремонту автомобіля в закритому приміщенні при працюючому двигуні у чоловіка з’явилися задишка, запаморочення, акроціаноз, частота дихання 24-26/хв. Газовий склад крові: pO2 - 60 мм рт.ст., pCO2 - 30 мм рт.ст.; у крові наявний карбоксигемоглобін. Про який вид гіпоксії можна думати?', NULL, 'medium', 153, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 0),
  ((SELECT id FROM inserted_question), 'Гемічна', true, 1),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 3),
  ((SELECT id FROM inserted_question), 'Респіраторна', false, 4);


-- Question 154
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 13 років знаходиться на стаціонарному лікуванні в гематологічному відділенні обласної дитячої лікарні з діагнозом залізодефіцитна анемія. Який тип гіпоксії має місце у цієї хворої?', NULL, 'medium', 154, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 1),
  ((SELECT id FROM inserted_question), 'Гемічна', true, 2),
  ((SELECT id FROM inserted_question), 'Змішана', false, 3),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 4);


-- Question 155
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Вагітна жінка під час пологів втратила близько 800 мл крові. Спостерігається тахікардія, артеріальний тиск 100/70 мм рт.ст., тахіпное до 28/хв. Який тип гіпоксії розвивається первинно в такій клінічній ситуації ?', NULL, 'medium', 155, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Змішана', false, 0),
  ((SELECT id FROM inserted_question), 'Кров’яна', true, 1),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 2),
  ((SELECT id FROM inserted_question), 'Серцево-судинна', false, 3),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 4);


-- Question 156
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При розвитку колапсу спостерігаються розлади функцій нервової системи, порушення газообмінної функції легень, розлади системи крові і гемостазу. Первинне виникнення якої гіпоксії зумовлює ці прояви колапсу?', NULL, 'medium', 156, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тканинна', false, 0),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 1),
  ((SELECT id FROM inserted_question), 'Гемічна', false, 2),
  ((SELECT id FROM inserted_question), 'Циркуляторна', true, 3),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 4);


-- Question 157
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Чоловік 40-ка років скаржиться на загальну слабкість, головний біль, кашель із виділенням мокротиння, задишку. Після клінічного огляду й обстеження поставлено діагноз пневмонія. Який тип гіпоксії має місце у хворого?', NULL, 'medium', 157, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемічна', false, 0),
  ((SELECT id FROM inserted_question), 'Тканинна', false, 1),
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 3),
  ((SELECT id FROM inserted_question), 'Респіраторна', true, 4);


-- Question 158
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До приймального відділення звернувся хворий зі скаргами на задишку. Температура тіла 39°С. На рентгенограмі легенів спостерігається двостороння пневмонія. Який вид гіпоксії розвинувся у пацієнта?', NULL, 'medium', 158, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Тканинна', false, 0),
  ((SELECT id FROM inserted_question), 'Серцево-судинна', false, 1),
  ((SELECT id FROM inserted_question), 'Дихальна', true, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксична', false, 3),
  ((SELECT id FROM inserted_question), 'Кров''яна', false, 4);


-- Question 159
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У чоловіка під час обстеження в клініці виявлено різке зниження показників гемоглобіну. Яка функція крові порушується?', NULL, 'medium', 159, true, NULL
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


-- Question 160
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Хвора 56-ти років тривалий час хворіє на тиреотоксикоз. Який тип гіпоксії може розвинутися у цієї хворої?', NULL, 'medium', 160, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Циркуляторна', false, 0),
  ((SELECT id FROM inserted_question), 'Змішана', false, 1),
  ((SELECT id FROM inserted_question), 'Тканинна', true, 2),
  ((SELECT id FROM inserted_question), 'Дихальна', false, 3),
  ((SELECT id FROM inserted_question), 'Гемічна', false, 4);


-- Question 161
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До відділення реанімації доставлено пацієнта, у крові якого виявлено високий вміст сульфгемоглобіну. Який тип гіпоксії наявний у цьому разі?', NULL, 'medium', 161, true, NULL
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


-- Question 162
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнтку віком 65 років, яка довгий час хворіла на стеноз аортального клапана, після перенесеної вірусної інфекції шпиталізовано з ознаками хронічної серцево-судинної недостатності, задишкою, ціанозом, набряками. Який тип гіпоксії спостерігається в пацієнтки?', NULL, 'medium', 162, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихальний', false, 0),
  ((SELECT id FROM inserted_question), 'Тканинний', false, 1),
  ((SELECT id FROM inserted_question), 'Циркуляторний', true, 2),
  ((SELECT id FROM inserted_question), 'Гемічний', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоксичний', false, 4);


-- Question 163
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час аварії на виробництві пацієнт зазнав токсичного впливу калію ціаніду, що спричинило блокаду цитохромоксидази. До якого патологічного процесу це призвело?', NULL, 'medium', 163, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гемічної гіпоксії', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпоксичної гіпоксії', false, 1),
  ((SELECT id FROM inserted_question), 'Циркуляторної гіпоксії', false, 2),
  ((SELECT id FROM inserted_question), 'Тканинної гіпоксії', true, 3),
  ((SELECT id FROM inserted_question), 'Дихальної гіпоксії', false, 4);


-- Question 164
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До лікарні госпіталізовано пацієнта з діагнозом: пневмоконіоз, дихальна недостатність. Порушення якого компонента зовнішнього дихання є характерним для цієї патології?', NULL, 'medium', 164, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Порушення гуморальної регуляції зовнішнього дихання', false, 0),
  ((SELECT id FROM inserted_question), 'Порушення перфузії легень', false, 1),
  ((SELECT id FROM inserted_question), 'Зниження вентиляції легень', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження процесу дифузії газів', true, 3),
  ((SELECT id FROM inserted_question), 'Порушення нервової регуляції зовнішнього дихання', false, 4);


-- Question 165
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта з хронічним захворюванням легень розвинулася рестриктивна дихальна недостатність. Що з наведеного може бути причиною цього?', NULL, 'medium', 165, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Ларингоспазм', false, 0),
  ((SELECT id FROM inserted_question), 'Стиснення стінок дихальних шляхів пухлиною', false, 1),
  ((SELECT id FROM inserted_question), 'Порушення мукоциліарного транспорту і скупчення мокротиння', false, 2),
  ((SELECT id FROM inserted_question), 'Запальні процеси в легенях', true, 3),
  ((SELECT id FROM inserted_question), 'Потрапляння у просвіт бронху стороннього тіла', false, 4);


-- Question 166
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого із вираженим пневмосклерозом після перенесеного інфільтративного туберкульозу легень розвинулась дихальна недостатність. До якого патогенетичного типу вона відноситься?', NULL, 'medium', 166, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивний', true, 0),
  ((SELECT id FROM inserted_question), 'Рефлекторний', false, 1),
  ((SELECT id FROM inserted_question), 'Апнеїстичний', false, 2),
  ((SELECT id FROM inserted_question), 'Дисрегуляційний', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 4);


-- Question 167
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Пацієнту, у якого діагностована гостра дихальна недостатність, проведено штучну вентиляцію легень при високому парціальному тиску кисню, внаслідок чого стан пацієнта погіршився з розвитком респіраторного дистрес-синдрому. Вкажіть можливу причину цього ускладнення.', NULL, 'medium', 167, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Інтенсивне окислення сурфактанту легень', true, 0),
  ((SELECT id FROM inserted_question), 'Фіброз', false, 1),
  ((SELECT id FROM inserted_question), 'Ателектаз', false, 2),
  ((SELECT id FROM inserted_question), 'Застій крові в легенях', false, 3),
  ((SELECT id FROM inserted_question), 'Запальний процес', false, 4);


-- Question 168
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У експерименті на кролі через 2 тижні після звуження ниркової артерії виявлено збільшення кількості еритроцитів і гемоглобіну в крові внаслідок стимуляції еритропоезу еритропоетинами. Що підсилює утворення еритропоетинів?', NULL, 'medium', 168, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіповолемія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіперосмія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіперкапнія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоосмія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоксемія', true, 4);


-- Question 169
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 62 роки з хронічним обструктивним захворюванням легень спостерігається прогресуюча задишка та втома. В аналізі газів артеріальної крові спостерігається: гіпоксемія і підвищений рівень вуглекислого газу. Який механізм є головним у патогенезі його дихальної недостатності?', NULL, 'medium', 169, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Надмірна метаболічна потреба', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження легеневої вентиляції', true, 1),
  ((SELECT id FROM inserted_question), 'Зниження рівня кисню в повітрі', false, 2),
  ((SELECT id FROM inserted_question), 'Посилення шунтування крові', false, 3),
  ((SELECT id FROM inserted_question), 'Порушення альвеолярної дифузії кисню', false, 4);


-- Question 170
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В альпініста, який піднявся на висоту 5200 м, розвинувся газовий алкалоз. Що є причиною розвитку цього патологічного стану?', NULL, 'medium', 170, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперкапнія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпервентиляція легенів', true, 1),
  ((SELECT id FROM inserted_question), 'Гіповентиляція легенів', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження температури навколишнього середовища', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпоксемія', false, 4);


-- Question 171
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У альпініста, що піднявся на висоту 5200 м, розвинувся газовий алкалоз. Що є причиною його розвитку?', NULL, 'medium', 171, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіпервентиляція легенів', true, 0),
  ((SELECT id FROM inserted_question), 'Гіповентиляція легенів', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпероксемія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоксемія', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження температури навколишнього середовища', false, 4);


-- Question 172
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта віком 62 роки з хронічним обструктивним захворюванням легень спостерігається прогресуюча задишка та втома. В аналізі газів артеріальної крові спостерігається: гіпоксемія і підвищений рівень вуглекислого газу. Який механізм є головним у патогенезі його дихальної недостатності?', NULL, 'medium', 172, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Надмірна метаболічна потреба', false, 0),
  ((SELECT id FROM inserted_question), 'Зниження легеневої вентиляції', true, 1),
  ((SELECT id FROM inserted_question), 'Зниження рівня кисню в повітрі', false, 2),
  ((SELECT id FROM inserted_question), 'Посилення шунтування крові', false, 3),
  ((SELECT id FROM inserted_question), 'Порушення альвеолярної дифузії кисню', false, 4);


-- Question 173
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Внаслідок дії на організм електричного струму міської електромережі впродовж 0,1 сек у напрямку ''права рука-голова''у постраждалого спостерігалась зупинка дихання. Вкажіть найбільш імовірний механізм цього ускладнення:', NULL, 'medium', 173, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Параліч центрів вдиху', false, 0),
  ((SELECT id FROM inserted_question), 'Емоційний стрес', false, 1),
  ((SELECT id FROM inserted_question), 'Рефлекторна зупинка дихання (больовий шок)', false, 2),
  ((SELECT id FROM inserted_question), 'Тотальний параліч дихального центру', true, 3),
  ((SELECT id FROM inserted_question), 'Параліч дихальних м’язів', false, 4);


-- Question 174
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час функціонального навантаження на велотренажері у досліджуваного збільшилася частота дихання. Що є основною причиною зміни діяльності дихального центру в цьому випадку?', NULL, 'medium', 174, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Підвищення напруги CO_2 у крові', true, 0),
  ((SELECT id FROM inserted_question), 'Підвищення напруги O_2 у крові', false, 1),
  ((SELECT id FROM inserted_question), 'Зростання кількості адреналіну в крові', false, 2),
  ((SELECT id FROM inserted_question), 'Зниження напруги CO_2 у крові', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження напруги O_2 у крові', false, 4);


-- Question 175
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'При операції правосторонньої лобектомії хірург підійшов до кореня правої легені з метою окремого виділення і обробки його складових. Вкажіть порядок розміщення елементів кореня правої легені з якими лікар зустрінеться при виділенні та обробці в напрямку зверху вниз?', NULL, 'medium', 175, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Легенева артерія, бронх, легеневі вени', false, 0),
  ((SELECT id FROM inserted_question), 'Бронх, легенева артерія, легеневі вени', true, 1),
  ((SELECT id FROM inserted_question), 'Бронх, легенева артерія, діафрагмальний нерв', false, 2),
  ((SELECT id FROM inserted_question), 'Легенева вена, легеневі артерії, бронх', false, 3),
  ((SELECT id FROM inserted_question), 'Діафрагмальний нерв, бронх, бронхіальні артерія і вена', false, 4);


-- Question 176
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час мікроскопічного дослідження препарату, виготовленного з периферійної ділянки легені, виявлено поперечний переріз трубчастого утворення, стінка якого складається зі слизової та адвентиційної оболонок. Поверхня слизової оболонки має численні складки, а м’язова пластинка утворена суцільним шаром гладких міоцитів. Який це елемент повітроносних шляхів?', NULL, 'medium', 176, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Середній бронх', false, 0),
  ((SELECT id FROM inserted_question), 'Великий бронх', false, 1),
  ((SELECT id FROM inserted_question), 'Термінальна бронхіола', false, 2),
  ((SELECT id FROM inserted_question), 'Малий бронх', true, 3),
  ((SELECT id FROM inserted_question), 'Альвеолярний хід', false, 4);


-- Question 177
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На гістологічному препараті легень спостерігається структура діаметром близько 0,5 мм, слизова оболонка якої вкрита одношаровим кубічним війчастим епітелієм. У цьому епітелії виявлено секреторні клітини Клара, війчасті клітини та мікроворсинчасті. Яка структура спостерігається на гістологічному препараті?', NULL, 'medium', 177, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Термінальна бронхіола', true, 0),
  ((SELECT id FROM inserted_question), 'Середній бронх', false, 1),
  ((SELECT id FROM inserted_question), 'Альвеолярний хід', false, 2),
  ((SELECT id FROM inserted_question), 'Великий бронх', false, 3),
  ((SELECT id FROM inserted_question), 'Малий бронх', false, 4);


-- Question 178
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До приймального відділення лікарні госпіталізували юнака у непритомному стані. Діагностовано отруєння морфіном. У нього спостерігається поверхневе та рідке дихання, що зумовлено пригніченням дихального центру. Який тип недостатності дихання виник у пацієнта?', NULL, 'medium', 178, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 0),
  ((SELECT id FROM inserted_question), 'Вентиляційний рестриктивний', false, 1),
  ((SELECT id FROM inserted_question), 'Вентиляційний дисрегуляторний', true, 2),
  ((SELECT id FROM inserted_question), 'Дифузійний', false, 3),
  ((SELECT id FROM inserted_question), 'Вентиляційний обструктивний', false, 4);


-- Question 179
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У жінки, що хворіє на міастенію, виникли розлади дихання, що вимагало застосування штучної вентиляції легень. Який вид дихальної недостатності розвинувся в даної хворої?', NULL, 'medium', 179, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 0),
  ((SELECT id FROM inserted_question), 'Нервово-м’язовий', true, 1),
  ((SELECT id FROM inserted_question), 'Торако-діафрагмальний', false, 2),
  ((SELECT id FROM inserted_question), 'Центрогенний', false, 3),
  ((SELECT id FROM inserted_question), 'Рестриктивний', false, 4);


-- Question 180
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У групи альпіністів на висоті 3000 метрів було зроблено аналіз крові. Виявлене зниження HCO3 до 15 ммоль/л (норма 22-26 ммоль/л). Який механізм зниження HCO3 крові?', NULL, 'medium', 180, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зниження реабсорбції бікарбонатів у нирках', false, 0),
  ((SELECT id FROM inserted_question), 'Гіповентиляція', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпервентиляція', true, 2),
  ((SELECT id FROM inserted_question), 'Посилення ацидогенезу', false, 3),
  ((SELECT id FROM inserted_question), 'Зниження амоніогенезу', false, 4);


-- Question 181
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У пацієнта внаслідок хронічного захворювання органів дихання, що супроводжується задишкою, тахікардією і ціанозом, під час дослідження газового складу крові виявлено розвиток гіпоксемії і гіперкапнії. Яке порушення зовнішнього дихання спричинило зміни в газовому складі крові?', NULL, 'medium', 181, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперперфузія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіпердифузія', false, 1),
  ((SELECT id FROM inserted_question), 'Гіпервентиляція', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпоперфузія', false, 3),
  ((SELECT id FROM inserted_question), 'Гіповентиляція', true, 4);


-- Question 182
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого внаслідок хронічного захворювання органів дихання на фоні задишки, тахікардії і ціанозу під час дослідження газового складу крові виявлено розвиток гіпоксемії і гіперкапнії. Яке порушення зовнішнього дихання спостерігається у хворого?', NULL, 'medium', 182, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Гіперперфузія', false, 0),
  ((SELECT id FROM inserted_question), 'Гіповентиляція', true, 1),
  ((SELECT id FROM inserted_question), 'Гіпоперфузія', false, 2),
  ((SELECT id FROM inserted_question), 'Гіпервентиляція', false, 3),
  ((SELECT id FROM inserted_question), 'Гіпердифузія', false, 4);


-- Question 183
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Який тип вентиляційної недостатності дихання характерний для пневмотораксу?', NULL, 'medium', 183, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивний', true, 0),
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 1),
  ((SELECT id FROM inserted_question), 'Змішаний', false, 2),
  ((SELECT id FROM inserted_question), 'Дисрегуляторний', false, 3),
  ((SELECT id FROM inserted_question), 'Патологічний', false, 4);


-- Question 184
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'До приймального відділення лікарні госпіталізували юнака у непритомному стані. Діагностовано отруєння морфіном. У нього спостерігається поверхневе та рідке дихання, що зумовлено пригніченням дихального центру. Який тип недостатності дихання виник у пацієнта?', NULL, 'medium', 184, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 0),
  ((SELECT id FROM inserted_question), 'Вентиляційний рестриктивний', false, 1),
  ((SELECT id FROM inserted_question), 'Вентиляційний дисрегуляторний', true, 2),
  ((SELECT id FROM inserted_question), 'Дифузійний', false, 3),
  ((SELECT id FROM inserted_question), 'Вентиляційний обструктивний', false, 4);


-- Question 185
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Робота шахтарів у забої часто спричинює антракоз. Який вид дихальної недостатності може розвинутися при цьому?', NULL, 'medium', 185, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивний', true, 0),
  ((SELECT id FROM inserted_question), 'Торакальний', false, 1),
  ((SELECT id FROM inserted_question), 'Дисрегуляторний', false, 2),
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 3),
  ((SELECT id FROM inserted_question), 'Діафрагмальний', false, 4);


-- Question 186
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Щуру в плевральну порожнину введено 0,5 мл повітря. Який тип недостатності дихання виникає в даному випадку?', NULL, 'medium', 186, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Обструктивне порушення альвеолярної вентиляції', false, 0),
  ((SELECT id FROM inserted_question), 'Дифузійний', false, 1),
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 2),
  ((SELECT id FROM inserted_question), 'Рестриктивне порушення альвеолярної вентиляції', true, 3),
  ((SELECT id FROM inserted_question), 'Дисрегуляторне порушення альвеолярної вентиляції', false, 4);


-- Question 187
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого із вираженим пневмосклерозом після перенесеного інфільтративного туберкульозу легень розвинулась дихальна недостатність. До якого патогенетичного типу вона відноситься?', NULL, 'medium', 187, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дисрегуляційний', false, 0),
  ((SELECT id FROM inserted_question), 'Обструктивний', false, 1),
  ((SELECT id FROM inserted_question), 'Рестриктивний', true, 2),
  ((SELECT id FROM inserted_question), 'Рефлекторний', false, 3),
  ((SELECT id FROM inserted_question), 'Апнеїстичний', false, 4);


-- Question 188
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У підлітка 12-ти років, який хворіє на бронхіальну астму, розвинувся тяжкий напад астми: виражена експіраторна задишка. блідість шкірних покровів. Який вид порушення альвеолярної вентиляції має місце?', NULL, 'medium', 188, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивннй', false, 0),
  ((SELECT id FROM inserted_question), 'Нервово-м’язовий', false, 1),
  ((SELECT id FROM inserted_question), 'Центральний', false, 2),
  ((SELECT id FROM inserted_question), 'Торако-діафрагмальний', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивний', true, 4);


-- Question 189
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'На тлі алергічної реакції у дитини розвинувся набряк гортані. Який тип дихальної недостаності розвинувся в цьому разі?', NULL, 'medium', 189, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Рестриктивний', false, 0),
  ((SELECT id FROM inserted_question), 'Дифузійний', false, 1),
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 2),
  ((SELECT id FROM inserted_question), 'Обструктивний', true, 3),
  ((SELECT id FROM inserted_question), 'Дисрегуляторний', false, 4);


-- Question 190
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого під час прийому їжі виникла асфіксія внаслідок закупорки трахеї стороннім тілом. Яка форма порушення зовнішнього дихання спостерігається у хворого?', NULL, 'medium', 190, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дифузно-пневмонозна', false, 0),
  ((SELECT id FROM inserted_question), 'Первинно дискінетична', false, 1),
  ((SELECT id FROM inserted_question), 'Вентиляційно-рестриктивна', false, 2),
  ((SELECT id FROM inserted_question), 'Дифузно-рестриктивна', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивна', true, 4);


-- Question 191
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого на бронхіальну астму виникла гостра недостатність дихання. Який тип недостатності дихання виникає в цьому разі?', NULL, 'medium', 191, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Перфузійний', false, 0),
  ((SELECT id FROM inserted_question), 'Дисрегуляторне порушення альвеолярної вентиляції', false, 1),
  ((SELECT id FROM inserted_question), 'Дифузний', false, 2),
  ((SELECT id FROM inserted_question), 'Рестриктивне порушення альвеолярної вентиляції', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивне порушення альвеолярної вентиляції', true, 4);


-- Question 192
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В експерименті на тварині здійснили перерізку блукаючих нервів з обох боків. Як при цьому зміниться характер дихання?', NULL, 'medium', 192, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дихання не зміниться', false, 0),
  ((SELECT id FROM inserted_question), 'Стане поверхневим та частим', false, 1),
  ((SELECT id FROM inserted_question), 'Стане глибоким і частим', false, 2),
  ((SELECT id FROM inserted_question), 'Стане глибоким і рідким', true, 3),
  ((SELECT id FROM inserted_question), 'Стане поверхневим та рідким', false, 4);


-- Question 193
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В експериментальної тварини зроблено двобічну перерізку блукаючих нервів. Що станеться з її диханням?', NULL, 'medium', 193, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стане частим і поверхневим', false, 0),
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 1),
  ((SELECT id FROM inserted_question), 'Зупиниться у фазі видиху', false, 2),
  ((SELECT id FROM inserted_question), 'Зупиниться у фазі вдиху', false, 3),
  ((SELECT id FROM inserted_question), 'Стане рідким і глибоким', true, 4);


-- Question 194
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого поперечний розрив спинного мозку нижче VI грудного сегменту. Як внаслідок цього зміниться дихання?', NULL, 'medium', 194, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зупиниться', false, 0),
  ((SELECT id FROM inserted_question), 'Стане більш глибоким', false, 1),
  ((SELECT id FROM inserted_question), 'Суттєво не зміниться', true, 2),
  ((SELECT id FROM inserted_question), 'Стане більш рідким', false, 3),
  ((SELECT id FROM inserted_question), 'Стане більш частим', false, 4);


-- Question 195
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'В результаті травми пошкоджений спинний мозок (з повним розривом) на рівні першого шийного хребця. Що відбудеться з диханням?', NULL, 'medium', 195, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Припиняється', true, 0),
  ((SELECT id FROM inserted_question), 'Зростає частота', false, 1),
  ((SELECT id FROM inserted_question), 'Не змінюється', false, 2),
  ((SELECT id FROM inserted_question), 'Зростає глибина', false, 3),
  ((SELECT id FROM inserted_question), 'Зменшується частота', false, 4);


-- Question 196
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Унаслідок травми відбулося пошкодження спинного мозку з повним його розривом на рівні першого шийного хребця. Як зміниться дихання потерпілого?', NULL, 'medium', 196, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Зросте частота дихання', false, 0),
  ((SELECT id FROM inserted_question), 'Дихання припиниться', true, 1),
  ((SELECT id FROM inserted_question), 'Зросте глибина дихання', false, 2),
  ((SELECT id FROM inserted_question), 'Зменшиться частота дихання', false, 3);


-- Question 197
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У результаті поранення у чоловіка 35-ти років настав повний розрив спинного мозку на рівні першого шийного сегменту. Як зміниться характер дихання?', NULL, 'medium', 197, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Не зміниться', false, 0),
  ((SELECT id FROM inserted_question), 'Збережеться грудне, щезне діафрагмальне', false, 1),
  ((SELECT id FROM inserted_question), 'Зупиниться', true, 2),
  ((SELECT id FROM inserted_question), 'Стане рідким та глибоким', false, 3),
  ((SELECT id FROM inserted_question), 'Збережеться діафрагмальне, щезне грудне', false, 4);


-- Question 198
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У людини внаслідок травми мозку сталося вимкнення грудного дихання зі збереженням діафрагмального. У разі якої локалізації травми це може відбутися?', NULL, 'medium', 198, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'На рівні варолієвого моста', false, 0),
  ((SELECT id FROM inserted_question), 'На рівні ретикулярної формації стовбура', false, 1),
  ((SELECT id FROM inserted_question), 'На рівні 1-го шийного сегмента спинного мозку', false, 2),
  ((SELECT id FROM inserted_question), 'На рівні 8-го ірудного сегмента спинного мозку', false, 3),
  ((SELECT id FROM inserted_question), 'Між шийними та грудними сегментами спинного мозку', true, 4);


-- Question 199
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У постраждалого в автомобільній аварії припинилося грудне дихання при збереженні діафрагмального. На якому рівні найбільш імовірно пошкоджено спинний мозок?', NULL, 'medium', 199, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'XI-XII грудні сегменти', false, 0),
  ((SELECT id FROM inserted_question), 'I-II шийні сегменти', false, 1),
  ((SELECT id FROM inserted_question), 'VI-VII шийні сегменти', true, 2),
  ((SELECT id FROM inserted_question), 'I-II поперекові сегменти', false, 3),
  ((SELECT id FROM inserted_question), 'I-II крижові сегменти', false, 4);


-- Question 200
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дитину госпіталізовано до лікарні в стані асфіксії. Під час огляду гортані виявлено білуваті плівки, що обтурують просвіт дихальних шляхів та легко видаляються. Для якого виду запалення гортані характерні такі ознаки?', NULL, 'medium', 200, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Катаральне', false, 0),
  ((SELECT id FROM inserted_question), 'Дифтеритичне', false, 1),
  ((SELECT id FROM inserted_question), 'Гнійне', false, 2),
  ((SELECT id FROM inserted_question), 'Серозне', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозне', true, 4);


-- Question 201
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дівчинка 6 років захворіла на дифтерію та померла від асфіксії на третю добу. На аутопсії слизова оболонка трахеї та бронхів стовщена, набрякла, тьмяна, вкрита сіруватими плівками, які легко відокремлюються. Про який вид запалення свідчать морфологічні зміни?', NULL, 'medium', 201, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серозне', false, 0),
  ((SELECT id FROM inserted_question), 'Крупозне', true, 1),
  ((SELECT id FROM inserted_question), 'Геморагічне', false, 2),
  ((SELECT id FROM inserted_question), 'Дифтеритичне', false, 3),
  ((SELECT id FROM inserted_question), 'Катаральне', false, 4);


-- Question 202
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час розтину тіла дитини, яка померла при ознаках асфіксії, були виявлені в трахеї і головних бронхах сіруватого кольору плівки, які вільно лежали у просвіті дихальних шляхів, нагадуючи їх зліпки. Вкажіть вид запалення:', NULL, 'medium', 202, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Крупозне', true, 0),
  ((SELECT id FROM inserted_question), 'Дифтеритичне', false, 1),
  ((SELECT id FROM inserted_question), 'Серозне', false, 2),
  ((SELECT id FROM inserted_question), 'Катаральне', false, 3),
  ((SELECT id FROM inserted_question), 'Гнійне', false, 4);


-- Question 203
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дитина доставлена в санпропускник в стані асфіксії. При огляді в гортані виявлені білуваті плівки, що обтурують просвіт та легко видаляються. Лікар запідозрив дифтерію. Про яке запалення гортані йдеться?', NULL, 'medium', 203, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Серозне', false, 0),
  ((SELECT id FROM inserted_question), 'Гнійне', false, 1),
  ((SELECT id FROM inserted_question), 'Катаральне', false, 2),
  ((SELECT id FROM inserted_question), 'Крупозне', true, 3),
  ((SELECT id FROM inserted_question), 'Дифтеритичне', false, 4);


-- Question 204
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У хворого під час прийому їжі виникла асфіксія внаслідок закупорки трахеї стороннім тілом. Яка форма порушення зовнішнього дихання спостерігається у хворого?', NULL, 'medium', 204, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Дифузно-пневмонозна', false, 0),
  ((SELECT id FROM inserted_question), 'Первинно дискінетична', false, 1),
  ((SELECT id FROM inserted_question), 'Вентиляційно-рестриктивна', false, 2),
  ((SELECT id FROM inserted_question), 'Дифузно-рестриктивна', false, 3),
  ((SELECT id FROM inserted_question), 'Обструктивна', true, 4);


-- Question 205
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'У дитини 7-ми років підвищилася температура тіла до 39°С, з’явилися нежить, кон’юнктивіт і кашель. На шкірі відзначалися великоплямисті висипи, при огляді порожнини рота спостерігаються білуваті висипи на слизовій оболонці щік. Раптово з’явилося важке дихання і настала смерть при явищах асфіксії. Який діагноз найімовірніший?', NULL, 'medium', 205, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Менінгококовий назофарингіт', false, 0),
  ((SELECT id FROM inserted_question), 'Скарлатина', false, 1),
  ((SELECT id FROM inserted_question), 'Дифтерія', false, 2),
  ((SELECT id FROM inserted_question), 'Грип', false, 3),
  ((SELECT id FROM inserted_question), 'Кір', true, 4);


-- Question 206
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Дитину госпіталізовано до лікарні в стані асфіксії. Під час огляду гортані виявлено білуваті плівки, що обтурують просвіт дихальних шляхів та легко видаляються. Для якого виду запалення гортані характерні такі ознаки?', NULL, 'medium', 206, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Катаральне', false, 0),
  ((SELECT id FROM inserted_question), 'Дифтеритичне', false, 1),
  ((SELECT id FROM inserted_question), 'Гнійне', false, 2),
  ((SELECT id FROM inserted_question), 'Серозне', false, 3),
  ((SELECT id FROM inserted_question), 'Крупозне', true, 4);


-- Question 207
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обіду дитина поперхнувся і аспірував їжу. Почався сильний кашель, шкіра і слизові ціанотичні, пульс прискорений, дихання рідке, видих подовжений. Яке порушення зовнішнього дихання розвинулося у дитини?', NULL, 'medium', 207, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Стадія експіраторної задишки при асфіксії', true, 0),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 1),
  ((SELECT id FROM inserted_question), 'Стадія інспіраторної задишки при асфіксії', false, 2),
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 3);


-- Question 208
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)
  SELECT t.id, 'Під час обіду дитина поперхнулася й аспірувала їжу. Почався сильний кашель, шкіра й слизові ціанотичні, пульс частий, дихання рідке, видих подовжений. Яке порушення зовнішнього дихання розвинулося у дитини?', NULL, 'medium', 208, true, NULL
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Система кровотворення й імунного захисту, кров'
    AND t.title = 'Нормальний розвиток і структура, вікові зміни'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES
  ((SELECT id FROM inserted_question), 'Експіраторна задишка при асфіксії', true, 0),
  ((SELECT id FROM inserted_question), 'Дихання Біота', false, 1),
  ((SELECT id FROM inserted_question), 'Інспіраторна задишка при асфіксії', false, 2),
  ((SELECT id FROM inserted_question), 'Альтернуюче дихання', false, 3),
  ((SELECT id FROM inserted_question), 'Стенотичне дихання', false, 4);


COMMIT;
