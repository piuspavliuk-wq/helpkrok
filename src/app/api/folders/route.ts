import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { getToken } from 'next-auth/jwt';

// Кеш для папок (в пам'яті)
const foldersCache = new Map<string, { data: any; timestamp: number }>();
const CACHE_DURATION = 5 * 60 * 1000; // 5 хвилин

async function getServerSession(request: NextRequest) {
  try {
    // Отримуємо токен з cookies
    const token = await getToken({ 
      req: request,
      secret: process.env.NEXTAUTH_SECRET 
    });
    
    if (!token) {
      console.log('No token found');
      return null;
    }

    console.log('Token found:', { id: token.id, email: token.email });

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

// GET - Отримання папок користувача
export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('GET /api/folders called');
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      console.log('No session found, returning 401');
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    console.log('Session found for user:', session.user.id);

    // Перевіряємо чи існує користувач в таблиці users
    const { data: existingUser, error: userError } = await supabase
      .from('users')
      .select('id')
      .eq('id', session.user.id)
      .single();

    if (userError && userError.code === 'PGRST116') {
      // Користувач не існує, створюємо його
      console.log('Creating user in database:', session.user.id);
      const { error: createUserError } = await supabase
        .from('users')
        .insert({
          id: session.user.id,
          first_name: session.user.name?.split(' ')[0] || 'User',
          last_name: session.user.name?.split(' ').slice(1).join(' ') || '',
          email: session.user.email,
          password: 'nextauth_user', // Пароль для NextAuth користувачів
          role: 'student'
        });

      if (createUserError) {
        console.error('Error creating user:', createUserError);
        return NextResponse.json({ error: 'Failed to create user' }, { status: 500 });
      }
    } else if (userError) {
      console.error('Error checking user:', userError);
      return NextResponse.json({ error: 'Failed to check user' }, { status: 500 });
    }

    const { data: folders, error } = await supabase
      .from('user_folders')
      .select(`
        *,
        folder_questions(count)
      `)
      .eq('user_id', session.user.id)
      .order('position', { ascending: true });

    if (error) {
      console.error('Error fetching folders:', error);
      return NextResponse.json({ error: 'Failed to fetch folders' }, { status: 500 });
    }

    // Додаємо статистику питань для кожної папки
    const foldersWithStats = await Promise.all(
      folders.map(async (folder) => {
        // Отримуємо статистику напряму з таблиці folder_questions
        const { data: questions } = await supabase
          .from('folder_questions')
          .select('question_type')
          .eq('folder_id', folder.id)
          .eq('user_id', session.user.id);
        
        const stats = {
          total_questions: questions?.length || 0,
          krok_questions: questions?.filter(q => q.question_type === 'krok').length || 0,
          anatomy_questions: questions?.filter(q => q.question_type === 'anatomy').length || 0,
          histology_questions: questions?.filter(q => q.question_type === 'histology').length || 0,
          pharmaceutical_questions: questions?.filter(q => q.question_type === 'pharmaceutical').length || 0
        };
        
        return {
          ...folder,
          stats
        };
      })
    );

    return NextResponse.json({ folders: foldersWithStats });
  } catch (error) {
    console.error('Error in GET /api/folders:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}


// POST - Створення нової папки
export async function POST(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('POST /api/folders called');
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      console.log('No session found for POST, returning 401');
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    console.log('Session found for POST user:', session.user.id);

    // Перевіряємо чи існує користувач в таблиці users
    const { data: existingUser, error: userError } = await supabase
      .from('users')
      .select('id')
      .eq('id', session.user.id)
      .single();

    if (userError && userError.code === 'PGRST116') {
      // Користувач не існує, створюємо його
      console.log('Creating user in database:', session.user.id);
      const { error: createUserError } = await supabase
        .from('users')
        .insert({
          id: session.user.id,
          first_name: session.user.name?.split(' ')[0] || 'User',
          last_name: session.user.name?.split(' ').slice(1).join(' ') || '',
          email: session.user.email,
          password: 'nextauth_user', // Пароль для NextAuth користувачів
          role: 'student'
        });

      if (createUserError) {
        console.error('Error creating user:', createUserError);
        return NextResponse.json({ error: 'Failed to create user' }, { status: 500 });
      }
    } else if (userError) {
      console.error('Error checking user:', userError);
      return NextResponse.json({ error: 'Failed to check user' }, { status: 500 });
    }

    const { name, description, color } = await request.json();

    if (!name || name.trim().length === 0) {
      return NextResponse.json({ error: 'Folder name is required' }, { status: 400 });
    }

    const { data: folder, error } = await supabase
      .from('user_folders')
      .insert({
        user_id: session.user.id,
        name: name.trim(),
        description: description?.trim() || null,
        color: color || '#3B82F6'
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating folder:', error);
      if (error.code === '23505') {
        return NextResponse.json({ error: 'Folder with this name already exists' }, { status: 409 });
      }
      return NextResponse.json({ error: 'Failed to create folder' }, { status: 500 });
    }

    return NextResponse.json({ folder });
  } catch (error) {
    console.error('Error in POST /api/folders:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// PUT - Оновлення папки
export async function PUT(request: NextRequest) {
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

    const { id, name, description, color } = await request.json();

    if (!id) {
      return NextResponse.json({ error: 'Folder ID is required' }, { status: 400 });
    }

    const { data: folder, error } = await supabase
      .from('user_folders')
      .update({
        name: name?.trim(),
        description: description?.trim() || null,
        color: color
      })
      .eq('id', id)
      .eq('user_id', session.user.id)
      .select()
      .single();

    if (error) {
      console.error('Error updating folder:', error);
      return NextResponse.json({ error: 'Failed to update folder' }, { status: 500 });
    }

    if (!folder) {
      return NextResponse.json({ error: 'Folder not found' }, { status: 404 });
    }

    return NextResponse.json({ folder });
  } catch (error) {
    console.error('Error in PUT /api/folders:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

// DELETE - Видалення папки
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

    const { searchParams } = new URL(request.url);
    const folderId = searchParams.get('id');

    if (!folderId) {
      return NextResponse.json({ error: 'Folder ID is required' }, { status: 400 });
    }

    const { error } = await supabase
      .from('user_folders')
      .delete()
      .eq('id', folderId)
      .eq('user_id', session.user.id);

    if (error) {
      console.error('Error deleting folder:', error);
      return NextResponse.json({ error: 'Failed to delete folder' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in DELETE /api/folders:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
