const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class MicrobiologyScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера для збору мікробіології...');
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
        
        // Прокручуємо до питання
        await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            questions[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        }, i);
        await this.waitFor(1000);

        // Клікаємо на питання та варіанти
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

        // Збираємо дані питання
        const questionData = await this.page.evaluate((index) => {
          const questions = document.querySelectorAll('.question');
          if (questions[index]) {
            const questionEl = questions[index];
            const cleanText = (text) => {
              if (!text) return '';
              return text.replace(/\s+/g, ' ').trim();
            };

            let questionText = '';
            const questionTextEl = questionEl.querySelector('.question__text');
            if (questionTextEl) {
              questionText = cleanText(questionTextEl.textContent);
            }

            const variantElements = questionEl.querySelectorAll('.question__variant');
            const options = {};
            let correctAnswer = '';

            variantElements.forEach((variantEl, variantIndex) => {
              const letter = String.fromCharCode(65 + variantIndex);
              const optionText = cleanText(variantEl.textContent);
              
              if (optionText && !optionText.includes('Варіант')) {
                options[letter] = optionText;
                
                if (variantEl.classList.contains('question__variant_right') ||
                    variantEl.querySelector('.icon-kl-check') ||
                    variantEl.querySelector('[class*="check"]')) {
                  correctAnswer = letter;
                }
              }
            });

            if (Object.keys(options).length > 0) {
              return {
                question_text: questionText,
                option_a: options.A || '',
                option_b: options.B || '',
                option_c: options.C || '',
                option_d: options.D || '',
                option_e: options.E || '',
                correct_answer: correctAnswer,
                question_number: index + 1,
                extracted_at: new Date().toISOString()
              };
            }
          }
          return null;
        }, i);

        if (questionData) {
          allQuestions.push(questionData);
          console.log(`✅ Питання ${i + 1}: зібрано ${Object.keys(questionData).filter(key => key.startsWith('option_')).length} варіантів, правильна: ${questionData.correct_answer || 'не визначено'}`);
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
      total_questions: questions.length
    };

    const filename = `krok-lead-microbiology-individual-clicks-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);

    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }

    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 Дані збережено в файл: ${filepath}`);
    return filepath;
  }

  generateSQL(questions) {
    console.log('📝 Генерація SQL для мікробіології...');
    
    let sql = '-- SQL для вставки питань з мікробіології\n';
    sql += '-- Згенеровано автоматично\n\n';
    
    questions.forEach((question, index) => {
      const questionText = question.question_text.replace(/'/g, "''");
      const optionA = (question.option_a || '').replace(/'/g, "''");
      const optionB = (question.option_b || '').replace(/'/g, "''");
      const optionC = (question.option_c || '').replace(/'/g, "''");
      const optionD = (question.option_d || '').replace(/'/g, "''");
      const optionE = (question.option_e || '').replace(/'/g, "''");
      const correctAnswer = question.correct_answer || null;

      sql += `INSERT INTO microbiology_questions (question_text, option_a, option_b, option_c, option_d, option_e, correct_answer, created_at) VALUES (\n`;
      sql += `  '${questionText}',\n`;
      sql += `  '${optionA}',\n`;
      sql += `  '${optionB}',\n`;
      sql += `  '${optionC}',\n`;
      sql += `  '${optionD}',\n`;
      sql += `  '${optionE}',\n`;
      sql += `  ${correctAnswer ? `'${correctAnswer}'` : 'NULL'},\n`;
      sql += `  NOW()\n`;
      sql += `);\n\n`;
    });

    const sqlFilename = `microbiology-questions-${Date.now()}.sql`;
    const sqlFilepath = path.join(__dirname, 'data', sqlFilename);
    fs.writeFileSync(sqlFilepath, sql, 'utf8');
    console.log(`📄 SQL збережено в файл: ${sqlFilepath}`);
    return sqlFilepath;
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

async function scrapeMicrobiology(url, timerSeconds = 30) {
  const scraper = new MicrobiologyScraper();
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
      const sqlFilepath = scraper.generateSQL(questions);
      console.log(`🎉 Успішно зібрано дані! JSON: ${filepath}`);
      console.log(`📄 SQL файл: ${sqlFilepath}`);
      
      const correctAnswersCount = questions.filter(q => q.correct_answer).length;
      console.log('\n📊 Статистика:');
      console.log(`- Всього питань: ${questions.length}`);
      console.log(`- З правильними відповідями: ${correctAnswersCount}`);
      console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);

      console.log('\n📝 Приклади зібраних питань:');
      questions.slice(0, 3).forEach((q, i) => {
        console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
        console.log(`   A: ${q.option_a?.substring(0, 50)}...`);
        console.log(`   B: ${q.option_b?.substring(0, 50)}...`);
        console.log(`   C: ${q.option_c?.substring(0, 50)}...`);
        console.log(`   D: ${q.option_d?.substring(0, 50)}...`);
        console.log(`   E: ${q.option_e?.substring(0, 50)}...`);
        console.log(`   Правильна: ${q.correct_answer || 'не визначено'}`);
      });
      
      return { jsonFile: filepath, sqlFile: sqlFilepath };
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
  const timerSeconds = parseInt(process.argv[3]) || 30;
  scrapeMicrobiology(url, timerSeconds);
}

module.exports = { MicrobiologyScraper, scrapeMicrobiology };
