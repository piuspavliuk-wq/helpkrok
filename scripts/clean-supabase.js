const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

const supabase = createClient(supabaseUrl, supabaseKey)

async function cleanSupabase() {
  console.log('🧹 Очищення Supabase...')
  
  try {
    // Видаляємо всіх користувачів
    console.log('🗑️ Видалення всіх користувачів...')
    const { error: deleteUsersError } = await supabase
      .from('users')
      .delete()
      .neq('id', '00000000-0000-0000-0000-000000000000') // Видаляємо всіх

    if (deleteUsersError) {
      console.error('❌ Помилка видалення користувачів:', deleteUsersError)
    } else {
      console.log('✅ Користувачі видалені')
    }

    // Видаляємо всі університети
    console.log('🗑️ Видалення всіх університетів...')
    const { error: deleteUniError } = await supabase
      .from('universities')
      .delete()
      .neq('id', 0) // Видаляємо всі

    if (deleteUniError) {
      console.error('❌ Помилка видалення університетів:', deleteUniError)
    } else {
      console.log('✅ Університети видалені')
    }

    console.log('🎉 Supabase очищено!')
    
  } catch (error) {
    console.error('❌ Помилка очищення:', error)
  }
}

async function recreateTables() {
  console.log('🔧 Перестворення таблиць...')
  
  console.log('📋 SQL команди для перестворення таблиць:')
  console.log(`
-- Видалення старих таблиць
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS universities CASCADE;

-- Створення нових таблиць
CREATE TABLE universities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE users (
  id TEXT PRIMARY KEY,
  telegram_id TEXT UNIQUE,
  telegram_username TEXT,
  university_id INTEGER REFERENCES universities(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Вставка університетів
INSERT INTO universities (name) VALUES 
('Харківський національний університет імені В. Н. Каразіна'),
('(КиМУ) Київський міжнародний університет'),
('Черкаська медична академія'),
('Волинський національний університет імені Лесі Українки'),
('Київський національний університет імені Тараса Шевченка'),
('Чорноморський національний університет імені Петра Могили'),
('Харківський міжнародний медичний університет'),
('Міжнародний Європейський Університет'),
('(МАУП) Міжрегіональна Академія управління персоналом'),
('Дніпровський інститут медицини та громадського здоров''я'),
('Київський міський медичний коледж'),
('Херсонський державний університет'),
('Медичний коледж «Монада»'),
('Івано-Франківський медичний фаховий коледж'),
('Житомирський медичний інститут'),
('Запорізький медичний коледж'),
('КЗВО «Волинський медичний інститут»'),
('Дніпровський базовий медичний коледж'),
('Шепетівський медичний фаховий коледж'),
('Харківський інститут медицини та біомедичних наук'),
('(ЖБФФК) Житомирський базовий фармацевтичний фаховий коледж'),
('Кам''янець-Подільський медичний фаховий коледж'),
('Кам''янський медичний коледж'),
('Навчально-науковий інститут медсестринства');
`)

  console.log('\n📝 Виконайте ці команди в Supabase SQL Editor')
}

async function main() {
  console.log('🚀 Очищення та перестворення Supabase...')
  
  await cleanSupabase()
  await recreateTables()
  
  console.log('\n✅ Готово!')
  console.log('📋 Наступні кроки:')
  console.log('1. Відкрийте Supabase Dashboard')
  console.log('2. Перейдіть в SQL Editor')
  console.log('3. Виконайте SQL команди зверху')
  console.log('4. Перезапустіть сервер розробки')
}

main().catch(console.error)
