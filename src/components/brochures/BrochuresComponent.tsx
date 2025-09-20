'use client'

import { useState, useEffect } from 'react'
import { CustomSelect } from '@/components/ui/CustomSelect'

interface Brochure {
  id: string
  title: string
  totalQuestions: number
  completedQuestions?: number
  hasProgress?: boolean
  isCompleted?: boolean
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
    { id: 'krok-2024-medical', title: 'КРОК 2024 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2023-medical', title: 'КРОК 2023 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2022-medical', title: 'КРОК 2022 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2021-medical', title: 'КРОК 2021 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2020-medical', title: 'КРОК 2020 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2019-medical', title: 'КРОК 2019 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2018-medical', title: 'КРОК 2018 - Медичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2017-medical', title: 'КРОК 2017 - Медичний факультет', totalQuestions: 150, hasProgress: true }
  ]

  // Fallback mock data for pharmaceutical brochures
  const pharmaceuticalBrochures: Brochure[] = [
    { id: 'krok-2024-pharmacy', title: 'КРОК 2024 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2023-pharmacy', title: 'КРОК 2023 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2022-pharmacy', title: 'КРОК 2022 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2021-pharmacy', title: 'КРОК 2021 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2020-pharmacy', title: 'КРОК 2020 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2019-pharmacy', title: 'КРОК 2019 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2018-pharmacy', title: 'КРОК 2018 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true },
    { id: 'krok-2017-pharmacy', title: 'КРОК 2017 - Фармацевтичний факультет', totalQuestions: 150, hasProgress: true }
  ]

  const fetchBrochures = async () => {
    setLoading(true)
    setError(null)
    
    try {
      // Тут можна додати API виклик для завантаження буклетів
      // const response = await fetch(`/api/brochures?faculty=${selectedFaculty}`)
      // const data = await response.json()
      
      // Поки що використовуємо mock дані
      let brochuresData: Brochure[] = []
      
      if (selectedFaculty === 'medical') {
        brochuresData = medicalBrochures
      } else {
        brochuresData = pharmaceuticalBrochures
      }
      
      setBrochures(brochuresData)
      
    } catch (err) {
      console.error('Error fetching brochures:', err)
      setError(err instanceof Error ? err.message : 'Помилка при завантаженні буклетів')
      
      // Fallback to mock data
      let fallbackBrochures: Brochure[] = []
      if (selectedFaculty === 'medical') {
        fallbackBrochures = medicalBrochures
      } else {
        fallbackBrochures = pharmaceuticalBrochures
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
    // Тут можна додати логіку для відкриття буклету
    console.log('Opening brochure:', brochureId)
    // Наприклад, відкрити PDF або перенаправити на сторінку буклету
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100">
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
                <h3 className="text-lg font-semibold text-gray-900 mb-3">{brochure.title}</h3>

                {/* Progress Info */}
                {brochure.hasProgress && (
                  <div className="mb-4">
                    <div className="flex items-center justify-between text-sm text-gray-600 mb-2">
                      <div className="flex items-center gap-2">
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







