const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class AdvancedKrokScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера з індивідуальними кліками на кожне питання...');
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
      console.log('⚠️ Помилка при завантаженні сторінки:', error.message);
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
    let currentHeight = await this.page.evaluate('document.body.scrollHeight');
    let scrollAttempts = 0;
    const maxScrollAttempts = 15;
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      // Прокручуємо до кінця сторінки
      await this.page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
      
      // Чекаємо завантаження нових елементів
      await this.waitFor(3000);
      
      currentHeight = await this.page.evaluate('document.body.scrollHeight');
      scrollAttempts++;
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
      
      // Перевіряємо кількість питань
      const questionsCount = await this.page.evaluate(() => {
        return document.querySelectorAll('.question').length;
      });
      console.log(`📊 Поточна кількість питань: ${questionsCount}`);
    }
    
    // Повертаємося на початок
    await this.page.evaluate('window.scrollTo(0, 0)');
    await this.waitFor(2000);
  }

  async clickOnEachQuestionIndividually() {
    console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    
    const questionsCount = await this.page.evaluate(() => {
      return document.querySelectorAll('.question').length;
    });
    
    console.log(`📊 Знайдено ${questionsCount} питань`);
    
    const allQuestions = [];
    
    for (let i = 0; i < questionsCount; i++) {
      try {
        console.log(`\n🔄 Обробка питання ${i + 1}/${questionsCount}...`);
        
        // Прокручуємо до питання
        await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            questions[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        }, i);
        
        // Чекаємо трохи
        await this.waitFor(1000);
        
        // Клікаємо на питання кілька разів
        await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            const questionEl = questions[index];
            
            // Клік на заголовок питання
            const header = questionEl.querySelector('.question__header');
            if (header) {
              header.click();
            }
            
            // Клік на текст питання
            const textEl = questionEl.querySelector('.question__text');
            if (textEl) {
              textEl.click();
            }
            
            // Клік на варіанти
            const variants = questionEl.querySelectorAll('.question__variant');
            variants.forEach(variant => {
              variant.click();
            });
            
            // Клік на сам елемент питання
            questionEl.click();
          }
        }, i);
        
        // Чекаємо завантаження варіантів
        await this.waitFor(2000);
        
        // Збираємо дані з поточного питання
        const questionData = await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            const questionEl = questions[index];
            
            // Функція для очищення тексту
            const cleanText = (text) => {
              if (!text) return '';
              return text.replace(/\s+/g, ' ').trim();
            };
            
            // Отримуємо текст питання
            const questionTextEl = questionEl.querySelector('.question__text');
            const questionText = questionTextEl ? cleanText(questionTextEl.textContent) : '';
            
            if (!questionText) {
              return null;
            }
            
            // Отримуємо варіанти відповідей
            const variantElements = questionEl.querySelectorAll('.question__variant');
            const options = {};
            let correctAnswer = '';
            
            variantElements.forEach((variantEl, variantIndex) => {
              const spanEl = variantEl.querySelector('span');
              const optionText = spanEl ? cleanText(spanEl.textContent) : '';
              
              if (optionText && !optionText.includes('Варіант') && optionText.length > 5) {
                const letter = String.fromCharCode(65 + variantIndex); // A, B, C, D, E
                options[letter] = optionText;
                
                // Перевіряємо, чи це правильна відповідь
                if (variantEl.classList.contains('question__variant_right') || 
                    variantEl.querySelector('.icon-kl-check') ||
                    variantEl.querySelector('[class*="check"]')) {
                  correctAnswer = letter;
                }
              }
            });
            
            if (Object.keys(options).length > 0) {
              return {
                question_text: questionText,
                option_a: options.A || '',
                option_b: options.B || '',
                option_c: options.C || '',
                option_d: options.D || '',
                option_e: options.E || '',
                correct_answer: correctAnswer,
                question_number: index + 1
              };
            }
          }
          return null;
        }, i);
        
        if (questionData) {
          allQuestions.push(questionData);
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData).filter(k => k.startsWith('option_')).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати варіанти`);
        }
        
        // Показуємо прогрес кожні 10 питань
        if ((i + 1) % 10 === 0) {
          console.log(`📊 Прогрес: ${i + 1}/${questionsCount} питань, зібрано: ${allQuestions.length}`);
        }
        
      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i + 1}:`, error.message);
      }
    }
    
    console.log(`✅ Індивідуальні кліки завершено. Зібрано ${allQuestions.length} питань`);
    return allQuestions;
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

async function scrapeAdvanced(url) {
  const scraper = new AdvancedKrokScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // 30-секундний таймер для ручного налаштування
    await scraper.waitWithTimer(30);
    
    // Прокручуємо сторінку для завантаження всіх питань
    await scraper.scrollToLoadAllQuestions();
    
    // Клікаємо на кожне питання індивідуально
    const questions = await scraper.clickOnEachQuestionIndividually();
    
    if (questions.length === 0) {
      console.log('❌ Не знайдено питань!');
      return [];
    }
    
    const timestamp = Date.now();
    const jsonFilename = `2025-new-tests-questions-${timestamp}.json`;
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
  console.log('🎯 РОЗШИРЕНИЙ СКРАПЕР для тесту "2025 Нові тести"');
  console.log('📋 Параметри:');
  console.log('   - Рік: 2025');
  console.log('   - Факультет: medical');
  console.log('   - Test ID: 2025-new-tests');
  console.log('   - Назва: 2025 Нові тести');
  console.log('');
  
  const url = 'https://krok-lead.com';
  
  console.log('🚀 Запускаємо розширений скрапінг...');
  console.log('📖 Відкрийте потрібну сторінку тесту в браузері');
  console.log('⏰ У вас буде 30 секунд для налаштування правильних відповідей');
  console.log('🔄 Індивідуальні кліки на кожне питання для розкриття варіантів');
  console.log('');
  
  const questions = await scrapeAdvanced(url);
  
  if (questions.length > 0) {
    console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
    
    // Показуємо статистику
    const correctAnswersCount = questions.filter(q => q.correct_answer).length;
    console.log('\n📊 Статистика:');
    console.log(`- Всього питань: ${questions.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);
    
    // Показуємо приклади питань
    console.log('\n📝 Приклади зібраних питань:');
    questions.slice(0, 3).forEach((q, i) => {
      console.log(`${i + 1}. ${q.question_text.substring(0, 80)}...`);
      console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
      if (q.option_a) console.log(`   A: ${q.option_a.substring(0, 40)}...`);
      if (q.option_b) console.log(`   B: ${q.option_b.substring(0, 40)}...`);
    });
    
    // Генеруємо SQL
    const timestamp = Date.now();
    const sqlFilename = `2025-new-tests-questions-${timestamp}.sql`;
    const scraper = new AdvancedKrokScraper();
    await scraper.generateSQL(questions, sqlFilename, 2025, 'medical', '2025-new-tests', '2025 Нові тести');
    
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте зібрані дані в JSON файлі');
    console.log('2. Виконайте SQL файл в Supabase');
    console.log('3. Перевірте відображення на сайті');
  } else {
    console.log('❌ Скрапінг не вдався');
  }
}

// Запускаємо розширений скрапер
main().catch(console.error);
