-- SQL script to insert section-1 tests into courses/topics/questions tables
-- This script will create tables if they don't exist and insert test data

BEGIN;

-- Create courses table if not exists
CREATE TABLE IF NOT EXISTS courses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    faculty VARCHAR(20) CHECK (faculty IN ('medical', 'pharmaceutical')) NOT NULL,
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create topics table if not exists
CREATE TABLE IF NOT EXISTS topics (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    video_url TEXT,
    lecture_notes TEXT,
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create questions table if not exists
CREATE TABLE IF NOT EXISTS questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    topic_id UUID REFERENCES topics(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    explanation TEXT,
    difficulty VARCHAR(10) CHECK (difficulty IN ('easy', 'medium', 'hard')) DEFAULT 'medium',
    order_index INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create question_options table if not exists
CREATE TABLE IF NOT EXISTS question_options (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT false,
    order_index INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Ensure course exists
INSERT INTO courses (title, description, faculty, order_index, is_active)
SELECT 'Фундаментальні медико-біологічні знання', 'Комплексний курс із молекулярної біології, генетики та біохімії', 'medical', 1, true
WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = 'Фундаментальні медико-біологічні знання');

-- Ensure topic exists
INSERT INTO topics (course_id, title, description, order_index, is_active)
SELECT c.id, 'Молекулярні механізми реалізації генетичної інформації', 'Розділ 1: Молекулярні механізми реалізації генетичної інформації', 1, true
FROM courses c
WHERE c.title = 'Фундаментальні медико-біологічні знання'
  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = 'Молекулярні механізми реалізації генетичної інформації');

-- Insert questions and options
-- Question 1
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Прокаріотичні та еукаріотичні клітини характеризуються здатністю до поділу. Поділ прокаріотичних клітин відрізняється від поділу еукаріотичних, але існує молекулярний процес, який лежить в основі цих поділів. Який це процес?', NULL, 'medium', 1, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Ампліфікація генів', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Транскрипція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Репарація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Реплікація ДНК', true, 4 )
;

-- Question 2
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Прокаріотичні та еукаріотичні клітини характеризуються здатністю до поділу. Поділ прокаріотичних клітин відрізняється від поділу еукаріотичних, але існує молекулярний процес, що лежить в основі обох поділів. Назвіть цей процес.', NULL, 'medium', 2, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Транскрипція', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Репарація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Ампліфікація генів', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Реплікація ДНК', true, 4 )
;

-- Question 3
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Для лікування урогенітальних інфекцій використовують хінолони - інгібітори ферменту ДНК-гірази. Який процес порушується під дією хінолонів у першу чергу?', NULL, 'medium', 3, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Ампліфікація генів', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Зворотна транскрипція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Реплікація ДНК', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Рекомбінація генів', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Репарація ДНК', false, 4 )
;

-- Question 4
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під дією фізичних і хімічних мутагенів у ДНК можуть виникати ушкодження. Як називається здатність клітин до виправлення пошкоджень у молекулах ДНК?', NULL, 'medium', 4, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Транскрипція', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Регенерація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Репарація', true, 4 )
;

-- Question 5
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Унаслідок дії випромінювання на послідовність нуклеотидів ДНК, втрачено 2 нуклеотиди. Який вид мутації відбувся в ланцюзі ДНК?', NULL, 'medium', 5, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Делеція', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Інверсія', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 4 )
;

-- Question 6
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Генний апарат людини містить близько 30 тисяч генів, а кількість варіантів антитіл сягає мільйонів. Який механізм використовується для утворення нових генів, що відповідають за синтез такої кількості антитіл?', NULL, 'medium', 6, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Утворення фрагментів Оказакі', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Реплікація ДНК', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Рекомбінація генів', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Ампліфікація генів', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Репарація ДНК', false, 4 )
;

-- Question 7
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Внаслідок впливу у-випромінювання ділянка ланцюга ДНК повернулася на 180 градусів. Яка з перелічених видів мутацій відбулася в ланцюзі ДНК?', NULL, 'medium', 7, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Інверсія', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Делеція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 4 )
;

