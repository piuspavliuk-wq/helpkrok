const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class WaitKrokLeadScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера з очікуванням завантаження варіантів...');
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

  async waitForVariantsToLoad() {
    console.log('⏳ Чекаємо завантаження варіантів відповідей...');
    
    // Чекаємо, поки варіанти не завантажаться
    let attempts = 0;
    const maxAttempts = 30;
    
    while (attempts < maxAttempts) {
      const variantsLoaded = await this.page.evaluate(() => {
        const questions = document.querySelectorAll('.question');
        let loadedCount = 0;
        
        questions.forEach(question => {
          const variants = question.querySelectorAll('.question__variant span');
          if (variants.length >= 5) {
            // Перевіряємо, чи варіанти не містять тільки "Варіант А", "Варіант Б" тощо
            let hasRealVariants = false;
            variants.forEach(variant => {
              const text = variant.textContent.trim();
              if (text && !text.includes('Варіант') && text.length > 10) {
                hasRealVariants = true;
              }
            });
            if (hasRealVariants) {
              loadedCount++;
            }
          }
        });
        
        return { loaded: loadedCount, total: questions.length };
      });
      
      console.log(`📊 Завантажено варіантів: ${variantsLoaded.loaded}/${variantsLoaded.total}`);
      
      if (variantsLoaded.loaded >= variantsLoaded.total * 0.8) { // 80% питань мають варіанти
        console.log('✅ Варіанти відповідей завантажені!');
        break;
      }
      
      attempts++;
      await this.waitFor(2000);
    }
    
    if (attempts >= maxAttempts) {
      console.log('⚠️ Не вдалося дочекатися завантаження всіх варіантів');
    }
  }

  async extractAllQuestionsWithCorrectAnswers() {
    console.log('🔍 Збір ВСІХ питань з правильними відповідями...');
    
    try {
      const questions = await this.page.evaluate(() => {
        const results = [];
        
        // Функція для очищення тексту
        const cleanText = (text) => {
          if (!text) return '';
          return text.replace(/\s+/g, ' ').trim();
        };
        
        // Шукаємо всі питання
        const questionElements = document.querySelectorAll('.question');
        
        console.log(`Знайдено ${questionElements.length} питань`);
        
        questionElements.forEach((questionEl, index) => {
          try {
            // Отримуємо текст питання
            const questionTextEl = questionEl.querySelector('.question__text');
            const questionText = questionTextEl ? cleanText(questionTextEl.textContent) : '';
            
            if (!questionText) {
              console.log(`Питання ${index + 1}: не знайдено текст питання`);
              return;
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
                if (variantEl.classList.contains('question__variant_right')) {
                  correctAnswer = letter;
                  console.log(`Правильна відповідь для питання ${index + 1}: ${letter} - ${optionText}`);
                }
              }
            });
            
            if (Object.keys(options).length > 0) {
              results.push({
                question_text: questionText,
                options: options,
                correct_answer: correctAnswer,
                question_number: index + 1,
                extracted_at: new Date().toISOString()
              });
            } else {
              console.log(`Питання ${index + 1}: не знайдено варіанти відповідей`);
            }
            
          } catch (error) {
            console.log(`Помилка при обробці питання ${index + 1}:`, error.message);
          }
        });
        
        console.log(`Всього зібрано питань: ${results.length}`);
        return results;
      });
      
      console.log(`✅ Зібрано ${questions.length} питань з правильними відповідями`);
      return questions;
      
    } catch (error) {
      console.log('❌ Помилка при зборі питань:', error.message);
      return [];
    }
  }

  async getPageInfo() {
    try {
      const info = await this.page.evaluate(() => {
        const urlYear = window.location.search.match(/year=(\d+)/)?.[1];
        const textYear = document.body.innerText.match(/(\d{4})/)?.[1];
        const urlFaculty = window.location.search.match(/faculty=([^&]+)/)?.[1];
        const textFaculty = document.body.innerText.match(/(медичний|фармацевтичний|medical|pharmaceutical)/i)?.[1];
        const testType = window.location.search.match(/krok=([^&]+)/)?.[1];
        
        return {
          title: document.title,
          url: window.location.href,
          year: urlYear || textYear || new Date().getFullYear(),
          faculty: urlFaculty || (textFaculty?.toLowerCase().includes('медичний') ? 'medical' : 'pharmaceutical'),
          test_type: testType || 'krok1',
          totalQuestions: document.querySelectorAll('.question').length
        };
      });
      
      return info;
    } catch (error) {
      console.log('⚠️ Не вдалося отримати інформацію про сторінку');
      return {
        title: 'Unknown',
        url: this.page.url(),
        year: new Date().getFullYear(),
        faculty: 'medical',
        test_type: 'krok1',
        totalQuestions: 0
      };
    }
  }

  async saveQuestions(questions, pageInfo) {
    const data = {
      source: 'krok-lead.com',
      url: pageInfo.url,
      extracted_at: new Date().toISOString(),
      page_info: pageInfo,
      questions: questions,
      total_questions: questions.length
    };

    const filename = `krok-lead-wait-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 Дані збережено в файл: ${filepath}`);
    
    return filepath;
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

// Основна функція
async function scrapeWithWait(url, timerSeconds = 10) {
  const scraper = new WaitKrokLeadScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // Таймер для ручного налаштування
    await scraper.waitWithTimer(timerSeconds);
    
    // Прокручуємо сторінку для завантаження всіх питань
    await scraper.scrollToLoadAllQuestions();
    
    // Чекаємо завантаження варіантів
    await scraper.waitForVariantsToLoad();
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const questions = await scraper.extractAllQuestionsWithCorrectAnswers();
    console.log(`✅ Зібрано ${questions.length} питань`);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
      
      // Показуємо статистику
      const correctAnswersCount = questions.filter(q => q.correct_answer).length;
      console.log('\n📊 Статистика:');
      console.log(`- Всього питань: ${questions.length}`);
      console.log(`- З правильними відповідями: ${correctAnswersCount}`);
      console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);
      
      // Показуємо приклади питань
      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 3).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   Варіанти: ${Object.keys(q.options).length}`);
        console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
        Object.entries(q.options).forEach(([letter, text]) => {
          const isCorrect = letter === q.correct_answer ? ' ✓' : '';
          console.log(`   ${letter}: ${text.substring(0, 50)}...${isCorrect}`);
        });
      });
      
      if (questions.length > 3) {
        console.log(`   ... та ще ${questions.length - 3} питань`);
      }
      
      return filepath;
    } else {
      console.log('❌ Не вдалося знайти питання на сторінці');
      return null;
    }
    
  } catch (error) {
    console.error('❌ Помилка при зборі даних:', error);
    return null;
  } finally {
    await scraper.close();
  }
}

// Запуск скрипта
if (require.main === module) {
  const url = process.argv[2] || 'https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1';
  const timerSeconds = parseInt(process.argv[3]) || 10;
  scrapeWithWait(url, timerSeconds);
}

module.exports = { WaitKrokLeadScraper, scrapeWithWait };
