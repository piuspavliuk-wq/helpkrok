const fs = require('fs');
const path = require('path');

// Файли для виправлення
const filesToFix = [
  {
    sqlFile: 'data/2019-pharmacy-eng-questions-1760169625205-COMPLETE.sql',
    jsonFile: 'data/2019-pharmacy-eng-questions-1760169625205.json',
    newTitle: 'Нові тести з цт 2024',
    newIdentifier: '2024-pharmacy-new-ct'
  },
  {
    sqlFile: 'data/2024-pharmacy-new-ct-questions-1760169264084-COMPLETE.sql', 
    jsonFile: 'data/2024-pharmacy-new-ct-questions-1760169264084.json',
    newTitle: '2019 (Eng)',
    newIdentifier: '2019-pharmacy-eng'
  }
];

function fixSQLFile(filePath, newTitle, newIdentifier) {
  try {
    console.log(`🔧 Виправляємо SQL файл: ${filePath}`);
    
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Замінюємо title в INSERT statements
    content = content.replace(
      /title, test_identifier,\n.*?VALUES \(\n.*?'([^']+)',\n.*?'([^']+)',/g,
      (match, oldTitle, oldIdentifier) => {
        return match.replace(oldTitle, newTitle).replace(oldIdentifier, newIdentifier);
      }
    );
    
    // Замінюємо title в коментарях
    content = content.replace(
      /-- Назва тесту: .+/g,
      `-- Назва тесту: ${newTitle}`
    );
    
    fs.writeFileSync(filePath, content);
    console.log(`✅ SQL файл виправлено: ${filePath}`);
    return true;
    
  } catch (error) {
    console.error(`❌ Помилка при виправленні SQL файлу ${filePath}:`, error.message);
    return false;
  }
}

function fixJSONFile(filePath, newTitle, newIdentifier) {
  try {
    console.log(`🔧 Виправляємо JSON файл: ${filePath}`);
    
    const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    
    // Оновлюємо дані
    jsonData.title = newTitle;
    jsonData.test_identifier = newIdentifier;
    
    // Оновлюємо title в кожному питанні
    jsonData.questions.forEach(question => {
      // Питання не мають окремого title, але можна додати якщо потрібно
    });
    
    fs.writeFileSync(filePath, JSON.stringify(jsonData, null, 2));
    console.log(`✅ JSON файл виправлено: ${filePath}`);
    return true;
    
  } catch (error) {
    console.error(`❌ Помилка при виправленні JSON файлу ${filePath}:`, error.message);
    return false;
  }
}

async function fixTestNames() {
  console.log('🔧 ВИПРАВЛЯЄМО НАЗВИ ТЕСТІВ...');
  console.log('');
  
  const results = [];
  
  for (const file of filesToFix) {
    console.log(`\n📝 Обробляємо: ${file.newTitle}`);
    
    let sqlSuccess = false;
    let jsonSuccess = false;
    
    // Виправляємо SQL файл
    if (fs.existsSync(file.sqlFile)) {
      sqlSuccess = fixSQLFile(file.sqlFile, file.newTitle, file.newIdentifier);
    } else {
      console.log(`⚠️ SQL файл не знайдено: ${file.sqlFile}`);
    }
    
    // Виправляємо JSON файл
    if (fs.existsSync(file.jsonFile)) {
      jsonSuccess = fixJSONFile(file.jsonFile, file.newTitle, file.newIdentifier);
    } else {
      console.log(`⚠️ JSON файл не знайдено: ${file.jsonFile}`);
    }
    
    results.push({
      title: file.newTitle,
      sqlSuccess,
      jsonSuccess
    });
  }
  
  console.log('\n🎉 ВИПРАВЛЕННЯ ЗАВЕРШЕНО!');
  console.log('\n📊 РЕЗУЛЬТАТИ:');
  
  results.forEach((result, index) => {
    console.log(`${index + 1}. ${result.title}:`);
    console.log(`   📄 SQL: ${result.sqlSuccess ? '✅' : '❌'}`);
    console.log(`   📄 JSON: ${result.jsonSuccess ? '✅' : '❌'}`);
  });
  
  return results;
}

if (require.main === module) {
  fixTestNames().catch(console.error);
}

module.exports = { fixTestNames };


