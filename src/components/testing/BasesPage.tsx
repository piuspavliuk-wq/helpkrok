'use client'

import { useState, useEffect } from 'react'
import { TestCard } from '@/components/testing/TestCard'
import { CustomSelect } from '@/components/ui/CustomSelect'
import { useSession } from 'next-auth/react'

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
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical'>(faculty)
  const { data: session } = useSession()

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
    { id: 'pharm-chem', title: 'Фармацевтична хімія', totalQuestions: 180 },
    { id: 'pharm-tech', title: 'Фармацевтична технологія', totalQuestions: 220 },
    { id: 'pharm-analysis', title: 'Фармацевтичний аналіз', totalQuestions: 150 },
    { id: 'pharm-management', title: 'Фармацевтичне менеджмент', totalQuestions: 120 },
    { id: 'pharm-law', title: 'Фармацевтичне право', totalQuestions: 90 },
    { id: 'pharm-economics', title: 'Фармацевтична економіка', totalQuestions: 110 }
  ]

  const [subjects, setSubjects] = useState<TestSubject[]>([]) // Початкові дані
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  // Функція для завантаження прогресу користувача
  const loadUserProgress = async (subjects: TestSubject[]) => {
    if (!session?.user?.id) {
      return subjects // Якщо користувач не авторизований, повертаємо без прогресу
    }

    const subjectsWithProgress = await Promise.all(
      subjects.map(async (subject) => {
        try {
          const response = await fetch(`/api/test-progress?testType=${subject.id}`)
          if (response.ok) {
            const data = await response.json()
            if (data.success && data.progress) {
              const completedQuestions = Object.keys(data.progress).length
              return {
                ...subject,
                completedQuestions,
                hasProgress: true
              }
            }
          }
        } catch (error) {
          console.error(`Помилка завантаження прогресу для ${subject.title}:`, error)
        }
        return subject
      })
    )

    return subjectsWithProgress
  }

  const fetchSubjects = async () => {
    setLoading(true)
    setError(null)
    
    try {
      const params = new URLSearchParams({
        faculty: selectedFaculty
      })
      
      const response = await fetch(`/api/tests?${params}`)
      const data: ApiResponse = await response.json()
      
      let subjectsData: TestSubject[] = []
      
      if (data.success && data.subjects) {
        subjectsData = data.subjects
      } else {
        throw new Error('Помилка при завантаженні тестів')
      }
      
      // Завантажуємо прогрес користувача
      const subjectsWithProgress = await loadUserProgress(subjectsData)
      setSubjects(subjectsWithProgress)
      
    } catch (err) {
      console.error('Error fetching subjects:', err)
      setError(err instanceof Error ? err.message : 'Помилка при завантаженні тестів')
      
      // Fallback to mock data
      let fallbackSubjects: TestSubject[] = []
      if (selectedFaculty === 'medical') {
        fallbackSubjects = medicalSubjectsKrok1
      } else {
        fallbackSubjects = pharmaceuticalSubjectsKrok1
      }
      
      // Завантажуємо прогрес для fallback даних
      const subjectsWithProgress = await loadUserProgress(fallbackSubjects)
      setSubjects(subjectsWithProgress)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchSubjects()
  }, [selectedFaculty, session?.user?.id])

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
    
    // Для інших тестів - стандартне перенаправлення
    window.location.href = `/test/${testId}?faculty=${selectedFaculty}`
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100">
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
        {!loading && subjects.length > 0 && (
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
