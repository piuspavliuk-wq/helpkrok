import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// Спрощений API для збережених питань (без авторизації для тестування)
export async function GET(request: NextRequest) {
  try {
    // Повертаємо порожній масив для тестування
    return NextResponse.json({
      success: true,
      savedQuestions: [],
      totalSaved: 0
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const { questionId } = await request.json();
    
    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    // Повертаємо успішну відповідь для тестування
    return NextResponse.json({
      success: true,
      message: 'Питання успішно збережено (тестовий режим)'
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const questionId = searchParams.get('questionId');
    
    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    // Повертаємо успішну відповідь для тестування
    return NextResponse.json({
      success: true,
      message: 'Питання видалено зі збережених (тестовий режим)'
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
