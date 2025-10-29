const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Конфігурація для 4 тестів з інтервалом 1 хвилина
const tests = [
  { year: 2007, title: '2007 рік 1', timer: 0 },
  { year: 2008, title: '2008 рік 2', timer: 1 },
  { year: 2009, title: '2009 рік 3', timer: 2 },
  { year: 2010, title: '2010 рік 4', timer: 3 }
];

async function scrapePharmacyTest(testConfig) {
  console.log(`🚀 Запускаємо скрапер для ${testConfig.title} через ${testConfig.timer} хвилин...`);
  
  // Чекаємо відповідний час
  if (testConfig.timer > 0) {
    console.log(`⏰ Чекаємо ${testConfig.timer} хвилин...`);
    await new Promise(resolve => setTimeout(resolve, testConfig.timer * 60 * 1000));
  }
  
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized']
  });
  
  try {
    const page = await browser.newPage();
    
    // Переходимо на сторінку тесту
    const testUrl = `https://krok-lead.com/test/pharmacy/${testConfig.year}`;
    console.log(`📊 Переходимо на: ${testUrl}`);
    
    await page.goto(testUrl, { waitUntil: 'networkidle2' });
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // Очікуємо завантаження питань
    await page.waitForSelector('.question-text, .question, [class*="question"]', { timeout: 10000 });
    
    const questions = [];
    let questionIndex = 0;
    
    console.log(`🔍 Починаємо скрапінг питань для ${testConfig.title}...`);
    
    while (true) {
      try {
        // Очікуємо завантаження питання
        await new Promise(resolve => setTimeout(resolve, 2000));
        
        // Отримуємо текст питання
        const questionText = await page.evaluate(() => {
          const questionSelectors = [
            '.question-text',
            '.question',
            '[class*="question"]',
            'h3',
            'h2',
            '.text-lg',
            '.font-semibold'
          ];
          
          for (const selector of questionSelectors) {
            const element = document.querySelector(selector);
            if (element && element.textContent.trim()) {
              return element.textContent.trim();
            }
          }
          return null;
        });
        
        if (!questionText) {
          console.log(`❌ Не знайдено текст питання ${questionIndex + 1}`);
          break;
        }
        
        // Отримуємо варіанти відповідей
        const options = await page.evaluate(() => {
          const optionSelectors = [
            'input[type="radio"] + label',
            '.option',
            '[class*="option"]',
            'label',
            '.answer-option'
          ];
          
          const options = {};
          const letters = ['A', 'B', 'C', 'D', 'E'];
          
          for (const selector of optionSelectors) {
            const elements = document.querySelectorAll(selector);
            if (elements.length >= 4) {
              elements.forEach((element, index) => {
                if (index < 5) {
                  const text = element.textContent.trim();
                  if (text) {
                    options[letters[index]] = text;
                  }
                }
              });
              break;
            }
          }
          
          return options;
        });
        
        // Отримуємо правильну відповідь
        const correctAnswer = await page.evaluate(() => {
          // Шукаємо позначену правильну відповідь
          const checkedInput = document.querySelector('input[type="radio"]:checked');
          if (checkedInput) {
            const label = document.querySelector(`label[for="${checkedInput.id}"]`);
            if (label) {
              const text = label.textContent.trim();
              if (text.startsWith('A')) return 'A';
              if (text.startsWith('B')) return 'B';
              if (text.startsWith('C')) return 'C';
              if (text.startsWith('D')) return 'D';
              if (text.startsWith('E')) return 'E';
            }
          }
          
          // Альтернативний спосіб - шукаємо по класах
          const correctElements = document.querySelectorAll('.correct, .right, .true, [class*="correct"]');
          for (const element of correctElements) {
            const text = element.textContent.trim();
            if (text.startsWith('A')) return 'A';
            if (text.startsWith('B')) return 'B';
            if (text.startsWith('C')) return 'C';
            if (text.startsWith('D')) return 'D';
            if (text.startsWith('E')) return 'E';
          }
          
          return 'A'; // Fallback
        });
        
        // Отримуємо зображення питання
        const questionImage = await page.evaluate(() => {
          const imgSelectors = [
            '.question img',
            '.question-image img',
            '[class*="question"] img',
            'img'
          ];
          
          for (const selector of imgSelectors) {
            const img = document.querySelector(selector);
            if (img && img.src && !img.src.includes('data:image/svg')) {
              return img.src;
            }
          }
          return null;
        });
        
        // Отримуємо зображення варіантів
        const optionImages = await page.evaluate(() => {
          const images = {};
          const letters = ['A', 'B', 'C', 'D', 'E'];
          
          const optionElements = document.querySelectorAll('.option, [class*="option"], label');
          optionElements.forEach((element, index) => {
            if (index < 5) {
              const img = element.querySelector('img');
              if (img && img.src && !img.src.includes('data:image/svg')) {
                images[letters[index]] = img.src;
              }
            }
          });
          
          return images;
        });
        
        const question = {
          id: questionIndex + 1,
          question_text: questionText,
          year: testConfig.year,
          faculty: 'pharmacy',
          test_identifier: `${testConfig.year}-pharmacy`,
          title: testConfig.title,
          category: 'general',
          difficulty: 'medium',
          option_a: options.A || '',
          option_b: options.B || '',
          option_c: options.C || '',
          option_d: options.D || '',
          option_e: options.E || '',
          correct_answer: correctAnswer,
          question_image: questionImage,
          option_a_image: optionImages.A || null,
          option_b_image: optionImages.B || null,
          option_c_image: optionImages.C || null,
          option_d_image: optionImages.D || null,
          option_e_image: optionImages.E || null,
          question_type: questionImage ? 'with_images' : 'text_only',
          explanation_text: null,
          reference_text: null,
          is_active: true
        };
        
        questions.push(question);
        console.log(`✅ Питання ${questionIndex + 1}: ${questionText.substring(0, 50)}...`);
        
        // Переходимо до наступного питання
        const nextButton = await page.$('button[class*="next"], .next, [class*="next"]');
        if (nextButton) {
          await nextButton.click();
          await new Promise(resolve => setTimeout(resolve, 2000));
        } else {
          // Спробуємо знайти кнопку по тексту
          const nextButtons = await page.$$('button');
          let found = false;
          for (const button of nextButtons) {
            const text = await button.evaluate(el => el.textContent);
            if (text.includes('Наступне') || text.includes('Next') || text.includes('→')) {
              await button.click();
              await new Promise(resolve => setTimeout(resolve, 2000));
              found = true;
              break;
            }
          }
          if (!found) {
            console.log(`❌ Не знайдено кнопку "Наступне" для питання ${questionIndex + 1}`);
            break;
          }
        }
        
        questionIndex++;
        
        // Обмеження на кількість питань
        if (questionIndex >= 200) {
          console.log(`⚠️ Досягнуто ліміт питань (200)`);
          break;
        }
        
      } catch (error) {
        console.error(`❌ Помилка при обробці питання ${questionIndex + 1}:`, error.message);
        break;
      }
    }
    
    console.log(`🎉 Скрапінг завершено! Зібрано ${questions.length} питань для ${testConfig.title}`);
    
    // Зберігаємо дані
    const timestamp = Date.now();
    const jsonFile = `data/${testConfig.year}-pharmacy-questions-${timestamp}.json`;
    const sqlFile = `data/${testConfig.year}-pharmacy-questions-${timestamp}.sql`;
    
    // Зберігаємо JSON
    fs.writeFileSync(jsonFile, JSON.stringify(questions, null, 2));
    console.log(`💾 JSON збережено: ${jsonFile}`);
    
    // Генеруємо SQL
    const sqlContent = generateSQL(questions, testConfig);
    fs.writeFileSync(sqlFile, sqlContent);
    console.log(`💾 SQL збережено: ${sqlFile}`);
    
    return { questions, jsonFile, sqlFile };
    
  } finally {
    await browser.close();
  }
}

