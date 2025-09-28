'use client'

import { useSession } from 'next-auth/react'
import { useRouter, usePathname } from 'next/navigation'
import { useEffect } from 'react'
import ProfileSubmenu from '@/components/profile/ProfileSubmenu'
import UserProfile from '@/components/auth/UserProfile'
import ProfileEditForm from '@/components/profile/ProfileEditForm'
import StatisticsTab from '@/components/profile/StatisticsTab'
import RatingTab from '@/components/profile/RatingTab'
import ScheduleTab from '@/components/profile/ScheduleTab'

export default function ProfilePage() {
  const { data: session, status } = useSession()
  const router = useRouter()
  const pathname = usePathname()

  useEffect(() => {
    if (status === 'loading') return // Still loading
    if (!session) {
      router.push('/auth/signin')
    }
  }, [session, status, router])

  const renderTabContent = () => {
    // Для основної сторінки профілю за замовчуванням показуємо розклад
    if (pathname === '/profile') {
      return <ScheduleTab />
    }
    
    switch (pathname) {
      case '/profile/statistics':
        return <StatisticsTab />
      case '/profile/rating':
        return <RatingTab />
      case '/profile/schedule':
        return <ScheduleTab />
      case '/profile/edit':
        return <ProfileEditForm />
      default:
        return <ScheduleTab />
    }
  }

  if (status === 'loading') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600"></div>
      </div>
    )
  }

  if (!session) {
    return null // Will redirect
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden">
      {/* Фонові візерунки */}
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-20 left-20 w-32 h-32 border border-blue-200 rounded-full animate-pulse"></div>
        <div className="absolute top-40 right-32 w-24 h-24 border border-blue-200 rounded-full animate-pulse delay-1000"></div>
        <div className="absolute bottom-32 left-40 w-40 h-40 border border-blue-200 rounded-full animate-pulse delay-2000"></div>
        <div className="absolute bottom-20 right-20 w-28 h-28 border border-blue-200 rounded-full animate-pulse delay-500"></div>
        <div className="absolute top-1/2 left-1/4 w-20 h-20 border border-blue-200 rounded-full animate-pulse delay-1500"></div>
        <div className="absolute top-1/3 right-1/4 w-36 h-36 border border-blue-200 rounded-full animate-pulse delay-3000"></div>
      </div>
      
      <ProfileSubmenu />
      
      <main className="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8 relative z-10">
        <div className="px-4 py-6 sm:px-0">

          <div className="max-w-6xl mx-auto">
            {renderTabContent()}
          </div>
        </div>
      </main>
    </div>
  )
}
