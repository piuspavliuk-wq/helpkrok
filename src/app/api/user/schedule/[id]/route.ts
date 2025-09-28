import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const action = searchParams.get('action')

    if (action === 'toggle') {
      // Тимчасово повертаємо успішну відповідь
      // Пізніше тут буде оновлення статусу в базі даних
      return NextResponse.json({
        success: true,
        message: 'Schedule item completion status toggled',
        note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
      })
    }

    const body = await request.json()
    // Деструктуризація для майбутнього використання
    const { title, description, subject, step, faculty, startDate, endDate, priority } = body
    
    // Тимчасово використовуємо змінні для уникнення помилок
    console.log('Update data:', { title, description, subject, step, faculty, startDate, endDate, priority })

    // Тимчасово повертаємо успішну відповідь
    // Пізніше тут буде оновлення в базі даних
    return NextResponse.json({
      success: true,
      message: 'Schedule item updated successfully',
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Update schedule item API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id } = await params
    
    // Тимчасово використовуємо id для уникнення помилок
    console.log('Deleting schedule item:', id)

    // Тимчасово повертаємо успішну відповідь
    // Пізніше тут буде видалення з бази даних
    return NextResponse.json({
      success: true,
      message: 'Schedule item deleted successfully',
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Delete schedule item API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
