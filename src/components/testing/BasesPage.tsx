'use client'

import { useState, useEffect } from 'react'
import { TestCard } from '@/components/testing/TestCard'
import { CustomSelect } from '@/components/ui/CustomSelect'

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
  const [activeStep, setActiveStep] = useState<'krok1' | 'krok2' | 'krok3'>('krok1')
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical'>(faculty)
  const [selectedYearRange, setSelectedYearRange] = useState<'2001-2015' | '2015-2025'>('2001-2015')
  // Fallback mock data for medical subjects (Крок 1)
  const medicalSubjectsKrok1: TestSubject[] = [
    { id: 'anatomy', title: 'Анатомія', totalQuestions: 207 },
    { id: 'biology', title: 'Біологія', totalQuestions: 142 },
    { id: 'biochemistry', title: 'Біохімія', totalQuestions: 308 },
    { id: 'physiology', title: 'Фізіологія', totalQuestions: 280 },
    { id: 'histology', title: 'Гістологія', totalQuestions: 102 },
    { 
      id: 'microbiology', 
      title: 'Мікробіологія', 
      totalQuestions: 144, 
      completedQuestions: 0, 
      hasProgress: true 
    },
    { 
      id: 'pathomorphology', 
      title: 'Патоморфологія', 
      totalQuestions: 228, 
      completedQuestions: 5, 
      hasProgress: true, 
      isCompleted: true 
    },
    { 
      id: 'pathophysiology', 
      title: 'Патофізіологія', 
      totalQuestions: 274, 
      completedQuestions: 0, 
      hasProgress: true 
    },
    { 
      id: 'pharmacology', 
      title: 'Фармакологія', 
      totalQuestions: 267, 
      completedQuestions: 0, 
      bestScore: 78.0, 
      hasProgress: true 
    }
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

  const [subjects, setSubjects] = useState<TestSubject[]>(medicalSubjectsKrok1) // Початкові дані
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const fetchSubjects = async () => {
    setLoading(true)
    setError(null)
    
    try {
      const params = new URLSearchParams({
        faculty: selectedFaculty,
        step: activeStep,
        yearRange: selectedYearRange
      })
      
      const response = await fetch(`/api/tests?${params}`)
      const data: ApiResponse = await response.json()
      
      if (data.success && data.subjects) {
        setSubjects(data.subjects)
      } else {
        throw new Error('Помилка при завантаженні тестів')
      }
    } catch (err) {
      console.error('Error fetching subjects:', err)
      setError(err instanceof Error ? err.message : 'Помилка при завантаженні тестів')
      
      // Fallback to mock data
      if (selectedFaculty === 'medical') {
        setSubjects(medicalSubjectsKrok1)
      } else {
        setSubjects(pharmaceuticalSubjectsKrok1)
      }
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchSubjects()
  }, [selectedFaculty, activeStep, selectedYearRange])

  const handleStartTest = (testId: string) => {
    // Перенаправляємо на сторінку тесту
    window.location.href = `/test/${testId}?step=${activeStep}&faculty=${selectedFaculty}&yearRange=${selectedYearRange}`
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-6">Бази</h1>
          
          {/* Step Selection */}
          <div className="flex flex-col sm:flex-row gap-4 mb-6">
            {/* Step Filter */}
            <CustomSelect
              value={activeStep}
              onChange={(value) => setActiveStep(value as any)}
              options={[
                { value: 'krok1', label: 'Крок 1' },
                { value: 'krok2', label: 'Крок 2' },
                { value: 'krok3', label: 'Крок 3' }
              ]}
              className="min-w-[120px]"
            />

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

            {/* Year Range Filter */}
            <CustomSelect
              value={selectedYearRange}
              onChange={(value) => setSelectedYearRange(value as any)}
              options={[
                { value: '2001-2015', label: '2001-2015' },
                { value: '2015-2025', label: '2015-2025' }
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
