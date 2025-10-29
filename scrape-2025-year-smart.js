const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Конфігурація для тесту "2025 рік"
const testConfig = {
  year: 2025,
  identifier: '2025-pharmacy',
  title: '2025 рік',
  timerSeconds: 30 // 30 секунд
};

class Pharmacy2025YearScraper {
  constructor(testConfig) {
    this.testConfig = testConfig;
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log(`🚀 Ініціалізація скрапера для ${this.testConfig.title}...`);
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

  async navigateToTest() {
    console.log(`📖 Перехід на сторінку: https://krok-lead.com (${this.testConfig.title})`);
    
    try {
      await this.page.goto('https://krok-lead.com', { 
        waitUntil: 'domcontentloaded',
        timeout: 60000 
      });
      
      await this.waitFor(5000);
      console.log(`✅ Сторінка завантажена (${this.testConfig.title})`);
      
    } catch (error) {
      console.log(`⚠️ Помилка при завантаженні сторінки (${this.testConfig.title}):`, error.message);
      throw error;
    }
  }

  async waitFor(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async waitWithTimer(seconds) {
    console.log(`\n⏰ ТАЙМЕР ${seconds} СЕКУНД (${Math.floor(seconds/60)} хв) ДЛЯ РУЧНОГО НАЛАШТУВАННЯ (${this.testConfig.title})`);
    console.log('📋 Швидкі інструкції:');
    console.log('1. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('2. Натисніть на неї');
    console.log('3. Виберіть "Показувати правильні відповіді"');
    console.log('4. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('5. Чекайте завершення таймера...\n');
    
    for (let i = seconds; i > 0; i--) {
      const minutes = Math.floor(i / 60);
      const secs = i % 60;
      console.log(`⏳ Залишилось: ${minutes}:${secs.toString().padStart(2, '0')} (${this.testConfig.title})`);
      await this.waitFor(1000);
    }
    
    console.log(`🚀 Таймер завершено! Продовжуємо збір даних... (${this.testConfig.title})\n`);
  }

  async scrollToLoadAllQuestions() {
    console.log(`📜 Прокручуємо сторінку для завантаження всіх питань... (${this.testConfig.title})`);
    
    let previousHeight = 0;
    let currentHeight = await this.page.evaluate('document.body.scrollHeight');
    let scrollAttempts = 0;
    const maxScrollAttempts = 20;
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      await this.page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
      await this.waitFor(3000);
      
      currentHeight = await this.page.evaluate('document.body.scrollHeight');
      scrollAttempts++;
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px (${this.testConfig.title})`);
      
      const questionsCount = await this.page.evaluate(() => {
        return document.querySelectorAll('.question').length;
      });
      console.log(`📊 Поточна кількість питань: ${questionsCount} (${this.testConfig.title})`);
    }
    
    await this.page.evaluate('window.scrollTo(0, 0)');
    await this.waitFor(2000);
  }

  async clickOnEachQuestionIndividually() {
    console.log(`🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів... (${this.testConfig.title})`);
    
    const questionsCount = await this.page.evaluate(() => {
      return document.querySelectorAll('.question').length;
    });
    
    console.log(`📊 Знайдено ${questionsCount} питань (${this.testConfig.title})`);
    
    const allQuestions = [];
    
    for (let i = 0; i < questionsCount; i++) {
      try {
        console.log(`\n🔄 Обробка питання ${i + 1}/${questionsCount}... (${this.testConfig.title})`);
        
        await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            questions[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        }, i);
        
        await this.waitFor(1000);
        
        await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            const questionEl = questions[index];
            
            const header = questionEl.querySelector('.question__header');
            if (header) {
              header.click();
            }
            
            const textEl = questionEl.querySelector('.question__text');
            if (textEl) {
              textEl.click();
            }
            
            const variants = questionEl.querySelectorAll('.question__variant');
            variants.forEach(variant => {
              variant.click();
            });
            
            questionEl.click();
          }
        }, i);
        
        await this.waitFor(2000);
        
        const questionData = await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            const questionEl = questions[index];
            
            const cleanText = (text) => {
              if (!text) return '';
              return text.replace(/\s+/g, ' ').trim();
            };

            // Функція для конвертації зображення в base64
            const getImageAsBase64 = (imgElement) => {
              try {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                
                canvas.width = imgElement.naturalWidth || imgElement.width;
                canvas.height = imgElement.naturalHeight || imgElement.height;
                
                ctx.drawImage(imgElement, 0, 0);
                return canvas.toDataURL('image/png');
              } catch (error) {
                console.log('Помилка при конвертації зображення:', error);
                return null;
              }
            };
            
            // Отримуємо текст питання
            const questionTextEl = questionEl.querySelector('.question__text');
            const questionText = questionTextEl ? cleanText(questionTextEl.textContent) : '';
            
            if (!questionText) {
              return null;
            }
            
            // Перевіряємо зображення в питанні
            let questionImage = null;
            const questionImagesEl = questionEl.querySelector('.question__images');
            if (questionImagesEl) {
              const imgEl = questionImagesEl.querySelector('img');
              if (imgEl) {
                questionImage = getImageAsBase64(imgEl);
              }
            }
            
            // Обробляємо варіанти відповідей
            const variantElements = questionEl.querySelectorAll('.question__variant');
            const options = {};
            const optionImages = {};
            let correctAnswer = '';
            let hasImages = false;
            
            for (let variantIndex = 0; variantIndex < variantElements.length; variantIndex++) {
              const variantEl = variantElements[variantIndex];
              const letter = String.fromCharCode(65 + variantIndex);
              
              const isCorrect = variantEl.classList.contains('question__variant_right') || 
                                variantEl.querySelector('.icon-kl-check') ||
                                variantEl.querySelector('[class*="check"]');
              
              if (isCorrect) {
                correctAnswer = letter;
              }
              
              // Отримуємо текст варіанта
              const spanEl = variantEl.querySelector('span');
              let optionText = spanEl ? cleanText(spanEl.textContent) : '';
              
              // Перевіряємо, чи є зображення в варіанті
              const imgEl = variantEl.querySelector('img');
              let optionImage = null;
              
              if (imgEl) {
                optionImage = getImageAsBase64(imgEl);
                hasImages = true;
                if (!optionText || optionText.length < 3) {
                  optionText = `Варіант ${letter}`;
                }
              } else {
                // Шукаємо SVG
                const svgEl = variantEl.querySelector('svg');
                if (svgEl) {
                  optionImage = `data:image/svg+xml;base64,${btoa(svgEl.outerHTML)}`;
                  hasImages = true;
                  if (!optionText || optionText.length < 3) {
                    optionText = `Варіант ${letter}`;
                  }
                } else {
                  // Шукаємо background-image
                  const computedStyle = window.getComputedStyle(variantEl);
                  const backgroundImage = computedStyle.backgroundImage;
                  if (backgroundImage && backgroundImage !== 'none') {
                    hasImages = true;
                    optionText = `Варіант ${letter} (зображення)`;
                  }
                }
              }
              
              // Додаємо варіант
              options[letter] = optionText;
              if (optionImage) {
                optionImages[letter] = optionImage;
              }
            }
            
            if (Object.keys(options).length > 0) {
              return {
                question_text: questionText,
                question_image: questionImage,
                options: options,
                option_images: optionImages,
                correct_answer: correctAnswer,
                question_number: index + 1,
                extracted_at: new Date().toISOString(),
                has_images: hasImages || !!questionImage,
                question_type: hasImages || questionImage ? 'with_images' : 'text_only'
              };
            }
          }
          return null;
        }, i);
        
        if (questionData) {
          allQuestions.push(questionData);
          const imagesCount = Object.keys(questionData.option_images || {}).length;
          const questionType = questionData.question_type;
          const questionImageStatus = questionData.question_image ? 'Так' : 'Ні';
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData.options).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}, тип: ${questionType}, зображення в питанні: ${questionImageStatus}, зображення в варіантах: ${imagesCount} (${this.testConfig.title})`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати варіанти (${this.testConfig.title})`);
        }
        
        if ((i + 1) % 10 === 0) {
          console.log(`📊 Прогрес: ${i + 1}/${questionsCount} питань, зібрано: ${allQuestions.length} (${this.testConfig.title})`);
        }
        
      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i + 1} (${this.testConfig.title}):`, error.message);
      }
    }
    
    console.log(`✅ Індивідуальні кліки завершено. Зібрано ${allQuestions.length} питань (${this.testConfig.title})`);
    return allQuestions;
  }

  async saveQuestions(questions) {
    const data = {
      source: 'krok-lead.com',
      url: 'https://krok-lead.com',
      extracted_at: new Date().toISOString(),
      year: this.testConfig.year,
      faculty: 'pharmacy',
      test_identifier: this.testConfig.identifier,
      title: this.testConfig.title,
      questions: questions,
      total_questions: questions.length,
      questions_with_images: questions.filter(q => q.has_images).length,
      questions_text_only: questions.filter(q => !q.has_images).length
    };

    const filename = `${this.testConfig.identifier}-questions-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 Дані збережено в файл: ${filepath} (${this.testConfig.title})`);
    
    return filepath;
  }

