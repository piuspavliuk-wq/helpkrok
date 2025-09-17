const { createClient } = require('@supabase/supabase-js')

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Missing Supabase environment variables')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
})

async function createTestLessons() {
  try {
    // Спочатку отримуємо адміна
    const { data: admin, error: adminError } = await supabase
      .from('users')
      .select('id')
      .eq('email', 'admin@helpkrok.com')
      .single()

    if (adminError || !admin) {
      console.error('Admin not found:', adminError)
      return
    }

    console.log('Admin found:', admin.id)

    // Створюємо тестові уроки
    const testLessons = [
      {
        title: 'Анатомія серця',
        description: 'Детальний розгляд будови серця та його функцій',
        subject: 'Анатомія',
        step: 'krok1',
        faculty: 'medical',
        start_date: new Date('2024-01-25T10:00:00Z').toISOString(),
        end_date: new Date('2024-01-25T12:00:00Z').toISOString(),
        location: 'Аудиторія 101',
        teacher_name: 'Професор Іванов',
        max_students: 30,
        is_online: false,
        meeting_link: null,
        materials: '{"slides": "anatomy_heart.pdf", "notes": "heart_notes.docx"}',
        status: 'scheduled',
        calendar_event_id: null,
        created_by: admin.id
      },
      {
        title: 'Фізіологія дихання',
        description: 'Механізми дихання та газообмін',
        subject: 'Фізіологія',
        step: 'krok1',
        faculty: 'medical',
        start_date: new Date('2024-01-26T14:00:00Z').toISOString(),
        end_date: new Date('2024-01-26T16:00:00Z').toISOString(),
        location: 'Аудиторія 205',
        teacher_name: 'Доцент Петренко',
        max_students: 25,
        is_online: false,
        meeting_link: null,
        materials: '{"slides": "physiology_respiration.pdf", "video": "respiration_video.mp4"}',
        status: 'scheduled',
        calendar_event_id: null,
        created_by: admin.id
      },
      {
        title: 'Онлайн лекція з біохімії',
        description: 'Біохімічні процеси в клітині',
        subject: 'Біохімія',
        step: 'krok2',
        faculty: 'medical',
        start_date: new Date('2024-01-27T09:00:00Z').toISOString(),
        end_date: new Date('2024-01-27T11:00:00Z').toISOString(),
        location: null,
        teacher_name: 'Професор Коваленко',
        max_students: 50,
        is_online: true,
        meeting_link: 'https://meet.google.com/abc-defg-hij',
        materials: '{"slides": "biochemistry_cell.pdf", "quiz": "biochemistry_quiz.pdf"}',
        status: 'scheduled',
        calendar_event_id: null,
        created_by: admin.id
      }
    ]

    console.log('Creating test lessons...')

    for (const lesson of testLessons) {
      const { data, error } = await supabase
        .from('lessons')
        .insert(lesson)
        .select()

      if (error) {
        console.error('Error creating lesson:', error)
      } else {
        console.log('Created lesson:', data[0].title)
      }
    }

    console.log('Test lessons created successfully!')

  } catch (error) {
    console.error('Error:', error)
  }
}

createTestLessons()
