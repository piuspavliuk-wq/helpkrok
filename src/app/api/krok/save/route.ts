import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// Перевірити, чи збережено питання користувачем
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json({
        success: true,
        isSaved: false,
        message: 'Необхідна авторизація для перевірки статусу збереження'
      });
    }

    const { searchParams } = new URL(request.url);
    const questionId = searchParams.get('questionId');

    if (!questionId) {
      return NextResponse.json(
        { error: 'ID питання обов\'язковий' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseClientForServer();

    // Перевіряємо, чи збережено питання
    const { data: savedQuestion, error } = await supabase
      .from('user_saved_krok_questions')
      .select('id, saved_at, notes')
      .eq('user_id', session.user.id)
      .eq('question_id', questionId)
      .single();

    if (error && error.code !== 'PGRST116') { // PGRST116 = no rows returned
      console.error('Помилка перевірки статусу збереження:', error);
      return NextResponse.json(
        { error: 'Помилка перевірки статусу збереження' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      isSaved: !!savedQuestion,
      savedQuestion: savedQuestion || null
    });

  } catch (error) {
    console.error('Помилка API:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
