'use client'

import { useState } from 'react'
import LoginForm from '@/components/auth/LoginForm'
import RegisterForm from '@/components/auth/RegisterForm'

export default function SignInPage() {
  const [isLogin, setIsLogin] = useState(true)

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
      <div className="max-w-md w-full space-y-8">
        <div className="text-center">
          <h2 className="mt-6 text-3xl font-extrabold text-gray-900">
            Help Krok Platform
          </h2>
          <p className="mt-2 text-sm text-gray-600">
            {isLogin ? 'Увійдіть в свій акаунт' : 'Створіть новий акаунт'}
          </p>
        </div>
        
        <div className="mt-8 space-y-6">
          <div className="bg-white p-8 rounded-lg shadow-lg">
            {isLogin ? <LoginForm /> : <RegisterForm />}
            
            <div className="mt-6 text-center">
              <button
                onClick={() => setIsLogin(!isLogin)}
                className="text-blue-600 hover:text-blue-500 text-sm font-medium"
              >
                {isLogin 
                  ? 'Немає акаунту? Зареєструватися' 
                  : 'Вже є акаунт? Увійти'
                }
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}