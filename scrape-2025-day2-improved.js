const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class ImprovedKrokScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запускаємо браузер...');
    this.browser = await puppeteer.launch({
      headless: false,
      defaultViewport: null,
      args: ['--start-maximized']
    });
    
    this.page = await this.browser.newPage();
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
  }

  async navigateToTest(url) {
    console.log(`📖 Переходимо на сторінку: ${url}`);
    await this.page.goto(url, { waitUntil: 'networkidle2' });
    await this.waitFor(3000);
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
    let currentHeight = await this.page.evaluate(() => document.body.scrollHeight);
    let scrollAttempts = 0;
    const maxScrollAttempts = 20;
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      // Прокручуємо поступово
      await this.page.evaluate(() => {
        window.scrollTo(0, document.body.scrollHeight);
      });
      
      await this.waitFor(2000);
      
      // Перевіряємо чи завантажились нові питання
      const questionCount = await this.page.evaluate(() => {
        return document.querySelectorAll('.question__content').length;
      });
      
      console.log(`📊 Завантажено ${questionCount} питань...`);
      
      currentHeight = await this.page.evaluate(() => document.body.scrollHeight);
      scrollAttempts++;
    }
    
    console.log('✅ Всі питання завантажено!');
  }

  async extractQuestionData() {
    console.log('📝 Витягуємо дані питань...');
    
    const questions = await this.page.evaluate(() => {
      const questionElements = document.querySelectorAll('.question__content');
      const extractedQuestions = [];
      
      console.log(`Знайдено ${questionElements.length} питань на сторінці`);
      
      questionElements.forEach((questionEl, index) => {
        try {
          // Текст питання
          const questionTextEl = questionEl.querySelector('.question__text');
          const questionText = questionTextEl ? questionTextEl.textContent.trim() : '';
          
          if (!questionText) {
            console.log(`Питання ${index + 1}: немає тексту`);
            return;
          }
          
          // Варіанти відповідей
          const variants = questionEl.querySelectorAll('.question__variant');
          const options = [];
          let correctAnswer = '';
          
          variants.forEach((variant, variantIndex) => {
            const text = variant.textContent.trim();
            const letter = String.fromCharCode(65 + variantIndex); // A, B, C, D, E
            
            if (text) {
              options.push(text);
              
              // Перевіряємо чи це правильна відповідь
              if (variant.classList.contains('question__variant_right') || 
                  variant.querySelector('.icon-kl-check') ||
                  variant.querySelector('[class*="check"]') ||
                  variant.querySelector('.text-positive')) {
                correctAnswer = letter;
              }
            }
          });
          
          if (questionText && options.length >= 2) {
            extractedQuestions.push({
              question_text: questionText,
              option_a: options[0] || '',
              option_b: options[1] || '',
              option_c: options[2] || '',
              option_d: options[3] || '',
              option_e: options[4] || '',
              correct_answer: correctAnswer
            });
            
            console.log(`Питання ${index + 1}: "${questionText.substring(0, 50)}..." - ${options.length} варіантів, правильна: ${correctAnswer}`);
          } else {
            console.log(`Питання ${index + 1}: невалідне (текст: ${!!questionText}, варіанти: ${options.length})`);
          }
        } catch (error) {
          console.log(`Помилка при обробці питання ${index + 1}:`, error.message);
        }
      });
      
      return extractedQuestions;
    });
    
    console.log(`✅ Витягнуто ${questions.length} питань`);
    
    // Статистика
    const withCorrectAnswers = questions.filter(q => q.correct_answer).length;
    console.log(`📊 Статистика:`);
    console.log(`   - Загалом питань: ${questions.length}`);
    console.log(`   - З правильними відповідями: ${withCorrectAnswers}`);
    console.log(`   - Без правильних відповідей: ${questions.length - withCorrectAnswers}`);
    
    return questions;
  }

  async saveData(questions, filename) {
    const dataDir = path.join(__dirname, 'data');
    if (!fs.existsSync(dataDir)) {
      fs.mkdirSync(dataDir);
    }
    
    const filepath = path.join(dataDir, filename);
    fs.writeFileSync(filepath, JSON.stringify(questions, null, 2));
    console.log(`💾 Дані збережено в: ${filepath}`);
    return filepath;
  }

  async generateSQL(questions, filename, year, faculty, testIdentifier, title) {
    console.log('📄 Генеруємо SQL файл...');
    
    const dataDir = path.join(__dirname, 'data');
    const sqlFilename = filename.replace('.json', '.sql');
    const filepath = path.join(dataDir, sqlFilename);
    
    let sql = `-- SQL для імпорту тесту "${title}"\n`;
    sql += `-- Рік: ${year}, Факультет: ${faculty}, Test ID: ${testIdentifier}\n`;
    sql += `-- Кількість питань: ${questions.length}\n\n`;
    
    questions.forEach((question, index) => {
      const escapedQuestion = question.question_text.replace(/'/g, "''");
      const escapedA = (question.option_a || '').replace(/'/g, "''");
      const escapedB = (question.option_b || '').replace(/'/g, "''");
      const escapedC = (question.option_c || '').replace(/'/g, "''");
      const escapedD = (question.option_d || '').replace(/'/g, "''");
      const escapedE = (question.option_e || '').replace(/'/g, "''");
      
      sql += `INSERT INTO krok_questions_unified (
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
    return filepath;
  }

  async closeBrowser() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

async function scrapeImproved(url) {
  const scraper = new ImprovedKrokScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // 30-секундний таймер для ручного налаштування
    await scraper.waitWithTimer(30);
    
    await scraper.scrollToLoadAllQuestions();
    
    const questions = await scraper.extractQuestionData();
    
    if (questions.length === 0) {
      console.log('❌ Не знайдено питань!');
      return [];
    }
    
    const timestamp = Date.now();
    const jsonFilename = `2025-day2-improved-questions-${timestamp}.json`;
    await scraper.saveData(questions, jsonFilename);
    
    return questions;
  } catch (error) {
    console.error('❌ Помилка при скрапінгу:', error);
    return [];
  } finally {
    await scraper.closeBrowser();
  }
}

async function main() {
  console.log('🎯 ПОКРАЩЕНИЙ СКРАПЕР для тесту "2025р 2 д"');
  console.log('📋 Параметри:');
  console.log('   - Рік: 2025');
  console.log('   - Факультет: medical');
  console.log('   - Test ID: 2025-day2');
  console.log('   - Назва: 2025р 2 д');
  console.log('');
  
  const url = 'https://krok-lead.com';
  
  console.log('🚀 Запускаємо покращений скрапінг...');
  console.log('📖 Відкрийте потрібну сторінку тесту в браузері');
  console.log('⏰ У вас буде 30 секунд для налаштування правильних відповідей');
  console.log('🔄 Покращена логіка прокрутки та збору даних');
  console.log('');
  
  const questions = await scrapeImproved(url);
  
  if (questions.length > 0) {
    console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
    
    // Генеруємо SQL
    const timestamp = Date.now();
    const sqlFilename = `2025-day2-improved-questions-${timestamp}.sql`;
    const scraper = new ImprovedKrokScraper();
    await scraper.generateSQL(questions, sqlFilename, 2025, 'medical', '2025-day2', '2025р 2 д');
    
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте зібрані дані в JSON файлі');
    console.log('2. Виконайте SQL файл в Supabase');
    console.log('3. Перевірте відображення на сайті');
  } else {
    console.log('❌ Скрапінг не вдався');
  }
}

// Запускаємо покращений скрапер
main().catch(console.error);
