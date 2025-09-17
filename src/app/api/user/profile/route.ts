import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { supabase } from '@/lib/supabase'

export async function PUT(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { firstName, lastName, faculty, university, email, step } = body

    // Валідація тільки університету
    if (!university) {
      return NextResponse.json({ 
        error: 'Missing required field: university' 
      }, { status: 400 })
    }

    // Оновлюємо тільки університет в Supabase (якщо доступний)
    let data = null
    let error = null
    
    if (supabase) {
      const result = await supabase
        .from('users')
        .update({
          university: university,
          updated_at: new Date().toISOString()
        })
        .eq('id', session.user.id)
        .select()
      
      data = result.data
      error = result.error
    }

    if (error) {
      console.error('Supabase update error:', error)
      return NextResponse.json(
        { error: 'Помилка оновлення профілю в базі даних' },
        { status: 500 }
      )
    }

    if (!data || data.length === 0) {
      // Якщо користувач не існує, створюємо його (тільки якщо Supabase доступний)
      if (supabase) {
        const { data: insertData, error: insertError } = await supabase
          .from('users')
          .insert({
            id: session.user.id,
            university: university,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
          })
          .select()

        if (insertError) {
          console.error('Supabase insert error:', insertError)
          return NextResponse.json(
            { error: 'Помилка створення профілю в базі даних' },
            { status: 500 }
          )
        }
      } else {
        console.log('Supabase not configured, skipping profile creation')
      }

      return NextResponse.json({
        success: true,
        profile: {
          id: session.user.id,
          university: university,
          updatedAt: new Date().toISOString()
        },
        message: 'Profile created successfully'
      })
    }

    return NextResponse.json({
      success: true,
      profile: {
        id: session.user.id,
        university: university,
        updatedAt: new Date().toISOString()
      },
      message: 'University updated successfully'
    })

  } catch (error) {
    console.error('Update profile API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Отримуємо профіль з Supabase (якщо доступний)
    let data = null
    let error = null
    
    if (supabase) {
      const result = await supabase
        .from('users')
        .select('*')
        .eq('id', session.user.id)
        .single()
      
      data = result.data
      error = result.error
    }

    if (error || !data) {
      console.error('Supabase get error:', error)
      // Якщо користувач не знайдений або Supabase недоступний, повертаємо базові дані
      return NextResponse.json({
        success: true,
        profile: {
          id: session.user.id,
          firstName: session.user.name?.split(' ')[0] || '',
          lastName: session.user.name?.split(' ').slice(1).join(' ') || '',
          faculty: 'medical',
          university: '',
          email: session.user.email || '',
          step: 'krok1',
          phone: '',
          dateOfBirth: '',
          bio: '',
          preferences: '{}',
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString()
        },
        message: 'Profile not found, using default values'
      })
    }

    return NextResponse.json({
      success: true,
      profile: {
        id: data.id,
        firstName: data.first_name || '',
        lastName: data.last_name || '',
        faculty: data.faculty || 'medical',
        university: data.university || '',
        email: session.user.email || '',
        step: data.step || 'krok1',
        phone: '',
        dateOfBirth: '',
        bio: '',
        preferences: '{}',
        createdAt: data.created_at,
        updatedAt: data.updated_at
      }
    })

  } catch (error) {
    console.error('Get profile API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
