const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function scrapeTest() {
  const browser = await puppeteer.launch({ 
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized']
  });

  const page = await browser.newPage();
  
  console.log('🚀 Запускаємо скрапер для 2024р 2д...');
  console.log('📖 Перехід на сторінку: https://krok-lead.com');
  
  await page.goto('https://krok-lead.com', { waitUntil: 'networkidle2' });
  
  console.log('⏰ ТАЙМЕР 30 СЕКУНД ДЛЯ РУЧНОГО НАЛАШТУВАННЯ');
  console.log('📋 Швидкі інструкції:');
  console.log('1. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
  console.log('2. Натисніть на неї');
  console.log('3. Увімкніть "Показувати правильні відповіді"');
  console.log('4. Виберіть тест "2024р 2д"');
  console.log('5. Дочекайтеся завершення таймера...');
  
  // Таймер 30 секунд
  for (let i = 30; i > 0; i--) {
    process.stdout.write(`\r⏰ Залишилось: ${i} секунд`);
    await new Promise(resolve => setTimeout(resolve, 1000));
  }
  
  console.log('\n✅ Таймер завершено! Починаємо скрапінг...');
  
  try {
    // Очікуємо завантаження питань
    await page.waitForSelector('.question', { timeout: 10000 });
    
    const questions = await page.evaluate(() => {
      const questionElements = document.querySelectorAll('.question');
      const results = [];
      
      questionElements.forEach((questionEl, index) => {
        try {
          const questionText = questionEl.querySelector('.question-text')?.textContent?.trim() || '';
          const questionImage = questionEl.querySelector('.question-image img')?.src || '';
          
          const options = [];
          const optionImages = [];
          
          const optionElements = questionEl.querySelectorAll('.option');
          optionElements.forEach(optionEl => {
            const optionText = optionEl.querySelector('.option-text')?.textContent?.trim() || '';
            const optionImage = optionEl.querySelector('.option-image img')?.src || '';
            
            options.push(optionText);
            optionImages.push(optionImage);
          });
          
          // Знаходимо правильну відповідь через single click
          const correctAnswerElement = questionEl.querySelector('.option.correct, .option.selected');
          const correctAnswer = correctAnswerElement?.textContent?.trim() || '';
          
          results.push({
            question_number: index + 1,
            question_text: questionText,
            question_image: questionImage,
            options: options,
            option_images: optionImages,
            correct_answer: correctAnswer
          });
        } catch (error) {
          console.error(`Помилка при обробці питання ${index + 1}:`, error);
        }
      });
      
      return results;
    });
    
    console.log(`✅ Знайдено ${questions.length} питань`);
    
    // Зберігаємо JSON
    const timestamp = Date.now();
    const jsonFilename = `2024-pharmacy-2d-questions-${timestamp}.json`;
    const jsonFilepath = path.join(__dirname, 'data', jsonFilename);
    
    const testData = {
      test_identifier: '2024-pharmacy-2d',
      title: '2024р 2д',
      year: 2024,
      faculty: 'pharmacy',
      questions: questions,
      scraped_at: new Date().toISOString()
    };
    
    fs.writeFileSync(jsonFilepath, JSON.stringify(testData, null, 2));
    console.log(`💾 JSON збережено: ${jsonFilename}`);
    
    // Генеруємо SQL
    await generateSQL(questions, jsonFilepath);
    
  } catch (error) {
    console.error('❌ Помилка при скрапінгу:', error);
  }
  
  await browser.close();
  console.log('✅ Скрапінг завершено!');
}

async function generateSQL(questions, jsonFilepath) {
  const sqlFilename = path.basename(jsonFilepath).replace('.json', '.sql');
  const sqlFilepath = path.join(__dirname, 'data', sqlFilename);
  
  let sql = `-- SQL для тесту 2024р 2д
-- Згенеровано: ${new Date().toISOString()}

INSERT INTO krok_questions_unified_pharmacy (
  question_number,
  question_text,
  question_image,
  options,
  option_images,
  correct_answer,
  year,
  faculty,
  test_identifier,
  title,
  is_active
) VALUES
`;

  questions.forEach((question, index) => {
    const questionImage = question.question_image ? `'${question.question_image.replace(/'/g, "''")}'` : 'NULL';
    const options = JSON.stringify(question.options);
    const optionImages = JSON.stringify(question.option_images);
    const correctAnswer = question.correct_answer.replace(/'/g, "''");
    
    sql += `  (${question.question_number}, '${question.question_text.replace(/'/g, "''")}', ${questionImage}, '${options}', '${optionImages}', '${correctAnswer}', 2024, 'pharmacy', '2024-pharmacy-2d', '2024р 2д', true)`;
    
    if (index < questions.length - 1) {
      sql += ',\n';
    } else {
      sql += ';\n';
    }
  });
  
  fs.writeFileSync(sqlFilepath, sql);
  console.log(`💾 SQL збережено: ${sqlFilename}`);
}

// Запускаємо скрапер
scrapeTest().catch(console.error);
