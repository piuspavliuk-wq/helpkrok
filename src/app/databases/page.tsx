'use client'

import { BasesPage } from '@/components/testing/BasesPage'
import AuthGuard from '@/components/auth/AuthGuard'

export default function DatabasesPage() {
  return (
    <AuthGuard>
      <BasesPage />
    </AuthGuard>
  )
}
