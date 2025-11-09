'use client'

import { useSession } from 'next-auth/react'
import { ReactNode } from 'react'
import Link from 'next/link'
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
        <div className="max-w-md w-full bg-white rounded-2xl shadow-xl p-8 text-center">
          <div className="mb-6">
            <div className="w-20 h-20 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <LogIn className="w-10 h-10 text-blue-600" />
            </div>
            <h2 className="text-2xl font-bold text-gray-800 mb-2">
              Потрібна авторизація
            </h2>
            <p className="text-gray-600">
              Увійдіть або зареєструйтеся, щоб отримати доступ до цього розділу
            </p>
          </div>
          
          <div className="space-y-3">
            <Link href="/auth/signin" className="block">
              <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white py-6 text-lg">
                <LogIn className="w-5 h-5 mr-2" />
                Увійти в систему
              </Button>
            </Link>
            
            <Link href="/auth/signin?register=true" className="block">
              <Button 
                variant="outline" 
                className="w-full border-blue-600 text-blue-600 hover:bg-blue-50 py-6 text-lg"
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

