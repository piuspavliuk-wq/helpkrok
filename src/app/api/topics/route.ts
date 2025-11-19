import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const courseId = searchParams.get('course_id')
    const title = searchParams.get('title')

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    let query = supabase
      .from('topics')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })

    if (courseId) {
      query = query.eq('course_id', courseId)
    }

    if (title) {
      query = query.eq('title', title)
    }

    const { data: topics, error } = await query

    if (error) {
      console.error('Error fetching topics:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні тем' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      topics: topics || [],
    })
  } catch (error) {
    console.error('Topics API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

