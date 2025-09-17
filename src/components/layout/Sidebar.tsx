'use client'

import Link from 'next/link'
import Image from 'next/image'
import { usePathname } from 'next/navigation'
import { 
  Home, 
  Search, 
  Database, 
  Sparkles, 
  User,
  Settings
} from 'lucide-react'

interface MenuItem {
  id: string
  label: string
  mobileLabel: string
  href: string
  icon: React.ComponentType<{ className?: string }>
}

const menuItems: MenuItem[] = [
  {
    id: 'home',
    label: 'Головна',
    mobileLabel: 'Головна',
    href: '/',
    icon: Home
  },
  {
    id: 'search',
    label: 'Знайти тест',
    mobileLabel: 'Пошук',
    href: '/search',
    icon: Search
  },
  {
    id: 'databases',
    label: 'Бази',
    mobileLabel: 'Бази',
    href: '/databases',
    icon: Database
  },
  {
    id: 'systems',
    label: 'Системи',
    mobileLabel: 'Системи',
    href: '/systems',
    icon: Settings
  },
  {
    id: 'randomizer',
    label: 'Randomizer PRO',
    mobileLabel: 'Randomizer',
    href: '/randomizer',
    icon: Sparkles
  },
  {
    id: 'profile',
    label: 'Мій профіль',
    mobileLabel: 'Профіль',
    href: '/profile',
    icon: User
  }
]

export default function Sidebar() {
  const pathname = usePathname()

  return (
    <>
      {/* Desktop Sidebar */}
      <aside className="hidden md:block w-64 bg-blue-50 fixed left-0 top-0 h-screen p-6 overflow-y-auto z-10 shadow-lg">
        {/* Logo */}
        <div className="mb-8 pt-4">
          <Link href="/" className="flex items-center space-x-3">
            <Image 
              src="/logo-original.png" 
              alt="Help Krok Logo" 
              width={32} 
              height={32}
              className="w-8 h-8"
            />
            <div>
              <h1 className="text-lg font-bold" style={{color: '#4C1D95'}}>HelpKrok</h1>
              <p className="text-xs" style={{color: '#8B5CF6'}}>by j.helpNMU</p>
            </div>
          </Link>
        </div>
        
        {/* Navigation Menu */}
        <div className="space-y-1">
          {menuItems.map((item) => {
            const Icon = item.icon
            const isActive = pathname === item.href || 
              (item.href !== '/' && pathname.startsWith(item.href))
            
            return (
              <Link
                key={item.id}
                href={item.href}
                className={`
                  flex items-center space-x-3 px-3 py-3 rounded-lg transition-all duration-200
                  ${isActive 
                    ? 'bg-slate-200 text-slate-800 font-medium shadow-sm' 
                    : 'text-gray-700 hover:bg-white hover:text-gray-900 hover:shadow-sm'
                  }
                `}
              >
                <Icon className="w-5 h-5 flex-shrink-0" />
                <span className="text-sm font-medium">{item.label}</span>
              </Link>
            )
          })}
        </div>
      </aside>

      {/* Mobile Bottom Navigation */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-blue-50 border-t border-gray-200 px-2 py-1.5 z-50">
        <div className="flex justify-around">
          {menuItems.map((item) => {
            const Icon = item.icon
            const isActive = pathname === item.href || 
              (item.href !== '/' && pathname.startsWith(item.href))
            
            return (
              <Link
                key={item.id}
                href={item.href}
                className={`
                  flex flex-col items-center py-1.5 px-1.5 rounded-lg transition-all duration-200 min-w-0 flex-1
                  ${isActive 
                    ? 'text-slate-800 bg-slate-200' 
                    : 'text-gray-700 hover:bg-white hover:text-gray-900'
                  }
                `}
              >
                <Icon className="w-4 h-4 mb-0.5" />
                <span className="text-xs font-medium text-center leading-tight" style={{fontSize: '10px'}}>
                  {item.mobileLabel}
                </span>
              </Link>
            )
          })}
        </div>
      </nav>
    </>
  )
}
