const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class PharmacySmartScraper {
  constructor(config) {
    this.browser = null;
    this.page = null;
    this.config = config;
  }

  async init() {
    console.log('🏥 Запуск браузера для розумного збору фармації...');
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
    const maxScrollAttempts = 15;
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      await this.page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
      await this.waitFor(3000);
      
      currentHeight = await this.page.evaluate('document.body.scrollHeight');
      scrollAttempts++;
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
      
      const questionsCount = await this.page.evaluate(() => {
        return document.querySelectorAll('.question').length;
      });
      console.log(`📊 Поточна кількість питань: ${questionsCount}`);
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
    
    const allQuestions = [];
    
    for (let i = 0; i < questionsCount; i++) {
      try {
        console.log(`\n🔄 Обробка питання ${i + 1}/${questionsCount}...`);
        
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
                option_a: options.A || '',
                option_b: options.B || '',
                option_c: options.C || '',
                option_d: options.D || '',
                option_e: options.E || '',
                option_a_image: optionImages.A || null,
                option_b_image: optionImages.B || null,
                option_c_image: optionImages.C || null,
                option_d_image: optionImages.D || null,
                option_e_image: optionImages.E || null,
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
          const imagesCount = Object.values(questionData).filter(v => v && typeof v === 'string' && v.startsWith('data:image')).length;
          const questionType = questionData.question_type;
          const questionImageStatus = questionData.question_image ? 'Так' : 'Ні';
          console.log(`✅ Питання ${i + 1}: зібрано 5 варіантів, правильна: ${questionData.correct_answer || 'не визначено'}, тип: ${questionType}, зображення в питанні: ${questionImageStatus}, зображення в варіантах: ${imagesCount}`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати варіанти`);
        }
        
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
    const filepath = path.join('data', filename);
    fs.writeFileSync(filepath, JSON.stringify(questions, null, 2));
    console.log(`💾 Дані збережено в: ${filepath}`);
  }

  async generateSQL(questions, filename, year, faculty, testIdentifier, title) {
    const filepath = path.join('data', filename);
    
    let sql = `-- SQL для імпорту тесту "${title}" (фармація з підтримкою зображень)\n`;
    sql += `-- Рік: ${year}, Факультет: ${faculty}, Test ID: ${testIdentifier}\n`;
    sql += `-- Кількість питань: ${questions.length}\n\n`;
    
    questions.forEach((question, index) => {
      const escapedQuestion = question.question_text.replace(/'/g, "''");
      const escapedA = (question.option_a || '').replace(/'/g, "''");
      const escapedB = (question.option_b || '').replace(/'/g, "''");
      const escapedC = (question.option_c || '').replace(/'/g, "''");
      const escapedD = (question.option_d || '').replace(/'/g, "''");
      const escapedE = (question.option_e || '').replace(/'/g, "''");
      
      // Обробляємо зображення
      const questionImage = question.question_image ? question.question_image.replace(/'/g, "''") : null;
      const optionAImage = question.option_a_image ? question.option_a_image.replace(/'/g, "''") : null;
      const optionBImage = question.option_b_image ? question.option_b_image.replace(/'/g, "''") : null;
      const optionCImage = question.option_c_image ? question.option_c_image.replace(/'/g, "''") : null;
      const optionDImage = question.option_d_image ? question.option_d_image.replace(/'/g, "''") : null;
      const optionEImage = question.option_e_image ? question.option_e_image.replace(/'/g, "''") : null;
      
      sql += `INSERT INTO krok_questions_unified_pharmacy (
  year, faculty, test_identifier, title, category, difficulty,
  question_text, option_a, option_b, option_c, option_d, option_e, correct_answer,
  question_image, option_a_image, option_b_image, option_c_image, option_d_image, option_e_image,
  question_type, is_active, created_at, updated_at
) VALUES (
  ${year}, '${faculty}', '${testIdentifier}', '${title}', 'general', 'medium',
  '${escapedQuestion}',
  '${escapedA}',
  '${escapedB}',
  '${escapedC}',
  '${escapedD}',
  '${escapedE}',
  '${question.correct_answer}',
  ${questionImage ? `'${questionImage}'` : 'NULL'},
  ${optionAImage ? `'${optionAImage}'` : 'NULL'},
  ${optionBImage ? `'${optionBImage}'` : 'NULL'},
  ${optionCImage ? `'${optionCImage}'` : 'NULL'},
  ${optionDImage ? `'${optionDImage}'` : 'NULL'},
  ${optionEImage ? `'${optionEImage}'` : 'NULL'},
  '${question.question_type}',
  true, NOW(), NOW()
);\n\n`;
    });
    
    fs.writeFileSync(filepath, sql);
    console.log(`📄 SQL файл збережено: ${filepath}`);
  }

  async closeBrowser() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

async function scrapePharmacySmart(config) {
  const scraper = new PharmacySmartScraper(config);
  
  try {
    await scraper.init();
    await scraper.navigateToTest(config.url);
    await scraper.waitWithTimer(config.timerSeconds);
    
    console.log('\n📜 Прокручуємо сторінку для завантаження всіх питань...');
    await scraper.scrollToLoadAllQuestions();
    console.log('✅ Всі питання завантажено!');
    
    console.log('\n🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    const questions = await scraper.clickOnEachQuestionIndividually();
    
    if (questions.length > 0) {
      console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
      
      // Показуємо статистику
      const correctAnswersCount = questions.filter(q => q.correct_answer).length;
      const withImagesCount = questions.filter(q => q.has_images).length;
      const textOnlyCount = questions.length - withImagesCount;
      
      console.log('\n📊 Статистика:');
      console.log(`- Всього питань: ${questions.length}`);
      console.log(`- З правильними відповідями: ${correctAnswersCount}`);
      console.log(`- З зображеннями: ${withImagesCount}`);
      console.log(`- Тільки текст: ${textOnlyCount}`);
      
      // Зберігаємо дані в JSON
      const timestamp = Date.now();
      const jsonFilename = `${config.testIdentifier}-questions-${timestamp}.json`;
      await scraper.saveData(questions, jsonFilename);
      
      // Генеруємо SQL
      const sqlFilename = `${config.testIdentifier}-questions-${timestamp}.sql`;
      await scraper.generateSQL(questions, sqlFilename, config.year, config.faculty, config.testIdentifier, config.title);
      
      return questions;
    } else {
      console.log('\n❌ Скрапінг не зібрав питань.');
      return [];
    }
    
  } finally {
    await scraper.closeBrowser();
  }
}

// Конфігурації для фармації 2007-2017
const pharmacyConfigs = {
  '2007-pharmacy': {
    year: 2007,
    faculty: 'pharmacy',
    testIdentifier: '2007-pharmacy',
    title: '2007 рік 1',
    url: 'https://krok-lead.com',
    timerSeconds: 60
  },
  '2008-pharmacy': {
    year: 2008,
    faculty: 'pharmacy',
    testIdentifier: '2008-pharmacy',
    title: '2008 рік 2',
    url: 'https://krok-lead.com',
    timerSeconds: 120
  },
  '2009-pharmacy': {
    year: 2009,
    faculty: 'pharmacy',
    testIdentifier: '2009-pharmacy',
    title: '2009 рік 3',
    url: 'https://krok-lead.com',
    timerSeconds: 180
  },
  '2010-pharmacy': {
    year: 2010,
    faculty: 'pharmacy',
    testIdentifier: '2010-pharmacy',
    title: '2010 рік 4',
    url: 'https://krok-lead.com',
    timerSeconds: 240
  },
  '2011-pharmacy': {
    year: 2011,
    faculty: 'pharmacy',
    testIdentifier: '2011-pharmacy',
    title: '2011 рік 5',
    url: 'https://krok-lead.com',
    timerSeconds: 300
  },
  '2012-pharmacy': {
    year: 2012,
    faculty: 'pharmacy',
    testIdentifier: '2012-pharmacy',
    title: '2012 рік 6',
    url: 'https://krok-lead.com',
    timerSeconds: 360
  },
  '2013-pharmacy': {
    year: 2013,
    faculty: 'pharmacy',
    testIdentifier: '2013-pharmacy',
    title: '2013 рік 7',
    url: 'https://krok-lead.com',
    timerSeconds: 420
  },
  '2014-pharmacy': {
    year: 2014,
    faculty: 'pharmacy',
    testIdentifier: '2014-pharmacy',
    title: '2014 рік 8',
    url: 'https://krok-lead.com',
    timerSeconds: 480
  },
  '2015-pharmacy': {
    year: 2015,
    faculty: 'pharmacy',
    testIdentifier: '2015-pharmacy',
    title: '2015 рік 9',
    url: 'https://krok-lead.com',
    timerSeconds: 540
  },
  '2016-pharmacy': {
    year: 2016,
    faculty: 'pharmacy',
    testIdentifier: '2016-pharmacy',
    title: '2016 рік 10',
    url: 'https://krok-lead.com',
    timerSeconds: 600
  },
  '2017-pharmacy': {
    year: 2017,
    faculty: 'pharmacy',
    testIdentifier: '2017-pharmacy',
    title: '2017 рік 11',
    url: 'https://krok-lead.com',
    timerSeconds: 660
  }
};

async function main() {
  const testName = process.argv[2];

  if (!testName) {
    console.log('🏥 РОЗУМНИЙ ФАРМАЦЕВТИЧНИЙ СКРАПЕР КРОК');
    console.log('\n📋 Доступні тести:');
    Object.keys(pharmacyConfigs).forEach(key => {
      const config = pharmacyConfigs[key];
      console.log(`   - ${key}: ${config.title} (${config.year})`);
    });
    console.log('\n🚀 Використання:');
    console.log('   node scrape-pharmacy-smart.js <test-name>');
    console.log('\n📝 Приклад:');
    console.log('   node scrape-pharmacy-smart.js 2007-pharmacy');
    return;
  }
  
  const config = pharmacyConfigs[testName];
  
  if (!config) {
    console.log('❌ Тест не знайдено!');
    console.log('📋 Доступні тести:');
    Object.keys(pharmacyConfigs).forEach(key => {
      const config = pharmacyConfigs[key];
      console.log(`   - ${key}: ${config.title} (${config.year})`);
    });
    return;
  }
  
  console.log(`🏥 РОЗУМНИЙ ФАРМАЦЕВТИЧНИЙ СКРАПЕР для тесту "${config.title}"`);
  console.log('📋 Параметри:');
  console.log(`   - Рік: ${config.year}`);
  console.log(`   - Факультет: ${config.faculty}`);
  console.log(`   - Test ID: ${config.testIdentifier}`);
  console.log(`   - Назва: ${config.title}`);
  console.log(`   - Таймер: ${config.timerSeconds} секунд`);
  console.log('');
  
  console.log('🚀 Запускаємо розумний фармацевтичний скрапінг...');
  console.log('📖 Відкрийте потрібну сторінку тесту в браузері');
  console.log(`⏰ У вас буде ${config.timerSeconds} секунд для налаштування правильних відповідей`);
  console.log('🔄 Індивідуальні кліки на кожне питання для розкриття варіантів');
  console.log('🖼️ Автоматичне виявлення та збереження зображень');
  console.log('');
  
  const questions = await scrapePharmacySmart(config);
  
  if (questions.length > 0) {
    console.log(`\n🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
    
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте зібрані дані в JSON файлі');
    console.log('2. Виконайте SQL файл в Supabase');
    console.log('3. Перевірте відображення на сайті');
  } else {
    console.log('\n❌ Скрапінг не зібрав питань.');
  }
}

main().catch(console.error);
