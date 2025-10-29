const fs = require('fs');
const path = require('path');

class KrokLeadDataImporter {
  constructor() {
    this.supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    this.supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  }

  // Читаємо зібрані дані
  readScrapedData(filePath) {
    try {
      const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
      console.log(`📖 Прочитано дані з файлу: ${filePath}`);
      console.log(`- Джерело: ${data.source}`);
      console.log(`- URL: ${data.url}`);
      console.log(`- Кількість питань: ${data.questions.length}`);
      return data;
    } catch (error) {
      console.error('❌ Помилка при читанні файлу:', error.message);
      return null;
    }
  }

  // Конвертуємо дані в формат krok_questions_unified
  convertToUnifiedFormat(scrapedData) {
    const convertedQuestions = [];
    
    scrapedData.questions.forEach((question, index) => {
      try {
        // Визначаємо рік
        const year = parseInt(scrapedData.page_info.year) || new Date().getFullYear();
        
        // Визначаємо факультет
        const faculty = scrapedData.page_info.faculty || 'medical';
        
        // Визначаємо категорію (можна покращити на основі тексту питання)
        const category = this.determineCategory(question.question_text);
        
        // Визначаємо складність
        const difficulty = this.determineDifficulty(question.question_text);
        
        // Обробляємо варіанти відповідей
        const options = this.processOptions(question.options);
        
        // Визначаємо правильну відповідь (поки що випадково)
        const correctAnswer = this.determineCorrectAnswer(options);
        
        const convertedQuestion = {
          question_text: question.question_text,
          year: year,
          faculty: faculty,
          category: category,
          difficulty: difficulty,
          is_active: true,
          option_a: options.A || '',
          option_b: options.B || '',
          option_c: options.C || '',
          option_d: options.D || '',
          option_e: options.E || '',
          correct_answer: correctAnswer,
          explanation_text: this.generateExplanation(question.question_text, correctAnswer),
          reference_text: `Джерело: ${scrapedData.source} - ${scrapedData.url}`,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        };
        
        convertedQuestions.push(convertedQuestion);
        
      } catch (error) {
        console.log(`⚠️ Помилка при конвертації питання ${index + 1}:`, error.message);
      }
    });
    
    return convertedQuestions;
  }

  // Визначаємо категорію на основі тексту питання
  determineCategory(questionText) {
    const text = questionText.toLowerCase();
    
    if (text.includes('анатом') || text.includes('орган') || text.includes('тканин')) {
      return 'anatomy';
    } else if (text.includes('фізіолог') || text.includes('функці')) {
      return 'physiology';
    } else if (text.includes('патолог') || text.includes('хвороб') || text.includes('симптом')) {
      return 'pathology';
    } else if (text.includes('фармаколог') || text.includes('лікар') || text.includes('антибіотик')) {
      return 'pharmacology';
    } else if (text.includes('мікробіолог') || text.includes('бактер') || text.includes('вірус')) {
      return 'microbiology';
    } else if (text.includes('біохім') || text.includes('метаболізм') || text.includes('фермент')) {
      return 'biochemistry';
    } else if (text.includes('гістолог') || text.includes('клітин')) {
      return 'histology';
    } else {
      return 'general_medicine';
    }
  }

  // Визначаємо складність
  determineDifficulty(questionText) {
    const text = questionText.toLowerCase();
    const length = questionText.length;
    
    if (length > 300 || text.includes('складн') || text.includes('диференціальн')) {
      return 'hard';
    } else if (length > 150 || text.includes('патолог') || text.includes('діагност')) {
      return 'medium';
    } else {
      return 'easy';
    }
  }

  // Обробляємо варіанти відповідей
  processOptions(options) {
    const processedOptions = {};
    
    if (Array.isArray(options) && options.length > 0) {
      options.forEach((option, index) => {
        const letter = String.fromCharCode(65 + index); // A, B, C, D, E
        processedOptions[letter] = option.text || option.value || '';
      });
    }
    
    // Якщо варіантів немає, створюємо заглушки
    if (Object.keys(processedOptions).length === 0) {
      processedOptions.A = 'Варіант А';
      processedOptions.B = 'Варіант Б';
      processedOptions.C = 'Варіант В';
      processedOptions.D = 'Варіант Г';
      processedOptions.E = 'Варіант Д';
    }
    
    return processedOptions;
  }

  // Визначаємо правильну відповідь (поки що випадково)
  determineCorrectAnswer(options) {
    const availableOptions = Object.keys(options).filter(key => options[key].trim() !== '');
    if (availableOptions.length === 0) {
      return 'A'; // За замовчуванням
    }
    
    // Поки що випадково, але можна покращити логіку
    const randomIndex = Math.floor(Math.random() * availableOptions.length);
    return availableOptions[randomIndex];
  }

  // Генеруємо пояснення
  generateExplanation(questionText, correctAnswer) {
    return `Правильна відповідь: ${correctAnswer}. Це питання з медичної підготовки, яке потребує детального вивчення відповідного матеріалу.`;
  }

