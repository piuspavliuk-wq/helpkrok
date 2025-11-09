'use client'

import SearchComponent from '@/components/search/SearchComponent'
import AuthGuard from '@/components/auth/AuthGuard'

export default function SearchPage() {
  return (
    <AuthGuard>
      <SearchComponent />
    </AuthGuard>
  )
}
