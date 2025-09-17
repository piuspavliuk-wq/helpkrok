import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty')
    const includeTopics = searchParams.get('include_topics') === 'true'

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    let query = supabase
      .from('courses')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })

    if (faculty && ['medical', 'pharmaceutical'].includes(faculty)) {
      query = query.eq('faculty', faculty)
    }

    const { data: courses, error } = await query

    if (error) {
      console.error('Error fetching courses:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні курсів' },
        { status: 500 }
      )
    }

    if (!includeTopics) {
      return NextResponse.json({
        success: true,
        courses: courses || [],
      })
    }

    // Якщо потрібно включити теми
    const coursesWithTopics = await Promise.all(
      (courses || []).map(async (course) => {
        const { data: topics, error: topicsError } = await supabase!
          .from('topics')
          .select('*')
          .eq('course_id', course.id)
          .eq('is_active', true)
          .order('order_index', { ascending: true })

        if (topicsError) {
          console.error('Error fetching topics:', topicsError)
          return { ...course, topics: [] }
        }

        return { ...course, topics: topics || [] }
      })
    )

    return NextResponse.json({
      success: true,
      courses: coursesWithTopics,
    })
  } catch (error) {
    console.error('Courses API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
