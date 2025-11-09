'use client'

import { useSession } from 'next-auth/react'
import { ReactNode } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import { LogIn, UserPlus } from 'lucide-react'
import { Button } from '@/components/ui/button'

interface AuthGuardProps {
  children: ReactNode
  showOnMainPage?: boolean
}

export default function AuthGuard({ children, showOnMainPage = false }: AuthGuardProps) {
  const { data: session, status } = useSession()

  // Якщо це головна сторінка, завжди показуємо контент
  if (showOnMainPage) {
    return <>{children}</>
  }

  // Показуємо завантаження
  if (status === 'loading') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження...</p>
        </div>
      </div>
    )
  }

  // Якщо користувач не авторизований, показуємо кнопку входу/реєстрації
  if (!session) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center px-4">
        <div className="max-w-md md:max-w-xl lg:max-w-2xl w-full bg-white rounded-2xl shadow-xl p-6 md:p-10 lg:p-12 text-left">
          {/* Logo */}
          <div className="mb-8">
            <Link href="/" className="flex items-center justify-start space-x-3 mb-8">
              <Image 
                src="/logo-original.png" 
                alt="Help Krok Logo" 
                width={48} 
                height={48}
                className="w-12 h-12 md:w-14 md:h-14"
              />
              <div>
                <h1 className="text-xl md:text-2xl font-bold" style={{color: '#4C1D95'}}>HelpKrok</h1>
                <p className="text-xs md:text-sm" style={{color: '#8B5CF6'}}>by j.helpNMU</p>
              </div>
            </Link>
          </div>

          <div className="mb-6 text-left">
            <h2 className="text-lg md:text-xl font-bold text-gray-800 mb-2">
              Потрібна авторизація
            </h2>
          </div>
          
          <div className="space-y-3 md:space-y-4">
            <Link href="/auth/signin" className="block">
              <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 md:py-4 text-base md:text-lg">
                <LogIn className="w-5 h-5 mr-2" />
                Увійти в систему
              </Button>
            </Link>
            
            <Link href="/auth/signin?register=true" className="block">
              <Button 
                variant="outline" 
                className="w-full border-blue-600 text-blue-600 hover:bg-blue-50 py-3 md:py-4 text-base md:text-lg"
              >
                <UserPlus className="w-5 h-5 mr-2" />
                Зареєструватися
              </Button>
            </Link>
          </div>

          <div className="mt-6 pt-6 border-t border-gray-200">
            <Link 
              href="/" 
              className="text-blue-600 hover:text-blue-700 text-sm font-medium"
            >
              ← Повернутися на головну
            </Link>
          </div>
        </div>
      </div>
    )
  }

  // Якщо користувач авторизований, показуємо контент
  return <>{children}</>
}

