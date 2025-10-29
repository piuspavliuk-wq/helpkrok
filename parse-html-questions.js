const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

class HTMLQuestionParser {
  constructor() {
    this.questions = [];
  }

  loadHTML(filepath) {
    console.log(`📖 Завантаження HTML з файлу: ${filepath}`);
    
    try {
      const data = JSON.parse(fs.readFileSync(filepath, 'utf8'));
      console.log(`✅ HTML завантажено (${data.html_length} символів)`);
      return data.html_content;
    } catch (error) {
      console.log('❌ Помилка при завантаженні HTML:', error.message);
      return null;
    }
  }

  parseQuestions(html) {
    console.log('🔍 Парсинг питань з HTML...');
    
    const $ = cheerio.load(html);
    const questions = [];
    
    // Функція для очищення тексту
    const cleanText = (text) => {
      if (!text) return '';
      return text.replace(/\s+/g, ' ').trim();
    };
    
    // Шукаємо всі питання
    const questionElements = $('.question');
    
    console.log(`Знайдено ${questionElements.length} питань`);
    
    questionElements.each((index, questionEl) => {
      try {
        const $question = $(questionEl);
        
        // Отримуємо текст питання
        const questionTextEl = $question.find('.question__text');
        const questionText = questionTextEl.length ? cleanText(questionTextEl.text()) : '';
        
        if (!questionText) {
          console.log(`Питання ${index + 1}: не знайдено текст питання`);
          return;
        }
        
        // Отримуємо варіанти відповідей
        const variantElements = $question.find('.question__variant');
        const options = {};
        let correctAnswer = '';
        
        variantElements.each((variantIndex, variantEl) => {
          const $variant = $(variantEl);
          const spanEl = $variant.find('span');
          const optionText = spanEl.length ? cleanText(spanEl.text()) : '';
          
          if (optionText) {
            const letter = String.fromCharCode(65 + variantIndex); // A, B, C, D, E
            options[letter] = optionText;
            
            // Перевіряємо, чи це правильна відповідь
            if ($variant.hasClass('question__variant_right')) {
              correctAnswer = letter;
              console.log(`Правильна відповідь для питання ${index + 1}: ${letter} - ${optionText}`);
            }
          }
        });
        
        if (Object.keys(options).length > 0) {
          questions.push({
            question_text: questionText,
            options: options,
            correct_answer: correctAnswer,
            question_number: index + 1,
            extracted_at: new Date().toISOString()
          });
        } else {
          console.log(`Питання ${index + 1}: не знайдено варіанти відповідей`);
        }
        
      } catch (error) {
        console.log(`Помилка при обробці питання ${index + 1}:`, error.message);
      }
    });
    
    console.log(`✅ Парсинг завершено. Зібрано ${questions.length} питань`);
    return questions;
  }

  saveQuestions(questions, pageInfo) {
    const data = {
      source: 'krok-lead.com',
      url: pageInfo.url,
      extracted_at: new Date().toISOString(),
      page_info: pageInfo,
      questions: questions,
      total_questions: questions.length
    };

    const filename = `krok-lead-parsed-questions-${Date.now()}.json`;
    const filepath = path.join(__dirname, 'data', filename);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`💾 Парсовані питання збережено в файл: ${filepath}`);
    
    return filepath;
  }

  showStatistics(questions) {
    const correctAnswersCount = questions.filter(q => q.correct_answer).length;
    
    console.log('\n📊 Статистика парсингу:');
    console.log(`- Всього питань: ${questions.length}`);
    console.log(`- З правильними відповідями: ${correctAnswersCount}`);
    console.log(`- Без правильних відповідей: ${questions.length - correctAnswersCount}`);
    
    // Показуємо приклади питань
    console.log('\n📝 Приклади зібраних питань:');
    questions.slice(0, 3).forEach((q, i) => {
      console.log(`${i + 1}. ${q.question_text.substring(0, 100)}...`);
      console.log(`   Варіанти: ${Object.keys(q.options).length}`);
      console.log(`   Правильна відповідь: ${q.correct_answer || 'не визначено'}`);
      Object.entries(q.options).forEach(([letter, text]) => {
        const isCorrect = letter === q.correct_answer ? ' ✓' : '';
        console.log(`   ${letter}: ${text.substring(0, 50)}...${isCorrect}`);
      });
    });
    
    if (questions.length > 3) {
      console.log(`   ... та ще ${questions.length - 3} питань`);
    }
  }
}

// Основна функція
async function parseHTMLQuestions(htmlFilePath) {
  const parser = new HTMLQuestionParser();
  
  try {
    const html = parser.loadHTML(htmlFilePath);
    
    if (!html) {
      console.log('❌ Не вдалося завантажити HTML');
      return null;
    }
    
    const questions = parser.parseQuestions(html);
    
    if (questions.length > 0) {
      // Отримуємо інформацію про сторінку з JSON файлу
      const data = JSON.parse(fs.readFileSync(htmlFilePath, 'utf8'));
      const pageInfo = data.page_info;
      
      const filepath = parser.saveQuestions(questions, pageInfo);
      parser.showStatistics(questions);
      
      console.log(`🎉 Успішно спарсено питання! Файл: ${filepath}`);
      
      return filepath;
    } else {
      console.log('❌ Не вдалося знайти питання в HTML');
      return null;
    }
    
  } catch (error) {
    console.error('❌ Помилка при парсингу HTML:', error);
    return null;
  }
}

// Запуск скрипта
if (require.main === module) {
  const htmlFilePath = process.argv[2] || 'data/krok-lead-html-with-answers-1759502418548.json';
  parseHTMLQuestions(htmlFilePath);
}

module.exports = { HTMLQuestionParser, parseHTMLQuestions };
