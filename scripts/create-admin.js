const { PrismaClient } = require('@prisma/client')
const bcrypt = require('bcryptjs')

const prisma = new PrismaClient()

async function createAdminAccount() {
  try {
    console.log('🔧 Створення адмін акаунту...')

    // Перевіряємо, чи вже існує адмін
    const existingAdmin = await prisma.user.findFirst({
      where: {
        role: 'admin'
      }
    })

    if (existingAdmin) {
      console.log('⚠️  Адмін акаунт вже існує:', existingAdmin.email)
      return existingAdmin
    }

    // Створюємо адмін акаунт
    const adminEmail = 'admin@helpkrok.com'
    const adminPassword = 'admin123' // В продакшені використовуйте складний пароль
    const hashedPassword = await bcrypt.hash(adminPassword, 12)

    const admin = await prisma.user.create({
      data: {
        name: 'Адміністратор',
        email: adminEmail,
        password: hashedPassword,
        firstName: 'Адміністратор',
        lastName: 'Системи',
        faculty: 'medical', // Можна змінити на потрібний факультет
        university: 'Харківський національний університет імені В. Н. Каразіна',
        yearOfStudy: 6,
        role: 'admin',
        emailVerified: new Date(),
        bio: 'Системний адміністратор платформи HelpKrok'
      }
    })

    console.log('✅ Адмін акаунт успішно створено!')
    console.log('📧 Email:', adminEmail)
    console.log('🔑 Password:', adminPassword)
    console.log('🆔 ID:', admin.id)
    console.log('👤 Role:', admin.role)

    return admin

  } catch (error) {
    console.error('❌ Помилка при створенні адмін акаунту:', error)
    throw error
  } finally {
    await prisma.$disconnect()
  }
}

// Додаткова функція для створення тестового викладача
async function createTeacherAccount() {
  try {
    console.log('🔧 Створення тестового викладача...')

    const teacherEmail = 'teacher@helpkrok.com'
    const teacherPassword = 'teacher123'
    const hashedPassword = await bcrypt.hash(teacherPassword, 12)

    const teacher = await prisma.user.create({
      data: {
        name: 'Викладач Тестовий',
        email: teacherEmail,
        password: hashedPassword,
        firstName: 'Викладач',
        lastName: 'Тестовий',
        faculty: 'medical',
        university: 'Харківський національний університет імені В. Н. Каразіна',
        yearOfStudy: 6,
        role: 'teacher',
        emailVerified: new Date(),
        bio: 'Тестовий викладач для демонстрації функцій'
      }
    })

    console.log('✅ Викладач успішно створено!')
    console.log('📧 Email:', teacherEmail)
    console.log('🔑 Password:', teacherPassword)
    console.log('🆔 ID:', teacher.id)
    console.log('👤 Role:', teacher.role)

    return teacher

  } catch (error) {
    console.error('❌ Помилка при створенні викладача:', error)
    throw error
  }
}

// Функція для створення тестових уроків
async function createTestLessons() {
  try {
    console.log('🔧 Створення тестових уроків...')

    const admin = await prisma.user.findFirst({
      where: { role: 'admin' }
    })

    if (!admin) {
      console.log('⚠️  Спочатку створіть адмін акаунт')
      return
    }

    const testLessons = [
      {
        title: 'Лекція з анатомії - Серцево-судинна система',
        description: 'Детальне вивчення будови серця та кровоносних судин',
        subject: 'Анатомія',
        step: 'krok1',
        faculty: 'medical',
        startDate: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000), // Через 2 дні
        endDate: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000 + 90 * 60 * 1000), // +90 хвилин
        location: 'Аудиторія 201',
        teacherName: 'Професор Іваненко',
        isOnline: false,
        status: 'scheduled',
        createdBy: admin.id
      },
      {
        title: 'Онлайн семінар з фармакології',
        description: 'Обговорення механізмів дії лікарських препаратів',
        subject: 'Фармакологія',
        step: 'krok2',
        faculty: 'pharmaceutical',
        startDate: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // Через 5 днів
        endDate: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000 + 120 * 60 * 1000), // +120 хвилин
        meetingLink: 'https://meet.google.com/abc-defg-hij',
        teacherName: 'Доцент Петренко',
        isOnline: true,
        status: 'scheduled',
        createdBy: admin.id
      },
      {
        title: 'Практичне заняття з біохімії',
        description: 'Лабораторна робота з ферментами',
        subject: 'Біохімія',
        step: 'krok1',
        faculty: 'medical',
        startDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // Через 7 днів
        endDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000 + 60 * 60 * 1000), // +60 хвилин
        location: 'Лабораторія 15',
        teacherName: 'Асистент Коваленко',
        isOnline: false,
        status: 'scheduled',
        createdBy: admin.id
      }
    ]

    for (const lessonData of testLessons) {
      const lesson = await prisma.lesson.create({
        data: lessonData
      })
      console.log(`✅ Створено урок: ${lesson.title}`)
    }

    console.log('✅ Всі тестові уроки створено!')

  } catch (error) {
    console.error('❌ Помилка при створенні тестових уроків:', error)
    throw error
  }
}

// Головна функція
async function main() {
  try {
    console.log('🚀 Початок створення адмін акаунту та тестових даних...\n')

    // Створюємо адмін акаунт
    await createAdminAccount()
    console.log('')

    // Створюємо тестового викладача
    await createTeacherAccount()
    console.log('')

    // Створюємо тестові уроки
    await createTestLessons()
    console.log('')

    console.log('🎉 Всі акаунти та тестові дані успішно створено!')
    console.log('\n📋 Дані для входу:')
    console.log('👑 Адмін: admin@helpkrok.com / admin123')
    console.log('👨‍🏫 Викладач: teacher@helpkrok.com / teacher123')

  } catch (error) {
    console.error('❌ Загальна помилка:', error)
    process.exit(1)
  } finally {
    await prisma.$disconnect()
  }
}

// Запускаємо скрипт
if (require.main === module) {
  main()
}

module.exports = {
  createAdminAccount,
  createTeacherAccount,
  createTestLessons
}
