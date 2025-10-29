const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class KrokLeadScraper {
  constructor() {
    this.browser = null;
    this.page = null;
    this.questions = [];
  }

  async init() {
    console.log('🚀 Запуск браузера...');
    this.browser = await puppeteer.launch({
      headless: false, // Показуємо браузер для налагодження
      defaultViewport: null,
      args: ['--start-maximized']
    });
    
    this.page = await this.browser.newPage();
    
    // Налаштування User-Agent
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
  }

  async navigateToTest(url) {
    console.log(`📖 Перехід на сторінку: ${url}`);
    await this.page.goto(url, { 
      waitUntil: 'networkidle2',
      timeout: 30000 
    });
    
    // Чекаємо завантаження сторінки
    await new Promise(resolve => setTimeout(resolve, 3000));
  }

  async extractQuestions() {
    console.log('🔍 Пошук питань на сторінці...');
    
    try {
      // Чекаємо наявності питань
      await this.page.waitForSelector('[data-testid="question"], .question, .test-question', { timeout: 10000 });
      
      // Спробуємо різні селектори для питань
      const questionSelectors = [
        '[data-testid="question"]',
        '.question',
        '.test-question',
        '.question-item',
        '.question-block',
        '[class*="question"]'
      ];

      let questions = [];
      
      for (const selector of questionSelectors) {
        const elements = await this.page.$$(selector);
        if (elements.length > 0) {
          console.log(`✅ Знайдено ${elements.length} питань з селектором: ${selector}`);
          questions = await this.extractQuestionsFromElements(elements);
          break;
        }
      }

      if (questions.length === 0) {
        // Спробуємо знайти питання через текст
        questions = await this.extractQuestionsByText();
      }

      return questions;
      
    } catch (error) {
      console.log('⚠️ Не вдалося знайти питання стандартними методами');
      console.log('🔍 Спробуємо альтернативний підхід...');
      
      // Альтернативний підхід - пошук по тексту
      return await this.extractQuestionsByText();
    }
  }

  async extractQuestionsFromElements(elements) {
    const questions = [];
    
    for (let i = 0; i < elements.length; i++) {
      try {
        const element = elements[i];
        
        // Отримуємо текст питання
        const questionText = await element.$eval('*', el => {
          // Шукаємо текст питання
          const textNodes = Array.from(el.childNodes).filter(node => 
            node.nodeType === Node.TEXT_NODE && node.textContent.trim()
          );
          return textNodes.map(node => node.textContent.trim()).join(' ');
        }).catch(() => '');

        if (!questionText) continue;

        // Шукаємо варіанти відповідей
        const options = await element.$$eval('input[type="radio"], .option, .answer-option', options => {
          return options.map(option => ({
            value: option.value || option.textContent?.trim() || '',
            text: option.nextElementSibling?.textContent?.trim() || 
                  option.parentElement?.textContent?.trim() || 
                  option.textContent?.trim() || ''
          }));
        }).catch(() => []);

        if (options.length === 0) {
          // Спробуємо знайти варіанти іншим способом
          const optionTexts = await element.$$eval('*', els => {
            return els
              .filter(el => el.textContent && el.textContent.length > 10 && el.textContent.length < 200)
              .map(el => el.textContent.trim())
              .filter(text => !text.includes(questionText))
              .slice(0, 5);
          }).catch(() => []);
          
          options.push(...optionTexts.map((text, index) => ({
            value: String.fromCharCode(65 + index), // A, B, C, D, E
            text: text
          })));
        }

        if (options.length >= 2) {
          questions.push({
            question_text: questionText,
            options: options.slice(0, 5), // Максимум 5 варіантів
            extracted_at: new Date().toISOString()
          });
        }
        
      } catch (error) {
        console.log(`⚠️ Помилка при обробці питання ${i + 1}:`, error.message);
      }
    }
    
    return questions;
  }

  async extractQuestionsByText() {
    console.log('🔍 Пошук питань через аналіз тексту сторінки...');
    
    try {
      // Отримуємо весь текст сторінки
      const pageContent = await this.page.evaluate(() => {
        return document.body.innerText;
      });

      // Шукаємо паттерни питань
      const questionPatterns = [
        /(\d+\.\s*[^?]+\?)/g,
        /(Питання\s*\d+[^?]+\?)/g,
        /([А-Я][^?]{20,}\?)/g
      ];

      const questions = [];
      
      for (const pattern of questionPatterns) {
        const matches = pageContent.match(pattern);
        if (matches && matches.length > 0) {
          console.log(`✅ Знайдено ${matches.length} потенційних питань з паттерном`);
          
          for (const match of matches.slice(0, 10)) { // Обмежуємо до 10 питань
            if (match.length > 20 && match.length < 500) {
              questions.push({
                question_text: match.trim(),
                options: [], // Варіанти відповідей потрібно буде знайти окремо
                extracted_at: new Date().toISOString()
              });
            }
          }
          break;
        }
      }

      return questions;
      
    } catch (error) {
      console.log('❌ Помилка при аналізі тексту:', error.message);
      return [];
    }
  }

  async getPageInfo() {
    try {
      const info = await this.page.evaluate(() => {
        return {
          title: document.title,
          url: window.location.href,
          year: document.querySelector('[data-year], .year, .test-year')?.textContent?.trim() || 
                window.location.search.match(/year=(\d+)/)?.[1] || 
                document.body.innerText.match(/(\d{4})/)?.[1],
          faculty: document.querySelector('[data-faculty], .faculty')?.textContent?.trim() || 
                   window.location.search.match(/faculty=([^&]+)/)?.[1] || 
                   'medical',
          totalQuestions: document.querySelector('[data-total], .total-questions')?.textContent?.trim() || 
                         document.body.innerText.match(/(\d+)\s*питань?/)?.[1]
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
        totalQuestions: 'Unknown'
      };
    }
  }

  async saveQuestions(questions, pageInfo) {
    const data = {
      source: 'krok-lead.com',
      url: pageInfo.url,
      extracted_at: new Date().toISOString(),
      page_info: pageInfo,
      questions: questions
    };

    const filename = `krok-lead-questions-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    // Створюємо папку data якщо не існує
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
async function scrapeKrokLead(url) {
  const scraper = new KrokLeadScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const questions = await scraper.extractQuestions();
    console.log(`✅ Зібрано ${questions.length} питань`);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
    } else {
      console.log('❌ Не вдалося знайти питання на сторінці');
    }
    
  } catch (error) {
    console.error('❌ Помилка при зборі даних:', error);
  } finally {
    await scraper.close();
  }
}

// Запуск скрипта
if (require.main === module) {
  const url = process.argv[2] || 'https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1';
  scrapeKrokLead(url);
}

module.exports = { KrokLeadScraper, scrapeKrokLead };
