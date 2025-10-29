const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class EnhancedImageScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера з підтримкою зображень...');
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

            // Функція для отримання зображення як base64
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
            
            // Отримуємо варіанти відповідей
            const variantElements = questionEl.querySelectorAll('.question__variant');
            const options = {};
            let correctAnswer = '';
            
            for (let variantIndex = 0; variantIndex < variantElements.length; variantIndex++) {
              const variantEl = variantElements[variantIndex];
              const letter = String.fromCharCode(65 + variantIndex); // A, B, C, D, E
              
              // Перевіряємо, чи це правильна відповідь
              const isCorrect = variantEl.classList.contains('question__variant_right') || 
                                variantEl.querySelector('.icon-kl-check') ||
                                variantEl.querySelector('[class*="check"]');
              
              if (isCorrect) {
                correctAnswer = letter;
              }
              
              // Шукаємо текст у span
              const spanEl = variantEl.querySelector('span');
              let optionText = spanEl ? cleanText(spanEl.textContent) : '';
              
              // Якщо немає тексту, шукаємо зображення
              if (!optionText || optionText.length < 5) {
                const imgEl = variantEl.querySelector('img');
                if (imgEl) {
                  // Спробуємо отримати base64 зображення
                  try {
                    const base64Image = getImageAsBase64(imgEl);
                    if (base64Image) {
                      optionText = `[IMAGE:${base64Image.substring(0, 100)}...]`;
                    } else {
                      optionText = `[IMAGE:${imgEl.src || 'unknown'}]`;
                    }
                  } catch (error) {
                    optionText = `[IMAGE:${imgEl.src || 'unknown'}]`;
                  }
                } else {
                  // Шукаємо SVG або інші графічні елементи
                  const svgEl = variantEl.querySelector('svg');
                  if (svgEl) {
                    optionText = `[SVG:${svgEl.outerHTML.substring(0, 100)}...]`;
                  } else {
                    // Шукаємо background-image в CSS
                    const computedStyle = window.getComputedStyle(variantEl);
                    const backgroundImage = computedStyle.backgroundImage;
                    if (backgroundImage && backgroundImage !== 'none') {
                      optionText = `[BACKGROUND_IMAGE:${backgroundImage}]`;
                    } else {
                      optionText = `[VISUAL_CONTENT]`;
                    }
                  }
                }
              }
              
              // Додаємо варіант, якщо є контент
              if (optionText && optionText.length > 0) {
                options[letter] = optionText;
              }
            }
            
            if (Object.keys(options).length > 0) {
              return {
                question_text: questionText,
                options: options,
                correct_answer: correctAnswer,
                question_number: index + 1,
                extracted_at: new Date().toISOString(),
                has_images: Object.values(options).some(opt => opt.includes('[IMAGE:') || opt.includes('[SVG:') || opt.includes('[BACKGROUND_IMAGE:') || opt.includes('[VISUAL_CONTENT]'))
              };
            }
          }
          return null;
        }, i);
        
        if (questionData) {
          allQuestions.push(questionData);
          const imageCount = Object.values(questionData.options).filter(opt => 
            opt.includes('[IMAGE:') || opt.includes('[SVG:') || opt.includes('[BACKGROUND_IMAGE:') || opt.includes('[VISUAL_CONTENT]')
          ).length;
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData.options).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}, зображень: ${imageCount}`);
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
      total_questions: questions.length,
      questions_with_images: questions.filter(q => q.has_images).length
    };

    const filename = `krok-lead-enhanced-images-${Date.now()}.json`;
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
async function scrapeWithEnhancedImages(url, timerSeconds = 10) {
  const scraper = new EnhancedImageScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // Таймер для ручного налаштування
    await scraper.waitWithTimer(timerSeconds);
    
    // Прокручуємо сторінку для завантаження всіх питань
    await scraper.scrollToLoadAllQuestions();
    
    // Клікаємо на кожне питання індивідуально
    const questions = await scraper.clickOnEachQuestionIndividually();
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано дані! Файл: ${filepath}`);
      
      // Показуємо статистику
      const correctAnswersCount = questions.filter(q => q.correct_answer).length;
      const questionsWithImages = questions.filter(q => q.has_images).length;
      console.log('\n📊 Статистика:');
      console.log(`- Всього питань: ${questions.length}`);
      console.log(`- З правильними відповідями: ${correctAnswersCount}`);
      console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);
      console.log(`- З зображеннями: ${questionsWithImages}`);
      console.log(`- Тільки текст: ${questions.length - questionsWithImages}`);
      
      // Показуємо приклади питань
      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 5).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   Варіанти: ${Object.keys(q.options).length}`);
        console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
        console.log(`   Має зображення: ${q.has_images ? 'Так' : 'Ні'}`);
        Object.entries(q.options).forEach(([letter, text]) => {
          const isCorrect = letter === q.correct_answer ? ' ✓' : '';
          const isImage = text.includes('[IMAGE:') || text.includes('[SVG:') || text.includes('[BACKGROUND_IMAGE:') || text.includes('[VISUAL_CONTENT]') ? ' 🖼️' : '';
          console.log(`   ${letter}: ${text.substring(0, 50)}...${isCorrect}${isImage}`);
        });
      });
      
      if (questions.length > 5) {
        console.log(`   ... та ще ${questions.length - 5} питань`);
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
  const url = process.argv[2] || 'https://krok-lead.com/';
  const timerSeconds = parseInt(process.argv[3]) || 10;
  scrapeWithEnhancedImages(url, timerSeconds);
}

module.exports = { EnhancedImageScraper, scrapeWithEnhancedImages };
