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
    const progressMap: { [questionId: string]: string } = {};
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
    console.log('🔍 API test-progress POST запит отримано');
    
    const session = await getServerSession(authOptions);
    console.log('👤 Сесія користувача:', session?.user?.id ? 'авторизований' : 'не авторизований');
    
    if (!session?.user?.id) {
      console.log('❌ Користувач не авторизований');
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { testType, questionId, selectedAnswer, correctAnswer } = await request.json();
    console.log('📝 Дані запиту:', { testType, questionId, selectedAnswer, correctAnswer });

    if (!testType || !questionId || !selectedAnswer) {
      console.log('❌ Відсутні обов\'язкові поля');
      return NextResponse.json(
        { error: 'testType, questionId та selectedAnswer обов\'язкові' },
        { status: 400 }
      );
    }

    console.log('🔗 Підключення до Supabase...');
    const supabase = createSupabaseClientForServer();

    // Визначаємо чи правильно відповів користувач
    const isCorrect = selectedAnswer === correctAnswer;
    console.log('✅ Правильність відповіді:', isCorrect);

    // Зберігаємо або оновлюємо відповідь
    console.log('💾 Збереження в базу даних...');
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
    
    console.log('📊 Результат операції з БД:', { data, error });

    if (error) {
      console.error('Помилка збереження відповіді:', error);
      console.error('Деталі помилки:', JSON.stringify(error, null, 2));
      console.error('Дані запиту:', {
        userId: session.user.id,
        testType,
        testTypeLength: testType?.length,
        questionId,
        selectedAnswer,
        correctAnswer,
        isCorrect
      });
      return NextResponse.json(
        { 
          error: 'Помилка збереження відповіді',
          details: error.message || 'Unknown error',
          code: error.code || 'UNKNOWN',
          hint: error.details || null
        },
        { status: 500 }
      );
    }

    // Оновлюємо статистику після збереження відповіді
    console.log('📈 Оновлення статистики...');
    try {
      await updateUserStatistics(session.user.id, supabase);
      console.log('✅ Статистика оновлена');
    } catch (statsError) {
      console.error('❌ Помилка оновлення статистики:', statsError);
      // Не зупиняємо процес, якщо статистика не оновилася
    }

    console.log('🎉 Відповідь успішно збережено');
    return NextResponse.json({
      success: true,
      message: 'Відповідь збережено',
      progress: data
    });

  } catch (error) {
    console.error('❌ Загальна помилка API:', error);
    console.error('📋 Деталі помилки:', JSON.stringify(error, null, 2));
    return NextResponse.json(
      { 
        error: 'Внутрішня помилка сервера',
        details: (error as Error).message || 'Unknown error',
        stack: (error as Error).stack || 'No stack trace'
      },
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

    // Видаляємо відповіді з таблиці
    const { error } = await supabase
      .from('user_test_progress')
      .delete()
      .eq('user_id', session.user.id)
      .eq('test_type', testType);

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

// Функція для оновлення статистики користувача
async function updateUserStatistics(userId: string, supabase: any) {
  try {
    // Отримуємо статистику з user_test_progress
    const { data: progressData } = await supabase
      .from('user_test_progress')
      .select('is_correct')
      .eq('user_id', userId)
    
    if (progressData) {
      const totalAnswered = progressData.length
      const correctAnswers = progressData.filter((p: any) => p.is_correct).length
      const incorrectAnswers = totalAnswered - correctAnswers
      const averagePercentage = totalAnswered > 0 ? Math.round((correctAnswers / totalAnswered) * 100 * 100) / 100 : 0
      
      // Отримуємо кількість завершених тестів
      const { data: testAttempts } = await supabase
        .from('test_attempts')
        .select('id')
        .eq('user_id', userId)
        .not('completed_at', 'is', null)
      
      const completedTests = testAttempts?.length || 0
      
      // Оновлюємо статистику
      await supabase
        .from('user_statistics')
        .upsert({
          user_id: userId,
          total_questions_answered: totalAnswered,
          correct_answers: correctAnswers,
          incorrect_answers: incorrectAnswers,
          average_percentage: averagePercentage,
          ratio_percentage: averagePercentage,
          total_tests: completedTests,
          completed_tests: completedTests,
          last_calculated_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }, {
          onConflict: 'user_id'
        })

    }
  } catch (error) {
    console.error('Error updating user statistics:', error)
    throw error
  }
}
