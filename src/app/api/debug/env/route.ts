import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  try {
    const envCheck = {
      GOOGLE_GEMINI_API_KEY: process.env.GOOGLE_GEMINI_API_KEY ? '✅ Налаштований' : '❌ Відсутній',
      NEXTAUTH_URL: process.env.NEXTAUTH_URL || '❌ Відсутній',
      NEXTAUTH_SECRET: process.env.NEXTAUTH_SECRET ? '✅ Налаштований' : '❌ Відсутній',
      NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL ? '✅ Налаштований' : '❌ Відсутній',
      NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ? '✅ Налаштований' : '❌ Відсутній',
      NODE_ENV: process.env.NODE_ENV || '❌ Відсутній',
    };

    return NextResponse.json({
      success: true,
      environment: envCheck,
      timestamp: new Date().toISOString(),
      message: 'Перевірка змінних середовища'
    });

  } catch (error) {
    console.error('Debug API error:', error);
    return NextResponse.json(
      { 
        success: false,
        error: 'Помилка перевірки змінних середовища',
        details: error instanceof Error ? error.message : 'Невідома помилка'
      },
      { status: 500 }
    );
  }
}
