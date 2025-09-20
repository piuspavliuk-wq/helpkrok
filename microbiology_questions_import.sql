-- Create microbiology_questions table
CREATE TABLE IF NOT EXISTS microbiology_questions (
    id BIGSERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    option_e TEXT NOT NULL,
    correct_answer CHAR(1) DEFAULT 'A',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлені антитіла до вірусу імунодефіциту людини. Який метод рекомендується для підтвердження діагнозу ВІЛ-інфекції?',
    'Вестернблоту (імуноблотингу)',
    'Електронної мікроскопії',
    'Імуноферментного аналізу',
    'Імунофлюоресценції',
    'Радіоімунного аналізу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вірусу імунодефіциту людини?',
    'Т-хелпери',
    'Гепатоцити',
    'Ендотеліоцити',
    'Епітеліоцити',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'основну ознаку, що характеризує дану родину.',
    'Наявність ферменту зворотньої транскриптази',
    'Містять мінус-РНК',
    'Прості віруси, що вражають тільки людину',
    'Нуклеїнова кислота не інтегрує в геном хазяїна',
    'Реакція імуноферментного аналізу для виявлення антигенів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бляшки та вузли ( саркома Капоши). Виявлена гостра пневмонія, викликана пневмоцистами. Для якого захворювання характерні данні зміни?',
    'СНІД*',
    'сибірка',
    'дифтерія',
    'грип',
    'кір',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'характеризує дану родину.',
    'виявлення антигенів реакцією імуноферментного аналізу',
    'наявність мінус - РНК.',
    '___',
    'відсутність інтеграції нуклеїнової кислоти в геном хазяїна',
    'наявністьфермента зворортньої транскриптази*.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'залежна ДНК-полімераза) каталізує синтез:',
    'ДНК на матриці вірусної і-РНК',
    'Вірусної і-РНК на матриці ДНК',
    'ДНК на вірусній р-РНК',
    'Вірусної ДНК на матриці ДНК',
    'і-РНК на матриці вірусного білка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'взаємодіє з клітинами-мішенями організму. Виберіть серед перерахованих антигени лімфоцитів  людини, з якими комплементарно зв’язується  gp 120 вірусу.',
    'CD 4',
    'CD 3',
    'CD 8',
    'CD 19',
    'CD 28',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'безпосередньо розмножуються в клітинах імунної системи і руйнують їх. Виберіть серед перерахованих ті захворювання, при яких має місце вищезгадане:',
    '* Інфекційний мононуклеоз, СНІД',
    'Туберкульоз, мікобактеріоз',
    'Поліомієліт, гепатит А',
    'Дизентерія, холера',
    'Ку-гарячка, висипний тиф',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ревертази змусила клітину синтезувати вірусну ДНК. В основі цього явища лежить:',
    'Зворотня транскрипція',
    'Зворотня трансляція',
    'Репресія оперона',
    'Дерепресія оперона',
    'Конваріантна реплікація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зниження кількості клітин, що утворюють розетки з еритроцитами барана. Який висновок слід зробити на основі даних аналізу?',
    'Зниження рівня Т-лімфоцитів',
    'Зниження рівня В-лімфоцитів',
    'Зниження рівня натуральних кілерів (NK-клітин)',
    'Зниження рівня системи комлементу',
    'Недостатність клітин- ефекторів гуморального імунітету',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антигенами ВІЛ. Скарги на стан здоров’я відсутні. Про що може свідчити результат ІФА?',
    'Про інфікування ВІЛ',
    'Про захворювання на СНІД',
    'Про перенесене захворювання на СНІД',
    'Про персистенцію ВГВ',
    'Про інфікування ВГВ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'епідермальним стафілококом, В аналізі харкотиння виявлена пневмоциста карінії, у випорожненнях - криптоспоридії, вульгарний протей та гриби роду кандіда. При якому захворюванні зустрічається таке множинне інфікування умовно-патогенними мікроорганізмами?',
    'СНIД',
    'Цукровий діабет',
    'Сепсис',
    'Дисбактеріоз',
    'Медикаментозний агранулоцитоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'якому збудники безпосередньо розмножуються в клітинах імунної системи і руйнують їх. Виберіть серед перерахованих ті захворювання, при яких має місце вищезгадане:',
    'Інфекційний мононуклеоз, СНІД',
    'Туберкульоз, мікобактеріоз',
    'Поліоміеліт, гепатит А',
    'Дизентерія, холера',
    'Ку-гарячка, висипний тиф',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'умовно-патогенними мікроорганізмами?',
    'СНIД',
    'Цукровий діабет',
    'Сепсис',
    'Дисбактеріоз',
    'Медикаментозний агранулоцитоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'позитивний результат ІФА з антигенами ВІЛ. Скарги на стан здоров’я відсутні. Про що  може свідчити позитивний результат ІФА?',
    'Про інфікування ВІЛ',
    'Про захворювання СНІДом',
    'Про інфікування ВГВ',
    'Про  перенесене захворювання СНІДом',
    'О персистенцію ВГВ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'взаємодіє з клітинами-мішенями організму. Виберіть серед перерахованих антигени лімфоцитів  людини, з якими комплементарно зв’язується  gp 120 вірусу.',
    'CD 4',
    'CD 3',
    'CD 8',
    'CD 19',
    'CD 28',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіла до білків gP 120 i gP41. Яку інфекцію у хворого підтверджує цей результат?',
    'ВІЛ-інфекція',
    'НLTV-1- інфекція',
    'TORCH- інфекція',
    'НВV - інфекція',
    'ЕСНО-інфекція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'білків gP120 і gP41. Наявність якої інфекції у хворого підтверджує цей результат?',
    'TORCH-інфекція',
    'HBV-інфекція',
    'ВІЛ-інфекція',
    'HLTV-1-інфекція',
    'ЕНСО-інфекція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'больовим синдромом. Яке дослідження найбільш ефективне для експрес-діагностики оперізуючого лишаю?',
    'РІФ з моноклональними антитілами',
    'Виділення вірусу в культурі клітин',
    'РН',
    'ІФА',
    'РЗК',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'захворювання грипом.Який метод найдостовірніше підтверджує грипозну етіологію пневмонії?',
    'Виявлення антигенів віруса грипу в харкотинні методом ІФА.',
    'Дослідження парних сироваток.',
    'Зараження курячих ембріонів.',
    'Імунолюмінісцентне дослідження мазків-відбитків з носових ходів.',
    'Виявлення антитіл проти гемаглютинінів вірусу грипу.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'профілактичні препарати. Який з них сприятиме формуванню активного специфічного імунітету та є найменш реактогенним?',
    'Субодинична вакцина',
    'Жива вакцина',
    'Вбита вакцина',
    'Донорський гама- глобулін',
    'Лейкоцитарний інтерферон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проводиться експрес-діагностика, яка грунтується на виявленні специфічного вірусного антигену в досліджуваному матеріалі (змив носоглотки). Яку серологічну реакцію використовують для цього?',
    'Реакція імунофлюоресценції',
    'Реакція зв’язування комплементу',
    'Реакція  аглютинації',
    'Реакція преципітації',
    'Реакція опсонізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудника в сироватці крові хворого. В скільки разів повинен зрости титр антитіл з парною сироваткою, щоб результат вважався достовірним?',
    'В 4 рази і більше',
    'В 2 рази',
    'В один раз',
    'В 3 рази',
    'В пів-титру',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'матриксний білок (М) та зовнішні антигени - гемаглютинін (Н) і нейрамінізазу (N). Яким з них належить основна роль у створені імунітету до грипозної інфекції?',
    'Гемаглютинін та нейрамінідаза',
    'Нуклеопротеїдні антигени',
    'Матриксний білок',
    'Полімеразні білки',
    'Нейрамінідаза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'порекомендувати людям для неспецифічної профілактики захворювання?',
    'Лейкоцитарний інтерферон.',
    'Протигрипозну вакцину.',
    'Пеніцилін.',
    'Протигрипозний імуноглобулін.',
    'Протигрипозну сироватку.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'оболонки носових ходів), який взяли від хворого з попереднім діагнозом “грип”. Який експрес-метод дасть змогу виявити специфічний вірусний антиген в досліджуваному матеріалі?',
    'Пряма і непряма РІФ',
    'Прямий і непрямий ІФА',
    'РГГА',
    'РЗНГА',
    'РІА',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проведенні вірусологічного дослідження було застосовано реакцію гемадсорбції. Для виявлення яких вірусів може бути використана ця реакція?',
    'Вірусів, що мають гемаглютиніни',
    'Всіх простих вірусів',
    'Всіх складних вірусів',
    'ДНК-геномних вірусів',
    'Будь-яких вірусів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'заразили культуру клітин мавп (Vero) і мишенят-сисунців; в результаті не виявлено цитопатичного ефекту на культурі клітин, але зареєстрована загибель мишенят-сисунців. Які ентеровіруси могли викликати захворювання у даної дитини?',
    'Коксакі А',
    'Коксакі В',
    'ЕСНО',
    'Поліовіруси',
    'Некласифіковані ентеровіруси 68-71',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тканинних культурах, має гемаглютинуючі властивості та викликає утворення симпластів у культурі клітин. Які ще органи найбільш імовірно можуть бути уражені в наслідок інфекції, викликаної цим вірусом?',
    'Статеві залози',
    'Печінка',
    'Легені',
    'Глоткові мигдалини',
    'Головний мозок',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'можна  перевiрити  формування  пiслявакцинального  iмунiтету?',
    'Серологiчним',
    'Вiрусологiчним',
    'Бактерiологiчним',
    'Бактерiоскопiчним',
    'Алергiчним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'днів, за методом імунної електронної мікроскопії виявлено віруси із двошаровим капсидом і псевдооболонкою, які нагадують дрібні коліщатка із спицями. Які віруси найбільш вірогідно виявлені?',
    'Ротавіруси',
    'Коксакі-віруси',
    'ЕСНО-віруси',
    'Коронавіруси',
    'Реовіруси',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мавпи (Vero) і мишат-сисунків, в результаті не виявлено цитопатичного ефекту на культурі клітин, але зареєстрована загибель мишат-сисунків. Які ентеровіруси могли викликати захворювання у цієї дитини?',
    'Коксакі А',
    'Коксакі В',
    'ЕСНО',
    'Поліовіруси',
    'Некласифіковані  ентеровіруси 68-71',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '- укус кліща. В реакції затримки гемаглютинації виявлено антитіла проти збудника кліщового енцефаліту в розведенні 1 : 20, що не є діагностичним. Вкажіть наступні дії лікаря після одержання вказаного результату:',
    'Повторити дослідження із сироваткою, взятою через 10 днів',
    'Дослідити цю ж сироватку повторно.',
    'Використати чутливішу реакцію.',
    'Повторити дослідження з іншим діагностикумом.',
    'Відхилити діагноз кліщового енцефаліту.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лікар-лаборант поставив діагноз - респіраторно-синцитіальна вірусна інфекція. Які зміни викликає цей вірус у культурі клітин?',
    'Утворення багатоядерних клітин',
    'Круглоклітинна дегенерація',
    'Тотальна деструкція клітинного моношару',
    'Наявність тілець Бабеша-Негрі',
    'Відшарування моно шару',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'рани локалізовані на обличчі. Яку лікувально-профілактичну допомогу потрівбно надати для профілактики сказу?',
    'Розпочати імунізацію антирабічною вакциною',
    'Призначити комбіновану антибіотикотерапію',
    'Терміново ввести вакцину АКДП',
    'Госпіталізувати хворого і тримати під наглядом лікаря',
    'Терміново ввести нормальний гама-глобулін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'метою екстреної специфічної профілактики дитині було введено донорський гамаглобулін. Який вид імунітету було створено при цьому?',
    'Пасивний',
    'Природний',
    'Антитоксичний',
    'Поствакцинальний',
    'Місцевий',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'категорія дітей має природний пасивний імунітет до цього захворювання. Яких саме дітей мав на увазі лікар?',
    'Новонароджені',
    'Старші 14 років',
    'Ті, що перенесли кір на першому році життя',
    'Ті, що отримали планові щеплення',
    'Ті, чиї батьки не хворіли на кір',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тварини. Яку вакцину необхідно ввести для попередження сказу?',
    'Антирабічну вакцину',
    'АКДП',
    'АДП',
    'БЦЖ',
    'ТАВte',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лисицею. Яку допомогу слід надати йому з метою специфічної профілактики сказу?',
    'Введення антирабічної вакцини',
    'Хірургічна обробка рани',
    'Введення антибіотиків',
    'Промивання рани мильним розчином',
    'Обробка рани спиртовим розчином йоду',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тілець Бабеша-Негрі. Джерелом якого захворювання була тварина?',
    'Сказ',
    'Инфекційний мононуклеоз',
    'Грип',
    'Кліщовий енцефаліт',
    'Вітряна віспа',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'внаслідок підвищеного рівня антитіл, переважно IgE, які адсорбуються на поверхні клітин-мішеній – тканинних базофілів (тучних клітин) та базофілів крові?',
    'Анафілаксія',
    'Антитіло-залежна цитотоксичність',
    'Гиперчутливість уповільненого типу',
    'Імунно-комплексна гиперчутливість',
    'Сироваткова хвороба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'почервоніння повік зі сльозотечею. Який тип алергічної реакції за Джелом і Кумбсом розвивається у цьому випадку?',
    'Цитотоксичний',
    'Анафілактичний',
    'Стимулюючий',
    'Імунокомплексний',
    'Гіперчутливості сповільненого типу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'підвищилася до 38 С, з’явилися болі в суглобах, висипка, свербіж. З боку крові спостерігається лейкопенія і тромбоцитопенія. Алергічна реакція якого типу розвинулася в цьому випадку?',
    'Анафілактичного',
    'Стимулюючого',
    'Цитотоксичного',
    'Імунокомплексного',
    'Гіперчутливості уповільненого типу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дослідженні легень виявлено6 у просвіті бронхіол та дрібних бронхів багато слизу з вмістом еозинофілів, склероз між альвеолярних перетинок, розширення просвіту альвеол. Який з механізмів розвитку реакції гіперчутливості має місце?',
    'Цитотоксичний',
    'Цитоліз, обумовлений лімфоцитами',
    '* Реагіновий',
    'Гранульоматоз',
    'Імунокомплексний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обстеження виявлено зменшення Т-лімфоцитів та IgM при нормальному вмісті IgА та ІgG. Який вид патології імунної системи спостерігається у хворого?',
    'Гіпогаммаглобулінемія Брутона',
    'Синдром Шерешевського-Тернера',
    'Спадковий дефіцит системи комплементу',
    'Гіпоплазія тимуса',
    'Комбінований імунодефіцит',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'свербіння та печіння шкіри, набряк губ та повік, кашель зі свистом, став знижуватися артеріальний тиск. Які імуноглобуліни беруть участь у розвитку цієї алергічної реакції?',
    '* IgE і IgG',
    'IgМ і IgD',
    'IgМ і IgG',
    'IgА і IgМ',
    'IgG і IgD',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лапаротомії виявлено венозну гіперемію та набряк очеревини. У мазках-відбитках з очеревини велика кількість лімфоцитів та моноцитів. Який патологічний процес у тварини?',
    'Серозне запалення',
    'Алергійне запалення',
    'Гнійне запалення',
    'Асептичне запалення',
    'Фібринозне запалення',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'введення відзначена виражена гіперемія, ущільнення тканин. Який механізм лежить в основі розвитку даних змін?',
    'Клітинна цитотоксичність',
    'Антитільна цитотосичність',
    'Утворення гранульом',
    'Цитотоксичність реагінового типу',
    'Імунокомплексна цитотоксичність',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'слизових оболонок, припухання лімфатичних вузлів. Яке захворювання розвинулося?',
    'Поліноз',
    'Сироваткова хвороба',
    'Феномен Шварцмана',
    'Феномен Овері',
    'Набряк Квінке',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з''явилаcя папула розміром до 8 мм у диаметрі. Який тип реакції гіперчутливості розвинувся після введення туберкуліну?',
    'Реакція гіперчутливості IV типу',
    'Реакція типу феномен Артюса',
    'Реакція типу сироваткової хвороби',
    'Атопічна реакція',
    'Реакція гіперчутливості ІІ типу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'утворилася папула до 10 мм у діаметрі. Який механізм гіперчутливості лежить в основі розвитку вказаних змін?',
    'Клітинна цитотоксичність',
    'Антитілозалежна цитотоксичність',
    'Імунокомплексна цитотоксичність',
    'Анафілаксія',
    'Гранулематоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'свербіж та печіння тіла, набряк губ та повік, свистячий кашель; став падати артеріальний тиск. Які імуноглобуліни беруть участь в розвитку даної алергічної реакції?',
    'IgE та IgG',
    'IgM та IgG',
    'IgM та IgD',
    'IgA та IgM',
    'IgG та IgD',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'туберкуліну утворилася папула до 10 мм у діаметрі. Який  механізм гіперчутливості лежить в основі розвитку вказаних змін?',
    '*Клітинна цитотоксичність',
    'Гранулематоз',
    'Імунокомплексна цитотоксичність',
    'Антитілозалежна цитотоксичність',
    'Анафілаксія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'температура тіла до 380С, з’явилися біль в суглобах, висипка, свербіж. У крові – лейкопенія і тромбоцитопенія. Який тип алергічної реакції розвинувся?',
    '* Імунокомплексна',
    'Анафілактична',
    'Цитотоксична',
    'Стимулююча',
    'Гіперчутливість уповільненого типу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'що з’явилася нещодавно. Антигістамінні препарати, що їх призначив лікар призводили до деякого покращення стану хворої. Які антитіла могли сприяти розвитку цієї реакції?',
    'Ig E',
    'Ig А',
    'Ig D',
    'Ig G',
    'Ig M',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ароматичних речовин, діагностована атопічна бронхіальна астма. Діагностовано збільшення IgE. Для якого типу реакцій це характерно:',
    'Анафілактичні  реакції',
    'Цитотоксичні реакції',
    'Імунокомплексні реакції',
    'ГСТ',
    'Автоімунні  реакції',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'внаслідок підвищеного рівня антитіл, переважно IgE, які адсорбуються на поверхні клітин-мішеній – тканинних базофілів (тучних клітин) та базофілів крові?',
    'Анафілаксія',
    'Антитіло-залежна цитотоксичність',
    'Гиперчутливість уповільненого типу',
    'Імунно-комплексна гиперчутливість',
    'Сироваткова хвороба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'профілактику (ботулізму). Вкажіть, якіий з перелічених препаратів слід використати ?',
    'Полівалентна антитоксична сироватка.',
    'Інтерферон.',
    'Моновалентна антитоксична сироватка.',
    'Анатоксин.',
    'Плацентарний гама-глобулін.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'при дослiдженнi якої на середовищі Кiтта-Тароцi бактерiолог виявив мiкроорганiзми подiбнi до “тенiсної ракетки”. Збудником якоi хвороби вони могли бути?',
    'Ботулiзму',
    'Сальмонельозу',
    'Дизентерiї',
    'Стафілококової токсикоінфекції',
    'Черевного тифу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ковтанні. Лікар запідозрив ботулізм. Які методи діагностики доцільно використати для підтвердження діагнозу?',
    'Біологічна проба, бактеріологічний',
    'Алергічна проба, серологічний',
    'Бактеріологічний, мікологічний',
    'Протозоологічний, мікроскопічний',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'нарушение глотания, затрудненное дыхание, мышечная слабость. Поставлен диагноз ботулизм. С каким фактором патогенности связаны клинические проявления этого заболевания?',
    'Экзотоксин.',
    'Гемолизин.',
    'Эндотоксин.',
    'Плазмокоагулаза.',
    'Фибринолизин.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ботулінічного токсину. Для цього дослідній групі мишей ввели екстракт із досліджуваного матеріалу та антитоксичну протиботулінічну сироватку типів А,В,Е; контрольній групі мишей ввели екстракт без протиботулінічної сироватки. Яку серологічну реакцію було використано?',
    'Нейтралізації',
    'Преципітації',
    'Зв‘язування комплементу',
    'Опсоно-фагоцитарна',
    'Подвійної імунної дифузії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'гангрена. Яким мікробіологічним методом можна встановити видову належність  збудника?',
    'Бактеріологічним',
    'Алергічним',
    'Бактеріоскопічним',
    'Серологічним',
    'РІА',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріоскопічного дослідження препаратів - мазків і виявлення туберкульозної палички потрібно використати один із методів збагачення, який передбачає обробку харкотиння лише розчином їдкого натру. Як називається такий метод?:',
    'Гомогенізація',
    'Інактивація',
    'Флотація',
    'Фільтрація',
    'Знешкодження',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'запідозрив ботулізм. Які методи діагностики доцільно використати для підтвердження діагнозу?',
    'Біологічну пробу, бактеріологічний',
    'Протозоологічний, мікроскопічний',
    '–',
    'Алергічну пробу, серологічний',
    'Бактеріологічний, мікологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'важкого харчового отруєння, При мікроскопії виділеної на середовищі Кіта-Тароцці культури виявлені мікроорганізми, схожі на тенісну ракетку. Який найбільш вірогідний діагноз?',
    'Ботулізм',
    'Сальмонельоз',
    'Холера',
    'Дизентерія',
    'Черевний  тиф',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікробіологічним методом можна встановити видову приналежність збудника?',
    'Бактеріологічним',
    'РІА',
    'Бактеріоскопічним',
    'Алергічним',
    'Серологічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'протиботулінічну сироватку типів А,В,Е; контрольній групі мишей ввели екстракт без протиботулінічної сироватки. Яку серологічну реакцію було використано?',
    'Нейтралізації',
    'Преципітації',
    'Зв‘язування комплементу',
    'Опсонофагоцитарна',
    'Подвійної імунної дифузії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виду, найбільш вірогідно, відноситься виділений збудник?',
    'Vibrio parahemolyticus',
    'P. mirabilis',
    'Escherichia coli',
    'Proteus vulgaris',
    'C.perfringens',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'параліч дихання. Чим обумовлені такі симптоми ботулізму?',
    'Інвазія Cl. botulinum в епітелій кишечнику',
    'Секреція ентеротоксину',
    'Ендотоксичний шок',
    'Дія нейротоксину',
    'Активація аденілатциклази',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'причиною важкого харчового отруєння, При мікроскопії виділеної на середовищі Кітта-Тароці культури виявлені мікроорганізми схожі на тенісну ракетку. Який діагноз встановить лікар?',
    'Ботулізм',
    'Сальмонельоз',
    'Холера',
    'Дизентерія',
    'Черевний  тиф',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'симптоми харчового отруєння Clostridium botulinum: диплопія, порушення мови та параліч дихання. Чим обумовлені такі симптоми ботулізму?',
    'Дією нейротоксину',
    'Інвазією Cl. вotulinum в епітелій  кишківника',
    'Секрецією ентеротоксина',
    'Ендотоксичним шоком',
    'Активацією аденілатциклази',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'чувствительность его к антибиотикам: пенициллин - зона задержки роста 8 мм; оксациллин - 9 мм; ампициллин - 10 мм; гентамицин - 22 мм; линкомицин - 11 мм. Какой антибиотик необходимо  выбрать для лечения больного?',
    'Гентамицин',
    'Оксациллин',
    'Ампициллин',
    'Пенициллин',
    'Линкомицин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'результати дослідження - діаметр зон затримки росту дорівнює: пенiцилiн - 8 мм, оксацилiн - 8 мм, ампiцилiн - 25 мм, гентамiцин - 22 мм. Який метод дослідження був використаний?',
    'Метод паперових дисків',
    'Метод серійних розведень',
    'Біохімічний',
    'Бактерiоскопiчний',
    'Біометричний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антибіотик. Вкажіть який препарат можна застосувати в даному випадку?',
    'тетрациклін',
    'азитроміцин*',
    'бензилпеніцилін',
    'гентаміцин',
    'левоміцетин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зуби деформовані , уражені карієсом, у шийки коричнева облямівка. З анамензу встановлено, що мати під час вагітності приймала антибіотики без контролю лікаря. Вкажіть антибіотики якої групи, що мають найбільш виражену тератогенну дію, могла приймати мати?',
    'аміноглікозиди',
    'пеніцилін',
    'макроліди',
    'тетрацикліни*',
    'цефалоспорини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'протитуберкульозними засобами',
    'Рифампіцин',
    'Тетрациклін',
    'Кефзол',
    'Левоміцетин',
    'Азітроміцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сіль бензилпеніциліну. Вкажіть механізм дії цього препарату:',
    'Блокада синтезу пептидогліканів мікробної оболонки',
    'Блокада синтезу білків цитоплазми',
    'Блокада синтезу ДНК',
    'Блокада тіолових груп ензимів',
    'Блокада синтезу РНК',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антимікробної дії препарату?',
    'Пригнічення синтезу клітинної стінки мікроорганізмів',
    'Пригнічення внутрішньоклітинного синтезу білка',
    'Пригнічення активності холінестерази',
    'Пригнічення SH-груп ферментів мікроорганізмів',
    'Антагонізм з параамінобензойною кислотою',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'найбільш доцільно призначити в першу чергу?',
    'Ізоніазид',
    'Циклосерін',
    'Етоксид',
    'Сульфален',
    'Етіонамід',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'механізму дії. Який з протитуберкульозних засобів пригнічує в мікобактеріях транскрипцію РНК на ДНК?',
    '* Рифампіцин',
    'ПАСК',
    'Ізоніазид',
    'Етіонамід',
    'Стрептоміцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'засобів, однак у хворого виявлені явища анемії. Який препарат протипоказаний хворому?',
    'Фталазол',
    'Левоміцетин',
    'Ампіцилін',
    'Фуразолідон',
    'Ентеросептол',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сульфаніламідних препаратів слід призначити хворому?',
    'Етазол',
    'Бісептол',
    'Стрептоцид',
    'Сульфацил натрію',
    'Сульфадиметоксин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'використовується як імуномодулятор. Який це препарат?',
    'Фенасол',
    'Пірантел',
    'Левамізол',
    'Нафтамон',
    'Піперазину адипінат',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'гнійною паличкою, чутливою до антибіотика пеніцилінового ряду. Вкажіть. Який з наведених пеніциліні має виражену активність по відношенню до Pseudomonas aeruginosa?',
    'Оксацилін',
    'Бензилпеніцилін',
    'Метицилін',
    'Карбеніцилін',
    'Феноксиметилпеніцилін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'печінки і нирок. Який із зазначених препаратів буде найбільш небажаним для призначення?',
    'Неоміцин',
    'Ампіцилін',
    'Пеніцилін',
    'Левоміцетин',
    'Цефалоксин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'на шкірі, набряк слизових оболонок і порушилась координація рухів. Після відміни препарата стан хворого значно покращився. Який препарат приймав хворий?',
    'стептоміцину сульфат*',
    'бепаск',
    'етамбутол',
    'ізоніазид',
    'рифампіцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'пеніцилін – зона затримки росту 8мм., оксациклін – 9мм., ампіцилін – 10мм., гентаміцин – 22мм., лінкоміцин – 11мм.. Який антибіотик необхідно вибрати для лікування хворого?',
    'пеніцилін',
    'оксациклін',
    'ампіцилін',
    'гентаміцин*',
    'лінкоміцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'загальну слабкість, відсутність апетиту, біль в суглобах. Протягом 10 діб вона лікувалась з діагнозом “Грип”. Але інфекціоніст запідозрив в неї бруцельоз. Якою реакцією можна поставити остаточний діагноз бруцельоз?',
    'Райта',
    'Хедльсона',
    'Імунофлюорестенції',
    'Відаля',
    'Оухтерлоні',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'врачу поставить предварительный диагноз: туляремия. Какой из ниже перечисленных методов является наиболее ранним методом  диагностики и наиболее применим в обычных клинических условиях?',
    'Аллергологический',
    'Биологический',
    'Серологический',
    'РИФ (экспресс-метод)',
    'Бактериологический',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проба використовується для виявлення гіперчутливості до',
    'Бруцеліну',
    'Туберкульну',
    'Альттуберкуліну',
    'Тулярину',
    'Антраксину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'відповідні скарги, лікар запідозрив у нього бруцельоз. Який матеріал забраний у цього хворого, підлягає дослідженню у звичайній мікробіологічній лабораторії?',
    'Сироватка крові',
    'Спинномозкова рідина',
    'Блювотні маси',
    'Сеча',
    'Випорожнення',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'пульс, впав артеріальний тиск. Який препарат міг бути найбільш імовірною  причиною виниклого ускладнення?',
    'Антитоксична сироватка',
    'Сульфаниламид',
    'Антибіотик',
    'Анатоксин',
    'Донорський гама- глобулін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'екстреної специфічної профілактики дитині було введено донорський гамаглобулін. Який вид імунітету було створено при цьому?',
    'Пасивний',
    'Природний',
    'Антитоксичний',
    'Поствакцинальний',
    'Місцевий',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '2.Лептоспирозная вакцина. 3.Вакцина БЦЖ. 4.Адсорбированная коклюшно-дифтерийно- столбнячная вакцина АКДС. 5.Адсорбированный столбнячный анатоксин. Какой иммунитет создают эти препараты.',
    'Искусственный активный',
    'Нестерильный (инфекционный)',
    'Антибактериальный',
    'Искусственный пассивный',
    'Антитоксический',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сироватки, з’явилися висипання на шкірі, які супроводжувались сильним зудом, підвищилася температура тіла до 38ºС, з’явились болі в суглобах. Яку причину цих явищ Ви  передбачаєте?',
    'Сироваткова хвороба',
    'Анафілактична реакція',
    'Атопія',
    'Гіперчутливість сповільненого типу',
    'Контактна алергія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'туберкульозу новонароджених дітей віком 5-7 днів життя. При цьому застосовують вакцину:',
    '*БЦЖ',
    'АКДП',
    'АДП',
    'АД',
    'АКП',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'был поставлен бактериологический диагноз: хеликобактериоз. Какая из особенностей бактерий, выделенных у данного больного, была обязательно учтена при культивировании?',
    'Микроаэрофильность',
    'Наличие фермента уреазы',
    'Колонизация клеток гастрального типа',
    'Отсутствие спор и капсул',
    'Наличие шести полярных жгутиков',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виразки шлунку. Які мікроорганізми мають намір виявити?',
    'Гелікобактер',
    'Лістерії',
    'Лептоспіри',
    'Сальмонелу',
    'Шигелу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'эндоскопічного і бактеріологічного досліджень були виділені бактерії рода Helicobacter. Завдяки якій властивості ці мікроорганізми не гинуть в кислому середовищі шлунка?',
    'Уреазній активності',
    'Каталазній активності',
    'Оксидазной активності',
    'Стійкості до ванкоміцину',
    'Здатності утворювати капсулу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біоптат слизової оболонки в області виразки. З біоптату виготовлений мазок-відбиток, пофарбований за методом Грама; з рештою біоптату проведена проба на уреазну активність. Під час мікроскопії мазка-відбитка виявлені Грам-негативні спіралеподібні мікро-організми, тест на уреазну активність - позитивний. Які бактерії були виявлені?',
    'Helycobacter pylori',
    'Spirilla minor',
    'Shigella flexneri',
    'Treponema pallidum',
    'Campylobacter jeuni',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудника необхідно перевірити цю кров ?',
    'Віруса гепатиту В.',
    'Віруса гепатиту А.',
    'Вірус гепатиту Е.',
    'Ентеровірусів.',
    'Аденовірусів.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'інфікованість  одним із вірусів гепатиту. Який маркер був виявлений?',
    'НВs-АГ',
    'ВНs-АТ',
    'НВс - АГ',
    'НВс-АТ',
    'НВе - АГ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'анти-НBS  антитела. О чем свидетельствует в данном случае положительный результат ИФА?',
    'Перенесенном гепатите В',
    'Остром гепатите В',
    'Остром гепатите С',
    'Хроническом гепатите В',
    'Хроническом гепатите С',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'високочутливі методи .Яку з названих реакцій слід застосувати з вказаною метою?',
    'Твердофазний імуноферментний аналіз',
    'Імуноелектрофорез',
    'Непрямої гемаглютинації',
    'Зв’язування комплементу',
    'Непрямої імунофлуоресценції',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'анти НВsAg+, анти НВsМ-, НСАg+. Який діагноз підтверджується на основі цих даних?',
    'Гепатит С, в анамнезі - гепатит В.',
    'Гепатит С.',
    'Хронічний гепатит В з низькою репликативною активністю.',
    'Рецидив гепатиту В.',
    'Повторне зараження гепатитом В.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лише в клітинах, уже інфікованих одним з перерахованих вірусів:',
    'Вірусом гепатиту В',
    'Вірусом гепатиту А',
    'Вірусом гепатиту Е',
    'Вірусом Епстайна-Барр',
    'Вірусом імунодефіциту людини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'водним фактором. Який вірус гепатита міг викликати спалах захворювань у цьому населеному пункті?',
    'Вірус гепатита Е.',
    'Вірус гепатита С.',
    'Вірус гепатита Д.',
    'Вірус гепатита G.',
    'Вірус гепатита B.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'анти-НВs антитіла. Про що свідчить у цьому випадку позитивний результат ІФА?',
    'Про хронічний гепатит В',
    'Про гострий гепатит С',
    'Про перенесений гепатит В',
    'Про гострий гепатит В',
    'Про хронічний гепатит С',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біль у ділянці печінки. У нього запідозрено гепатит А. Такий діагноз передбачає зараження хворого через:',
    'Продукти харчування',
    'Інфіковану кров',
    'Інфіковану плазму',
    'Укуси комах',
    'Нестерильні шприци',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '.У хворого з жовтяницею отриманні такі данні лабораторного обстеження:HbsAg-? HbeAs-? Анти HBsG+ анти HBsM-  HCAg+. Який діагноз підтверджується на основі цих даних?',
    'повторне зараження гепатитом В',
    'гепатит С',
    'хронічний гепатит В з низькою реплікативною активністю.',
    'рецидив гепатита В',
    'гепатит С,  в анамнезі - гепатит В.*',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вірус гепатиту міг викликати спалах захворювань у цьому населеному пункті?',
    'Е',
    'В',
    'С',
    'G',
    'D',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лише в клітинах, що вже інфіковані одним з вірусів. Який  саме вірус необхідний для розмноження дельта-вірусу?',
    '* Вірус гепатиту В',
    'Вірус гепатиту А',
    'Вірус гепатиту Е',
    'Вірус Епстайна-Барр',
    'Вірус імунодефіциту людини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '2, Зонне – тип I и этеропатогенную кишечную палочку – 055/В5. Как называется такой тип инфекции у данного ребенка?',
    'Смешанная инфекция',
    'Вторичная инфекция',
    'Носительство патогенных бактерий',
    'Суперинфекция',
    'Реинфекция',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'екзотоксин. Про який вид шигел йде мова?',
    'Шигела дизентерії',
    'Шигкла Зоне',
    'Шигела Флекснера',
    'Шигела Бойда',
    'Шигела Нью-Кастла',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'випорож-нення зі слизом і прожилками крові, підвищення температури, слабкість. Лікар запідозрив дизентерію. Який метод лабораторної діагностики найдоцільніше призначити для підтвердження діагнозу?',
    'Бактеріологічний',
    'Серологічний',
    'Мікологічний',
    'Мікроскопічний',
    'Протозоологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'культуральними та біохімічними властивостями віднесена до роду шигел. Яку з названих реакцій доцільно застосувати для серологічної ідентифікації культури?',
    'Аглютинації з діагностичними сироватками',
    'Зв’язування комплементу',
    'Непрямої гемаглютинації',
    'Преципітації',
    'Затримки гемаглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'температуру, частый стул, боли в животе с тенезмами. Врач поставил клинический диагноз “дизентерия?” и направил исследуемый материал /испражнения/ в баклабораторию. Каким методом диагностики врач-бактериолог должен был подтвердить или опровергнуть клинический диагноз?',
    'Бактериологическим',
    'Биологическим',
    'Бактериоскопическим',
    'Серологическим',
    'Аллергическим',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'для встановлення джерела інфекції?',
    'Провести фаготипування виділеної чистої культури',
    'Зробити антибіотикограму',
    'Поставити реакцію преципітації',
    'За допомогою реакції зв”язування комплементу',
    'Поставити реакцію нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наведених методів лабораторної діагностики необхідно назначити?',
    'Бактеріологічний.',
    'Серологічний.',
    'Алергічний.',
    'Біологічний.',
    'Мікроскопічний.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'у хворого виявлені явища анемії. Який препарат протипоказаний хворому?',
    'Фталазол',
    'Левоміцетин',
    'Ампіцилін',
    'Фуразолідон',
    'Ентеросептол',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стадію місцевих змін імовірно йде мова у даного хворого?',
    'Фібринозний коліт',
    'Катаральний коліт',
    'Фолікулярний коліт',
    'Стадія загоєння виразок',
    'Стадія утворення виразок',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'випорожненнях – еритроцити. Аналіз показав наявність дизентерійної флори. Який препарат найкраще призначити хворому?',
    'Бісептол',
    'Фенілсаліцилат',
    'Норсульфазол',
    'Етазол',
    'Фталазол',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'некротичні маси просякнуті фібрином, утворюючи плівку. Слизова та підслизова оболонки по периферії ділянок некрозу повнокровні, набряклі із крововиливами та лейкоцитарною інфільтрацією. Яке захворювання можна передбачити?',
    'Дизентерія',
    'Холера',
    'Черевний тиф',
    'Амебіаз',
    'Сальмонельоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мазку відбитку слизової оболонки виявлені грам негативні палички.Який найбільш вірогідний діагноз?',
    'черевний тиф',
    'дизентерія*',
    'холера',
    'стафілококова кишкова інфекція',
    'сальмонельоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '- зелені нашарування крововиливи; у просвіті кишки слиз , невелика кількість крові; гістологічно - фібринозний коліт. При бактеріологічному дослідженню вмісту кишки висіяно.Який найбільш вірогідний діагноз?',
    'дизентерія*',
    'хвороба крона',
    'холера',
    'ієрсиніоз',
    'сальмонельоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антибіотиків під час бактеріологічного дослідження випорожнення шигели не виявлені. Титр антишигельозних антитіл в РПГА у парних сироватках у даного хворого підвищився в 4 рази. Про що це свідчить?',
    'Підтверджує діагноз дизентерії',
    'Виключає діагноз дизентерії',
    'Переніс дизентерію раніше',
    'Неспецифічна реакція',
    'Вакцинальна реакція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'серологічне дослідження сироватки крові з метою встановлення титру антитіл до шигел. Яку з перелічених реакцій доцільно використати для цього?',
    'Пасивної гемаглютинації',
    'Зв’язування комплементу',
    'Гемолізу',
    'Бактеріолізу',
    'Преципітації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'серологічне дослідження сироватки крові з метою встановлення титру антитіл до шигел. Яку з перелічених реакцій доцільно використати для цього?',
    'Пасивної гемаглютинації',
    'Зв’язування комплементу',
    'Преципітації',
    'Гемолізу',
    'Бактеріолізу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '38ºС, болі в животі, частий рідкий стілець, присутність крові  в калі, лікар клінічно діагностовано бактеріальну дизентерію. Який метод мікробіологічної діагностики доцільно застосувати в даному випадку і який матеріал потрібно взяти від хворого для підтвердження діагнозу?',
    'Бактеріологічний, кал',
    'Бактеріоскопічний, кал',
    'Бактеріоскопічний, кров',
    'Бактеріологічний, сечу',
    'Серологічний, кров',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антибіотиків під час бактеріологічного дослідження випорожнення шигелли не виявлені. Тітр антишигелльозних антитіл в РПГА у парних сироватках у даного хворого виріс в 4 рази. Про що це свідчить?',
    'Підтверджує діагноз дизентерії.',
    'Виключає діагноз дизентерії.',
    'Переніс дизентерію раніше.',
    'Неспецифічна реакція.',
    'Вакцинальнареакція.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дизентерії було призначено провести серологічне дослідження сироватки крові з метою встановлення титру антитіл до шигел. Яку з перелічених реакцій доцільно використати для цього?',
    'Пасивной гемаглютинації',
    'Зв’язування комплементу',
    'Преципітації',
    'Гемолізу',
    'Бактеріолізу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудником. Як називається така форма інфекції?',
    'Реінфекція.',
    'Рецидив.',
    'Суперінфекція.',
    'Персистуюча інфекція.',
    'Хронічна інфекція.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділена Shigella sonnei. Яку з перерахованих серологічних реакцій було застосовано для ідентифікації виділеної чистої культури?',
    'Реакція аглютинації',
    'Реакція преципітації',
    'Реакція зв’язування комплементу',
    'Реакція нейтралізації',
    'Реакція лізису',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ребенка с подозрением на дифтерию и окрашенного по Нейссеру, обнаружены палочки светло-коричневого цвета с темно-синими включениями на концах. Какой структурный элемент микробной клетки выявлен в этом случае?',
    'Зерна волютина.',
    'Споры.',
    'Капсула.',
    'Жгутики.',
    'Ядерная субстанция.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'боли в горле при глотании, одутловатость лица, адинамия, грязно-белые пленки на миндалинах, врач заподозрил дифтерию. Какими микробиологическими методами можно подтвердить предполагаемый диагноз?',
    'Микроскопическим + бактериологическим.',
    'Микроскопическим + аллергологическим.',
    'Микроскопическим + серологическим.',
    'Аллергологическим + серологическим.',
    'Биологическим + серологическим.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біохімічними ознаками ідентичний Corynebacterium diphtheriae, але не утворює екзотоксин. У результаті якого процесу цей мікроорганізм може стати токсигенним?',
    'Фагова конверсія',
    'Культивування на телурітовому середовищі',
    'Пасаж через організм чутливих тварин',
    'Вирощування у присутності антитоксичної сироватки',
    'Хромосомна мутація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'поставить реакцию пассивной  гемагглютинации. Чем необходимо сенсибилизировать эритроциты, чтобы решить поставленную задачу?',
    'Дифтерийным анатоксином',
    'Дифтерийным антитоксином',
    'Антигенами дифтерийной палочки',
    'Противодифтерийной сывороткой',
    'Гемолитической сывороткой',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'затрудне-ним  диханням. Бактеріоскопічне дослідження матеріалу із зіву та дихальних шляхів дозволило попередньо діагностувати дифтерійний круп. Який метод фарбування при цьому був застосований?',
    'Нейссера',
    'Циль-Нільсена',
    'Гнса-Буррі',
    'Пешкова',
    'Ожешки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'студентській групі. Який препарат слід використати для створення штучного активного імунітету?',
    'Дифтерійний анатоксин',
    'Антидифтерійну сироватку',
    'Специфічний імуноглобулін',
    'Вакцина АКДП',
    'Вакцина з вбитих бактерій',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'щоб обгрунтувати необхідність вакцинації. Які дослідження слід провести з такою метою?',
    'Встановити титр антитоксинів в РНГА',
    'Перевірити членів колективу на носійство палички дифтерії',
    'Встановити рівень антитіл проти дифтерійної палички',
    'Перевірити медичну документацію щодо вакцинації',
    'Перевірити стан імунітету щодо дифтерійної палички',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'желтые палочки с синими зернами на концах. Какой способ окраски использован в данном случае?',
    'Нейссера',
    'Леффлера',
    'Циль- Нильсена',
    'Козловского',
    'Романовского',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'провести, щоб переконатись, що даний мікроб є збудником дифтерії у цієї дитини?',
    'Перевірити токсигенність мікроба',
    'Провести фарбування за методом Буррі - Гінса',
    'Виконати посів на кров''яний агар',
    'Заразити кролика',
    'Провести реакцію аглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроскопії мазків з мигдаликів, зафарбованих по методу Нейсера знайдені тонкі палички жовтого кольору з темно-коричневими зернами на кінцях, що розміщуються в вигляді римської цифри п’ять. Яку інфекцію можна запідозрити в цьому випадку?',
    'Дифтерію',
    'Інфекційний мононуклеоз',
    'Лістеріоз',
    'Тонзиліт',
    'Скарлатину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'синього кольору з потовщеннями на полюсах. Який метод фарбування мазків було використано?',
    'Леффлера.',
    'Буррі.',
    'Гінса.',
    'Грама.',
    'Нейссера.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'специфической терапии Вы воспользуетесь?',
    'Противодифтерийной антитоксической сывороткой, антибиотиками',
    'Дифтерийным анатоксином, антибиотиками',
    'Вакциной “Кодивак”, сульфаниламидами',
    'Дифтерийными вакцинами: АКДС, АДС, АД',
    'Дифтерийным бактериофагом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ковтання лікар запідозрив дифтерію та направив матеріал до бактеріологічної лабораторії. На яке диференціально-діагностичне поживне середовище слід засіяти матеріал для виділення збудника дифтерії?',
    'Кров’яно-телуритовий агар',
    'Середовище Ендо',
    'Середовище Плоскирева',
    'Середовище Сабуро',
    'Середовище Левенштейна-Йенсена',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'при спробі видалення якої виникла помірна кровотеча. Бактеріоскопія мазків з мигдалин показала наявність грампозитивних бактерій булавоподібної форми. Які симптоми  можуть виникнути у дитини у найближчі дні, якщо не буде проведене специфічне лікування?',
    'Токсичні ураження серцевого м‘яза, печінки, нирок',
    'Набряк легенів',
    'Дуже сильний нападоподібний кашель',
    'Папульозні висипи на шкірі',
    'Хвильоподібна лихоманка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діаметром 4-5 мм, сірого кольору, радіально посмуговані (у вигляді розеток). Під мікроскопом – грампозитивні палички із булавоподібними потовщеннями на кінцях, що розміщені у вигляді розчепірюваних пальців. Які це мікроорганізми?',
    'Коринебактерії дифтерії',
    'Дифтероїди',
    'Клостридії ботулізму',
    'Стрептококи',
    'Стрептобацили',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлені паличкоподібні бактерії з зернами волютину. Який етіотропний препарат є препаратом вибору в даному  випадку?',
    'Протидифтерійна антитоксична сироватка',
    'Бактеріофаг',
    'Дифтерійний анатоксин',
    'Еубіотик',
    'Інтерферон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'змоченого протидифтерійною антитоксичною сироваткою. Після інкубації посівів в агарі між окремими культурами і смужкою фільтрувального паперу виявлено смужкоподібні ділянки помутніння середовища. Яку імунологічну реакцію було виконано?',
    'Реакцію преципітації в гелі.',
    'Реакцію Кумбса',
    'Реакцію аглютинації',
    'Реакцію кільцепреципітації',
    'Реакцію опсонізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тинкторіальні, культуральні та біохімічні властивості, які виявилися типовими для збудників дифтерії. Яке дослідження необхідно ще провести для видачі висновку про те, що виділена патогенна дифтерійна паличка?',
    'Визначення токсигенних властивостей',
    'Визначення протеолітичних властивостей',
    'Визначення властивості розщеплювати крохмаль',
    'Визначення цистиназної активності',
    'Визначення уреазної активності',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з сірим нальотом на них. При мікроскопії нальоту було виявлено грампозитивні палички розташовані під кутом одна до одної. Про яке захворювання слід думати?',
    'Дифтерія',
    'Ангіна',
    'Скарлатина',
    'Менінгоназофарингіт',
    'Епідемічний паротит',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'при спробі видалення якої виникла помірна кровотеча. Бактеріоскопія мазків з мигдалин показала наявність грампозитивних бактерій булавоподібної форми. Які симптоми  можуть виникнути у дитини у найближчі дні, якщо не буде проведене специфічне лікування?',
    'Токсичні ураження серцевої м‘язи, печінки, нирок',
    'Набряк легенів',
    'Дуже сильний нападоподібний кашель',
    'Папульозні висипи на шкірі',
    'Хвильоподібна лихоманка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлені паличкоподібні бактерії з зернами волютину. Який етіотропний препарат препаратом вибору в даному  випадку?',
    'Протидифтерійна антитоксична сироватка',
    'Бактеріофаг',
    'Дифтерійний анатоксин',
    'Еубіотик',
    'Інтерферон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроорганізмів і вивчені їх морфологічні, тинкторіальні, культуральні і біохімічні властивості, що виявилися типовими для збудників дифтерії. Яке дослідження необхідно ще провести для видачі заключення про те, що виділена патогенна дифтерійна паличка?',
    'Визначення токсигенних властивостей.',
    'Визначення протеолітичних властивостей.',
    'Определение уреазной активності.',
    'Визначення цистиназної активності.',
    'Визначення здатності розщеплювати крохмаль',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фільтрувального паперу, просякнуту антитоксичною дифтерійною сироваткою, а поряд  з нею підсіяли у вигляді бляшок культуру микробів, що вивчається, і завідомо токсигенний штам. Якщо  культура мікробів, що вивчається,  продукує экзотоксин, то утворюються:',
    'Лінії преципітації',
    'Зони гемолізу',
    'Зони дифузного помутніння',
    'Зони лецитовітелазної активності',
    'Кільця преципітації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'змоченого протидифтерійною антитоксичною сироваткою. Після інкубації посівів в агарі між окремими культурами і смужкою фільтрувального паперу виявлено смужкоподібні ділянки помутніння середовища. Яку імунологічну реакцію було виконано?',
    'Реакцію преципітації в гелі.',
    'Реакцію Кумбса.',
    'Реакцію аглютинації.',
    'Реакцію кільцепреципітації.',
    'Реакцію опсонізації.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наведених нижче препаратів необхідно використати з цією метою?',
    'Вакцина АКДП.',
    'Вакцина БЦЖ.',
    'Типоспецифічна сироватка.',
    'Нормальний гама-глобулін.',
    'АДП анатоксин.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'кашлю. Лiкар призначив посiв слизу з носоглотки на середовище КУА. Який мiкроорганiзм передбачається виявити?',
    'Паличку коклюшу',
    'Паличку iнфлюенцii',
    'Лiстерiю',
    'Клебсiелу',
    'Стафiлокок',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '5мм, сірого кольору,  радіально покреслені (у вигляді розеток). Під мікроскопом грампозитивні  палички із булавовидними потовщеннями на кінцях, розміщені у вигляді розтопирених пальців. Які це мікроорганізми?',
    'Коринебактерії дифтерії.',
    'Клостридії ботулізму.',
    'Дифтероїди.',
    'Стрептококи.',
    'Стрептобацил',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'запідозрив дифтерію та направив матеріал до бактеріологічної лабораторії. На яке диференціально- діагностичне поживне середовище слід засіяти матеріал для виділення збудника дифтерії?',
    'Кров’яно-телуритовий агар',
    'Середовище Ендо',
    'Середовище Плоскирева',
    'Середовище Сабуро',
    'Середовище Левенштейна-Йенсена',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'піднебіння, на мигдаликах сірі плівки, які важко відділяються, залишаючи глибокі кровоточиві дефекти тканин. Яке з нижче перерахованих захворювань найбільш ймовірне?',
    'Ангіна Симановського-Венсана',
    'Некротична ангіна',
    'Лакунарна ангіна',
    'Інфекційний мононуклеоз',
    'Дифтерія зіву',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збільшені, темно червоні, вкриті сіро – жовтими плівками, щільно спаяними з поверхнею мигдаликів. Яке запалення розвигнулось в мигдаликах?',
    'крупозне',
    'дифтеричне*',
    'геморагічне',
    'гнійне',
    'катаральне',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фільтрувального паперу, просякнуту антитоксичною дифтерійною сироваткою, а поряд  з нею підсіяли у вигляді бляшок  культуру микробів, що вивчається, і завідомо токсигенний штам. Якщо культура мікробів, що вивчається,  продукує экзотоксин, то утворюються:',
    'Лінії преципітації',
    'Зони гемолізу',
    'Зони дифузного помутніння',
    'Зони лецитовітелазної активності',
    'Кільця преципітації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'чашку Петрі з поживним агаром по обидва боки від розташованої в центрі смужки фільтрувального паперу, змоченого протидифтерійною антитоксичною сироваткою. Після інкубації посівів в агарі між окремими культурами і смужкою фільтрувального паперу виявлено смужкоподібні ділянки помутніння середовища. Яку імунологічну реакцію було виконано?',
    'Реакцію преципітації в гелі.',
    'Реакцію Кумбса.',
    'Реакцію аглютинації.',
    'Реакцію кільцепреципітації.',
    'Реакцію опсонізації.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вилікування було повним. До якої категорії інфекцій можна віднести це нове захворювання?',
    'Рецидив',
    'Суперінфекція',
    'Реінфекція',
    'Аутоінфекція',
    'Вторинна інфекція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ковтання. Лікар запідозрив ботулізм. Які методи діагностики доцільно використати для підтвердження діагнозу?',
    'Біологічну пробу, бактеріологічний',
    'Протозоологічний, мікроскопічний',
    '–',
    'Алергічну пробу, серологічний',
    'Бактеріологічний, мікологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'день стан хворого погіршився, температура підвищилася до 39,6̊С. Чим пояснити погіршення стану хворого?',
    'Приєднанням вторинної інфекції',
    'Реінфекцією',
    'Алергічною реакцією',
    'Нечутливістю збудника до левоміцетину',
    'Дією ендотоксинів збудника',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наслідком.При розтині померлої виявлені чисельні абсцеси легень, субкапсулярні гнійники в нирках, гіперплазія селезінки. Яка форма сепсису виникла у хворої?',
    'Легеневий сепсис',
    'Уросепсис',
    'Септицемія',
    'Хроніосепсис',
    'Септикопіємія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділена культура кишкової палички з антигенною структурою 0-111. Який діагноз можна поставити?',
    'Колі-ентерит',
    'Гастро-ентерит',
    'Холероподібне захворювання',
    'Харчове отруєння',
    'Дизентерієподібне захворювання',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділено кишкову паличку. Як встановити належнiсть   палички до патогенних варіантів?',
    'У реакцiї аглютинацiї з О сироватками',
    'На пiдставi бiохiмiчних властивостей',
    'Шляхом фаготипування',
    'Мікроскопію забарвлених мазків',
    'За характером росту на середовищi Ендо',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фекалій хворого на середовище Ендо виросла велика кількість безбарвних колоній. Який мікроорганізм можна з найбільшою імовірністю ВИКЛЮЧИТИ з числа можливих збудників захворювання?',
    'Escherichia coli',
    'Salmonella enteritidis',
    'Proteus vulgaris',
    'Pseudomonas aeruginosa',
    'Yersinia enterocolitica',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'випорожненнях. Педіатром було запідозрено коліентерит. Яким методом необхідно скористатись для діагностики ентерального ешерихіозу?',
    'Бактеріологічним',
    'Серологічним',
    'Біологічним',
    'Алергічним',
    'Мікроскопічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'кишкової інфекції на середовищі Ендо виросли у великій кількості червоні колонії. Які це можуть бути мікроорганізми?',
    'Стрептококи',
    'Шигели',
    'Ешерихії',
    'Сальмонели',
    'Стафілококи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділена культура кишкової палички з антигенною структурою О-111. Який діагноз можна встановити?',
    'Дизентерієподібне захворювання',
    'Холероподібне захворювання',
    'Гастроентерит',
    'Харчове отруєння',
    'Колі-ентерит',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фекалій, необхідно призначати біологічні препарати, які підкислюють середовище і проявляють антагоністичну дію. Які мікроорганізми для цього придатні?',
    'Клебсієли',
    'Азотобактерії',
    'Серація',
    'Біфідумбактерії',
    'Ентеробактер',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лише до антибіотиків групи аміноглікозидів. Який з перелічених антибіотиків доцільно призначити хворому з лікувальною метою?',
    'Гентаміцин',
    'Метицилін',
    'Еритроміцин',
    'Ністатин',
    'Кефзол',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з’явилась кров у випорожненнях. Педіатром було запідозрено колі ентерит. Яким методом необхідно скористатись для діагностики ентерального ешерихіозу?',
    'Бактеріологічним',
    'Серологічним',
    'Біологічним',
    'Алергічним',
    'Мікроскопічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ознаками коліентериту. Які  дослідження слід провестии для остаточної ідентифікації виділеного збудника?',
    'Вивчити антигенні властивості збудника.',
    'Визначити чутливість до антибіотиків.',
    'Вивчити чутливість до бактеріофагів.',
    'Вивчити біохімічні властивості збудника.',
    'Вивчити вірулентність збудника.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'серологічного дослідження?',
    'Бруцельоз',
    'Черевний тиф',
    'Пратиф А',
    'Паратиф В',
    'Лептоспіроз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'безболісний набряк підшкірної клітковини. У центрі карбункула чорний струп, по периферії везикульозні висипання навколо карбункула. Бактеріологічне дослідження виявило нерухомі стрептобацили, які здатні утворювати капсули. Які мікроорганізми є збудниками даної хвороби?',
    'Bacillus anthracis',
    'Staphylococcus aureus',
    'Bacillus antrhracoides',
    'Bacillus subtilis',
    'Bacillus megaterium',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проведення бактеріологічного методу діагностики. В чому особливість цього методу в даному випадку?',
    'Виділяють чисту культуру від заражених лабораторних тварин',
    'Виділяють чисту культуру на густих живильних середовищах',
    'Виділяють чисту культуру з використанням середовищ збагачення',
    'Ідетифікують виділену культуру за антигенною структурою',
    'Виділяють чисту культуру на рідких живильних середовищах',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'застосовується для виявлення термостабільного антигену збудника сибірки в шкіряній та хутровій сировині?',
    'Преципітації',
    'Зв’язування комплементу',
    'Імунофлюоресценції',
    'Аглютинації',
    'Гемаглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'овоїдної форми з біполярним забарвленням. Гам – негативні. В мазку з бульйонної культури розміщуються ланцюжками, на агарі утворюють колонії Р – форми. Для якого захворювання це характерно?',
    'менінгококовий назофарингіт',
    'туберкульоз',
    'стрептококова ангіна',
    'чума*',
    'дифтерія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біль у суглобах, лихоманку, нездужання, пітливість по ночам. Хворіє близько місяця. Враховуючи скарги та професійний анамнез, лікар запідозрив у нього бруцельоз. Який матеріал, взятий у цього хворого, підлягає дослідженню в звичайній мікробіологічній лабораторії?',
    'Сироватка крові',
    'Спинномозкова рідина',
    'Блювотні маси',
    'Сеча',
    'Випорожнення',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'відвести під житлове будівництво. Однак дослідження грунту показало наявність життєздатних спор збудника особливо небезпечного захворювання. Який із вказаних мікроорганізмів найбільш вірогідно міг зберігатися у грунті протягом такого тривалого часу?',
    'Bacillus anthracis',
    'Francisella tularensis',
    'Brucella abortus',
    'Yersinia pestis',
    'Mycobacterium bovis',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мешканців селища . Для цієї хвороби було притаманне швидке підвищення температуридо 40С. , виражена інтоксикація, збільшення пахвиних лімфовузлів. Упрепаратах мазках з трупного матеріалу виявленні грам негативні палички овоїдної форми  з біполярним забарвленням. Які мікроорганізми є збудниками цього інфекційного захворювання?',
    'стафілокок',
    'збудник сибірки',
    'клостридії',
    'збудник  туляремії',
    'збудник чуми*',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обліку результатів через декілька хвилин після поєднання імунної сироватки та екстракту шкіри було відмічено утворення білуватого кільця. Про що свідчить даний результат?',
    'Наявність антигенів сибірки',
    'Наявність токсину анаеробної інфекції',
    'Наявність збудника бруцельозу',
    'Поверхневого антигену ешеріхій',
    'Вірулентного антигену сальмонел',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіл можна очікувати в першу чергу?',
    'Ig M, IgG',
    'Ig A, IgG',
    'Ig D, IgG',
    'Ig E, IgG',
    'Ig M, Ig А',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хвилини після укусу. За яким типом реакції гіперчутливості вона проходить?',
    'Анафілактичний',
    'Цитотоксичний',
    'Імунокомплексний',
    'Уповільненого типу',
    'Ідіотип-антиідіотип',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'категорія дітей має природний пасивний імунітет до цього захворювання. Яких саме дітей мав на увазі лікар?',
    'Новонароджені',
    'Старші 14 років',
    'Ті, що перенесли кір на першому році життя',
    'Ті, що отримали планові щеплення',
    'Ті, чиї батьки не хворіли на кір',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'трансплантат прижився. Але на 8-му добу трансплантат набряк, змінився його колір і на 11 добу почав відторгатися. Які клітини приймають у цьому участь?',
    'Т-лімфоцити',
    'Еритроцити',
    'Базофіли',
    'Еозинофіли',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'системи їх продукують?',
    'плазматичні*',
    'плазмобласти',
    'Т-супресори',
    'Т- кілери',
    'Т-хелпери',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіл та лейкоцитів у крові. Які речовини зумовили розвиток цих загальних реакцій організму при запаленні?',
    'Мінералокортикоїди',
    'Інтерлейкіни',
    'Соматомедини',
    'Лейкотрієни',
    'Глюкокортикоїди',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'змінені. Під час обстеження на молекулярному рівні виявлено дефект. При якому порушена функція антигенпрезентації імунокомпетентним клітинам. Дефект яких клітин є найбільш імовірним?',
    'Фібробласти, Т-лімфоцити, В-лімфоцити',
    '*Макрофаги, моноцити',
    '0-лімфоцити',
    'NK-клітини',
    'Т-лімфоцити, В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лімфоїднлої тканини, що формує різноманітні структури. Визначте, в якому з органів відбувається антигеннезалежна проліферація та диференціювання лімфоцитів?',
    'Лімфатичні вузли',
    'Тимус',
    'Гемолімфатичні вузли',
    'Мигдалики',
    'Селезінка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ряд інфекцій. У сироватці крові були виявлені IgM до вірусу краснухи. Про що свідчить такий результат?',
    'Первинне зараження жінки',
    'Жінка здорова',
    'Хронічний процес',
    'Загострення хронічного процесу',
    'Повторне інфікування вірусом краснухи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'змінився його колір; на 11 добу почав відторгатися. Які клітини приймають у цьому участь?',
    'Т-лімфоцити',
    'Еритроцити',
    'Базофіли',
    'Еозинофіли',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'трансплантат набряк, змінився його колір; на 11 добу почав відторгатися. Які клітини приймають у цьому участь?',
    'Т-лімфоцити',
    'Ерітроцити',
    'Базофіли',
    'Єозінофіли',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'функціональною активністю Т- і В-лімфоцитів, при обстеженні виявлений дефект на молекулярному рівні, при якому порушена функція антигенпрезентації імунокомпетентним клітинам. Дефект структур яких клітин є можливим?',
    'Макрофаги, моноцити',
    'Т-лімфоцити, В-лімфоцити',
    'NK-клітини',
    'Фібробласти, Т-лімфоцити, В-лімфоцити',
    '0-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'функції антигенпрезентації імунокомпетентним клітинам. Дефект структур яких клітин є можливим?',
    'Макрофаги, моноцити',
    'Т-лімфоцити',
    'В-лімфоцити',
    'Фібробласти',
    '0-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'барана. Який висновок слід зробити на основі даних аналізу?',
    'Зниження рівня Т-лімфоцитів',
    'Зниження рівня В-лімфоцитів',
    'Зниження рівня натуральних кілерів (NK-клітин)',
    'Зниження рівня системи комлементу',
    'Недостатність клітин- ефекторів гуморального імунітету',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'висновок слід зробити аналізуючи результати дослідження?',
    'Зниження рівня Т-лімфоцитів',
    'Зниження рівня натуральних кілерів (NK-клітин)',
    'Зниження рівня системи комплементу',
    'Недостатність клітин-ефекторів гуморального імунітету',
    'Зниження рівня В-лімфоцитів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'більшість із них були розпізнані і знищені клітинами імунної системи, а саме:',
    'Т-лімфоцитами-кілерами',
    'Т-лімфоцитами-супресорами',
    'В-лімфоцитами',
    'Плазмобластами',
    'Стовбуровими клітинами',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'початку реакції відторгнення трансплантату. Який фактор імунної системи відіграє вирішальну роль в цій реакції?',
    'Т-кілери',
    'Інтерлейкін-1',
    'Природні кілери',
    'В-лімфоцити',
    'Т-хелпери',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сполучній тканині будуть порушуватися в першу чергу?',
    'Фагоцитування сторонніх тіл',
    'Утворення попередників Т-лімфоцитів',
    'Перетворення В-лімфоцитів у плазматичні клітини',
    'Опсонізації',
    'Фагоцитування антигенів макрофагами',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'набряк, змінився його колір і на 11 добупочаі відторгатися. Які клітини беруть у цьому участь?',
    'Т-лімфоцити',
    'Еритроцити',
    'В-лімфоцити',
    'Еозинофіли',
    'Базофіли',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'імунної системи виробляють імуноглобуліни?',
    'Плазматичні',
    'Т-хелпери',
    'Т-кілери',
    'Т-супресори',
    'Плазмобласти',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '2, Зонне – тип I и этеропатогенную кишечную палочку – 055/В5. Как называется такой тип инфекции у данного ребенка?',
    'Смешанная инфекция',
    'Вторичная инфекция',
    'Носительство патогенных бактерий',
    'Суперинфекция',
    'Реинфекция',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріями. Яка найбільш імовірна форма цієї інфекції?',
    'Вторинна інфекція',
    'Реінфекція',
    'Суперінфекція',
    'Персистуюча інфекція',
    'Госпітальна інфекція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'излечился, снова заболел гонореей. В данном случае можно говорить о',
    'реинфекции',
    'микст-инфекции',
    'рецидиве',
    'суперинфекции',
    'вторичной инфекции',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ранее он перенес гонорею и излечение было полным. К какой категории инфекций можно отнести это новое заболевание?',
    'Реинфекция.',
    'Суперинфекция.',
    'Рецидив',
    'Вторичная инфекция.',
    'Аутоинфекция',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'переносник кліщ роду Alectorobius. Як можна назвати таку інфекцію?',
    'Эндемічною',
    'Экзотичною',
    'Спорадичною',
    'Пандемічною',
    'Эпідемічною',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудником. Як називається така форма інфекції?',
    'Реінфекція.',
    'Рецидив.',
    'Суперінфекція.',
    'Персистуюча інфекція.',
    'Хронічна інфекція.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностики була поставлена розгорнута реакція з коклюшним та паракоклюшним діагностикумами. На дні пробірок, до яких було внесено  діагностикум з Bordetella parapertussis, утворився зернистий осад. Які антитіла виявила ця реакція?',
    'Аглютиніни',
    'Преципітини',
    'Опсоніни',
    'Бактеріолізіни',
    'Антитоксини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наведених нижче препаратів необхідно використати з цією метою?',
    'Вакцина АКДП.',
    'Вакцина БЦЖ.',
    'Типоспецифічна сироватка.',
    'Нормальний гама-глобулін.',
    'АДП анатоксин.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'напад спастичного кашлю. Подібна картина спостерігалася в старшої дитини дошкільного віку місяць тому. Лікар запідозрив кашлюкову інфекцію. Яким методом можна провести ретроспективну діагностику цього захворювання?',
    'Серологічним',
    'Бактеріологічним',
    'Біологічним',
    'Мікроскопічним',
    'Молекулярно-біологічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'кашлю. Лiкар призначив посiв слизу з носоглотки на середовище КУА. Який мiкроорганiзм передбачається виявити?',
    'Паличку коклюшу',
    'Паличку iнфлюенцii',
    'Лiстерiю',
    'Клебсiелу',
    'Стафiлокок',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'воспаление внутренних органов, сепсис, образование сине-зеленого гноя, как правило, устойчив к большинству антибиотиков:',
    'Pseudomonas aeruginosa',
    'Proteus vulgaris',
    'Staphylococcus aureus',
    'Streptococcus mutants',
    'Escherichia coli',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мiкроорганiзми,  що  утворюють  на  мясо-пептонному  агарi  жовто-зелений  пiгмент  i характерний  запах.  Як  вони називаються?',
    'Псевдомонади',
    'Ешерiхiї',
    'Протеї',
    'Клебсiєли',
    'Азотобактерiї',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'матеріал для дослідження необхідно взяти від хворого і на яке середовище  його слід засіяти?',
    'Кров, цукровий бульон',
    'Ліквор, сироватковий агар',
    'Сечу, м’ясо-пептонний бульон',
    'Гній, жовточно-сольовий агар',
    'Пунктат лімфовузла, цистеїновий агар.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'грамнегативних паличок. При  посіві виросли колонії слизового характеру, які утворювали зелений, розчинний пігмент. Який мікроорганізм, ймовірно, є причиною захворювання?',
    'Pseudomonas aeruginosa',
    'Escherihia coli',
    'Klebsiella pneumoniae',
    'Proteus mirabilis',
    'Salmonella enteritidis',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сечовипускання. Після бактеріологічного дослідження сечі виявлені грамнегативні  оксидазо-позитивні палочковидні бактерії, що утворюють мукоїдні колонії зеленуватого кольору зі специфічним запахом. Про який збудник можна думати?',
    'Pseudomonas aeruginosa',
    'Proteus mirabilis',
    'E. coli',
    'Str. pyogenes',
    'Mycoplasma pneumonie',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроорганізм, найбільш вірогідно, є причиною захворювання?',
    'Pseudomonas aeruginosa',
    'Escherihia coli',
    'Klebsiella pneumoniae',
    'Proteus mirabilis',
    'Salmonella enteritidis',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'частому нагноєнні післяопераційних ран. При бактеріологічному дослідженні гною був виділений золотистий стафілокок. Яке дослідження треба використати для виявлення джерела цього збудника серед персоналу відділення?',
    'Фаготипування',
    'Мікроскопічний',
    'Серологічна ідентифікація',
    'Визначення чутливості до антибіотиків',
    'Біохімічна ідентифікація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сечовипускання. Після бактеріологічного дослідження сечі виявлені грамнегативні оксидаза-позитивні паличкоподібні бактерії, що утворюють мукоїдні колонії зеленуватого кольору зі специфічним запахом. Про який збудник можна думати?',
    'Pseudomonas aeruginosa',
    'Proteus mirabilis',
    'E. coli',
    'Str. pyogenes',
    'Mycoplasma pneumonie',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'роста микроорганизмов на специальных питательных средах не обнаружено. Какие методы диагностики следует применить чтобы подтвердить или опровергнуть диагноз хронической гонореи?',
    'Поставить РСК, аллергическую кожную пробу с гонококковым аллергеном',
    'Определить титр антител в сыворотки крови больного, используя РПГА',
    'Биологический метод',
    'Иммунную электронную микроскопию',
    'Повторить посев исследуемого материала на дифференциально-диагностические',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ці мікроорганізми проникнуть у кров?',
    'Оболонки мозку',
    'Серцеві клапани',
    'Ниркові гломерули',
    'Статево-сечові шляхи',
    'Лімфатичні вузли',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '(гонорейний кон''юнктивіт). Якими методами лабораторної діагностики слід скористатися для підтвердження діагнозу?',
    'Мікроскопічним та бактеріологічним',
    'Серологічним та алергічним',
    'Біологічним та методом фагодіагностики',
    'Біологічним та алергічним',
    'Мікроскопічним та серологічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лабораторної діагностики найбільш раціональний для підтвердження діагнозу?',
    'Бактеріологічний',
    'Біологічний',
    'Серологічний',
    'Мікроскопічний',
    'Алергічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вміщує велику кількість лейкоцитів. Якою із серологічних реакцій слід скористатися для експрес-діагностики захворювання?',
    'Реакцією преципітації',
    'Реакцією аглютинації',
    'Реакцією зв''язування коиплементу',
    'Реакцією гемаглютинації',
    'Реакцією нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'колонiї. При мiкроскопiї препаратiв з них виявленi грамнегативнi бобовиднi диплококи. Збудником якої хвороби вони являються?',
    'Гонореї',
    'Хламiдiозу',
    'Сифiлiсу',
    'Туляремiї',
    'Мелiоїдозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'гонореей. В данном случае можно говорить о',
    'реинфекции',
    'микст-инфекции',
    'рецидиве',
    'суперинфекции',
    'вторичной инфекции',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'блювота без попередження нудотою, герпетичні висипи на обличчі, лихоманка. На підставі бактеріологічних досліджень якого патологічного матеріалу можливе підтвердження попереднього діагнозу цереброспінальний менінгіт ?',
    'Пункція спинно - мозгової рідини, яка витікає під тиском і має неприємний запах',
    'Виділення урінокультур N.meningitidis',
    'Виділення копрокультур   N. Meningitidis',
    'Дослідження блювоти',
    'Виділення бактерій N. Meningitidis  з слизової оболонки сечостатевої системи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фарбуваалися  негативно, нагадували кавові зернини. Розташовувалися в лейкоцитах. До збудників якої хвороби їх  віднести?',
    'Гонорея',
    'Сифіліс',
    'Венеричний  лімфогранулематоз',
    'М''який шанкр',
    'Трихомонадоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хронічну гонорею. Яку реакцію слід поставити для виявлення прихованого токсоплазмозу і хронічної гонореї у цього хворого?',
    'РЗК',
    'Імуноблотингу',
    'РЗПГА',
    'РЗНГА',
    'РІФ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'знаходилися всередині лейкоцитів. Збудниками якої хвороби є ці мікроорганізми?',
    'М’який шанкр',
    'Меліоїдоз',
    'Венеричний лімфогранульоматоз',
    'Гонорея',
    'Сифіліс',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'повнокровна, жовто-зеленого кольору, просочена гнійним та фібринозним ексудатом, що нагадує чіпець. Для якого захворювання характерна така картина?',
    'Туберкульозний менінгіт',
    'Менінгіт при сибірці',
    'Менінгіт при висипному тифі',
    'Грипозний менінгіт',
    'Менінгококовий менінгіт',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'для лікування гонореї є фторхінолони, хворому необхідно призначити:',
    'Фторурацил',
    'Цефазолін',
    'Фуразолідон',
    'Ципрофлоксацин',
    'Уросульфан',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'засіяно на середовище Ендо. Через 18 годин на поверхні середовища виросли середніх розмірів, круглі, слабовипуклі червоні колонії з металевим блиском. Яке дослідження дає можливість виявити патогенну кишкову паличку серед цих колоній?',
    'Реакція аглютинації з сумішшю ОВ-сироваток патогенних серогруп',
    'Забарвлення мазка за методом Грама',
    'Визначення рухливості мікроорганізмів',
    'Відсів мікроорганізмів на середовище Олькеницького',
    'Фаготипування мікроорганізмів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фарбуваалися  негативно, нагадували кавові зернини, розкладали глюкозу і мальтозу до кислоти, розташовувалися в лейкоцитах. Збудники якої хвороби виявлені?',
    'Гонореї',
    'Сифілісу',
    'Венеричного  лімфогранулематозу',
    'Мякого шанкру',
    'Меліоідозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'колонії. При мікроскопії препаратів з них виявленні грамнегативні бобовидні диплококи. Збудником якої хвороби вони є?',
    'Гонореї',
    'Хламідіозу',
    'Сифілісу',
    'Туляремії',
    'Меліоїдозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'для лікування гонореї є фторхінолони, хворому необхідно призначити:',
    'Ципрофлоксацин',
    'Цефазолін',
    'Уросульфан',
    'Фторурацил',
    'Фуразолідон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вилікування було повним. До якої категорії інфекцій можна віднести це нове захворювання?',
    'Реінфекція',
    'Суперінфекція',
    'Вторинна інфекція',
    'Аутоінфекція',
    'Рецидив',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактерій, які за Грамом фарбуваалися  негативно, нагадували кавові зернини, розкладали глюкозу і мальтозу до кислоти. Розташовувалися в лейкоцитах. До збудників якої хвороби їх віднести?',
    'Гонореї',
    'Сифілісу',
    'Венеричного  лімфогранулематозу',
    'Мякого шанкру',
    'Меліоідозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виросли ніжні голубуваті колонії. При мікроскопії препаратів з них виявленні грамнегативні бобовидні диплококи. Збудником якої хвороби вони є?',
    'Гонореї',
    'Хламідіозу',
    'Сифілісу',
    'Туляремії',
    'Меліоїдозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збереження збудників у матеріалі. Під час бактереоскопічного дослідження встановлено наявність грамнегативних коків, які нагадують кавові зерна та розташовані парами або тетрадами. Назвіть збудника, який був ізольований бактеріологом:',
    'Neisseria meningitidis',
    'Staphilococcus aureus',
    'Neisseria gonorrhoeae',
    'Moraxella lacunata',
    'Acinetobacter calcoaceticus',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'досліджень можна застосувати для підтверджння діагнозу?',
    'Мікроскопія патологічного матеріалу.',
    'Зараження лабораторних тварин',
    'Проба з бактеріофагом.',
    'Реакція гемаглютинації.',
    'Реакція іммобілізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ока. При мікроскопіїї мазка з кон’юктиви ока знайдено велику кількість лейкоцитів та грамнегативні бобовинні диплококи, що знаходилися всередині лейкоцитів. Який збудник є причиною цього захворювання?',
    'Neisseria gonnorrhoeae',
    'Staphylococcus aureus.',
    'Staphylococcus epidermitis',
    'Streptococcus pyogenes',
    'Neisseria catarrhalis.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тріщини. При посіві зішкрябу шкіри на середовище Сабуро виросли пухнасті колонії, білі зверху та зеленувато-жовті внизу. У мазках з верхньої частини колоній видно конідії  у вигляді “дубинок” з 1-5 клітинами. Які ще органи найбільш імовірно може уразити цей збудник?',
    'Нігті',
    'Волосся',
    'Підшкірна клітковина',
    'Лімфатичні судини',
    'Слизова статевих шляхів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обрывки мицелия  гриба, споры, пузырьки воздуха и капельки жира. Для возбудителей какого грибкового заболевания характерна такая микроскопическая картина волоса?',
    'Фавуса',
    'Микроспории',
    'Трихофитии',
    'Эпидермофитии',
    'Споротрихоза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'округлої форми та еліпсоподібні, що брунькуються клітини, розміром 3-6 мкм. Про збудника якої грибкової хвороби може йти мова в даному випадку?',
    'Кандидозу',
    'Кокцидіозу',
    'Епідермофітії',
    'Мікроспорії',
    'Криптококозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'рота, а також язик вкриті щільним білим нальотом. В матеріалі, взятому з місця ураження, бактеріолог виявив наявність грибів дріжжеподібної форми, в зв’язку з цим запідозрили мікоз:',
    'Кандідоз',
    'Фавус',
    'Епідермофітія',
    'Актиномікоз',
    'Трихофітія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ротової порожнини. Висів матеріалу зроблено на середовище Сабуро, відмічено ріст сметаноподібних колоній, бактеріоскопія виявила короткі бруньковані нитки, до збудників якої інфекції відносять ізольовані мікроорганізми ?',
    'Мікози',
    'Спірохетози',
    'Рікетсіози',
    'Мікоплазмози',
    'Хламідіози',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'круглі, подовжені ланцюжки  клітин, що брунькуються темно-фіолетового кольору. Про збудника якого захворювання може йти мова?',
    'Кандидоза.',
    'Актиномікоза.',
    'Стрептококової інфекції.',
    'Стафилококової інфекції.',
    'Дифтерії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'молоко, що скипілося. У виготовлених препаратах-мазках знайденi Грам+ овальнi дрiжджоподiбнi клiтини. Якi це збудники?',
    'Гриби роду Кандiда',
    'Стафiлококи',
    'Дифтерiйна паличка',
    'Актиноміцети',
    'Фузобактерії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з’явився білуватий наліт на слизовій  порожнини рота.  Мікроскопічне вивчення мазків, приготованих з нальотів, виявило  крупні,округлої форми, різної величини, грампозитивні мікроорганізми. Що необхідно здійснити  для продовження мікробіологічної діагностики ?',
    'Посів матеріалу на середовище Сабуро',
    'Посів на середовище Плоскірєва',
    'Посів матеріалу на середовище Кітта – Тароцци',
    'Посів матеріалу на середовище Ендо',
    'Посів на жовтково-сольовий агар',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділені грампозитивні великі овальні клітини з брунькуванням, що розташовані хаотично та подовжені клітини, розташовані ланцюжками. Який збудник виділений?',
    'Кандіди',
    'Стрептобактерії',
    'Актиноміцети',
    'Стрептококи',
    'Ієрсінії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фіолетового кольору, видовжені ланцюжки клітин, що брунькуються. Про збудника якого захворювання може йти мова?',
    'Кандидоз',
    'Стафілококова інфекція',
    'Актиномікоз',
    'Стрептококова інфекція',
    'Дифтерія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'порожнини. Висів матеріалу зроблено на середовище Сабуро, відмічено ріст сметаноподібних колоній. Бактеріоскопія виявила короткі брунькова нитки. До збудників якої інфекції відносять ізольовані мікроорганізми?',
    'Мікоплазмоз',
    'Рикетсіоз',
    'Хламідіоз',
    'Спірохетоз',
    'Мікоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'скипілося. У виготовлених препаратах-мазках знайденi Грам(+) овальнi дрiжджоподiбнi клiтини. Якi це збудники?',
    'Гриби роду Кандiда',
    'Стафiлококи',
    'Дифтерiйна паличка',
    'Актиноміцети',
    'Фузобактерії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'середовище потрібно посіяти кров хворого з метою виділення збудника?',
    'Цукрово-пептонний бульйон',
    'М’ясо-пептонний агар',
    'Середовище Плоскірьова',
    'Середовище Бучіна',
    'Жовчно-сольовий агар',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'загальну слабкість, відсутність апетиту, біль в суглобах. Протягом 10 діб вона лікувалась з діагнозом “Грип”. Але інфекціоніст запідозрив в неї бруцельоз. Якою реакцією можна поставити остаточний діагноз бруцельоз?',
    'Райта',
    'Хедльсона',
    'Імунофлюорестенції',
    'Відаля',
    'Оухтерлоні',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'винограду. Які мікроби виявлено?',
    'Стафілококи',
    'Диплококи',
    'Мікрококи',
    'Стрептококи',
    'Тетракоки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'менінгококового носійства. Підберіть метод мікробіологічного  дослідження:',
    'Бактеріологічний',
    'Алергічний',
    'Бактеріоскопічний',
    'Біологічний',
    'Серологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'приготували препарат для мікроскопії. Який метод фарбування препарату використовують для виявлення збудника?',
    'За Цілем-Нильсеном',
    'За Бурі',
    'За Грамом',
    'За Леффлером',
    'За Ожешко',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагнозом “холера”. Який метод мікробіологічної діагностики потрібно використати, щоб підтвердити або відхилити діагноз?',
    'Бактеріологічний',
    'Алергічний',
    'Бактеріоскопічний',
    'Біологічний',
    'Вірусологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлені антитіла до вірусу імунодефіциту людини. Який метод рекомендується для підтвердження діагнозу ВІЛ-інфекції?',
    'Вестернблоту (імуноблотингу)',
    'Електронної мікроскопії',
    'Імуноферментного аналізу',
    'Імунофлюоресценції',
    'Радіоімунного аналізу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'себе хворим протягом трьох днів. Використання, якого метода, дасть змогу підтвердити діагноз?',
    'Виділення гемокультури',
    'Виділення копрокультури',
    'Виділення уринокультури',
    'Виділення білікультури',
    'Виділення розеолокультури',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'захворювання грипом.Який метод найдостовірніше підтверджує грипозну етіологію пневмонії?',
    'Виявлення антигенів віруса грипу в харкотинні методом ІФА.',
    'Дослідження парних сироваток.',
    'Зараження курячих ембріонів.',
    'Імунолюмінісцентне дослідження мазків-відбитків з носових ходів.',
    'Виявлення антитіл проти гемаглютинінів вірусу грипу.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '2, Зонне – тип I и этеропатогенную кишечную палочку – 055/В5. Как называется такой тип инфекции у данного ребенка?',
    'Смешанная инфекция',
    'Вторичная инфекция',
    'Носительство патогенных бактерий',
    'Суперинфекция',
    'Реинфекция',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хроническую гонорею, роста микроорганизмов на специальных питательных средах не обнаружено. Какие методы диагностики следует применить чтобы подтвердить или опровергнуть диагноз хронической гонореи?',
    'Поставить РСК, аллергическую кожную пробу с гонококковым аллергеном',
    'Определить титр антител в сыворотки крови больного, используя РПГА',
    'Биологический метод',
    'Иммунную электронную микроскопию',
    'Повторить посев исследуемого материала на дифференциально-диагностические',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'специфической терапии Вы воспользуетесь?',
    'Противодифтерийной антитоксической сывороткой, антибиотиками',
    'Дифтерийным анатоксином, антибиотиками',
    'Вакциной “Кодивак”, сульфаниламидами',
    'Дифтерийными вакцинами: АКДС, АДС, АД',
    'Дифтерийным бактериофагом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'среды обнаружен рост- нежная пленка. Для возбудителя какого заболевания характерны такие культуральные свойства?',
    'Возбудителя холеры',
    'Возбудителя чумы',
    'Возбудителя туберкулеза',
    'Возбудителя дизентерии',
    'Возбудителя псевдотуберкулеза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обнаружены. Можно ли повысить вероятность бактериоскопического oбнаружения возбудителя в мокроте? Если да, то какими методами.',
    'Методами обогащения исследуемого материала (цетрифугированием флотацией)',
    'Биологическим методом',
    'Посевом материала в среды обогащения',
    'Методом иммуноферментного анализа',
    'Серологическими методами',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'врачу поставить предварительный диагноз: туляремия. Какой из ниже перечисленных методов является наиболее ранним методом  диагностики и наиболее применим в обычных клинических условиях?',
    'Аллергологический',
    'Биологический',
    'Серологический',
    'РИФ (экспресс-метод)',
    'Бактериологический',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'был поставлен бактериологический диагноз: хеликобактериоз. Какая из особенностей бактерий, выделенных у данного больного, была обязательно учтена при культивировании?',
    'Микроаэрофильность',
    'Наличие фермента уреазы',
    'Колонизация клеток гастрального типа',
    'Отсутствие спор и капсул',
    'Наличие шести полярных жгутиков',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'черевний тиф, було виявлено Salmonella typhi у кількості 102/г. Як найбільш точно охарактеризувати стан обстеженої жінки?',
    'Бактерионосійство',
    'Дисбактериоз',
    'Реінфекція',
    'Суперінфекція',
    'Рецидив',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'організмі є живі бактерії вакцинного штаму. Як найбільш правильно назвати такий вид імунітету?',
    'Нестерильний',
    'Гуморальний',
    'Типоспецифічний',
    'Природжений',
    'Перехресний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сечі. При мікроскопії знайдено кислотостійкі бактерії, але за методом Прайса корд-фактор не виявлений. Яке дослідження дозволить найбільш надійно підтвердити або спростувати попередній діагноз?',
    'Зараження лабораторних тварин',
    'Вивчення токсигенності',
    'Фаготипування виділеної культури',
    'Серологічна ідентифікація збудника',
    'Шкірна алергічна проба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'назофарінгіт, виявлені Гр- диплококи, схожі за формою на кавові зерна. Які органи дитини найбільш імовірно будуть уражені, якщо ці мікроорганізми проникнуть у кров?',
    'Оболонки мозку',
    'Серцеві клапани',
    'Ниркові гломерули',
    'Статево-сечові шляхи',
    'Лімфатичні вузли',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'використати для профілактики ускладнень?',
    'Пеніцилін',
    'Стрептококовий анатоксин',
    'Стрептококовий бактеріофаг',
    'Донорський гама-глобулін',
    'Аутовакцина',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'відшаровується, з‘явилися тріщини. При посіві зішкрябу шкіри на середовище Сабуро виросли пухнасті колонії, білі зверху та зеленувато-жовті внизу. У мазках з верхньої частини колоній видно конідії  у вигляді “дубинок” з 1-5 клітинами. Які ще органи найбільш імовірно може уразити цей збудник?',
    'Нігті',
    'Волосся',
    'Підшкірна клітковина',
    'Лімфатичні судини',
    'Слизова статевих шляхів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'профілактичні препарати. Який з них сприятиме формуванню активного специфічного імунітету та є найменш реактогенним?',
    'Субодинична вакцина',
    'Жива вакцина',
    'Вбита вакцина',
    'Донорський гама- глобулін',
    'Лейкоцитарний інтерферон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тканинних культурах, має гемаглютинуючі властивості та викликає утворення симпластів у культурі клітин. Які ще органи найбільш імовірно можуть бути уражені в наслідок інфекції, викликаної цим вірусом?',
    'Статеві залози',
    'Печінка',
    'Легені',
    'Глоткові мигдалини',
    'Головний мозок',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бленорею (гонорейний кон''юнктивіт). Якими методами лабораторної діагностики слід скористатися для підтвердження діагнозу?',
    'Мікроскопічним та бактеріологічним',
    'Серологічним та алергічним',
    'Біологічним та методом фагодіагностики',
    'Біологічним та алергічним',
    'Мікроскопічним та серологічним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мутного характеру, яка вміщує велику кількість лейкоцитів. Якою із серологічних реакцій слід скористатися для експрес-діагностики захворювання?',
    'Реакцією преципітації',
    'Реакцією аглютинації',
    'Реакцією зв''язування коиплементу',
    'Реакцією гемаглютинації',
    'Реакцією нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'Із рото-глотки хлопчика, який хворіє на хронічний тонзиліт виділили культуру кокових бактерій. У мазках вони розташовувалися у вигляді ланцюжків. Які це можуть бути бактерії?',
    'Стрептококи',
    'Стафілококи',
    'Ешерихії',
    'Клостридії',
    'Вібріони',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'екзотоксин. Про який вид шигел йде мова?',
    'Шигела дизентерії',
    'Шигкла Зоне',
    'Шигела Флекснера',
    'Шигела Бойда',
    'Шигела Нью-Кастла',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено. Яким методом можна підвищити імовірність виявлення мікобактерій в харкотині?',
    'Гомогенізації і флотації',
    'Прайса і Школьнікової',
    'Темнопільна мікроскопія',
    'Мікроскопія препаратів, пофарбованих за Циль-Нільсеном',
    'Мікроскопія нативних мікропрепартів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'кров''яно-слизистий характер виявлені мікроорганізми округлої форми, в цитоплазмі яких містяться еритроцити, а також цисти дрібних розмірів з 4 ядрами. Про який збудник йде мова?',
    'Entamoeba hystolitica',
    'Entamoeba coli',
    'Lamblia intestinalis',
    'Trichomonas intestinalis',
    'Leichmania donovani',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділена культура кишкової палички з антигенною структурою 0-111. Який діагноз можна поставити?',
    'Колі-ентерит',
    'Гастро-ентерит',
    'Холероподібне захворювання',
    'Харчове отруєння',
    'Дизентерієподібне захворювання',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проведено мікроскопічне дослідження мокротиння, з метою виявлення збудника. Який метод забарвлення доцільно використати при цьому?',
    'Метод Ціля-Нільсена',
    'Метод Грама',
    'Метод Буррі-Гінса',
    'Метод Романовського-Гімза',
    'Метод Нейссера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностики була поставлена розгорнута реакція з коклюшним та паракоклюшним діагностикумами. На дні пробірок, до яких було внесено  діагностикум з Bordetella parapertussis, утворився зернистий осад. Які антитіла виявила ця реакція?',
    'Аглютиніни',
    'Преципітини',
    'Опсоніни',
    'Бактеріолізіни',
    'Антитоксини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'та блювоту, біль у м''язах ніг, слабкість, запаморочення. Після огляду лікар виставив попередній діагноз "холера". Як необхідно досліджувати матеріал від хворого для експрес діагнозу?',
    'Пряма і непряма РІФ',
    'РА',
    'Бактеріологічним методом',
    'Серологічним методом',
    'Біологчним методом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудника необхідно перевірити цю кров ?',
    'Віруса гепатиту В.',
    'Віруса гепатиту А.',
    'Вірус гепатиту Е.',
    'Ентеровірусів.',
    'Аденовірусів.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'частий пульс, впав артеріальний тиск. Який препарат міг бути найбільш імовірною причиною виниклого ускладнення?',
    'Антитоксична сироватка',
    'Сульфаниламид',
    'Антибіотик',
    'Анатоксин',
    'Донорський гама- глобулін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'профілактику (ботулізму). Вкажіть, якіий з перелічених препаратів слід використати ?',
    'Полівалентна антитоксична сироватка.',
    'Інтерферон.',
    'Моновалентна антитоксична сироватка.',
    'Анатоксин.',
    'Плацентарний гама-глобулін.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'характеризующееся острым началом, тошнотой, рвотой, поносом. При микроскопии мазков, приготовленных из творога и рвотных мас обнаружены грамположительные микроорганизмы, располагающиеся в мазках в виде скоплений, напоминающих гроздья винограда. Какими будут Ваши последующие действия по установлению этиологии этой вспышки пищевой интоксикации ?',
    'Дополнительно провести бактериологический метод исследования.',
    'Сделать заключение о том, что причиной заболеваний стал стафилококк.',
    'Дополнительно поставить аллергическую пробу.',
    'Дополнительно определить антитела в сыворотке крови.',
    'Дополнительно определить фаготип стафилококка.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'нiжнi голубоватi колонiї. При мiкроскопiї препаратiв з них виявленi грамнегативнi бобовиднi диплококи. Збудником якої хвороби вони являються?',
    'Гонореї',
    'Хламiдiозу',
    'Сифiлiсу',
    'Туляремiї',
    'Мелiоїдозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділено кишкову паличку. Як встановити належнiсть   палички до патогенних варіантів?',
    'У реакцiї аглютинацiї з О сироватками',
    'На пiдставi бiохiмiчних властивостей',
    'Шляхом фаготипування',
    'Мікроскопію забарвлених мазків',
    'За характером росту на середовищi Ендо',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'захворювання.   Який метод мікробіологічної  діагностики слід використати ?',
    'Виділення гемокультури.',
    'Виділення копрокультури.',
    'Виділення урінокультури.',
    'Виділення збудника з ліквора.',
    'Виділення білікультури.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'препаратом вибору в даному випадку?',
    'Еубіотик.',
    'Антибіотик.',
    'Інтерферон.',
    'Бактеріофаг.',
    'Полівітаміни.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ребенка с подозрением на дифтерию и окрашенного по Нейссеру, обнаружены палочки светло-коричневого цвета с темно-синими включениями на концах. Какой структурный элемент микробной клетки выявлен в этом случае?',
    'Зерна волютина.',
    'Споры.',
    'Капсула.',
    'Жгутики.',
    'Ядерная субстанция.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'боли в горле при глотании, одутловатость лица, адинамия, грязно-белые пленки на миндалинах, врач заподозрил дифтерию. Какими микробиологическими методами можно подтвердить предполагаемый диагноз?',
    'Микроскопическим + бактериологическим.',
    'Микроскопическим + аллергологическим.',
    'Микроскопическим + серологическим.',
    'Аллергологическим + серологическим.',
    'Биологическим + серологическим.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сутки заболевания подозревают инфекционный мононуклеоз. Какой результат лабораторного обследования может подтвердить диагноз у данного студента в день госпитализации?',
    'Выявление Ig M-антител к вирусу Эпштейн-Барр.',
    'Выявление Ig M-антител к вирусу простого герпеса.',
    'Выявление 4-х кратного нарастания антител к вирусу Эпштейн-Барр.',
    'Изоляция (выделение) вируса герпеса.',
    'Обнаружение антител к цитомегало-вирусу.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виразки шлунку. Які мікроорганізми мають намір виявити?',
    'Гелікобактер',
    'Лістерії',
    'Лептоспіри',
    'Сальмонелу',
    'Шигелу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'можна  перевiрити  формування  пiслявакцинального  iмунiтету?',
    'Серологiчним',
    'Вiрусологiчним',
    'Бактерiологiчним',
    'Бактерiоскопiчним',
    'Алергiчним',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'при дослiдженнi якої на середовищі Кiтта-Тароцi бактерiолог виявив мiкроорганiзми подiбнi до “тенiсної ракетки”. Збудником якоi хвороби вони могли бути?',
    'Ботулiзму',
    'Сальмонельозу',
    'Дизентерiї',
    'Стафілококової токсикоінфекції',
    'Черевного тифу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біохімічними властивостями він відноситься до роду Salmonella. Яка ознака збудника дозволить найбільш точно встановити його видову приналежність?',
    'Антигенна структура',
    'Фаготип',
    'Культуральні властивості',
    'Патогенність для лабораторних тварин',
    'Морфо-тинкторіальні властивості',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'інфікованість  одним із вірусів гепатиту. Який маркер був виявлений?',
    'НВs-АГ',
    'ВНs-АТ',
    'НВс - АГ',
    'НВс-АТ',
    'НВе - АГ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'птогенетичних впливів є основною  причиною зневоднення.',
    'Активація аденілатциклази',
    'Відщеплення нейрамінової  кислоти',
    'Деструкція гіалуронової кислоти',
    'Дефект фосфоліпідів мембран',
    'Деструкція муцину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'розташованъ короткими ланцюжками.      Який з перелічених мікроорганізмів знайдено в мазках з мигдалин?',
    'Стрептококи',
    'Стафілококи',
    'Мікрококи',
    'Диплококи',
    'Тетракоки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'яких  із перелічених специфічних чинників зумовлена позитивна реакція?',
    'Т-лімфоцити',
    'В-лімфоцити',
    'Антитіла',
    'Еритроцити',
    'Лейкоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'воспаление внутренних органов, сепсис, образование сине-зеленого гноя, как правило, устойчив к большинству антибиотиков:',
    'Pseudomonas aeruginosa',
    'Proteus vulgaris',
    'Staphylococcus aureus',
    'Streptococcus mutants',
    'Escherichia coli',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактериальными и грибковыми оппортунистическими инфекциями поставлен диагноз "ВИЧ-инфекция". Результаты какого исследования позволили поставить такой диагноз?',
    'Иммуноферментный анализ.',
    'Реакция связывания комплемента.',
    'Реакция преципитации в геле.',
    'Реакция торможения гемагглютинации.',
    'Реакция пассивной гемагглютинации.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'грам-отрицательные палочки средних размеров с закругленными концами, подвижные, агглютинирующие с сальмонеллезной О-сывороткой группы В. Идентичные микроорганизмы обнаружены в мясном салате, который накануне употребляли все заболевшие. О возбудителях какого заболевания можно думать в данном случае?',
    'Сальмонеллы - возбудители острого гастроэнтерита.',
    'Сальмонеллы - возбудители брюшного тифа.',
    'Сальмонеллы - возбудители паратифа А.',
    'Эшерихии - возбудители пищевой токсикоинфекции.',
    'Протеи - возбудители пищевой токсикоинфекции.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вибрионов. Проведение какой реакции  позволит определить вид микроба, вызвавшего это заболевание?',
    'Агглютинации с сыворотками, содержащими  О-антитела.',
    'Агглютинации с сыворотками, содержащими Н-антитела.',
    'Пассивной гемагглютинации с эритроцитарным антигенным диагностикумом.',
    'Агглютинации Видаля.',
    'Преципитации.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'чувствительность его к антибиотикам: пенициллин - зона задержки роста 8 мм; оксациллин - 9 мм; ампициллин - 10 мм; гентамицин - 22 мм; линкомицин - 11 мм. Какой антибиотик необходимо  выбрать для лечения больного?',
    'Гентамицин',
    'Оксациллин',
    'Ампициллин',
    'Пенициллин',
    'Линкомицин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'результати дослідження - діаметр зон затримки росту дорівнює: пенiцилiн - 8 мм, оксацилiн - 8 мм, ампiцилiн - 25 мм, гентамiцин - 22 мм. Який метод дослідження був використаний?',
    'Метод паперових дисків',
    'Метод серійних розведень',
    'Біохімічний',
    'Бактерiоскопiчний',
    'Біометричний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хаотично розташовані мікроорганізми овоїдної форми довжиною до 2 мкм, інтенсивніше забарвлені на полюсах. Який найбільш імовірний діагноз можна встановити на підставі отриманих даних?',
    'Легенева форма чуми',
    'Пневмококова пневмонія',
    'Стафілококова пневмонія',
    'Клебсієльозна пневмонія',
    'Дифтерія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дослідження. З якою метою слід взяти матеріал у хворого з гнійним ураженням глибоких тканин нижньої кінцівки?',
    'Для встановлення етіології гнійного процесу і визначення чутливості до антибіотиків',
    'Для виявлення патогенного стафілокока і визначення антибіотикограми',
    'Для виявлення збудника, щоб попередити внутрішньолікарняне інфікування',
    'Для підтвердження анаеробної інфекції',
    'Для виявлення токсичності  збудника',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'показник характеризує кількість бактерій групи кишкових паличок, що знаходяться в 1 л води?',
    'Колі-індекс',
    'Колі-титр',
    'Титр колі-фага',
    'Перфрінгенс-титр',
    'Мікробне число',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лікар-лаборант поставив діагноз - респіраторно-синцитіальна вірусна інфекція. Які зміни викликає цей вірус у культурі клітин?',
    'Утворення багатоядерних клітин',
    'Круглоклітинна дегенерація',
    'Тотальна деструкція клітинного моношару',
    'Наявність тілець Бабеша-Негрі',
    'Відшарування моношару',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріями. Яка найбільш імовірна форма цієї інфекції?',
    'Вторинна інфекція',
    'Реінфекція',
    'Суперінфекція',
    'Персистуюча інфекція',
    'Госпітальна інфекція',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'триває три дні, загальну слабість, безсоння, погіршення апетиту. Лікар запідозрив черевний тиф. Який метод лабораторної діагностики найдоцільніше призначити для підтвердження діагнозу?',
    'Виділення гемокультури',
    'Виділення копрокультури',
    'Виділення уринокультури',
    'Виділення білікультури',
    'Виділення  мієлокультури',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фекалій хворого на середовище Ендо виросли однотипні колонії: малинового кольору, з металевим блиском. Який мікроорганізм є найбільш імовірним збудником захворювання?',
    'ентеротоксигенна Escherichia coli',
    'Salmonella enteritidis',
    'Yersinia enterocolitica',
    'Shigella sonnei',
    'НАГ-вібріон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'допомогою біологічного методу. Які мікроорганізми найбільш доцільно використати як тест - культури?',
    'Спорові',
    'Капсульні',
    'Кислотоупорні',
    'Патогенні',
    'Термофільні',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'біохімічними ознаками ідентичний Corynebacterium diphtheriae, але не утворює екзотоксин. У результаті якого процесу цей мікроорганізм може стати токсигенним?',
    'Фагова конверсія',
    'Культивування на телурітовому середовищі',
    'Пасаж через організм чутливих тварин',
    'Вирощування у присутності антитоксичної сироватки',
    'Хромосомна мутація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностикум, що являє собою оброблені таніном еритроцити барана, на яких адсорбований Vi-антиген Salmonella typhi. В якій реакції буде застосовано цей діагностикум?',
    'РПГА',
    'РГГА',
    'РГА',
    'РП',
    'РЗК',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіл можна очікувати в першу чергу?',
    'Ig M, IgG',
    'Ig A, IgG',
    'Ig D, IgG',
    'Ig E, IgG',
    'Ig M, Ig А',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'поставлена проба Манту, которая оказалась отрицательной. О чем свидетельствует данный результат пробы?',
    'Об отсутствии клеточного иммунитета к туберкулезу',
    'О наличии клеточного иммунитета к туберкулезу',
    'Об отсутствии антител туберкулезным бактериям',
    'Об отсутствии антитоксического иммунитета иммунитета к туберкулезу',
    'О наличии антител к туберкулезным бактериям',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'анти-НBS  антитела. О чем свидетельствует в данном случае положительный результат ИФА?',
    'Перенесенном гепатите В',
    'Остром гепатите В',
    'Остром гепатите С',
    'Хроническом гепатите В',
    'Хроническом гепатите С',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обрывки мицелия  гриба, споры, пузырьки воздуха и капельки жира. Для возбудителей какого грибкового заболевания характерна такая микроскопическая картина волоса?',
    'Фавуса',
    'Микроспории',
    'Трихофитии',
    'Эпидермофитии',
    'Споротрихоза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'поставить реакцию пассивной  гемагглютинации. Чем необходимо сенсибилизировать эритроциты, чтобы решить поставленную задачу?',
    'Дифтерийным анатоксином',
    'Дифтерийным антитоксином',
    'Антигенами дифтерийной палочки',
    'Противодифтерийной сывороткой',
    'Гемолитической сывороткой',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'препарат и окрасили его по Цилю-Нильсену. Какова микроскопическая картина при подтверждении предполагаемого диагноза?',
    'Тонкие бактерии красного цвета',
    'Микроорганизмы с ядром рубиново-красного цвета и голубой цитоплазмой',
    'Красного цвета овоидные бактерии биполярно окрашенные',
    'Палочковидные микробы в виде цепочек, фиолетового цвета',
    'Кокковидные микроорганизмы красного цвета',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'месте введения аллергена появилась припухлость, гиперемия и болезненность. Какие основные компоненты определяют эту реакцию организма?',
    'Мононуклеары, Т-лимфоциты и лимфокины',
    'Гранулоциты, Т- лимфоциты и Ig G.',
    'Плазматические клетки, Т-лимфоциты и лимфокины',
    'В-лимфоциты,  Ig М',
    'Макрофаги,  В-лимфоциты и моноциты',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'округлої форми та еліпсоподібні, що брунькуються клітини, розміром 3-6 мкм. Про збудника якої грибкової хвороби може йти мова в даному випадку?',
    'Кандидозу',
    'Кокцидіозу',
    'Епідермофітії',
    'Мікроспорії',
    'Криптококозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хвилини після укусу. За яким типом реакції гіперчутливості вона проходить?',
    'Анафілактичний',
    'Цитотоксичний',
    'Імунокомплексний',
    'Уповільненого типу',
    'Ідіотип-антиідіотип',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зафарбовування слід використати для виявлення збудників туберкульозу?',
    'Циля-Нельсена',
    'Грам-Синьова',
    'Гімзе-Романовського',
    'Буррі-Гінса',
    'Нейссера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'подовжені з дещо загостреними протилежними кінцями. Які мікроорганізми виявлені у харкотинні?',
    'Streptococcus pneumoniae',
    'Staphylococcus  aureus',
    'Klebsiella pneumoniae',
    'Neisseria meningitidis',
    'Neisseria gonorrhoeae',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дрібних, дещо зігнутих грам негативних паличок, які впродовж 6 годин дають ріст на лужній 1 \% пептонній воді у вигляді ніжної голубуватої плівки. Яким мікроорганізмам притаманні такі властивості?',
    'Вібріонам',
    'Спірохетам',
    'Клостридіям',
    'Бацилам',
    'Спірилам',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проба використовується для виявлення гіперчутливості до',
    'Бруцеліну',
    'Туберкульну',
    'Альттуберкуліну',
    'Тулярину',
    'Антраксину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'раптово з’явилися симптоми гастроентериту. При бактеріологічному дослідженні блювотних мас та залишків сирної маси було виділено золотистий стафілокок. Як доцільно продовжити дослідження для уточнення джерела інфекції?',
    'Провести фаготипування виділених штамів',
    'Визначити здатність штамів до токсиноутворення',
    'Провести дослідження обладнання харчоблоку',
    'Вивчити наявність антитіл у хворих дітей',
    'Поставити алергічну пробу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'грампозитивних ланцетоподібних диплококів, оточених капсулою. Виявлення якого збудника слід очікувати?',
    'Streptococcus pneumoniae',
    'Klebsiella pneumoniae',
    'Chlamidia pneumoniae',
    'Staphylococcus aureus',
    'Escherichia coli',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'із способів стерилізації слід застосувати?',
    'Автоклавування при 121оС 30 хв.',
    'Сухим жаром 160оС 2 год.',
    'Кип’ятінням 1 год.',
    'Фільтрування',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'важкість при ковтанні. Лікар запідозрив ботулізм. Які методи діагностики доцільно використати для підтвердження діагнозу?',
    'Біологічна проба, бактеріологічний',
    'Алергічна проба, серологічний',
    'Бактеріологічний, мікологічний',
    'Протозоологічний, мікроскопічний',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'випорож-нення зі слизом і прожилками крові, підвищення температури, слабкість. Лікар запідозрив дизентерію. Який метод лабораторної діагностики найдоцільніше призначити для підтвердження діагнозу?',
    'Бактеріологічний',
    'Серологічний',
    'Мікологічний',
    'Мікроскопічний',
    'Протозоологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'затрудне-ним  диханням. Бактеріоскопічне дослідження матеріалу із зіву та дихальних шляхів дозволило попередньо діагностувати дифтерійний круп. Який метод фарбування при цьому був застосований?',
    'Нейссера',
    'Циль-Нільсена',
    'Гнса-Буррі',
    'Пешкова',
    'Ожешки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено 5 дрібних округлих, навколо яких чітко було видно зону гемолізу. На яке середовище були зроблені посіви?',
    'Кров’яний МПА',
    'МПА',
    'Ендо',
    'ЖСА',
    'Левіна',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'підозра, що причиною може бути чума. Які постмортальні дослідження тварин слід провести з метою екстренного встановлення збудника інфекції?',
    'Реакція кільцепреципітації',
    'Реакція аглютинації',
    'Реакція пасивної аглютинації',
    'Реакція зв”язування комплементу',
    'Реакція нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'культуральними та біохімічними властивостями віднесена до роду шигел. Яку з названих реакцій доцільно застосувати для серологічної ідентифікації культури?',
    'Аглютинації з діагностичними сироватками',
    'Зв’язування комплементу',
    'Непрямої гемаглютинації',
    'Преципітації',
    'Затримки гемаглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'високочутливі методи .Яку з названих реакцій слід застосувати з вказаною метою?',
    'Твердофазний імуноферментний аналіз',
    'Імуноелектрофорез',
    'Непрямої гемаглютинації',
    'Зв’язування комплементу',
    'Непрямої імунофлуоресценції',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'даними нагадувала тифо-паратифозне захворювання. Лікар вирішив підтвердити діагноз шляхом виявлення специфічних антитіл. Які препарати слід використовувати для цієї мети?',
    'Діагностикуми',
    'Діагностичні сироватки',
    'Мічені сироватки',
    'Моноклональні антитіла',
    'Адсорбовані монорецепторні сироватки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'відмічені випадки на сибірку серед тварин. Яку серологічну реакцію необхідно застосувати для виявлення антигенів збудника в досліджуваному матеріалі?',
    'Реакцію термопреципітації',
    'Реакцію зв’язування комплементу',
    'Реакцію непрямої гемаглютинації',
    'Радіоімунний аналіз',
    'Реакцію преципітації в агарі',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'студентській групі. Який препарат слід використати для створення штучного активного імунітету?',
    'Дифтерійний анатоксин',
    'Антидифтерійну сироватку',
    'Специфічний імуноглобулін',
    'Вакцина АКДП',
    'Вакцина з вбитих бактерій',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріальних та вірусних інфекцій. Виберіть умову, без дотримання якої неможливо визначити результат реакції.',
    'Наявність люмінесцентного мікроскопа',
    'Наявність електронного мікроскопа',
    'Наявності імерсійного мікроскопа',
    'Виділеної чистої культури збудника',
    'Сироватки хворого',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ідентифіковано за морфологічними, культуральними та біохімічними властивостями як сальмонелла тифу. Яке дослідження слід застосувати для остаточної ідентифікації збудника?',
    'Сероідентифікацію',
    'Серодіагностику',
    'Алергодіагностику',
    'Антибіотикограму',
    'Фаготипування',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'рани локалізовані на обличчі. Яку лікувально-профілактичну допомогу потрівбно надати для профілактики сказу?',
    'Розпочати імунізацію антирабічною вакциною',
    'Призначити комбіновану антибіотикотерапію',
    'Терміново ввести вакцину АКДП',
    'Госпіталізувати хворого і тримати під наглядом лікаря',
    'Терміново ввести нормальний гама-глобулін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'проводиться експрес-діагностика, яка грунтується на виявленні специфічного вірусного антигену в досліджуваному матеріалі (змив носоглотки). Яку серологічну реакцію використовують для цього?',
    'Реакція імунофлюоресценції',
    'Реакція зв’язування комплементу',
    'Реакція  аглютинації',
    'Реакція преципітації',
    'Реакція опсонізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'збудника в сироватці крові хворого. В скільки разів повинен зрости титр антитіл з парною сироваткою, щоб результат вважався достовірним?',
    'В 4 рази і більше',
    'В 2 рази',
    'В один раз',
    'В 3 рази',
    'В пів-титру',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'матриксний білок (М) та зовнішні антигени - гемаглютинін (Н) і нейрамінізазу (N). Яким з них належить основна роль у створені імунітету до грипозної інфекції?',
    'Гемаглютинін та нейрамінідаза',
    'Нуклеопротеїдні антигени',
    'Матриксний білок',
    'Полімеразні білки',
    'Нейрамінідаза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вірусу імунодефіциту людини?',
    'Т-хелпери',
    'Гепатоцити',
    'Ендотеліоцити',
    'Епітеліоцити',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'основну ознаку, що характеризує дану родину.',
    'Наявність ферменту зворотньої транскриптази',
    'Містять мінус-РНК',
    'Прості віруси, що вражають тільки людину',
    'Нуклеїнова кислота не інтегрує в геном хазяїна',
    'Реакція імуноферментного аналізу для виявлення антигенів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'новонароджених пологового будинку. У кількох дітей, а також на деяких предметах догляду виявлено золотистий стафілокок. Які властивості виділених культур дають можливість встановити їхнє походження з одного джерела?',
    'Фаготип',
    'Пігментоутворення',
    'Антигенна структура',
    'Біохімічна активність',
    'Антибіотикограма',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'щоб обгрунтувати необхідність вакцинації. Які дослідження слід провести з такою метою?',
    'Встановити титр антитоксинів в РНГА',
    'Перевірити членів колективу на носійство палички дифтерії',
    'Встановити рівень антитіл проти дифтерійної палички',
    'Перевірити медичну документацію щодо вакцинації',
    'Перевірити стан імунітету щодо дифтерійної палички',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'фекалій хворого на середовище Ендо виросла велика кількість безбарвних колоній. Який мікроорганізм можна з найбільшою імовірністю ВИКЛЮЧИТИ з числа можливих збудників захворювання?',
    'Escherichia coli',
    'Salmonella enteritidis',
    'Proteus vulgaris',
    'Pseudomonas aeruginosa',
    'Yersinia enterocolitica',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'метою екстреної специфічної профілактики дитині було введено донорський гамаглобулін. Який вид імунітету було створено при цьому?',
    'Пасивний',
    'Природний',
    'Антитоксичний',
    'Поствакцинальний',
    'Місцевий',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'категорія дітей має природний пасивний імунітет до цього захворювання. Яких саме дітей мав на увазі лікар?',
    'Новонароджені',
    'Старші 14 років',
    'Ті, що перенесли кір на першому році життя',
    'Ті, що отримали планові щеплення',
    'Ті, чиї батьки не хворіли на кір',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'имеющие различную окраску и размеры: одни – красные крупные, другие – бесцветные средних размеров. К каким по назначению средам относится указанная в условии питательная среда?',
    'Дифференциально- диагностическим',
    'Элективным',
    'Специальным',
    'Избирательным',
    'Обогащения',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '(испражнений) и 8 часовой инкубации в термостате при 37оС обнаружен рост в виде нежной голубоватой пленки. Для возбудителя какого заболевания характерны такие культуральные свойства?',
    'холеры',
    'чумы',
    'брюшного тифа',
    'паратифа А',
    'дизентерии',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'желтые палочки с синими зернами на концах. Какой способ окраски использован в данном случае?',
    'Нейссера',
    'Леффлера',
    'Циль- Нильсена',
    'Козловского',
    'Романовского',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'излечился, снова заболел гонореей. В данном случае можно говорить о',
    'реинфекции',
    'микст-инфекции',
    'рецидиве',
    'суперинфекции',
    'вторичной инфекции',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'при применении реакции иммунофлуоресценции. Опишите полученную при этом микроскопическую картину.',
    'Мелкие овоидные палочки с ярко-зеленым свечением',
    'Мелкие кокковидные бактерии розового цвета',
    'Крупные палочки с обрубленными концами фиолетового цвета',
    'Мелкие палочки с закругленными концами розового цвета',
    'Слегка изогнутые красные палочки, расположенные под углом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'цвета палочковидные бактерии, образующие извитые тяжи. Какое вещество обусловливает склеивание данных бактерий и их рост в виде жгутов?',
    'Корд-фактор',
    'Альттуберкулин',
    'Фтионовая кислота (фосфатид)',
    'Туберкулостеариновая кислота',
    'РРД',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'этого пациента врач приготовил мазок, окрасил по Граму. При микроскопии в препарате обнаружена масса лейкоцитов, в цитоплазме которых находилось большое количество грамотрицательных бобовидной формы диплококков. Результаты какого процесса наблюдаются в препарате?',
    'Фагоцитоза',
    'Метаболизма',
    'Капсулообразования',
    'Спорообразования',
    'Малигнизации',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'первые симптомы столбняка. Ему назначили курс лечения противостолбнячной сыворотки и больной начал выздоравливать. Через две недели у больного повысилась температура, увеличились лимфоузлы, появилась отечность суставов, сыпь, зуд и нарушение со стороны сердечно-сосудистой системы. Как называется состояние, которое возникло у больного?',
    'Сывороточная болезнь',
    'Крапивница',
    'Анафилактический шок',
    'Дисбактериоз',
    'Отек Квинке',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '2.Лептоспирозная вакцина. 3.Вакцина БЦЖ. 4.Адсорбированная коклюшно-дифтерийно-столбнячная вакцина АКДС. 5.Адсорбированный столбнячный анатоксин. Какой иммунитет создают эти препараты.',
    'Искусственный активный',
    'Нестерильный (инфекционный)',
    'Антибактериальный',
    'Искусственный пассивный',
    'Антитоксический',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'температуру, частый стул, боли в животе с тенезмами. Врач поставил клинический диагноз “дизентерия?” и направил исследуемый материал /испражнения/ в баклабораторию. Каким методом диагностики врач-бактериолог должен был подтвердить или опровергнуть клинический диагноз?',
    'Бактериологическим',
    'Биологическим',
    'Бактериоскопическим',
    'Серологическим',
    'Аллергическим',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'учащихся у 15 проба Манту была отрицательной. Что необходимо сделать детям с отрицательной пробой Манту?',
    'Ввести вакцину БЦЖ',
    'Ввести антитоксическую сыворотку',
    'Ввести вакцину антирабическую',
    'Сделать повторную пробу',
    'Исследовать сыворотку крови',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '1:1600, з черевнотифозним Н-антигеном – у розведенні 1:200. Про що це свідчить?',
    'Про захворювання на черевний тиф.',
    'Відсутність тифо-паратифозного захворювання.',
    'Черевнотифозне бактеріоносійство.',
    'Інкубаційний період черевного тифу.',
    'Перенесений черевний тиф в анамнезі.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностичну реакцію Манту. Який імунобіологічний препарат при цьому було введено?',
    'Туберкулін.',
    'Вакцину БЦЖ.',
    'Вакцину АКДП.',
    'Тулярін.',
    'Вакцину АДП.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'трансплантат прижився. Але на 8-му добу трансплантат набряк, змінився його колір і на 11 добу почав відторгатися. Які клітини приймають у цьому участь?',
    'Т-лімфоцити',
    'Еритроцити',
    'Базофіли',
    'Еозинофіли',
    'В-лімфоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мокроты выделили палочки овоидной формы с биполярной окраской, Грам-негативные, в мазке из бульонной культуры располагаются цепочками, на агаре образуют колонии R-формы. Это характерно для возбудителя',
    'чумы',
    'Туберкулеза',
    'Дифтерии',
    'Стрептококковой ангины',
    'Менингококкового назофарингита',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'м’язів потилиці, блювота без попередження нудотою, герпетичні висипи на обличчі, лихоманка. На підставі бактеріологічних досліджень якого патологічного матеріалу можливе підтвердження попереднього діагнозу – цереброспінальний  менінгіт ?',
    'Пункція спинно- мозгової рідини, яка витікає під тиском і має неприємний запах',
    'Виділення урінокультур N.meningitidis',
    'Виділення копрокультур   N. Meningitidis',
    'Дослідження блювоти',
    'Виділення бактерій N. Meningitidis  з слизової оболонки сечостатевої системи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'без болю набряк  підшкірної клітковини, у центрі карбункулу чорний  струп, по периферії везикулярні висипання навколо карбункулу. Мікробіологічне дослідження з’ясувало наявність нерухомих стрептобацил, які здатні утворювати капсули. Які мікроорганізми є збудниками  даної хвороби.',
    'Bacillus  antracis',
    'Staptylococcus  aureus',
    'Bacillus  anthracoides',
    'Bacillus  subtilis',
    'Bacillus  megaterium',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'анти НВsAg+, анти НВsМ-, НСАg+. Який діагноз підтверджується на основі цих даних?',
    'Гепатит С, в анамнезі - гепатит В.',
    'Гепатит С.',
    'Хронічний гепатит В з низькою репликативною активністю.',
    'Рецидив гепатиту В.',
    'Повторне зараження гепатитом В.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ранее он перенес гонорею и излечение было полным. К какой категории инфекций можно отнести это новое заболевание?',
    'Реинфекция.',
    'Суперинфекция.',
    'Рецидив',
    'Вторичная инфекция.',
    'Аутоинфекция',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'выставил предварительный клинический диагноз "Брюшной тиф" и направил исследуемый материал в бактериологическу лабораторию. Больной болеет 2 дня. Каким методом микробиологической диагностики можно подтвердить диагноз у данного больного?',
    'Бактериологическим.',
    'Микроскопическим.',
    'Серологическим.',
    'Биологическим.',
    'Аллергологическим.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'лабораторний дiагноз не був встановлений.Який матерiал треба направити до лабораторi для бактерiологiчного дослiдження на третьому тижнi?',
    'Фекалi, та сечу',
    'Харкотиння',
    'Слиз з носу',
    'Слиз з зiву',
    'Промивнi води шлунку',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'механiзм взаємодiї антигенiв та антитiл лежить в її основi?',
    'Аглютинацiя',
    'Преципiтацiя',
    'Бактерiолiз',
    'Гемолiз',
    'lмобiлiзацiя бактерiй',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дослідження необхідно провести, щоб переконатись, що даний мікроб є збудником дифтерії у цієї дитини?',
    'Перевірити токсигенність мікроба',
    'Провести фарбування за методом Буррі - Гінса',
    'Виконати посів на кров''яний агар',
    'Заразити кролика',
    'Провести реакцію аглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'для встановлення джерела інфекції?',
    'Провести фаготипування виділеної чистої культури',
    'Зробити антибіотикограму',
    'Поставити реакцію преципітації',
    'За допомогою реакції зв”язування комплементу',
    'Поставити реакцію нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроскопії мазків з мигдаликів, зафарбованих по методу Нейсера знайдені тонкі палички жовтого кольору з темно-коричневими зернами на кінцях, що розміщуються в вигляді римської цифри п’ять. Яку інфекцію можна запідозрити в цьому випадку?',
    'Дифтерію',
    'Інфекційний мононуклеоз',
    'Лістеріоз',
    'Тонзиліт',
    'Скарлатину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріоскопічного дослідження препаратів – мазків і виявлення туберкульозної палички потрібно використати один із вказаних методів фарбування:',
    'Ціля - Нільсена',
    'Буррі - Гінса',
    'Здрадовського',
    'Грама',
    'Романовського',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сироватки хворого добавляють діагностикуми трьох видів мікроорганізмів і результат якої оцінюють по наявності осаду із склеєних бактерій. Ця реакція відома під назвою:',
    'Відаля',
    'Борде - Жангу',
    'Вассермана',
    'Райта',
    'Асколі',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'емульсії наносять на елективне середовище: 10% молочно – сольовий, або жовточно – сольовий агар. Які мікроорганізми передбачається виділити?',
    'Стафілококи',
    'Кишкову паличку',
    'Стрептококи',
    'Клебсієли',
    'Ентерококи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'рота, а також язик вкриті щільним білим нальотом. В матеріалі, взятому з місця ураження, бактеріолог виявив наявність грибів дріжжеподібної форми, в зв’язку з цим запідозрили мікоз:',
    'Кандідоз',
    'Фавус',
    'Епідермофітія',
    'Актиномікоз',
    'Трихофітія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сильная головная боль, нарушение глотания, затрудненное дыхание, мышечная слабость. Поставлен диагноз ботулизм. С каким фактором патогенности связаны клинические проявления этого заболевания?',
    'Экзотоксин.',
    'Гемолизин.',
    'Эндотоксин.',
    'Плазмокоагулаза.',
    'Фибринолизин.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наведених методів лабораторної діагностики необхідно назначити?',
    'Бактеріологічний.',
    'Серологічний.',
    'Алергічний.',
    'Біологічний.',
    'Мікроскопічний.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мiкроорганiзми,  що  утворюють  на  мясо-пептонному  агарi  жовто-зелений  пiгмент  i характерний  запах.  Як  вони називаються?',
    'Псевдомонади',
    'Ешерiхiї',
    'Протеї',
    'Клебсiєли',
    'Азотобактерiї',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'за Грамом фарбуваалися  негативно, нагадували кавові зернини. Розташовувалися в лейкоцитах. До збудників якої хвороби їх  віднести?',
    'Гонорея',
    'Сифіліс',
    'Венеричний  лімфогранулематоз',
    'М''який шанкр',
    'Трихомонадоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наступний день стан хворого погіршився, температура підвищилася до 39,6оС. Чим пояснити погіршення стану хворого?',
    'Дією ендотоксинів збудника',
    'Алергічною реакцією',
    'Нечутливістю збудника до левоміцетину',
    'Приєднанням вторинної інфекції',
    'Реінфекцією',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'тварини. Яку вакцину необхідно ввести для попередження сказу?',
    'Антирабічну вакцину',
    'АКДП',
    'АДП',
    'БЦЖ',
    'ТАВte',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіл з антигенами. Як називається серологічна реакція, при якій високодисперсні антигени адсорбовані на еритроцитах?',
    'Реакція непрямої (пасивної) гемаглютинації',
    'Реакція преципітації',
    'Реакція зв''язування комплементу',
    'Реакція гемадсорбції',
    'Реакція нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'синього кольору з потовщеннями на полюсах. Який метод фарбування мазків було використано?',
    'Леффлера.',
    'Буррі.',
    'Гінса.',
    'Грама.',
    'Нейссера.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'внаслідок підвищеного рівня антитіл, переважно IgE, які адсорбуються на поверхні клітин-мішеній – тканинних базофілів (тучних клітин) та базофілів крові?',
    'Анафілаксія',
    'Антитіло-залежна цитотоксичність',
    'Гиперчутливість уповільненого типу',
    'Імунно-комплексна гиперчутливість',
    'Сироваткова хвороба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мають форму веретена і за Грамом фарбуються в синьо-фіолетовий колір.Що це за мікроорганізми?',
    'Клостридії.',
    'Стрептококи.',
    'Спірохети.',
    'Актиноміцети.',
    'Диплококи.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроорганізми,зафарбовані в синій колір, в яких термінально розміщені компоненти круглої форми,зафарбовані в червоний колір.Як називаються ці компоненти?',
    'Спори.',
    'Війки.',
    'Джгутики.',
    'Капсули.',
    'Мезосоми.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наступні барвники і реактиви: розчин генціанвіолету, розчин Люголя, 96 ̊ спирт, водний фуксин. Який спосіб фарбування застосований у даному випадку?',
    'За Лефлером',
    'За Цілем-Нільсеном',
    'За Грамом',
    'За Нейсером',
    'За Романовським',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зафарбовані в синій колір, в яких термінально розміщені компоненти округлої форми, зафарбовані в червоний колір. Як називаються ці компоненти?',
    'Спори',
    'Війки',
    'Джгутики',
    'Капсули',
    'Мезосоми',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'препаратом вибору в даному випадку?',
    'Еубіотик.',
    'Антибіотик.',
    'Інтерферон.',
    'Бактеріофаг.',
    'Полівітаміни.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроцефалією.  Про яку хворобу слід в першу чергу подумати лікарю?',
    'токсоплазмоз*',
    'гістоплазмоз',
    'бруцельоз',
    'сифіліс',
    'лістеріоз.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'слизистий характер виявлені мікроорганізми округлої форми, в цитоплазмі яких містяться еритроцити, а також цисти дрібних розмірів з 4 ядрами. Про який збудник йде мова?',
    'Entamoeba hystolitica',
    'Entamoeba coli',
    'Lamblia intestinalis',
    'Trichomonas intestinalis',
    'Leichmania donovani',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виділенно рухомі найпростіші грушеподібної форми, двоядерніз опорним стрижнем.Яке протозойне захворювання можна припустити у хворого?',
    'Лямбліоз*',
    'Балантидіаз кишковий',
    'Амебіаз кишковий',
    'Амебна дизентерія',
    'Трихомоноз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроцефалією.  Про яку хворобу слід в першу чергу подумати лікарю?',
    'токсоплазмоз*',
    'гістоплазмоз',
    'бруцельоз',
    'сифіліс',
    'лістеріоз.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'гістомизонтацидноюдією. Який препарт він одержував?',
    'примахін',
    'хінін',
    'доксициклін',
    'хлоридин*',
    'бісептол',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'спричинити внутрішньоутробну загибель?',
    'Токсоплазмоз',
    'Амебіаз',
    'Лейшманіоз',
    'Лямбліоз',
    'Малярія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'із піхви виявлено овально-грушоподібні найпростіші з шипом, з передньої частини яких відходять джгутики; наявна ундулююча мембрана. Яке захворювання підозрює лікар у хворої?',
    '*Урогенітальний трихомоноз',
    'Балантидіоз',
    'Токсоплазмоз',
    'Лямбліоз',
    'Кишковий трихомоноз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'препараті, забарвленому за Романовським-Гімзою, виявлені тільця півмісяцевої форми із загостреним кінцем, блакитною цитоплазмою, ядром червоного кольору. Яких найпростіших виявлено в мазках?',
    'Токсоплазми',
    'Малярійні плазмодії',
    'Вісцеротропні лейшманії',
    'Трипаносоми',
    'Дерматотропні лейшманії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зустрічається переважно у тропічних і субтропічних областях. Межі її розповсюдження співпадають з ареалами комарів роду:',
    'Анофелес',
    'Мансоніа',
    'Аедес',
    'Кулізета',
    'Кулекс',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено великі одноклітинні організми грушоподібної форми з загостреним шипом на задньому кінці тіла, великим ядром та ундулюючою мембраною Які найпростіші знайдені в мазку?',
    'Trichomonas vaginalis',
    'Trichomonas buccalis',
    'Lamblia intestinalis',
    'Trypanosoma gambiense',
    'Trichomonas hominis',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    '18 мкм. Тіло грушоподібної форми, 4 пари джгутиків, у розширеній передній частині тіла два ядра, які розміщені симетрично. Який вид найпростіших найбільш вірогідний?',
    'Лямблія',
    'Балантидій',
    'Трихомонада',
    'Дизентерійна амеба',
    'Кишкова амеба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'підвищення температури. Лікар запідозрив у хворого малярію. Який із перерахованих методів є найбільш адекватним в діагностиці даного захворювання?',
    'Мікроскопічний',
    'Біологічний',
    'Алергічний',
    'Мікробіологічний',
    'Серологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'із перерахованих серологічних реакцій має діагностичне значення в підтвердженні діагнозу?',
    'Реакція зв’язування комплементу',
    'Реакція нейтралізації',
    'Реакція гемадсорбції',
    'Реакція аглютинації',
    'Реакція гальмування гемаглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'товстої кишки. При мікроскопічному дослідженні фекалій виявлено округлої форми утворення розміром  коло 10 мкм з 4 ядрами, ідентифікованіяк цисти збудника.  Який діагноз можна поставити на основі даних лабораторного обстеження?.',
    'Амебна дизентерія',
    'Балантидіаз',
    'Ентеробіоз',
    'Ентероколіт',
    'Теніоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'этого пациента врач приготовил мазок, окрасил по Граму. При микроскопии в препарате обнаружена масса лейкоцитов, в цитоплазме которых находилось большое количество грамотрицательных бобовидной формы диплококков. Результаты какого процесса наблюдаются в препарате?',
    'Фагоцитоза',
    'Метаболизма',
    'Капсулообразования',
    'Спорообразования',
    'Малигнизации',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'призначено препарат, який являє собою термостабільний білок, що міститься у людини в сльозах, слині, грудному молоці матері, а також його можна виявити в свіжознесеному курячому яйці. Відомо, що він являє собою фактор природної резистентності організму і має назву:',
    'Лізоцим',
    'Комплемент',
    'Інтерферон',
    'Інтерлейкін',
    'Іманін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'барана. Який висновок слід зробити на основі даних аналізу?',
    'Зниження рівня Т-лімфоцитів',
    'Зниження рівня В-лімфоцитів',
    'Зниження рівня натуральних кілерів (NK-клітин)',
    'Зниження рівня системи комлементу',
    'Недостатність клітин- ефекторів гуморального імунітету',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'препарат, який являє собою термостабільний білок, що міститься у людини в сльозах, слині, грудному молоці матері, а також його можна виявити в свіжознесеному курячому яйці. Відомо, що він являє собою фактор природної резистентності організму і має назву:',
    'Лізоцим',
    'Комплемент',
    'Інтерферон',
    'Інтерлейкін',
    'Іманін',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'показник характеризує кількість бактерій групи кишкових паличок, що знаходяться в 1 л води?',
    'Колі-індекс',
    'Колі-титр',
    'Титр колі-фага',
    'Перфрінгенс-титр',
    'Мікробне число',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено 5 дрібних округлих, навколо яких чітко було видно зону гемолізу. На яке середовище були зроблені посіви?',
    'Кров’яний МПА',
    'МПА',
    'Ендо',
    'ЖСА',
    'Левіна',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено дві червоні колонії на мембранному фільтрі (середовище Ендо), через який пропустили 500 мл досліджуваної води. Розрахуйте колі-індекс та колі-титр досліджуваної води:',
    '4 та 250',
    '2 та 500',
    '250 та 4',
    '500 та 2',
    '250 та 2',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'повітря. Встановлено наявність у ньому бацил, дріжджоподібних грибів, гемолітичних стрептококів, мікрококів. Які з виявлених мікроорганізмів свідчать про пряму епідемічну  небезпеку?',
    'Гемолітичні стрептококи',
    'Мікрококи',
    'Бацили',
    'Дріжджоподібні гриби',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'повітря. Встановлено наявність у ньому бацил, дріжджеподібних грибів,  гемолітичних стрептококів, мікрококів. Які з виявлених мікроорганізмів свідчать про пряму епідемічну  небезпеку?',
    'Гемолітичні стрептококи',
    'Мікрококи',
    'Бацили',
    'Дріжджеподібні гриби',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено дві червоні колонії на мембранному фільтрі (середовище Ендо), через який пропустили 500 мл досліджуваної води. Розрахуйте колі-індекс та колі-титр досліджуваної води:',
    '4 та 250',
    '2 та 500',
    '250 та 4',
    '500 та 2',
    '250 та 2',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріальних та вірусних інфекцій. Виберіть умову, без дотримання якої неможливо визначити результат реакції.',
    'Наявність люмінесцентного мікроскопа',
    'Наявність електронного мікроскопа',
    'Наявності імерсійного мікроскопа',
    'Виділеної чистої культури збудника',
    'Сироватки хворого',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антитіл з антигенами. Як називається серологічна реакція, при якій високодисперсні антигени адсорбовані на еритроцитах?',
    'Реакція непрямої (пасивної) гемаглютинації',
    'Реакція преципітації',
    'Реакція зв''язування комплементу',
    'Реакція гемадсорбції',
    'Реакція нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зв''язку з підозрою щодо її фальсифікації. За допомогою якої серологічної реакції імунітету можна ідентифікувати харчовий продукт?',
    'Преципітації',
    'РЗК',
    'Аглютинації',
    'Імунофлюорестенції',
    'РНГА',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стабілізованих еритроцитах барана. З якою метою використовують цей препарат?',
    'Для виявлення антитіл в реакції непрямої гемаглютинації',
    'Для виявлення антитіл в реакції зв’язування комплементу.',
    'Для виявлення антитіл в реакції Відаля',
    'Для виявлення антитіл в реакції затримки гемаглютинації',
    'Для серологічної ідентифікації зхбудника черевного тифу.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'коклюшним діагностикумами. На дні пробірок, до яких було внесено діагностикуми з Bordetella parapertussis, утворився зернистий осад. Які антитіла виявила ця реакція?',
    'Бактеріолізини',
    'Антитоксини',
    'Опсоніни',
    'Аглютиніни',
    'Преципітини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностикум (стабілізовані еритроцити з адсорбованим на них Vi-антигеном збудника черевного тифу); б) буферний ізотонічний розчин; в) стандартна сироватка з антитілами до Vi-антигена збудника черевного тифу. Для якої серологічної реакції призначений набір?',
    'Пасивної гемаглютинації',
    'Зв’язування комплементу',
    'Прямої гемаглютинації',
    'Гальмування гемаглютинації',
    'Нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'блювання, біль у м’язах ніг, слабість, запаморочення. Лікар поставив попередній діагноз: холера. Як необхідно досліджувати матеріал від хворого для експрес-діагнозу?',
    'РА',
    'Бактеріологічним методом',
    'Пряма і непряма РІФ',
    'Серологічним методом',
    'Біологічним методом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стабілізованих еритроцитах барана. З якою метою використовують цей препарат?',
    'Для виявлення антитіл в реакції зв’язування комплементу',
    'Для серологічної ідентифікації збудника черевного тифу',
    'Для виявлення антитіл в реакції непрямої гемаглютинації',
    'Для виявлення антитіл в реакції затримки гемаглютинації',
    'Для виявлення антитіл в реакції Відаля',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'чашку Петрі з поживним агаром по обидва боки від розташованої в центрі смужки фільтрувального паперу, змоченого протидифтерійною антитоксичною сироваткою. Після інкубації посівів в агарі між окремими культурами і смужкою фільтрувального паперу виявлено смужкоподібні ділянки помутніння середовища. Яку імунологічну реакцію було виконано?',
    'Реакцію преципітації в гелі.',
    'Реакцію Кумбса',
    'Реакцію аглютинації',
    'Реакцію кільцепреципітації',
    'Реакцію опсонізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностикумом, виявлені антитіла у розведенні сироватки обстежуваного до 1:80, що вище діагностичного титру. Такий результат свідчить про наступне:',
    'Можливе носійство паличок черевного тифу',
    'Гостре захворювання на черевний тиф',
    'Реконвалесценції хворого на черевний тиф',
    'Інкубаційний період черевного тифу',
    'Рецидив черевного тифу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'такі реактиви: кардіоліпіновий антиген, спиртовий екстракт ліпоїдів із серцевого м‘яза бика з холестерином, антиген з трепонем, зруйнованих ультразвуком, гемолітична система, фізіологічний розчин, досліджувані сироватки. Який ще компонент необхідний для постановки реакції?',
    '* Комплемент',
    'Живі трепонеми',
    'Еритроцити барана',
    'Діагностична преципітуюча сироватка',
    'Антиглобулінова сироватка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зафарбованому за Романовським-Гімза  лікар виявив тонкі мікроорганізми з 12-14 рівномірними завитками з гострими кінцями довжиною 10-13 мкм блідо-рожевого кольору. Про збудника якої інфекційної хвороби може йти мова в даному випадку?',
    'Сифілісу',
    'Трипаносомозу',
    'Лептоспірозу',
    'Поворотного тифу',
    'Лейшманіозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'жовтяниці, болі в м’язах, ознобом,. носовими кровотечами. При проведені лабораторної діагностики бактеріолог виконав темнопольну мікроскопію краплини крові хворого. Назвіть збудників хвороби:',
    'Leptospira interrogans',
    'Borrelia dutlonii',
    'Calymmatobacterium granulomatis',
    'Bartonella bacilloformis',
    'Rickettsia mooseri',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'такі реактиви: кардіоліпіновий антиген, спиртовий екстракт ліпоідів із серцевої м‘язи бика з холестерином, антиген з трепонем, зруйнованих ультразвуком, гемолітична система, фізіологічний розчин, досліджувані сироватки. Який ще компонент необхідний для постановки реакції?',
    'Комплемент',
    'Живі трепонеми',
    'Еритроцити барана',
    'Діагностична преципітуюча сироватка',
    'Антиглобулінова сироватка',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'гарячкою, жовтяницею, геморагічною висипкою на шкірі і слизових оболонках, а також гострою нирковою недостатністю, при гістологічному дослідженні тканини нирки (забарвлення за Романовськом-Гімзою) виявлені звивисті бактерії, які мають вигляд букв С та S. Які бактерії були виявлені?',
    'Лептоспіри',
    'Трепонеми',
    'Спіролли',
    'Боррелії',
    'Кампілобактерії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'територіях, де є переносник кліщ роду Alectorobius. Як можна назвати таку інфекцію?',
    'Эндемічною',
    'Экзотичною',
    'Спорадичною',
    'Пандемічною',
    'Эпідемічною',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявилась позитивною на три плюси. Яка подальша тактика лікаря?',
    'Вдруге призначити реакцію Васермана з реакцією мікропреципітації',
    'Встановити діагноз:сифіліс',
    'Вдруге призначити реакцію Васермана',
    'Призначити реакцію мікропреципітації',
    'Призначити мікроскопію біопсійного матеріалу з пухлини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'кінцями, довжиною 10-13 мкм блідо-рожевого кольору. Про збудника якої інфекційної хвороби може йти мова в даному випадку?',
    'Сифілісу',
    'Трипаносомозу',
    'Лептоспірозу',
    'Поворотного тифу',
    'Лейшманіозу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ознобом,. носовими кровотечами. Під час  проведення лабораторної діагностики бактеріолог виконав темнопольну мікроскопію краплини крові хворого. Назвіть збудника хвороби:',
    'Leptospira interrogans',
    'Borrelia dutlonii',
    'Calymmatobacterium granulomatis',
    'Bartonella bacilloformis',
    'Rickettsia mooseri',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'посіяти кров хворого з метою виділення збудника?',
    'Цукрово-пептонний бульйон',
    'М’ясо-пептонний агар',
    'Середовище Плоскірьова',
    'Середовище Бучіна',
    'Жовчно-сольовий агар',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стрептококова інфекція погіршує стан хворого. Який препарат доцільно використати для профілактики ускладнень?',
    'Пеніцилін',
    'Стрептококовий анатоксин',
    'Стрептококовий бактеріофаг',
    'Донорський гама-глобулін',
    'Аутовакцина',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'Із ротоглотки хлопчика, який хворіє на хронічний тонзиліт виділили культуру кокових бактерій. У мазках вони розташовувалися у вигляді ланцюжків. Які це можуть бути бактерії?',
    'Стрептококи',
    'Стафілококи',
    'Ешерихії',
    'Клостридії',
    'Вібріони',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'острым началом, тошнотой, рвотой, поносом. При микроскопии мазков, приготовленных из творога и рвотных  мас обнаружены грамположительные микроорганизмы, располагающиеся в мазках в виде скоплений, напоминающих гроздья винограда. Какими будут Ваши последующие действия по установлению этиологии этой  вспышки пищевой интоксикации ?',
    'Дополнительно провести бактериологический метод исследования.',
    'Сделать заключение о том, что причиной заболеваний стал стафилококк.',
    'Дополнительно поставить аллергическую пробу.',
    'Дополнительно определить антитела в сыворотке крови.',
    'Дополнительно определить фаготип стафилококка.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'короткими ланцюжками.  Який з перелічених мікроорганізмів знайдено в мазках з мигдалин?',
    'Стрептококи',
    'Стафілококи',
    'Мікрококи',
    'Диплококи',
    'Тетракоки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'подовжені з дещо загостреними протилежними кінцями. Які мікроорганізми виявлені у харкотинні?',
    'Streptococcus pneumoniae',
    'Staphylococcus aureus',
    'Klebsiella pneumoniae',
    'Neisseria meningitidis',
    'Neisseria gonorrhoeae',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'симптоми гастроентериту. При бактеріологічному дослідженні блювотних мас та залишків сирної маси було виділено золотистий стафілокок. Як доцільно продовжити дослідження для уточнення джерела інфекції?',
    'Провести фаготипування виділених штамів',
    'Визначити здатність штамів до токсиноутворення',
    'Провести дослідження обладнання харчоблоку',
    'Вивчити наявність антитіл у хворих дітей',
    'Поставити алергічну пробу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ланцетоподібних диплококів, оточених капсулою. Виявлення якого збудника слід очікувати?',
    'Streptococcus pneumoniae',
    'Klebsiella pneumoniae',
    'Chlamidia pneumoniae',
    'Staphylococcus aureus',
    'Escherichia coli',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'елективне середовище: 10% молочно – сольовий, або жовточно – сольовий агар. Які мікроорганізми передбачається виділити?',
    'Стафілококи',
    'Кишкову паличку',
    'Стрептококи',
    'Клебсієли',
    'Ентерококи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'плазмокоагулазну активність. Скоріше всього - це:',
    '* Staphylococcus aureus',
    'Streptococcus pyogenes',
    'Staphylococcus epidermidis',
    'Staphylococcus saprophyticus',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'загостреними протилежними кінцями. Які мікроорганізми виявлені  у харкотинні?',
    'Neisseria meningitidis',
    'Staphylococcus aureus',
    'Klebsiella pneumonia',
    'Neisseria gonnorrhoeae',
    'Streptococcus pneumoniae',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'шкірно дитині ввели невелику кількість сироватки до еритрогенного токсину стрептокока, на місці ін’єкції висип зник. Що означають результати реакції?',
    'Клінічний діагноз підтвердився',
    'Всю дозу сироватки можна вводити внутрішньовенно',
    'У дитини підвищена чутливість до еритрогенного токсину',
    'Захворювання викликав не гемолітичний стрептокок',
    'Імунна система дитини дуже ослаблена',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'від хворих, медперсоналу та деяких об’єктів навколишнього середовища. Яке дослідження необхідно провести, щоб визначити ідентичність виділених стафілококів і встановити джерело  госпітальної інфекції?',
    'Фаготипування',
    'Визначення біовару',
    'Серотипування',
    'Зараження тварин',
    'Визначення патогенності',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'утворився придонний осад. При пересів на кров’яний агар виросли дрібні, прозорі, кулясті колонії, оточені зоною гемолізу. У мазку, приготованому з осаду, визначалися грампозитивні коки, що розташовувалися у вигляді довгих ланцюжків. Які мікроорганізми присутні у крові цього хворого?',
    'Стрептококи',
    'Сарцини',
    'Стафілококи',
    'Тетракоки',
    'Мікрококи',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'колонії округлої форми, середніх розмірів, оточені зоною гемолізу. У мазках з колоній – коки, розташовані скупченнями неправильної формыи Гр+. . Виділена культура оксидазо- і каталазопозитивна,  ферментує манітт, синтезує плазмокоагулазу. Який вид збудника виділений?',
    'Staphylococcus aureus',
    'Streptococcus agalactiae',
    'Streptococcus pyogenes',
    'Staphylococcus epidermidis',
    'Staphylococcus saprophyticus',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стрептокока, на місці ін''єкції висип зник. Що означають результати реакції?',
    'Клінічний діагноз підтвердився',
    'У дитини підвищена чутливість до еритрогенного токсину',
    'Захворювання викликав негемолітичний стрептокок',
    'Всю дозу сироватки можна вводити внутривенно',
    'Імунна система дитини дуже ослаблена',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'округлой форми, середніх размеров, жовті колонії, оточені зоною гемолізу. В мазках з колоній –коки, розташовані скупченнями неправильної форми, Гр+. Виділена культура оксидазо- и каталазо- позитивна, ферментує маніт, синтезує плазмокоагулазу. Якому виду з нижче перерахованих відповідає виділений збудник?',
    'Staphylococcus aureus',
    'Streptococcus agalactiae',
    'Streptococcus pyogenes',
    'Staphylococcus epidermidis',
    'Staphylococcus saprophyticus',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'цукровому бульйоні утворився придонний осад. При пересіві на кров’яний агар вирослі дрібні, прозорі, круглі колонії, оточені зоною гемоліза. В мазку, приготованому з осаду, виявлено грампозитивні коки, розташовані у вигляді довгих ланцюжків. Які мікроорганізми присутні в крові у цього хворого?',
    'Стрептококи',
    'Мікрококи',
    'Стафілококи',
    'Тетракоки',
    'Сарцини',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'частому нагноєнні післяопераційних ран. При бактеріологічному дослідженні гною був виділений золотистий стафілокок. Яке дослідження треба використати для виявлення джерела цього збудника серед персоналу відділення.',
    '* Фаготипування',
    'Мікроскопічний',
    'Серологічна ідентифікація',
    'Визначення чутливості до антибіотиків',
    'Біохімічна ідентифікація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'культури золотистого стафилококу від хворих, мед.персоналу і з деяких об’єктів оточуючого середовища. Яке дослідження необхідно провести, щоб встановити ідентичність виділених стафілококів і встановити джерело госпітальної інфекції?',
    'Фаготипування',
    'Визначення біовару',
    'Серотипування',
    'Визначення патогенності',
    'Зараження тварин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ревматизму і призначив серологічне дослідження. Наявність антитіл до якого з стрептококових антигенів найбільш вірогідно підтвердить передбачуваний діагноз?',
    'О-стрептолізин',
    'С-вуглевод',
    'М-білок',
    'Еритрогенний токсин',
    'Капсульний полісахарид',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'дослідження. З якою метою слід взяти матеріал у хворого з гнійним ураженням глибоких тканин нижньої кінцівки?',
    'Для встановлення етіології гнійного процесу і визначення чутливості до антибіотиків',
    'Для виявлення патогенного стафілокока і визначення антибіотикограми',
    'Для виявлення збудника, щоб попередити внутрішньолікарняне інфікування',
    'Для підтвердження анаеробної інфекції',
    'Для виявлення токсичності  збудника',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'допомогою біологічного методу. Які мікроорганізми найбільш доцільно використати як тест - культури?',
    'Спорові',
    'Капсульні',
    'Кислотоупорні',
    'Патогенні',
    'Термофільні',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'із способів стерилізації слід застосувати?',
    'Автоклавування при 121оС 30 хв.',
    'Сухим жаром 160оС 2 год.',
    'Кип’ятінням 1 год.',
    'Фільтрування',
    '-',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'середовища, що містять речовини, які змінюються при температурі вище 100ºС (сечовина,вуглеводи). Який спосіб стерилізації повинен вибрати лаборант?',
    'Проточною парою, дробно',
    'Парою під тиском в автоклаве',
    'Кип’ятінням',
    'Тиндалізація',
    'Пастеризація',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'ковтання. Лікар запідозрив ботулізм. Які методи діагностики доцільно використати для підтвердження діагнозу?',
    'Біологічну пробу, бактеріологічний',
    'Протозоологічний, мікроскопічний',
    '–',
    'Алергічну пробу, серологічний',
    'Бактеріологічний, мікологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'наступний день, необхідно підготувати стерильні чашки Петрі, піпетки. Який спосіб стерилізації варто застосувати в даному випадку?',
    'Сухим жаром',
    'Текучим паром',
    'Тиндалізацією',
    'пастеризацією',
    'Кип’ятінням',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'аллергена появилась припухлость, гиперемия и болезненность. Какие основные компоненты определяют эту реакцию организма?',
    'Мононуклеары, Т-лимфоциты и лимфокины',
    'Гранулоциты, Т- лимфоциты и Ig G.',
    'Плазматические клетки, Т-лимфоциты и лимфокины',
    'В-лимфоциты,  Ig М',
    'Макрофаги,  В-лимфоциты и моноциты',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'для мікроскопії. Який метод фарбування препарату використовують для виявлення збудника?',
    'За Цілем-Нильсеном',
    'За Бурі',
    'За Грамом',
    'За Леффлером',
    'За Ожешко',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'повысить вероятность бактериоскопического oбнаружения возбудителя в мокроте? Если да, то какими методами.',
    'Методами обогащения исследуемого материала (цетрифугированием флотацией)',
    'Биологическим методом',
    'Посевом материала в среды обогащения',
    'Методом иммуноферментного анализа',
    'Серологическими методами',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'організмі є живі бактерії вакцинного штаму. Як найбільш правильно назвати такий вид імунітету?',
    'Нестерильний',
    'Гуморальний',
    'Типоспецифічний',
    'Природжений',
    'Перехресний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'знайдено кислотостійкі бактерії, але за методом Прайса корд-фактор не виявлений. Яке дослідження дозволить найбільш надійно підтвердити або спростувати попередній діагноз?',
    'Зараження лабораторних тварин',
    'Вивчення токсигенності',
    'Фаготипування виділеної культури',
    'Серологічна ідентифікація збудника',
    'Шкірна алергічна проба',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено. Яким методом можна підвищити імовірність виявлення мікобактерій в харкотині?',
    'Гомогенізації і флотації',
    'Прайса і Школьнікової',
    'Темнопільна мікроскопія',
    'Мікроскопія препаратів, пофарбованих за Циль-Нільсеном',
    'Мікроскопія нативних мікропрепартів',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроскопічне дослідження мокротиння, з метою виявлення збудника. Який метод забарвлення доцільно використати при цьому?',
    'Метод Ціля-Нільсена',
    'Метод Грама',
    'Метод Буррі-Гінса',
    'Метод Романовського-Гімза',
    'Метод Нейссера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'яких  із перелічених специфічних чинників зумовлена позитивна реакція?',
    'Т-лімфоцити',
    'В-лімфоцити',
    'Антитіла',
    'Еритроцити',
    'Лейкоцити',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'поставлена проба Манту, которая оказалась отрицательной. О чем свидетельствует данный результат пробы?',
    'Об отсутствии клеточного иммунитета к туберкулезу',
    'О наличии клеточного иммунитета к туберкулезу',
    'Об отсутствии антител туберкулезным бактериям',
    'Об отсутствии антитоксического иммунитета иммунитета к туберкулезу',
    'О наличии антител к туберкулезным бактериям',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'по Цилю-Нильсену. Какова микроскопическая картина при подтверждении предполагаемого диагноза?',
    'Тонкие бактерии красного цвета',
    'Микроорганизмы с ядром рубиново-красного цвета и голубой цитоплазмой',
    'Красного цвета овоидные бактерии биполярно окрашенные',
    'Палочковидные микробы в виде цепочек, фиолетового цвета',
    'Кокковидные микроорганизмы красного цвета',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'зафарбовування слід використати для виявлення збудників туберкульозу?',
    'Циля-Нельсена',
    'Грам-Синьова',
    'Гімзе-Романовського',
    'Буррі-Гінса',
    'Нейссера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'цвета палочковидные бактерии, образующие извитые тяжи. Какое вещество обусловливает склеивание данных бактерий и их рост в виде жгутов?',
    'Корд-фактор',
    'Альттуберкулин',
    'Фтионовая кислота (фосфатид)',
    'Туберкулостеариновая кислота',
    'РРД',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'учащихся у 15 проба Манту была отрицательной. Что необходимо сделать детям с отрицательной пробой Манту?',
    'Ввести вакцину БЦЖ',
    'Ввести антитоксическую сыворотку',
    'Ввести вакцину антирабическую',
    'Сделать повторную пробу',
    'Исследовать сыворотку крови',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагностичну реакцію Манту. Який імунобіологічний препарат при цьому було введено?',
    'Туберкулін.',
    'Вакцину БЦЖ.',
    'Вакцину АКДП.',
    'Тулярін.',
    'Вакцину АДП',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріоскопічного дослідження препаратів – мазків і виявлення туберкульозної палички потрібно використати один із вказаних методів фарбування:',
    'Ціля - Нільсена',
    'Буррі - Гінса',
    'Здрадовського',
    'Грама',
    'Романовського',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікобактерій. Який із вказаних препаратів обовязково повинен бути включений в комплексну терапію туберкульозу?',
    'етамбутол',
    'етіонамід',
    'натрію парааміносаліцилат',
    'ізоніазид*',
    'рифампіцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлення збудників туберкульозу?',
    'Нейсера',
    'Гімзи –Романовського',
    'Грама – Синьова',
    'Буррі –Гінса',
    'Циля – Нільсена*',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з''явилаcя папула розміром до 8 мм у диаметрі. Який тип реакції гіперчутливості розвинувся після введення туберкуліну?',
    'Реакція гіперчутливості IV типу',
    'Реакція типу феномен Артюса',
    'Реакція типу сироваткової хвороби',
    'Атопічна реакція',
    'Реакція гіперчутливості ІІ типу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'забарвлених за Цілем-Нільсеном, виявлені червоні палички. Яка властивість туберкульозної палички виявлена при цьому?',
    'Кислотостійкість',
    'Спороутворення',
    'Лугостійкість',
    'Капсулоутворення',
    'Спиртостійкість',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'яскравочервоних паличок, які розміщувалися поодиноко або групами, не чутливі до дії кислот. На живильних середовищах перші ознаки росту з''являються на 10-15-ту добу. До якої родини відносяться виявлені  бактерії?',
    'Micobacterium tuberculosis',
    'Versinia pseudotuberculosis',
    'Histoplasma dubrosii',
    'Klebsiella rhinoscleromatnis',
    'Coxiella burnettii',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'туберкульозу новонароджених дітей віком 5-7 днів життя. При цьому застосовують вакцину:',
    '*БЦЖ',
    'АКДП',
    'АДП',
    'АД',
    'АКП',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'туберкульозу. Яку з наведених нижче проб при цьому використали?',
    'Проба Манту.',
    'Проба Шика.',
    'Нашкірна проба з тулярином',
    'Проба Бюрне.',
    'Проба з антраксином',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'найбільш доцільно призначити в першу чергу?',
    'Ізоніазид',
    'Циклосерін',
    'Етоксид',
    'Сульфален',
    'Етіонамід',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'механізму дії. Який з протитуберкульозних засобів пригнічує в мікобактеріях транскрипцію РНК на ДНК?',
    '* Рифампіцин',
    'ПАСК',
    'Ізоніазид',
    'Етіонамід',
    'Стрептоміцин',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактеріоскопічного дослідження препаратів - мазків і виявлення туберкульозної палички потрібно використати один із методів збагачення, який передбачає обробку харкотиння лише розчином їдкого натру. Як називається такий метод?:',
    'Гомогенізація',
    'Інактивація',
    'Флотація',
    'Фільтрація',
    'Знешкодження',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'туберкульозу новонароджених дітей віком 5-7 днів життя. При цьому застосовують вакцину:',
    'БЦЖ',
    'АКДС',
    'АДС',
    'АД',
    'АКС',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мокротиння хворого на туберкульоз. Який метод фарбування треба використати у даному випадку7',
    'Ціля-Нільсена',
    'Бурі',
    'Грама',
    'Романовського-Гімзи',
    'Гінса',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікроскопічне дослідження мокротиння  з метою виявлення збудника. Який метод забарвлювання доцільно застосувати при цьому?',
    'Метод Ціля-Нільсена',
    'Метод Бурі-Гінса',
    'Метод Романовського-Гімзи',
    'Метод Грама',
    'Метод Нейсера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діагнозом “холера”. Який метод мікробіологічної діагностики потрібно використати, щоб підтвердити або відхилити діагноз?',
    'Бактеріологічний',
    'Алергічний',
    'Бактеріоскопічний',
    'Біологічний',
    'Вірусологічний',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'обнаружен рост- нежная пленка. Для возбудителя какого заболевания характерны такие культуральные свойства?',
    'Возбудителя холеры',
    'Возбудителя чумы',
    'Возбудителя туберкулеза',
    'Возбудителя дизентерии',
    'Возбудителя псевдотуберкулеза',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'м''язах ніг, слабкість, запаморочення. Після огляду лікар виставив попередній діагноз "холера". Як необхідно досліджувати матеріал від хворого для експрес діагнозу?',
    'Пряма і непряма РІФ',
    'РА',
    'Бактеріологічним методом',
    'Серологічним методом',
    'Біологчним методом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хвороби є дегідратація.  Виберіть, які з перерахованих  птогенетичних впливів є основною  причиною зневоднення.',
    'Активація аденілатциклази',
    'Відщеплення нейрамінової  кислоти',
    'Деструкція гіалуронової кислоти',
    'Дефект фосфоліпідів мембран',
    'Деструкція муцину',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'вибрионов. Проведение какой реакции  позволит определить вид микроба, вызвавшего это заболевание?',
    'Агглютинации с сыворотками, содержащими  О-антитела.',
    'Агглютинации с сыворотками, содержащими Н-антитела.',
    'Пассивной гемагглютинации с эритроцитарным антигенным диагностикумом.',
    'Агглютинации Видаля.',
    'Преципитации.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'на середовище Ендо виросли однотипні колонії: малинового кольору, з металевим блиском. Який мікроорганізм є найбільш імовірним збудником захворювання?',
    'ентеротоксигенна Escherichia coli',
    'Salmonella enteritidis',
    'Yersinia enterocolitica',
    'Shigella sonnei',
    'НАГ-вібріон',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'грам негативних паличок, які впродовж 6 годин дають ріст на лужній 1 \% пептонній воді у вигляді ніжної голубуватої плівки. Яким мікроорганізмам притаманні такі властивості?',
    'Вібріонам',
    'Спірохетам',
    'Клостридіям',
    'Бацилам',
    'Спірилам',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'инкубации в термостате при 37оС обнаружен рост в виде нежной голубоватой пленки. Для возбудителя какого заболевания характерны такие культуральные свойства?',
    'холеры',
    'чумы',
    'брюшного тифа',
    'паратифа А',
    'дизентерии',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'м’язах ніг, слабість, запаморочення. Лікар поставив попередній діагноз: холера. Як необхідно досліджувати матеріал від хворого для експрес-діагнозу?',
    'РА',
    'Бактеріологічним методом',
    'Пряма і непряма РІФ',
    'Серологічним методом',
    'Біологічним методом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хворих направлені в бактеріологічну лабораторію для підтвердження цього припущення. Якими експрес- методами можна скористатись в даному випадку?',
    'Реакція імунофлюоресценції',
    'Реакція преципітації',
    'Реакція аглютинації',
    'Реакція зв’язування комплементу',
    'Реакція кільце преципітації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'приготований препарат «висяча крапля». Який метод мікроскопії буде використаний для виявлення збудника по його рухливості?',
    'Фазово-контрастна',
    'Електронна',
    'Імунна електронна',
    'Люмінесцентна',
    'Імерсійна',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'цілях. При бакпосіві води виділено чисту культуру холерного вібріону. Яке поживне середовище  було використано при цьому дослідженні?',
    'Лужний агар',
    'МПБ',
    'МПА',
    'Агар Ендо',
    'Агар Ресселя',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'протягом трьох днів. Використання, якого метода, дасть змогу підтвердити  діагноз?',
    'Виділення гемокультури',
    'Виділення копрокультури',
    'Виділення уринокультури',
    'Виділення білікультури',
    'Виділення розеолокультури',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлено Salmonella typhi у кількості 102/г. Як найбільш точно охарактеризувати стан обстеженої жінки?',
    'Бактерионосійство',
    'Дисбактериоз',
    'Реінфекція',
    'Суперінфекція',
    'Рецидив',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мікробіологічної  діагностики слід використати ?',
    'Виділення гемокультури.',
    'Виділення копрокультури.',
    'Виділення урінокультури.',
    'Виділення збудника з ліквора.',
    'Виділення білікультури.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'він відноситься до роду Salmonella. Яка ознака збудника дозволить найбільш точно встановити його видову приналежність?',
    'Антигенна структура',
    'Фаготип',
    'Культуральні властивості',
    'Патогенність для лабораторних тварин',
    'Морфо-тинкторіальні властивості',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'средних размеров с закругленными концами, подвижные, агглютинирующие с сальмонеллезной  О- сывороткой группы В. Идентичные микроорганизмы обнаружены в мясном салате, который накануне употребляли все заболевшие. О возбудителях какого заболевания можно думать в данном случае?',
    'Сальмонеллы - возбудители острого гастроэнтерита.',
    'Сальмонеллы - возбудители брюшного тифа.',
    'Сальмонеллы - возбудители паратифа А.',
    'Эшерихии - возбудители пищевой токсикоинфекции.',
    'Протеи - возбудители пищевой токсикоинфекции.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'слабість, безсоння, погіршення апетиту. Лікар запідозрив черевний тиф. Який метод лабораторної діагностики найдоцільніше призначити для підтвердження діагнозу?',
    'Виділення гемокультури',
    'Виділення копрокультури',
    'Виділення уринокультури',
    'Виділення білікультури',
    'Виділення  мієлокультури',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'собою оброблені таніном еритроцити барана, на яких адсорбований Vi-антиген Salmonella typhi. В якій реакції буде застосовано цей діагностикум?',
    'РПГА',
    'РГГА',
    'РГА',
    'РП',
    'РЗК',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'серологічного дослідження взято кров. При проведенні реакція аглютинації Відаля встановлено, що вона позитивна в розведенні 1:200 з О-діагностикумом черевного тифу. Який діагноз можна встановити на підставі цього дослідження?',
    'Черевний тиф',
    'Дизентерія',
    'Холера',
    'Лептоспіроз',
    'Туберкульоз',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'даними нагадувала тифо-паратифозне захворювання. Лікар вирішив підтвердити діагноз шляхом виявлення специфічних антитіл. Які препарати слід використовувати для цієї мети?',
    'Діагностикуми',
    'Діагностичні сироватки',
    'Мічені сироватки',
    'Моноклональні антитіла',
    'Адсорбовані монорецепторні сироватки',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'морфологічними, культуральними та біохімічними властивостями як сальмонелла тифу. Яке дослідження слід застосувати для остаточної ідентифікації збудника?',
    'Сероідентифікацію',
    'Серодіагностику',
    'Алергодіагностику',
    'Антибіотикограму',
    'Фаготипування',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'окраску и размеры: одни – красные крупные, другие – бесцветные средних размеров. К каким по назначению средам относится указанная в условии питательная среда?',
    'Дифференциально- диагностическим',
    'Элективным',
    'Специальным',
    'Избирательным',
    'Обогащения',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявилася позитивною з черевнотифозним О-антигеном у розведенні 1:1600, з черевнотифозним Н-антигеном – у розведенні 1:200. Про що це свідчить?',
    'Про захворювання на черевний тиф.',
    'Відсутність тифо-паратифозного захворювання.',
    'Черевнотифозне бактеріоносійство.',
    'Інкубаційний період черевного тифу.',
    'Перенесений черевний тиф в анамнезі.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'предварительный клинический диагноз "Брюшной тиф" и направил исследуемый материал в бактериологическу лабораторию. Больной болеет 2 дня. Каким  методом микробиологической диагностики можно подтвердить диагноз у данного больного?',
    'Бактериологическим.',
    'Микроскопическим.',
    'Серологическим.',
    'Биологическим.',
    'Аллергологическим.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'встановлений.Який матерiал треба направити до лабораторi для бактерiологiчного дослiдження на третьому тижнi?',
    'Фекалi, та сечу',
    'Харкотиння',
    'Слиз з носу',
    'Слиз з зiву',
    'Промивнi води шлунку',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'антигенiв та антитiл лежить в її основi?',
    'Аглютинацiя',
    'Преципiтацiя',
    'Бактерiолiз',
    'Гемолiз',
    'lмобiлiзацiя бактерiй',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'добавляють діагностикуми трьох видів мікроорганізмів і результат якої оцінюють по наявності осаду із склеєних бактерій. Ця реакція відома під назвою:',
    'Відаля',
    'Борде - Жангу',
    'Вассермана',
    'Райта',
    'Асколі',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хворого погіршився, температура підвищилася до 39,6оС. Чим пояснити погіршення стану хворого?',
    'Дією ендотоксинів збудника',
    'Алергічною реакцією',
    'Нечутливістю збудника до левоміцетину',
    'Приєднанням вторинної інфекції',
    'Реінфекцією',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'діаметром 4-5см.. Краї виразок піднімаються над поверхнею слизової оболонки; стінки вкриті сірувато – жовтими маслами, які кришаться.Реакція Відаля позитивна. Який найбільш вірогідний діагноз?',
    'хвороба Крона',
    'черевний тиф*',
    'дизентерія',
    'поворотній тиф',
    'паратиф',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'стан погіршився, темпереатура підвищилася до 39,6С.. Чим пояснити погіршення стану хворого?',
    'приєднанням вториної інфекції',
    'реінфекцією',
    'нечутливістю збудника до левоміцитину',
    'алергічною реакцією',
    'дією ендотоксинів збудника*',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'розтину в нижній ділянці тонкої кишки виявлена виразка, яка повторювала форму пейєрової бляшки, з перфорацією стінки кишки. Мікроскопічне дослідження виявило невизначеність малюнку лімфоїдної тканини, витіснення її проліферуючими лімфоцитами, які формують гранульоми. Ускладнення якого захворювання є причиною смерті хворого?',
    'Черевний тиф',
    'Дизентерія',
    'Бруцельоз',
    'Неспецифічний виразковий коліт',
    'Холера',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хворого погіршився, температура підвищилася до 39,6̊С. Чим пояснити погіршення стану хворого?',
    'Приєднанням вторинної інфекції',
    'Реінфекцією',
    'Алергічною реакцією',
    'Нечутливістю збудника до левоміцетину',
    'Дією ендотоксинів збудника',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'безсоння, погіршення апетиту. Лікар запідозрив черевний тиф. Який метод лабораторної діагностики найдоцільніше призначити для підтвердження діагнозу?',
    'Виділення гемо культури',
    'Виділення копро культури',
    'виділення урино культури',
    'Виділення мієлокультури',
    'Виділення білікультури',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'хворого спостерігається:',
    'Бактеремія',
    'Токсинемія',
    'Септицемія',
    'Септикопіємія',
    'Вірусемія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'із перелічених серологічних реакцій слід для цього застосувати?',
    'Реакцію аглютинації',
    'Реакцію преципітації',
    'Реакцію зв''язування комплементу',
    'Реакцію гемаглютинації',
    'Реакцію гальмування гемаглютинації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'бактерій з такими властивостями: грамнегативна рухлива паличка, на середовищі Ендо росте у вигляді безбарвних колоній. Представником якого роду було зумовлене захворювання?',
    'Salmonella',
    'Shigella',
    'Iersinia',
    'Esherichia',
    'Citrobacter',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'виявлені антитіла в розведенні сироватки досліджуваного  1:80, що вище діагностичного титру. Такий результат свідчить:',
    'Про можливе носійство паличок черевного тифу',
    'Про гостре захворювання черевним тифом',
    'Про рецидив черевного тифу',
    'Про інкубаційний період черевного тифу',
    'Про реконвалесценцію хворого черевним тифом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'S.typhi у сироватці хворого с 1:100 до 1:400. Як можна трактувати отримані результати?',
    'Хворіє черевним тифом',
    'Є гострим носієм черевнотифозних мікробів',
    'Є хронічним носієм черевнотифозних мікробів',
    'Раніше перехворів черевним тифом',
    'Раніше щеплювався проти черевного тифу',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'адсорбовані на стабілізованих еритроцитах барана. З якою метою використовують цей препарат?',
    'Для виявлення антитіл в реакції непрямої гемаглютинації',
    'Для виявлення антитіл в реакції зв’язування комплементу.',
    'Для виявлення антитіл в реакції Відаля',
    'Для виявлення антитіл в реакції затримки гемаглютинації',
    'Для серологічної ідентифікації зхбудника черевного тифу.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'шкільної їдальні виявлені Vi-антитіла. Яка з перелікованих реакцій була використана у данному випадку?',
    'РНГА',
    'Реакція Відаля',
    'РЗК',
    'ІФА',
    'РІФ',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'культуру бактерій з такими властивостями: грамнегативна рухлива паличка, на середовищі Ендо росте у вигляді безбарвних колоній. Представником якого роду було зумовлене захворювання?',
    'Salmonella',
    'Shigella',
    'Iersinia',
    'Esherichia',
    'Citrobacter',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'розташовані мікроорганізми овоїдної форми довжиною до 2 мкм, інтенсивніше забарвлені на полюсах. Який найбільш імовірний діагноз можна встановити на підставі отриманих даних?',
    'Легенева форма чуми',
    'Пневмококова пневмонія',
    'Стафілококова пневмонія',
    'Клебсієльозна пневмонія',
    'Дифтерія',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'причиною може бути чума. Які постмортальні дослідження тварин слід провести з метою екстренного встановлення збудника інфекції?',
    'Реакція кільцепреципітації',
    'Реакція аглютинації',
    'Реакція пасивної аглютинації',
    'Реакція зв”язування комплементу',
    'Реакція нейтралізації',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'сибірку серед тварин. Яку серологічну реакцію необхідно застосувати для виявлення антигенів збудника в досліджуваному матеріалі?',
    'Реакцію термопреципітації',
    'Реакцію зв’язування комплементу',
    'Реакцію непрямої гемаглютинації',
    'Радіоімунний аналіз',
    'Реакцію преципітації в агарі',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'реакции иммунофлуоресценции. Опишите полученную при этом микроскопическую картину.',
    'Мелкие овоидные палочки с ярко-зеленым свечением',
    'Мелкие кокковидные бактерии розового цвета',
    'Крупные палочки с обрубленными концами фиолетового цвета',
    'Мелкие палочки с закругленными концами розового цвета',
    'Слегка изогнутые красные палочки, расположенные под углом',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'палочки овоидной формы с биполярной окраской, Грам-негативные, в мазке из бульонной культуры располагаются цепочками, на агаре образуют колонии R-формы. Это характерно для возбудителя',
    'чумы',
    'Туберкулеза',
    'Дифтерии',
    'Стрептококковой ангины',
    'Менингококкового назофарингита',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'підшкірної клітковини, у центрі карбункулу чорний  струп, по периферії везикулярні висипання навколо карбункулу. Мікробіологічне дослідження з’ясувало наявність нерухомих стрептобацил, які здатні утворювати капсули. Які мікроорганізми є збудниками  даної хвороби.',
    'Bacillus  antracis',
    'Staptylococcus  aureus',
    'Bacillus  anthracoides',
    'Bacillus  subtilis',
    'Bacillus  megaterium',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мiсцевостi. Хвороба супроводжувалася швидким  підвищенням температури до 40ºС, вираженою інтоксикацією, збільшенням пахових  лiмфовузлiв. У препаратах-мазках з трупного матеріалу виявлені грам- негативні палички овоїдної форми з біполярним забарвленням. Якi мікроорганізми  є збудниками цього інфекційного захворювання?',
    'Паличка чуми',
    'Стафілокок',
    'Збудник туляремії',
    'Збудник сибірки',
    'Клостридії',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'з підозрілим порошком. Чоловіка госпіталізували в ізолятор, а порошок з конверта скерували в лабораторію з метою дослідити на наявність спор збудника сибірки. Який метод дослідження дає можливість якнайшвидше виявити можливого збудника?',
    'Імунолюмінесцентний метод',
    'Реакція зв’язування комплементу',
    'Реакція преципітації в гелі',
    'Виділення чистої культури',
    'Біопроба на мишах.',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'колонії з нерівними краями. Мікроскопічно виявлено великі грам позитивні палички, які розташовувались у вигляді ланцюжка і містили спори. Якому з наведених збудників притаманні такі властивості?',
    'Bacillus anthracis',
    'Streptococcus pneumoniae',
    'Klebsiella  pneumoniae',
    'Mycobacterium tuberculosis',
    'Bordetella pertussis',
    'A'
);
INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer) VALUES (
    'мешканців селища . Для цієї хвороби було притаманне швидке підвищення температуридо 40С. , виражена інтоксикація, збільшення пахвиних лімфовузлів. Упрепаратах мазках з трупного матеріалу виявленні грам негативні палички овоїдної форми  з біполярним забарвленням. Які мікроорганізми є збудниками цього інфекційного захворювання?',
    'стафілокок',
    'збудник сибірки',
    'клостридії',
    'збудник  туляремії',
    'збудник чуми*',
    'A'
);