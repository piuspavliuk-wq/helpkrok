import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function PUT(request: NextRequest) {
  try {
    const body = await request.json()
    const { topic_id, video_progress, video_completed, test_completed, test_score } = body

    if (!topic_id) {
      return NextResponse.json(
        { error: 'ID теми обов\'язковий' },
        { status: 400 }
      )
    }

    // Отримуємо токен з cookies
    const token = request.cookies.get('auth-token')?.value
    
    if (!token) {
      return NextResponse.json(
        { error: 'Не автентифікований' },
        { status: 401 }
      )
    }

    // Тут має бути логіка валідації токена та отримання user_id
    // Для спрощення поки що використовуємо заглушку
    const userId = 'temp-user-id' // В реальному додатку це має бути з токена

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    // Перевіряємо чи існує запис прогресу
    const { data: existingProgress, error: fetchError } = await supabase
      .from('user_topic_progress')
      .select('*')
      .eq('user_id', userId)
      .eq('topic_id', topic_id)
      .single()

    const updateData = {
      video_progress: video_progress !== undefined ? video_progress : 0,
      video_completed: video_completed !== undefined ? video_completed : false,
      test_completed: test_completed !== undefined ? test_completed : false,
      test_score: test_score !== undefined ? test_score : null,
      last_accessed: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    }

    let result

    if (existingProgress) {
      // Оновлюємо існуючий запис
      const { data: updatedProgress, error: updateError } = await supabase
        .from('user_topic_progress')
        .update(updateData)
        .eq('id', existingProgress.id)
        .select()
        .single()

      if (updateError) {
        console.error('Error updating progress:', updateError)
        return NextResponse.json(
          { error: 'Помилка при оновленні прогресу' },
          { status: 500 }
        )
      }

      result = updatedProgress
    } else {
      // Створюємо новий запис
      const { data: newProgress, error: createError } = await supabase
        .from('user_topic_progress')
        .insert({
          user_id: userId,
          topic_id,
          ...updateData,
        })
        .select()
        .single()

      if (createError) {
        console.error('Error creating progress:', createError)
        return NextResponse.json(
          { error: 'Помилка при створенні запису прогресу' },
          { status: 500 }
        )
      }

      result = newProgress
    }

    return NextResponse.json({
      success: true,
      progress: result,
    })
  } catch (error) {
    console.error('Progress update error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const topicId = searchParams.get('topic_id')

    // Отримуємо токен з cookies
    const token = request.cookies.get('auth-token')?.value
    
    if (!token) {
      return NextResponse.json(
        { error: 'Не автентифікований' },
        { status: 401 }
      )
    }

    // Тут має бути логіка валідації токена та отримання user_id
    const userId = 'temp-user-id' // В реальному додатку це має бути з токена

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    let query = supabase
      .from('user_topic_progress')
      .select('*')
      .eq('user_id', userId)

    if (topicId) {
      query = query.eq('topic_id', topicId)
    }

    const { data: progress, error } = await query

    if (error) {
      console.error('Error fetching progress:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні прогресу' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      progress: topicId ? progress?.[0] || null : progress || [],
    })
  } catch (error) {
    console.error('Progress fetch error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
