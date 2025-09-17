'use client'

import { Suspense } from 'react'
import { useSearchParams } from 'next/navigation'
import Link from 'next/link'

function AuthErrorContent() {
  const searchParams = useSearchParams()
  const error = searchParams.get('error')

  const getErrorMessage = (error: string | null) => {
    switch (error) {
      case 'Configuration':
        return 'Помилка конфігурації сервера. Будь ласка, спробуйте пізніше.'
      case 'AccessDenied':
        return 'Доступ заборонено. Ви не маєте дозволу на вхід.'
      case 'Verification':
        return 'Помилка верифікації. Неправильний код або токен.'
      case 'Default':
        return 'Сталася невідома помилка під час автентифікації.'
      default:
        return 'Сталася помилка під час входу. Будь ласка, спробуйте ще раз.'
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-red-50 to-pink-100 flex items-center justify-center p-4">
      <div className="max-w-md w-full space-y-8">
        <div className="text-center">
          <div className="mx-auto h-12 w-12 text-red-600">
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z" />
            </svg>
          </div>
          <h2 className="mt-6 text-3xl font-extrabold text-gray-900">
            Помилка автентифікації
          </h2>
          <p className="mt-2 text-sm text-gray-600">
            {getErrorMessage(error)}
          </p>
        </div>
        
        <div className="mt-8 space-y-6">
          <div className="bg-white p-8 rounded-lg shadow-lg">
            <div className="space-y-4">
              <div className="text-center">
                <p className="text-gray-700 mb-6">
                  Якщо проблема повторюється, будь ласка, зв&apos;яжіться з підтримкою.
                </p>
                
                <div className="space-y-3">
                  <Link
                    href="/auth/signin"
                    className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  >
                    Спробувати ще раз
                  </Link>
                  
                  <Link
                    href="/"
                    className="w-full flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                  >
                    Повернутися на головну
                  </Link>
                </div>
              </div>
            </div>
          </div>
          
          <div className="text-center">
            <p className="text-xs text-gray-500">
              Потрібна допомога?{' '}
              <a href="mailto:support@helpkrok.com" className="text-blue-600 hover:text-blue-500">
                Зв&apos;яжіться з підтримкою
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

export default function AuthErrorPage() {
  return (
    <Suspense fallback={<div>Завантаження...</div>}>
      <AuthErrorContent />
    </Suspense>
  )
}
