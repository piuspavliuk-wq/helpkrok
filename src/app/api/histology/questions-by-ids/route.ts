import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const ids = searchParams.get('ids');
    
    if (!ids) {
      return NextResponse.json({ error: 'Missing ids parameter' }, { status: 400 });
    }
    
    const questionIds = ids.split(',').map(id => parseInt(id.trim())).filter(id => !isNaN(id));
    
    if (questionIds.length === 0) {
      return NextResponse.json({ questions: [] });
    }
    
    console.log('Fetching histology questions with IDs:', questionIds);
    
    const supabase = createSupabaseClientForServer();
    
    // Отримуємо питання за конкретними ID
    const { data: questions, error } = await supabase
      .from('histology_questions')
      .select('*')
      .in('id', questionIds);
    
    if (error) {
      console.error('Error fetching histology questions:', error);
      return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
    }
    
    console.log(`Found ${questions?.length || 0} histology questions`);
    
    return NextResponse.json({ questions: questions || [] });
  } catch (error) {
    console.error('Error in /api/histology/questions-by-ids:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}