-- Question 8
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Внаслідок впливу у-випромінювання ділянка ланцюга ДНК повернулася на 180 градусів. Яка з перелічених видів мутацій відбулася в ланцюзі ДНК?', NULL, 'medium', 8, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Делеція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Інверсія', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 4 )
;

-- Question 9
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Генетична інформація зберігається в ДНК, але не бере безпосередньої участі в синтезі білка в клітинах ДНК. Який процес забезпечує реалізацію генетичної інформації в поліпептидний ланцюг?', NULL, 'medium', 9, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Синтез рРНК', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Синтез іРНК', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Синтез тРНК', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 4 )
;

-- Question 10
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У клітинах людини під дією ультрафіолетового випромінювання відбулося пошкодження молекули ДНК. Реалізувалася система відновлення пошкодженої ділянки молекули ДНК по непошкодженому ланцюгу за допомогою специфічного ферменту. Як називається це явище?', NULL, 'medium', 10, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Репарація', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Ініціація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Термінація', false, 4 )
;

-- Question 11
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У клітинах людини під дією ультрафіолетового випромінювання відбулося пошкодження молекули ДНК. Реалізувалася система відновлення пошкодженої ділянки молекули ДНК по непошкодженому ланцюгу за допомогою специфічного ферменту. Як називається це явище?', NULL, 'medium', 11, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Репарація', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Ініціація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Термінація', false, 4 )
;

-- Question 12
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під час вивчення роботи оперона бактерії відбулося звільнення гена-оператора від білка-репресора. Який процес починається у клітині відразу після цього?', NULL, 'medium', 12, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Транскринція', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Сплайсинг', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Процесинг', false, 4 )
;

-- Question 13
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Формування великої кількості імуноглобулінів з різною антигенною специфічністю відбувається з невеликої кількості генів. Завдяки якому процесу це є можливим?', NULL, 'medium', 13, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Рекомбінація генів', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Делеція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Транскрипція', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 4 )
;

-- Question 14
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Генний апарат людини містить близько 30 тисяч генів, а кількість варіантів антитіл сягає мільйонів. Який механізм використовується для утворення нових генів, що відповідають за синтез такої кількості антитіл?', NULL, 'medium', 14, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Утворення фрагментів Оказакі', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Реплікація ДНК', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Рекомбінація генів', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Ампліфікація генів', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Репарація ДНК', false, 4 )
;

-- Question 15
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Внаслідок впливу гама-випромінювання ділянка ланцюга ДНК повернулась на 180 градусів. Який з наведених видів мутацій відбувся в ланцюгу ДНК?', NULL, 'medium', 15, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Делеція', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Інверсія', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 4 )
;

-- Question 16
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Внаслідок впливу у-випромінювання ділянка ланцюга ДНК повернулася на 180 градусів. Яка з перелічених видів мутацій відбулася в ланцюзі ДНК?', NULL, 'medium', 16, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Інверсія', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Делеція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', false, 4 )
;

-- Question 17
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Вивчається робота оперону бактерії. Відбулося звільнення гена-оператора від білка репресора. Безпосередньо після цього в клітині почнеться:', NULL, 'medium', 17, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Репресія', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Процесінг', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Транскрипція', true, 4 )
;

-- Question 18
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У клітині людини в гранулярну ендоплазматичну сітку до рибосом доставлена і-РНК, що містить як екзонні, так і інтронні ділянки. Який процес НЕ відбувається?', NULL, 'medium', 18, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Процесинг', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Транскрипція', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трансляція', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Пролонгація', false, 4 )
;

-- Question 19
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під час реплікації ДНК один із її ланцюгів синтезується із запізненням. Що визначає дану особливість синтезу?', NULL, 'medium', 19, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Компліментарність ланцюгів', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Відсутність трифосфонуклеотидів', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Антипаралельність ланцюгів', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Великі розмірами ДНК-полімерази', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Необхідність репарації', false, 4 )
;

