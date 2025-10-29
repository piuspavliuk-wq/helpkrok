const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function manualScrape() {
  console.log('🚀 Запуск браузера для ручного збору...');
  
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
    args: ['--start-maximized']
  });

  try {
    const page = await browser.newPage();
    
    console.log('📖 Перехід на головну сторінку Krok Lead...');
    await page.goto('https://krok-lead.com/', { waitUntil: 'networkidle2', timeout: 30000 });
    console.log('✅ Головна сторінка завантажена');

    console.log('\n🔧 РУЧНИЙ КОНТРОЛЬ');
    console.log('📋 Інструкції:');
    console.log('1. Зайдіть в систему');
    console.log('2. Перейдіть до потрібного тесту (фармація)');
    console.log('3. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('4. Натисніть на неї');
    console.log('5. Виберіть "Показувати правильні відповіді"');
    console.log('6. Переконайтеся, що правильні відповіді відображаються (галочки ✓)');
    console.log('7. Натисніть ENTER в терміналі коли будете готові...\n');

    // Чекаємо на введення користувача
    await new Promise(resolve => {
      process.stdin.once('data', () => {
        resolve();
      });
    });

    console.log('🔍 Аналізуємо поточну сторінку...\n');

    // Отримуємо поточний URL
    const currentUrl = page.url();
    console.log(`📍 Поточний URL: ${currentUrl}`);

    // Зберігаємо HTML сторінки
    const html = await page.content();
    const timestamp = Date.now();
    const filename = `krok-lead-html-${timestamp}.html`;
    const filepath = path.join(__dirname, 'data', filename);
    
    // Створюємо папку data якщо не існує
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, html, 'utf8');
    console.log(`💾 HTML збережено в файл: ${filename}`);

    // Аналізуємо різні селектори
    const selectors = await page.evaluate(() => {
      const selectors = [
        '.question',
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

    console.log('🔍 Результати пошуку селекторів:');
    Object.entries(selectors).forEach(([selector, count]) => {
      console.log(`  ${selector}: ${count} елементів`);
    });

    // Знаходимо найкращий селектор
    const bestSelector = Object.entries(selectors).find(([selector, count]) => count > 0);
    
    if (bestSelector) {
      console.log(`\n✅ Найкращий селектор: ${bestSelector[0]} (${bestSelector[1]} елементів)`);
      
      // Аналізуємо структуру першого елемента
      const firstElement = await page.evaluate((selector) => {
        const element = document.querySelector(selector);
        if (!element) return null;
        
        return {
          tagName: element.tagName,
          className: element.className,
          id: element.id,
          innerHTML: element.innerHTML.substring(0, 1000) + '...',
          children: Array.from(element.children).map(child => ({
            tagName: child.tagName,
            className: child.className,
            textContent: child.textContent?.substring(0, 200) + '...'
          }))
        };
      }, bestSelector[0]);
      
      console.log('\n📋 Структура першого елемента:');
      console.log(JSON.stringify(firstElement, null, 2));
      
    } else {
      console.log('\n❌ Не знайдено жодного підходящого селектора');
      
      // Спробуємо знайти будь-які елементи з текстом
      const allElements = await page.evaluate(() => {
        const elements = document.querySelectorAll('*');
        const results = [];
        
        elements.forEach((element, index) => {
          if (index < 100) { // Обмежуємо кількість для швидкості
            const text = element.textContent?.trim();
            if (text && text.length > 20 && text.length < 500) {
              results.push({
                tagName: element.tagName,
                className: element.className,
                text: text.substring(0, 150) + '...'
              });
            }
          }
        });
        
        return results;
      });
      
      console.log('\n🔍 Знайдені елементи з текстом:');
      allElements.forEach((element, index) => {
        if (index < 20) { // Показуємо тільки перші 20
          console.log(`  ${element.tagName}.${element.className}: ${element.text}`);
        }
      });
    }

    // Перевіряємо чи є питання після прокрутки
    console.log('\n📜 Прокручуємо сторінку...');
    await page.evaluate(() => {
      window.scrollTo(0, document.body.scrollHeight);
    });
    
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    const afterScroll = await page.evaluate(() => {
      const selectors = [
        '.question',
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

    console.log('\n📊 Результати після прокрутки:');
    Object.entries(afterScroll).forEach(([selector, count]) => {
      console.log(`  ${selector}: ${count} елементів`);
    });

    console.log(`\n💾 HTML збережено в: ${filepath}`);
    console.log('🔍 Можете відкрити файл в браузері для аналізу структури');

  } catch (error) {
    console.error('❌ Помилка при діагностиці:', error);
  } finally {
    await browser.close();
  }
}

manualScrape();
