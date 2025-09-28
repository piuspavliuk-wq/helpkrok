// API endpoint для питань з фізіології
// Файл: /api/physiology/questions/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// GET - отримати всі питання з фізіології
export async function GET(req: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    return NextResponse.json({ error: 'Supabase configuration missing' }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseKey);
  try {
    const { data: questions, error } = await supabase
      .from('physiology_questions')
      .select('*')
      .order('id');

    if (error) {
      console.error('Error fetching physiology questions:', error);
      return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
    }
    
    // Перевіряємо на дублікати за ID
    if (questions) {
      const uniqueQuestions = questions.filter((question, index, self) => 
        index === self.findIndex(q => q.id === question.id)
      );
      
      return NextResponse.json({ questions: uniqueQuestions });
    }

    return NextResponse.json({ questions: [] });
  } catch (error) {
    console.error('Error in GET /api/physiology/questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
