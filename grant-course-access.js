/**
 * Скрипт для надання доступу до курсу користувачу
 * Використання: node grant-course-access.js <email> [courseId]
 * 
 * Приклад:
 * node grant-course-access.js user@example.com central-nervous-system
 */

const { createClient } = require('@supabase/supabase-js')
require('dotenv').config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Помилка: NEXT_PUBLIC_SUPABASE_URL та SUPABASE_SERVICE_ROLE_KEY мають бути встановлені в .env.local')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseKey)

async function grantCourseAccess(email, courseId = 'central-nervous-system') {
  try {
    console.log(`🔍 Шукаю користувача з email: ${email}`)
    
    // Знаходимо користувача за email
    const { data: user, error: findUserError } = await supabase
      .from('users')
      .select('id, email, first_name, last_name')
      .eq('email', email)
      .single()

    if (findUserError || !user) {
      console.error(`❌ Користувач з email ${email} не знайдений`)
      console.error('Помилка:', findUserError)
      process.exit(1)
    }

    console.log(`✅ Знайдено користувача: ${user.first_name} ${user.last_name} (${user.email})`)
    console.log(`📚 Надаю доступ до курсу: ${courseId}`)

    // Перевіряємо чи вже є доступ через payments
    const { data: existingPayment, error: checkError } = await supabase
      .from('payments')
      .select('*')
      .eq('user_id', user.id)
      .eq('package_id', courseId)
      .eq('payment_type', 'course')
      .eq('status', 'success')
      .maybeSingle()

    if (existingPayment) {
      console.log('⚠️  Доступ вже надано раніше')
      console.log('Деталі платежу:', existingPayment)
      return
    }

    // Створюємо фіктивний платіж для надання доступу
    const invoiceId = `granted-access-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`
    
    const { data: newPayment, error: insertError } = await supabase
      .from('payments')
      .insert({
        user_id: user.id,
        invoice_id: invoiceId,
        amount: 0,
        status: 'success',
        payment_type: 'course',
        package_id: courseId,
        attempts_count: 0,
        metadata: JSON.stringify({
          reason: 'Надано доступ за виграш курсу',
          granted_by: 'admin'
        }),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single()

    if (insertError) {
      console.error('❌ Помилка створення платежу:', insertError)
      process.exit(1)
    }

    console.log('✅ Доступ успішно надано через систему платежів!')
    console.log('ID платежу:', newPayment.id)
    console.log('Invoice ID:', newPayment.invoice_id)
  } catch (error) {
    console.error('❌ Помилка:', error)
    process.exit(1)
  }
}

// Отримуємо аргументи з командного рядка
const email = process.argv[2]
const courseId = process.argv[3] || 'central-nervous-system'

if (!email) {
  console.error('❌ Помилка: необхідно вказати email користувача')
  console.log('Використання: node grant-course-access.js <email> [courseId]')
  console.log('Приклад: node grant-course-access.js user@example.com central-nervous-system')
  process.exit(1)
}

// Запускаємо скрипт
grantCourseAccess(email, courseId)
  .then(() => {
    console.log('\n✨ Готово!')
    process.exit(0)
  })
  .catch((error) => {
    console.error('❌ Критична помилка:', error)
    process.exit(1)
  })

