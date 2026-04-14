import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { createClient } from '@supabase/supabase-js'

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
    const courseId = searchParams.get('course_id')

    if (!courseId) {
      return NextResponse.json(
        { error: 'course_id обов\'язковий' },
        { status: 400 }
      )
    }

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    const supabase = createClient(supabaseUrl, supabaseKey)

    const isUuid = (v: string) =>
      /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(v)

    // Якщо courseId = slug (як у фронті), а payments.package_id зберігає UUID courses.id,
    // то без цього резолву доступ "не знаходиться".
    const slugToTitle: Record<string, string> = {
      'fundamental-medico-biological-knowledge': 'Фундаментальні медико-біологічні знання',
      'blood-system-and-immunity': 'Система кровотворення й імунного захисту, кров',
      'central-nervous-system': 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття',
      'integumentary-system': 'Покривна система',
      'musculoskeletal-system': "Опорно-руховий апарат",
      'respiratory-system': 'Дихальна система',
      'cardiovascular-system': 'Серцево-судинна система',
      'digestive-system': 'Травна система',
      'urinary-system': 'Сечовидільна система',
      'reproductive-system': 'Статева система',
      'endocrine-system': 'Ендокринна система'
    }

    // Нормалізуємо ідентифікатор курсу:
    // - фронт часто передає UUID (courses.id)
    // - платежі / course_access в багатьох місцях використовують slug як ідентифікатор курсу
    let normalizedCourseId = courseId
    let normalizedCourseFaculty: 'medical' | 'pharmaceutical' | null = null
    let resolvedCourseUuid: string | null = null
    try {
      const { data: courseRow } = await supabase
        .from('courses')
        .select('id, slug, faculty, title')
        .eq('id', courseId)
        .maybeSingle()

      if (courseRow?.slug) {
        normalizedCourseId = courseRow.slug
      }
      if (courseRow?.faculty) {
        normalizedCourseFaculty = courseRow.faculty as 'medical' | 'pharmaceutical'
      }
      if (courseRow?.id) {
        resolvedCourseUuid = courseRow.id
      }
    } catch {
      // Якщо таблиця не має slug або courseId не UUID — ігноруємо, працюємо як є
    }

    // Якщо нам передали slug, спробуємо знайти UUID курсу по title (бо slug може не існувати в БД).
    if (!resolvedCourseUuid && !isUuid(courseId)) {
      const title = slugToTitle[courseId]
      if (title) {
        const { data: courseByTitle } = await supabase
          .from('courses')
          .select('id, faculty')
          .eq('title', title)
          .maybeSingle()

        if (courseByTitle?.id) {
          resolvedCourseUuid = courseByTitle.id
        }
        if (courseByTitle?.faculty && !normalizedCourseFaculty) {
          normalizedCourseFaculty = courseByTitle.faculty as 'medical' | 'pharmaceutical'
        }
      }
    }

    const packageIdCandidates = Array.from(
      new Set([courseId, normalizedCourseId, resolvedCourseUuid].filter(Boolean))
    ) as string[]

    // Перевіряємо чи є успішний платіж за курс
    const { data: payment, error: paymentError } = await supabase
      .from('payments')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('payment_type', 'course')
      // В БД можуть використовуватись як UUID courses.id, так і slug як package_id.
      // Тому перевіряємо обидва варіанти.
      .in('package_id', packageIdCandidates)
      .eq('status', 'success')
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle()

    if (paymentError && paymentError.code !== 'PGRST116') {
      console.error('Помилка перевірки платежу:', paymentError)
    }

    const hasPaymentAccess = !!payment

    // Також перевіряємо чи є успішний платіж за підписку (subscription)
    // Якщо користувач оплатив підписку, він має доступ до всіх курсів
    const { data: subscriptionPayment } = await supabase
      .from('payments')
      .select('*')
      .eq('user_id', session.user.id)
      .eq('payment_type', 'subscription')
      .eq('status', 'success')
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle()

    const hasSubscriptionPayment = !!subscriptionPayment

    // Перевіряємо також через таблицю course_access якщо вона існує
    let courseAccess = null
    try {
      const { data: access, error: accessError } = await supabase
        .from('course_access')
        .select('*')
        .eq('user_id', session.user.id)
        // В course_access може бути або UUID courses.id, або slug.
        .in('course_id', packageIdCandidates)
        .eq('access_granted', true)
        .maybeSingle()

      if (!accessError) {
        courseAccess = access
      }
    } catch (error) {
      // Таблиця може не існувати, це нормально
    }

    // Визначаємо факультет курсу
    // Оскільки courseId - це рядок типу 'fundamental-medico-biological-knowledge', 
    // а не UUID, визначаємо факультет за списком курсів
    const medicalCourses = ['fundamental-medico-biological-knowledge', 'blood-system-and-immunity', 'central-nervous-system', 'integumentary-system', 'musculoskeletal-system', 'respiratory-system', 'cardiovascular-system', 'digestive-system', 'urinary-system', 'reproductive-system', 'endocrine-system']
    const pharmaceuticalCourses = ['organic-compounds-basics', 'pharmaceutical-analysis-theory', 'physical-physicochemical-basics', 'pharmaceutical-botany', 'pathological-processes', 'biochemical-processes', 'infectious-disease-agents', 'rational-drug-use']
    
    let courseFaculty: 'medical' | 'pharmaceutical' | null = null
    
    if (normalizedCourseFaculty) {
      courseFaculty = normalizedCourseFaculty
    } else if (medicalCourses.includes(normalizedCourseId)) {
      courseFaculty = 'medical'
    } else if (pharmaceuticalCourses.includes(normalizedCourseId)) {
      courseFaculty = 'pharmaceutical'
    }
    
    // Якщо не вдалося визначити за списком, намагаємося знайти в базі даних
    if (!courseFaculty) {
      try {
        // Шукаємо курс за id (якщо courseId це UUID) або за title
        const { data: course } = await supabase
          .from('courses')
          .select('faculty')
          .or(`id.eq.${courseId},title.ilike.%${normalizedCourseId}%`)
          .maybeSingle()

        if (course?.faculty) {
          courseFaculty = course.faculty as 'medical' | 'pharmaceutical'
        }
      } catch (error) {
        console.error('Помилка визначення факультету курсу:', error)
      }
    }

    // Перевіряємо активні підписки залежно від факультету курсу
    let hasSubscriptionAccess = false
    try {
      // Визначаємо які типи підписок перевіряти
      const subscriptionTypes: string[] = ['premium'] // Premium дає доступ до всіх
      
      if (courseFaculty === 'medical') {
        subscriptionTypes.push('medical')
      } else if (courseFaculty === 'pharmaceutical') {
        subscriptionTypes.push('pharmaceutical')
      } else {
        // Якщо не вдалося визначити факультет, перевіряємо всі типи
        subscriptionTypes.push('medical', 'pharmaceutical')
      }

      const { data: subscriptions, error: subscriptionError } = await supabase
        .from('user_subscriptions')
        .select('*')
        .eq('user_id', session.user.id)
        .eq('status', 'active')
        .in('subscription_type', subscriptionTypes)
        .gte('end_date', new Date().toISOString()) // Підписка ще не закінчилася
        .order('created_at', { ascending: false })
        .limit(1)

      console.log('Перевірка підписок для користувача:', session.user.id, {
        courseFaculty,
        subscriptionTypes,
        subscriptions,
        subscriptionError,
        hasAccess: !subscriptionError && subscriptions && subscriptions.length > 0
      })

      if (!subscriptionError && subscriptions && subscriptions.length > 0) {
        hasSubscriptionAccess = true
      }
    } catch (error) {
      console.error('Помилка перевірки підписок:', error)
    }

    // Перевіряємо чи користувач має базовий доступ (оплату підписки)
    const hasBaseAccess = hasPaymentAccess || !!courseAccess || hasSubscriptionAccess || hasSubscriptionPayment

    // Якщо доступ явно виданий через course_access — не перевіряємо попередній курс повторно
    // (course_access створюється лише після успішного завершення попереднього курсу)
    if (courseAccess) {
      return NextResponse.json({
        success: true,
        hasAccess: true,
        paymentId: payment?.id || null,
        grantedAt: courseAccess.granted_at || payment?.created_at || null,
        accessType: 'access',
        debug: {
          normalizedCourseId,
          resolvedCourseUuid,
          packageIdCandidates,
          hasPaymentAccess,
          hasCourseAccess: true,
          hasSubscriptionAccess,
          hasSubscriptionPayment
        }
      })
    }

    // Якщо є базовий доступ, перевіряємо чи потрібно пройти попередній курс
    if (hasBaseAccess) {
      // Визначаємо порядок курсів залежно від факультету
      const medicalCourseOrder = [
        'fundamental-medico-biological-knowledge',
        'blood-system-and-immunity',
        'central-nervous-system',
        'integumentary-system',
        'musculoskeletal-system',
        'respiratory-system',
        'cardiovascular-system',
        'digestive-system',
        'urinary-system',
        'reproductive-system',
        'endocrine-system'
      ]
      
      const pharmaceuticalCourseOrder = [
        'organic-compounds-basics',
        'pharmaceutical-analysis-theory',
        'physical-physicochemical-basics',
        'pharmaceutical-botany',
        'pathological-processes',
        'biochemical-processes',
        'infectious-disease-agents',
        'rational-drug-use'
      ]
      
      const courseOrder = courseFaculty === 'pharmaceutical' ? pharmaceuticalCourseOrder : medicalCourseOrder
      const courseIndex = courseOrder.indexOf(normalizedCourseId)
      
      // Якщо це не перший курс, перевіряємо чи пройдено попередній на 80%+
      // Поки що перевірка попередніх курсів працює тільки для медицини
      if (courseIndex > 0 && courseFaculty === 'medical') {
        const previousCourseId = courseOrder[courseIndex - 1]
        
        try {
          // Перевіряємо прогрес попереднього курсу
          const { data: previousCourse } = await supabase
            .from('courses')
            .select('id')
            .eq('slug', previousCourseId)
            .maybeSingle()

          if (previousCourse) {
            // Отримуємо всі topics попереднього курсу + відсікаємо ті, де немає питань
            const { data: topics } = await supabase
              .from('topics')
              .select('id, questions:questions(count)')
              .eq('course_id', previousCourse.id)

            const topicsWithTests = (topics || []).filter((t: any) => Number(t.questions?.[0]?.count ?? 0) > 0)

            if (topicsWithTests.length > 0) {
              // Отримуємо прогрес по всіх topics
              const { data: allProgress } = await supabase
                .from('user_topic_progress')
                .select('test_score, test_completed')
                .eq('user_id', session.user.id)
                .in('topic_id', topicsWithTests.map(t => t.id))

              // Перевіряємо чи всі тести пройдені на 80%+
              if (allProgress && allProgress.length > 0) {
                // Перевіряємо чи кількість пройдених тестів відповідає кількості topics
                if (allProgress.length < topicsWithTests.length) {
                  console.log(`Користувач ${session.user.id} не пройшов всі тести попереднього курсу ${previousCourseId}`)
                  return NextResponse.json({
                    success: true,
                    hasAccess: false,
                    reason: 'previous_course_not_completed',
                    previousCourseId
                  })
                }

                const allPassed = allProgress.every(p => 
                  p.test_completed && (p.test_score || 0) >= 80
                )

                if (!allPassed) {
                  console.log(`Користувач ${session.user.id} не пройшов попередній курс ${previousCourseId} на 80%+`)
                  return NextResponse.json({
                    success: true,
                    hasAccess: false,
                    reason: 'previous_course_not_completed',
                    previousCourseId
                  })
                }
              } else {
                // Немає прогресу - курс не пройдено
                console.log(`Користувач ${session.user.id} не має прогресу по попередньому курсу ${previousCourseId}`)
                return NextResponse.json({
                  success: true,
                  hasAccess: false,
                  reason: 'previous_course_not_completed',
                  previousCourseId
                })
              }
            } else {
              // Якщо немає topics з питаннями — не блокуємо доступ
              console.log(`Попередній курс ${previousCourseId} не має topics з питаннями, дозволяємо доступ`)
            }
          } else {
            // Якщо не знайдено попередній курс в базі, не блокуємо доступ
            console.log(`Попередній курс ${previousCourseId} не знайдено в базі, дозволяємо доступ`)
          }
        } catch (error) {
          console.error('Помилка перевірки попереднього курсу:', error)
          // У випадку помилки, не блокуємо доступ
        }
      }
    }

    const finalAccess = hasBaseAccess

    console.log('Перевірка доступу до курсу:', {
      courseId: normalizedCourseId,
      rawCourseId: courseId,
      resolvedCourseUuid,
      packageIdCandidates,
      userId: session.user.id,
      hasPaymentAccess,
      hasCourseAccess: !!courseAccess,
      hasSubscriptionAccess,
      finalAccess
    })

    return NextResponse.json({
      success: true,
      hasAccess: finalAccess,
      paymentId: payment?.id || null,
      grantedAt: courseAccess?.granted_at || payment?.created_at || null,
      accessType: hasSubscriptionAccess ? 'subscription' : (hasPaymentAccess ? 'payment' : (courseAccess ? 'access' : null)),
      debug: {
        normalizedCourseId,
        resolvedCourseUuid,
        packageIdCandidates,
        hasPaymentAccess,
        hasCourseAccess: !!courseAccess,
        hasSubscriptionAccess,
        hasSubscriptionPayment
      }
    })
  } catch (error) {
    console.error('Check course access API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

