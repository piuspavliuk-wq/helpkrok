import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function GET(request: NextRequest) {
  try {
    const token = await getToken({ req: request })
    
    if (!token?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Тимчасово повертаємо mock дані
    const mockScheduleItems = [
      {
        id: '1',
        title: 'Підготовка до тесту з анатомії',
        description: 'Повторити матеріал з будови скелета та м\'язів',
        subject: 'Анатомія',
        step: 'krok1',
        faculty: 'medical',
        startDate: '2024-01-20T09:00:00Z',
        endDate: '2024-01-20T12:00:00Z',
        isCompleted: false,
        priority: 'high',
        createdAt: '2024-01-15T10:00:00Z',
        updatedAt: '2024-01-15T10:00:00Z'
      },
      {
        id: '2',
        title: 'Перегляд відеолекції з фізіології',
        description: 'Лекція про серцево-судинну систему',
        subject: 'Фізіологія',
        step: 'krok1',
        faculty: 'medical',
        startDate: '2024-01-21T14:00:00Z',
        endDate: '2024-01-21T16:00:00Z',
        isCompleted: true,
        priority: 'medium',
        createdAt: '2024-01-16T10:00:00Z',
        updatedAt: '2024-01-21T16:00:00Z'
      },
      {
        id: '3',
        title: 'Тест з біохімії',
        description: 'Практичний тест з обміну речовин',
        subject: 'Біохімія',
        step: 'krok1',
        faculty: 'medical',
        startDate: '2024-01-22T10:00:00Z',
        endDate: '2024-01-22T11:30:00Z',
        isCompleted: false,
        priority: 'high',
        createdAt: '2024-01-17T10:00:00Z',
        updatedAt: '2024-01-17T10:00:00Z'
      }
    ]

    return NextResponse.json({
      success: true,
      scheduleItems: mockScheduleItems,
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Schedule API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { title, description, subject, step, faculty, startDate, endDate, priority } = body

    // Валідація обов'язкових полів
    if (!title || !subject || !startDate || !endDate) {
      return NextResponse.json({ 
        error: 'Missing required fields: title, subject, startDate, endDate' 
      }, { status: 400 })
    }

    // Тимчасово повертаємо успішну відповідь
    // Пізніше тут буде створення в базі даних
    const newItem = {
      id: Date.now().toString(),
      title,
      description: description || '',
      subject,
      step: step || 'krok1',
      faculty: faculty || 'medical',
      startDate,
      endDate,
      isCompleted: false,
      priority: priority || 'medium',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }

    return NextResponse.json({
      success: true,
      scheduleItem: newItem,
      message: 'Schedule item created successfully',
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Create schedule item API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
