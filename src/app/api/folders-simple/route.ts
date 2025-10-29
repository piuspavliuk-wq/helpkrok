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

// GET - Отримання папок користувача (спрощена версія)
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

    console.log('GET /api/folders-simple called for user:', session.user.id);

    // Отримуємо папки користувача
    const { data: folders, error } = await supabase
      .from('user_folders')
      .select('*')
      .eq('user_id', session.user.id)
      .order('created_at', { ascending: false });

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

    console.log('Returning folders:', foldersWithStats.length);
    return NextResponse.json({ folders: foldersWithStats });
  } catch (error) {
    console.error('Error in GET /api/folders-simple:', error);
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
    const session = await getServerSession(request);
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    console.log('POST /api/folders-simple called for user:', session.user.id);

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
          password: 'nextauth_user',
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

    // Створюємо папку
    const { data, error } = await supabase
      .from('user_folders')
      .insert({
        user_id: session.user.id,
        name: name.trim(),
        description: description?.trim() || '',
        color: color || '#3B82F6'
      })
      .select()
      .single();

    if (error) {
      console.error('Error creating folder:', error);
      return NextResponse.json({ error: 'Failed to create folder' }, { status: 500 });
    }

    console.log('Folder created successfully:', data.id);
    return NextResponse.json({ folder: data });
  } catch (error) {
    console.error('Error in POST /api/folders-simple:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
