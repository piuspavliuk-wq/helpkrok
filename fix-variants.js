const fs = require('fs');
const path = require('path');

// Дані з дебагу (правильні варіанти)
const correctVariants = {
  1: {
    question_text: 'При отруєнні етиленгліколем у пацієнта розвинулася гостра ниркова недостатність: З\'явилася нудота, блювання, олігурія, азотемія. Який механізм розвитку гострої ниркової недостатності?',
    options: {
      A: 'Зменшення гідростатнчного тиску в кубочках',
      B: 'Зменшення тканинного тиску в нирках',
      C: 'Збільшення загальної площі фільтрації',
      D: 'Зменшення онкотичного тиску крові',
      E: 'Збільшення проникності стінки клубочків'
    },
    correct_answer: 'A'
  },
  2: {
    question_text: 'Після вживання в їжу консервованих грибів у пацієнта з\'явилися симптоми бульбарного паралічу: птоз, диплопія, дисфаргія, дисфонія. Який метод лабораторної діагностики найбільш інформативний для підтвердження діагнозу?',
    options: {
      A: 'Преципітації',
      B: 'Імуно-флюоресценції',
      C: 'Аглютинації',
      D: 'Зв\'язування комплементу',
      E: 'Нейтралізації'
    },
    correct_answer: 'E'
  },
  3: {
    question_text: 'У пацієнта віком 62 роки з хронічним обструктивним захворюванням легень спостерігається прогресуюча дихальна недостатність. Який механізм розвитку дихальної недостатності є основним?',
    options: {
      A: 'Зниження легеневої вентиляції',
      B: 'Посилення шунтування крові',
      C: 'Надмірна метаболічна потреба',
      D: 'Порушення альвеолярної дифузії кисню',
      E: 'Зниження рівня кисню в повітрі'
    },
    correct_answer: 'A'
  },
  4: {
    question_text: 'Пацієнт віком 60 років звернувся до лікарки-отоларингологині зі скаргами на погіршення слуху на ліве вухо. Під час обстеження виявлено порушення проведення звуку по повітряному шляху. Яка структура мозку відповідає за проведення звукових сигналів?',
    options: {
      A: 'Медіальне колінчасте тіло',
      B: 'Верхні горбики',
      C: 'Латеральне колінчасте тіло',
      D: 'Нижні горбики',
      E: 'Кохлеарне ядро'
    },
    correct_answer: 'E'
  }
};

function generateCorrectSQL() {
  console.log('🔄 Генерація правильного SQL файлу...');
  
  const questions = Object.values(correctVariants);
  
  const sqlValues = questions.map((q, index) => {
    const category = getRandomCategory();
    const explanation_text = `Правильна відповідь: ${q.correct_answer}. ${q.options[q.correct_answer]}. Це питання з медичної підготовки, яке потребує детального вивчення відповідного матеріалу.`;
    const reference_text = `Джерело: krok-lead.com - https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1`;
    const importedAt = new Date().toISOString();
    
    return `(
  '${q.question_text.replace(/'/g, "''")}',
  2025,
  'medical',
  '${category}',
  true,
  '${q.options.A.replace(/'/g, "''")}',
  '${q.options.B.replace(/'/g, "''")}',
  '${q.options.C.replace(/'/g, "''")}',
  '${q.options.D.replace(/'/g, "''")}',
  '${q.options.E.replace(/'/g, "''")}',
  '${q.correct_answer}',
  '${explanation_text.replace(/'/g, "''")}',
  '${reference_text}',
  '${importedAt}',
  '${importedAt}'
)`;
  }).join(',\n');

  const sql = `-- Імпорт питань з Krok Lead (з правильними відповідями)
-- Дата створення: ${new Date().toISOString()}
-- Кількість питань: ${questions.length}

INSERT INTO krok_questions_unified (
  question_text,
  year,
  faculty,
  category,
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
${sqlValues};`;

  return sql;
}

function getRandomCategory() {
  const categories = [
    'general_medicine',
    'physiology', 
    'biochemistry',
    'pharmacology',
    'histology',
    'pathology',
    'microbiology',
    'anatomy'
  ];
  return categories[Math.floor(Math.random() * categories.length)];
}

// Основна функція
function fixVariants() {
  try {
    const sql = generateCorrectSQL();
    
    const filename = `krok-lead-corrected-${Date.now()}.sql`;
    const filepath = path.join(__dirname, 'data', filename);
    
    if (!fs.existsSync(path.join(__dirname, 'data'))) {
      fs.mkdirSync(path.join(__dirname, 'data'));
    }
    
    fs.writeFileSync(filepath, sql, 'utf8');
    console.log(`💾 Правильний SQL файл збережено: ${filepath}`);
    
    // Копіюємо на робочий стіл
    const desktopPath = path.join(process.env.HOME, 'Desktop', 'krok-lead-4-questions-corrected.sql');
    fs.writeFileSync(desktopPath, sql, 'utf8');
    console.log(`📁 Файл також скопійовано на робочий стіл: ${desktopPath}`);
    
    console.log('\n📊 Статистика:');
    console.log(`- Всього питань: ${Object.keys(correctVariants).length}`);
    console.log(`- З правильними відповідями: ${Object.keys(correctVariants).length}`);
    console.log(`- Без колонки difficulty: ✅`);
    console.log(`- Реальні варіанти відповідей: ✅`);
    
    console.log('\n📝 Приклади питань:');
    Object.entries(correctVariants).forEach(([num, q]) => {
      console.log(`${num}. ${q.question_text.substring(0, 80)}...`);
      console.log(`   Правильна відповідь: ${q.correct_answer} - ${q.options[q.correct_answer]}`);
    });
    
    return filepath;
    
  } catch (error) {
    console.error('❌ Помилка при генерації SQL:', error);
    return null;
  }
}

// Запуск скрипта
if (require.main === module) {
  fixVariants();
}

module.exports = { fixVariants, correctVariants };
