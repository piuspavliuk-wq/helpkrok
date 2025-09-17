import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
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

    const { data: user, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single()

    if (error) {
      console.error('Error fetching user:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні даних користувача' },
        { status: 500 }
      )
    }

    if (!user) {
      return NextResponse.json(
        { error: 'Користувач не знайдений' },
        { status: 404 }
      )
    }

    return NextResponse.json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        faculty: user.faculty,
      },
    })
  } catch (error) {
    console.error('Auth check error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
