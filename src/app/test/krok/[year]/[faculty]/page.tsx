'use client'

import { useParams, useSearchParams } from 'next/navigation'
import { Suspense } from 'react'
import BrochureTest from '@/components/testing/BrochureTest'
import AuthGuard from '@/components/auth/AuthGuard'

function KrokTestContent() {
  const params = useParams()
  const searchParams = useSearchParams()
  const year = params.year as string
  const faculty = params.faculty as string
  const test_identifier = searchParams.get('test_identifier')
  
  const testId = `krok-${year}-${faculty}${test_identifier ? `-${test_identifier}` : ''}`
  const testName = `КРОК ${year} - ${faculty === 'medical' ? 'Медичний' : 'Фармацевтичний'} факультет`

  return (
    <BrochureTest 
      testId={testId}
      year={year}
      faculty={faculty}
      testName={testName}
      test_identifier={test_identifier}
    />
  )
}

export default function KrokTestPage() {
  return (
    <AuthGuard>
      <Suspense fallback={
        <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
          <div className="text-center">
            <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-xl text-gray-600">Завантаження...</p>
          </div>
        </div>
      }>
        <KrokTestContent />
      </Suspense>
    </AuthGuard>
  )
}
