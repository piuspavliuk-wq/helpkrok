import { NextRequest, NextResponse } from 'next/server'
import { createSupabaseClientForServer } from '@/lib/supabase/server'

export async function GET(request: NextRequest) {
  try {
    const supabase = createSupabaseClientForServer()
    const { searchParams } = new URL(request.url)
    const limit = searchParams.get('limit')
    const system = searchParams.get('system')

    let query = supabase.from('pharmacy_knowledge_questions').select('*')

    if (system) query = query.eq('system', system)
    if (limit && parseInt(limit) < 1000) query = query.limit(parseInt(limit))

    const { data, error } = await query
    if (error) return NextResponse.json({ error: 'Database error: ' + error.message }, { status: 500 })

    return NextResponse.json({ questions: data || [] })
  } catch (error: any) {
    return NextResponse.json({ error: 'Internal server error: ' + error.message }, { status: 500 })
  }
}