-- Question 20
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У районах Південної Африки у людей розповсюджена серпоподібноклітинна анемія, при якій еритроцити мають форму серпа внаслідок заміни в молекулі гемоглобіну амінокислоти глутаміну на валін. Чим викликана ця хвороба?', NULL, 'medium', 20, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Геномні мутації', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Порушення механізмів реалізації генетичної інформації', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Трансдукція', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Кросинговер', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Генна мутація', true, 4 )
;

-- Question 21
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під час цитогенетичного дослідження культури клітин людини виявлено клітини, які мають 44 хромосоми (відсутність обох хромосом третьої пари). Яка мутаціявідбулася?', NULL, 'medium', 21, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Хромосомна аберація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Нулесомія', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Генна (точкова)', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Полісомія', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Моносомія', false, 4 )
;

-- Question 22
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У здорових батьків, спадковість яких не обтяжена, народилась дитина з чисельними вадами розвитку. Цитогенетичний аналіз виявив в соматичних клітинах дитини трисомію за 13-ю хромосомою (синдром Патау). З яким явищем пов''язане народження такої дитини?', NULL, 'medium', 22, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Хромосомна мутація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Рецесивна мутація', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Домінантна мутація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Порушення гаметогенезу', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Соматична мутація', false, 4 )
;

-- Question 23
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Одна з форм рахіту успадковується за домінантним зчепленим із Х-хромосомою типом. Хворіють і чоловіки, і жінки. Наслідком якої мутації є це захворювання?', NULL, 'medium', 23, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Анеуплоідії', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Поліплоідії', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Хромосомної', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Геномної', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Генної', true, 4 )
;

-- Question 24
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під час поділу клітини для реплікації ДНК надходить сигнал з цитоплазми, і певна ділянка спіралі ДНК розкручується та розділяється на два ланцюги. За допомогою якого ферменту це здійснюється?', NULL, 'medium', 24, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'РНК-полімераза', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Лігаза', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Геліказа', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Рестриктаза', false, 3 ),
  ( (SELECT id FROM inserted_question), 'ДНК-полімераза', false, 4 )
;

-- Question 25
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У структурі оперону ДНК прокаріот є фрагмент, до якого прикріплюється РНК-полімераза в фазі ініціації транскрипції. Визначте цей фермент.', NULL, 'medium', 25, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Ген-регулятор', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Промотор', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Первинний транскрипт', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Структурний ген', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Ген-оператор', false, 4 )
;

-- Question 26
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Робітниця хімічного підприємства внаслідок порушення правил безпечної роботи зазнала токсичної дії азотистої кислоти та нітритів, які викликають дезамінування цитозину в молекулі ДНК. Який фермент ініціює ланцюг репараційних процесів?', NULL, 'medium', 26, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Оротидилмонофосфат-декарбоксилаза', false, 0 ),
  ( (SELECT id FROM inserted_question), 'ДНК-залежна-РНК-полімераза', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Цитидинтрифосфатсинтетаза', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Уридин-ДНК-глікозидаза', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Тимідилатсинтаза', false, 4 )
;

-- Question 27
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'В експерименті було показано, що опромінені ультрафіолетом клітини шкіри хворих на пігментну ксеродерму, через дефект ферменту репарації, повільніше відновлюють нативну структуру ДНК, ніж клітини здорових людей. За допомогою якого ферменту відбувається цей процес?', NULL, 'medium', 27, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'РНК-лігаза', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Ендонуклеаза', true, 1 ),
  ( (SELECT id FROM inserted_question), 'ДНК-гіраза', false, 2 ),
  ( (SELECT id FROM inserted_question), 'ДНК-полімераза III', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Праймаза', false, 4 )
;

-- Question 28
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Під час аналізу груп крові у великому місті вчені виявили, що деякі люди мають рідкісні антигени на поверхні еритроцитів, які не входять до найпоширеніших систем АBО і Rh. Подальші дослідження показали, що ці антигени передаються у спадок і трапляються лише в певних етнічних групах. Виявилося, що їхня поява пов''язана зі змінами в ДНК які відбулися багато поколінь тому. Чим із запропонованих варіантів зумовлений поліморфізм людських популяцій?', NULL, 'medium', 28, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Незалежним розходженням хромосом', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Випадковою зустріччю гамет при заплідненні', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Умовами навколишнього середовища', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Кросинговером', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Мутаціями', true, 4 )
;

-- Question 29
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'В ділянці хромосоми гени розташовані в такій послідовності: ABCDEFG. В результаті дії радіоактивного випромінювання відбулася перебудова, після чого ділянка хромосоми має наступний вигляд: ABDEFG. Яка мутація відбулася?', NULL, 'medium', 29, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Мутація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Інсерція', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Делеція', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Інверсія', false, 4 )
;

-- Question 30
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Було доведено, що молекула незрілої і-РНК (про-і-РНК) містить більше триплетів, ніж знайдено амінокислот у синтезованому білку. Це пояснюється тим, що трансляції у нормі передує:', NULL, 'medium', 30, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Мутація', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Процесинг', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Ініціація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Реплікація', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Репарація', false, 4 )
;

-- Question 31
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Як називається хромосомна мутація, що полягає в перенесенні ділянки однієї хромосоми на іншу, не гомологічну їй хромосому?', NULL, 'medium', 31, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Транспозиція', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Транслокація', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Трансверзія', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Делеція', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Дуплікація', false, 4 )
;

