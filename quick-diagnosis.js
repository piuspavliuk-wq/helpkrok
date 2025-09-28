// Швидка діагностика проблеми з збереженням прогресу
// Запустіть: node quick-diagnosis.js

console.log('🔍 Швидка діагностика проблеми з збереженням прогресу...\n');

// 1. Перевіряємо змінні середовища
console.log('1️⃣ Змінні середовища:');
const requiredEnvVars = [
    'NEXT_PUBLIC_SUPABASE_URL',
    'NEXT_PUBLIC_SUPABASE_ANON_KEY', 
    'SUPABASE_SERVICE_ROLE_KEY',
    'NEXTAUTH_SECRET'
];

let envIssues = 0;
requiredEnvVars.forEach(envVar => {
    if (process.env[envVar]) {
        console.log(`✅ ${envVar}: Встановлено`);
    } else {
        console.log(`❌ ${envVar}: НЕ ВСТАНОВЛЕНО`);
        envIssues++;
    }
});

if (envIssues > 0) {
    console.log(`\n⚠️  Знайдено ${envIssues} проблем з змінними середовища!`);
    console.log('Рішення: Перевірте файл .env.local та перезапустіть сервер');
} else {
    console.log('\n✅ Всі змінні середовища встановлені правильно');
}

// 2. Перевіряємо підключення до Supabase
console.log('\n2️⃣ Тестування підключення до Supabase...');

async function testSupabase() {
    try {
        const { createClient } = require('@supabase/supabase-js');
        
        const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
        const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
        
        if (!supabaseUrl || !supabaseKey) {
            console.log('❌ Не можу тестувати Supabase - відсутні змінні середовища');
            return;
        }
        
        const supabase = createClient(supabaseUrl, supabaseKey);
        
        // Тестуємо простий запит
        const { data, error } = await supabase
            .from('user_test_progress')
            .select('count')
            .limit(1);
            
        if (error) {
            console.log('❌ Помилка підключення до Supabase:', error.message);
        } else {
            console.log('✅ Підключення до Supabase працює');
        }
        
    } catch (error) {
        console.log('❌ Критична помилка:', error.message);
    }
}

// 3. Перевіряємо API endpoint
console.log('\n3️⃣ Тестування API endpoint...');

async function testAPI() {
    try {
        const response = await fetch('http://localhost:3000/api/test-progress?testType=anatomy');
        console.log(`Статус API: ${response.status}`);
        
        if (response.status === 401) {
            console.log('⚠️  API повертає 401 - потрібна авторизація користувача');
        } else if (response.status === 500) {
            console.log('❌ API повертає 500 - внутрішня помилка сервера');
            const errorData = await response.json();
            console.log('Деталі помилки:', errorData);
        } else if (response.status === 200) {
            console.log('✅ API працює правильно');
        } else {
            console.log(`⚠️  Неочікуваний статус: ${response.status}`);
        }
    } catch (error) {
        console.log('❌ Не можу підключитися до API:', error.message);
        console.log('Переконайтеся, що сервер запущений: npm run dev');
    }
}

// Запускаємо всі тести
async function runDiagnosis() {
    await testSupabase();
    await testAPI();
    
    console.log('\n📋 Рекомендації:');
    console.log('1. Переконайтеся, що файл .env.local існує та містить всі необхідні змінні');
    console.log('2. Перезапустіть сервер після зміни змінних середовища');
    console.log('3. Увійдіть в систему перед тестуванням збереження прогресу');
    console.log('4. Відкрийте test-progress-save.html в браузері для детального тестування');
}

runDiagnosis();
