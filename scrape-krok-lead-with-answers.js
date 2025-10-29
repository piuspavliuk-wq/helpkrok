const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class KrokLeadWithAnswersScraper {
  constructor() {
    this.browser = null;
    this.page = null;
    this.questions = [];
  }

  async init() {
    console.log('🚀 Запуск браузера для збору питань з правильними відповідями...');
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

  async enableCorrectAnswers() {
    console.log('🔍 Шукаємо кнопку для показу правильних відповідей...');
    
    try {
      // Шукаємо кнопку з трьома крапками
      const threeDotsSelectors = [
        '[data-testid="more-options"]',
        '.more-options',
        '.three-dots',
        '.menu-button',
        '[class*="more"]',
        '[class*="menu"]',
        'button[aria-label*="more"]',
        'button[aria-label*="меню"]',
        'button[title*="more"]',
        'button[title*="меню"]'
      ];

      let threeDotsButton = null;
      for (const selector of threeDotsSelectors) {
        threeDotsButton = await this.page.$(selector);
        if (threeDotsButton) {
          console.log(`✅ Знайдено кнопку з трьома крапками: ${selector}`);
          break;
        }
      }

      if (threeDotsButton) {
        // Натискаємо на кнопку з трьома крапками
        await threeDotsButton.click();
        await this.waitFor(1000);

        // Шукаємо опцію "показувати правильні відповіді"
        const showAnswersSelectors = [
          'text="Показувати правильні відповіді"',
          'text="Show correct answers"',
          'text="Показати відповіді"',
          '[data-testid="show-answers"]',
          '.show-answers',
          '[class*="show-answers"]',
          '[class*="correct-answers"]'
        ];

        for (const selector of showAnswersSelectors) {
          try {
            const showAnswersButton = await this.page.$(selector);
            if (showAnswersButton) {
              console.log(`✅ Знайдено кнопку показу відповідей: ${selector}`);
              await showAnswersButton.click();
              await this.waitFor(2000);
              console.log('✅ Увімкнено показ правильних відповідей');
              return true;
            }
          } catch (error) {
            // Продовжуємо пошук
          }
        }
      }

      // Альтернативний підхід - шукаємо прямо кнопку показу відповідей
      const directShowAnswersSelectors = [
        'button:contains("Показувати правильні відповіді")',
        'button:contains("Show correct answers")',
        'button:contains("Показати відповіді")',
        '[data-testid="toggle-answers"]',
        '.toggle-answers',
        '[class*="toggle-answers"]'
      ];

      for (const selector of directShowAnswersSelectors) {
        try {
          const button = await this.page.$(selector);
          if (button) {
            console.log(`✅ Знайдено пряму кнопку показу відповідей: ${selector}`);
            await button.click();
            await this.waitFor(2000);
            console.log('✅ Увімкнено показ правильних відповідей');
            return true;
          }
        } catch (error) {
          // Продовжуємо пошук
        }
      }

      console.log('⚠️ Не вдалося знайти кнопку показу правильних відповідей');
      return false;

    } catch (error) {
      console.log('⚠️ Помилка при спробі увімкнути показ відповідей:', error.message);
      return false;
    }
  }

  async extractQuestionsWithAnswers() {
    console.log('🔍 Збір питань з реальними варіантами відповідей...');
    
    try {
      const questions = await this.page.evaluate(() => {
        const results = [];
        
        // Функція для очищення тексту
        const cleanText = (text) => {
          if (!text) return '';
          return text.replace(/\s+/g, ' ').trim();
        };
        
        // Функція для витягування варіантів відповідей
        const extractOptions = (element) => {
          const options = {};
          
          // Шукаємо радіо-кнопки з лейблами
          const radioButtons = element.querySelectorAll('input[type="radio"]');
          radioButtons.forEach(radio => {
            const label = radio.nextElementSibling || radio.parentElement;
            if (label && label.textContent) {
              const letter = radio.value || radio.getAttribute('data-value') || '';
              const text = cleanText(label.textContent);
              if (letter && text) {
                options[letter] = text;
              }
            }
          });
          
          // Якщо радіо-кнопок немає, шукаємо інші елементи
          if (Object.keys(options).length === 0) {
            const optionElements = element.querySelectorAll('.option, .answer, .choice, [class*="option"], [class*="answer"]');
            optionElements.forEach((option, index) => {
              const text = cleanText(option.textContent);
              if (text && text.length > 5) {
                const letter = String.fromCharCode(65 + index); // A, B, C, D, E
                options[letter] = text;
              }
            });
          }
          
          return options;
        };
        
        // Функція для визначення правильної відповіді
        const extractCorrectAnswer = (element) => {
          // Шукаємо позначені правильні відповіді
          const correctElements = element.querySelectorAll('.correct, .right, .answer-correct, [class*="correct"], [class*="right"]');
          
          for (const correctEl of correctElements) {
            // Шукаємо радіо-кнопку поруч
            const radio = correctEl.querySelector('input[type="radio"]') || 
                         correctEl.previousElementSibling?.querySelector('input[type="radio"]') ||
                         correctEl.nextElementSibling?.querySelector('input[type="radio"]');
            
            if (radio) {
              return radio.value || radio.getAttribute('data-value') || '';
            }
            
            // Шукаємо текст з позначкою правильної відповіді
            const text = correctEl.textContent;
            if (text && text.match(/^[A-E]\)/)) {
              return text.charAt(0);
            }
          }
          
          return '';
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
                
                // Витягуємо варіанти відповідей
                const options = extractOptions(element);
                
                // Очищаємо текст питання від варіантів відповідей
                Object.values(options).forEach(optionText => {
                  questionText = questionText.replace(optionText, '').trim();
                });
                
                // Витягуємо правильну відповідь
                const correctAnswer = extractCorrectAnswer(element);
                
                if (questionText && questionText.length > 20) {
                  results.push({
                    question_text: questionText,
                    options: options,
                    correct_answer: correctAnswer,
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
          
          // Шукаємо паттерни питань з варіантами відповідей
          const questionPatterns = [
            /(\d+\.\s*[^?]+\?)\s*([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)/g,
            /(\d+\)\s*[^?]+\?)\s*([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)([A-E]\)[^A-E]+)/g
          ];
          
          for (const pattern of questionPatterns) {
            const matches = [...pageText.matchAll(pattern)];
            matches.forEach((match, index) => {
              if (match.length >= 7) {
                const questionText = cleanText(match[1]);
                const options = {
                  A: cleanText(match[2].replace(/^A\)\s*/, '')),
                  B: cleanText(match[3].replace(/^B\)\s*/, '')),
                  C: cleanText(match[4].replace(/^C\)\s*/, '')),
                  D: cleanText(match[5].replace(/^D\)\s*/, '')),
                  E: cleanText(match[6].replace(/^E\)\s*/, ''))
                };
                
                results.push({
                  question_text: questionText,
                  options: options,
                  correct_answer: '',
                  question_number: index + 1,
                  extracted_at: new Date().toISOString()
                });
              }
            });
          }
        }
        
        console.log(`Всього знайдено питань: ${results.length}`);
        return results;
      });
      
      console.log(`✅ Зібрано ${questions.length} питань з варіантами відповідей`);
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

    const filename = `krok-lead-with-answers-${Date.now()}.json`;
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
async function scrapeKrokLeadWithAnswers(url) {
  const scraper = new KrokLeadWithAnswersScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // Спробуємо увімкнути показ правильних відповідей
    await scraper.enableCorrectAnswers();
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const questions = await scraper.extractQuestionsWithAnswers();
    console.log(`✅ Зібрано ${questions.length} питань`);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
      
      // Показуємо приклади питань
      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 3).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   Варіанти: ${Object.keys(q.options).length}`);
        console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
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
  scrapeKrokLeadWithAnswers(url);
}

module.exports = { KrokLeadWithAnswersScraper, scrapeKrokLeadWithAnswers };
