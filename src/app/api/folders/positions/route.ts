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

// PUT - Оновлення позицій папок
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

    const { folders } = await request.json();

    if (!folders || !Array.isArray(folders)) {
      return NextResponse.json({ error: 'Invalid folders data' }, { status: 400 });
    }

    // Оновлюємо позиції для всіх папок користувача
    const updates = folders.map((folder: { id: string; position: number }) => ({
      id: folder.id,
      position: folder.position
    }));

    // Виконуємо масове оновлення позицій
    for (const update of updates) {
      const { error } = await supabase
        .from('user_folders')
        .update({ position: update.position })
        .eq('id', update.id)
        .eq('user_id', session.user.id);

      if (error) {
        console.error('Error updating folder position:', error);
        return NextResponse.json({ error: 'Failed to update folder positions' }, { status: 500 });
      }
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in PUT /api/folders/positions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
