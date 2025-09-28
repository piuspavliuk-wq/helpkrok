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

// GET - Отримання конкретної папки
export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
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

    const { id } = await params;
    const { data: folder, error } = await supabase
      .from('user_folders')
      .select('*')
      .eq('id', id)
      .eq('user_id', session.user.id)
      .single();

    if (error) {
      console.error('Error fetching folder:', error);
      return NextResponse.json({ error: 'Folder not found' }, { status: 404 });
    }

    // Отримуємо кількість питань напряму
    const { data: questions } = await supabase
      .from('folder_questions')
      .select('id')
      .eq('folder_id', id)
      .eq('user_id', session.user.id);

    const folderWithCount = {
      ...folder,
      question_count: questions?.length || 0
    };

    return NextResponse.json({ folder: folderWithCount });
  } catch (error) {
    console.error('Error in GET /api/folders/[id]:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// DELETE - Видалення папки
export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
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

    const { id } = await params;
    // Спочатку видаляємо всі зв'язки з питаннями
    const { error: deleteQuestionsError } = await supabase
      .from('folder_questions')
      .delete()
      .eq('folder_id', id);

    if (deleteQuestionsError) {
      console.error('Error deleting folder questions:', deleteQuestionsError);
      return NextResponse.json({ error: 'Failed to delete folder questions' }, { status: 500 });
    }

    // Потім видаляємо саму папку
    const { error: deleteFolderError } = await supabase
      .from('user_folders')
      .delete()
      .eq('id', id)
      .eq('user_id', session.user.id);

    if (deleteFolderError) {
      console.error('Error deleting folder:', deleteFolderError);
      return NextResponse.json({ error: 'Failed to delete folder' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in DELETE /api/folders/[id]:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
