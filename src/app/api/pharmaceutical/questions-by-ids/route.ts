// API endpoint для отримання фармацевтичних питань за ID
// Файл: /api/pharmaceutical/questions-by-ids/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

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
    const idsParam = searchParams.get('ids');
    const subject = searchParams.get('subject');

    if (!idsParam) {
      return NextResponse.json(
        { error: 'Параметр ids обов\'язковий' },
        { status: 400 }
      );
    }

    const questionIds = idsParam.split(',');
    return await fetchQuestionsByIds(questionIds, subject || undefined);
  } catch (error) {
    console.error('Error in GET /api/pharmaceutical/questions-by-ids:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      );
    }

    const { questionIds, subject } = await request.json();

    if (!questionIds || !Array.isArray(questionIds)) {
      return NextResponse.json(
        { error: 'questionIds має бути масивом' },
        { status: 400 }
      );
    }

    return await fetchQuestionsByIds(questionIds, subject);
  } catch (error) {
    console.error('Error in POST /api/pharmaceutical/questions-by-ids:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

async function fetchQuestionsByIds(questionIds: string[], subject?: string) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json(
      { error: 'Supabase configuration missing' },
      { status: 500 }
    );
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  let query = supabase
    .from('pharmaceutical_questions')
    .select('*')
    .in('id', questionIds)
    .eq('is_active', true);

  // Додаємо фільтр за предметом, якщо вказано
  if (subject) {
    query = query.eq('subject', subject);
  }

  const { data: questions, error } = await query;

  if (error) {
    console.error('Error fetching pharmaceutical questions by IDs:', error);
    return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
  }

  // Сортуємо відповідно до порядку вказаних ID
  const sortedQuestions = questions?.sort((a, b) => {
    const indexA = questionIds.indexOf(a.id);
    const indexB = questionIds.indexOf(b.id);
    return indexA - indexB;
  }) || [];

  return NextResponse.json({
    success: true,
    questions: sortedQuestions,
    count: sortedQuestions.length
  });
}
