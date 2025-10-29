const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

class KrokLeadAnalyzer {
  constructor() {
    this.browser = null;
    this.page = null;
  }

  async init() {
    console.log('🚀 Запуск браузера для аналізу...');
    this.browser = await puppeteer.launch({
      headless: false, // Показуємо браузер
      defaultViewport: null,
      args: ['--start-maximized']
    });
    
    this.page = await this.browser.newPage();
    await this.page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
  }

  async analyzePage(url) {
    console.log(`📖 Аналіз сторінки: ${url}`);
    
    try {
      await this.page.goto(url, { 
        waitUntil: 'domcontentloaded',
        timeout: 30000 
      });
      
      // Чекаємо завантаження
      await new Promise(resolve => setTimeout(resolve, 5000));
      
      // Зберігаємо скріншот сторінки
      await this.page.screenshot({ 
        path: path.join(__dirname, 'data', 'krok-lead-page.png'),
        fullPage: true 
      });
      
      // Аналізуємо структуру сторінки
      const analysis = await this.page.evaluate(() => {
        const result = {
          title: document.title,
          url: window.location.href,
          html: document.documentElement.outerHTML,
          bodyText: document.body.innerText,
          allElements: [],
          potentialQuestions: [],
          forms: [],
          scripts: [],
          stylesheets: []
        };
        
        // Збираємо всі елементи
        const allElements = document.querySelectorAll('*');
        allElements.forEach(el => {
          if (el.tagName && el.className && el.id) {
            result.allElements.push({
              tag: el.tagName,
              className: el.className,
              id: el.id,
              textContent: el.textContent?.substring(0, 100) || ''
            });
          }
        });
        
        // Шукаємо форми
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
          result.forms.push({
            action: form.action,
            method: form.method,
            innerHTML: form.innerHTML.substring(0, 500)
          });
        });
        
        // Шукаємо скрипти
        const scripts = document.querySelectorAll('script');
        scripts.forEach(script => {
          if (script.src) {
            result.scripts.push(script.src);
          } else if (script.textContent) {
            result.scripts.push('inline: ' + script.textContent.substring(0, 200));
          }
        });
        
        // Шукаємо стилі
        const stylesheets = document.querySelectorAll('link[rel="stylesheet"]');
        stylesheets.forEach(link => {
          result.stylesheets.push(link.href);
        });
        
        // Шукаємо потенційні питання
        const textContent = document.body.innerText;
        const questionMatches = textContent.match(/\d+\.\s*[^?]+\?/g);
        if (questionMatches) {
          result.potentialQuestions = questionMatches.slice(0, 10);
        }
        
        return result;
      });
      
      // Зберігаємо аналіз
      const filename = `krok-lead-analysis-${Date.now()}.json`;
      const filepath = path.join(__dirname, 'data', filename);
      
      if (!fs.existsSync(path.join(__dirname, 'data'))) {
        fs.mkdirSync(path.join(__dirname, 'data'));
      }
      
      fs.writeFileSync(filepath, JSON.stringify(analysis, null, 2), 'utf8');
      
      console.log('📊 Результати аналізу:');
      console.log(`- Заголовок: ${analysis.title}`);
      console.log(`- URL: ${analysis.url}`);
      console.log(`- Елементів на сторінці: ${analysis.allElements.length}`);
      console.log(`- Форм: ${analysis.forms.length}`);
      console.log(`- Скриптів: ${analysis.scripts.length}`);
      console.log(`- Стилів: ${analysis.stylesheets.length}`);
      console.log(`- Потенційних питань: ${analysis.potentialQuestions.length}`);
      
      if (analysis.potentialQuestions.length > 0) {
        console.log('\n📝 Приклади знайдених питань:');
        analysis.potentialQuestions.forEach((q, i) => {
          console.log(`${i + 1}. ${q.substring(0, 100)}...`);
        });
      }
      
      console.log(`\n💾 Повний аналіз збережено в: ${filepath}`);
      
      // Чекаємо, щоб користувач міг подивитися на сторінку
      console.log('\n⏳ Браузер залишається відкритим для ручного аналізу...');
      console.log('Натисніть Ctrl+C для закриття');
      
      // Чекаємо нескінченно
      await new Promise(() => {});
      
    } catch (error) {
      console.error('❌ Помилка при аналізі:', error);
    }
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      console.log('🔒 Браузер закрито');
    }
  }
}

// Основна функція
async function analyzeKrokLeadPage(url) {
  const analyzer = new KrokLeadAnalyzer();
  
  try {
    await analyzer.init();
    await analyzer.analyzePage(url);
  } catch (error) {
    console.error('❌ Помилка:', error);
  } finally {
    await analyzer.close();
  }
}

// Запуск скрипта
if (require.main === module) {
  const url = process.argv[2] || 'https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1';
  analyzeKrokLeadPage(url);
}

module.exports = { KrokLeadAnalyzer, analyzeKrokLeadPage };
