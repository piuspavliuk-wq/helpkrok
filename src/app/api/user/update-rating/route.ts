import { NextRequest, NextResponse } from 'next/server'
import { createSupabaseClientForServer } from '@/lib/supabase/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Необхідна авторизація' },
        { status: 401 }
      )
    }

    const supabase = createSupabaseClientForServer()
    const userId = session.user.id

    // Оновлюємо рейтинг користувача
    await updateUserRating(userId, supabase)

    return NextResponse.json({
      success: true,
      message: 'Рейтинг оновлено'
    })

  } catch (error) {
    console.error('Rating update error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}

// Функція для оновлення рейтингу користувача
async function updateUserRating(userId: string, supabase: any) {
  try {
    // Отримуємо статистику користувача
    const { data: userStats } = await supabase
      .from('user_statistics')
      .select('*')
      .eq('user_id', userId)
      .single()

    if (userStats) {
      // Розраховуємо очки
      const totalPoints = (userStats.correct_answers || 0) + 
                         ((userStats.completed_tests || 0) * 10) + 
                         ((userStats.average_percentage || 0) * 5)

      // Оновлюємо або створюємо рейтинг
      await supabase
        .from('user_ratings')
        .upsert({
          user_id: userId,
          total_points: totalPoints,
          tests_completed: userStats.completed_tests || 0,
          average_score: userStats.average_percentage || 0,
          last_updated: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }, {
          onConflict: 'user_id'
        })
    }
  } catch (error) {
    console.error('Error updating user rating:', error)
    throw error
  }
}
