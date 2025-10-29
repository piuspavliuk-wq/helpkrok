'use client'

import { useState, useEffect } from 'react'
import { TestCard } from '@/components/testing/TestCard'
import { CustomSelect } from '@/components/ui/CustomSelect'
import { useSession } from 'next-auth/react'

// Кеш для баз на фронтенді
const basesCache = new Map<string, { data: TestSubject[]; timestamp: number }>();
const FRONTEND_CACHE_DURATION = 3 * 60 * 1000; // 3 хвилини

interface TestSubject {
  id: string
  title: string
  totalQuestions: number
  completedQuestions?: number
  bestScore?: number
  hasProgress?: boolean
  isCompleted?: boolean
}

interface ApiResponse {
  success: boolean
  subjects?: TestSubject[]
  error?: string
}

interface BasesPageProps {
  faculty?: 'medical' | 'pharmaceutical'
}

export function BasesPage({ faculty = 'medical' }: BasesPageProps) {
  const { data: session } = useSession()
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical'>(faculty)
  const [userFaculty, setUserFaculty] = useState<'medical' | 'pharmaceutical' | null>(null)
  const [facultyLoaded, setFacultyLoaded] = useState(false)

  // Отримуємо факультет користувача
  useEffect(() => {
    const fetchUserFaculty = async () => {
      if (session?.user?.id) {
        try {
          console.log('🔍 Fetching user faculty for user:', session.user.id)
          const response = await fetch('/api/user/profile')
          if (response.ok) {
            const userData = await response.json()
            console.log('📋 User data received:', userData)
            if (userData.profile?.faculty) {
              console.log('✅ Setting faculty to:', userData.profile.faculty)
              setUserFaculty(userData.profile.faculty)
              setSelectedFaculty(userData.profile.faculty)
              setFacultyLoaded(true)
            } else {
              console.log('⚠️ No faculty found in user data, using default')
              setFacultyLoaded(true)
            }
          } else {
            console.log('❌ Failed to fetch user profile:', response.status)
          }
        } catch (error) {
          console.error('❌ Error fetching user faculty:', error)
          setFacultyLoaded(true)
        }
      } else {
        console.log('⚠️ No user session, using default faculty')
        setFacultyLoaded(true)
      }
    }

    fetchUserFaculty()
  }, [session?.user?.id])

  // Fallback mock data for medical subjects (Крок 1)
  const medicalSubjectsKrok1: TestSubject[] = [
    { id: 'anatomy', title: 'Анатомія', totalQuestions: 200, hasProgress: true },
    { id: 'histology', title: 'Гістологія', totalQuestions: 100, hasProgress: true },
    { id: 'physiology', title: 'Фізіологія', totalQuestions: 300, hasProgress: true },
    { id: 'pharmacology', title: 'Фармакологія', totalQuestions: 296, hasProgress: true },
    { id: 'biology', title: 'Біологія', totalQuestions: 140, hasProgress: true },
    { id: 'pathology', title: 'Патологія', totalQuestions: 221, hasProgress: true },
    { id: 'pathophysiology', title: 'Патологічна фізіологія', totalQuestions: 107, hasProgress: true },
    { id: 'microbiology', title: 'Мікробіологія', totalQuestions: 563, hasProgress: true }
  ]

  // Fallback mock data for pharmaceutical subjects
  const pharmaceuticalSubjectsKrok1: TestSubject[] = [
    { 
      id: 'analytical-chemistry', 
      title: 'Аналітична хімія', 
      totalQuestions: 376,
      completedQuestions: 3,
      hasProgress: true
    },
    { 
      id: 'microbiology-pharmaceutical', 
      title: 'Мікробіологія', 
      totalQuestions: 269,
      completedQuestions: 0,
      hasProgress: true
    },
    { 
      id: 'biochemistry-pharmaceutical', 
      title: 'Біохімія', 
      totalQuestions: 340,
      completedQuestions: 0,
      hasProgress: true
    },
    { 
      id: 'pharmacology-pharmaceutical', 
      title: 'Фармакологія', 
      totalQuestions: 352,
      completedQuestions: 0,
      hasProgress: true
    },
    { 
      id: 'botany-pharmaceutical', 
      title: 'Ботаніка', 
      totalQuestions: 313,
      completedQuestions: 0,
      hasProgress: true
    },
    { 
      id: 'pathophysiology-pharmaceutical', 
      title: 'Патофізіологія', 
      totalQuestions: 370,
      completedQuestions: 0,
      hasProgress: true
    },
    { 
      id: 'physical-chemistry-pharmaceutical', 
      title: 'Фізична та колоїдна хімія', 
      totalQuestions: 283,
      completedQuestions: 0,
      hasProgress: true
    },
        { 
          id: 'organic-chemistry-pharmaceutical', 
          title: 'Органічна хімія', 
          totalQuestions: 318,
          completedQuestions: 0,
          hasProgress: true
        }
  ]

  const [subjects, setSubjects] = useState<TestSubject[]>([]) // Початкові дані
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  // Функція для завантаження прогресу користувача
  const loadUserProgress = async (subjects: TestSubject[]) => {
    // Для фармації завжди показуємо хардкод дані
    const subjectsWithProgress = subjects.map(subject => {
      if (subject.id === 'analytical-chemistry') {
        return {
          ...subject,
          totalQuestions: 376,
          completedQuestions: 3,
          hasProgress: true
        };
      }
      if (subject.id === 'microbiology-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 269,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'biochemistry-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 340,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'pharmacology-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 352,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'botany-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 313,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'pathophysiology-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 370,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'physical-chemistry-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 283,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      if (subject.id === 'organic-chemistry-pharmaceutical') {
        return {
          ...subject,
          totalQuestions: 318,
          completedQuestions: 0,
          hasProgress: true
        };
      }
      return subject;
    });

    if (!session?.user?.id) {
      console.log('👤 Користувач не авторизований, прогрес не завантажується');
      return subjectsWithProgress // Повертаємо з хардкод даними для фармації
    }

    console.log('📊 Завантаження прогресу для предметів:', subjects.map(s => ({ id: s.id, title: s.title })));

    const finalSubjectsWithProgress = await Promise.all(
      subjectsWithProgress.map(async (subject) => {
        // Пропускаємо фармацевтичні предмети - вже мають хардкод дані
        if (subject.id === 'analytical-chemistry' || subject.id === 'microbiology-pharmaceutical' || subject.id === 'biochemistry-pharmaceutical' || subject.id === 'pharmacology-pharmaceutical' || subject.id === 'botany-pharmaceutical') {
          return subject;
        }

        try {
          console.log(`🔍 Завантаження прогресу для ${subject.title} (${subject.id})`);
          const response = await fetch(`/api/test-progress?testType=${subject.id}`)
          if (response.ok) {
            const data = await response.json()
            console.log(`📈 Відповідь API для ${subject.title}:`, data);
            if (data.success && data.progress) {
              const completedQuestions = Object.keys(data.progress).length
              console.log(`✅ Прогрес для ${subject.title}: ${completedQuestions} питань`);
              return {
                ...subject,
                completedQuestions,
                hasProgress: true
              }
            } else {
              console.log(`❌ Немає прогресу для ${subject.title}`);
            }
          } else {
            console.log(`❌ Помилка API для ${subject.title}:`, response.status, response.statusText);
          }
        } catch (error) {
          console.error(`❌ Помилка завантаження прогресу для ${subject.title}:`, error)
        }
        return subject
      })
    )

    console.log('📋 Фінальні дані з прогресом:', finalSubjectsWithProgress);
    return finalSubjectsWithProgress
  }

  const fetchSubjects = async () => {
    setLoading(true)
    setError(null)
    
    // Перевіряємо фронтенд кеш
    const cacheKey = `bases_${selectedFaculty}`;
    const cached = basesCache.get(cacheKey);
    
    if (cached && (Date.now() - cached.timestamp) < FRONTEND_CACHE_DURATION) {
      console.log('📦 Using cached bases data from frontend');
      setSubjects(cached.data);
      setLoading(false);
      return;
    }
    
    console.log('🏥 Завантаження предметів для факультету:', selectedFaculty);
    
    try {
      const params = new URLSearchParams({
        faculty: selectedFaculty
      })
      
      const response = await fetch(`/api/tests?${params}`)
      const data: ApiResponse = await response.json()
      
      let subjectsData: TestSubject[] = []
      
      if (data.success && data.subjects) {
        subjectsData = data.subjects
        console.log('📚 Отримано предмети з API:', subjectsData);
      } else {
        throw new Error('Помилка при завантаженні тестів')
      }
      
      // Завантажуємо прогрес користувача
      const subjectsWithProgress = await loadUserProgress(subjectsData)
      setSubjects(subjectsWithProgress)
      
      // Зберігаємо в фронтенд кеш
      basesCache.set(cacheKey, {
        data: subjectsWithProgress,
        timestamp: Date.now()
      });
      
      console.log('💾 Cached bases data in frontend for key:', cacheKey);
      
    } catch (err) {
      console.error('Error fetching subjects:', err)
      setError(err instanceof Error ? err.message : 'Помилка при завантаженні тестів')
      
      // Fallback to mock data
      let fallbackSubjects: TestSubject[] = []
      if (selectedFaculty === 'medical') {
        fallbackSubjects = medicalSubjectsKrok1
        console.log('🏥 Використовуємо fallback медичні предмети:', fallbackSubjects);
      } else {
        fallbackSubjects = pharmaceuticalSubjectsKrok1
        console.log('💊 Використовуємо fallback фармацевтичні предмети:', fallbackSubjects);
      }
      
      // Завантажуємо прогрес для fallback даних
      const subjectsWithProgress = await loadUserProgress(fallbackSubjects)
      
      // Для фармації завжди показуємо хардкод дані
      if (selectedFaculty === 'pharmaceutical') {
        const pharmaceuticalData = [
          {
            id: 'analytical-chemistry',
            title: 'Аналітична хімія',
            totalQuestions: 376,
            completedQuestions: 3,
            hasProgress: true
          },
          {
            id: 'microbiology-pharmaceutical',
            title: 'Мікробіологія',
            totalQuestions: 269,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'biochemistry-pharmaceutical',
            title: 'Біохімія',
            totalQuestions: 340,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'pharmacology-pharmaceutical',
            title: 'Фармакологія',
            totalQuestions: 352,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'botany-pharmaceutical',
            title: 'Ботаніка',
            totalQuestions: 313,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'pathophysiology-pharmaceutical',
            title: 'Патофізіологія',
            totalQuestions: 370,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'physical-chemistry-pharmaceutical',
            title: 'Фізична та колоїдна хімія',
            totalQuestions: 283,
            completedQuestions: 0,
            hasProgress: true
          },
          {
            id: 'organic-chemistry-pharmaceutical',
            title: 'Органічна хімія',
            totalQuestions: 316,
            completedQuestions: 0,
            hasProgress: true
          }
        ];
        console.log('💊 Встановлюємо хардкод дані для фармації:', pharmaceuticalData);
        setSubjects(pharmaceuticalData);
      } else {
        setSubjects(subjectsWithProgress);
      }
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    if (facultyLoaded) {
      fetchSubjects()
    }
  }, [selectedFaculty, session?.user?.id, facultyLoaded])

  const handleStartTest = (testId: string) => {
    // Для анатомії перенаправляємо на нову сторінку тесту
    if (testId === 'anatomy') {
      window.location.href = '/anatomy-test'
      return
    }
    
    // Для гістології перенаправляємо на нову сторінку тесту
    if (testId === 'histology') {
      window.location.href = '/histology-test'
      return
    }
    
    // Для фізіології перенаправляємо на нову сторінку тесту
    if (testId === 'physiology') {
      window.location.href = '/physiology-test'
      return
    }
    
    // Для фармакології перенаправляємо на нову сторінку тесту
    if (testId === 'pharmacology') {
      window.location.href = '/pharmacology-test'
      return
    }
    
    // Для біології перенаправляємо на нову сторінку тесту
    if (testId === 'biology') {
      window.location.href = '/biology-test'
      return
    }
    
    // Для патології перенаправляємо на нову сторінку тесту
    if (testId === 'pathology') {
      window.location.href = '/pathology-test'
      return
    }
    
    // Для патологічної фізіології перенаправляємо на нову сторінку тесту
    if (testId === 'pathophysiology') {
      window.location.href = '/pathophysiology-test'
      return
    }
    
    // Для мікробіології перенаправляємо на нову сторінку тесту
    if (testId === 'microbiology') {
      window.location.href = '/microbiology-test'
      return
    }
    
    // Для патоморфології перенаправляємо на нову сторінку тесту
    if (testId === 'pathomorphology') {
      window.location.href = '/pathomorphology-test'
      return
    }
    
    // Для аналітичної хімії перенаправляємо на сторінку тесту
    if (testId === 'analytical-chemistry') {
      window.location.href = '/analytical-chemistry-test'
      return
    }
    
    // Для мікробіології фармації перенаправляємо на сторінку тесту
    if (testId === 'microbiology-pharmaceutical') {
      window.location.href = '/microbiology-pharmaceutical-test'
      return
    }
    
    // Для біохімії фармації перенаправляємо на сторінку тесту
    if (testId === 'biochemistry-pharmaceutical') {
      window.location.href = '/biochemistry-pharmaceutical-test'
      return
    }
    
    // Для фармакології фармації перенаправляємо на сторінку тесту
    if (testId === 'pharmacology-pharmaceutical') {
      window.location.href = '/pharmacology-pharmaceutical-test'
      return
    }
    
    // Для ботаніки фармації перенаправляємо на сторінку тесту
    if (testId === 'botany-pharmaceutical') {
      window.location.href = '/botany-pharmaceutical-test'
      return
    }
    
    // Для патофізіології фармації перенаправляємо на сторінку тесту
    if (testId === 'pathophysiology-pharmaceutical') {
      window.location.href = '/pathophysiology-pharmaceutical-test'
      return
    }
    
    // Для фізичної та колоїдної хімії фармації перенаправляємо на сторінку тесту
    if (testId === 'physical-chemistry-pharmaceutical') {
      window.location.href = '/physical-chemistry-pharmaceutical-test'
      return
    }
    
    // Для органічної хімії фармації перенаправляємо на сторінку тесту
    if (testId === 'organic-chemistry-pharmaceutical') {
      window.location.href = '/organic-chemistry-pharmaceutical-test'
      return
    }
    
    // Для інших тестів - стандартне перенаправлення
    window.location.href = `/test/${testId}?faculty=${selectedFaculty}`
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-6">Бази</h1>
          
          {/* Faculty Selection */}
          <div className="flex flex-col sm:flex-row gap-4 mb-6">
            {/* Faculty Filter */}
            <CustomSelect
              value={selectedFaculty}
              onChange={(value) => setSelectedFaculty(value as any)}
              options={[
                { value: 'medical', label: 'Медицина' },
                { value: 'pharmaceutical', label: 'Фармація' }
              ]}
              className="min-w-[140px]"
            />
          </div>
        </div>

        {/* Loading State */}
        {loading && (
          <div className="text-center py-12">
            <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
            <div className="text-gray-500 text-lg mt-4">Завантаження тестів...</div>
          </div>
        )}

        {/* Error State */}
        {error && !loading && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
            <div className="text-red-800">
              <strong>Помилка:</strong> {error}
            </div>
          </div>
        )}

        {/* Subjects Grid */}
        {!loading && selectedFaculty === 'pharmaceutical' && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <TestCard
              key="analytical-chemistry"
              id="analytical-chemistry"
              title="Аналітична хімія"
              totalQuestions={376}
              completedQuestions={3}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="microbiology-pharmaceutical"
              id="microbiology-pharmaceutical"
              title="Мікробіологія"
              totalQuestions={269}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="biochemistry-pharmaceutical"
              id="biochemistry-pharmaceutical"
              title="Біохімія"
              totalQuestions={340}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="pharmacology-pharmaceutical"
              id="pharmacology-pharmaceutical"
              title="Фармакологія"
              totalQuestions={352}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="botany-pharmaceutical"
              id="botany-pharmaceutical"
              title="Ботаніка"
              totalQuestions={313}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="pathophysiology-pharmaceutical"
              id="pathophysiology-pharmaceutical"
              title="Патофізіологія"
              totalQuestions={370}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
            <TestCard
              key="physical-chemistry-pharmaceutical"
              id="physical-chemistry-pharmaceutical"
              title="Фізична та колоїдна хімія"
              totalQuestions={283}
              completedQuestions={0}
              bestScore={undefined}
              hasProgress={true}
              isCompleted={false}
              onStartTest={handleStartTest}
            />
        <TestCard
          key="organic-chemistry-pharmaceutical"
          id="organic-chemistry-pharmaceutical"
          title="Органічна хімія"
          totalQuestions={318}
          completedQuestions={0}
          bestScore={undefined}
          hasProgress={true}
          isCompleted={false}
          onStartTest={handleStartTest}
        />
          </div>
        )}
        
        {!loading && selectedFaculty !== 'pharmaceutical' && subjects.length > 0 && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {subjects.map((subject) => (
              <TestCard
                key={subject.id}
                id={subject.id}
                title={subject.title}
                totalQuestions={subject.totalQuestions}
                completedQuestions={subject.completedQuestions}
                bestScore={subject.bestScore}
                hasProgress={subject.hasProgress}
                isCompleted={subject.isCompleted}
                onStartTest={handleStartTest}
              />
            ))}
          </div>
        )}

        {/* Empty State */}
        {!loading && subjects.length === 0 && (
          <div className="text-center py-12">
            <div className="text-gray-500 text-lg">
              Немає доступних тестів для обраних фільтрів
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
