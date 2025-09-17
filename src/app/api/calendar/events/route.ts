import { NextRequest, NextResponse } from 'next/server'
import { google } from 'googleapis'

// Інтерфейс для події календаря
interface CalendarEvent {
  id: string
  summary: string
  description?: string
  start: {
    dateTime?: string
    date?: string
  }
  end: {
    dateTime?: string
    date?: string
  }
  location?: string
  attendees?: Array<{
    email: string
    displayName?: string
  }>
}

// Інтерфейс для завдання навчання
interface StudyTask {
  title: string
  description?: string
  subject: string
  step: string
  faculty: string
  startDate: string
  endDate: string
  priority: 'low' | 'medium' | 'high'
  source: 'calendar'
  calendarEventId?: string
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const calendarId = searchParams.get('calendarId') || process.env.GOOGLE_CALENDAR_ID
    const timeMin = searchParams.get('timeMin') || new Date().toISOString()
    const timeMax = searchParams.get('timeMax') || new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString() // 30 днів вперед

    if (!calendarId) {
      return NextResponse.json(
        { error: 'Calendar ID не надано' },
        { status: 400 }
      )
    }

    // Ініціалізація Google Calendar API
    const auth = new google.auth.OAuth2(
      process.env.GOOGLE_CLIENT_ID,
      process.env.GOOGLE_CLIENT_SECRET,
      process.env.NEXTAUTH_URL + '/api/auth/google/callback'
    )

    // Для тестування використовуємо mock дані
    // В реальному проекті тут буде отримання токену доступу
    const mockEvents: CalendarEvent[] = [
      {
        id: 'cal_1',
        summary: 'Лекція з анатомії - Серцево-судинна система',
        description: 'Вивчення будови серця та кровоносних судин',
        start: {
          dateTime: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000 + 90 * 60 * 1000).toISOString()
        },
        location: 'Аудиторія 201'
      },
      {
        id: 'cal_2',
        summary: 'Тест КРОК - Фармакологія',
        description: 'Контрольний тест з основ фармакології',
        start: {
          dateTime: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000 + 120 * 60 * 1000).toISOString()
        },
        location: 'Комп\'ютерний клас'
      },
      {
        id: 'cal_3',
        summary: 'Підготовка до КРОК - Біохімія',
        description: 'Повторення матеріалу з біохімії',
        start: {
          dateTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString()
        },
        end: {
          dateTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000 + 60 * 60 * 1000).toISOString()
        }
      }
    ]

    // Конвертація подій календаря в завдання навчання
    const studyTasks: StudyTask[] = mockEvents.map(event => {
      const startDate = event.start.dateTime || event.start.date
      const endDate = event.end.dateTime || event.end.date

      // Визначення предмету на основі назви події
      let subject = 'Загальна медицина'
      let step = 'krok1'
      let faculty = 'medical'
      let priority: 'low' | 'medium' | 'high' = 'medium'

      if (event.summary.toLowerCase().includes('анатомія') || event.summary.toLowerCase().includes('анатомия')) {
        subject = 'Анатомія'
      } else if (event.summary.toLowerCase().includes('фармакологія') || event.summary.toLowerCase().includes('фармакология')) {
        subject = 'Фармакологія'
        faculty = 'pharmaceutical'
      } else if (event.summary.toLowerCase().includes('біохімія') || event.summary.toLowerCase().includes('биохимия')) {
        subject = 'Біохімія'
      } else if (event.summary.toLowerCase().includes('тест') || event.summary.toLowerCase().includes('крок')) {
        subject = 'КРОК тестування'
        priority = 'high'
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
        title: event.summary,
        description: event.description || `Подія з календаря: ${event.summary}`,
        subject,
        step,
        faculty,
        startDate: startDate || new Date().toISOString(),
        endDate: endDate || new Date().toISOString(),
        priority,
        source: 'calendar' as const,
        calendarEventId: event.id
      }
    })

    return NextResponse.json({
      success: true,
      events: mockEvents,
      studyTasks,
      note: 'Використовуються тестові дані. Для реальної інтеграції потрібно налаштувати OAuth токени.'
    })

  } catch (error) {
    console.error('Google Calendar API error:', error)
    return NextResponse.json(
      { error: 'Помилка при отриманні подій календаря' },
      { status: 500 }
    )
  }
}

// POST endpoint для створення завдань з подій календаря
export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { events, userId } = body

    if (!events || !Array.isArray(events)) {
      return NextResponse.json(
        { error: 'Невалідні дані подій' },
        { status: 400 }
      )
    }

    // Тут буде логіка збереження завдань в базу даних
    // Наразі повертаємо успішну відповідь
    
    const createdTasks = events.map((event: Record<string, unknown>, index: number) => ({
      id: `calendar_task_${Date.now()}_${index}`,
      ...event,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }))

    return NextResponse.json({
      success: true,
      message: `Створено ${createdTasks.length} завдань з календаря`,
      tasks: createdTasks
    })

  } catch (error) {
    console.error('Error creating tasks from calendar:', error)
    return NextResponse.json(
      { error: 'Помилка при створенні завдань' },
      { status: 500 }
    )
  }
}