-- Question 32
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У новонародженої дитини виявлено наступну патологію: аномалія розвитку нижньої щелепи та гортані, що супроводжується характерними змінами голосу, а також мікроцефалія, вада серця, чотирьохпалість. Найбільш імовірною причиною таких аномалій є делеція:', NULL, 'medium', 32, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), '21-ої хромосоми', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Короткого плеча 5-ої хромосоми', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Короткого плеча 7-ої хромосоми', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Короткого плеча 11-ої хромосоми', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Короткого плеча 9-ої хромосоми', false, 4 )
;

-- Question 33
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Чоловік 26-ти років скаржиться на безплідність. Об''єктивно: зріст 186 см, довгі кінцівки, гінекомастія, гіпоплазія яєчок, у зіскрібку слизової оболонки щоки знайдені тільця Барра. Діагностований синдром Клайнфельтера. Який механізм хромосомної аномалії має місце при даному захворюванні?', NULL, 'medium', 33, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Нерозходження гетосом у мейозі', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Нерозходження хроматид у мітозі', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Транслфокація', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Інверсія хромосоми', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Делеція хромосоми', false, 4 )
;

-- Question 34
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'При розтині трупа новонародженого хлопчика виявлені полідактилія, мікроцефалія, незрощення верхньої губи та твердого піднебіння, а також гіпертрофія паренхіматозних органів. Вказані вади відповідають синдрому Патау. Яка найбільш вірогідна причина даної патології?', NULL, 'medium', 34, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Нерозходження статевих хромосом', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 18-ої хромосоми', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 21-ої хромосоми', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Часткова моносомія', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 13-ої хромосоми', true, 4 )
;

-- Question 35
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У фібробластах шкіри дитини з діагнозом хвороба Дауна, виявлено 47 хромосом. Визначте тип аномалії.', NULL, 'medium', 35, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Полісомія Ү', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 13', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Трисомія Х', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 18', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 21', true, 4 )
;

-- Question 36
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У букальних мазках епітелію жінки виявлено в ядрі клітини 2 тільця Барра. Це характерно для синдрому:', NULL, 'medium', 36, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Трисомія 21-ї хромосоми', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трисомія 13-ї хромосоми', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Трисомія по У-хромосомі', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Трисомія статевих хромосом', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Моносомія статевих хромосом', false, 4 )
;

