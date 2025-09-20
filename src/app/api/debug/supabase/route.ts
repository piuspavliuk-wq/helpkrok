import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

export async function GET(request: NextRequest) {
  try {
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
    const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    const envCheck = {
      NEXT_PUBLIC_SUPABASE_URL: supabaseUrl ? '✅ Налаштований' : '❌ Відсутній',
      NEXT_PUBLIC_SUPABASE_ANON_KEY: supabaseAnonKey ? '✅ Налаштований' : '❌ Відсутній',
      SUPABASE_SERVICE_ROLE_KEY: supabaseServiceKey ? '✅ Налаштований' : '❌ Відсутній',
    };

    // Спробуємо створити клієнт
    let supabaseClient = null;
    let connectionError = null;

    try {
      if (supabaseUrl && supabaseAnonKey) {
        supabaseClient = createClient(supabaseUrl, supabaseAnonKey);
      }
    } catch (error) {
      connectionError = error instanceof Error ? error.message : 'Невідома помилка';
    }

    // Спробуємо зробити простий запит
    let testResult = null;
    if (supabaseClient) {
      try {
        const { data, error } = await supabaseClient
          .from('users')
          .select('id')
          .limit(1);
        
        if (error) {
          testResult = { success: false, error: error.message };
        } else {
          testResult = { success: true, data: data };
        }
      } catch (error) {
        testResult = { success: false, error: error instanceof Error ? error.message : 'Невідома помилка' };
      }
    }

    return NextResponse.json({
      success: true,
      environment: envCheck,
      connectionError,
      testResult,
      timestamp: new Date().toISOString(),
      message: 'Перевірка Supabase з\'єднання'
    });

  } catch (error) {
    console.error('Debug Supabase API error:', error);
    return NextResponse.json(
      { 
        success: false,
        error: 'Помилка перевірки Supabase',
        details: error instanceof Error ? error.message : 'Невідома помилка'
      },
      { status: 500 }
    );
  }
}

