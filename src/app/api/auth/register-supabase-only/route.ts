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

    // Перевірка чи налаштований Supabase клієнт
    if (!supabaseAdmin) {
      return NextResponse.json(
        { error: 'Supabase не налаштовано' },
        { status: 500 }
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

    // Надаємо одну безкоштовну спробу для нового користувача
    // Перевіряємо, чи вже не існує спроби (на випадок, якщо тригер вже створив)
    try {
      const { data: existingAttempt } = await supabaseAdmin
        .from('randomizer_attempts')
        .select('id')
        .eq('user_id', user.id)
        .single()

      if (!existingAttempt) {
        const { error: attemptError } = await supabaseAdmin
          .from('randomizer_attempts')
          .insert({
            user_id: user.id,
            total_attempts: 1,
            used_attempts: 0,
            purchase_date: new Date().toISOString(),
            expires_at: null // Безкоштовна спроба не має терміну дії
          })

        if (attemptError) {
          console.error('❌ Error creating free attempt:', attemptError)
          // Не блокуємо реєстрацію, якщо не вдалося створити спробу
        } else {
          console.log('✅ Free randomizer attempt created for new user')
        }
      } else {
        console.log('✅ Free randomizer attempt already exists (created by trigger)')
      }
    } catch (attemptErr) {
      console.error('❌ Error in free attempt creation:', attemptErr)
      // Продовжуємо реєстрацію навіть якщо не вдалося створити спробу
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