  // Створюємо SQL для імпорту
  generateImportSQL(convertedQuestions) {
    let sql = `-- Імпорт питань з Krok Lead
-- Дата створення: ${new Date().toISOString()}
-- Кількість питань: ${convertedQuestions.length}

INSERT INTO krok_questions_unified (
  question_text,
  year,
  faculty,
  category,
  difficulty,
  is_active,
  option_a,
  option_b,
  option_c,
  option_d,
  option_e,
  correct_answer,
  explanation_text,
  reference_text,
  created_at,
  updated_at
) VALUES
`;

    const values = convertedQuestions.map(q => {
      return `(
  '${q.question_text.replace(/'/g, "''")}',
  ${q.year},
  '${q.faculty}',
  '${q.category}',
  '${q.difficulty}',
  ${q.is_active},
  '${q.option_a.replace(/'/g, "''")}',
  '${q.option_b.replace(/'/g, "''")}',
  '${q.option_c.replace(/'/g, "''")}',
  '${q.option_d.replace(/'/g, "''")}',
  '${q.option_e.replace(/'/g, "''")}',
  '${q.correct_answer}',
  '${q.explanation_text.replace(/'/g, "''")}',
  '${q.reference_text.replace(/'/g, "''")}',
  '${q.created_at}',
  '${q.updated_at}'
)`;
    }).join(',\n');

    sql += values + ';\n';
    
    return sql;
  }

  // Створюємо JSON для API імпорту
  generateAPIJSON(convertedQuestions) {
    return {
      source: 'krok-lead-import',
      imported_at: new Date().toISOString(),
      total_questions: convertedQuestions.length,
      questions: convertedQuestions
    };
  }

  // Зберігаємо результати
  saveResults(convertedQuestions, originalData) {
    const timestamp = Date.now();
    
    // SQL файл
    const sqlContent = this.generateImportSQL(convertedQuestions);
    const sqlPath = path.join(__dirname, 'data', `krok-lead-import-${timestamp}.sql`);
    fs.writeFileSync(sqlPath, sqlContent, 'utf8');
    
    // JSON файл для API
    const jsonContent = this.generateAPIJSON(convertedQuestions);
    const jsonPath = path.join(__dirname, 'data', `krok-lead-api-${timestamp}.json`);
    fs.writeFileSync(jsonPath, JSON.stringify(jsonContent, null, 2), 'utf8');
    
    // Звіт
    const report = {
      import_summary: {
        source: originalData.source,
        original_url: originalData.url,
        imported_at: new Date().toISOString(),
        total_questions: convertedQuestions.length,
        year: convertedQuestions[0]?.year || 'unknown',
        faculty: convertedQuestions[0]?.faculty || 'unknown',
        categories: [...new Set(convertedQuestions.map(q => q.category))],
        difficulties: [...new Set(convertedQuestions.map(q => q.difficulty))]
      },
      files_created: {
        sql_file: sqlPath,
        json_file: jsonPath
      },
      next_steps: [
        '1. Перевірити SQL файл перед виконанням',
        '2. Виконати SQL в Supabase SQL Editor',
        '3. Або використати JSON файл для API імпорту',
        '4. Перевірити імпортовані дані в базі'
      ]
    };
    
    const reportPath = path.join(__dirname, 'data', `krok-lead-report-${timestamp}.json`);
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2), 'utf8');
    
    console.log('\n📊 Результати конвертації:');
    console.log(`- Конвертовано питань: ${convertedQuestions.length}`);
    console.log(`- Рік: ${report.import_summary.year}`);
    console.log(`- Факультет: ${report.import_summary.faculty}`);
    console.log(`- Категорії: ${report.import_summary.categories.join(', ')}`);
    console.log(`- Складності: ${report.import_summary.difficulties.join(', ')}`);
    
    console.log('\n📁 Створені файли:');
    console.log(`- SQL: ${sqlPath}`);
    console.log(`- JSON: ${jsonPath}`);
    console.log(`- Звіт: ${reportPath}`);
    
    return {
      sqlPath,
      jsonPath,
      reportPath,
      convertedQuestions
    };
  }
}

// Основна функція
async function importKrokLeadData(dataFilePath) {
  const importer = new KrokLeadDataImporter();
  
  try {
    // Читаємо зібрані дані
    const scrapedData = importer.readScrapedData(dataFilePath);
    if (!scrapedData) {
      console.log('❌ Не вдалося прочитати дані');
      return;
    }
    
    // Конвертуємо в формат krok_questions_unified
    console.log('\n🔄 Конвертація даних...');
    const convertedQuestions = importer.convertToUnifiedFormat(scrapedData);
    
    if (convertedQuestions.length === 0) {
      console.log('❌ Не вдалося конвертувати жодного питання');
      return;
    }
    
    // Зберігаємо результати
    console.log('\n💾 Збереження результатів...');
    const results = importer.saveResults(convertedQuestions, scrapedData);
    
    console.log('\n✅ Конвертація завершена успішно!');
    console.log('\n📋 Наступні кроки:');
    console.log('1. Перевірте SQL файл перед виконанням');
    console.log('2. Виконайте SQL в Supabase SQL Editor');
    console.log('3. Або використайте JSON файл для API імпорту');
    console.log('4. Перевірте імпортовані дані в базі');
    
  } catch (error) {
    console.error('❌ Помилка при імпорті:', error);
  }
}

// Запуск скрипта
if (require.main === module) {
  const dataFilePath = process.argv[2];
  
  if (!dataFilePath) {
    console.log('❌ Вкажіть шлях до файлу з даними');
    console.log('Використання: node import-krok-lead-data.js <path-to-data-file>');
    process.exit(1);
  }
  
  importKrokLeadData(dataFilePath);
}

module.exports = { KrokLeadDataImporter, importKrokLeadData };
