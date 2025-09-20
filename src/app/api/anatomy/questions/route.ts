// API endpoint для питань з анатомії
// Файл: /api/anatomy/questions/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// GET - отримати всі питання з анатомії
export async function GET(req: NextRequest) {
  try {
    const { data: questions, error } = await supabase
      .from('anatomy_questions')
      .select('*')
      .order('id');

    if (error) {
      console.error('Error fetching anatomy questions:', error);
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
    console.error('Error in GET /api/anatomy/questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}