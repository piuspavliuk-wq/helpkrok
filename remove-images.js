const fs = require('fs');
const path = require('path');

// Функція для видалення всіх зображень
function removeAllImages(jsonFilePath) {
  console.log(`📖 Читаємо JSON файл: ${jsonFilePath}`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  console.log(`📊 Кількість питань: ${data.questions.length}`);
  
  let removedCount = 0;
  
  for (let i = 0; i < data.questions.length; i++) {
    const question = data.questions[i];
    let hasChanges = false;
    
    // Видаляємо зображення питання
    if (question.question_image) {
      question.question_image = null;
      hasChanges = true;
      removedCount++;
    }
    
    // Видаляємо зображення варіантів
    if (question.option_images && Object.keys(question.option_images).length > 0) {
      question.option_images = {};
      hasChanges = true;
      removedCount++;
    }
    
    if (hasChanges) {
      console.log(`✅ Видалено зображення з питання ${i + 1}`);
    }
  }
  
  // Зберігаємо файл без зображень
  const noImagesFilePath = jsonFilePath.replace('.json', '-no-images.json');
  fs.writeFileSync(noImagesFilePath, JSON.stringify(data, null, 2), 'utf8');
  
  console.log(`\n📊 РЕЗУЛЬТАТИ ВИДАЛЕННЯ:`);
  console.log(`- Видалено зображень: ${removedCount}`);
  console.log(`\n💾 Файл без зображень: ${noImagesFilePath}`);
  
  return noImagesFilePath;
}

// Функція для генерації SQL без зображень
function generateNoImagesSQL(jsonFilePath) {
  console.log(`\n📄 Генеруємо SQL без зображень...`);
  
  const rawData = fs.readFileSync(jsonFilePath, 'utf8');
  const data = JSON.parse(rawData);
  
  let sql = `-- SQL для імпорту питань фармації ${data.title} (без зображень)\n`;
  sql += `-- Кількість питань: ${data.questions.length}\n`;
  sql += `-- Назва тесту: ${data.title}\n\n`;

  data.questions.forEach((question, index) => {
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
    sql += `  NULL,\n`; // question_image = NULL
    sql += `  NULL,\n`; // option_images = NULL
    sql += `  '${JSON.stringify(question.options).replace(/'/g, "''")}',\n`;
    sql += `  '${question.extracted_at}',\n`;
    sql += `  '${question.extracted_at}'\n`;
    sql += `);\n\n`;
  });

  const sqlFilePath = jsonFilePath.replace('.json', '-no-images.sql');
  fs.writeFileSync(sqlFilePath, sql);
  
  console.log(`📄 SQL файл без зображень: ${sqlFilePath}`);
  return sqlFilePath;
}

// Основна функція
function removeImages() {
  console.log('🗑️ ВИДАЛЕННЯ ВСІХ ЗОБРАЖЕНЬ...\n');
  
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
    // Видаляємо всі зображення
    const noImagesJsonPath = removeAllImages(jsonFilePath);
    
    // Генеруємо SQL без зображень
    const noImagesSqlPath = generateNoImagesSQL(noImagesJsonPath);
    
    console.log('\n🎉 ВИДАЛЕННЯ ЗАВЕРШЕНО!');
    console.log(`📄 JSON: ${noImagesJsonPath}`);
    console.log(`📄 SQL: ${noImagesSqlPath}`);
    console.log('\n💡 Тепер SQL файл буде маленьким і без помилок зображень!');
    
  } catch (error) {
    console.error('❌ Помилка при видаленні:', error);
  }
}

if (require.main === module) {
  removeImages();
}

module.exports = { removeImages, removeAllImages, generateNoImagesSQL };


