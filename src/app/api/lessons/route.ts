import { NextRequest, NextResponse } from 'next/server'
import { getToken } from 'next-auth/jwt'
import { supabaseAdmin } from '@/lib/supabase'

// GET - отримання уроків для студентів
export async function GET(request: NextRequest) {
  try {
    const token = await getToken({ req: request })
    
    if (!token?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty')
    const step = searchParams.get('step')
    const status = searchParams.get('status') || 'scheduled'

    if (!supabaseAdmin) {
      return NextResponse.json({ error: 'База даних недоступна' }, { status: 500 })
    }

    // Отримуємо користувача для перевірки ролі
    const { data: user, error: userError } = await supabaseAdmin
      .from('users')
      .select('id, email, role')
      .eq('id', token.id)
      .single()

    if (userError || !user) {
      return NextResponse.json({ error: 'Користувач не знайдений' }, { status: 404 })
    }

    // Отримуємо уроки (спрощений запит)
    let query = supabaseAdmin.from('lessons').select('*')

    if (faculty) {
      query = query?.eq('faculty', faculty)
    }
    if (step) {
      query = query?.eq('step', step)
    }
    if (status) {
      query = query?.eq('status', status)
    }

    const { data: lessons, error: lessonsError } = await query?.order('start_date', { ascending: true })

    if (lessonsError) {
      console.error('Lessons query error:', lessonsError)
      return NextResponse.json({ error: 'Помилка при отриманні уроків' }, { status: 500 })
    }

    // Трансформуємо дані з snake_case в camelCase
    const transformedLessons = lessons?.map((lesson: Record<string, unknown>) => ({
      ...lesson,
      isOnline: lesson.is_online,
      meetingLink: lesson.meeting_link,
      startDate: lesson.start_date,
      endDate: lesson.end_date,
      teacherName: lesson.teacher_name,
      maxStudents: lesson.max_students,
      calendarEventId: lesson.calendar_event_id,
      createdAt: lesson.created_at,
      updatedAt: lesson.updated_at
    })) || []

    return NextResponse.json({
      success: true,
      lessons: transformedLessons,
      userRole: user.role || 'student'
    })

  } catch (error) {
    console.error('Lessons API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

// POST - створення уроку (тільки для адмінів)
export async function POST(request: NextRequest) {
  try {
    const token = await getToken({ req: request })
    
    if (!token?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    if (!supabaseAdmin) {
      return NextResponse.json({ error: 'База даних недоступна' }, { status: 500 })
    }

    // Перевіряємо, чи користувач адмін
    const { data: user, error: userError } = await supabaseAdmin
      .from('users')
      .select('id, email, role')
      .eq('id', token.id)
      .single()

    if (userError || !user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Доступ заборонено. Тільки адміністратори можуть редагувати уроки.' }, { status: 403 })
    }

    const body = await request.json()
    const {
      title,
      description,
      subject,
      step,
      faculty,
      startDate,
      endDate,
      location,
      teacherName,
      maxStudents,
      isOnline,
      meetingLink,
      materials,
      calendarEventId
    } = body

    // Валідація обов'язкових полів
    if (!title || !subject || !step || !faculty || !startDate || !endDate) {
      return NextResponse.json(
        { error: 'Відсутні обов\'язкові поля' },
        { status: 400 }
      )
    }

    const { data: lesson, error: lessonError } = await supabaseAdmin
      .from('lessons')
      .insert({
        title,
        description,
        subject,
        step,
        faculty,
        start_date: startDate,
        end_date: endDate,
        location,
        teacher_name: teacherName,
        max_students: maxStudents ? parseInt(maxStudents) : null,
        is_online: isOnline || false,
        meeting_link: meetingLink,
        materials: materials ? JSON.stringify(materials) : null,
        calendar_event_id: calendarEventId,
        created_by: token.id,
        status: 'scheduled'
      })
      .select()
      .single()

    if (lessonError) {
      console.error('Create lesson error:', lessonError)
      return NextResponse.json({ error: 'Помилка при створенні уроку' }, { status: 500 })
    }

    return NextResponse.json({
      success: true,
      lesson,
      message: 'Урок успішно створено'
    })

  } catch (error) {
    console.error('Create lesson error:', error)
    return NextResponse.json(
      { error: 'Помилка при створенні уроку' },
      { status: 500 }
    )
  }
}

// PUT - оновлення уроку (тільки для адмінів)
export async function PUT(request: NextRequest) {
  try {
    const token = await getToken({ req: request })
    
    if (!token?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    if (!supabaseAdmin) {
      return NextResponse.json({ error: 'База даних недоступна' }, { status: 500 })
    }

    // Перевіряємо, чи користувач адмін
    const { data: user, error: userError } = await supabaseAdmin
      .from('users')
      .select('id, email, role')
      .eq('id', token.id)
      .single()

    if (userError || !user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Доступ заборонено. Тільки адміністратори можуть редагувати уроки.' }, { status: 403 })
    }

    const body = await request.json()
    const { lessonId, ...updateData } = body

    if (!lessonId) {
      return NextResponse.json({ error: 'ID уроку не надано' }, { status: 400 })
    }

    // Підготовка даних для оновлення
    const updateFields: Record<string, unknown> = { ...updateData }
    if (updateData.startDate) updateFields.start_date = updateData.startDate
    if (updateData.endDate) updateFields.end_date = updateData.endDate
    if (updateData.materials) updateFields.materials = JSON.stringify(updateData.materials)
    updateFields.updated_at = new Date().toISOString()

    const { data: lesson, error: lessonError } = await supabaseAdmin
      .from('lessons')
      .update(updateFields)
      .eq('id', lessonId)
      .select()
      .single()

    if (lessonError) {
      console.error('Update lesson error:', lessonError)
      return NextResponse.json({ error: 'Помилка при оновленні уроку' }, { status: 500 })
    }

    return NextResponse.json({
      success: true,
      lesson,
      message: 'Урок успішно оновлено'
    })

  } catch (error) {
    console.error('Update lesson error:', error)
    return NextResponse.json(
      { error: 'Помилка при оновленні уроку' },
      { status: 500 }
    )
  }
}

// DELETE - видалення уроку (тільки для адмінів)
export async function DELETE(request: NextRequest) {
  try {
    const token = await getToken({ req: request })
    
    if (!token?.id) {
      return NextResponse.json({ error: 'Не авторизовано' }, { status: 401 })
    }

    if (!supabaseAdmin) {
      return NextResponse.json({ error: 'База даних недоступна' }, { status: 500 })
    }

    // Перевіряємо, чи користувач адмін
    const { data: user, error: userError } = await supabaseAdmin
      .from('users')
      .select('id, email, role')
      .eq('id', token.id)
      .single()

    if (userError || !user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Доступ заборонено. Тільки адміністратори можуть редагувати уроки.' }, { status: 403 })
    }

    const body = await request.json()
    const { id: lessonId } = body

    if (!lessonId) {
      return NextResponse.json({ error: 'ID уроку не надано' }, { status: 400 })
    }

    const { error: deleteError } = await supabaseAdmin
      .from('lessons')
      .delete()
      .eq('id', lessonId)

    if (deleteError) {
      console.error('Delete lesson error:', deleteError)
      return NextResponse.json({ error: 'Помилка при видаленні уроку' }, { status: 500 })
    }

    return NextResponse.json({
      success: true,
      message: 'Урок успішно видалено'
    })

  } catch (error) {
    console.error('Delete lesson error:', error)
    return NextResponse.json(
      { error: 'Помилка при видаленні уроку' },
      { status: 500 }
    )
  }
}
