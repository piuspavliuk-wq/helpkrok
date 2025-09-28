'use client'

import { useState, useEffect } from 'react'
import { CustomSelect } from '@/components/ui/CustomSelect'

interface Brochure {
  id: string
  year: number
  faculty: string
  title: string
  description: string
  totalQuestions: number
  completedQuestions?: number
  hasProgress?: boolean
  isCompleted?: boolean
  is_active: boolean
  created_at: string
  updated_at: string
}

interface BrochuresPageProps {
  faculty?: 'medical' | 'pharmaceutical'
}

export default function BrochuresComponent({ faculty = 'medical' }: BrochuresPageProps) {
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical'>(faculty)
  const [brochures, setBrochures] = useState<Brochure[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  // Fallback mock data for medical brochures
  const medicalBrochures: Brochure[] = [
    { id: 'krok-2024-medical', year: 2024, faculty: 'medical', title: 'КРОК 2024 - Медичний факультет', description: 'Тест КРОК 2024 року для медичного факультету', totalQuestions: 150, completedQuestions: 10, hasProgress: true, is_active: true, created_at: '2024-01-01', updated_at: '2024-01-01' },
    { id: 'krok-2021-1day-medical', year: 2021, faculty: 'medical', title: 'КРОК 2021 (1 день) - Медичний факультет', description: 'Тест КРОК 2021 року (1 день) для медичного факультету', totalQuestions: 148, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2021-01-01', updated_at: '2021-01-01' },
    { id: 'krok-2020-osinnia-medical', year: 2020, faculty: 'medical', title: 'КРОК 2020 (осіння сесія) - Медичний факультет', description: 'Тест КРОК 2020 року (осіння сесія) для медичного факультету', totalQuestions: 143, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2020-10-01', updated_at: '2020-10-01' },
    { id: 'krok-2020-vesna-medical', year: 2020, faculty: 'medical', title: 'КРОК 2020 (весняна сесія) - Медичний факультет', description: 'Тест КРОК 2020 року (весняна сесія) для медичного факультету', totalQuestions: 146, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2020-05-01', updated_at: '2020-05-01' },
    { id: 'krok-2019-medical', year: 2019, faculty: 'medical', title: 'КРОК 2019 - Медичний факультет', description: 'Тест КРОК 2019 року для медичного факультету', totalQuestions: 154, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2019-01-01', updated_at: '2019-01-01' },
    { id: 'krok-2017-medical', year: 2017, faculty: 'medical', title: 'КРОК 2017 - Медичний факультет', description: 'Тест КРОК 2017 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2017-01-01', updated_at: '2017-01-01' },
    { id: 'krok-2016-medical', year: 2016, faculty: 'medical', title: 'КРОК 2016 - Медичний факультет', description: 'Тест КРОК 2016 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2016-01-01', updated_at: '2016-01-01' },
    { id: 'krok-2015-medical', year: 2015, faculty: 'medical', title: 'КРОК 2015 - Медичний факультет', description: 'Тест КРОК 2015 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2015-01-01', updated_at: '2015-01-01' },
    { id: 'krok-2014-medical', year: 2014, faculty: 'medical', title: 'КРОК 2014 - Медичний факультет', description: 'Тест КРОК 2014 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2014-01-01', updated_at: '2014-01-01' },
    { id: 'krok-2013-medical', year: 2013, faculty: 'medical', title: 'КРОК 2013 - Медичний факультет', description: 'Тест КРОК 2013 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2013-01-01', updated_at: '2013-01-01' },
    { id: 'krok-2012-medical', year: 2012, faculty: 'medical', title: 'КРОК 2012 - Медичний факультет', description: 'Тест КРОК 2012 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2012-01-01', updated_at: '2012-01-01' },
    { id: 'krok-2011-medical', year: 2011, faculty: 'medical', title: 'КРОК 2011 - Медичний факультет', description: 'Тест КРОК 2011 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2011-01-01', updated_at: '2011-01-01' },
    { id: 'krok-2010-medical', year: 2010, faculty: 'medical', title: 'КРОК 2010 - Медичний факультет', description: 'Тест КРОК 2010 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2010-01-01', updated_at: '2010-01-01' },
    { id: 'krok-2009-medical', year: 2009, faculty: 'medical', title: 'КРОК 2009 - Медичний факультет', description: 'Тест КРОК 2009 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2009-01-01', updated_at: '2009-01-01' },
    { id: 'krok-2008-medical', year: 2008, faculty: 'medical', title: 'КРОК 2008 - Медичний факультет', description: 'Тест КРОК 2008 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2008-01-01', updated_at: '2008-01-01' },
    { id: 'krok-2007-medical', year: 2007, faculty: 'medical', title: 'КРОК 2007 - Медичний факультет', description: 'Тест КРОК 2007 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2007-01-01', updated_at: '2007-01-01' },
    { id: 'krok-2006-medical', year: 2006, faculty: 'medical', title: 'КРОК 2006 - Медичний факультет', description: 'Тест КРОК 2006 року для медичного факультету', totalQuestions: 200, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2006-01-01', updated_at: '2006-01-01' },
    { id: 'krok-2023-medical', year: 2023, faculty: 'medical', title: 'КРОК 2023 - Медичний факультет', description: 'Тест КРОК 2023 року для медичного факультету', totalQuestions: 150, completedQuestions: 8, hasProgress: true, is_active: true, created_at: '2023-01-01', updated_at: '2023-01-01' },
    { id: 'krok-2022-medical', year: 2022, faculty: 'medical', title: 'КРОК 2022 - Медичний факультет', description: 'Тест КРОК 2022 року для медичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2022-01-01', updated_at: '2022-01-01' },
    { id: 'krok-2019-medical', year: 2019, faculty: 'medical', title: 'КРОК 2019 - Медичний факультет', description: 'Тест КРОК 2019 року для медичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2019-01-01', updated_at: '2019-01-01' },
    { id: 'krok-2018-medical', year: 2018, faculty: 'medical', title: 'КРОК 2018 - Медичний факультет', description: 'Тест КРОК 2018 року для медичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2018-01-01', updated_at: '2018-01-01' },
    { id: 'krok-2017-medical', year: 2017, faculty: 'medical', title: 'КРОК 2017 - Медичний факультет', description: 'Тест КРОК 2017 року для медичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2017-01-01', updated_at: '2017-01-01' }
  ]

  // Fallback mock data for pharmaceutical brochures
  const pharmaceuticalBrochures: Brochure[] = [
    { id: 'krok-2024-pharmacy', year: 2024, faculty: 'pharmaceutical', title: 'КРОК 2024 - Фармацевтичний факультет', description: 'Тест КРОК 2024 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 5, hasProgress: true, is_active: true, created_at: '2024-01-01', updated_at: '2024-01-01' },
    { id: 'krok-2023-pharmacy', year: 2023, faculty: 'pharmaceutical', title: 'КРОК 2023 - Фармацевтичний факультет', description: 'Тест КРОК 2023 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2023-01-01', updated_at: '2023-01-01' },
    { id: 'krok-2022-pharmacy', year: 2022, faculty: 'pharmaceutical', title: 'КРОК 2022 - Фармацевтичний факультет', description: 'Тест КРОК 2022 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2022-01-01', updated_at: '2022-01-01' },
    { id: 'krok-2021-pharmacy', year: 2021, faculty: 'pharmaceutical', title: 'КРОК 2021 - Фармацевтичний факультет', description: 'Тест КРОК 2021 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2021-01-01', updated_at: '2021-01-01' },
    { id: 'krok-2020-pharmacy', year: 2020, faculty: 'pharmaceutical', title: 'КРОК 2020 - Фармацевтичний факультет', description: 'Тест КРОК 2020 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2020-01-01', updated_at: '2020-01-01' },
    { id: 'krok-2019-pharmacy', year: 2019, faculty: 'pharmaceutical', title: 'КРОК 2019 - Фармацевтичний факультет', description: 'Тест КРОК 2019 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2019-01-01', updated_at: '2019-01-01' },
    { id: 'krok-2018-pharmacy', year: 2018, faculty: 'pharmaceutical', title: 'КРОК 2018 - Фармацевтичний факультет', description: 'Тест КРОК 2018 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2018-01-01', updated_at: '2018-01-01' },
    { id: 'krok-2017-pharmacy', year: 2017, faculty: 'pharmaceutical', title: 'КРОК 2017 - Фармацевтичний факультет', description: 'Тест КРОК 2017 року для фармацевтичного факультету', totalQuestions: 150, completedQuestions: 0, hasProgress: true, is_active: true, created_at: '2017-01-01', updated_at: '2017-01-01' }
  ]

  const fetchBrochures = async () => {
    setLoading(true)
    setError(null)
    
    try {
      // Спочатку завантажуємо базові дані буклетів
      const brochuresResponse = await fetch(`/api/brochures?faculty=${selectedFaculty}&t=${Date.now()}`, {
        cache: 'no-cache',
        headers: {
          'Cache-Control': 'no-cache'
        }
      })
      
      if (!brochuresResponse.ok) {
        throw new Error(`HTTP error! status: ${brochuresResponse.status}`)
      }
      
      const brochuresData = await brochuresResponse.json()
      let booklets = brochuresData.booklets || []
      
      // Тепер завантажуємо прогрес користувача безпосередньо
      try {
        const progressResponse = await fetch(`/api/user/progress-test?userId=test-user-123`)
        
        if (progressResponse.ok) {
          const progressData = await progressResponse.json()
          
          if (progressData.success && progressData.progress) {
            // Оновлюємо буклети з реальним прогресом
            booklets = booklets.map((booklet: any) => {
              const progress = progressData.progress.find((p: any) => 
                p.year === booklet.year && p.faculty === booklet.faculty
              )
              
              if (progress) {
                return {
                  ...booklet,
                  completedQuestions: progress.completed_questions,
                  totalQuestions: progress.total_questions,
                  hasProgress: true,
                  isCompleted: progress.completed_questions >= progress.total_questions
                }
              }
              
              return booklet
            })
          }
        }
      } catch (progressErr) {
        console.error('Error fetching progress:', progressErr)
      }
      
      setBrochures(booklets)
      
    } catch (err) {
      console.error('Error fetching brochures:', err)
      console.error('Error details:', err)
      setError(err instanceof Error ? err.message : 'Помилка при завантаженні буклетів')
      
      // Fallback to mock data з актуальними даними
      let fallbackBrochures: Brochure[] = []
      if (selectedFaculty === 'medical') {
        fallbackBrochures = medicalBrochures.map(brochure => ({
          ...brochure,
          completedQuestions: 0, // Скидаємо прогрес для fallback даних
          hasProgress: false // Приховуємо прогрес для fallback даних
        }))
      } else {
        fallbackBrochures = pharmaceuticalBrochures.map(brochure => ({
          ...brochure,
          completedQuestions: 0, // Скидаємо прогрес для fallback даних
          hasProgress: false // Приховуємо прогрес для fallback даних
        }))
      }
      
      setBrochures(fallbackBrochures)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchBrochures()
  }, [selectedFaculty])


  const handleOpenBrochure = (brochureId: string) => {
    // Перенаправляємо на сторінку тесту з параметрами
    const brochure = brochures.find(b => b.id === brochureId)
    if (brochure) {
      // Використовуємо рік з об'єкта brochure
      const year = brochure.year.toString()
      
      // Перенаправляємо на сторінку тесту
      window.location.href = `/test/krok/${year}/${brochure.faculty}`
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-6">Буклети</h1>
          
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
            <div className="text-gray-500 text-lg mt-4">Завантаження буклетів...</div>
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

        {/* Brochures Grid */}
        {!loading && brochures.length > 0 && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {brochures.map((brochure) => (
              <div
                key={brochure.id}
                className="bg-white/30 backdrop-blur-sm rounded-lg shadow-sm border border-white/40 p-6 hover:shadow-md hover:bg-white/40 transition-all duration-300"
              >
                {/* Brochure Title */}
                <h3 className="text-lg font-semibold text-gray-900 mb-2">{brochure.title}</h3>
                
                {/* Description */}
                <p className="text-sm text-gray-600 mb-3">{brochure.description}</p>

                {/* Progress Info */}
                {brochure.hasProgress && (
                  <div className="mb-4">
                    <div className="flex items-center justify-between text-sm text-gray-600 mb-2">
                      <div className="flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="lucide lucide-clock w-4 h-4" aria-hidden="true">
                          <path d="M12 6v6l4 2"></path>
                          <circle cx="12" cy="12" r="10"></circle>
                        </svg>
                        <span>{brochure.completedQuestions || 0}/{brochure.totalQuestions}</span>
                      </div>
                      <span className="font-medium text-blue-600">
                        {brochure.totalQuestions > 0 ? Math.round(((brochure.completedQuestions || 0) / brochure.totalQuestions) * 100) : 0}%
                      </span>
                    </div>
                    
                    {/* Progress Bar */}
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div 
                        className="bg-blue-500 h-2 rounded-full transition-all duration-300"
                        style={{ width: `${brochure.totalQuestions > 0 ? ((brochure.completedQuestions || 0) / brochure.totalQuestions) * 100 : 0}%` }}
                      />
                    </div>
                  </div>
                )}

                {/* Question Count (if no progress) */}
                {!brochure.hasProgress && (
                  <div className="text-sm text-gray-500 mb-4">
                    {brochure.totalQuestions} питань
                  </div>
                )}

                {/* Action Button */}
                <button
                  onClick={() => handleOpenBrochure(brochure.id)}
                  className="w-full bg-blue-500/80 backdrop-blur-sm hover:bg-blue-600/90 text-white font-medium py-2 px-4 rounded-lg transition-all duration-300 shadow-sm hover:shadow-md"
                >
                  {brochure.hasProgress && (brochure.completedQuestions || 0) > 0 ? 'Продовжити' : 'Почати спробу'}
                </button>
              </div>
            ))}
          </div>
        )}

        {/* Empty State */}
        {!loading && brochures.length === 0 && (
          <div className="text-center py-12">
            <div className="text-gray-500 text-lg">
              Немає доступних буклетів для обраних фільтрів
            </div>
          </div>
        )}
      </div>
    </div>
  )
}







