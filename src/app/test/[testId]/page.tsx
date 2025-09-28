'use client'

import { useSearchParams, useRouter } from 'next/navigation'
import { useEffect } from 'react'
import UniversalTest from '@/components/testing/UniversalTest'
import BrochureTest from '@/components/testing/BrochureTest'

export default function TestPage() {
  const searchParams = useSearchParams()
  const router = useRouter()
  const testId = searchParams.get('testId') || 'krok'
  const step = searchParams.get('step') || 'krok1'
  const faculty = searchParams.get('faculty') || 'medical'
  const year = searchParams.get('year') || '2014'
  const yearRange = searchParams.get('yearRange') || year

  // Визначаємо тип тесту на основі testId
  const getTestType = (testId: string): 'anatomy' | 'histology' | 'krok' => {
    if (testId.includes('anatomy')) return 'anatomy'
    if (testId.includes('histology')) return 'histology'
    return 'krok' // За замовчуванням для КРОК тестів
  }

  const getTestName = (testId: string, faculty: string, year: string) => {
    if (testId.includes('krok')) {
      return `КРОК ${year} - ${faculty === 'medical' ? 'Медичний' : 'Фармацевтичний'} факультет`
    }
    if (testId.includes('anatomy')) return 'Анатомія'
    if (testId.includes('histology')) return 'Гістологія'
    return 'Тест'
  }

  const testType = getTestType(testId)
  const testName = getTestName(testId, faculty, year)

  // Перенаправляємо КРОК тести на новий маршрут
  useEffect(() => {
    if (testType === 'krok') {
      router.replace(`/test/krok/${year}/${faculty}`)
    }
  }, [testType, year, faculty, router])

  // Для КРОК тестів показуємо завантаження (поки перенаправляємо)
  if (testType === 'krok') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Перенаправлення на тест...</p>
        </div>
      </div>
    )
  }

  // Для інших тестів використовуємо UniversalTest
  return (
    <UniversalTest 
      testType={testType} 
      testName={testName}
    />
  )
}
