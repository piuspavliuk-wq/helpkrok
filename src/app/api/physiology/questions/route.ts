import { NextRequest, NextResponse } from 'next/server'
import { createSupabaseClientForServer } from '@/lib/supabase/server'

export async function GET(request: NextRequest) {
  try {
    console.log('API: Starting physiology questions request')
    
    const supabase = createSupabaseClientForServer()
    console.log('API: Supabase client created')
    
    // Отримуємо параметри запиту
    const { searchParams } = new URL(request.url)
    const limit = searchParams.get('limit')
    const system = searchParams.get('system')
    const faculty = searchParams.get('faculty') || 'medical'
    
    console.log('API: Parameters:', { limit, system, faculty })
    
    // Будую запит
    let query = supabase
      .from('physiology_questions')
      .select('*')
      .eq('faculty', faculty)
    
    // Додаємо фільтри
    if (system) {
      query = query.eq('system', system)
    }
    
    // Додаємо ліміт тільки якщо він менший за загальну кількість
    if (limit && parseInt(limit) < 100) {
      query = query.limit(parseInt(limit))
    }
    
    console.log('API: Executing query...')
    const { data: questions, error } = await query
    
    if (error) {
      console.error('API: Supabase error:', error)
      return NextResponse.json({ error: 'Database error: ' + error.message }, { status: 500 })
    }
    
    console.log('API: Success, questions count:', questions?.length || 0)
    return NextResponse.json({ questions: questions || [] })
  } catch (error) {
    console.error('API: Unexpected error:', error)
    const errorMessage = error instanceof Error ? error.message : 'Unknown error'
    return NextResponse.json({ error: 'Internal server error: ' + errorMessage }, { status: 500 })
  }
}