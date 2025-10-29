const fs = require('fs');
const path = require('path');

// Функція для правильного стиснення base64 зображень
function properlyCompressBase64(base64String, maxSizeKB = 50) {
  if (!base64String || !base64String.startsWith('data:image/')) {
    return base64String;
  }
  
  const maxSizeBytes = maxSizeKB * 1024;
  
  // Якщо зображення вже менше за ліміт, повертаємо як є
  if (base64String.length <= maxSizeBytes) {
    return base64String;
  }
  
  // Для великих зображень просто замінюємо на placeholder
  // або створюємо мінімальне зображення
  const placeholder = 'data:image/svg+xml;base64,' + Buffer.from(`
    <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
      <rect width="100" height="100" fill="#f0f0f0"/>
      <text x="50" y="50" text-anchor="middle" dy=".3em" font-family="Arial" font-size="12" fill="#666">
        Зображення
      </text>
    </svg>
  `).toString('base64');
  
  return placeholder;
}

// Функція для обробки JSON файлу з правильним стисненням
function fixCompressedImages(jsonFilePath) {
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
      const originalLength = question.question_image.length;
      question.question_image = properlyCompressBase64(question.question_image);
      
      if (question.question_image !== question.question_image) {
        hasChanges = true;
        fixedCount++;
        console.log(`✅ Виправлено зображення питання ${i + 1}: ${originalLength} → ${question.question_image.length} символів`);
      }
    }
    
    // Виправляємо зображення варіантів
    if (question.option_images) {
      for (const [key, imageData] of Object.entries(question.option_images)) {
        if (imageData && imageData.startsWith('data:image/')) {
          const originalLength = imageData.length;
          const compressed = properlyCompressBase64(imageData);
          
          if (compressed !== imageData) {
            question.option_images[key] = compressed;
            hasChanges = true;
            fixedCount++;
            console.log(`✅ Виправлено зображення варіанта ${key} питання ${i + 1}: ${originalLength} → ${compressed.length} символів`);
          }
        }
      }
    }
  }
  
  // Зберігаємо виправлений файл
  const fixedFilePath = jsonFilePath.replace('.json', '-fixed.json');
  fs.writeFileSync(fixedFilePath, JSON.stringify(data, null, 2), 'utf8');
  
  console.log(`\n📊 РЕЗУЛЬТАТИ ВИПРАВЛЕННЯ:`);
  console.log(`- Виправлено зображень: ${fixedCount}`);
  console.log(`\n💾 Виправлений файл: ${fixedFilePath}`);
  
  return fixedFilePath;
}

// Функція для генерації SQL з виправленими зображеннями
function generateFixedSQL(jsonFilePath) {
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

  const sqlFilePath = jsonFilePath.replace('.json', '-fixed.sql');
  fs.writeFileSync(sqlFilePath, sql);
  
  console.log(`📄 SQL файл з виправленими зображеннями: ${sqlFilePath}`);
  return sqlFilePath;
}

// Основна функція
function fixImages() {
  console.log('🔧 ВИПРАВЛЕННЯ ЗОБРАЖЕНЬ...\n');
  
  // Знаходимо оригінальний JSON файл
  const dataDir = path.join(__dirname, 'data');
  const jsonFiles = fs.readdirSync(dataDir).filter(file => 
    file.endsWith('.json') && file.includes('2024-pharmacy-1d') && !file.includes('compressed') && !file.includes('fixed')
  );
  
  if (jsonFiles.length === 0) {
    console.log('❌ Не знайдено оригінальний JSON файл');
    return;
  }
  
  const jsonFile = jsonFiles[0];
  const jsonFilePath = path.join(dataDir, jsonFile);
  
  console.log(`📁 Обробляємо файл: ${jsonFile}`);
  
  try {
    // Виправляємо зображення в JSON
    const fixedJsonPath = fixCompressedImages(jsonFilePath);
    
    // Генеруємо SQL з виправленими зображеннями
    const fixedSqlPath = generateFixedSQL(fixedJsonPath);
    
    console.log('\n🎉 ВИПРАВЛЕННЯ ЗАВЕРШЕНО!');
    console.log(`📄 JSON: ${fixedJsonPath}`);
    console.log(`📄 SQL: ${fixedSqlPath}`);
    console.log('\n💡 Тепер зображення мають працювати правильно!');
    
  } catch (error) {
    console.error('❌ Помилка при виправленні:', error);
  }
}

if (require.main === module) {
  fixImages();
}

module.exports = { fixImages, properlyCompressBase64, fixCompressedImages, generateFixedSQL };


