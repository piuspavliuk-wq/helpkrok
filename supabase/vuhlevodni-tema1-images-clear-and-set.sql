-- 1) Очистити всі зображення теми "Вуглеводні та їх галогенопохідні"
-- 2) Призначити зображення точно за списком

UPDATE questions SET image_url = NULL
WHERE topic_id = (
  SELECT t.id FROM topics t
  JOIN courses c ON c.id = t.course_id
  WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні'
);

-- При алкілуванні ароматичних вуглеводнів за Фріделем-Крафтсом як каталізатор використовують: → page1_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page1_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%При алкілуванні ароматичних вуглеводнів за Фріделем-Крафтсом як каталізатор використовують%';

-- Яка із наведених сполук відноситься до нітропохідних вуглеводнів? → page2_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page2_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%Яка із наведених сполук відноситься до нітропохідних вуглеводнів%';

-- Сполука відноситься до похідних ароматичних вуглеводнів, не утворює забарвлення з FeCl3, при окисненні утворює бензойну кислоту. Це: → page2_img2.png + page3_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page2_img2.png,/test-images/organic/tema1/page3_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%Сполука відноситься до похідних ароматичних вуглеводнів, не утворює забарвлення з FeCl3%';

-- За яких умов відбувається реакція галогенування толуолу з утворенням бензилхлориду (механізм SR)? → page7_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page7_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%реакція галогенування толуолу з утворенням бензилхлориду (механізм SR)%';

-- Яка якісна реакція підтверджує ненасиченість лінолевої кислоти? → page8_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page8_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%Яка якісна реакція підтверджує ненасиченість лінолевої кислоти%';

-- Вкажіть продукти при дегалогенуванні віцинальних... (перше питання, order_index 35) → page9_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page9_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%дегалогенуванні віцинальних дигалогеналканів при дії металів (цинку або магнію)%' AND order_index = 35;

-- Яка з наведених нижче сполук належить до аліфатичних? → page9_img2.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page9_img2.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%Яка з наведених нижче сполук належить до аліфатичних%';

-- Вкажіть продукти при дегалогенуванні віцинальних... (друге питання, order_index 38) → page10_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page10_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%дегалогенуванні віцинальних дигалогеналканів при дії металів (цинку або магнію)%' AND order_index = 38;

-- Серед наведених структурних формул гетероциклічних сполук виберіть бензо-1,4-діазепін: → page11_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page11_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%бензо-1,4-діазепін%';

-- Який вид таутомерії характерний для гетероциклічних сполук із двома гетероатомами? → page12_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page12_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%таутомерії характерний для гетероциклічних сполук із двома гетероатомами%';

-- Які два гетероциклічні кільця містить у своєму складі вітамін В1 (тіамін)? → page13_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page13_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%вітамін В1 (тіамін)%';

-- Які продукти реакції, що утворюються за механізмом радикального заміщення вказані на нижченаведеній схемі перетворень? → page13_img2.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page13_img2.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%радикального заміщення вказані на нижченаведеній схемі перетворень%';

-- Укажіть положення в молекулі піразолу, за яким проходять реакції електрофільного заміщення. → page14_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page14_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%молекулі піразолу%';

-- За якою реакцією і механізмом відбувається перетворення толуолу на бромметилбензол? → лише page14_img2.png (одне зображення)
UPDATE questions SET image_url = '/test-images/organic/tema1/page14_img2.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%перетворення толуолу на бромметилбензол%';

-- Продуктами реакції нітрування толуолу переважно будуть: → page14_img3.png + page15_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page14_img3.png,/test-images/organic/tema1/page15_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%Продуктами реакції нітрування толуолу переважно будуть%';

-- Укажіть положення в молекулі індолу, за яким проходить реакція його нітрування. → page16_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page16_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%молекулі індолу, за яким проходить реакція його нітрування%';

-- Вкажіть положення, за яким переважно проходить реакція нітрування саліцилової кислоти? → page16_img2.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page16_img2.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%нітрування саліцилової кислоти%';

-- Для схеми перетворень крекінг відбувається на стадії: → page18_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page18_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%крекінг відбувається на стадії%';

-- Яка сполука утворюється під час повного гідрування нафталіну? → page19_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page19_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%гідрування нафталіну%';

-- При гідратації акрилової кислоти утворюється: → page20_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page20_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%гідратації акрилової кислоти%';

-- Для якої з наведених сполук можлива геометрична ізомерія? → page22_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page22_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%геометрична ізомерія%';

-- У разі якого числового значення n виконується правило Хюккеля (4n+2) для нафталіну? → page23_img1.png
UPDATE questions SET image_url = '/test-images/organic/tema1/page23_img1.png'
WHERE topic_id = (SELECT t.id FROM topics t JOIN courses c ON c.id = t.course_id WHERE c.title = 'Основи знань про органічні сполуки' AND t.title = 'Вуглеводні та їх галогенопохідні')
  AND question_text LIKE '%правило Хюккеля (4n+2) для нафталіну%';
