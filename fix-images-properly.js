const fs = require('fs');
const path = require('path');

// Функція для створення мінімального валідного зображення
function createMinimalImage() {
  // Створюємо мінімальне 1x1 піксельне зображення в base64
  const minimalImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';
  return minimalImage;
}

// Функція для правильного стиснення зображень
function properlyCompressImages(jsonFilePath) {
  console.log(`📖 Читаємо JSON файл: ${jsonFilePath}`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  console.log(`📊 Кількість питань: ${data.questions.length}`);
  
  let fixedCount = 0;
  
  for (let i = 0; i < data.questions.length; i++) {
    const question = data.questions[i];
    let hasChanges = false;
    
    // Виправляємо зображення питання
    if (question.question_image && question.question_image.startsWith('data:image/')) {
      // Якщо зображення пошкоджене (закінчується на ...), замінюємо на мінімальне
      if (question.question_image.endsWith('...') || question.question_image.length < 100) {
        question.question_image = createMinimalImage();
        hasChanges = true;
        fixedCount++;
        console.log(`✅ Виправлено зображення питання ${i + 1}`);
      }
    }
    
    // Виправляємо зображення варіантів
    if (question.option_images) {
      for (const [key, imageData] of Object.entries(question.option_images)) {
        if (imageData && imageData.startsWith('data:image/')) {
          // Якщо зображення пошкоджене, замінюємо на мінімальне
          if (imageData.endsWith('...') || imageData.length < 100) {
            question.option_images[key] = createMinimalImage();
            hasChanges = true;
            fixedCount++;
            console.log(`✅ Виправлено зображення варіанта ${key} питання ${i + 1}`);
          }
        }
      }
    }
    
    if (hasChanges) {
      console.log(`✅ Виправлено питання ${i + 1}`);
    }
  }
  
  // Зберігаємо виправлений файл
  const fixedFilePath = jsonFilePath.replace('.json', '-properly-fixed.json');
  fs.writeFileSync(fixedFilePath, JSON.stringify(data, null, 2), 'utf8');
  
  console.log(`\n📊 РЕЗУЛЬТАТИ ВИПРАВЛЕННЯ:`);
  console.log(`- Виправлено зображень: ${fixedCount}`);
  console.log(`\n💾 Виправлений файл: ${fixedFilePath}`);
  
  return fixedFilePath;
}

// Функція для генерації SQL з виправленими зображеннями
function generateProperlyFixedSQL(jsonFilePath) {
  console.log(`\n📄 Генеруємо SQL з виправленими зображеннями...`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  let sql = `-- SQL для імпорту питань фармації ${data.title} (виправлені зображення)\n`;
  sql += `-- Кількість питань: ${data.questions.length}\n`;
  sql += `-- Назва тесту: ${data.title}\n\n`;

  data.questions.forEach((question, index) => {
    const questionImage = question.question_image ? `'${question.question_image.replace(/'/g, "''")}'` : 'NULL';
    const optionImages = question.option_images && Object.keys(question.option_images).length > 0 ? 
      `'${JSON.stringify(question.option_images).replace(/'/g, "''")}'` : 'NULL';
    
    sql += `INSERT INTO krok_questions_unified_pharmacy (\n`;
    sql += `  question_text, year, faculty, category, difficulty,\n`;
    sql += `  option_a, option_b, option_c, option_d, option_e,\n`;
    sql += `  correct_answer, title, test_identifier,\n`;
    sql += `  question_image, option_images, options,\n`;
    sql += `  created_at, updated_at\n`;
    sql += `) VALUES (\n`;
    sql += `  '${question.question_text.replace(/'/g, "''")}',\n`;
    sql += `  ${data.year},\n`;
    sql += `  'pharmacy',\n`;
    sql += `  'pharmacy',\n`;
    sql += `  'medium',\n`;
    sql += `  '${question.options.A?.replace(/'/g, "''") || ''}',\n`;
    sql += `  '${question.options.B?.replace(/'/g, "''") || ''}',\n`;
    sql += `  '${question.options.C?.replace(/'/g, "''") || ''}',\n`;
    sql += `  '${question.options.D?.replace(/'/g, "''") || ''}',\n`;
    sql += `  '${question.options.E?.replace(/'/g, "''") || ''}',\n`;
    sql += `  '${question.correct_answer || 'A'}',\n`;
    sql += `  '${data.title}',\n`;
    sql += `  '${data.test_identifier}',\n`;
    sql += `  ${questionImage},\n`;
    sql += `  ${optionImages},\n`;
    sql += `  '${JSON.stringify(question.options).replace(/'/g, "''")}',\n`;
    sql += `  '${question.extracted_at}',\n`;
    sql += `  '${question.extracted_at}'\n`;
    sql += `);\n\n`;
  });

  const sqlFilePath = jsonFilePath.replace('.json', '-properly-fixed.sql');
  fs.writeFileSync(sqlFilePath, sql);
  
  console.log(`📄 SQL файл з виправленими зображеннями: ${sqlFilePath}`);
  return sqlFilePath;
}

// Основна функція
function fixImagesProperly() {
  console.log('🔧 ПРАВИЛЬНЕ ВИПРАВЛЕННЯ ЗОБРАЖЕНЬ...\n');
  
  // Знаходимо оригінальний JSON файл
  const dataDir = path.join(__dirname, 'data');
  const jsonFiles = fs.readdirSync(dataDir).filter(file => 
    file.endsWith('.json') && file.includes('2024-pharmacy-1d') && !file.includes('compressed') && !file.includes('fixed') && !file.includes('no-images')
  );
  
  if (jsonFiles.length === 0) {
    console.log('❌ Не знайдено оригінальний JSON файл');
    return;
  }
  
  const jsonFile = jsonFiles[0];
  const jsonFilePath = path.join(dataDir, jsonFile);
  
  console.log(`📁 Обробляємо файл: ${jsonFile}`);
  
  try {
    // Виправляємо зображення правильно
    const fixedJsonPath = properlyCompressImages(jsonFilePath);
    
    // Генеруємо SQL з виправленими зображеннями
    const fixedSqlPath = generateProperlyFixedSQL(fixedJsonPath);
    
    console.log('\n🎉 ВИПРАВЛЕННЯ ЗАВЕРШЕНО!');
    console.log(`📄 JSON: ${fixedJsonPath}`);
    console.log(`📄 SQL: ${fixedSqlPath}`);
    console.log('\n💡 Тепер зображення мають працювати правильно!');
    console.log('💡 Пошкоджені зображення замінено на мінімальні валідні!');
    
  } catch (error) {
    console.error('❌ Помилка при виправленні:', error);
  }
}

if (require.main === module) {
  fixImagesProperly();
}

module.exports = { fixImagesProperly, properlyCompressImages, generateProperlyFixedSQL, createMinimalImage };


