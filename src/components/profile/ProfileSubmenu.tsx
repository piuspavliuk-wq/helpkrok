'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { signOut } from 'next-auth/react'
import { Calendar, User, Bookmark, BarChart3, Trophy, LogOut } from 'lucide-react'

interface SubmenuItem {
  id: string
  label: string
  href: string
  icon: React.ComponentType<{ className?: string }>
}

const submenuItems: SubmenuItem[] = [
  {
    id: 'schedule',
    label: 'Розклад',
    href: '/profile/schedule',
    icon: Calendar
  },
  {
    id: 'profile',
    label: 'Профіль',
    href: '/profile',
    icon: User
  },
  {
    id: 'statistics',
    label: 'Статистика',
    href: '/profile/statistics',
    icon: BarChart3
  },
  {
    id: 'rating',
    label: 'Рейтинг',
    href: '/profile/rating',
    icon: Trophy
  },
  {
    id: 'saved',
    label: 'Збережені',
    href: '/profile/saved',
    icon: Bookmark
  }
]

export default function ProfileSubmenu() {
  const pathname = usePathname()

  const handleSignOut = async () => {
    await signOut({ callbackUrl: '/' })
  }

  return (
    <div className="relative z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Desktop layout */}
        <div className="hidden md:flex justify-between items-center">
          <nav className="flex space-x-8">
            {submenuItems.map((item) => {
              const Icon = item.icon
              const isActive = pathname === item.href || 
                (item.href === '/profile' && pathname === '/profile') ||
                (item.href === '/profile/statistics' && pathname === '/profile/statistics') ||
                (item.href === '/profile/rating' && pathname === '/profile/rating')
              
              return (
                <Link
                  key={item.id}
                  href={item.href}
                  className={`
                    flex items-center space-x-2 py-4 px-1 border-b-2 font-medium text-sm transition-colors duration-200
                    ${isActive 
                      ? 'border-blue-500 text-blue-600' 
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                    }
                  `}
                >
                  <Icon className="w-4 h-4" />
                  <span>{item.label}</span>
                </Link>
              )
            })}
          </nav>
          
          <button
            onClick={handleSignOut}
            className="flex items-center space-x-2 py-2 px-4 text-red-600 hover:text-red-700 hover:bg-red-50 rounded-md transition-colors duration-200"
            title="Вийти з системи"
          >
            <LogOut className="w-4 h-4" />
            <span className="text-sm font-medium">Вийти</span>
          </button>
        </div>

        {/* Mobile layout with horizontal scroll */}
        <div className="md:hidden">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Профіль</h2>
            <button
              onClick={handleSignOut}
              className="flex items-center space-x-1 py-1 px-2 text-red-600 hover:text-red-700 hover:bg-red-50 rounded-md transition-colors duration-200"
              title="Вийти з системи"
            >
              <LogOut className="w-4 h-4" />
              <span className="text-xs font-medium">Вийти</span>
            </button>
          </div>
          
          <div className="overflow-x-auto scrollbar-hide">
            <nav className="flex space-x-4 min-w-max pb-2">
              {submenuItems.map((item) => {
                const Icon = item.icon
                const isActive = pathname === item.href || 
                  (item.href === '/profile' && pathname === '/profile') ||
                  (item.href === '/profile/statistics' && pathname === '/profile/statistics') ||
                  (item.href === '/profile/rating' && pathname === '/profile/rating')
                
                return (
                  <Link
                    key={item.id}
                    href={item.href}
                    className={`
                      flex items-center space-x-2 py-3 px-3 border-b-2 font-medium text-sm transition-colors duration-200 whitespace-nowrap rounded-t-lg
                      ${isActive 
                        ? 'border-blue-500 text-blue-600 bg-blue-50' 
                        : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 hover:bg-gray-50'
                      }
                    `}
                  >
                    <Icon className="w-4 h-4 flex-shrink-0" />
                    <span>{item.label}</span>
                  </Link>
                )
              })}
            </nav>
          </div>
        </div>
      </div>
    </div>
  )
}
