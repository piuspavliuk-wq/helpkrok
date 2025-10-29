const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class PausedKrokLeadScraper {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера з паузою для ручного налаштування...');
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
    
    // Налаштування User-Agent
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
    
    // Налаштування таймаутів
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
      
      // Чекаємо завантаження
      await this.waitFor(3000);
      
      console.log('✅ Сторінка завантажена');
      
    } catch (error) {
      console.log('⚠️ Помилка при завантаженні сторінки:', error.message);
      throw error;
    }
  }

  async waitFor(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async waitForUserAction() {
    console.log('\n⏸️  ПАУЗА ДЛЯ РУЧНОГО НАЛАШТУВАННЯ');
    console.log('📋 Інструкції:');
    console.log('1. Знайдіть кнопку "три крапки" (⋮) в правому верхньому куті');
    console.log('2. Натисніть на неї');
    console.log('3. Виберіть "Показувати правильні відповіді" або "Show correct answers"');
    console.log('4. Переконайтеся, що правильні відповіді відображаються (мають бути галочки ✓)');
    console.log('5. Натисніть Enter в терміналі, коли будете готові продовжити...\n');
    
    // Чекаємо вводу користувача
    await new Promise(resolve => {
      process.stdin.once('data', () => {
        console.log('✅ Продовжуємо збір даних...\n');
        resolve();
      });
    });
  }

  async scrollToLoadAllQuestions() {
    console.log('📜 Прокручуємо сторінку для завантаження всіх питань...');
    
    let previousHeight = 0;
    let currentHeight = await this.page.evaluate('document.body.scrollHeight');
    let scrollAttempts = 0;
    const maxScrollAttempts = 15;
    
    while (previousHeight !== currentHeight && scrollAttempts < maxScrollAttempts) {
      previousHeight = currentHeight;
      
      // Прокручуємо до кінця сторінки
      await this.page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
      
      // Чекаємо завантаження нових елементів
      await this.waitFor(3000);
      
      currentHeight = await this.page.evaluate('document.body.scrollHeight');
      scrollAttempts++;
      
      console.log(`📜 Прокрутка ${scrollAttempts}/${maxScrollAttempts}, висота: ${currentHeight}px`);
      
      // Перевіряємо кількість питань
      const questionsCount = await this.page.evaluate(() => {
        return document.querySelectorAll('.question').length;
      });
      console.log(`📊 Поточна кількість питань: ${questionsCount}`);
    }
    
    // Повертаємося на початок
    await this.page.evaluate('window.scrollTo(0, 0)');
    await this.waitFor(2000);
  }

  async getPageHTML() {
    console.log('📄 Отримуємо HTML код сторінки...');
    
    try {
      const html = await this.page.content();
      console.log(`✅ Отримано HTML код (${html.length} символів)`);
      return html;
    } catch (error) {
      console.log('❌ Помилка при отриманні HTML:', error.message);
      return null;
    }
  }

  async saveHTML(html, pageInfo) {
    const data = {
      source: 'krok-lead.com',
      url: pageInfo.url,
      extracted_at: new Date().toISOString(),
      page_info: pageInfo,
      html_content: html,
      html_length: html ? html.length : 0
    };

    const filename = `krok-lead-html-manual-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 HTML збережено в файл: ${filepath}`);
    
    return filepath;
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

// Основна функція
async function scrapeWithPause(url) {
  const scraper = new PausedKrokLeadScraper();
  
  try {
    await scraper.init();
    await scraper.navigateToTest(url);
    
    // Пауза для ручного налаштування
    await scraper.waitForUserAction();
    
    // Прокручуємо сторінку для завантаження всіх питань
    await scraper.scrollToLoadAllQuestions();
    
    const pageInfo = await scraper.page.evaluate(() => {
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
    
    console.log('📄 Інформація про сторінку:', pageInfo);
    
    const html = await scraper.getPageHTML();
    
    if (html) {
      const filepath = await scraper.saveHTML(html, pageInfo);
      console.log(`🎉 Успішно зібрано HTML! Файл: ${filepath}`);
      
      // Показуємо статистику
      console.log('\n📊 Статистика:');
      console.log(`- Всього питань: ${pageInfo.totalQuestions}`);
      console.log(`- Розмір HTML: ${html.length} символів`);
      
      return filepath;
    } else {
      console.log('❌ Не вдалося отримати HTML код');
      return null;
    }
    
  } catch (error) {
    console.error('❌ Помилка при зборі HTML:', error);
    return null;
  } finally {
    await scraper.close();
  }
}

// Запуск скрипта
if (require.main === module) {
  const url = process.argv[2] || 'https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1';
  scrapeWithPause(url);
}

module.exports = { PausedKrokLeadScraper, scrapeWithPause };
