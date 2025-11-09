'use client'

import Link from 'next/link'
import Image from 'next/image'
import { usePathname } from 'next/navigation'
import { useEffect, useState } from 'react'
import { 
  Home, 
  Search, 
  Database, 
  Sparkles, 
  User,
  Settings,
  FileText,
  Bookmark,
  Heart,
  Folder
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
    label: 'Курси',
    mobileLabel: 'Курси',
    href: '/systems',
    icon: Settings
  },
  {
    id: 'brochures',
    label: 'Буклети',
    mobileLabel: 'Буклети',
    href: '/brochures',
    icon: FileText
  },
  {
    id: 'randomizer',
    label: 'Randomizer PRO',
    mobileLabel: 'Randomizer',
    href: '/randomizer/settings',
    icon: Sparkles
  },
  {
    id: 'saved-questions',
    label: 'Збережені питання',
    mobileLabel: 'Збережені',
    href: '/saved-questions',
    icon: Bookmark
  },
  {
    id: 'folders',
    label: 'Папки',
    mobileLabel: 'Папки',
    href: '/folders',
    icon: Folder
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
  const [isMobileNavHidden, setIsMobileNavHidden] = useState(false)
  const isTestRoute = pathname
    ? pathname.startsWith('/test') ||
      pathname === '/randomizer' ||
      pathname === '/pharmaceutical/randomizer' ||
      /-test($|\/)/.test(pathname)
    : false

  // Слухаємо зміни класу body для приховування мобільної навігації під час тесту
  useEffect(() => {
    if (isTestRoute) {
      setIsMobileNavHidden(true)
      return
    }

    const checkBodyClass = () => {
      const hasHideClass = document.body.classList.contains('hide-mobile-nav')
      const isMobile = window.innerWidth < 768
      setIsMobileNavHidden(hasHideClass && isMobile)
    }

    checkBodyClass()

    const handleResize = () => {
      const hasHideClass = document.body.classList.contains('hide-mobile-nav')
      const isMobile = window.innerWidth < 768
      setIsMobileNavHidden(hasHideClass && isMobile)
    }

    window.addEventListener('resize', handleResize)

    const observer = new MutationObserver(checkBodyClass)
    observer.observe(document.body, {
      attributes: true,
      attributeFilter: ['class']
    })

    return () => {
      observer.disconnect()
      window.removeEventListener('resize', handleResize)
    }
  }, [isTestRoute])

  return (
    <>
      {/* Desktop Sidebar - завжди показуємо на десктопі */}
      <aside className="hidden md:block w-64 bg-blue-50 fixed left-0 top-0 h-screen p-6 overflow-y-auto z-[100] shadow-lg" suppressHydrationWarning>
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
                    : 'text-gray-700 hover:bg-blue-100 hover:text-gray-900 hover:shadow-sm'
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

      {/* Mobile Bottom Navigation - приховуємо тільки на мобільних під час тесту */}
      <nav className={`${isMobileNavHidden ? 'hidden' : 'md:hidden'} mobile-nav fixed bottom-0 left-0 right-0 bg-blue-50 border-t border-gray-200 py-1.5 z-[100]`} suppressHydrationWarning>
        <div className="flex overflow-x-auto scrollbar-hide px-4 space-x-1">
          {menuItems.map((item) => {
            const Icon = item.icon
            const isActive = pathname === item.href || 
              (item.href !== '/' && pathname.startsWith(item.href))
            
            return (
              <Link
                key={item.id}
                href={item.href}
                className={`
                  flex flex-col items-center py-1.5 px-2 rounded-lg transition-all duration-200 flex-shrink-0 min-w-[65px]
                  ${isActive 
                    ? 'text-slate-800 bg-slate-200' 
                    : 'text-gray-700 hover:bg-blue-100 hover:text-gray-900'
                  }
                `}
              >
                <Icon className="w-4 h-4 mb-0.5" />
                <span className="text-xs font-medium text-center leading-tight whitespace-nowrap" style={{fontSize: '10px'}}>
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