-- Question 37
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Внаслідок порушення розходження хромосом при мейозі утворилися: яйцеклітина тільки з 22 аутосомами і полярне тільце з 24 хромосомами. Який синдром можливий у дитини при заплідненні такої яйцеклітини нормальним сперматозооном (22+Х)?', NULL, 'medium', 37, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Синдром Клайнфельтера', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трисомія Х', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Синдром Шерешевського-Тернера', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Синдром Дауна', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Синдром Едвардса', false, 4 )
;

-- Question 38
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У вагітної жінки 38-ми років з обтяженою спадковістю аналіз клітин амніотичної рідини на статевий хроматин показав, що клітини плоду містять по два тільця статевого хроматину (тільця Барра). Для якого захворювання характерні вищезазначені ознаки?', NULL, 'medium', 38, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Трисомія Х', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Синдром Патау', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Хвороба Дауна', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Синдром Шерешевського-Тернера', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Синдром Клайнфельтера', true, 4 )
;

-- Question 39
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Жінка 30-ти років народила хлопчика з розщепленням верхньої губи (''заяча губа'' ''вовча паща''). При додатковому обстеженні виявлені значні порушення нервової, серцевосудинної систем та зору. При дослідженні каріотипу діагностована трисомія за 13-ю хромосомою. Який синдром наявний у хлопчика?', NULL, 'medium', 39, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Патау', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Шерешевського-Тернера', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Клайнфельтера', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Дауна', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Едвардса', false, 4 )
;

-- Question 40
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'При дослідженні амніотичної рідини, одержаної під час амніоцентезу (прокол амніотичної оболонки), виявлені клітини, ядра яких містять статевий хроматин (тільце Барра). Про що це може свідчити?', NULL, 'medium', 40, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Поліплоїдія', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Генетичні порушення розвитку плода', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Розвиток плода чоловічої статі', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Розвиток плода жіночої статі', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Трисомія', false, 4 )
;

-- Question 41
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'При обстеженні букального епітелію чоловіка з євнухоїдними ознаками у багатьох клітинах був виявлений статевий Х- хроматин. Для якої хромосомної хвороби це характерно?', NULL, 'medium', 41, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Синдром Дауна', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Трисомія за Х-хромосомою', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Синдром Клайнфельтера', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Синдром Шерешевського-Тернера', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Синдром Марфана', false, 4 )
;

-- Question 42
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'На розтині звертає на себе увагу наступне: тіло молодого чоловіка високого зросту, виражена блідість та еластичність шкіри, доліхоцефалічна будова голови, подовження і контрактура пальців верхніх і нижніх кінцівок (нагадують кінцівки павука), незначне вдавлення грудини всередину, помірно виражений сколіоз. При дослідженні органів грудної порожнини виявили розрив аневризми висхідної частини аорти. Яке захворювання, найімовірніше, мало місце в цьому випадку?', NULL, 'medium', 42, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Синдром Марфана', true, 0 ),
  ( (SELECT id FROM inserted_question), 'Сифілітичний мезоаортит', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Синдром Гудпасчера', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Атеросклероз аорти', false, 3 )
;

-- Question 43
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Юнаку віком 18 років встановлено діагноз: хвороба Марфана. Під час клініко-лабораторного дослідження виявлено порушення розвитку сполучної тканини, будови кришталика ока, аномалії серцево- судинної системи, арахнодактилія. Який варіант взаємодії генів різних алельних пар сприяє розвитку цього захворювання?', NULL, 'medium', 43, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'А. Комплементарність', false, 0 ),
  ( (SELECT id FROM inserted_question), 'B. Плейотропія', true, 1 ),
  ( (SELECT id FROM inserted_question), 'С. Кодомінування', false, 2 ),
  ( (SELECT id FROM inserted_question), 'D. Множинний алелізм', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Е. Неповне домінування', false, 4 )
;

-- Question 44
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Молекула зрілої інформаційної РНК має меншу довжину, ніж відповідний ген молекули ДНК. Неінформативні послідовності нуклеотидів про-іРНК видаляються під час процесингу. Яку назву мають ці ділянки?', NULL, 'medium', 44, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Трапскриптони', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Екзони', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Мутони', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Інтрони', true, 3 ),
  ( (SELECT id FROM inserted_question), 'Кластери', false, 4 )
;

-- Question 45
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У загальному вигляді генетичний апарат еукаріот є таким: екзон-інтрон-екзон. Така структурно-функціональна організація гена зумовлює особливості транскрипції. Якою буде про-іРНК відповідно до згаданої схеми?', NULL, 'medium', 45, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Екзон-екзон', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Екзон-екзон-інтрон', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Інтрон-екзон', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Екзон-інтрон', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Екзон-інтрон-екзон', true, 4 )
;

