'use client'

import BrochuresComponent from '@/components/brochures/BrochuresComponent'
import AuthGuard from '@/components/auth/AuthGuard'

export default function BrochuresPharmacyPage() {
  return (
    <AuthGuard>
      <BrochuresComponent faculty="pharmaceutical" />
    </AuthGuard>
  )
}
