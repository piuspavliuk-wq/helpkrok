const fs = require('fs');
const path = require('path');

// Читаємо JSON файл
const jsonFile = '/Users/bohdanpavliuk/Desktop/help-krok-platform/data/2024-pharmacy-2d-questions-1760206186012.json';
const data = JSON.parse(fs.readFileSync(jsonFile, 'utf8'));

console.log('🔍 Аналізуємо зображення в файлі 2024р 2д...');
console.log(`📊 Всього питань: ${data.questions.length}`);

let largeImagesCount = 0;
let smallImagesCount = 0;
let totalImageSize = 0;

// Аналізуємо зображення
data.questions.forEach((question, index) => {
  // Перевіряємо зображення в питанні
  if (question.question_image) {
    const size = question.question_image.length;
    totalImageSize += size;
    
    if (size > 100000) { // > 100KB
      largeImagesCount++;
      console.log(`🖼️ Питання ${index + 1}: зображення в питанні ${Math.round(size/1024)}KB`);
    } else {
      smallImagesCount++;
    }
  }
  
  // Перевіряємо зображення в варіантах
  if (question.option_images) {
    Object.entries(question.option_images).forEach(([letter, image]) => {
      if (image) {
        const size = image.length;
        totalImageSize += size;
        
        if (size > 100000) { // > 100KB
          largeImagesCount++;
          console.log(`🖼️ Питання ${index + 1}, варіант ${letter}: зображення ${Math.round(size/1024)}KB`);
        } else {
          smallImagesCount++;
        }
      }
    });
  }
});

console.log('\n📊 Статистика зображень:');
console.log(`- Великі зображення (>100KB): ${largeImagesCount}`);
console.log(`- Малі зображення (≤100KB): ${smallImagesCount}`);
console.log(`- Загальний розмір зображень: ${Math.round(totalImageSize/1024/1024)}MB`);

// Створюємо версію без великих зображень
const limitedData = {
  ...data,
  questions: data.questions.map(question => {
    const limitedQuestion = { ...question };
    
    // Видаляємо великі зображення з питання
    if (limitedQuestion.question_image && limitedQuestion.question_image.length > 100000) {
      limitedQuestion.question_image = null;
    }
    
    // Видаляємо великі зображення з варіантів
    if (limitedQuestion.option_images) {
      const limitedOptionImages = {};
      Object.entries(limitedQuestion.option_images).forEach(([letter, image]) => {
        if (image && image.length <= 100000) {
          limitedOptionImages[letter] = image;
        }
      });
      limitedQuestion.option_images = Object.keys(limitedOptionImages).length > 0 ? limitedOptionImages : null;
    }
    
    return limitedQuestion;
  })
};

// Генеруємо SQL без великих зображень
let sql = `-- SQL для імпорту питань фармації 2024р 2д (без великих зображень)
-- Кількість питань: ${limitedData.questions.length}
-- Назва тесту: 2024р 2д
-- Видалено великих зображень: ${largeImagesCount}

`;

limitedData.questions.forEach((question, index) => {
  const questionImage = question.question_image ? `'${question.question_image.replace(/'/g, "''")}'` : 'NULL';
  const optionImages = question.option_images && Object.keys(question.option_images).length > 0 ? 
    `'${JSON.stringify(question.option_images).replace(/'/g, "''")}'` : 'NULL';
  
  sql += `INSERT INTO krok_questions_unified_pharmacy (
  question_text, year, faculty, category, difficulty,
  option_a, option_b, option_c, option_d, option_e,
  correct_answer, title, test_identifier,
  question_image, option_images, options,
  created_at, updated_at
) VALUES (
  '${question.question_text.replace(/'/g, "''")}',
  2024,
  'pharmacy',
  'pharmacy',
  'medium',
  '${question.options.A?.replace(/'/g, "''") || ''}',
  '${question.options.B?.replace(/'/g, "''") || ''}',
  '${question.options.C?.replace(/'/g, "''") || ''}',
  '${question.options.D?.replace(/'/g, "''") || ''}',
  '${question.options.E?.replace(/'/g, "''") || ''}',
  '${question.correct_answer || 'A'}',
  '2024р 2д',
  '2024-pharmacy-2d',
  ${questionImage},
  ${optionImages},
  '${JSON.stringify(question.options).replace(/'/g, "''")}',
  '${question.extracted_at}',
  '${question.extracted_at}'
);

`;
});

// Зберігаємо обмежений SQL файл
const limitedSqlFile = '/Users/bohdanpavliuk/Desktop/help-krok-platform/data/2024-pharmacy-2d-questions-1760206186012-limited-50kb.sql';
fs.writeFileSync(limitedSqlFile, sql);

console.log(`\n✅ Створено обмежений SQL файл: ${limitedSqlFile}`);
console.log(`📄 Розмір файлу: ${Math.round(fs.statSync(limitedSqlFile).size / 1024)}KB`);

// Перевіряємо, чи файл не занадто великий
const fileSize = fs.statSync(limitedSqlFile).size;
if (fileSize > 5000000) { // > 5MB
  console.log('⚠️ Файл все ще занадто великий. Спробуємо видалити всі зображення...');
  
  // Видаляємо всі зображення
  const noImagesData = {
    ...data,
    questions: data.questions.map(question => ({
      ...question,
      question_image: null,
      option_images: null
    }))
  };
  
  let noImagesSql = `-- SQL для імпорту питань фармації 2024р 2д (без зображень)
-- Кількість питань: ${noImagesData.questions.length}
-- Назва тесту: 2024р 2д

`;
  
  noImagesData.questions.forEach((question, index) => {
    noImagesSql += `INSERT INTO krok_questions_unified_pharmacy (
  question_text, year, faculty, category, difficulty,
  option_a, option_b, option_c, option_d, option_e,
  correct_answer, title, test_identifier,
  question_image, option_images, options,
  created_at, updated_at
) VALUES (
  '${question.question_text.replace(/'/g, "''")}',
  2024,
  'pharmacy',
  'pharmacy',
  'medium',
  '${question.options.A?.replace(/'/g, "''") || ''}',
  '${question.options.B?.replace(/'/g, "''") || ''}',
  '${question.options.C?.replace(/'/g, "''") || ''}',
  '${question.options.D?.replace(/'/g, "''") || ''}',
  '${question.options.E?.replace(/'/g, "''") || ''}',
  '${question.correct_answer || 'A'}',
  '2024р 2д',
  '2024-pharmacy-2d',
  NULL,
  NULL,
  '${JSON.stringify(question.options).replace(/'/g, "''")}',
  '${question.extracted_at}',
  '${question.extracted_at}'
);

`;
  });
  
  const noImagesSqlFile = '/Users/bohdanpavliuk/Desktop/help-krok-platform/data/2024-pharmacy-2d-questions-1760206186012-no-images.sql';
  fs.writeFileSync(noImagesSqlFile, noImagesSql);
  
  console.log(`✅ Створено SQL файл без зображень: ${noImagesSqlFile}`);
  console.log(`📄 Розмір файлу: ${Math.round(fs.statSync(noImagesSqlFile).size / 1024)}KB`);
}
