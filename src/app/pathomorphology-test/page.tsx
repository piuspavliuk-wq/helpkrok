'use client'

import UniversalTest from '@/components/testing/UniversalTest'
import AuthGuard from '@/components/auth/AuthGuard'

export default function PathomorphologyTestPage() {
  return (
    <AuthGuard>
      <UniversalTest 
        testType="pathomorphology" 
        testName="Патоморфологія" 
      />
    </AuthGuard>
  )
}
