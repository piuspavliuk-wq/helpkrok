'use client'

import { useParams, useSearchParams } from 'next/navigation'
import BrochureTest from '@/components/testing/BrochureTest'

export default function KrokTestPage() {
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
