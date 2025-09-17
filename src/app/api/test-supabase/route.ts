import { NextRequest, NextResponse } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    console.log('🧪 Тестування Supabase підключення...');
    
    if (!supabaseAdmin) {
      return NextResponse.json({
        success: false,
        error: 'Supabase Admin клієнт не налаштований',
        details: {
          url: process.env.NEXT_PUBLIC_SUPABASE_URL,
          serviceKey: process.env.SUPABASE_SERVICE_ROLE_KEY ? 'налаштований' : 'не налаштований'
        }
      })
    }

    // Тестуємо підключення
    const { data, error } = await supabaseAdmin
      .from('users')
      .select('count')
      .limit(1)

    if (error) {
      console.error('❌ Supabase error:', error);
      return NextResponse.json({
        success: false,
        error: 'Помилка підключення до Supabase',
        details: error
      })
    }

    // Отримуємо всіх користувачів
    const { data: users, error: usersError } = await supabaseAdmin
      .from('users')
      .select('*')

    if (usersError) {
      console.error('❌ Users error:', usersError);
      return NextResponse.json({
        success: false,
        error: 'Помилка отримання користувачів',
        details: usersError
      })
    }

    console.log('✅ Supabase працює правильно');
    console.log('📊 Користувачі:', users);

    return NextResponse.json({
      success: true,
      message: 'Supabase працює правильно',
      usersCount: users?.length || 0,
      users: users
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