  async generateSQL(questions, jsonFilepath) {
    const sqlFilename = path.basename(jsonFilepath).replace('.json', '.sql');
    const sqlFilepath = path.join(__dirname, 'data', sqlFilename);

    let sql = `-- SQL для імпорту питань фармації ${this.testConfig.title}\n`;
    sql += `-- Кількість питань: ${questions.length}\n`;
    sql += `-- Назва тесту: ${this.testConfig.title}\n\n`;

    questions.forEach((question, index) => {
      const questionImage = question.question_image ? `'${question.question_image}'` : 'NULL';
      const optionImages = question.option_images && Object.keys(question.option_images).length > 0 ? 
        `'${JSON.stringify(question.option_images).replace(/'/g, "''")}'` : 'NULL';
      
      sql += `INSERT INTO krok_questions_unified_pharmacy (
  question_text, year, faculty, category, difficulty,
  option_a, option_b, option_c, option_d, option_e,
  correct_answer, title, test_identifier,
  question_image, option_images, options,
  created_at, updated_at
) VALUES (
  '${question.question_text.replace(/'/g, "''")}',
  ${this.testConfig.year},
  'pharmacy',
  'pharmacy',
  'medium',
  '${question.options.A?.replace(/'/g, "''") || ''}',
  '${question.options.B?.replace(/'/g, "''") || ''}',
  '${question.options.C?.replace(/'/g, "''") || ''}',
  '${question.options.D?.replace(/'/g, "''") || ''}',
  '${question.options.E?.replace(/'/g, "''") || ''}',
  '${question.correct_answer || 'A'}',
  '${this.testConfig.title}',
  '${this.testConfig.identifier}',
  ${questionImage},
  ${optionImages},
  '${JSON.stringify(question.options).replace(/'/g, "''")}',
  '${question.extracted_at}',
  '${question.extracted_at}'
);

`;
    });

    fs.writeFileSync(sqlFilepath, sql);
    console.log(`📄 SQL файл згенеровано: ${sqlFilepath} (${this.testConfig.title})`);
    return sqlFilepath;
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log(`🔒 Браузер закрито (${this.testConfig.title})`);
    }
  }

  async run() {
    try {
      await this.init();
      await this.navigateToTest();
      
      await this.waitWithTimer(this.testConfig.timerSeconds);
      
      await this.scrollToLoadAllQuestions();
      
      const questions = await this.clickOnEachQuestionIndividually();
      
      if (questions.length > 0) {
        const jsonFilepath = await this.saveQuestions(questions);
        const sqlFilepath = await this.generateSQL(questions, jsonFilepath);
        
        console.log(`🎉 Успішно зібрано дані для ${this.testConfig.title}!`);
        console.log(`📊 Статистика (${this.testConfig.title}):`);
        console.log(`- Всього питань: ${questions.length}`);
        console.log(`- З правильними відповідями: ${questions.filter(q => q.correct_answer).length}`);
        console.log(`- З зображеннями: ${questions.filter(q => q.has_images).length}`);
        console.log(`- Тільки текст: ${questions.filter(q => !q.has_images).length}`);
        
        return { jsonFilepath, sqlFilepath, questionsCount: questions.length };
      } else {
        console.log(`❌ Не вдалося знайти питання на сторінці (${this.testConfig.title})`);
        return null;
      }
      
    } catch (error) {
      console.error(`❌ Помилка при зборі даних для ${this.testConfig.title}:`, error);
      return null;
    } finally {
      await this.close();
    }
  }
}

async function run2025YearScraper() {
  console.log('🚀 ЗАПУСКАЄМО СКРАПЕР ДЛЯ "2025 рік" З ТАЙМЕРОМ 30 СЕКУНД...');
  console.log('');
  
  const scraper = new Pharmacy2025YearScraper(testConfig);
  const result = await scraper.run();
  
  if (result) {
    console.log(`\n🎉 СКРАПЕР ЗАВЕРШЕНО!`);
    console.log(`📊 Результат: ${result.questionsCount} питань ✅`);
    console.log(`📄 JSON: ${result.jsonFilepath}`);
    console.log(`📄 SQL: ${result.sqlFilepath}`);
  } else {
    console.log(`\n❌ СКРАПЕР НЕ ВДАЛОСЯ ЗАВЕРШИТИ`);
  }
  
  return result;
}

if (require.main === module) {
  run2025YearScraper().catch(console.error);
}

module.exports = { Pharmacy2025YearScraper, run2025YearScraper };
