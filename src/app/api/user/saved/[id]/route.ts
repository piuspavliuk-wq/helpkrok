import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

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

    // Тимчасово повертаємо успішну відповідь
    // Пізніше тут буде видалення з бази даних
    return NextResponse.json({
      success: true,
      message: 'Saved item removed successfully',
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
