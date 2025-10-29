import { NextRequest, NextResponse } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase'
import bcrypt from 'bcryptjs'

export async function POST(request: NextRequest) {
  try {
    const { firstName, lastName, email, password, faculty } = await request.json()

    // Валідація даних
    if (!firstName || !lastName || !email || !password || !faculty) {
      return NextResponse.json(
        { error: 'Всі поля обов\'язкові' },
        { status: 400 }
      )
    }

    if (!['medical', 'pharmaceutical'].includes(faculty)) {
      return NextResponse.json(
        { error: 'Невірний факультет' },
        { status: 400 }
      )
    }

    if (password.length < 6) {
      return NextResponse.json(
        { error: 'Пароль повинен містити мінімум 6 символів' },
        { status: 400 }
      )
    }

    // Перевірка чи існує користувач в Supabase
    const { data: existingUser, error: checkError } = await supabaseAdmin
      .from('users')
      .select('id, email')
      .eq('email', email)
      .single()

    if (existingUser) {
      return NextResponse.json(
        { error: 'Користувач з таким email вже існує' },
        { status: 400 }
      )
    }

    // Хешування пароля
    const hashedPassword = await bcrypt.hash(password, 12)

    // Створення користувача в Supabase
    const { data: user, error: createError } = await supabaseAdmin
      .from('users')
      .insert({
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: hashedPassword,
        faculty: faculty
      })
      .select()
      .single()

    if (createError) {
      console.error('❌ Supabase create error:', createError)
      return NextResponse.json(
        { error: 'Помилка створення користувача' },
        { status: 500 }
      )
    }

    // Повертаємо користувача без пароля
    const { password: _, ...userWithoutPassword } = user

    return NextResponse.json(
      { 
        message: 'Користувач успішно створений',
        user: userWithoutPassword 
      },
      { status: 201 }
    )

  } catch (error) {
    console.error('Registration error:', error)
    console.error('Error details:', {
      message: error instanceof Error ? error.message : 'Unknown error',
      stack: error instanceof Error ? error.stack : undefined,
      name: error instanceof Error ? error.name : undefined
    })
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
