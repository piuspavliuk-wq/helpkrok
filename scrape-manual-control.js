const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function scrapeWithManualControl(url) {
  console.log('🚀 Запуск браузера з ручним контролем...');
  
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized', '--disable-web-security', '--disable-features=VizDisplayCompositor']
  });

  try {
    const page = await browser.newPage();
    
    // Налаштування для кращого рендерингу
    await page.setViewport({ width: 1920, height: 1080 });
    
    // Відключення завантаження зображень для швидкості
    await page.setRequestInterception(true);
    page.on('request', (req) => {
      if (req.resourceType() === 'image') {
        req.continue();
      } else {
        req.continue();
      }
    });

    console.log(`📖 Перехід на сторінку: ${url}`);
    await page.goto(url, { waitUntil: 'networkidle2', timeout: 30000 });
    console.log('✅ Сторінка завантажена');

    // Ручний контроль - чекаємо на введення користувача
    console.log('\n🔧 РУЧНИЙ КОНТРОЛЬ');
    console.log('📋 Інструкції:');
    console.log('1. Зайдіть в систему якщо потрібно');
    console.log('2. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('3. Натисніть на неї');
    console.log('4. Виберіть "Показувати правильні відповіді"');
    console.log('5. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('6. Натисніть ENTER в терміналі коли будете готові...\n');

    // Чекаємо на введення користувача
    await new Promise(resolve => {
      process.stdin.once('data', () => {
        resolve();
      });
    });

    console.log('🚀 Починаємо збір даних...\n');

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
      console.log('❌ Питання не знайдено. Можливо потрібна авторизація або інший селектор.');
      console.log('🔍 Спробуємо знайти альтернативні селектори...');
      
      const alternativeSelectors = await page.evaluate(() => {
        const selectors = [
          '.question-item',
          '.test-question', 
          '.question-block',
          '[class*="question"]',
          '.item',
          '.test-item'
        ];
        
        const results = {};
        selectors.forEach(selector => {
          const elements = document.querySelectorAll(selector);
          results[selector] = elements.length;
        });
        
        return results;
      });
      
      console.log('🔍 Альтернативні селектори:', alternativeSelectors);
      return;
    }

    // Збираємо дані
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

        // Збираємо дані з підтримкою зображень
        const questionData = await page.evaluate((questionIndex) => {
          const questions = document.querySelectorAll('.question');
          const questionElement = questions[questionIndex - 1];
          
          if (!questionElement) return null;

          // Текст питання з підтримкою зображень
          const questionTextElement = questionElement.querySelector('.question__text');
          let questionText = '';
          
          if (questionTextElement) {
            // Копіюємо весь HTML контент, включаючи зображення
            questionText = questionTextElement.innerHTML;
          }

          // Збираємо варіанти відповідей
          const variants = questionElement.querySelectorAll('.question__variant');
          const options = [];
          let correctAnswer = null;

          variants.forEach((variant, index) => {
            const letter = String.fromCharCode(65 + index); // A, B, C, D, E
            const textElement = variant.querySelector('.question__variant-text');
            const isCorrect = variant.classList.contains('question__variant_right');
            
            let optionText = '';
            if (textElement) {
              // Копіюємо HTML контент варіанту, включаючи зображення
              optionText = textElement.innerHTML;
            }
            
            if (optionText.trim()) {
              options.push({
                letter: letter,
                text: optionText,
                is_correct: isCorrect
              });
              
              if (isCorrect) {
                correctAnswer = letter;
              }
            }
          });

          return {
            question_text: questionText,
            options: options,
            correct_answer: correctAnswer,
            has_images: questionText.includes('<img') || options.some(opt => opt.text.includes('<img'))
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
          
          const imageStatus = questionData.has_images ? ' (з зображеннями)' : '';
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

    // Зберігаємо дані
    const timestamp = Date.now();
    const filename = `krok-lead-manual-${timestamp}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    // Створюємо папку data якщо не існує
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    const dataToSave = {
      page_info: {
        url: url,
        faculty: 'pharmaceutical',
        year: 2025,
        subject: 'органічна_хімія', // Буде визначено з заголовка сторінки
        scraped_at: new Date().toISOString(),
        total_questions_found: totalQuestions,
        questions_collected: successCount,
        questions_failed: failCount,
        success_rate: `${((successCount / totalQuestions) * 100).toFixed(1)}%`
      },
      questions: questions
    };

    fs.writeFileSync(filepath, JSON.stringify(dataToSave, null, 2), 'utf8');
    console.log(`\n💾 Дані збережено в файл: ${filename}`);
    console.log(`📁 Повний шлях: ${filepath}`);
    console.log(`📊 Зібрано ${questions.length} питань з підтримкою зображень`);

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
  console.log('📝 Використання: node scrape-manual-control.js <URL>');
  process.exit(1);
}

scrapeWithManualControl(url)
  .then((filepath) => {
    console.log(`\n🎉 Збір даних завершено! Файл: ${filepath}`);
  })
  .catch((error) => {
    console.error('🚨 Критична помилка:', error);
    process.exit(1);
  });