-- Question 46
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'При регенерації епітелію слизової оболонки порожнини рота (розмноження клітин) відбулася реплікація (авторепродукція) ДНК за напівконсервативним механізмом. При цьому нуклеотиди нової нитки ДНК є комплементарними до:', NULL, 'medium', 46, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Ферменту ДНК-полімерази', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Змістовних кодонів', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Материнської нитки', true, 2 ),
  ( (SELECT id FROM inserted_question), 'Ферменту РНК-полімерази', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Інтронних ділянок гену', false, 4 )
;

-- Question 47
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Онкологічному хворому призначили препарат метотрексат, до якого з часом клітини-мішені пухлини втратили чутливість. Експресія гену якого ферменту при цьому змінюється?', NULL, 'medium', 47, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Тиміназа', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Дегідрофолатредуктаза', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Фолатдекарбоксилаза', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Фолатоксидаза', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Дезаміназа', false, 4 )
;

-- Question 48
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Регуляція експресії генів здійснюється за допомогою різних механізмів. Назвіть ділянки ДНК, у разі індукції яких активується експресія гену:', NULL, 'medium', 48, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Сайленсер', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Енхансер', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Атенюатор', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Спейсер', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Термінатор', false, 4 )
;

-- Question 49
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'У клітину проник вірус грипу. Трансляція під час біосинтезу вірусного білка в клітині буде здійснюватися:', NULL, 'medium', 49, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'На каналах гладенької ендоплазматичної сітки', false, 0 ),
  ( (SELECT id FROM inserted_question), 'На полірибосомах', true, 1 ),
  ( (SELECT id FROM inserted_question), 'У ядрі', false, 2 ),
  ( (SELECT id FROM inserted_question), 'У клітинному центрі', false, 3 ),
  ( (SELECT id FROM inserted_question), 'У лізосомах', false, 4 )
;

-- Question 50
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'В клітині відбувається процес трансляції. Коли рибосомадоходить до кодонів УАА, УАГ або УГА, синтез поліпептидного ланцюга закінчується. Ці кодони у процесі біосинтезу поліпептиду не розпізнаються жодною т-РНК і тому є сигналом:', NULL, 'medium', 50, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Посттрансляційної модифікації', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Термінації', true, 1 ),
  ( (SELECT id FROM inserted_question), 'Початку транскрипції', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Елонгації', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Ініціації', false, 4 )
;

-- Question 51
WITH inserted_question AS (
  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)
  SELECT t.id, 'Молекули зрілої іРНК у клітині є носієм генетичної інформації про послідовність з''єднання між собою певних амінокислот. Це означає, що в молекулах іРНК закодована:', NULL, 'medium', 51, true
  FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Фундаментальні медико-біологічні знання'
    AND t.title = 'Молекулярні механізми реалізації генетичної інформації'
  RETURNING id
)
INSERT INTO question_options (question_id, option_text, is_correct, order_index)
VALUES
  ( (SELECT id FROM inserted_question), 'Первинна структура вуглеводів', false, 0 ),
  ( (SELECT id FROM inserted_question), 'Вторинна структура вуглеводів', false, 1 ),
  ( (SELECT id FROM inserted_question), 'Первинна структура ліпідів', false, 2 ),
  ( (SELECT id FROM inserted_question), 'Первинна структура полінуклеотидів', false, 3 ),
  ( (SELECT id FROM inserted_question), 'Первинна структура білка', true, 4 )
;

COMMIT;