function generateSQL(questions, testConfig) {
  let sql = `-- SQL для імпорту питань ${testConfig.title}\n`;
  sql += `-- Згенеровано: ${new Date().toISOString()}\n`;
  sql += `-- Кількість питань: ${questions.length}\n\n`;
  
  sql += `INSERT INTO krok_questions_unified_pharmacy (\n`;
  sql += `  year, faculty, test_identifier, title, category, difficulty,\n`;
  sql += `  question_text, option_a, option_b, option_c, option_d, option_e,\n`;
  sql += `  correct_answer, question_image, option_a_image, option_b_image,\n`;
  sql += `  option_c_image, option_d_image, option_e_image, question_type,\n`;
  sql += `  explanation_text, reference_text, is_active, created_at, updated_at\n`;
  sql += `) VALUES\n`;
  
  const values = questions.map(q => {
    const escapeSQL = (str) => {
      if (!str) return 'NULL';
      return `'${str.replace(/'/g, "''")}'`;
    };
    
    return `(
      ${q.year},
      '${q.faculty}',
      '${q.test_identifier}',
      '${q.title}',
      '${q.category}',
      '${q.difficulty}',
      ${escapeSQL(q.question_text)},
      ${escapeSQL(q.option_a)},
      ${escapeSQL(q.option_b)},
      ${escapeSQL(q.option_c)},
      ${escapeSQL(q.option_d)},
      ${escapeSQL(q.option_e)},
      '${q.correct_answer}',
      ${escapeSQL(q.question_image)},
      ${escapeSQL(q.option_a_image)},
      ${escapeSQL(q.option_b_image)},
      ${escapeSQL(q.option_c_image)},
      ${escapeSQL(q.option_d_image)},
      ${escapeSQL(q.option_e_image)},
      '${q.question_type}',
      ${escapeSQL(q.explanation_text)},
      ${escapeSQL(q.reference_text)},
      ${q.is_active},
      NOW(),
      NOW()
    )`;
  }).join(',\n');
  
  sql += values + ';\n\n';
  
  sql += `-- Перевірка кількості записів\n`;
  sql += `SELECT COUNT(*) as total_questions FROM krok_questions_unified_pharmacy WHERE year = ${testConfig.year} AND faculty = 'pharmacy';\n`;
  
  return sql;
}

async function runAllScrapers() {
  console.log('🚀 Запускаємо скрапери для 2007-2010 років...');
  console.log('⏰ Інтервал між скраперами: 1 хвилина');
  console.log('');
  
  const results = [];
  
  for (const test of tests) {
    try {
      const result = await scrapePharmacyTest(test);
      results.push(result);
      console.log(`✅ ${test.title} завершено: ${result.questions.length} питань`);
    } catch (error) {
      console.error(`❌ Помилка в ${test.title}:`, error.message);
    }
  }
  
  console.log('\n🎉 Всі скрапери завершено!');
  console.log('📊 Результати:');
  results.forEach(result => {
    console.log(`- ${result.questions.length} питань збережено`);
  });
}

// Запускаємо скрапери
runAllScrapers().catch(console.error);
