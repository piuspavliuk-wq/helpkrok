import { NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';

export async function GET() {
  try {
    const supabase = createSupabaseClientForServer();

    // Отримуємо питання
    const { data: questions, error: questionsError } = await supabase
      .from('krok_questions')
      .select('*')
      .order('question_number');

    if (questionsError) {
      console.error('Помилка отримання питань:', questionsError);
      return NextResponse.json(
        { error: 'Помилка отримання питань' },
        { status: 500 }
      );
    }

    // Отримуємо відповіді
    const { data: answers, error: answersError } = await supabase
      .from('krok_answers')
      .select('*')
      .order('question_id, answer_option');

    if (answersError) {
      console.error('Помилка отримання відповідей:', answersError);
      return NextResponse.json(
        { error: 'Помилка отримання відповідей' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      questions: questions || [],
      answers: answers || [],
      totalQuestions: questions?.length || 0
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
