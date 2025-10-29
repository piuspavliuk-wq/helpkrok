const fs = require('fs');
const path = require('path');

class KrokLeadAPIImporter {
  constructor() {
    this.apiUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    this.apiKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
    this.baseUrl = 'http://localhost:3000'; // Локальний сервер Next.js
  }

  // Читаємо JSON файл з конвертованими даними
  readConvertedData(jsonFilePath) {
    try {
      const data = JSON.parse(fs.readFileSync(jsonFilePath, 'utf8'));
      console.log(`📖 Прочитано конвертовані дані з файлу: ${jsonFilePath}`);
      console.log(`- Кількість питань: ${data.total_questions}`);
      return data;
    } catch (error) {
      console.error('❌ Помилка при читанні файлу:', error.message);
      return null;
    }
  }

  // Імпортуємо питання через API
  async importQuestions(questions) {
    const results = {
      successful: 0,
      failed: 0,
      errors: []
    };

    console.log(`🚀 Початок імпорту ${questions.length} питань через API...`);

    for (let i = 0; i < questions.length; i++) {
      const question = questions[i];
      
      try {
        console.log(`📝 Імпорт питання ${i + 1}/${questions.length}...`);
        
        const response = await fetch(`${this.baseUrl}/api/krok/unified`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(question)
        });

        if (response.ok) {
          const result = await response.json();
          console.log(`✅ Питання ${i + 1} успішно імпортовано (ID: ${result.question?.id})`);
          results.successful++;
        } else {
          const error = await response.text();
          console.log(`❌ Помилка при імпорті питання ${i + 1}: ${error}`);
          results.failed++;
          results.errors.push({
            question_index: i + 1,
            question_text: question.question_text.substring(0, 100) + '...',
            error: error
          });
        }

        // Невелика затримка між запитами
        await new Promise(resolve => setTimeout(resolve, 100));

      } catch (error) {
        console.log(`❌ Помилка при імпорті питання ${i + 1}: ${error.message}`);
        results.failed++;
        results.errors.push({
          question_index: i + 1,
          question_text: question.question_text.substring(0, 100) + '...',
          error: error.message
        });
      }
    }

    return results;
  }

  // Перевіряємо підключення до API
  async checkConnection() {
    try {
      console.log('🔍 Перевірка підключення до API...');
      
      const response = await fetch(`${this.baseUrl}/api/krok/unified?limit=1`);
      
      if (response.ok) {
        const data = await response.json();
        console.log('✅ Підключення до API успішне');
        console.log(`- Знайдено ${data.total} питань в базі`);
        return true;
      } else {
        console.log('❌ Помилка підключення до API:', response.status);
        return false;
      }
    } catch (error) {
      console.log('❌ Помилка підключення до API:', error.message);
      return false;
    }
  }

  // Зберігаємо звіт про імпорт
  saveImportReport(results, totalQuestions) {
    const report = {
      import_summary: {
        imported_at: new Date().toISOString(),
        total_questions: totalQuestions,
        successful_imports: results.successful,
        failed_imports: results.failed,
        success_rate: `${((results.successful / totalQuestions) * 100).toFixed(2)}%`
      },
      errors: results.errors,
      next_steps: [
        '1. Перевірити імпортовані дані в базі',
        '2. Протестувати питання на сайті',
        '3. Виправити помилки, якщо є',
        '4. Додати правильні відповіді та пояснення'
      ]
    };

    const timestamp = Date.now();
    const reportPath = path.join(__dirname, 'data', `api-import-report-${timestamp}.json`);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2), 'utf8');
    
    console.log('\n📊 Звіт про імпорт:');
    console.log(`- Всього питань: ${totalQuestions}`);
    console.log(`- Успішно імпортовано: ${results.successful}`);
    console.log(`- Помилок: ${results.failed}`);
    console.log(`- Відсоток успіху: ${report.import_summary.success_rate}`);
    
    if (results.errors.length > 0) {
      console.log('\n❌ Помилки:');
      results.errors.forEach(error => {
        console.log(`- Питання ${error.question_index}: ${error.error}`);
      });
    }
    
    console.log(`\n💾 Звіт збережено в: ${reportPath}`);
    
    return reportPath;
  }
}

// Основна функція
async function importViaAPI(jsonFilePath) {
  const importer = new KrokLeadAPIImporter();
  
  try {
    // Читаємо конвертовані дані
    const data = importer.readConvertedData(jsonFilePath);
    if (!data) {
      console.log('❌ Не вдалося прочитати дані');
      return;
    }

    // Перевіряємо підключення до API
    const isConnected = await importer.checkConnection();
    if (!isConnected) {
      console.log('❌ Не вдалося підключитися до API');
      console.log('💡 Переконайтеся, що сервер Next.js запущено (npm run dev)');
      return;
    }

    // Імпортуємо питання
    const results = await importer.importQuestions(data.questions);
    
    // Зберігаємо звіт
    const reportPath = importer.saveImportReport(results, data.total_questions);
    
    console.log('\n✅ Імпорт завершено!');
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте імпортовані дані в базі');
    console.log('2. Протестуйте питання на сайті');
    console.log('3. Виправте помилки, якщо є');
    console.log('4. Додайте правильні відповіді та пояснення');
    
  } catch (error) {
    console.error('❌ Помилка при імпорті через API:', error);
  }
}

// Запуск скрипта
if (require.main === module) {
  const jsonFilePath = process.argv[2];
  
  if (!jsonFilePath) {
    console.log('❌ Вкажіть шлях до JSON файлу з конвертованими даними');
    console.log('Використання: node import-via-api.js <path-to-json-file>');
    console.log('\n💡 Приклад:');
    console.log('node import-via-api.js data/krok-lead-api-1759500411229.json');
    process.exit(1);
  }
  
  importViaAPI(jsonFilePath);
}

module.exports = { KrokLeadAPIImporter, importViaAPI };
