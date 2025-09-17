import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function PUT(request: NextRequest) {
  try {
    const body = await request.json()
    const { faculty } = body

    if (!faculty || !['medical', 'pharmaceutical'].includes(faculty)) {
      return NextResponse.json(
        { error: 'Невірний факультет' },
        { status: 400 }
      )
    }

    // Отримуємо токен з cookies
    const token = request.cookies.get('auth-token')?.value
    
    if (!token) {
      return NextResponse.json(
        { error: 'Не автентифікований' },
        { status: 401 }
      )
    }

    // Тут має бути логіка валідації токена та отримання user_id
    // Для спрощення поки що використовуємо заглушку
    const userId = 'temp-user-id' // В реальному додатку це має бути з токена

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    const { data: updatedUser, error } = await supabase
      .from('users')
      .update({
        faculty,
        updated_at: new Date().toISOString(),
      })
      .eq('id', userId)
      .select()
      .single()

    if (error) {
      console.error('Error updating user faculty:', error)
      return NextResponse.json(
        { error: 'Помилка при оновленні факультету' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      user: updatedUser,
    })
  } catch (error) {
    console.error('Faculty update error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
