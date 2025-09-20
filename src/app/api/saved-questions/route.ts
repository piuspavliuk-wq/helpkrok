// Універсальний API endpoint для збережених питань
// Файл: /api/saved-questions/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// GET - отримати збережені питання користувача
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const questionType = searchParams.get('type'); // anatomy, histology, krok, etc.

    let query = supabase
      .from('user_saved_questions')
      .select('*')
      .eq('user_id', session.user.id)
      .order('saved_at', { ascending: false });

    if (questionType) {
      query = query.eq('question_type', questionType);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching saved questions:', error);
      return NextResponse.json({ error: 'Failed to fetch saved questions' }, { status: 500 });
    }

    return NextResponse.json({ savedQuestions: data || [] });
  } catch (error) {
    console.error('Error in GET /api/saved-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// POST - зберегти питання
export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { questionType, questionId, notes } = await req.json();

    if (!questionType || !questionId) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    // Перевіряємо чи не збережено вже це питання
    const { data: existing } = await supabase
      .from('user_saved_questions')
      .select('id')
      .eq('user_id', session.user.id)
      .eq('question_type', questionType)
      .eq('question_id', questionId)
      .single();

    if (existing) {
      return NextResponse.json({ error: 'Question already saved' }, { status: 409 });
    }

    const { data, error } = await supabase
      .from('user_saved_questions')
      .insert({
        user_id: session.user.id,
        question_type: questionType,
        question_id: questionId,
        notes: notes || null
      })
      .select()
      .single();

    if (error) {
      console.error('Error saving question:', error);
      return NextResponse.json({ error: 'Failed to save question' }, { status: 500 });
    }

    return NextResponse.json({ success: true, savedQuestion: data });
  } catch (error) {
    console.error('Error in POST /api/saved-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// DELETE - видалити збережене питання
export async function DELETE(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const questionType = searchParams.get('type');
    const questionId = searchParams.get('questionId');

    if (!questionType || !questionId) {
      return NextResponse.json({ error: 'Missing required parameters' }, { status: 400 });
    }

    const { error } = await supabase
      .from('user_saved_questions')
      .delete()
      .eq('user_id', session.user.id)
      .eq('question_type', questionType)
      .eq('question_id', questionId);

    if (error) {
      console.error('Error deleting saved question:', error);
      return NextResponse.json({ error: 'Failed to delete saved question' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in DELETE /api/saved-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
