const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Відсутні змінні середовища для Supabase')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

async function testConnection() {
  console.log('🔍 Тестування підключення до Supabase...')
  
  try {
    const { data, error } = await supabase
      .from('users')
      .select('count')
      .limit(1)

    if (error) {
      console.error('❌ Помилка підключення:', error)
      return false
    }

    console.log('✅ Підключення до Supabase успішне')
    return true
  } catch (error) {
    console.error('❌ Помилка підключення:', error)
    return false
  }
}

async function createUniversities() {
  console.log('📚 Створення університетів...')
  
  const universities = [
    'Харківський національний університет імені В. Н. Каразіна',
    '(КиМУ) Київський міжнародний університет',
    'Черкаська медична академія',
    'Волинський національний університет імені Лесі Українки',
    'Київський національний університет імені Тараса Шевченка',
    'Чорноморський національний університет імені Петра Могили',
    'Харківський міжнародний медичний університет',
    'Міжнародний Європейський Університет',
    '(МАУП) Міжрегіональна Академія управління персоналом',
    'Дніпровський інститут медицини та громадського здоров\'я',
    'Київський міський медичний коледж',
    'Херсонський державний університет',
    'Медичний коледж «Монада»',
    'Івано-Франківський медичний фаховий коледж',
    'Житомирський медичний інститут',
    'Запорізький медичний коледж',
    'КЗВО «Волинський медичний інститут»',
    'Дніпровський базовий медичний коледж',
    'Шепетівський медичний фаховий коледж',
    'Харківський інститут медицини та біомедичних наук',
    '(ЖБФФК) Житомирський базовий фармацевтичний фаховий коледж',
    'Кам\'янець-Подільський медичний фаховий коледж',
    'Кам\'янський медичний коледж',
    'Навчально-науковий інститут медсестринства'
  ]

  console.log('📝 Список університетів для додавання в Supabase:')
  universities.forEach((uni, index) => {
    console.log(`${index + 1}. ${uni}`)
  })

  console.log('\n📋 SQL команди для створення таблиці universities:')
  console.log(`
-- Створення таблиці universities
CREATE TABLE universities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Додавання полів до таблиці users
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS university_id INTEGER REFERENCES universities(id),
ADD COLUMN IF NOT EXISTS step TEXT DEFAULT 'krok1' CHECK (step IN ('krok1', 'krok2', 'krok3'));
`)

  console.log('\n📝 SQL команди для вставки університетів:')
  universities.forEach((uni, index) => {
    console.log(`INSERT INTO universities (name) VALUES ('${uni}');`)
  })

  return true
}

async function main() {
  console.log('🚀 Налаштування бази даних Supabase...')
  
  const connectionOk = await testConnection()
  if (!connectionOk) {
    console.log('❌ Не вдалося підключитися до Supabase')
    process.exit(1)
  }

  await createUniversities()
  
  console.log('\n🎉 Інструкції готові!')
  console.log('📋 Виконайте наступні кроки:')
  console.log('1. Відкрийте Supabase Dashboard')
  console.log('2. Перейдіть в SQL Editor')
  console.log('3. Виконайте SQL команди зверху')
  console.log('4. Перезапустіть сервер розробки')
}

main().catch(console.error)