const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class Day2TextScraper {
  constructor() {
    this.browser = null;
    this.page = null;
    this.questions = [];
  }

  async init() {
    console.log('🚀 Запуск браузера для збору 2025р 2 д (ТЕХТ)...');
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
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
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
      await this.waitFor(5000);
      console.log('✅ Сторінка завантажена');
    } catch (error) {
      console.log('⚠️ Помилка при завантаженні сторінки:', error.message);
      throw error;
    }
  }

  async waitFor(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async waitWithTimer(seconds) {
    console.log(`\n⏰ ТАЙМЕР ${seconds} СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ`);
    console.log('📋 Підготуйте сторінку:');
    console.log('   1. Відкрийте потрібний тест');
    console.log('   2. Переконайтеся що відповіді показані');
    console.log('   3. Переконайтеся що всі питання завантажені');
    console.log('   4. Прокрутіть до початку');
    
    for (let i = seconds; i > 0; i--) {
      process.stdout.write(`\r⏳ Залишилось: ${i} секунд...`);
      await this.waitFor(1000);
    }
    console.log('\n✅ Таймер завершено! Починаємо збір даних...\n');
  }

  async scrapeQuestions() {
    console.log('🔍 Початок збору питань...');
    
    try {
      // Очікуємо завантаження питань
      await this.page.waitForSelector('.question__content', { timeout: 10000 });
      
      // Отримуємо загальну кількість питань
      const totalQuestions = await this.page.evaluate(() => {
        const questions = document.querySelectorAll('.question__content');
        return questions.length;
      });
      
      console.log(`📊 Знайдено ${totalQuestions} питань`);
      
      // Збираємо всі питання
      for (let i = 0; i < totalQuestions; i++) {
        console.log(`\n📝 Обробка питання ${i + 1}/${totalQuestions}`);
        
        try {
          // Прокручуємо до питання
          await this.page.evaluate((index) => {
            const questions = document.querySelectorAll('.question__content');
            if (questions[index]) {
              questions[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
          }, i);
          
          await this.waitFor(1000);
          
          // Збираємо дані питання
          const questionData = await this.page.evaluate((index) => {
            const questions = document.querySelectorAll('.question__content');
            const question = questions[index];
            
            if (!question) return null;
            
            // Текст питання
            const questionText = question.querySelector('.question__text')?.textContent?.trim() || '';
            
            // Варіанти відповідей
            const variants = question.querySelectorAll('.question__variant');
            const options = {};
            let correctAnswer = '';
            
            variants.forEach((variant, idx) => {
              const letter = variant.querySelector('span')?.textContent?.trim() || '';
              const isCorrect = variant.classList.contains('question__variant_right');
              
              if (letter && letter.length === 1) {
                options[`option_${letter.toLowerCase()}`] = letter;
                if (isCorrect) {
                  correctAnswer = letter;
                }
              }
            });
            
            return {
              question_text: questionText,
              option_a: options.option_a || '',
              option_b: options.option_b || '',
              option_c: options.option_c || '',
              option_d: options.option_d || '',
              option_e: options.option_e || '',
              correct_answer: correctAnswer,
              year: 2025,
              faculty: 'medical',
              test_identifier: '2025-day2-text',
              category: 'Загальна медицина'
            };
          }, i);
          
          if (questionData && questionData.question_text) {
            this.questions.push(questionData);
            console.log(`✅ Питання ${i + 1}: "${questionData.question_text.substring(0, 50)}..."`);
            console.log(`   Правильна відповідь: ${questionData.correct_answer}`);
          } else {
            console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати дані`);
          }
          
        } catch (error) {
          console.log(`❌ Помилка при обробці питання ${i + 1}:`, error.message);
        }
      }
      
      console.log(`\n🎉 Збір завершено! Зібрано ${this.questions.length} питань`);
      
    } catch (error) {
      console.log('❌ Помилка при зборі питань:', error.message);
      throw error;
    }
  }

  async saveToFile() {
    if (this.questions.length === 0) {
      console.log('⚠️ Немає питань для збереження');
      return;
    }

    const timestamp = Date.now();
    const filename = `2025-day2-text-questions-${timestamp}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    // Створюємо папку data якщо не існує
    const dataDir = path.join(__dirname, 'data');
    if (!fs.existsSync(dataDir)) {
      fs.mkdirSync(dataDir, { recursive: true });
    }
    
    const data = {
      metadata: {
        total_questions: this.questions.length,
        year: 2025,
        faculty: 'medical',
        test_identifier: '2025-day2-text',
        scraped_at: new Date().toISOString(),
        source: 'krok-lead.com'
      },
      questions: this.questions
    };
    
    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 Дані збережено в файл: ${filename}`);
    console.log(`📁 Повний шлях: ${filepath}`);
    
    return filepath;
  }

  async generateSQL(filepath) {
    if (this.questions.length === 0) {
      console.log('⚠️ Немає питань для генерації SQL');
      return;
    }

    const timestamp = Date.now();
    const sqlFilename = `2025-day2-text-questions-${timestamp}.sql`;
    const sqlFilepath = path.join(__dirname, 'data', sqlFilename);
    
    let sql = `-- SQL для імпорту питань 2025р 2 д (ТЕХТ)
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${this.questions.length}

INSERT INTO krok_questions_unified (
    question_text, year, faculty, category, difficulty, is_active,
    option_a, option_b, option_c, option_d, option_e, correct_answer,
    test_identifier, title, created_at, updated_at
) VALUES
`;

    const values = this.questions.map((q, index) => {
      const escapedText = q.question_text.replace(/'/g, "''");
      return `(
    '${escapedText}',
    ${q.year},
    '${q.faculty}',
    '${q.category}',
    'medium',
    true,
    '${q.option_a}',
    '${q.option_b}',
    '${q.option_c}',
    '${q.option_d}',
    '${q.option_e}',
    '${q.correct_answer}',
    '${q.test_identifier}',
    '2025р 2 д (ТЕХТ)',
    NOW(),
    NOW()
)`;
    });

    sql += values.join(',\n') + ';';
    
    fs.writeFileSync(sqlFilepath, sql, 'utf8');
    console.log(`📄 SQL згенеровано: ${sqlFilename}`);
    console.log(`📁 Повний шлях: ${sqlFilepath}`);
    
    return sqlFilepath;
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }

  async run() {
    try {
      await this.init();
      
      console.log('\n🎯 ІНСТРУКЦІЇ ДЛЯ КОРИСТУВАЧА:');
      console.log('1. Відкрийте браузер');
      console.log('2. Перейдіть на krok-lead.com');
      console.log('3. Знайдіть тест "2025р 2 д (ТЕХТ)"');
      console.log('4. Відкрийте тест і переконайтеся що відповіді показані');
      console.log('5. Натисніть Enter коли будете готові...\n');
      
      // Очікуємо натискання Enter
      await new Promise(resolve => {
        process.stdin.once('data', () => resolve());
      });
      
      // Отримуємо поточний URL
      const currentUrl = this.page.url();
      console.log(`📍 Поточний URL: ${currentUrl}`);
      
      // Таймер для підготовки
      await this.waitWithTimer(10);
      
      // Збираємо питання
      await this.scrapeQuestions();
      
      // Зберігаємо дані
      const jsonFile = await this.saveToFile();
      const sqlFile = await this.generateSQL(jsonFile);
      
      console.log('\n🎉 СКРАПІНГ ЗАВЕРШЕНО!');
      console.log(`📊 Зібрано: ${this.questions.length} питань`);
      console.log(`📄 JSON файл: ${jsonFile}`);
      console.log(`📄 SQL файл: ${sqlFile}`);
      
    } catch (error) {
      console.error('❌ Помилка:', error);
    } finally {
      await this.close();
    }
  }
}

// Запуск скрапера
const scraper = new Day2TextScraper();
scraper.run().catch(console.error);
