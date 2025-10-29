import { NextRequest, NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
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

    // Перевірка чи існує користувач в Prisma (локальна база)
    const existingUser = await prisma.user.findUnique({
      where: { email }
    })

    if (existingUser) {
      return NextResponse.json(
        { error: 'Користувач з таким email вже існує' },
        { status: 400 }
      )
    }

    // Хешування пароля
    const hashedPassword = await bcrypt.hash(password, 12)

    // Створення користувача в Prisma (локальна база)
    const user = await prisma.user.create({
      data: {
        firstName,
        lastName,
        email,
        password: hashedPassword,
        faculty,
      }
    })

    // Синхронізація з Supabase (опціонально)
    try {
      console.log('🔄 Спроба синхронізації з Supabase...');
      console.log('Supabase Admin клієнт доступний:', !!supabaseAdmin);
      
      if (supabaseAdmin) {
        console.log('📤 Відправляємо дані в Supabase:', {
          first_name: firstName,
          last_name: lastName,
          email: email
        });
        
        const { data: supabaseData, error: supabaseError } = await supabaseAdmin
          .from('users')
          .insert({
            first_name: firstName,
            last_name: lastName,
            email: email,
            faculty: faculty,
            password: hashedPassword
          })
          .select();

        if (supabaseError) {
          console.error('❌ Supabase sync error:', supabaseError);
          console.error('❌ Supabase error details:', {
            message: supabaseError.message,
            details: supabaseError.details,
            hint: supabaseError.hint,
            code: supabaseError.code
          });
          // Не блокуємо реєстрацію, якщо Supabase недоступний
        } else {
          console.log('✅ Supabase sync successful:', supabaseData);
        }
      } else {
        console.log('⚠️ Supabase Admin not configured, skipping sync');
      }
    } catch (supabaseError) {
      console.error('❌ Supabase connection error:', supabaseError);
      // Продовжуємо роботу з локальною базою
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
