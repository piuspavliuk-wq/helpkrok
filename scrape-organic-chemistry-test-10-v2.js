const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class OrganicChemistryTestV2Scraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера для тестового збору органічної хімії v2 (10 питань)...');
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
    const maxScrollAttempts = 5; // Менше прокруток для тесту
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      await this.page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
      await this.waitFor(2000);
      
      currentHeight = await this.page.evaluate('document.body.scrollHeight');
      scrollAttempts++;
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
    }
    
    await this.page.evaluate('window.scrollTo(0, 0)');
    await this.waitFor(2000);
  }

  async clickOnEachQuestionIndividually() {
    console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    
    const questionsCount = await this.page.evaluate(() => {
      return document.querySelectorAll('.question').length;
    });
    
    console.log(`📊 Знайдено ${questionsCount} питань`);
    
    // Обмежуємо до 10 питань для тесту
    const maxQuestions = Math.min(10, questionsCount);
    console.log(`🧪 ТЕСТОВИЙ РЕЖИМ: обробляємо тільки ${maxQuestions} питань`);
    
    const allQuestions = [];
    
    for (let i = 0; i < maxQuestions; i++) {
      try {
        console.log(`\n🔄 Обробка питання ${i + 1}/${maxQuestions}...`);
        
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
                // Якщо є зображення, але немає тексту, ставимо опис
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
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData.options).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}, тип: ${questionType}, зображення в питанні: ${questionImageStatus}, зображення в варіантах: ${imagesCount}`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати варіанти`);
        }
        
      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i + 1}:`, error.message);
      }
    }
    
    console.log(`✅ Тестовий збір завершено. Зібрано ${allQuestions.length} питань`);
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
      questions_with_images: questions.filter(q => q.has_images).length,
      questions_text_only: questions.filter(q => !q.has_images).length
    };

    const filename = `krok-lead-organic-chemistry-test-10-v2-${Date.now()}.json`;
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

async function scrapeOrganicChemistryTest10V2(url, timerSeconds = 10) {
  const scraper = new OrganicChemistryTestV2Scraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    await scraper.waitWithTimer(timerSeconds);
    
    await scraper.scrollToLoadAllQuestions();
    
    const questions = await scraper.clickOnEachQuestionIndividually();
    
    const pageInfo = await scraper.getPageInfo();
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    if (questions.length > 0) {
      const filepath = await scraper.saveQuestions(questions, pageInfo);
      console.log(`🎉 Успішно зібрано тестові дані! Файл: ${filepath}`);
      
      const correctAnswersCount = questions.filter(q => q.correct_answer).length;
      const withImagesCount = questions.filter(q => q.has_images).length;
      const textOnlyCount = questions.length - withImagesCount;
      
      console.log('\n📊 Статистика тестового збору:');
      console.log(`- Всього питань: ${questions.length}`);
      console.log(`- З правильними відповідями: ${correctAnswersCount}`);
      console.log(`- З зображеннями: ${withImagesCount}`);
      console.log(`- Тільки текст: ${textOnlyCount}`);
      
      console.log('\n📝 Приклади зібраних питань:');
      questions.forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 80)}...`);
        console.log(`   Тип: ${q.question_type}`);
        console.log(`   Варіанти: ${Object.keys(q.options).length}`);
        console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
        console.log(`   Зображення в питанні: ${q.question_image ? 'Так' : 'Ні'}`);
        console.log(`   Зображення в варіантах: ${Object.keys(q.option_images || {}).length}`);
        Object.entries(q.options).forEach(([letter, text]) => {
          const isCorrect = letter === q.correct_answer ? ' ✓' : '';
          const hasImage = q.option_images && q.option_images[letter] ? ' 🖼️' : '';
          console.log(`   ${letter}: ${text}${isCorrect}${hasImage}`);
        });
        console.log('---');
      });
      
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

if (require.main === module) {
  const url = process.argv[2] || 'https://krok-lead.com/';
  const timerSeconds = parseInt(process.argv[3]) || 10;
  scrapeOrganicChemistryTest10V2(url, timerSeconds);
}

module.exports = { OrganicChemistryTestV2Scraper, scrapeOrganicChemistryTest10V2 };
