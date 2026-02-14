-- Картинки тільки за номером питання (order_index). БЕЗ зіставлення за текстом.
-- ВАЖЛИВО: порядок питань у БД має збігатися з порядком у PDF (питання 1 = перше в PDF, 2 = друге, тощо).
-- Якщо у вас інший порядок — спочатку видаліть питання цієї теми і імпортуйте їх з PDF скриптом pdf_to_tests_with_images.py.

ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Очистити всі картинки в цій темі
UPDATE questions SET image_url = NULL WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні');

-- Прив'язати картинки за діапазонами order_index (позиційне зіставлення з PDF)
UPDATE questions SET image_url = '/test-images/organic/tema1/page1_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 1 AND 5;
UPDATE questions SET image_url = '/test-images/organic/tema1/page2_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 6 AND 9;
UPDATE questions SET image_url = '/test-images/organic/tema1/page7_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 26 AND 29;
UPDATE questions SET image_url = '/test-images/organic/tema1/page8_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 30 AND 35;
UPDATE questions SET image_url = '/test-images/organic/tema1/page9_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 36 AND 37;
UPDATE questions SET image_url = '/test-images/organic/tema1/page9_img2.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 38 AND 38;
UPDATE questions SET image_url = '/test-images/organic/tema1/page10_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 39 AND 42;
UPDATE questions SET image_url = '/test-images/organic/tema1/page12_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 43 AND 46;
UPDATE questions SET image_url = '/test-images/organic/tema1/page13_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 47 AND 48;
UPDATE questions SET image_url = '/test-images/organic/tema1/page14_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 49 AND 50;
UPDATE questions SET image_url = '/test-images/organic/tema1/page14_img2.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 51 AND 51;
UPDATE questions SET image_url = '/test-images/organic/tema1/page16_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 52 AND 55;
UPDATE questions SET image_url = '/test-images/organic/tema1/page18_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 61 AND 62;
UPDATE questions SET image_url = '/test-images/organic/tema1/page19_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 63 AND 64;
UPDATE questions SET image_url = '/test-images/organic/tema1/page20_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 65 AND 66;
UPDATE questions SET image_url = '/test-images/organic/tema1/page22_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 70 AND 71;
UPDATE questions SET image_url = '/test-images/organic/tema1/page23_img1.png' WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні') AND order_index BETWEEN 72 AND 75;

-- Якщо після виконання картинки все одно не там: порядок питань у БД не збігається з PDF.
-- Тоді видаліть питання цієї теми і імпортуйте заново з PDF:
--   1. Видалити: question_options для цих питань, потім questions де topic_id = тема "Вуглеводні та їх галогенопохідні"
--   2. Запустити: python3 pdf_to_tests_with_images.py "шлях/до/Тема_1_....pdf" > tema1-full.sql
--   3. З tema1-full.sql взяти тільки INSERT INTO questions та question_options (без курсу/теми), виконати в Supabase
