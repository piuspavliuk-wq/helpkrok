'use client'

import { useSession, signOut } from 'next-auth/react'
import { useRouter } from 'next/navigation'
import Image from 'next/image'

export default function UserProfile() {
  const { data: session, status } = useSession()
  const router = useRouter()

  if (status === 'loading') {
    return (
      <div className="animate-pulse">
        <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
        <div className="h-4 bg-gray-200 rounded w-1/2"></div>
      </div>
    )
  }

  if (!session) {
    return (
      <div className="text-center">
        <p className="text-gray-600 mb-4">Ви не увійшли в систему</p>
        <button
          onClick={() => router.push('/auth/signin')}
          className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700"
        >
          Увійти
        </button>
      </div>
    )
  }

  const handleSignOut = async () => {
    await signOut({ callbackUrl: '/' })
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex items-center space-x-4 mb-6">
        {session.user?.image && (
          <div className="relative w-16 h-16">
            <Image
              src={session.user.image}
              alt="Profile"
              fill
              className="rounded-full object-cover"
            />
          </div>
        )}
        <div>
          <h2 className="text-xl font-semibold text-gray-900">
            {session.user?.name || 'Користувач'}
          </h2>
          <p className="text-gray-600">
            {session.user?.email || 'Email користувач'}
          </p>
        </div>
      </div>

      <div className="space-y-4">
        <div className="border-t pt-4">
          <h3 className="text-lg font-medium text-gray-900 mb-3">
            Інформація про профіль
          </h3>
          <div className="space-y-2">
            <div className="flex justify-between">
              <span className="text-gray-600">ID користувача:</span>
              <span className="font-mono text-sm">{session.user?.id}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Статус:</span>
              <span className="text-green-600 font-medium">Активний</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Спосіб входу:</span>
              <span className="text-blue-600 font-medium">Email/Password</span>
            </div>
          </div>
        </div>

        <div className="border-t pt-4">
          <button
            onClick={handleSignOut}
            className="w-full bg-red-600 text-white py-2 px-4 rounded-md hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2"
          >
            Вийти з системи
          </button>
        </div>
      </div>
    </div>
  )
}
