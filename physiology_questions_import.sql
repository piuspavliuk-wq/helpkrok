
-- Створення таблиці для питань фізіології
CREATE TABLE IF NOT EXISTS physiology_questions (
  id SERIAL PRIMARY KEY,
  question_number INTEGER,
  system VARCHAR(100),
  level VARCHAR(50),
  question_text TEXT,
  option_a TEXT,
  option_b TEXT,
  option_c TEXT,
  option_d TEXT,
  correct_answer VARCHAR(10),
  topic VARCHAR(200),
  recommendation TEXT,
  faculty VARCHAR(50) DEFAULT 'medical',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Очищення таблиці перед імпортом
DELETE FROM physiology_questions;

-- Вставка питань

INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  1, 
  'Нервова', 
  'Легке', 
  'Який іон відповідає за деполяризацію нейрона?', 
  'Na⁺', 
  'K⁺', 
  'Ca²⁺', 
  'Cl⁻', 
  'A', 
  'Потенціал дії', 
  'Повтори механізм потенціалу дії', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  3, 
  'Нервова', 
  'Середнє', 
  'Порушення координації рухів — яка структура мозку уражена?', 
  'Мозочок', 
  'Ствол мозку', 
  'Спинний мозок', 
  'Гіпокамп', 
  'A', 
  'Мозочок', 
  'Повтори функції мозочка', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  4, 
  'Нервова', 
  'Важке', 
  'На ЕЕГ пацієнта хвилі високої амплітуди в центральних відділах — що це свідчить?', 
  'Епілепсія', 
  'Порушення сну', 
  'Гідроцефалія', 
  'Інсульт', 
  'A', 
  'Електрофізіологія', 
  'Повтори ЕЕГ-патології', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  5, 
  'Нервова', 
  'Важке', 
  'Параліч дельтоподібного м’яза після травми плечового сплетіння — який нерв пошкоджений?', 
  'Пахвовий', 
  'М’язово-шкірний', 
  'Ліктьовий', 
  'Середній', 
  'A', 
  'Периферичні нерви', 
  'Повтори анатомію плечового сплетіння', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  7, 
  'Серцево-судинна', 
  'Середнє', 
  '"На ЕКГ відсутній зубець P', 
  ' комплекси QRS регулярні — причина?"', 
  'Фібриляція передсердь', 
  'АВ-блокада', 
  'Ектопічний ритм', 
  'Гіперкаліємія', 
  'C', 
  'ЕКГ', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  8, 
  'Серцево-судинна', 
  'Середнє', 
  'Пацієнт має артеріальну гіпертензію — який механізм основний?', 
  'Зниження об’єму плазми', 
  'Підвищення периферичного опору', 
  'Зниження серцевого викиду', 
  'Зниження гормонів наднирників', 
  'B', 
  'Регуляція тиску', 
  'Повтори механізми АТ', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  9, 
  'Серцево-судинна', 
  'Важке', 
  'Хворий із серцевою недостатністю приймає інгібітор АПФ. Основний ефект?', 
  'Підвищення ангіотензину II', 
  'Зниження ангіотензину II', 
  'Зниження калію', 
  'Вазоконстрикція', 
  'B', 
  'Фармакологія', 
  'Повтори ренін-ангіотензинову систему', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  11, 
  'Дихальна', 
  'Легке', 
  'Який газ основний стимул для дихання?', 
  'CO₂', 
  'O₂', 
  'N₂', 
  'H₂', 
  'A', 
  'Регуляція дихання', 
  'Повтори хеморецептори', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  12, 
  'Дихальна', 
  'Середнє', 
  'Зниження еластичності легень — який тип порушення?', 
  'Обструктивний', 
  'Рестриктивний', 
  'Мішаний', 
  'Астматичний', 
  'B', 
  'Фізіологія дихання', 
  'Повтори легеневу комплаєнс', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  13, 
  'Дихальна', 
  'Середнє', 
  'Хворий має задишку та ціаноз. Що свідчить про правошлуночкову недостатність?', 
  'Набряк легень', 
  'Печінковий набряк', 
  'Гіпертензія легеневих судин', 
  'Підвищення венозного тиску', 
  'D', 
  'Клінічна фізіологія', 
  'Повтори прояви правошлуночкової недостатності', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  14, 
  'Дихальна', 
  'Важке', 
  'На спірограмі зниження FEV1/FVC — що це свідчить?', 
  'Обструктивне порушення', 
  'Рестриктивне порушення', 
  'Норма', 
  'Помилковий результат', 
  'A', 
  'Пульмонологія', 
  'Повтори тести функції легень', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  15, 
  'Дихальна', 
  'Важке', 
  'Хворий з ХОЗЛ. Який препарат покращує дихання?', 
  'β2-агоніст', 
  'АСЕ-інгібітор', 
  'Діуретик', 
  'Антибіотик', 
  'A', 
  'Фармакологія дихання', 
  'Повтори бронхолітики', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  16, 
  'Травна', 
  'Легке', 
  'Основний фермент для розщеплення білків у шлунку?', 
  'Пепсин', 
  'Амілоза', 
  'Ліпаза', 
  'Трипсин', 
  'A', 
  'Ферменти травлення', 
  'Повтори шлункове травлення', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  17, 
  'Травна', 
  'Середнє', 
  'Яка речовина стимулює виділення жовчі?', 
  'Секретин', 
  'Холецистокінін', 
  'Гастрин', 
  'Інсулін', 
  'B', 
  'Фізіологія травлення', 
  'Повтори жовчовиділення', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  18, 
  'Травна', 
  'Середнє', 
  'Хворий має кровотечу з варикозних вен стравоходу. Що первинне?', 
  'Гіпертензія портальна', 
  'Гіпертонія', 
  'Гастрит', 
  'Анемія', 
  'A', 
  'Патологія печінки', 
  'Повтори ускладнення портальної гіпертензії', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  19, 
  'Травна', 
  'Важке', 
  'Який маркер у крові специфічний для гепатоцелюлярної карциноми?', 
  'AFP', 
  'CEA', 
  'CA19-9', 
  'PSA', 
  'A', 
  'Онкологія', 
  'Повтори лабораторні маркери', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  20, 
  'Травна', 
  'Важке', 
  'Хворий має діарею та стеаторею — причина?', 
  'Панкреатична недостатність', 
  'Гастрит', 
  'Виразка шлунка', 
  'Коліт', 
  'A', 
  'Ферменти травлення', 
  'Повтори панкреатичну функцію', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  21, 
  'Видільна', 
  'Легке', 
  'Основна функція нирок?', 
  'Фільтрація крові', 
  'Гормональна секреція', 
  'Синтез ферментів', 
  'Енергозабезпечення', 
  'A', 
  'Фізіологія нирок', 
  'Повтори функції нефрону', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  22, 
  'Видільна', 
  'Середнє', 
  'Який гормон підвищує реабсорбцію води в нирках?', 
  'Ангіотензин II', 
  'Альдостерон', 
  'ADH', 
  'Кортизол', 
  'C', 
  'Гормональна регуляція', 
  'Повтори антидіуретичний гормон', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  23, 
  'Видільна', 
  'Середнє', 
  'Хворий з гломерулонефритом — що з’явиться в аналізі сечі?', 
  'Протеїнурія', 
  'Гіперкаліємія', 
  'Гіпоглікемія', 
  'Гематурія', 
  '"A', 
  'D"', 
  'Патологія нирок', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  24, 
  'Видільна', 
  'Важке', 
  'Який тип ниркової недостатності розвивається при обструкції сечових шляхів?', 
  'Преренальна', 
  'Постренальна', 
  'Ренальна', 
  'Мішана', 
  'B', 
  'Патологія нирок', 
  'Повтори типи ниркової недостатності', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  25, 
  'Видільна', 
  'Важке', 
  'Пацієнт із нефротичним синдромом — основний механізм втрати білка?', 
  'Пошкодження клубочків', 
  'Зниження альбуміну в печінці', 
  'Зниження апетиту', 
  'Підвищене руйнування білка', 
  'A', 
  'Патологія нирок', 
  'Повтори нефротичний синдром', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  26, 
  'Ендокринна', 
  'Легке', 
  'Основний гормон підшлункової залози для зниження глюкози?', 
  'Інсулін', 
  'Глюкагон', 
  'Адреналін', 
  'Кортизол', 
  'A', 
  'Гормональна регуляція', 
  'Повтори функції інсуліну', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  27, 
  'Ендокринна', 
  'Середнє', 
  'Пацієнт з гіпотиреозом — який симптом характерний?', 
  'Брадикардія', 
  'Тахікардія', 
  'Пітливість', 
  'Похудання', 
  'A', 
  'Щитоподібна залоза', 
  'Повтори клініку гіпотиреозу', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  28, 
  'Ендокринна', 
  'Середнє', 
  'Який гормон стимулює вивільнення кальцію з кісток?', 
  'Паратгормон', 
  'Кальцитонін', 
  'Вітамін D', 
  'Альдостерон', 
  'A', 
  'Кальцієвий обмін', 
  'Повтори регуляцію кальцію', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  29, 
  'Ендокринна', 
  'Важке', 
  'Хворий має синдром Іценко-Кушинга — причина?', 
  'Надлишок кортизолу', 
  'Недостатність АКТГ', 
  'Гіпотиреоз', 
  'Інсулінова резистентність', 
  'A', 
  'Ендокринопатії', 
  'Повтори клініку та механізм', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  30, 
  'Ендокринна', 
  'Важке', 
  'Пухлина аденогіпофіза → підвищений пролактин. Який ефект у жінок?', 
  'Аменорея', 
  'Гіпоменструація', 
  'Гіперменструація', 
  'Гіпертрихоз', 
  'A', 
  'Гормони гіпофіза', 
  'Повтори механізми гіперпролактинемії', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  31, 
  'Імунна', 
  'Легке', 
  'Основна клітина гуморального імунітету?', 
  'В-лімфоцит', 
  'Т-лімфоцит', 
  'Макрофаг', 
  'Нейтрофіл', 
  'A', 
  'Клітинний імунітет', 
  'Повтори функції B-лімфоцитів', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  32, 
  'Імунна', 
  'Середнє', 
  'Який тип імунітету забезпечує вакцини?', 
  'Активний', 
  'Пасивний', 
  'Природний', 
  'Неспецифічний', 
  'A', 
  'Вакцинація', 
  'Повтори механізм імунізації', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  33, 
  'Імунна', 
  'Середнє', 
  'Хворий з АІСД — дефект?', 
  'CD4⁺ T-лімфоцити', 
  'CD8⁺ T-лімфоцити', 
  'В-лімфоцити', 
  'NK-клітини', 
  'A', 
  'Імунодефіцити', 
  'Повтори механізм імунодефіцитів', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  34, 
  'Імунна', 
  'Важке', 
  'Анафілактичний шок — що відбувається в судинах?', 
  'Масивна вазодилатація', 
  'Вазоконстрикція', 
  'Гіпотонія', 
  'Гіпертонія', 
  'A', 
  'Алергічні реакції', 
  'Повтори механізм анафілаксії', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  35, 
  'Імунна', 
  'Важке', 
  'Хворий з аутоімунним тиреоїдитом — основний механізм?', 
  'Аутоантитіла до тиреоглобуліну', 
  'Інфекція', 
  'Дефіцит йоду', 
  'Недостатність гормонів', 
  'A', 
  'Аутоімунні хвороби', 
  'Повтори аутоімунні механізми', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  36, 
  'Кровотворна', 
  'Легке', 
  '"Основна клітина крові', 
  ' що переносить кисень?"', 
  'Еритроцит', 
  'Лейкоцит', 
  'Тромбоцит', 
  'Плазма', 
  'A', 
  'Формені елементи', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  37, 
  'Кровотворна', 
  'Середнє', 
  'Який гормон стимулює еритропоез?', 
  'Еритропоетин', 
  'Тромбопоетин', 
  'Гепсидин', 
  'Кортизол', 
  'A', 
  'Гормональна регуляція', 
  'Повтори регуляцію кровотворення', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  38, 
  'Кровотворна', 
  'Середнє', 
  'Анемія при дефіциті B12 — який тип?', 
  'Мегалобластна', 
  'Мікроцитарна', 
  'Нормоцитарна', 
  'Гемолітична', 
  'A', 
  'Анемії', 
  'Повтори типи анемій', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  39, 
  'Кровотворна', 
  'Важке', 
  'Гемофілія А — дефект якого фактора?', 
  'VIII', 
  'IX', 
  'VII', 
  'X', 
  'A', 
  'Коагулопатії', 
  'Повтори фактори згортання', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  40, 
  'Кровотворна', 
  'Важке', 
  'Пацієнт із тромбоцитопенією — головний ризик?', 
  'Кровотеча', 
  'Інфекція', 
  'Анемія', 
  'Тромбоз', 
  'A', 
  'Гемостаз', 
  'Повтори клінічні прояви', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  41, 
  'Опорно-рухова', 
  'Легке', 
  'Основний компонент кісткової тканини?', 
  'Колаген', 
  'Актин', 
  'Міозин', 
  'Еластин', 
  'A', 
  'Кісткова тканина', 
  'Повтори склад кістки', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  42, 
  'Опорно-рухова', 
  'Середнє', 
  'Артрит — запалення чого?', 
  'Суставів', 
  'М’язів', 
  'Сухожиль', 
  'Шкіри', 
  'A', 
  'Ревматологія', 
  'Повтори запальні процеси', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  43, 
  'Опорно-рухова', 
  'Середнє', 
  'Хворий з остеопорозом — який лабораторний маркер підвищений?', 
  'Калій', 
  'Кальцій', 
  'Фосфатаза лужна', 
  'Фосфор', 
  'C', 
  'Метаболізм кістки', 
  'Повтори біохімію кістки', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  44, 
  'Опорно-рухова', 
  'Важке', 
  'Локальний остеомієліт — основний збудник?', 
  'Staphylococcus aureus', 
  'E. coli', 
  'Streptococcus pyogenes', 
  'Pseudomonas', 
  'A', 
  'Інфекційні хвороби', 
  'Повтори остеомієліт', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  45, 
  'Опорно-рухова', 
  'Важке', 
  '"Хворий після перелому має інтерпозицію тканин', 
  ' затримка зрощення — що робити?"', 
  'Репозиція', 
  'Фізіотерапія', 
  'Масаж', 
  'Спокій', 
  'A', 
  'Травматологія', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  46, 
  'Репродуктивна', 
  'Легке', 
  '"Основний гормон', 
  ' що стимулює овуляцію?"', 
  'LH', 
  'FSH', 
  'Прогестерон', 
  'Естрадіол', 
  'A', 
  'Гормони репродукції', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  47, 
  'Репродуктивна', 
  'Середнє', 
  'Який етап сперматогенезу — утворення сперматозоїдів?', 
  'Сперміогенез', 
  'Сперматоцитогенез', 
  'Сперматогонія', 
  'Лейдигова клітина', 
  'A', 
  'Гаметогенез', 
  'Повтори чоловічу репродукцію', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  48, 
  'Репродуктивна', 
  'Середнє', 
  'Естроген у жінки — основна функція?', 
  'Розвиток вторинних статевих ознак', 
  'Лютеїнізація', 
  'Овуляція', 
  'Прогестерон', 
  'A', 
  'Гормони', 
  'Повтори функції естрогену', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  49, 
  'Репродуктивна', 
  'Важке', 
  'Ектопічна вагітність — основний ризик?', 
  'Розрив маткової труби', 
  'Викидень', 
  'Прееклампсія', 
  'Плацента преvia', 
  'A', 
  'Гінекологія', 
  'Повтори ускладнення вагітності', 
  'medical'
);
INSERT INTO physiology_questions (
  question_number, system, level, question_text, 
  option_a, option_b, option_c, option_d, 
  correct_answer, topic, recommendation, faculty
) VALUES (
  50, 
  'Репродуктивна', 
  'Важке', 
  'Патогенез ПКЯ — який механізм?', 
  'Гіперандрогенія', 
  'Гіпоестрогенія', 
  'Дефіцит LH', 
  'Надлишок прогестерону', 
  'A', 
  'Ендокринні розлади', 
  'Повтори механізми ПКЯ', 
  'medical'
);

-- Створення індексів для швидкого пошуку
CREATE INDEX IF NOT EXISTS idx_physiology_questions_system ON physiology_questions(system);
CREATE INDEX IF NOT EXISTS idx_physiology_questions_level ON physiology_questions(level);
CREATE INDEX IF NOT EXISTS idx_physiology_questions_faculty ON physiology_questions(faculty);
