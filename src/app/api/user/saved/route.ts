import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Тимчасово повертаємо mock дані
    const mockSavedItems = [
      {
        id: '1',
        itemType: 'test',
        itemId: 'anatomy',
        itemTitle: 'Анатомія - Крок 1',
        itemData: {
          description: 'Тест з анатомії для підготовки до КРОК 1',
          questions: 50,
          difficulty: 'medium',
          subject: 'Анатомія',
          step: 'krok1',
          faculty: 'medical'
        },
        createdAt: '2024-01-15T10:30:00Z'
      },
      {
        id: '2',
        itemType: 'course',
        itemId: 'physiology-course',
        itemTitle: 'Курс фізіології',
        itemData: {
          description: 'Повний курс фізіології з відеолекціями',
          duration: 1800,
          difficulty: 'hard',
          subject: 'Фізіологія',
          step: 'krok1',
          faculty: 'medical'
        },
        createdAt: '2024-01-14T15:45:00Z'
      },
      {
        id: '3',
        itemType: 'video',
        itemId: 'biochemistry-video',
        itemTitle: 'Біохімія: Обмін речовин',
        itemData: {
          description: 'Відеолекція про обмін речовин в організмі',
          duration: 1200,
          difficulty: 'medium',
          subject: 'Біохімія',
          step: 'krok1',
          faculty: 'medical'
        },
        createdAt: '2024-01-13T09:20:00Z'
      },
      {
        id: '4',
        itemType: 'question',
        itemId: 'question-123',
        itemTitle: 'Питання про серце',
        itemData: {
          description: 'Складне питання про будову серця',
          difficulty: 'hard',
          subject: 'Анатомія',
          step: 'krok1',
          faculty: 'medical'
        },
        createdAt: '2024-01-12T14:15:00Z'
      }
    ]

    return NextResponse.json({
      success: true,
      savedItems: mockSavedItems,
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Saved items API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const itemId = searchParams.get('itemId')

    if (!itemId) {
      return NextResponse.json({ error: 'Item ID is required' }, { status: 400 })
    }

    // Тимчасово повертаємо успішну відповідь
    // Пізніше тут буде видалення з бази даних
    return NextResponse.json({
      success: true,
      message: 'Item removed from saved list',
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Delete saved item API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
