import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getToken } from 'next-auth/jwt';

async function getServerSession(request: NextRequest) {
  try {
    const token = await getToken({ 
      req: request,
      secret: process.env.NEXTAUTH_SECRET 
    });
    
    if (!token) {
      return null;
    }

    return {
      user: {
        id: token.id as string,
        email: token.email as string,
        name: token.name as string,
        role: token.role as string,
      }
    };
  } catch (error) {
    console.error('Error getting session:', error);
    return null;
  }
}

// GET - Отримання питань з папки
export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(request.url);
    const folderId = searchParams.get('folderId');
    const questionType = searchParams.get('questionType');
    const limit = parseInt(searchParams.get('limit') || '50');
    const offset = parseInt(searchParams.get('offset') || '0');

    if (!folderId) {
      return NextResponse.json({ error: 'Folder ID is required' }, { status: 400 });
    }

    // Перевіряємо, чи папка належить користувачу
    const { data: folder, error: folderError } = await supabase
      .from('user_folders')
      .select('id')
      .eq('id', folderId)
      .eq('user_id', session.user.id)
      .single();

    if (folderError || !folder) {
      return NextResponse.json({ error: 'Folder not found' }, { status: 404 });
    }

    // Отримуємо питання з папки
    console.log('Fetching questions for folder:', folderId, 'user:', session.user.id);
    const { data: folderQuestions, error: questionsError } = await supabase
      .from('folder_questions')
      .select(`
        question_id,
        question_type,
        added_at
      `)
      .eq('folder_id', folderId)
      .eq('user_id', session.user.id)
      .order('added_at', { ascending: false })
      .range(offset, offset + limit - 1);


    if (questionsError) {
      console.error('Error fetching folder questions:', questionsError);
      return NextResponse.json({ error: 'Failed to fetch folder questions' }, { status: 500 });
    }

    // Отримуємо повні дані питань з відповідних таблиць
    const questions = [];
    for (const fq of folderQuestions) {
      let questionData = null;
      
      if (fq.question_type === 'anatomy') {
        const { data } = await supabase
          .from('anatomy_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'histology') {
        const { data } = await supabase
          .from('histology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'krok') {
        const { data } = await supabase
          .from('krok_questions_unified')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'physiology') {
        const { data } = await supabase
          .from('physiology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'biology') {
        const { data } = await supabase
          .from('biology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'microbiology') {
        const { data } = await supabase
          .from('microbiology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'pathology') {
        const { data } = await supabase
          .from('pathology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'pathophysiology') {
        const { data } = await supabase
          .from('pathophysiology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      } else if (fq.question_type === 'pharmacology') {
        const { data } = await supabase
          .from('pharmacology_questions')
          .select('*')
          .eq('id', fq.question_id)
          .single();
        questionData = data;
      }

      if (questionData) {
        // Форматуємо дані для відображення
        let formattedQuestion;
        
        if (fq.question_type === 'krok') {
          // Для КРОК питань використовуємо спеціальний формат
          formattedQuestion = {
            id: questionData.id,
            question_text: questionData.question_text,
            year: questionData.year,
            faculty: questionData.faculty,
            category: questionData.category,
            difficulty: questionData.difficulty,
            option_a: questionData.option_a,
            option_b: questionData.option_b,
            option_c: questionData.option_c,
            option_d: questionData.option_d,
            option_e: questionData.option_e,
            correct_answer: questionData.correct_answer,
            explanation_text: questionData.explanation_text,
            reference_text: questionData.reference_text,
            // Форматуємо варіанти відповідей у формат, очікуваний компонентами
            options: [
              { letter: 'A', text: questionData.option_a || '', is_correct: questionData.correct_answer === 'A' },
              { letter: 'B', text: questionData.option_b || '', is_correct: questionData.correct_answer === 'B' },
              { letter: 'C', text: questionData.option_c || '', is_correct: questionData.correct_answer === 'C' },
              { letter: 'D', text: questionData.option_d || '', is_correct: questionData.correct_answer === 'D' },
              { letter: 'E', text: questionData.option_e || '', is_correct: questionData.correct_answer === 'E' }
            ].filter(option => option.text.trim() !== ''), // Видаляємо порожні варіанти
            question_type: fq.question_type,
            created_at: fq.added_at
          };
        } else {
          // Для інших типів питань (анатомія, гістологія, фізіологія)
          formattedQuestion = {
            id: questionData.id,
            question_text: questionData.question_text || questionData.question,
            options: questionData.options || [
              questionData.option_a,
              questionData.option_b,
              questionData.option_c,
              questionData.option_d,
              questionData.option_e
            ].filter(Boolean),
            correct_answer: questionData.correct_answer,
            explanation: questionData.explanation,
            question_type: fq.question_type,
            created_at: fq.added_at
          };
        }
        
        questions.push(formattedQuestion);
      }
    }

    return NextResponse.json({ questions });
  } catch (error) {
    console.error('Error in GET /api/folders/questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// POST - Додавання питання до папки
export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { folderId, questionType, questionId } = await request.json();

    if (!folderId || !questionType || !questionId) {
      return NextResponse.json({ 
        error: 'Folder ID, question type, and question ID are required' 
      }, { status: 400 });
    }

    // Перевіряємо, чи папка належить користувачу
    const { data: folder, error: folderError } = await supabase
      .from('user_folders')
      .select('id')
      .eq('id', folderId)
      .eq('user_id', session.user.id)
      .single();

    if (folderError || !folder) {
      return NextResponse.json({ error: 'Folder not found' }, { status: 404 });
    }

    // Додаємо питання до папки
    console.log('Adding question to folder:', { folderId, questionType, questionId, userId: session.user.id });
    const { data, error } = await supabase
      .from('folder_questions')
      .insert({
        folder_id: folderId,
        question_type: questionType,
        question_id: questionId,
        user_id: session.user.id
      })
      .select()
      .single();

    if (error) {
      console.error('Error adding question to folder:', error);
      if (error.code === '23505') {
        return NextResponse.json({ error: 'Question already exists in this folder' }, { status: 409 });
      }
      return NextResponse.json({ error: 'Failed to add question to folder' }, { status: 500 });
    }

    return NextResponse.json({ success: true, data });
  } catch (error) {
    console.error('Error in POST /api/folders/questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// DELETE - Видалення питання з папки
export async function DELETE(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { folderId, questionType, questionId } = await request.json();

    if (!folderId || !questionType || !questionId) {
      return NextResponse.json({ 
        error: 'Folder ID, question type, and question ID are required' 
      }, { status: 400 });
    }

    // Перевіряємо, чи папка належить користувачу
    const { data: folder, error: folderError } = await supabase
      .from('user_folders')
      .select('id')
      .eq('id', folderId)
      .eq('user_id', session.user.id)
      .single();

    if (folderError || !folder) {
      return NextResponse.json({ error: 'Folder not found' }, { status: 404 });
    }

    // Видаляємо питання з папки
    const { error } = await supabase
      .from('folder_questions')
      .delete()
      .eq('folder_id', folderId)
      .eq('question_type', questionType)
      .eq('question_id', questionId);

    if (error) {
      console.error('Error removing question from folder:', error);
      return NextResponse.json({ error: 'Failed to remove question from folder' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in DELETE /api/folders/questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}