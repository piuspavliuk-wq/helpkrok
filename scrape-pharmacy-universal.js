const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class PharmacyKrokScraper {
  constructor(config) {
    this.browser = null;
    this.page = null;
    this.config = config;
  }

  async init() {
    console.log('🏥 Запуск браузера для фармацевтичного факультету...');
    this.browser = await puppeteer.launch({
      headless: false,
      defaultViewport: null,
      args: [
        '--start-maximized',
        '--disable-web-security',
        '--disable-features=VizDisplayCompositor',
        '--no-sandbox',
        '--disable-setuid-sandbox'
      ]
    });
    
    this.page = await this.browser.newPage();
    
    // Налаштування User-Agent
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
    
    // Налаштування таймаутів
    this.page.setDefaultTimeout(30000);
    this.page.setDefaultNavigationTimeout(60000);
  }

  async navigateToTest(url) {
    console.log(`📖 Перехід на сторінку: ${url}`);
    
    try {
      await this.page.goto(url, { 
        waitUntil: 'domcontentloaded',
        timeout: 60000 
      });
      
      // Чекаємо завантаження
      await this.waitFor(5000);
      
      console.log('✅ Сторінка завантажена');
      
    } catch (error) {
      console.error('❌ Помилка при переході на сторінку:', error.message);
      throw error;
    }
  }

  async waitFor(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async waitWithTimer(seconds) {
    console.log(`\n⏰ ТАЙМЕР ${seconds} СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ`);
    console.log('📋 Швидкі інструкції:');
    console.log('1. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('2. Натисніть на неї');
    console.log('3. Виберіть "Показувати правильні відповіді"');
    console.log('4. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('5. Чекайте завершення таймера...\n');
    for (let i = seconds; i > 0; i--) {
      console.log(`⏳ Залишилось: ${i} секунд...`);
      await this.waitFor(1000);
    }
    console.log('🚀 Таймер завершено! Продовжуємо збір даних...\n');
  }

  async scrollToLoadAllQuestions() {
    console.log('📜 Прокручуємо сторінку для завантаження всіх питань...');
    
    let previousHeight = 0;
    let currentHeight = 0;
    let scrollAttempts = 0;
    const maxScrollAttempts = 15;
    
    do {
      previousHeight = currentHeight;
      
      // Прокручуємо вниз
      await this.page.evaluate(() => {
        window.scrollTo(0, document.body.scrollHeight);
      });
      
      // Чекаємо завантаження нових питань
      await this.waitFor(2000);
      
      // Отримуємо поточну висоту
      currentHeight = await this.page.evaluate(() => document.body.scrollHeight);
      
      // Рахуємо кількість питань
      const questionCount = await this.page.$$eval('.question', elements => elements.length);
      
      scrollAttempts++;
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
      console.log(`📊 Поточна кількість питань: ${questionCount}`);
      
    } while (currentHeight > previousHeight && scrollAttempts < maxScrollAttempts);
    
    console.log('✅ Всі питання завантажено!');
  }

  async clickOnEachQuestionIndividually() {
    console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    
    const questions = await this.page.$$('.question');
    console.log(`📊 Знайдено ${questions.length} питань`);
    
    const collectedQuestions = [];
    
    for (let i = 0; i < questions.length; i++) {
      try {
        console.log(`🔄 Обробка питання ${i + 1}/${questions.length}...`);
        
        // Клікаємо на питання
        await questions[i].click();
        await this.waitFor(500);
        
        // Клікаємо на всі варіанти відповідей
        const variants = await questions[i].$$('.question__variant');
        for (const variant of variants) {
          try {
            await variant.click();
            await this.waitFor(100);
          } catch (e) {
            // Ігноруємо помилки кліків
          }
        }
        
        // Витягуємо дані питання
        const questionData = await this.extractQuestionDataFromElement(questions[i]);
        if (questionData) {
          collectedQuestions.push(questionData);
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData).filter(k => k.startsWith('option_')).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати варіанти`);
        }
        
        // Показуємо прогрес кожні 10 питань
        if ((i + 1) % 10 === 0) {
          console.log(`📊 Прогрес: ${i + 1}/${questions.length} питань, зібрано: ${collectedQuestions.length}`);
        }
        
      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i + 1}:`, error.message);
      }
    }
    
    console.log(`✅ Індивідуальні кліки завершено. Зібрано ${collectedQuestions.length} питань`);
    return collectedQuestions;
  }

  async extractQuestionDataFromElement(questionElement) {
    try {
      const questionText = await questionElement.$eval('.question__text', el => el.textContent.trim());
      
      const variants = await questionElement.$$('.question__variant');
      const options = {};
      let correctAnswer = null;
      
      for (let i = 0; i < variants.length; i++) {
        const variant = variants[i];
        const text = await variant.$eval('span', el => el.textContent.trim());
        const letter = String.fromCharCode(65 + i); // A, B, C, D, E
        
        options[`option_${letter.toLowerCase()}`] = text;
        
        // Перевіряємо чи це правильна відповідь
        const isCorrect = await variant.evaluate(el => {
          return el.classList.contains('question__variant_right') || 
                 el.querySelector('.icon-kl-check') !== null ||
                 el.querySelector('[class*="check"]') !== null;
        });
        
        if (isCorrect) {
          correctAnswer = letter;
        }
      }
      
      return {
        question_text: questionText,
        ...options,
        correct_answer: correctAnswer
      };
      
    } catch (error) {
      console.log('❌ Помилка при витягуванні даних питання:', error.message);
      return null;
    }
  }

  async saveData(questions, filename) {
    const filepath = path.join('data', filename);
    fs.writeFileSync(filepath, JSON.stringify(questions, null, 2));
    console.log(`💾 Дані збережено в: ${filepath}`);
  }

  async generateSQL(questions, filename, year, faculty, testIdentifier, title) {
    const filepath = path.join('data', filename);
    
    let sql = `-- SQL для імпорту тесту "${title}" (фармація)\n`;
    sql += `-- Рік: ${year}, Факультет: ${faculty}, Test ID: ${testIdentifier}\n`;
    sql += `-- Кількість питань: ${questions.length}\n\n`;
    
    questions.forEach((question, index) => {
      const escapedQuestion = question.question_text.replace(/'/g, "''");
      const escapedA = (question.option_a || '').replace(/'/g, "''");
      const escapedB = (question.option_b || '').replace(/'/g, "''");
      const escapedC = (question.option_c || '').replace(/'/g, "''");
      const escapedD = (question.option_d || '').replace(/'/g, "''");
      const escapedE = (question.option_e || '').replace(/'/g, "''");
      
      sql += `INSERT INTO krok_questions_unified_pharmacy (
  year, faculty, test_identifier, title, category, difficulty,
  question_text, option_a, option_b, option_c, option_d, option_e, correct_answer,
  is_active, created_at, updated_at
) VALUES (
  ${year}, '${faculty}', '${testIdentifier}', '${title}', 'general', 'medium',
  '${escapedQuestion}',
  '${escapedA}',
  '${escapedB}',
  '${escapedC}',
  '${escapedD}',
  '${escapedE}',
  '${question.correct_answer}',
  true, NOW(), NOW()
);\n\n`;
    });
    
    fs.writeFileSync(filepath, sql);
    console.log(`📄 SQL файл збережено: ${filepath}`);
  }

  async closeBrowser() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

async function scrapePharmacy(config) {
  const scraper = new PharmacyKrokScraper(config);
  
  try {
    await scraper.init();
    await scraper.navigateToTest(config.url);
    await scraper.waitWithTimer(config.timerSeconds);
    
    console.log('\n📜 Прокручуємо сторінку для завантаження всіх питань...');
    await scraper.scrollToLoadAllQuestions();
    console.log('✅ Всі питання завантажено!');
    
    console.log('\n🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    const questions = await scraper.clickOnEachQuestionIndividually();
    
    if (questions.length > 0) {
      console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
      
      // Зберігаємо дані в JSON
      const timestamp = Date.now();
      const jsonFilename = `${config.testIdentifier}-questions-${timestamp}.json`;
      await scraper.saveData(questions, jsonFilename);
      
      // Генеруємо SQL
      const sqlFilename = `${config.testIdentifier}-questions-${timestamp}.sql`;
      await scraper.generateSQL(questions, sqlFilename, config.year, config.faculty, config.testIdentifier, config.title);
      
      return questions;
    } else {
      console.log('\n❌ Скрапінг не зібрав питань.');
      return [];
    }
    
  } finally {
    await scraper.closeBrowser();
  }
}

// Конфігурації для фармації 2007-2017
const pharmacyConfigs = {
  '2007-pharmacy': {
    year: 2007,
    faculty: 'pharmacy',
    testIdentifier: '2007-pharmacy',
    title: '2007 рік 1',
    url: 'https://krok-lead.com',
    timerSeconds: 60
  },
  '2008-pharmacy': {
    year: 2008,
    faculty: 'pharmacy',
    testIdentifier: '2008-pharmacy',
    title: '2008 рік 2',
    url: 'https://krok-lead.com',
    timerSeconds: 120
  },
  '2009-pharmacy': {
    year: 2009,
    faculty: 'pharmacy',
    testIdentifier: '2009-pharmacy',
    title: '2009 рік 3',
    url: 'https://krok-lead.com',
    timerSeconds: 180
  },
  '2010-pharmacy': {
    year: 2010,
    faculty: 'pharmacy',
    testIdentifier: '2010-pharmacy',
    title: '2010 рік 4',
    url: 'https://krok-lead.com',
    timerSeconds: 240
  },
  '2011-pharmacy': {
    year: 2011,
    faculty: 'pharmacy',
    testIdentifier: '2011-pharmacy',
    title: '2011 рік 5',
    url: 'https://krok-lead.com',
    timerSeconds: 300
  },
  '2012-pharmacy': {
    year: 2012,
    faculty: 'pharmacy',
    testIdentifier: '2012-pharmacy',
    title: '2012 рік 6',
    url: 'https://krok-lead.com',
    timerSeconds: 360
  },
  '2013-pharmacy': {
    year: 2013,
    faculty: 'pharmacy',
    testIdentifier: '2013-pharmacy',
    title: '2013 рік 7',
    url: 'https://krok-lead.com',
    timerSeconds: 420
  },
  '2014-pharmacy': {
    year: 2014,
    faculty: 'pharmacy',
    testIdentifier: '2014-pharmacy',
    title: '2014 рік 8',
    url: 'https://krok-lead.com',
    timerSeconds: 480
  },
  '2015-pharmacy': {
    year: 2015,
    faculty: 'pharmacy',
    testIdentifier: '2015-pharmacy',
    title: '2015 рік 9',
    url: 'https://krok-lead.com',
    timerSeconds: 540
  },
  '2016-pharmacy': {
    year: 2016,
    faculty: 'pharmacy',
    testIdentifier: '2016-pharmacy',
    title: '2016 рік 10',
    url: 'https://krok-lead.com',
    timerSeconds: 600
  },
  '2017-pharmacy': {
    year: 2017,
    faculty: 'pharmacy',
    testIdentifier: '2017-pharmacy',
    title: '2017 рік 11',
    url: 'https://krok-lead.com',
    timerSeconds: 660
  }
};

async function main() {
  const testName = process.argv[2];

  if (!testName) {
    console.log('🏥 ФАРМАЦЕВТИЧНИЙ СКРАПЕР КРОК');
    console.log('\n📋 Доступні тести:');
    Object.keys(pharmacyConfigs).forEach(key => {
      const config = pharmacyConfigs[key];
      console.log(`   - ${key}: ${config.title} (${config.year})`);
    });
    console.log('\n🚀 Використання:');
    console.log('   node scrape-pharmacy-universal.js <test-name>');
    console.log('\n📝 Приклад:');
    console.log('   node scrape-pharmacy-universal.js 2007-pharmacy');
    return;
  }
  
  const config = pharmacyConfigs[testName];
  
  if (!config) {
    console.log('❌ Тест не знайдено!');
    console.log('📋 Доступні тести:');
    Object.keys(pharmacyConfigs).forEach(key => {
      const config = pharmacyConfigs[key];
      console.log(`   - ${key}: ${config.title} (${config.year})`);
    });
    return;
  }
  
  console.log(`🏥 ФАРМАЦЕВТИЧНИЙ СКРАПЕР для тесту "${config.title}"`);
  console.log('📋 Параметри:');
  console.log(`   - Рік: ${config.year}`);
  console.log(`   - Факультет: ${config.faculty}`);
  console.log(`   - Test ID: ${config.testIdentifier}`);
  console.log(`   - Назва: ${config.title}`);
  console.log(`   - Таймер: ${config.timerSeconds} секунд`);
  console.log('');
  
  console.log('🚀 Запускаємо фармацевтичний скрапінг...');
  console.log('📖 Відкрийте потрібну сторінку тесту в браузері');
  console.log(`⏰ У вас буде ${config.timerSeconds} секунд для налаштування правильних відповідей`);
  console.log('🔄 Індивідуальні кліки на кожне питання для розкриття варіантів');
  console.log('');
  
  const questions = await scrapePharmacy(config);
  
  if (questions.length > 0) {
    console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
    
    // Показуємо статистику
    const correctAnswersCount = questions.filter(q => q.correct_answer).length;
    console.log('\n📊 Статистика:');
    console.log(`- Всього питань: ${questions.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);
    
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте зібрані дані в JSON файлі');
    console.log('2. Виконайте SQL файл в Supabase');
    console.log('3. Перевірте відображення на сайті');
  } else {
    console.log('\n❌ Скрапінг не зібрав питань.');
  }
}

main().catch(console.error);
