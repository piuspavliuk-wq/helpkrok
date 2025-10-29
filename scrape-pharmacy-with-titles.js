const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class PharmacyScraperWithTitles {
  constructor(config) {
    this.config = config;
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log(`🚀 Ініціалізація скрапера для ${this.config.title}...`);
    this.browser = await puppeteer.launch({
      headless: false,
      defaultViewport: null,
      args: ['--start-maximized']
    });
    this.page = await this.browser.newPage();
    
    // Налаштування сторінки
    await this.page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36');
    await this.page.goto(this.config.url, { waitUntil: 'networkidle2' });
    
    // Даємо час для завантаження сторінки
    await new Promise(resolve => setTimeout(resolve, 5000));
    
    console.log(`✅ Скрапер ініціалізовано для ${this.config.title}`);
    console.log(`⏳ Чекаємо 10 секунд для відкриття питань...`);
    await new Promise(resolve => setTimeout(resolve, 10000));
  }

  async scrapeTestTitle() {
    try {
      console.log('🔍 Шукаємо назву тесту...');
      
      // Різні селектори для пошуку назви тесту
      const titleSelectors = [
        'h1',
        'h2', 
        'h3',
        '.test-title',
        '.title',
        '[class*="title"]',
        '[class*="name"]',
        '.header h1',
        '.header h2',
        '.test-header h1',
        '.test-header h2'
      ];

      let testTitle = null;
      
      for (const selector of titleSelectors) {
        try {
          const element = await this.page.$(selector);
          if (element) {
            const text = await this.page.evaluate(el => el.textContent?.trim(), element);
            if (text && text.length > 0 && text.length < 100) {
              testTitle = text;
              console.log(`✅ Знайдено назву тесту: "${testTitle}"`);
              break;
            }
          }
        } catch (e) {
          // Продовжуємо пошук
        }
      }

      // Якщо не знайшли, використовуємо назву з конфігурації
      if (!testTitle) {
        testTitle = this.config.title;
        console.log(`⚠️ Використовуємо назву з конфігурації: "${testTitle}"`);
      }

      return testTitle;
    } catch (error) {
      console.error('❌ Помилка при пошуку назви тесту:', error);
      return this.config.title;
    }
  }

  async scrapeQuestions() {
    console.log(`📊 Починаємо скрапінг питань для ${this.config.title}...`);
    
    const questions = [];
    let questionNumber = 1;
    let hasNextQuestion = true;

    while (hasNextQuestion) {
      try {
        console.log(`🔍 Скрапимо питання ${questionNumber}...`);
        
        // Чекаємо завантаження питання
        await new Promise(resolve => setTimeout(resolve, 3000));
        
        // Скрапимо назву тесту (тільки для першого питання)
        let testTitle = null;
        if (questionNumber === 1) {
          testTitle = await this.scrapeTestTitle();
        }

        // Скрапимо текст питання
        const questionText = await this.page.evaluate(() => {
          const selectors = [
            '.question-text',
            '.question',
            '[class*="question"]',
            'p',
            'div[class*="text"]'
          ];
          
          for (const selector of selectors) {
            const element = document.querySelector(selector);
            if (element && element.textContent?.trim()) {
              return element.textContent.trim();
            }
          }
          return null;
        });

        if (!questionText) {
          console.log(`⚠️ Не знайдено текст питання ${questionNumber}`);
          break;
        }

        // Скрапимо варіанти відповідей
        const options = await this.page.evaluate(() => {
          const optionElements = document.querySelectorAll('[class*="option"], [class*="answer"], .choice, .variant');
          const options = [];
          
          optionElements.forEach((element, index) => {
            const text = element.textContent?.trim();
            if (text && text.length > 0) {
              const letter = String.fromCharCode(65 + index); // A, B, C, D, E
              options.push({
                letter: letter,
                text: text,
                is_correct: false // Буде визначено пізніше
              });
            }
          });
          
          return options;
        });

        // Скрапимо правильну відповідь
        const correctAnswer = await this.page.evaluate(() => {
          // Шукаємо позначену правильну відповідь
          const correctElements = document.querySelectorAll('[class*="correct"], [class*="right"], .selected, .active');
          for (const element of correctElements) {
            const text = element.textContent?.trim();
            if (text) {
              return text;
            }
          }
          return null;
        });

        // Визначаємо правильну відповідь
        let correctOptionLetter = 'A';
        if (correctAnswer && options.length > 0) {
          const correctOption = options.find(opt => opt.text.includes(correctAnswer) || correctAnswer.includes(opt.text));
          if (correctOption) {
            correctOption.is_correct = true;
            correctOptionLetter = correctOption.letter;
          } else {
            // Якщо не знайшли точну відповідь, встановлюємо першу як правильну
            options[0].is_correct = true;
            correctOptionLetter = options[0].letter;
          }
        } else if (options.length > 0) {
          // Якщо не знайшли правильну відповідь, встановлюємо першу
          options[0].is_correct = true;
          correctOptionLetter = options[0].letter;
        }

        // Скрапимо зображення питання
        const questionImage = await this.page.evaluate(() => {
          const imgElement = document.querySelector('img');
          if (imgElement && imgElement.src) {
            return imgElement.src;
          }
          return null;
        });

        // Скрапимо зображення варіантів
        const optionImages = {};
        if (options.length > 0) {
          const images = await this.page.evaluate(() => {
            const imgElements = document.querySelectorAll('img');
            const images = {};
            imgElements.forEach((img, index) => {
              if (img.src && index < 5) { // Максимум 5 зображень
                const letter = String.fromCharCode(65 + index);
                images[letter] = img.src;
              }
            });
            return images;
          });
          Object.assign(optionImages, images);
        }

        const question = {
          id: questionNumber,
          question_text: questionText,
          year: this.config.year,
          faculty: this.config.faculty,
          category: 'pharmacy',
          difficulty: 'medium',
          correct_answer: correctOptionLetter,
          title: testTitle || this.config.title,
          test_identifier: this.config.testIdentifier,
          question_image: questionImage,
          option_images: Object.keys(optionImages).length > 0 ? optionImages : null,
          options: options,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        };

        questions.push(question);
        console.log(`✅ Питання ${questionNumber} збережено (${options.length} варіантів)`);

        // Шукаємо кнопку "Наступне"
        let nextButton = await this.page.$('button[class*="next"], .next, [class*="next"]');
        
        // Fallback - шукаємо кнопку за текстом
        if (!nextButton) {
          nextButton = await this.page.$x("//button[contains(text(), 'Наступне') or contains(text(), 'Next') or contains(text(), 'Далі')]");
          if (nextButton && nextButton.length > 0) {
            nextButton = nextButton[0];
          }
        }
        
        if (nextButton) {
          await nextButton.click();
          await new Promise(resolve => setTimeout(resolve, 2000));
          questionNumber++;
        } else {
          console.log(`🏁 Достигнуто кінець тесту (${questions.length} питань)`);
          hasNextQuestion = false;
        }

      } catch (error) {
        console.error(`❌ Помилка при скрапінгу питання ${questionNumber}:`, error);
        hasNextQuestion = false;
      }
    }

    return questions;
  }

  async saveData(questions, filename) {
    const dataDir = path.join(__dirname, 'data');
    if (!fs.existsSync(dataDir)) {
      fs.mkdirSync(dataDir, { recursive: true });
    }

    const filepath = path.join(dataDir, filename);
    fs.writeFileSync(filepath, JSON.stringify(questions, null, 2));
    console.log(`💾 Дані збережено: ${filepath}`);
    return filepath;
  }

  async generateSQL(questions, filename, year, faculty, testIdentifier, title) {
    const dataDir = path.join(__dirname, 'data');
    const sqlFilename = filename.replace('.json', '.sql');
    const sqlFilepath = path.join(dataDir, sqlFilename);

    let sql = `-- SQL для імпорту питань фармації ${year}\n`;
    sql += `-- Кількість питань: ${questions.length}\n`;
    sql += `-- Назва тесту: ${title}\n\n`;

    questions.forEach((question, index) => {
      const questionImage = question.question_image ? `'${question.question_image}'` : 'NULL';
      const optionImages = question.option_images ? 
        `'${JSON.stringify(question.option_images).replace(/'/g, "''")}'` : 'NULL';
      
      sql += `INSERT INTO krok_questions_unified_pharmacy (\n`;
      sql += `  question_text, year, faculty, category, difficulty,\n`;
      sql += `  option_a, option_b, option_c, option_d, option_e,\n`;
      sql += `  correct_answer, title, test_identifier,\n`;
      sql += `  question_image, option_images, options,\n`;
      sql += `  created_at, updated_at\n`;
      sql += `) VALUES (\n`;
      sql += `  '${question.question_text.replace(/'/g, "''")}',\n`;
      sql += `  ${year},\n`;
      sql += `  '${faculty}',\n`;
      sql += `  '${question.category}',\n`;
      sql += `  '${question.difficulty}',\n`;
      sql += `  '${question.options[0]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[1]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[2]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[3]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[4]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.correct_answer}',\n`;
      sql += `  '${title.replace(/'/g, "''")}',\n`;
      sql += `  '${testIdentifier}',\n`;
      sql += `  ${questionImage},\n`;
      sql += `  ${optionImages},\n`;
      sql += `  '${JSON.stringify(question.options).replace(/'/g, "''")}',\n`;
      sql += `  '${question.created_at}',\n`;
      sql += `  '${question.updated_at}'\n`;
      sql += `);\n\n`;
    });

    fs.writeFileSync(sqlFilepath, sql);
    console.log(`📄 SQL файл згенеровано: ${sqlFilepath}`);
    return sqlFilepath;
  }

  async run() {
    try {
      await this.init();
      const questions = await this.scrapeQuestions();
      
      if (questions.length === 0) {
        console.log('❌ Не знайдено питань для скрапінгу');
        return;
      }

      const timestamp = Date.now();
      const jsonFilename = `${this.config.year}-pharmacy-questions-${timestamp}.json`;
      const sqlFilename = `${this.config.year}-pharmacy-questions-${timestamp}.sql`;
      
      await this.saveData(questions, jsonFilename);
      await this.generateSQL(questions, jsonFilename, this.config.year, this.config.faculty, this.config.testIdentifier, this.config.title);
      
      console.log(`🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
      
    } catch (error) {
      console.error('❌ Помилка скрапінгу:', error);
    } finally {
      if (this.browser) {
        await this.browser.close();
      }
    }
  }
}

// Конфігурації для 10 років фармації
const pharmacyConfigs = {
  '2012-pharmacy': {
    year: 2012,
    faculty: 'pharmacy',
    testIdentifier: '2012-pharmacy',
    title: '2012 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 60
  },
  '2013-pharmacy': {
    year: 2013,
    faculty: 'pharmacy',
    testIdentifier: '2013-pharmacy',
    title: '2013 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 120
  },
  '2014-pharmacy': {
    year: 2014,
    faculty: 'pharmacy',
    testIdentifier: '2014-pharmacy',
    title: '2014 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 180
  },
  '2015-pharmacy': {
    year: 2015,
    faculty: 'pharmacy',
    testIdentifier: '2015-pharmacy',
    title: '2015 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 240
  },
  '2016-pharmacy': {
    year: 2016,
    faculty: 'pharmacy',
    testIdentifier: '2016-pharmacy',
    title: '2016 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 300
  },
  '2017-pharmacy': {
    year: 2017,
    faculty: 'pharmacy',
    testIdentifier: '2017-pharmacy',
    title: '2017 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 360
  },
  '2018-pharmacy': {
    year: 2018,
    faculty: 'pharmacy',
    testIdentifier: '2018-pharmacy',
    title: '2018 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 420
  },
  '2019-pharmacy': {
    year: 2019,
    faculty: 'pharmacy',
    testIdentifier: '2019-pharmacy',
    title: '2019 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 480
  },
  '2020-pharmacy': {
    year: 2020,
    faculty: 'pharmacy',
    testIdentifier: '2020-pharmacy',
    title: '2020 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 540
  },
  '2021-pharmacy': {
    year: 2021,
    faculty: 'pharmacy',
    testIdentifier: '2021-pharmacy',
    title: '2021 рік',
    url: 'https://krok-lead.com',
    timerSeconds: 600
  }
};

async function scrapePharmacyWithTitles(config) {
  const scraper = new PharmacyScraperWithTitles(config);
  await scraper.run();
}

async function main() {
  const args = process.argv.slice(2);
  
  if (args.length === 0) {
    console.log('🚀 ЗАПУСКАЄМО ВСІ 10 СКРАПЕРІВ З ІНТЕРВАЛОМ...');
    console.log('');
    
    const configs = Object.values(pharmacyConfigs);
    
    for (let i = 0; i < configs.length; i++) {
      const config = configs[i];
      const delay = config.timerSeconds * 1000; // Конвертуємо в мілісекунди
      
      console.log(`📊 Запускаємо скрапер ${i + 1}/10 - ${config.title}:`);
      console.log(`   Рік: ${config.year}`);
      console.log(`   Інтервал: ${config.timerSeconds} секунд`);
      console.log('');
      
      // Запускаємо скрапер
      scrapePharmacyWithTitles(config).catch(console.error);
      
      // Чекаємо перед наступним скрапером (крім останнього)
      if (i < configs.length - 1) {
        console.log(`⏳ Чекаємо ${config.timerSeconds} секунд перед наступним скрапером...`);
        await new Promise(resolve => setTimeout(resolve, delay));
        console.log('');
      }
    }
    
    console.log('🎉 Всі скрапери запущено!');
    
  } else {
    const configKey = args[0];
    const config = pharmacyConfigs[configKey];
    
    if (!config) {
      console.error(`❌ Невідома конфігурація: ${configKey}`);
      console.log('Доступні конфігурації:', Object.keys(pharmacyConfigs).join(', '));
      return;
    }
    
    console.log(`🚀 Запускаємо скрапер для ${config.title}...`);
    await scrapePharmacyWithTitles(config);
  }
}

if (require.main === module) {
  main().catch(console.error);
}

module.exports = { PharmacyScraperWithTitles, scrapePharmacyWithTitles };
