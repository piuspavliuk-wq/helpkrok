import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { createClient } from '@supabase/supabase-js'
import { supabaseAdmin } from '@/lib/supabase'

export async function POST(request: NextRequest) {
  try {
    // Перевіряємо авторизацію
    const token = await getToken({ 
      req: request,
      secret: process.env.NEXTAUTH_SECRET 
    })
    
    if (!token?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

    // Перевіряємо чи користувач адмін
    if (!supabaseAdmin) {
      return NextResponse.json(
        { error: 'База даних недоступна' },
        { status: 500 }
      )
    }

    const { data: user, error: userError } = await supabaseAdmin
      .from('users')
      .select('id, email, role')
      .eq('id', token.id)
      .single()

    if (userError || !user || user.role !== 'admin') {
      return NextResponse.json(
        { error: 'Доступ заборонено. Тільки адміністратори можуть надавати доступ до курсів.' },
        { status: 403 }
      )
    }

    // Отримуємо дані з запиту
    const body = await request.json()
    const { email, courseId, grantAllMedical, grantAllPharmaceutical } = body

    if (!email) {
      return NextResponse.json(
        { error: 'Email обов\'язковий' },
        { status: 400 }
      )
    }

    // Визначаємо які курси надавати
    const medicalCourses = [
      'fundamental-medico-biological-knowledge',
      'blood-system-and-immunity',
      'central-nervous-system'
    ]

    const pharmaceuticalCourses = [
      'organic-compounds-basics',
      'pharmaceutical-analysis-theory',
      'physical-physicochemical-basics',
      'pharmaceutical-botany',
      'pathological-processes',
      'biochemical-processes',
      'infectious-disease-agents',
      'rational-drug-use',
      'morphological-structure-vegetative-organs'
    ]

    let coursesToGrant: string[] = []
    
    if (grantAllMedical) {
      coursesToGrant = medicalCourses
    } else if (grantAllPharmaceutical) {
      coursesToGrant = pharmaceuticalCourses
    } else if (courseId) {
      coursesToGrant = [courseId]
    }
    
    if (coursesToGrant.length === 0) {
      return NextResponse.json(
        { error: 'Необхідно вказати courseId, grantAllMedical=true або grantAllPharmaceutical=true' },
        { status: 400 }
      )
    }

    // Знаходимо користувача за email
    const { data: targetUser, error: findUserError } = await supabaseAdmin
      .from('users')
      .select('id, email, first_name, last_name')
      .eq('email', email)
      .single()

    if (findUserError || !targetUser) {
      return NextResponse.json(
        { error: 'Користувач з таким email не знайдений' },
        { status: 404 }
      )
    }

    // Надаємо доступ до всіх вказаних курсів
    const results = []
    
    for (const courseIdToGrant of coursesToGrant) {
      // Перевіряємо чи вже є доступ
      const { data: existingPayment } = await supabaseAdmin
        .from('payments')
        .select('*')
        .eq('user_id', targetUser.id)
        .eq('package_id', courseIdToGrant)
        .eq('payment_type', 'course')
        .eq('status', 'success')
        .maybeSingle()

      if (existingPayment) {
        results.push({
          courseId: courseIdToGrant,
          success: true,
          message: 'Доступ вже надано',
          payment: existingPayment
        })
        continue
      }

      // Створюємо фіктивний платіж для надання доступу
      const invoiceId = `granted-access-${Date.now()}-${Math.random().toString(36).substr(2, 9)}-${courseIdToGrant}`
      
      const { data: newPayment, error: insertError } = await supabaseAdmin
        .from('payments')
        .insert({
          user_id: targetUser.id,
          invoice_id: invoiceId,
          amount: 0,
          status: 'success',
          payment_type: 'course',
          package_id: courseIdToGrant,
          attempts_count: 0,
          metadata: JSON.stringify({
            reason: 'Надано доступ за виграш курсу',
            granted_by: 'admin'
          }),
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .select()
        .single()

      if (insertError) {
        console.error(`Помилка створення платежу для курсу ${courseIdToGrant}:`, insertError)
        results.push({
          courseId: courseIdToGrant,
          success: false,
          message: 'Помилка надання доступу',
          error: insertError.message
        })
      } else {
        results.push({
          courseId: courseIdToGrant,
          success: true,
          message: 'Доступ надано',
          payment: newPayment
        })
      }
    }

    const successCount = results.filter(r => r.success).length
    const allSuccess = successCount === results.length

    return NextResponse.json({
      success: allSuccess,
      message: allSuccess 
        ? `Доступ успішно надано до всіх ${successCount} курсів`
        : `Надано доступ до ${successCount} з ${results.length} курсів`,
      results: results,
      user: {
        id: targetUser.id,
        email: targetUser.email,
        name: `${targetUser.first_name} ${targetUser.last_name}`
      }
    })
  } catch (error) {
    console.error('Grant course access API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

