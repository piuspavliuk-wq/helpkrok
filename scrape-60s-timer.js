const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function scrapeWith60sTimer(url) {
  console.log('🚀 Запуск браузера з 60-секундним таймером...');
  
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized', '--disable-web-security', '--disable-features=VizDisplayCompositor']
  });

  try {
    const page = await browser.newPage();
    
    // Налаштування для кращого рендерингу
    await page.setViewport({ width: 1920, height: 1080 });
    
    // НЕ відключаємо зображення - вони нам потрібні
    console.log(`📖 Перехід на сторінку: ${url}`);
    await page.goto(url, { waitUntil: 'networkidle2', timeout: 30000 });
    console.log('✅ Сторінка завантажена');

    // Таймер 60 секунд для ручного налаштування
    console.log('\n⏰ ТАЙМЕР 60 СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ');
    console.log('📋 Інструкції:');
    console.log('1. Зайдіть в систему якщо потрібно');
    console.log('2. Перейдіть до потрібного тесту (фармація)');
    console.log('3. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('4. Натисніть на неї');
    console.log('5. Виберіть "Показувати правильні відповіді"');
    console.log('6. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('7. Чекайте завершення таймера...\n');

    for (let i = 60; i > 0; i--) {
      console.log(`⏳ Залишилось: ${i} секунд...`);
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
    console.log('🚀 Таймер завершено! Продовжуємо збір даних...\n');

    // Отримуємо поточний URL
    const currentUrl = page.url();
    console.log(`📍 Поточний URL: ${currentUrl}`);

    // Прокрутка для завантаження всіх питань
    console.log('📜 Прокручуємо сторінку для завантаження всіх питань...');
    let previousHeight = 0;
    let scrollAttempts = 0;
    const maxScrollAttempts = 20;

    while (scrollAttempts < maxScrollAttempts) {
      scrollAttempts++;
      const currentHeight = await page.evaluate(() => document.body.scrollHeight);
      
      if (currentHeight === previousHeight) {
        console.log('📜 Прокрутка завершена - висота не змінюється');
        break;
      }
      
      previousHeight = currentHeight;
      await page.evaluate(() => {
        window.scrollTo(0, document.body.scrollHeight);
      });
      
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      const questionCount = await page.evaluate(() => {
        return document.querySelectorAll('.question').length;
      });
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
      console.log(`📊 Поточна кількість питань: ${questionCount}`);
    }

    // Отримуємо загальну кількість питань
    const totalQuestions = await page.evaluate(() => {
      return document.querySelectorAll('.question').length;
    });
    console.log(`📊 Знайдено ${totalQuestions} питань\n`);

    if (totalQuestions === 0) {
      console.log('❌ Питання не знайдено. Спробуємо альтернативні селектори...');
      
      // Спробуємо альтернативні селектори
      const alternativeSelectors = await page.evaluate(() => {
        const selectors = [
          '.question-item',
          '.test-question', 
          '.question-block',
          '[class*="question"]',
          '.item',
          '.test-item',
          '.quiz-item',
          '.test-question-item',
          '.question-container',
          '.question-wrapper',
          '.test-item-wrapper',
          '.quiz-question',
          '.exam-question',
          '.test-question-container'
        ];
        
        const results = {};
        selectors.forEach(selector => {
          const elements = document.querySelectorAll(selector);
          results[selector] = elements.length;
        });
        
        return results;
      });
      
      console.log('🔍 Альтернативні селектори:', alternativeSelectors);
      
      // Знаходимо найкращий селектор
      const bestSelector = Object.entries(alternativeSelectors).find(([selector, count]) => count > 0);
      
      if (bestSelector) {
        console.log(`✅ Знайдено альтернативний селектор: ${bestSelector[0]} (${bestSelector[1]} елементів)`);
        
        // Зберігаємо HTML для аналізу
        const html = await page.content();
        const timestamp = Date.now();
        const filename = `krok-lead-html-${timestamp}.html`;
        const filepath = path.join(__dirname, 'data', filename);
        
        if (!fs.existsSync(path.join(__dirname, 'data'))) {
          fs.mkdirSync(path.join(__dirname, 'data'));
        }
        
        fs.writeFileSync(filepath, html, 'utf8');
        console.log(`💾 HTML збережено в файл: ${filename}`);
        console.log(`📁 Повний шлях: ${filepath}`);
        console.log('🔍 Можете відкрити файл в браузері для аналізу структури');
      }
      
      return;
    }

    // Збираємо дані з зображеннями в base64
    console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    
    const questions = [];
    let successCount = 0;
    let failCount = 0;

    for (let i = 1; i <= totalQuestions; i++) {
      console.log(`\n🔄 Обробка питання ${i}/${totalQuestions}...`);
      
      try {
        // Прокручуємо до питання
        await page.evaluate((questionIndex) => {
          const questions = document.querySelectorAll('.question');
          if (questions[questionIndex - 1]) {
            questions[questionIndex - 1].scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        }, i);
        
        await new Promise(resolve => setTimeout(resolve, 500));

        // Клікаємо на питання
        await page.evaluate((questionIndex) => {
          const questions = document.querySelectorAll('.question');
          if (questions[questionIndex - 1]) {
            questions[questionIndex - 1].click();
          }
        }, i);
        
        await new Promise(resolve => setTimeout(resolve, 1000));

        // Збираємо дані з зображеннями в base64
        const questionData = await page.evaluate(async (questionIndex) => {
          const questions = document.querySelectorAll('.question');
          const questionElement = questions[questionIndex - 1];
          
          if (!questionElement) return null;

          // Функція для конвертації зображень в base64
          const convertImagesToBase64 = async (element) => {
            const images = element.querySelectorAll('img');
            const imageData = [];
            
            for (let img of images) {
              try {
                // Отримуємо canvas з зображення
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.width = img.naturalWidth || img.width;
                canvas.height = img.naturalHeight || img.height;
                
                ctx.drawImage(img, 0, 0);
                const base64 = canvas.toDataURL('image/png');
                imageData.push({
                  src: img.src,
                  base64: base64,
                  alt: img.alt || '',
                  width: img.naturalWidth || img.width,
                  height: img.naturalHeight || img.height
                });
              } catch (error) {
                console.log('Помилка конвертації зображення:', error);
              }
            }
            
            return imageData;
          };

          // Текст питання з зображеннями
          const questionTextElement = questionElement.querySelector('.question__text');
          let questionText = '';
          let questionImages = [];
          
          if (questionTextElement) {
            questionText = questionTextElement.textContent || questionTextElement.innerText || '';
            questionImages = await convertImagesToBase64(questionTextElement);
          }

          // Збираємо варіанти відповідей з зображеннями
          const variants = questionElement.querySelectorAll('.question__variant');
          const options = [];
          let correctAnswer = null;

          for (let index = 0; index < variants.length; index++) {
            const variant = variants[index];
            const letter = String.fromCharCode(65 + index); // A, B, C, D, E
            const textElement = variant.querySelector('.question__variant-text');
            const isCorrect = variant.classList.contains('question__variant_right');
            
            let optionText = '';
            let optionImages = [];
            
            if (textElement) {
              optionText = textElement.textContent || textElement.innerText || '';
              optionImages = await convertImagesToBase64(textElement);
            }
            
            if (optionText.trim() || optionImages.length > 0) {
              options.push({
                letter: letter,
                text: optionText,
                images: optionImages,
                is_correct: isCorrect
              });
              
              if (isCorrect) {
                correctAnswer = letter;
              }
            }
          }

          return {
            question_text: questionText,
            question_images: questionImages,
            options: options,
            correct_answer: correctAnswer
          };
        }, i);

        if (questionData && questionData.options.length > 0) {
          questions.push({
            ...questionData,
            question_number: i,
            faculty: 'pharmaceutical',
            year: 2025,
            subject: 'органічна_хімія', // Буде визначено з URL або заголовка
            category: null
          });
          
          const imageCount = questionData.question_images.length + 
                           questionData.options.reduce((sum, opt) => sum + opt.images.length, 0);
          const imageStatus = imageCount > 0 ? ` (${imageCount} зображень)` : '';
          console.log(`✅ Питання ${i}: зібрано ${questionData.options.length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}${imageStatus}`);
          successCount++;
        } else {
          console.log(`⚠️ Питання ${i}: не вдалося зібрати варіанти`);
          failCount++;
        }

        // Показуємо прогрес кожні 10 питань
        if (i % 10 === 0) {
          console.log(`📊 Прогрес: ${i}/${totalQuestions} питань, зібрано: ${successCount}`);
        }

      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i}:`, error.message);
        failCount++;
      }
    }

    console.log(`\n📊 Підсумок збору даних:`);
    console.log(`✅ Успішно зібрано: ${successCount} питань`);
    console.log(`❌ Не вдалося зібрати: ${failCount} питань`);
    console.log(`📈 Відсоток успіху: ${((successCount / totalQuestions) * 100).toFixed(1)}%`);

    // Підраховуємо загальну кількість зображень
    const totalImages = questions.reduce((sum, q) => {
      return sum + q.question_images.length + 
             q.options.reduce((optSum, opt) => optSum + opt.images.length, 0);
    }, 0);

    console.log(`🖼️ Загальна кількість зображень: ${totalImages}`);

    // Зберігаємо дані
    const timestamp = Date.now();
    const filename = `krok-lead-60s-${timestamp}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    // Створюємо папку data якщо не існує
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    const dataToSave = {
      page_info: {
        url: currentUrl,
        faculty: 'pharmaceutical',
        year: 2025,
        subject: 'органічна_хімія', // Буде визначено з заголовка сторінки
        scraped_at: new Date().toISOString(),
        total_questions_found: totalQuestions,
        questions_collected: successCount,
        questions_failed: failCount,
        success_rate: `${((successCount / totalQuestions) * 100).toFixed(1)}%`,
        total_images: totalImages
      },
      questions: questions
    };

    fs.writeFileSync(filepath, JSON.stringify(dataToSave, null, 2), 'utf8');
    console.log(`\n💾 Дані збережено в файл: ${filename}`);
    console.log(`📁 Повний шлях: ${filepath}`);
    console.log(`📊 Зібрано ${questions.length} питань з ${totalImages} зображеннями`);

    return filepath;

  } catch (error) {
    console.error('❌ Помилка при зборі даних:', error);
    throw error;
  } finally {
    await browser.close();
  }
}

// Запуск скрипта
const url = process.argv[2];
if (!url) {
  console.error('❌ Будь ласка, вкажіть URL для збору даних');
  console.log('📝 Використання: node scrape-60s-timer.js <URL>');
  process.exit(1);
}

scrapeWith60sTimer(url)
  .then((filepath) => {
    console.log(`\n🎉 Збір даних завершено! Файл: ${filepath}`);
  })
  .catch((error) => {
    console.error('🚨 Критична помилка:', error);
    process.exit(1);
  });
