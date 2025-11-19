import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { supabase } from '@/lib/supabase'

async function getServerSession(request: NextRequest) {
  try {
    const token = await getToken({ 
      req: request,
      secret: process.env.NEXTAUTH_SECRET 
    })
    
    if (!token) {
      return null
    }

    return {
      user: {
        id: token.id as string,
        email: token.email as string,
        name: token.name as string,
        role: token.role as string,
      }
    }
  } catch (error) {
    console.error('Error getting session:', error)
    return null
  }
}

// Перевіряє чи користувач може відкрити наступний розділ (потрібно 80%+ на попередньому)
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(request)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

    const { searchParams } = new URL(request.url)
    const currentSectionSlug = searchParams.get('current_section')
    const targetSectionSlug = searchParams.get('target_section')

    if (!currentSectionSlug || !targetSectionSlug) {
      return NextResponse.json(
        { error: 'Параметри розділів обов\'язкові' },
        { status: 400 }
      )
    }

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    // Отримуємо курс
    const { data: course } = await supabase
      .from('courses')
      .select('id')
      .eq('title', 'Фундаментальні медико-біологічні знання')
      .single()

    if (!course) {
      return NextResponse.json({
        success: true,
        canAccess: true, // Якщо курс не знайдено, дозволяємо доступ
      })
    }

    // Отримуємо topic для поточного розділу
    const { data: currentTopic } = await supabase
      .from('topics')
      .select('id, title')
      .eq('course_id', course.id)
      .ilike('title', `%${currentSectionSlug.replace('section-', '')}%`)
      .single()

    if (!currentTopic) {
      return NextResponse.json({
        success: true,
        canAccess: true,
      })
    }

    // Перевіряємо прогрес користувача
    const { data: progress } = await supabase
      .from('user_topic_progress')
      .select('test_score, test_completed')
      .eq('user_id', session.user.id)
      .eq('topic_id', currentTopic.id)
      .single()

    // Якщо тест не пройдено або результат менше 80%, блокуємо доступ
    const canAccess = progress?.test_completed && (progress.test_score || 0) >= 80

    return NextResponse.json({
      success: true,
      canAccess,
      currentScore: progress?.test_score || 0,
      testCompleted: progress?.test_completed || false,
    })
  } catch (error) {
    console.error('Check access API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

