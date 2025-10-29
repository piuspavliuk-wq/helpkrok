const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function scrape2025Day2TextWith30sTimer() {
  console.log('🚀 Запуск браузера для збору 2025р 2 д (ТЕХТ) з 30-секундним таймером...');
  
  const browser = await puppeteer.launch({
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

  try {
    const page = await browser.newPage();
    
    // Налаштування для кращого рендерингу
    await page.setViewport({ width: 1920, height: 1080 });
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
    
    // Відключення завантаження зображень для швидкості
    await page.setRequestInterception(true);
    page.on('request', (req) => {
      if (req.resourceType() === 'image') {
        req.continue();
      } else {
        req.continue();
      }
    });

    console.log('📖 Перехід на krok-lead.com...');
    await page.goto('https://krok-lead.com', { waitUntil: 'networkidle2', timeout: 30000 });
    console.log('✅ Сайт завантажено');

    // Таймер 30 секунд для ручного налаштування
    console.log('\n⏰ ТАЙМЕР 30 СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ');
    console.log('📋 Інструкції:');
    console.log('1. Зайдіть в систему якщо потрібно');
    console.log('2. Знайдіть тест "2025р 2 д (ТЕХТ)"');
    console.log('3. Відкрийте тест');
    console.log('4. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('5. Натисніть на неї');
    console.log('6. Виберіть "Показувати правильні відповіді"');
    console.log('7. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('8. Чекайте завершення таймера...\n');

    for (let i = 30; i > 0; i--) {
      console.log(`⏳ Залишилось: ${i} секунд...`);
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
    console.log('🚀 Таймер завершено! Продовжуємо збір даних...\n');

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
    
    console.log(`📊 Загальна кількість питань: ${totalQuestions}`);

    // Збираємо всі питання
    console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
    const allQuestions = [];

    for (let i = 0; i < totalQuestions; i++) {
      try {
        console.log(`\n🔄 Обробка питання ${i + 1}/${totalQuestions}...`);
        
        // Прокручуємо до питання
        await page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            questions[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        }, i);
        
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Клікаємо на питання та варіанти
        await page.evaluate((index) => {
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
        
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        // Збираємо дані питання
        const questionData = await page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          const question = questions[index];
          
          if (!question) return null;
          
          const cleanText = (text) => {
            if (!text) return '';
            return text.replace(/\s+/g, ' ').trim();
          };

          // Текст питання
          let questionText = '';
          const questionTextEl = question.querySelector('.question__text');
          if (questionTextEl) {
            questionText = cleanText(questionTextEl.textContent);
          }

          // Варіанти відповідей
          const variantElements = question.querySelectorAll('.question__variant');
          const options = {};
          let correctAnswer = '';

          variantElements.forEach((variantEl, variantIndex) => {
            const letterSpan = variantEl.querySelector('span');
            if (letterSpan) {
              const letter = cleanText(letterSpan.textContent);
              if (letter && letter.length === 1) {
                // Перевіряємо чи це правильна відповідь
                const isCorrect = variantEl.classList.contains('question__variant_right') || 
                                 variantEl.querySelector('.icon-kl-check') !== null ||
                                 variantEl.querySelector('[class*="check"]') !== null;
                
                options[`option_${letter.toLowerCase()}`] = letter;
                if (isCorrect) {
                  correctAnswer = letter;
                }
              }
            }
          });
          
          return {
            question_text: questionText,
            option_a: options.option_a || '',
            option_b: options.option_b || '',
            option_c: options.option_c || '',
            option_d: options.option_d || '',
            option_e: options.option_e || '',
            correct_answer: correctAnswer,
            year: 2025,
            faculty: 'medical',
            test_identifier: '2025-day2-text',
            category: 'Загальна медицина'
          };
        }, i);
        
        if (questionData && questionData.question_text) {
          allQuestions.push(questionData);
          console.log(`✅ Питання ${i + 1}: "${questionData.question_text.substring(0, 50)}..."`);
          console.log(`   Правильна відповідь: ${questionData.correct_answer}`);
        } else {
          console.log(`⚠️ Питання ${i + 1}: не вдалося зібрати дані`);
        }
        
      } catch (error) {
        console.log(`❌ Помилка при обробці питання ${i + 1}:`, error.message);
      }
    }
    
    console.log(`\n🎉 Збір завершено! Зібрано ${allQuestions.length} питань`);

    // Зберігаємо дані
    if (allQuestions.length > 0) {
      const timestamp = Date.now();
      const filename = `2025-day2-text-questions-${timestamp}.json`;
      const filepath = path.join(__dirname, 'data', filename);
      
      // Створюємо папку data якщо не існує
      const dataDir = path.join(__dirname, 'data');
      if (!fs.existsSync(dataDir)) {
        fs.mkdirSync(dataDir, { recursive: true });
      }
      
      const data = {
        metadata: {
          total_questions: allQuestions.length,
          year: 2025,
          faculty: 'medical',
          test_identifier: '2025-day2-text',
          scraped_at: new Date().toISOString(),
          source: 'krok-lead.com'
        },
        questions: allQuestions
      };
      
      fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
      console.log(`💾 Дані збережено в файл: ${filename}`);
      console.log(`📁 Повний шлях: ${filepath}`);
      
      // Генеруємо SQL
      const sqlFilename = `2025-day2-text-questions-${timestamp}.sql`;
      const sqlFilepath = path.join(__dirname, 'data', sqlFilename);
      
      let sql = `-- SQL для імпорту питань 2025р 2 д (ТЕХТ)
-- Згенеровано: ${new Date().toISOString()}
-- Кількість питань: ${allQuestions.length}

INSERT INTO krok_questions_unified (
    question_text, year, faculty, category, difficulty, is_active,
    option_a, option_b, option_c, option_d, option_e, correct_answer,
    test_identifier, title, created_at, updated_at
) VALUES
`;

      const values = allQuestions.map((q, index) => {
        const escapedText = q.question_text.replace(/'/g, "''");
        return `(
    '${escapedText}',
    ${q.year},
    '${q.faculty}',
    '${q.category}',
    'medium',
    true,
    '${q.option_a}',
    '${q.option_b}',
    '${q.option_c}',
    '${q.option_d}',
    '${q.option_e}',
    '${q.correct_answer}',
    '${q.test_identifier}',
    '2025р 2 д (ТЕХТ)',
    NOW(),
    NOW()
)`;
      });

      sql += values.join(',\n') + ';';
      
      fs.writeFileSync(sqlFilepath, sql, 'utf8');
      console.log(`📄 SQL згенеровано: ${sqlFilename}`);
      console.log(`📁 Повний шлях: ${sqlFilepath}`);
      
      console.log('\n🎉 СКРАПІНГ ЗАВЕРШЕНО!');
      console.log(`📊 Зібрано: ${allQuestions.length} питань`);
      console.log(`📄 JSON файл: ${filename}`);
      console.log(`📄 SQL файл: ${sqlFilename}`);
    } else {
      console.log('⚠️ Немає питань для збереження');
    }

  } catch (error) {
    console.error('❌ Помилка:', error);
  } finally {
    await browser.close();
    console.log('🔒 Браузер закрито');
  }
}

// Запуск скрапера
scrape2025Day2TextWith30sTimer().catch(console.error);
