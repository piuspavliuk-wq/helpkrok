const fs = require('fs');
const path = require('path');

// Функція для аналізу зображень
function analyzeImages(jsonFilePath) {
  console.log(`📖 Аналізуємо зображення в файлі: ${jsonFilePath}`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  console.log(`📊 Кількість питань: ${data.questions.length}`);
  
  let totalImages = 0;
  let validImages = 0;
  let invalidImages = 0;
  let largeImages = 0;
  
  for (let i = 0; i < data.questions.length; i++) {
    const question = data.questions[i];
    
    // Аналізуємо зображення питання
    if (question.question_image) {
      totalImages++;
      const imageLength = question.question_image.length;
      
      if (question.question_image.startsWith('data:image/')) {
        if (imageLength > 100000) { // > 100KB
          largeImages++;
          console.log(`⚠️ Велике зображення питання ${i + 1}: ${Math.round(imageLength / 1024)}KB`);
        } else {
          validImages++;
        }
      } else {
        invalidImages++;
        console.log(`❌ Невалідне зображення питання ${i + 1}: ${question.question_image.substring(0, 50)}...`);
      }
    }
    
    // Аналізуємо зображення варіантів
    if (question.option_images) {
      for (const [key, imageData] of Object.entries(question.option_images)) {
        if (imageData) {
          totalImages++;
          const imageLength = imageData.length;
          
          if (imageData.startsWith('data:image/')) {
            if (imageLength > 100000) { // > 100KB
              largeImages++;
              console.log(`⚠️ Велике зображення варіанта ${key} питання ${i + 1}: ${Math.round(imageLength / 1024)}KB`);
            } else {
              validImages++;
            }
          } else {
            invalidImages++;
            console.log(`❌ Невалідне зображення варіанта ${key} питання ${i + 1}: ${imageData.substring(0, 50)}...`);
          }
        }
      }
    }
  }
  
  console.log(`\n📊 СТАТИСТИКА ЗОБРАЖЕНЬ:`);
  console.log(`- Всього зображень: ${totalImages}`);
  console.log(`- Валідних: ${validImages}`);
  console.log(`- Невалідних: ${invalidImages}`);
  console.log(`- Великих (>100KB): ${largeImages}`);
  
  return {
    totalImages,
    validImages,
    invalidImages,
    largeImages
  };
}

// Функція для створення SQL з обмеженням розміру зображень
function createLimitedSQL(jsonFilePath, maxSizeKB = 50) {
  console.log(`\n📄 Створюємо SQL з обмеженням розміру зображень до ${maxSizeKB}KB...`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  let sql = `-- SQL для імпорту питань фармації ${data.title} (обмежені зображення)\n`;
  sql += `-- Кількість питань: ${data.questions.length}\n`;
  sql += `-- Назва тесту: ${data.title}\n`;
  sql += `-- Максимальний розмір зображення: ${maxSizeKB}KB\n\n`;

  data.questions.forEach((question, index) => {
    // Обмежуємо розмір зображення питання
    let questionImage = question.question_image;
    if (questionImage && questionImage.length > maxSizeKB * 1024) {
      questionImage = null; // Видаляємо великі зображення
    }
    
    // Обмежуємо розмір зображень варіантів
    let optionImages = question.option_images;
    if (optionImages) {
      const limitedOptionImages = {};
      for (const [key, imageData] of Object.entries(optionImages)) {
        if (imageData && imageData.length <= maxSizeKB * 1024) {
          limitedOptionImages[key] = imageData;
        }
      }
      optionImages = Object.keys(limitedOptionImages).length > 0 ? limitedOptionImages : null;
    }
    
    const questionImageSql = questionImage ? `'${questionImage.replace(/'/g, "''")}'` : 'NULL';
    const optionImagesSql = optionImages ? `'${JSON.stringify(optionImages).replace(/'/g, "''")}'` : 'NULL';
    
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
    sql += `  ${questionImageSql},\n`;
    sql += `  ${optionImagesSql},\n`;
    sql += `  '${JSON.stringify(question.options).replace(/'/g, "''")}',\n`;
    sql += `  '${question.extracted_at}',\n`;
    sql += `  '${question.extracted_at}'\n`;
    sql += `);\n\n`;
  });

  const sqlFilePath = jsonFilePath.replace('.json', `-limited-${maxSizeKB}kb.sql`);
  fs.writeFileSync(sqlFilePath, sql);
  
  console.log(`📄 SQL файл з обмеженими зображеннями: ${sqlFilePath}`);
  return sqlFilePath;
}

// Основна функція
function analyzeAndFix() {
  console.log('🔍 АНАЛІЗ ЗОБРАЖЕНЬ ТА СТВОРЕННЯ SQL...\n');
  
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
    // Аналізуємо зображення
    const stats = analyzeImages(jsonFilePath);
    
    // Створюємо SQL з обмеженням розміру
    const limitedSqlPath = createLimitedSQL(jsonFilePath, 50); // 50KB ліміт
    
    console.log('\n🎉 АНАЛІЗ ЗАВЕРШЕНО!');
    console.log(`📄 SQL файл з обмеженими зображеннями: ${limitedSqlPath}`);
    console.log('\n💡 Великі зображення видалено, малі залишено!');
    
  } catch (error) {
    console.error('❌ Помилка при аналізі:', error);
  }
}

if (require.main === module) {
  analyzeAndFix();
}

module.exports = { analyzeAndFix, analyzeImages, createLimitedSQL };


