'use client'

import AdminPanel from '@/components/profile/AdminPanel'
import AuthGuard from '@/components/auth/AuthGuard'

export default function AdminPage() {
  return (
    <AuthGuard>
      <AdminPanel />
    </AuthGuard>
  )
}



