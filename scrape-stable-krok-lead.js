const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class StableKrokLeadScraper {
  constructor() {
    this.browser = null;
    this.page = null;
    this.questions = [];
  }

  async init() {
    console.log('🚀 Запуск стабільного браузера...');
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
      await this.waitFor(3000);
      
      console.log('✅ Сторінка завантажена');
      
    } catch (error) {
      console.log('⚠️ Помилка при завантаженні сторінки:', error.message);
      throw error;
    }
  }

  async waitFor(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async extractAllQuestions() {
    console.log('🔍 Пошук всіх питань на сторінці...');
    
    try {
      // Отримуємо всі питання через JavaScript
      const questions = await this.page.evaluate(() => {
        const results = [];
        
        // Функція для очищення тексту
        const cleanText = (text) => {
          if (!text) return '';
          return text.replace(/\s+/g, ' ').trim();
        };
        
        // Функція для витягування варіантів відповідей
        const extractOptions = (element) => {
          const options = [];
          
          // Шукаємо радіо-кнопки
          const radioButtons = element.querySelectorAll('input[type="radio"]');
          radioButtons.forEach(radio => {
            const label = radio.nextElementSibling || radio.parentElement;
            if (label && label.textContent) {
              options.push({
                value: radio.value || radio.getAttribute('data-value') || '',
                text: cleanText(label.textContent)
              });
            }
          });
          
          // Якщо радіо-кнопок немає, шукаємо інші елементи
          if (options.length === 0) {
            const optionElements = element.querySelectorAll('.option, .answer, .choice, [class*="option"], [class*="answer"]');
            optionElements.forEach((option, index) => {
              const text = cleanText(option.textContent);
              if (text && text.length > 5) {
                options.push({
                  value: String.fromCharCode(65 + index), // A, B, C, D, E
                  text: text
                });
              }
            });
          }
          
          return options;
        };
        
        // Шукаємо питання різними способами
        const questionSelectors = [
          '.question',
          '[data-testid="question"]',
          '.test-question',
          '.question-item',
          '.question-block',
          '[class*="question"]',
          '.quiz-question',
          '.exam-question',
          '.test-item',
          '.question-container'
        ];
        
        let foundQuestions = 0;
        
        for (const selector of questionSelectors) {
          const elements = document.querySelectorAll(selector);
          if (elements.length > 0) {
            console.log(`Знайдено ${elements.length} елементів з селектором: ${selector}`);
            
            elements.forEach((element, index) => {
              try {
                // Отримуємо текст питання
                let questionText = '';
                
                // Шукаємо заголовок питання
                const questionTitle = element.querySelector('.question-title, .question-text, h3, h4, .title, .question-content');
                if (questionTitle) {
                  questionText = cleanText(questionTitle.textContent);
                } else {
                  // Беремо весь текст елемента
                  questionText = cleanText(element.textContent);
                }
                
                // Очищаємо текст питання від варіантів відповідей
                const options = extractOptions(element);
                if (options.length > 0) {
                  options.forEach(option => {
                    questionText = questionText.replace(option.text, '').trim();
                  });
                }
                
                if (questionText && questionText.length > 20) {
                  results.push({
                    question_text: questionText,
                    options: options,
                    question_number: foundQuestions + 1,
                    extracted_at: new Date().toISOString()
                  });
                  foundQuestions++;
                }
              } catch (error) {
                console.log(`Помилка при обробці питання ${index + 1}:`, error.message);
              }
            });
            
            if (results.length > 0) break;
          }
        }
        
        // Якщо не знайшли питання, спробуємо альтернативний підхід
        if (results.length === 0) {
          console.log('Спробуємо альтернативний підхід - пошук по тексту...');
          
          // Отримуємо весь текст сторінки
          const pageText = document.body.innerText;
          
          // Шукаємо паттерни питань
          const questionPatterns = [
            /(\d+\.\s*[^?]+\?)/g,
            /(Питання\s*\d+[^?]+\?)/g,
            /([А-Я][^?]{30,}\?)/g,
            /(\d+\)\s*[^?]+\?)/g
          ];
          
          const allMatches = [];
          
          for (const pattern of questionPatterns) {
            const matches = pageText.match(pattern);
            if (matches) {
              allMatches.push(...matches);
            }
          }
          
          // Видаляємо дублікати
          const uniqueMatches = [...new Set(allMatches)];
          
          console.log(`Знайдено ${uniqueMatches.length} потенційних питань`);
          
          uniqueMatches.forEach((match, index) => {
            if (match.length > 30 && match.length < 1000) {
              results.push({
                question_text: cleanText(match),
                options: [],
                question_number: index + 1,
                extracted_at: new Date().toISOString()
              });
            }
          });
        }
        
        console.log(`Всього знайдено питань: ${results.length}`);
        return results;
      });
      
      console.log(`✅ Зібрано ${questions.length} питань`);
      return questions;
      
    } catch (error) {
      console.log('❌ Помилка при зборі питань:', error.message);
      return [];
    }
  }

  async getPageInfo() {
    try {
      const info = await this.page.evaluate(() => {
        // Отримуємо рік з URL або з тексту сторінки
        const urlYear = window.location.search.match(/year=(\d+)/)?.[1];
        const textYear = document.body.innerText.match(/(\d{4})/)?.[1];
        
        // Отримуємо факультет
        const urlFaculty = window.location.search.match(/faculty=([^&]+)/)?.[1];
        const textFaculty = document.body.innerText.match(/(медичний|фармацевтичний|medical|pharmaceutical)/i)?.[1];
        
        // Отримуємо тип тесту
        const testType = window.location.search.match(/krok=([^&]+)/)?.[1];
        
        return {
          title: document.title,
          url: window.location.href,
          year: urlYear || textYear || new Date().getFullYear(),
          faculty: urlFaculty || (textFaculty?.toLowerCase().includes('медичний') ? 'medical' : 'pharmaceutical'),
          test_type: testType || 'krok1',
          totalQuestions: document.querySelectorAll('.question, [class*="question"]').length,
          pageText: document.body.innerText.substring(0, 2000) // Перші 2000 символів для аналізу
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

    const filename = `krok-lead-stable-${Date.now()}.json`;
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
async function scrapeStableKrokLead(url) {
  const scraper = new StableKrokLeadScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const questions = await scraper.extractAllQuestions();
    console.log(`✅ Зібрано ${questions.length} питань`);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
      
      // Показуємо приклади питань
      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 3).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   Варіанти відповідей: ${q.options.length}`);
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
  scrapeStableKrokLead(url);
}

module.exports = { StableKrokLeadScraper, scrapeStableKrokLead };
