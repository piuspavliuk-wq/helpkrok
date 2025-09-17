import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function POST(request: NextRequest) {
  try {
    const { firstName, lastName, email, password } = await request.json()

    console.log('🧪 Тестування створення користувача в Supabase...');
    console.log('Дані:', { firstName, lastName, email });

    if (!supabase) {
      return NextResponse.json({
        success: false,
        error: 'Supabase клієнт не налаштований'
      })
    }

    // Спробуємо створити користувача
    const { data, error } = await supabase
      .from('users')
      .insert({
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password, // Не хешуємо для тесту
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()

    if (error) {
      console.error('❌ Supabase insert error:', error);
      return NextResponse.json({
        success: false,
        error: 'Помилка створення користувача в Supabase',
        details: {
          message: error.message,
          details: error.details,
          hint: error.hint,
          code: error.code
        }
      })
    }

    console.log('✅ Користувач створений в Supabase:', data);

    return NextResponse.json({
      success: true,
      message: 'Користувач успішно створений в Supabase',
      user: data
    })

  } catch (error) {
    console.error('❌ Test error:', error);
    return NextResponse.json({
      success: false,
      error: 'Внутрішня помилка',
      details: error instanceof Error ? error.message : 'Unknown error'
    })
  }
}
