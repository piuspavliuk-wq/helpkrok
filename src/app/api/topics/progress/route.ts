import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { supabase } from '@/lib/supabase'
import { createClient } from '@supabase/supabase-js'

// Функція для перевірки та автоматичного відкриття наступного курсу
async function checkAndUnlockNextCourse(userId: string, topicId: string) {
  try {
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

    if (!supabaseUrl || !supabaseKey) {
      console.error('Supabase credentials not configured')
      return
    }

    const adminSupabase = createClient(supabaseUrl, supabaseKey)

    // Отримуємо topic та курс
    const { data: topic } = await adminSupabase
      .from('topics')
      .select('id, course_id, course:courses(slug)')
      .eq('id', topicId)
      .single()

    if (!topic || !topic.course_id) {
      return
    }

    const courseSlug = (topic.course as any)?.slug
    if (!courseSlug) {
      return
    }

    // Визначаємо порядок курсів медичного факультету
    const medicalCourseOrder = [
      'fundamental-medico-biological-knowledge', // 1-й курс
      'blood-system-and-immunity', // 2-й курс
      'central-nervous-system' // 3-й курс
    ]

    const courseIndex = medicalCourseOrder.indexOf(courseSlug)
    
    // Якщо це останній курс або курс не знайдено, нічого не робимо
    if (courseIndex < 0 || courseIndex >= medicalCourseOrder.length - 1) {
      return
    }

    // Перевіряємо чи користувач має доступ до поточного курсу через підписку
    const { data: subscriptions } = await adminSupabase
      .from('user_subscriptions')
      .select('*')
      .eq('user_id', userId)
      .eq('status', 'active')
      .in('subscription_type', ['medical', 'premium'])
      .gte('end_date', new Date().toISOString())
      .limit(1)

    const hasSubscription = subscriptions && subscriptions.length > 0
    if (!hasSubscription) {
      return // Користувач не має підписки, не відкриваємо наступний курс
    }

    // Отримуємо всі topics поточного курсу
    const { data: allTopics } = await adminSupabase
      .from('topics')
      .select('id')
      .eq('course_id', topic.course_id)

    if (!allTopics || allTopics.length === 0) {
      return
    }

    // Отримуємо прогрес по всіх topics
    const { data: allProgress } = await adminSupabase
      .from('user_topic_progress')
      .select('test_score, test_completed')
      .eq('user_id', userId)
      .in('topic_id', allTopics.map(t => t.id))

    if (!allProgress || allProgress.length === 0) {
      return
    }

    // Перевіряємо чи всі тести пройдені на 80%+
    const allPassed = allProgress.every(p => 
      p.test_completed && (p.test_score || 0) >= 80
    )

    if (allPassed) {
      // Всі тести пройдені на 80%+, відкриваємо наступний курс
      const nextCourseId = medicalCourseOrder[courseIndex + 1]
      
      // Перевіряємо чи вже є доступ до наступного курсу
      const { data: existingAccess } = await adminSupabase
        .from('course_access')
        .select('*')
        .eq('user_id', userId)
        .eq('course_id', nextCourseId)
        .maybeSingle()

      if (!existingAccess) {
        // Створюємо доступ до наступного курсу
        const { error: courseAccessError } = await adminSupabase
          .from('course_access')
          .insert({
            user_id: userId,
            course_id: nextCourseId,
            access_granted: true,
            granted_at: new Date().toISOString()
          })

        if (courseAccessError && courseAccessError.code !== 'PGRST116') {
          console.error(`Помилка відкриття наступного курсу ${nextCourseId}:`, courseAccessError)
        } else {
          console.log(`✅ Автоматично відкрито наступний курс ${nextCourseId} для користувача ${userId}`)
        }
      }
    }
  } catch (error) {
    console.error('Помилка в checkAndUnlockNextCourse:', error)
  }
}

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

// GET - отримати прогрес користувача для topic
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
    const topicId = searchParams.get('topic_id')

    if (!topicId) {
      return NextResponse.json(
        { error: 'ID теми обов\'язковий' },
        { status: 400 }
      )
    }

    if (!supabase) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    const { data: progress, error } = await supabase
      .from('user_topic_progress')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('topic_id', topicId)
      .single()

    if (error && error.code !== 'PGRST116') { // PGRST116 = not found
      console.error('Error fetching progress:', error)
      return NextResponse.json(
        { error: 'Помилка при отриманні прогресу' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      progress: progress || null,
    })
  } catch (error) {
    console.error('Progress API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

// POST - зберегти результат тесту
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(request)
    
    if (!session?.user?.id) {
      console.error('No session or user ID')
      return NextResponse.json(
        { error: 'Необхідна авторизація', details: 'No session' },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { topic_id, score, total_questions, correct_answers } = body

    console.log('Saving progress:', { 
      userId: session.user.id, 
      topic_id, 
      score, 
      total_questions, 
      correct_answers 
    })

    if (!topic_id || score === undefined || !total_questions || correct_answers === undefined) {
      console.error('Missing required fields:', { topic_id, score, total_questions, correct_answers })
      return NextResponse.json(
        { error: 'Необхідні поля відсутні', details: 'Missing fields' },
        { status: 400 }
      )
    }

    if (!supabase) {
      console.error('Supabase client not available')
      return NextResponse.json(
        { error: 'База даних недоступна', details: 'No supabase client' },
        { status: 500 }
      )
    }

    // Оновлюємо або створюємо прогрес
    const progressData = {
      user_id: session.user.id,
      topic_id,
      test_completed: true,
      test_score: score,
      last_accessed: new Date().toISOString(),
    }

    console.log('Upserting progress:', progressData)

    const { data: progress, error: progressError } = await supabase
      .from('user_topic_progress')
      .upsert(progressData, {
        onConflict: 'user_id,topic_id'
      })
      .select()
      .single()

    if (progressError) {
      console.error('Error saving progress:', progressError)
      console.error('Error details:', JSON.stringify(progressError, null, 2))
      return NextResponse.json(
        { 
          error: 'Помилка при збереженні прогресу', 
          details: progressError.message,
          code: progressError.code 
        },
        { status: 500 }
      )
    }

    console.log('Progress saved successfully:', progress)

    // Зберігаємо спробу тесту (не критично, якщо не вдасться)
    const attemptData = {
      user_id: session.user.id,
      topic_id,
      attempt_type: 'topic_test',
      total_questions,
      correct_answers,
      score,
      time_spent: 0,
      completed_at: new Date().toISOString(),
    }

    const { error: attemptError } = await supabase
      .from('test_attempts')
      .insert(attemptData)

    if (attemptError) {
      console.error('Error saving test attempt (non-critical):', attemptError)
      // Не повертаємо помилку, бо прогрес вже збережено
    } else {
      console.log('Test attempt saved successfully')
    }

    // Перевіряємо чи потрібно автоматично відкрити наступний курс
    // (якщо користувач завершив попередній курс на 80%+)
    try {
      await checkAndUnlockNextCourse(session.user.id, topic_id)
    } catch (error) {
      console.error('Помилка перевірки/відкриття наступного курсу:', error)
      // Не повертаємо помилку, бо прогрес вже збережено
    }

    return NextResponse.json({
      success: true,
      progress,
    })
  } catch (error) {
    console.error('Save progress API error:', error)
    console.error('Error stack:', error instanceof Error ? error.stack : 'No stack')
    return NextResponse.json(
      { 
        error: 'Внутрішня помилка сервера',
        details: error instanceof Error ? error.message : 'Unknown error'
      },
      { status: 500 }
    )
  }
}

