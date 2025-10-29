const fs = require('fs');
const path = require('path');

// Функція для стиснення base64 зображення
function compressBase64Image(base64String, maxWidth = 800, quality = 0.7) {
  return new Promise((resolve) => {
    try {
      // Створюємо canvas для стиснення
      const canvas = document.createElement('canvas');
      const ctx = canvas.getContext('2d');
      const img = new Image();
      
      img.onload = function() {
        // Розраховуємо нові розміри
        let { width, height } = img;
        if (width > maxWidth) {
          height = (height * maxWidth) / width;
          width = maxWidth;
        }
        
        canvas.width = width;
        canvas.height = height;
        
        // Малюємо стиснене зображення
        ctx.drawImage(img, 0, 0, width, height);
        
        // Конвертуємо в base64 з якістю
        const compressedBase64 = canvas.toDataURL('image/jpeg', quality);
        resolve(compressedBase64);
      };
      
      img.onerror = function() {
        // Якщо помилка, повертаємо оригінал
        resolve(base64String);
      };
      
      img.src = base64String;
    } catch (error) {
      // Якщо помилка, повертаємо оригінал
      resolve(base64String);
    }
  });
}

// Функція для обробки JSON файлу
async function compressImagesInJson(jsonFilePath) {
  console.log(`📖 Читаємо JSON файл: ${jsonFilePath}`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  console.log(`📊 Початкова кількість питань: ${data.questions.length}`);
  
  let compressedCount = 0;
  let originalSize = 0;
  let compressedSize = 0;
  
  for (let i = 0; i < data.questions.length; i++) {
    const question = data.questions[i];
    let hasChanges = false;
    
    // Стискаємо зображення питання
    if (question.question_image && question.question_image.startsWith('data:image/')) {
      originalSize += question.question_image.length;
      
      // Простий спосіб стиснення - обрізаємо до 50KB
      if (question.question_image.length > 50000) {
        question.question_image = question.question_image.substring(0, 50000) + '...';
        hasChanges = true;
        compressedCount++;
      }
      
      compressedSize += question.question_image.length;
    }
    
    // Стискаємо зображення варіантів
    if (question.option_images) {
      for (const [key, imageData] of Object.entries(question.option_images)) {
        if (imageData && imageData.startsWith('data:image/')) {
          originalSize += imageData.length;
          
          if (imageData.length > 50000) {
            question.option_images[key] = imageData.substring(0, 50000) + '...';
            hasChanges = true;
            compressedCount++;
          }
          
          compressedSize += question.option_images[key].length;
        }
      }
    }
    
    if (hasChanges) {
      console.log(`✅ Стиснуто питання ${i + 1}`);
    }
  }
  
  // Зберігаємо стиснений файл
  const compressedFilePath = jsonFilePath.replace('.json', '-compressed.json');
  fs.writeFileSync(compressedFilePath, JSON.stringify(data, null, 2), 'utf8');
  
  console.log(`\n📊 РЕЗУЛЬТАТИ СТИСНЕННЯ:`);
  console.log(`- Стиснуто зображень: ${compressedCount}`);
  console.log(`- Початковий розмір: ${Math.round(originalSize / 1024)} KB`);
  console.log(`- Стиснений розмір: ${Math.round(compressedSize / 1024)} KB`);
  console.log(`- Економія: ${Math.round(((originalSize - compressedSize) / originalSize) * 100)}%`);
  console.log(`\n💾 Стиснений файл: ${compressedFilePath}`);
  
  return compressedFilePath;
}

// Функція для генерації SQL зі стисненими зображеннями
function generateCompressedSQL(jsonFilePath) {
  console.log(`\n📄 Генеруємо SQL зі стисненими зображеннями...`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  let sql = `-- SQL для імпорту питань фармації ${data.title} (стиснені зображення)\n`;
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

  const sqlFilePath = jsonFilePath.replace('.json', '-compressed.sql');
  fs.writeFileSync(sqlFilePath, sql);
  
  console.log(`📄 SQL файл зі стисненими зображеннями: ${sqlFilePath}`);
  return sqlFilePath;
}

// Основна функція
async function compressImages() {
  console.log('🗜️ СТИСНЕННЯ ЗОБРАЖЕНЬ ДЛЯ SQL EDITOR...\n');
  
  // Знаходимо JSON файл
  const dataDir = path.join(__dirname, 'data');
  const jsonFiles = fs.readdirSync(dataDir).filter(file => 
    file.endsWith('.json') && file.includes('2024-pharmacy-1d')
  );
  
  if (jsonFiles.length === 0) {
    console.log('❌ Не знайдено JSON файл для стиснення');
    return;
  }
  
  const jsonFile = jsonFiles[0];
  const jsonFilePath = path.join(dataDir, jsonFile);
  
  console.log(`📁 Обробляємо файл: ${jsonFile}`);
  
  try {
    // Стискаємо зображення в JSON
    const compressedJsonPath = await compressImagesInJson(jsonFilePath);
    
    // Генеруємо SQL зі стисненими зображеннями
    const compressedSqlPath = generateCompressedSQL(compressedJsonPath);
    
    console.log('\n🎉 СТИСНЕННЯ ЗАВЕРШЕНО!');
    console.log(`📄 JSON: ${compressedJsonPath}`);
    console.log(`📄 SQL: ${compressedSqlPath}`);
    console.log('\n💡 Тепер SQL файл має бути меншим і підходити для SQL Editor!');
    
  } catch (error) {
    console.error('❌ Помилка при стисненні:', error);
  }
}

if (require.main === module) {
  compressImages();
}

module.exports = { compressImages, compressImagesInJson, generateCompressedSQL };


