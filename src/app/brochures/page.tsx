'use client'

import BrochuresComponent from '@/components/brochures/BrochuresComponent'
import AuthGuard from '@/components/auth/AuthGuard'

export default function BrochuresPage() {
  return (
    <AuthGuard>
      <BrochuresComponent faculty="medical" />
    </AuthGuard>
  )
}







