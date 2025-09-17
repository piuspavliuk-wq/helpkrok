// Тестовий скрипт для перевірки підключення до Supabase
// Запустіть цей код в консолі браузера на сторінці з вашим додатком

async function testSupabaseConnection() {
  try {
    // Перевіряємо чи Supabase клієнт доступний
    if (typeof window !== 'undefined' && window.supabase) {
      console.log('✅ Supabase клієнт доступний');
      
      // Тестуємо підключення
      const { data, error } = await window.supabase
        .from('users')
        .select('count')
        .limit(1);
      
      if (error) {
        console.error('❌ Помилка підключення до Supabase:', error);
        return false;
      }
      
      console.log('✅ Підключення до Supabase працює');
      return true;
    } else {
      console.log('❌ Supabase клієнт не знайдений');
      return false;
    }
  } catch (error) {
    console.error('❌ Помилка тестування:', error);
    return false;
  }
}

// Функція для тестування створення користувача
async function testCreateUser() {
  try {
    const testUser = {
      id: 'test-' + Date.now(),
      first_name: 'Тестовий',
      last_name: 'Користувач',
      email: 'test@example.com',
      faculty: 'medical',
      university: 'Тестовий університет'
    };
    
    const { data, error } = await window.supabase
      .from('users')
      .insert(testUser)
      .select();
    
    if (error) {
      console.error('❌ Помилка створення користувача:', error);
      return false;
    }
    
    console.log('✅ Користувач створений:', data);
    return true;
  } catch (error) {
    console.error('❌ Помилка тестування створення:', error);
    return false;
  }
}

// Запуск тестів
console.log('🧪 Тестування підключення до Supabase...');
testSupabaseConnection().then(success => {
  if (success) {
    console.log('🧪 Тестування створення користувача...');
    testCreateUser();
  }
});
