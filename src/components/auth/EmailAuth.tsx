'use client'

import { useState } from 'react'
import { signIn } from 'next-auth/react'

export default function EmailAuth() {
  const [email, setEmail] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    setMessage('')

    try {
      const result = await signIn('email', {
        email,
        redirect: false,
      })

      if (result?.error) {
        setMessage('Помилка при відправці email. Спробуйте ще раз.')
      } else {
        setMessage('Перевірте свою пошту для завершення входу!')
      }
    } catch (error) {
      setMessage('Сталася помилка. Спробуйте ще раз.')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-lg font-medium text-gray-900 mb-2">
          Вхід через Email
        </h3>
        <p className="text-sm text-gray-600">
          Введіть свій email адрес, і ми надішлемо вам посилання для входу
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label htmlFor="email" className="block text-sm font-medium text-gray-700">
            Email адрес
          </label>
          <input
            id="email"
            name="email"
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
            placeholder="your@email.com"
          />
        </div>

        <button
          type="submit"
          disabled={isLoading}
          className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isLoading ? 'Відправляємо...' : 'Надіслати посилання для входу'}
        </button>
      </form>

      {message && (
        <div className={`text-sm p-3 rounded-md ${
          message.includes('Перевірте') 
            ? 'bg-green-50 text-green-800 border border-green-200' 
            : 'bg-red-50 text-red-800 border border-red-200'
        }`}>
          {message}
        </div>
      )}
    </div>
  )
}
