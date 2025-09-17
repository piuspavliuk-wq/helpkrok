import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

// Синхронізація уроків з Google Calendar
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    // Перевіряємо, чи користувач адмін
    const user = await prisma.user.findUnique({
      where: { id: session.user.id }
    })

    if (!user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Доступ заборонено. Тільки адміністратори можуть синхронізувати з календарем.' }, { status: 403 })
    }

    const body = await request.json()
    const { calendarEvents } = body

    if (!calendarEvents || !Array.isArray(calendarEvents)) {
      return NextResponse.json(
        { error: 'Невалідні дані подій календаря' },
        { status: 400 }
      )
    }

    const createdLessons = []
    const updatedLessons = []

    for (const event of calendarEvents) {
      try {
        // Перевіряємо, чи урок вже існує
        const existingLesson = await prisma.lesson.findFirst({
          where: {
            calendarEventId: event.id
          }
        })

        const lessonData = {
          title: event.summary,
          description: event.description || `Урок з ${event.subject}`,
          subject: event.subject,
          step: event.step,
          faculty: event.faculty,
          startDate: new Date(event.startDate),
          endDate: new Date(event.endDate),
          location: event.location,
          teacherName: event.teacherName,
          isOnline: event.isOnline || false,
          meetingLink: event.meetingLink,
          calendarEventId: event.id,
          createdBy: session.user.id,
          status: 'scheduled'
        }

        if (existingLesson) {
          // Оновлюємо існуючий урок
          const updatedLesson = await prisma.lesson.update({
            where: { id: existingLesson.id },
            data: lessonData
          })
          updatedLessons.push(updatedLesson)
        } else {
          // Створюємо новий урок
          const newLesson = await prisma.lesson.create({
            data: lessonData
          })
          createdLessons.push(newLesson)
        }
      } catch (error) {
        console.error(`Error processing event ${event.id}:`, error)
        continue
      }
    }

    return NextResponse.json({
      success: true,
      message: `Синхронізація завершена`,
      created: createdLessons.length,
      updated: updatedLessons.length,
      lessons: [...createdLessons, ...updatedLessons]
    })

  } catch (error) {
    console.error('Calendar sync error:', error)
    return NextResponse.json(
      { error: 'Помилка при синхронізації з календарем' },
      { status: 500 }
    )
  }
}

// Отримання подій з календаря для синхронізації
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    // Перевіряємо, чи користувач адмін
    const user = await prisma.user.findUnique({
      where: { id: session.user.id }
    })

    if (!user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Доступ заборонено. Тільки адміністратори можуть синхронізувати з календарем.' }, { status: 403 })
    }

    const { searchParams } = new URL(request.url)
    const calendarId = searchParams.get('calendarId') || process.env.GOOGLE_CALENDAR_ID
    const timeMin = searchParams.get('timeMin') || new Date().toISOString()
    const timeMax = searchParams.get('timeMax') || new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString()

    // Mock дані для тестування (в реальному проекті тут буде запит до Google Calendar API)
    const mockCalendarEvents = [
      {
        id: 'cal_lesson_1',
        summary: 'Лекція з анатомії - Серцево-судинна система',
        description: 'Детальне вивчення будови серця та кровоносних судин',
        start: {
          dateTime: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000 + 90 * 60 * 1000).toISOString()
        },
        location: 'Аудиторія 201',
        teacherName: 'Професор Іваненко',
        isOnline: false
      },
      {
        id: 'cal_lesson_2',
        summary: 'Онлайн семінар з фармакології',
        description: 'Обговорення механізмів дії лікарських препаратів',
        start: {
          dateTime: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000 + 120 * 60 * 1000).toISOString()
        },
        meetingLink: 'https://meet.google.com/abc-defg-hij',
        teacherName: 'Доцент Петренко',
        isOnline: true
      },
      {
        id: 'cal_lesson_3',
        summary: 'Практичне заняття з біохімії',
        description: 'Лабораторна робота з ферментами',
        start: {
          dateTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000 + 60 * 60 * 1000).toISOString()
        },
        location: 'Лабораторія 15',
        teacherName: 'Асистент Коваленко',
        isOnline: false
      }
    ]

    // Конвертація подій календаря в формат уроків
    const lessonEvents = mockCalendarEvents.map(event => {
      const startDate = event.start.dateTime
      const endDate = event.end.dateTime

      // Визначення предмету на основі назви події
      let subject = 'Загальна медицина'
      let step = 'krok1'
      let faculty = 'medical'

      if (event.summary.toLowerCase().includes('анатомія') || event.summary.toLowerCase().includes('анатомия')) {
        subject = 'Анатомія'
      } else if (event.summary.toLowerCase().includes('фармакологія') || event.summary.toLowerCase().includes('фармакология')) {
        subject = 'Фармакологія'
        faculty = 'pharmaceutical'
      } else if (event.summary.toLowerCase().includes('біохімія') || event.summary.toLowerCase().includes('биохимия')) {
        subject = 'Біохімія'
      }

      // Визначення кроку на основі опису або назви
      if (event.summary.toLowerCase().includes('крок1') || event.summary.toLowerCase().includes('крок 1')) {
        step = 'krok1'
      } else if (event.summary.toLowerCase().includes('крок2') || event.summary.toLowerCase().includes('крок 2')) {
        step = 'krok2'
      } else if (event.summary.toLowerCase().includes('крок3') || event.summary.toLowerCase().includes('крок 3')) {
        step = 'krok3'
      }

      return {
        id: event.id,
        summary: event.summary,
        description: event.description,
        subject,
        step,
        faculty,
        startDate,
        endDate,
        location: event.location,
        teacherName: event.teacherName,
        isOnline: event.isOnline,
        meetingLink: event.meetingLink
      }
    })

    return NextResponse.json({
      success: true,
      events: lessonEvents,
      note: 'Використовуються тестові дані. Для реальної інтеграції потрібно налаштувати Google Calendar API.'
    })

  } catch (error) {
    console.error('Calendar events API error:', error)
    return NextResponse.json(
      { error: 'Помилка при отриманні подій календаря' },
      { status: 500 }
    )
  }
}
