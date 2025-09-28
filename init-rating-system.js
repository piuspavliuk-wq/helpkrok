// Ініціалізація системи рейтингу
require('dotenv').config({ path: '.env.local' })
const { createClient } = require('@supabase/supabase-js')

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Помилка: Відсутні змінні середовища для Supabase')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey)

async function initRatingSystem() {
  try {
    console.log('🚀 Ініціалізація системи рейтингу...')

    // 1. Отримуємо всіх користувачів
    const { data: users, error: usersError } = await supabase
      .from('users')
      .select('id, first_name, last_name')

    if (usersError) {
      console.error('❌ Помилка отримання користувачів:', usersError.message)
      return
    }

    console.log(`👥 Знайдено ${users.length} користувачів`)

    // 2. Оновлюємо рейтинги для всіх користувачів
    let updatedCount = 0
    let errorCount = 0

    for (const user of users) {
      try {
        // Отримуємо статистику користувача
        const { data: userStats } = await supabase
          .from('user_statistics')
          .select('*')
          .eq('user_id', user.id)
          .single()

        if (userStats) {
          // Розраховуємо очки
          const totalPoints = (userStats.correct_answers || 0) + 
                             ((userStats.completed_tests || 0) * 10) + 
                             ((userStats.average_percentage || 0) * 5)

          // Оновлюємо рейтинг
          const { error: updateError } = await supabase
            .from('user_ratings')
            .upsert({
              user_id: user.id,
              total_points: totalPoints,
              tests_completed: userStats.completed_tests || 0,
              average_score: userStats.average_percentage || 0,
              last_updated: new Date().toISOString(),
              updated_at: new Date().toISOString()
            }, {
              onConflict: 'user_id'
            })

          if (updateError) {
            console.error(`❌ Помилка оновлення рейтингу для ${user.first_name}:`, updateError.message)
            errorCount++
          } else {
            console.log(`✅ Оновлено рейтинг для ${user.first_name} ${user.last_name}: ${totalPoints} очок`)
            updatedCount++
          }
        } else {
          console.log(`⚠️ Немає статистики для ${user.first_name} ${user.last_name}`)
        }
      } catch (error) {
        console.error(`❌ Помилка обробки користувача ${user.first_name}:`, error.message)
        errorCount++
      }
    }

    // 3. Оновлюємо позиції в рейтингу
    console.log('📊 Оновлення позицій в рейтингу...')
    
    const { data: ratings, error: ratingsError } = await supabase
      .from('user_ratings')
      .select('user_id, total_points')
      .order('total_points', { ascending: false })

    if (ratingsError) {
      console.error('❌ Помилка отримання рейтингів:', ratingsError.message)
    } else {
      for (let i = 0; i < ratings.length; i++) {
        const { error: updateError } = await supabase
          .from('user_ratings')
          .update({ rank_position: i + 1 })
          .eq('user_id', ratings[i].user_id)

        if (updateError) {
          console.error(`❌ Помилка оновлення позиції для користувача ${ratings[i].user_id}:`, updateError.message)
        }
      }
      console.log(`✅ Оновлено позиції для ${ratings.length} користувачів`)
    }

    // 4. Перевіряємо досягнення для всіх користувачів
    console.log('🎯 Перевірка досягнень...')
    
    const { data: achievements } = await supabase
      .from('achievements')
      .select('*')
      .eq('is_active', true)

    let achievementsUnlocked = 0

    for (const user of users) {
      try {
        const { data: userStats } = await supabase
          .from('user_statistics')
          .select('*')
          .eq('user_id', user.id)
          .single()

        const { data: userRating } = await supabase
          .from('user_ratings')
          .select('*')
          .eq('user_id', user.id)
          .single()

        if (userStats && userRating) {
          for (const achievement of achievements || []) {
            let shouldUnlock = false

            switch (achievement.code) {
              case 'first_test':
                shouldUnlock = (userStats.completed_tests || 0) >= 1
                break
              case 'tests_10':
                shouldUnlock = (userStats.completed_tests || 0) >= 10
                break
              case 'tests_50':
                shouldUnlock = (userStats.completed_tests || 0) >= 50
                break
              case 'tests_100':
                shouldUnlock = (userStats.completed_tests || 0) >= 100
                break
              case 'points_1000':
                shouldUnlock = (userRating.total_points || 0) >= 1000
                break
              case 'points_5000':
                shouldUnlock = (userRating.total_points || 0) >= 5000
                break
              case 'points_10000':
                shouldUnlock = (userRating.total_points || 0) >= 10000
                break
              case 'top_10':
                shouldUnlock = (userRating.rank_position || 999) <= 10
                break
              case 'top_3':
                shouldUnlock = (userRating.rank_position || 999) <= 3
                break
              case 'faculty_leader':
                shouldUnlock = (userRating.faculty_rank_position || 999) === 1
                break
            }

            if (shouldUnlock) {
              // Перевіряємо, чи досягнення вже не отримано
              const { data: existingAchievement } = await supabase
                .from('user_achievements')
                .select('id')
                .eq('user_id', user.id)
                .eq('achievement_id', achievement.id)
                .single()

              if (!existingAchievement) {
                const { error: insertError } = await supabase
                  .from('user_achievements')
                  .insert({
                    user_id: user.id,
                    achievement_id: achievement.id,
                    unlocked_at: new Date().toISOString()
                  })

                if (!insertError) {
                  achievementsUnlocked++
                  console.log(`🎉 ${user.first_name} отримав досягнення: ${achievement.title}`)
                }
              }
            }
          }
        }
      } catch (error) {
        console.error(`❌ Помилка перевірки досягнень для ${user.first_name}:`, error.message)
      }
    }

    console.log('\n🎉 Ініціалізація завершена!')
    console.log(`✅ Оновлено рейтингів: ${updatedCount}`)
    console.log(`❌ Помилок: ${errorCount}`)
    console.log(`🎯 Розблоковано досягнень: ${achievementsUnlocked}`)

  } catch (error) {
    console.error('❌ Помилка ініціалізації системи рейтингу:', error)
  }
}

initRatingSystem()
