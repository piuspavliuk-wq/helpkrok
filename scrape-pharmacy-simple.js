const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function scrapePharmacyTest(config) {
  console.log(`🚀 Запускаємо скрапер для ${config.title}...`);
  
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized']
  });
  
  const page = await browser.newPage();
  await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36');
  await page.goto(config.url, { waitUntil: 'networkidle2' });
  
  // Даємо час для завантаження
  await new Promise(resolve => setTimeout(resolve, 5000));
  
  const questions = [];
  let questionNumber = 1;
  let hasNextQuestion = true;

  while (hasNextQuestion) {
    try {
      console.log(`🔍 Скрапимо питання ${questionNumber}...`);
      
      // Чекаємо завантаження питання
      await new Promise(resolve => setTimeout(resolve, 3000));
      
      // Скрапимо текст питання
      const questionText = await page.evaluate(() => {
        const selectors = [
          '.question-text',
          '.question',
          '[class*="question"]',
          'p',
          'div[class*="text"]'
        ];
        
        for (const selector of selectors) {
          const element = document.querySelector(selector);
          if (element && element.textContent?.trim()) {
            return element.textContent.trim();
          }
        }
        return null;
      });

      if (!questionText) {
        console.log(`⚠️ Не знайдено текст питання ${questionNumber}`);
        break;
      }

      // Скрапимо варіанти відповідей
      const options = await page.evaluate(() => {
        const optionElements = document.querySelectorAll('[class*="option"], [class*="answer"], .choice, .variant');
        const options = [];
        
        optionElements.forEach((element, index) => {
          const text = element.textContent?.trim();
          if (text && text.length > 0) {
            const letter = String.fromCharCode(65 + index); // A, B, C, D, E
            options.push({
              letter: letter,
              text: text,
              is_correct: false
            });
          }
        });
        
        return options;
      });

      // Встановлюємо першу відповідь як правильну
      if (options.length > 0) {
        options[0].is_correct = true;
      }

      const question = {
        id: questionNumber,
        question_text: questionText,
        year: config.year,
        faculty: config.faculty,
        category: 'pharmacy',
        difficulty: 'medium',
        correct_answer: 'A',
        title: config.title,
        test_identifier: config.testIdentifier,
        options: options,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      questions.push(question);
      console.log(`✅ Питання ${questionNumber} збережено (${options.length} варіантів)`);

      // Шукаємо кнопку "Наступне"
      const nextButton = await page.$('button[class*="next"], .next, [class*="next"]');
      
      if (nextButton) {
        await nextButton.click();
        await new Promise(resolve => setTimeout(resolve, 2000));
        questionNumber++;
      } else {
        console.log(`🏁 Достигнуто кінець тесту (${questions.length} питань)`);
        hasNextQuestion = false;
      }

    } catch (error) {
      console.error(`❌ Помилка при скрапінгу питання ${questionNumber}:`, error);
      hasNextQuestion = false;
    }
  }

  // Зберігаємо дані
  if (questions.length > 0) {
    const timestamp = Date.now();
    const dataDir = path.join(__dirname, 'data');
    if (!fs.existsSync(dataDir)) {
      fs.mkdirSync(dataDir, { recursive: true });
    }

    const jsonFilename = `${config.year}-pharmacy-questions-${timestamp}.json`;
    const sqlFilename = `${config.year}-pharmacy-questions-${timestamp}.sql`;
    
    const jsonFilepath = path.join(dataDir, jsonFilename);
    const sqlFilepath = path.join(dataDir, sqlFilename);

    // Зберігаємо JSON
    fs.writeFileSync(jsonFilepath, JSON.stringify(questions, null, 2));
    console.log(`💾 JSON збережено: ${jsonFilepath}`);

    // Генеруємо SQL
    let sql = `-- SQL для імпорту питань фармації ${config.year}\n`;
    sql += `-- Кількість питань: ${questions.length}\n`;
    sql += `-- Назва тесту: ${config.title}\n\n`;

    questions.forEach((question) => {
      sql += `INSERT INTO krok_questions_unified_pharmacy (\n`;
      sql += `  question_text, year, faculty, category, difficulty,\n`;
      sql += `  option_a, option_b, option_c, option_d, option_e,\n`;
      sql += `  correct_answer, title, test_identifier, options,\n`;
      sql += `  created_at, updated_at\n`;
      sql += `) VALUES (\n`;
      sql += `  '${question.question_text.replace(/'/g, "''")}',\n`;
      sql += `  ${config.year},\n`;
      sql += `  '${config.faculty}',\n`;
      sql += `  '${question.category}',\n`;
      sql += `  '${question.difficulty}',\n`;
      sql += `  '${question.options[0]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[1]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[2]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[3]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.options[4]?.text?.replace(/'/g, "''") || ''}',\n`;
      sql += `  '${question.correct_answer}',\n`;
      sql += `  '${config.title.replace(/'/g, "''")}',\n`;
      sql += `  '${config.testIdentifier}',\n`;
      sql += `  '${JSON.stringify(question.options).replace(/'/g, "''")}',\n`;
      sql += `  '${question.created_at}',\n`;
      sql += `  '${question.updated_at}'\n`;
      sql += `);\n\n`;
    });

    fs.writeFileSync(sqlFilepath, sql);
    console.log(`📄 SQL збережено: ${sqlFilepath}`);
  }

  await browser.close();
  console.log(`🎉 Скрапінг завершено! Зібрано ${questions.length} питань`);
}

// Конфігурації
const configs = {
  '2012': { year: 2012, faculty: 'pharmacy', testIdentifier: '2012-pharmacy', title: '2012 рік', url: 'https://krok-lead.com' },
  '2013': { year: 2013, faculty: 'pharmacy', testIdentifier: '2013-pharmacy', title: '2013 рік', url: 'https://krok-lead.com' },
  '2014': { year: 2014, faculty: 'pharmacy', testIdentifier: '2014-pharmacy', title: '2014 рік', url: 'https://krok-lead.com' },
  '2015': { year: 2015, faculty: 'pharmacy', testIdentifier: '2015-pharmacy', title: '2015 рік', url: 'https://krok-lead.com' },
  '2016': { year: 2016, faculty: 'pharmacy', testIdentifier: '2016-pharmacy', title: '2016 рік', url: 'https://krok-lead.com' },
  '2017': { year: 2017, faculty: 'pharmacy', testIdentifier: '2017-pharmacy', title: '2017 рік', url: 'https://krok-lead.com' },
  '2018': { year: 2018, faculty: 'pharmacy', testIdentifier: '2018-pharmacy', title: '2018 рік', url: 'https://krok-lead.com' },
  '2019': { year: 2019, faculty: 'pharmacy', testIdentifier: '2019-pharmacy', title: '2019 рік', url: 'https://krok-lead.com' },
  '2020': { year: 2020, faculty: 'pharmacy', testIdentifier: '2020-pharmacy', title: '2020 рік', url: 'https://krok-lead.com' },
  '2021': { year: 2021, faculty: 'pharmacy', testIdentifier: '2021-pharmacy', title: '2021 рік', url: 'https://krok-lead.com' }
};

async function main() {
  const year = process.argv[2];
  
  if (!year || !configs[year]) {
    console.log('❌ Вкажіть рік: node scrape-pharmacy-simple.js 2012');
    console.log('Доступні роки:', Object.keys(configs).join(', '));
    return;
  }
  
  const config = configs[year];
  await scrapePharmacyTest(config);
}

if (require.main === module) {
  main().catch(console.error);
}

module.exports = { scrapePharmacyTest };
