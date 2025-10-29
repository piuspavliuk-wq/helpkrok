const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class FinalKrokLeadScraper {
  constructor() {
    this.browser = null;
    this.page = null;
    this.questions = [];
  }

  async init() {
    console.log('🚀 Запуск фінального браузера для збору питань...');
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

  async extractQuestionsFinal() {
    console.log('🔍 Фінальний збір питань з правильним розділенням...');
    
    try {
      const questions = await this.page.evaluate(() => {
        const results = [];
        
        // Функція для очищення тексту
        const cleanText = (text) => {
          if (!text) return '';
          return text.replace(/\s+/g, ' ').trim();
        };
        
        // Функція для розділення питання та варіантів
        const parseQuestionAndOptions = (fullText) => {
          // Шукаємо паттерн: питання? варіант1 варіант2 варіант3 варіант4 варіант5
          const questionMatch = fullText.match(/^(\d+\s*\/\s*\d+)?(.+?\?)\s*(.+)$/s);
          
          if (questionMatch) {
            const questionNumber = questionMatch[1] || '';
            const questionText = cleanText(questionMatch[2]);
            const optionsText = questionMatch[3];
            
            // Розділяємо варіанти відповідей
            const options = {};
            const optionPatterns = [
              // Паттерн для варіантів без літер: "Варіант1 Варіант2 Варіант3 Варіант4 Варіант5"
              /^(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+)$/,
              // Паттерн для варіантів з літерами: "A) Варіант1 B) Варіант2 C) Варіант3 D) Варіант4 E) Варіант5"
              /^A\)\s*(.+?)\s+B\)\s*(.+?)\s+C\)\s*(.+?)\s+D\)\s*(.+?)\s+E\)\s*(.+)$/,
              // Паттерн для варіантів з літерами без дужок: "A Варіант1 B Варіант2 C Варіант3 D Варіант4 E Варіант5"
              /^A\s+(.+?)\s+B\s+(.+?)\s+C\s+(.+?)\s+D\s+(.+?)\s+E\s+(.+)$/
            ];
            
            for (const pattern of optionPatterns) {
              const match = optionsText.match(pattern);
              if (match) {
                if (pattern.source.includes('A\\)')) {
                  // Варіанти з літерами та дужками
                  options.A = cleanText(match[1]);
                  options.B = cleanText(match[2]);
                  options.C = cleanText(match[3]);
                  options.D = cleanText(match[4]);
                  options.E = cleanText(match[5]);
                } else if (pattern.source.includes('A\\s+')) {
                  // Варіанти з літерами без дужок
                  options.A = cleanText(match[1]);
                  options.B = cleanText(match[2]);
                  options.C = cleanText(match[3]);
                  options.D = cleanText(match[4]);
                  options.E = cleanText(match[5]);
                } else {
                  // Варіанти без літер
                  options.A = cleanText(match[1]);
                  options.B = cleanText(match[2]);
                  options.C = cleanText(match[3]);
                  options.D = cleanText(match[4]);
                  options.E = cleanText(match[5]);
                }
                break;
              }
            }
            
            // Якщо не знайшли паттерн, спробуємо розділити по пробілах
            if (Object.keys(options).length === 0) {
              const words = optionsText.split(/\s+/);
              if (words.length >= 5) {
                // Розділяємо на 5 частин
                const chunkSize = Math.ceil(words.length / 5);
                options.A = words.slice(0, chunkSize).join(' ');
                options.B = words.slice(chunkSize, chunkSize * 2).join(' ');
                options.C = words.slice(chunkSize * 2, chunkSize * 3).join(' ');
                options.D = words.slice(chunkSize * 3, chunkSize * 4).join(' ');
                options.E = words.slice(chunkSize * 4).join(' ');
              }
            }
            
            return {
              questionNumber: questionNumber,
              questionText: questionText,
              options: options
            };
          }
          
          return null;
        };
        
        // Отримуємо весь текст сторінки
        const pageText = document.body.innerText;
        
        // Шукаємо всі питання з варіантами відповідей
        const questionPatterns = [
          // Паттерн: "1 / 150Питання? Варіант1 Варіант2 Варіант3 Варіант4 Варіант5"
          /(\d+\s*\/\s*\d+[^?]+\?[^0-9]+?)(?=\d+\s*\/\s*\d+|$)/g,
          // Паттерн: "Питання? Варіант1 Варіант2 Варіант3 Варіант4 Варіант5"
          /([^?]+\?[^0-9]+?)(?=\d+\s*\/\s*\d+|$)/g
        ];
        
        const allMatches = [];
        
        for (const pattern of questionPatterns) {
          const matches = pageText.match(pattern);
          if (matches) {
            allMatches.push(...matches);
          }
        }
        
        // Обробляємо кожне знайдене питання
        allMatches.forEach((match, index) => {
          const parsed = parseQuestionAndOptions(match);
          if (parsed && parsed.questionText && Object.keys(parsed.options).length > 0) {
            results.push({
              question_text: parsed.questionText,
              options: parsed.options,
              correct_answer: '', // Поки що порожнє
              question_number: index + 1,
              extracted_at: new Date().toISOString()
            });
          }
        });
        
        console.log(`Всього знайдено питань: ${results.length}`);
        return results;
      });
      
      console.log(`✅ Зібрано ${questions.length} питань з правильно розділеними варіантами`);
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
          totalQuestions: document.querySelectorAll('.question, [class*="question"]').length
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

    const filename = `krok-lead-final-${Date.now()}.json`;
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
async function scrapeFinalKrokLead(url) {
  const scraper = new FinalKrokLeadScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const questions = await scraper.extractQuestionsFinal();
    console.log(`✅ Зібрано ${questions.length} питань`);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
      
      // Показуємо приклади питань
      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 3).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   Варіанти: ${Object.keys(q.options).length}`);
        Object.entries(q.options).forEach(([letter, text]) => {
          console.log(`   ${letter}: ${text.substring(0, 50)}...`);
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
  scrapeFinalKrokLead(url);
}

module.exports = { FinalKrokLeadScraper, scrapeFinalKrokLead };
