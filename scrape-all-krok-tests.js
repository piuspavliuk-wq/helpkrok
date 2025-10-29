const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Створюємо папку data якщо не існує
if (!fs.existsSync('data')) {
  fs.mkdirSync('data');
}

class KrokTestScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера для збору всіх КРОК тестів...');
    this.browser = await puppeteer.launch({
      headless: false,
      defaultViewport: null,
      args: [
        '--start-maximized',
        '--no-sandbox',
        '--disable-setuid-sandbox'
      ]
    });
  }

  async scrapeAllTests(baseUrl, waitTime = 30) {
    try {
      await this.init();
      this.page = await this.browser.newPage();
      
      console.log(`📖 Перехід на сторінку: ${baseUrl}`);
      await this.page.goto(baseUrl, { waitUntil: 'networkidle2' });
      console.log('✅ Сторінка завантажена');

      // Таймер для ручного налаштування
      console.log(`\n⏰ ТАЙМЕР ${waitTime} СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ`);
      console.log('📋 Швидкі інструкції:');
      console.log('1. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
      console.log('2. Натисніть на неї');
      console.log('3. Виберіть "Показувати правильні відповіді"');
      console.log('4. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
      console.log('5. Чекайте завершення таймера...\n');

      // Обратний відлік
      for (let i = waitTime; i > 0; i--) {
        process.stdout.write(`\r⏳ Залишилось: ${i} секунд...`);
        await new Promise(resolve => setTimeout(resolve, 1000));
      }
      
      console.log('\n🚀 Таймер завершено! Продовжуємо збір даних...\n');

      // Прокручуємо сторінку для завантаження всіх питань
      console.log('📜 Прокручуємо сторінку для завантаження всіх питань...');
      let previousHeight = 0;
      let currentHeight = await this.page.evaluate(() => document.body.scrollHeight);
      let scrollAttempts = 0;
      const maxScrollAttempts = 20;

      while (scrollAttempts < maxScrollAttempts && currentHeight > previousHeight) {
        previousHeight = currentHeight;
        await this.page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
        await new Promise(resolve => setTimeout(resolve, 2000));
        currentHeight = await this.page.evaluate(() => document.body.scrollHeight);
        scrollAttempts++;
        
        const questionCount = await this.page.$$eval('.question', questions => questions.length);
        console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
        console.log(`📊 Поточна кількість питань: ${questionCount}`);
      }

      console.log('🖱️ Клікаємо на кожне питання індивідуально для розкриття варіантів...');
      
      // Отримуємо всі питання
      const questions = await this.page.$$('.question');
      console.log(`📊 Знайдено ${questions.length} питань\n`);

      const collectedQuestions = [];

      // Обробляємо кожне питання індивідуально
      for (let i = 0; i < questions.length; i++) {
        try {
          console.log(`🔄 Обробка питання ${i + 1}/${questions.length}...`);
          
          // Клікаємо на питання
          await questions[i].click();
          await new Promise(resolve => setTimeout(resolve, 1000)); // Чекаємо завантаження варіантів

          // Збираємо дані з поточного питання
          const questionData = await this.page.evaluate((questionIndex) => {
            const questionElement = document.querySelectorAll('.question')[questionIndex];
            if (!questionElement) return null;

            // Текст питання
            const questionText = questionElement.querySelector('.question__text')?.textContent?.trim() || '';
            
            // Варіанти відповідей
            const variants = questionElement.querySelectorAll('.question__variant');
            const options = {};
            let correctAnswer = '';

            variants.forEach((variant, index) => {
              const letter = variant.querySelector('.question__variant-letter')?.textContent?.trim();
              const text = variant.querySelector('.question__variant-text')?.textContent?.trim();
              const isCorrect = variant.classList.contains('question__variant--correct');
              
              if (letter && text) {
                options[letter.toLowerCase()] = text;
                if (isCorrect) {
                  correctAnswer = letter;
                }
              }
            });

            return {
              question_text: questionText,
              option_a: options.a || '',
              option_b: options.b || '',
              option_c: options.c || '',
              option_d: options.d || '',
              option_e: options.e || '',
              correct_answer: correctAnswer
            };
          }, i);

          if (questionData && questionData.question_text) {
            collectedQuestions.push(questionData);
            console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData).filter(key => key.startsWith('option_')).length} варіантів, правильна: ${questionData.correct_answer}`);
          } else {
            console.log(`❌ Питання ${i + 1}: не вдалося зібрати дані`);
          }

          // Показуємо прогрес кожні 10 питань
          if ((i + 1) % 10 === 0) {
            console.log(`📊 Прогрес: ${i + 1}/${questions.length} питань, зібрано: ${collectedQuestions.length}`);
          }

        } catch (error) {
          console.log(`❌ Помилка при обробці питання ${i + 1}: ${error.message}`);
        }
      }

      console.log(`✅ Індивідуальні кліки завершено. Зібрано ${collectedQuestions.length} питань`);

      // Збираємо метадані сторінки
      const pageInfo = await this.page.evaluate(() => ({
        title: document.title,
        url: window.location.href,
        year: new Date().getFullYear(),
        faculty: 'medical',
        test_type: 'krok1'
      }));

      const result = {
        ...pageInfo,
        totalQuestions: collectedQuestions.length,
        questions: collectedQuestions,
        collected_at: new Date().toISOString()
      };

      // Зберігаємо JSON
      const timestamp = Date.now();
      const jsonFilename = `data/krok-all-tests-${timestamp}.json`;
      fs.writeFileSync(jsonFilename, JSON.stringify(result, null, 2));
      console.log(`💾 Дані збережено в файл: ${path.resolve(jsonFilename)}`);

      // Генеруємо SQL для krok_questions_unified
      console.log('📝 Генерація SQL для krok_questions_unified...');
      const sqlFilename = `data/krok-questions-unified-${timestamp}.sql`;
      let sqlContent = `-- SQL для вставки питань в krok_questions_unified
-- Згенеровано автоматично

`;

      collectedQuestions.forEach(question => {
        const escapedQuestion = question.question_text.replace(/'/g, "''");
        const escapedA = (question.option_a || '').replace(/'/g, "''");
        const escapedB = (question.option_b || '').replace(/'/g, "''");
        const escapedC = (question.option_c || '').replace(/'/g, "''");
        const escapedD = (question.option_d || '').replace(/'/g, "''");
        const escapedE = (question.option_e || '').replace(/'/g, "''");

        sqlContent += `INSERT INTO krok_questions_unified (question_text, year, faculty, category, difficulty, is_active, option_a, option_b, option_c, option_d, option_e, correct_answer, created_at, updated_at) VALUES (
  '${escapedQuestion}',
  ${pageInfo.year},
  '${pageInfo.faculty}',
  'general',
  'medium',
  true,
  '${escapedA}',
  '${escapedB}',
  '${escapedC}',
  '${escapedD}',
  '${escapedE}',
  '${question.correct_answer}',
  NOW(),
  NOW()
);

`;
      });

      fs.writeFileSync(sqlFilename, sqlContent);
      console.log(`📄 SQL збережено в файл: ${path.resolve(sqlFilename)}`);

      console.log(`🎉 Успішно зібрано дані! JSON: ${path.resolve(jsonFilename)}`);
      console.log(`📄 SQL файл: ${path.resolve(sqlFilename)}`);

      // Статистика
      const withCorrectAnswers = collectedQuestions.filter(q => q.correct_answer).length;
      const withoutCorrectAnswers = collectedQuestions.length - withCorrectAnswers;

      console.log(`\n📊 Статистика:`);
      console.log(`- Всього питань: ${collectedQuestions.length}`);
      console.log(`- З правильними відповідями: ${withCorrectAnswers}`);
      console.log(`- Без правильних відповідей: ${withoutCorrectAnswers}`);

      // Показуємо приклади
      console.log(`\n📝 Приклади зібраних питань:`);
      collectedQuestions.slice(0, 3).forEach((q, index) => {
        console.log(`${index + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   A: ${q.option_a.substring(0, 50)}...`);
        console.log(`   B: ${q.option_b.substring(0, 50)}...`);
        console.log(`   C: ${q.option_c.substring(0, 50)}...`);
        console.log(`   D: ${q.option_d.substring(0, 50)}...`);
        console.log(`   E: ${q.option_e.substring(0, 50)}...`);
        console.log(`   Правильна: ${q.correct_answer}`);
      });

      return { jsonFilename, sqlFilename, questions: collectedQuestions };

    } catch (error) {
      console.error('❌ Помилка:', error);
      throw error;
    } finally {
      if (this.browser) {
        await this.browser.close();
        console.log('🔒 Браузер закрито');
      }
    }
  }
}

// Запуск скрипта
const baseUrl = process.argv[2] || 'https://krok-lead.com/';
const waitTime = parseInt(process.argv[3]) || 30;

const scraper = new KrokTestScraper();
scraper.scrapeAllTests(baseUrl, waitTime);
