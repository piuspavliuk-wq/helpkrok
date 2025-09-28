// Універсальний API endpoint для збережених питань
// Файл: /api/saved-questions/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// GET - отримати збережені питання користувача
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    console.log('GET /api/saved-questions session:', session);
    
    if (!session?.user?.id) {
      console.log('No user ID found in GET, returning 401');
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const questionType = searchParams.get('type'); // anatomy, histology, krok, etc.
    console.log('Question type:', questionType);

    // Визначаємо правильну таблицю залежно від типу питання
    const tableName = 'user_saved_questions'; // Використовуємо універсальну таблицю для всіх типів
    console.log('Using table:', tableName);
    
    const supabase = createSupabaseClientForServer();
    
    let query = supabase
      .from(tableName)
      .select('*')
      .eq('user_id', session.user.id)
      .order('saved_at', { ascending: false });

    if (questionType) {
      query = query.eq('question_type', questionType);
    }

    const { data, error } = await query;
    console.log('Query result:', { data, error });

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
    console.log('Session in POST:', session);
    console.log('User ID:', session?.user?.id);
    
    if (!session?.user?.id) {
      console.log('No session or user ID, returning 401');
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { questionType, questionId, notes } = await req.json();
    console.log('POST request data:', { questionType, questionId, notes });

    if (!questionType || !questionId) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    // Визначаємо правильну таблицю залежно від типу питання
    const tableName = 'user_saved_questions'; // Використовуємо універсальну таблицю для всіх типів
    
    const supabase = createSupabaseClientForServer();
    
    // Перевіряємо чи не збережено вже це питання
    const { data: existing } = await supabase
      .from(tableName)
      .select('id')
      .eq('user_id', session.user.id)
      .eq('question_id', questionId)
      .single();

    if (existing) {
      return NextResponse.json({ error: 'Question already saved' }, { status: 409 });
    }

    const insertData: any = {
      user_id: session.user.id,
      question_id: questionId,
      notes: notes || null
    };

    // Для всіх питань додаємо question_type (включаючи КРОК)
    insertData.question_type = questionType;

    console.log('Insert data:', insertData);
    const { data, error } = await supabase
      .from(tableName)
      .insert(insertData)
      .select()
      .single();

    console.log('Insert result:', { data, error });

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
    const savedQuestionId = searchParams.get('savedQuestionId'); // ID запису в таблиці збережених питань
    const deleteAll = searchParams.get('deleteAll'); // Параметр для видалення всіх питань

    const supabase = createSupabaseClientForServer();

    // Якщо deleteAll=true, видаляємо всі збережені питання користувача
    if (deleteAll === 'true') {
      // Видаляємо з універсальної таблиці
      const { error: deleteAllError } = await supabase
        .from('user_saved_questions')
        .delete()
        .eq('user_id', session.user.id);

      if (deleteAllError) {
        console.error('Error deleting all saved questions:', deleteAllError);
        return NextResponse.json({ error: 'Failed to delete all saved questions' }, { status: 500 });
      }

      // Також видаляємо з таблиці КРОК питань
      const { error: deleteKrokError } = await supabase
        .from('user_saved_krok_questions')
        .delete()
        .eq('user_id', session.user.id);

      if (deleteKrokError) {
        console.error('Error deleting KROK saved questions:', deleteKrokError);
        // Не повертаємо помилку, оскільки основна таблиця вже очищена
      }

      return NextResponse.json({ 
        success: true, 
        message: 'Всі збережені питання видалено' 
      });
    }

    // Звичайна логіка видалення одного питання
    if (!questionType || !questionId) {
      return NextResponse.json({ error: 'Missing required parameters' }, { status: 400 });
    }

    // Визначаємо правильну таблицю залежно від типу питання
    const tableName = 'user_saved_questions'; // Використовуємо універсальну таблицю для всіх типів
    
    let deleteQuery = supabase
      .from(tableName)
      .delete()
      .eq('user_id', session.user.id);

    // Якщо є savedQuestionId, видаляємо конкретний запис
    if (savedQuestionId) {
      deleteQuery = deleteQuery.eq('id', savedQuestionId);
    } else {
      // Інакше видаляємо по question_id (стара логіка)
      deleteQuery = deleteQuery.eq('question_id', questionId);
    // Для всіх питань додаємо фільтр по question_type
    if (questionType) {
      deleteQuery = deleteQuery.eq('question_type', questionType);
    }
    }

    const { error } = await deleteQuery;

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
