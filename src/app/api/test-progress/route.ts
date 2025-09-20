// API endpoint для роботи з прогресом тестування
// Файл: /api/test-progress/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// GET - отримати прогрес користувача по тесту
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url);
    const testType = searchParams.get('testType');

    if (!testType) {
      return NextResponse.json(
        { error: 'testType обов\'язковий' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Отримуємо прогрес користувача по конкретному тесту
    const { data: progress, error } = await supabase
      .from('user_test_progress')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('test_type', testType)
      .order('question_id');

    if (error) {
      console.error('Помилка отримання прогресу:', error);
      return NextResponse.json(
        { error: 'Помилка отримання прогресу' },
        { status: 500 }
      );
    }

    // Перетворюємо в зручний формат для фронтенду
    const progressMap: { [questionId: number]: string } = {};
    progress?.forEach(item => {
      if (item.selected_answer) {
        progressMap[item.question_id] = item.selected_answer;
      }
    });

    return NextResponse.json({
      success: true,
      progress: progressMap,
      totalAnswered: progress?.length || 0
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

// POST - зберегти відповідь користувача
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { testType, questionId, selectedAnswer, correctAnswer } = await request.json();

    if (!testType || !questionId || !selectedAnswer) {
      return NextResponse.json(
        { error: 'testType, questionId та selectedAnswer обов\'язкові' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Визначаємо чи правильно відповів користувач
    const isCorrect = selectedAnswer === correctAnswer;

    // Зберігаємо або оновлюємо відповідь
    const { data, error } = await supabase
      .from('user_test_progress')
      .upsert({
        user_id: session.user.id,
        test_type: testType,
        question_id: questionId,
        selected_answer: selectedAnswer,
        is_correct: isCorrect,
        answered_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }, {
        onConflict: 'user_id,test_type,question_id'
      })
      .select()
      .single();

    if (error) {
      console.error('Помилка збереження відповіді:', error);
      return NextResponse.json(
        { error: 'Помилка збереження відповіді' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: 'Відповідь збережено',
      progress: data
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}

// DELETE - видалити прогрес користувача по тесту
export async function DELETE(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url);
    const testType = searchParams.get('testType');

    if (!testType) {
      return NextResponse.json(
        { error: 'testType обов\'язковий' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Використовуємо функцію для видалення відповідей та оновлення статистики
    const { error } = await supabase.rpc('clear_user_answers_and_update_stats', {
      p_user_id: session.user.id,
      p_test_type: testType
    });

    if (error) {
      console.error('Помилка видалення прогресу:', error);
      return NextResponse.json(
        { error: 'Помилка видалення прогресу' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: 'Прогрес видалено'
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
