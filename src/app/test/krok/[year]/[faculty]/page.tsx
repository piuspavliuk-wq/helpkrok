'use client'

import { useParams } from 'next/navigation'
import BrochureTest from '@/components/testing/BrochureTest'

export default function KrokTestPage() {
  const params = useParams()
  const year = params.year as string
  const faculty = params.faculty as string
  
  const testId = `krok-${year}-${faculty}`
  const testName = `КРОК ${year} - ${faculty === 'medical' ? 'Медичний' : 'Фармацевтичний'} факультет`

  return (
    <BrochureTest 
      testId={testId}
      year={year}
      faculty={faculty}
      testName={testName}
    />
  )
}
