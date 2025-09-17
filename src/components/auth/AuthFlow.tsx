'use client'

import { useState, useEffect } from 'react'
import { FacultySelection } from './FacultySelection'

interface User {
  id: string
  first_name: string
  last_name?: string
  faculty?: 'medical' | 'pharmaceutical'
}

interface AuthFlowProps {
  onAuthComplete: (user: User) => void
}

export function AuthFlow({ onAuthComplete }: AuthFlowProps) {
  const [step, setStep] = useState<'faculty'>('faculty')
  const [user, setUser] = useState<User | null>(null)

  const handleFacultySelect = async (faculty: 'medical' | 'pharmaceutical') => {
    if (!user) return

    try {
      // Оновлюємо факультет користувача
      const response = await fetch('/api/user/faculty', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ faculty }),
      })

      if (response.ok) {
        const updatedUser = { ...user, faculty }
        setUser(updatedUser)
        onAuthComplete(updatedUser)
      } else {
        console.error('Failed to update faculty')
        // Все одно завершуємо автентифікацію
        onAuthComplete(user)
      }
    } catch (error) {
      console.error('Error updating faculty:', error)
      // Все одно завершуємо автентифікацію
      onAuthComplete(user)
    }
  }

  const handleSkipFaculty = () => {
    if (user) {
      onAuthComplete(user)
    }
  }

  // Перевіряємо чи користувач вже автентифікований
  useEffect(() => {
    const checkAuth = async () => {
      try {
        const response = await fetch('/api/auth/me')
        if (response.ok) {
          const userData = await response.json()
          onAuthComplete(userData.user)
        }
      } catch (error) {
        // Користувач не автентифікований, показуємо форму входу
      }
    }

    checkAuth()
  }, [onAuthComplete])

  if (step === 'faculty') {
    return (
      <FacultySelection
        onFacultySelect={handleFacultySelect}
        onSkip={handleSkipFaculty}
      />
    )
  }

  return null
}
