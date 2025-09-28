import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { createSupabaseClientForServer } from '@/lib/supabase/server'

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const supabase = createSupabaseClientForServer()

    // Отримуємо статистику користувача
    const { data: userStats, error: statsError } = await supabase
      .from('user_statistics')
      .select('*')
      .eq('user_id', session.user.id)
      .single()

    if (statsError) {
      console.error('Error fetching user stats:', statsError)
      return NextResponse.json(
        { error: 'Помилка отримання статистики' },
        { status: 500 }
      )
    }

    // Отримуємо рейтинг користувача
    const { data: userRating, error: ratingError } = await supabase
      .from('user_ratings')
      .select('*')
      .eq('user_id', session.user.id)
      .single()

    // Отримуємо всі доступні досягнення
    const { data: achievements, error: achievementsError } = await supabase
      .from('achievements')
      .select('*')
      .eq('is_active', true)

    if (achievementsError) {
      console.error('Error fetching achievements:', achievementsError)
      return NextResponse.json(
        { error: 'Помилка отримання досягнень' },
        { status: 500 }
      )
    }

    // Отримуємо вже отримані досягнення користувача
    const { data: userAchievements, error: userAchievementsError } = await supabase
      .from('user_achievements')
      .select('achievement_id')
      .eq('user_id', session.user.id)

    if (userAchievementsError) {
      console.error('Error fetching user achievements:', userAchievementsError)
      return NextResponse.json(
        { error: 'Помилка отримання досягнень користувача' },
        { status: 500 }
      )
    }

    const unlockedAchievementIds = new Set(userAchievements?.map(ua => ua.achievement_id) || [])

    // Перевіряємо, які досягнення можна отримати
    const newAchievements = []
    
    for (const achievement of achievements || []) {
      if (unlockedAchievementIds.has(achievement.id)) continue

      let shouldUnlock = false

      switch (achievement.code) {
        case 'first_test':
          shouldUnlock = (userStats?.completed_tests || 0) >= 1
          break
        case 'tests_10':
          shouldUnlock = (userStats?.completed_tests || 0) >= 10
          break
        case 'tests_50':
          shouldUnlock = (userStats?.completed_tests || 0) >= 50
          break
        case 'tests_100':
          shouldUnlock = (userStats?.completed_tests || 0) >= 100
          break
        case 'points_1000':
          shouldUnlock = (userRating?.total_points || 0) >= 1000
          break
        case 'points_5000':
          shouldUnlock = (userRating?.total_points || 0) >= 5000
          break
        case 'points_10000':
          shouldUnlock = (userRating?.total_points || 0) >= 10000
          break
        case 'top_10':
          shouldUnlock = (userRating?.rank_position || 999) <= 10
          break
        case 'top_3':
          shouldUnlock = (userRating?.rank_position || 999) <= 3
          break
        case 'faculty_leader':
          shouldUnlock = (userRating?.faculty_rank_position || 999) === 1
          break
      }

      if (shouldUnlock) {
        // Створюємо досягнення
        const { error: insertError } = await supabase
          .from('user_achievements')
          .insert({
            user_id: session.user.id,
            achievement_id: achievement.id,
            unlocked_at: new Date().toISOString()
          })

        if (!insertError) {
          newAchievements.push(achievement)
        }
      }
    }

    // Отримуємо оновлені досягнення користувача
    const { data: updatedUserAchievements, error: updatedAchievementsError } = await supabase
      .from('user_achievements')
      .select(`
        *,
        achievements!inner(code, title, description, icon, points)
      `)
      .eq('user_id', session.user.id)
      .order('unlocked_at', { ascending: false })

    if (updatedAchievementsError) {
      console.error('Error fetching updated user achievements:', updatedAchievementsError)
      return NextResponse.json(
        { error: 'Помилка завантаження оновлених досягнень' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      achievements: updatedUserAchievements || [],
      newAchievements: newAchievements,
      message: `Досягнення перевірено та оновлено. Отримано ${newAchievements.length} нових досягнень`
    })

  } catch (error) {
    console.error('Check achievements API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
