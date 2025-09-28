import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { createSupabaseClientForServer } from '@/lib/supabase/server'

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user?.id) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const supabase = createSupabaseClientForServer()

    // Оновлюємо рейтинг поточного користувача
    try {
      // Спочатку отримуємо статистику користувача
      const { data: userStats } = await supabase
        .from('user_statistics')
        .select('*')
        .eq('user_id', session.user.id)
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
            user_id: session.user.id,
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
      console.log('Rating update failed, continuing with existing data:', error)
    }

    // Отримуємо рейтинг поточного користувача
    const { data: currentUserRating, error: currentUserError } = await supabase
      .from('user_ratings')
      .select('*')
      .eq('user_id', session.user.id)
      .single()

    // Отримуємо дані користувача окремо
    const { data: currentUserData, error: currentUserDataError } = await supabase
      .from('users')
      .select('first_name, last_name, role')
      .eq('id', session.user.id)
      .single()

    if (currentUserError) {
      console.error('Error fetching current user rating:', currentUserError)
    }

    // Отримуємо топ-20 користувачів за загальним рейтингом
    const { data: topUsers, error: topUsersError } = await supabase
      .from('user_ratings')
      .select('*')
      .order('total_points', { ascending: false })
      .limit(20)

    if (topUsersError) {
      console.error('Error fetching top users:', topUsersError)
    }

    // Отримуємо рейтинг по факультетах (поки що використовуємо загальний рейтинг)
    const { data: medicalUsers, error: medicalError } = await supabase
      .from('user_ratings')
      .select('*')
      .order('total_points', { ascending: false })
      .limit(10)

    const { data: pharmaceuticalUsers, error: pharmaceuticalError } = await supabase
      .from('user_ratings')
      .select('*')
      .order('total_points', { ascending: false })
      .limit(10)

    // Отримуємо досягнення користувача
    const { data: userAchievements, error: achievementsError } = await supabase
      .from('user_achievements')
      .select(`
        *,
        achievements!inner(code, title, description, icon, points)
      `)
      .eq('user_id', session.user.id)
      .order('unlocked_at', { ascending: false })

    // Отримуємо всі доступні досягнення
    const { data: allAchievements, error: allAchievementsError } = await supabase
      .from('achievements')
      .select('*')
      .eq('is_active', true)
      .order('points', { ascending: true })

    // Отримуємо дані користувачів для рейтингу
    const getUserData = async (userId: string) => {
      const { data: user } = await supabase
        .from('users')
        .select('first_name, last_name, role')
        .eq('id', userId)
        .single()
      
      return user
    }

    // Отримуємо всіх користувачів для обчислення рангу
    const { data: allUsers, error: allUsersError } = await supabase
      .from('user_ratings')
      .select('user_id, total_points')
      .order('total_points', { ascending: false })

    // Створюємо мапу рангів
    const rankMap = new Map()
    if (allUsers) {
      allUsers.forEach((user, index) => {
        rankMap.set(user.user_id, index + 1)
      })
    }

    // Форматуємо дані для відповіді
    const formatUserData = async (userRating: any) => {
      if (!userRating) return null
      
      const userData = await getUserData(userRating.user_id)
      const fullName = userData 
        ? `${userData.first_name || ''} ${userData.last_name || ''}`.trim()
        : 'Невідомий користувач'
      
      // Обчислюємо ранг на основі позиції в загальному рейтингу
      const rank = rankMap.get(userRating.user_id) || 0
      
      return {
        id: userRating.user_id,
        name: fullName || 'Невідомий користувач',
        faculty: 'medical', // Поки що за замовчуванням
        totalScore: userRating.total_points || 0,
        testsCompleted: userRating.tests_completed || 0,
        averageScore: userRating.average_score || 0,
        rank: rank,
        points: userRating.total_points || 0,
        achievements: 0 // Буде розраховано нижче
      }
    }

    // Форматуємо досягнення
    const formatAchievements = () => {
      if (!allAchievements) return []
      
      const unlockedAchievementIds = new Set(
        userAchievements?.map(ua => ua.achievement_id) || []
      )
      
      return allAchievements.map(achievement => ({
        id: achievement.code,
        title: achievement.title,
        description: achievement.description,
        icon: achievement.icon,
        points: achievement.points,
        unlocked: unlockedAchievementIds.has(achievement.id),
        unlockedAt: userAchievements?.find(ua => ua.achievement_id === achievement.id)?.unlocked_at
      }))
    }

    // Підраховуємо кількість досягнень для кожного користувача
    const getUserAchievementsCount = async (userId: string) => {
      const { count } = await supabase
        .from('user_achievements')
        .select('*', { count: 'exact', head: true })
        .eq('user_id', userId)
      
      return count || 0
    }

    // Форматуємо дані користувачів з кількістю досягнень
    const formatUsersWithAchievements = async (users: any[]) => {
      const formattedUsers = []
      
      for (const user of users) {
        const formattedUser = await formatUserData(user)
        if (formattedUser) {
          formattedUser.achievements = await getUserAchievementsCount(user.user_id)
          formattedUsers.push(formattedUser)
        }
      }
      
      return formattedUsers
    }

    // Форматуємо всі дані
    const currentUserFormatted = currentUserRating ? {
      ...(await formatUserData(currentUserRating)),
      achievements: userAchievements?.length || 0
    } : {
      id: session.user.id,
      name: session.user.name || 'Ви',
      avatar: session.user.image,
      faculty: 'medical',
      totalScore: 0,
      testsCompleted: 0,
      averageScore: 0,
      rank: rankMap.get(session.user.id) || 0,
      points: 0,
      achievements: 0
    }

    const topUsersFormatted = topUsers ? await formatUsersWithAchievements(topUsers) : []
    const medicalUsersFormatted = medicalUsers ? await formatUsersWithAchievements(medicalUsers) : []
    const pharmaceuticalUsersFormatted = pharmaceuticalUsers ? await formatUsersWithAchievements(pharmaceuticalUsers) : []

    const rankingData = {
      currentUser: currentUserFormatted,
      topUsers: topUsersFormatted,
      facultyRanking: {
        medical: medicalUsersFormatted,
        pharmaceutical: pharmaceuticalUsersFormatted
      },
      achievements: formatAchievements()
    }

    return NextResponse.json({
      success: true,
      rankingData
    })

  } catch (error) {
    console.error('Ranking API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}