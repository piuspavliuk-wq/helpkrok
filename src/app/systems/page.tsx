'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { CustomSelect } from '@/components/ui/CustomSelect'
import { SystemCard } from '@/components/systems/SystemCard'

interface Course {
  id: string
  title: string
  description: string | null
  faculty: 'medical' | 'pharmaceutical'
  order_index: number
}

export default function CoursesPage() {
  const { data: session } = useSession()
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical'>('medical')
  const [facultyLoaded, setFacultyLoaded] = useState(false)
  const [courses, setCourses] = useState<Course[]>([])
  const [loading, setLoading] = useState(true)

  // Отримуємо факультет користувача
  useEffect(() => {
    const fetchUserFaculty = async () => {
      if (session?.user?.id) {
        try {
          const response = await fetch('/api/user/profile')
          if (response.ok) {
            const userData = await response.json()
            if (userData.profile?.faculty) {
              setSelectedFaculty(userData.profile.faculty)
            }
          }
        } catch (error) {
          console.error('Error fetching user faculty:', error)
        }
      }
      setFacultyLoaded(true)
    }

    if (!session) {
      setFacultyLoaded(true)
    } else {
      fetchUserFaculty()
    }
  }, [session?.user?.id])

  // Завантажуємо курси при зміні факультету
  useEffect(() => {
    if (facultyLoaded) {
      // Для медицини одразу встановлюємо, що завантаження завершено
      if (selectedFaculty === 'medical') {
        setLoading(false)
        setCourses([])
      } else {
        fetchCourses()
      }
    }
  }, [selectedFaculty, facultyLoaded])

  // Статичні системи для медицини
  const medicalSystems = [
    { id: 'cardiovascular', title: 'Серцево-судинна' },
    { id: 'respiratory', title: 'Дихальна' },
    { id: 'digestive', title: 'Травна' },
    { id: 'urinary', title: 'Сечова' }
  ]

  const fetchCourses = async () => {
    setLoading(true)

    try {
      const params = new URLSearchParams({
        faculty: selectedFaculty
      })

      const response = await fetch(`/api/courses?${params}`)
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      
      const data = await response.json()

      // Якщо API повернув успішну відповідь, навіть з порожнім масивом - це нормально
      if (data.success) {
        setCourses(data.courses || [])
      } else {
        // Тільки якщо API явно повернув помилку
        console.error('API returned error:', data.error)
        setCourses([])
        // Не встановлюємо error, бо це може бути нормально, що курсів ще немає
      }
    } catch (err) {
      // Тільки реальні мережеві помилки або проблеми з сервером
      console.error('Error fetching courses:', err)
      // Не показуємо помилку користувачу, просто порожній стан
      setCourses([])
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden">
      {/* Фонові візерунки */}
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-20 left-20 w-32 h-32 border border-blue-200 rounded-full animate-pulse"></div>
        <div className="absolute top-40 right-32 w-24 h-24 border border-blue-200 rounded-full animate-pulse delay-1000"></div>
        <div className="absolute bottom-32 left-40 w-40 h-40 border border-blue-200 rounded-full animate-pulse delay-2000"></div>
        <div className="absolute bottom-20 right-20 w-28 h-28 border border-blue-200 rounded-full animate-pulse delay-500"></div>
        <div className="absolute top-1/2 left-1/4 w-20 h-20 border border-blue-200 rounded-full animate-pulse delay-1500"></div>
        <div className="absolute top-1/3 right-1/4 w-36 h-36 border border-blue-200 rounded-full animate-pulse delay-3000"></div>
      </div>
      
      <div className="px-8 pt-20 pb-8 relative z-10">
        <div className="mx-auto max-w-[1010px]">
          {/* Header з вибіркою факультету */}
          <div className="mb-8">
            <h1 className="text-3xl font-bold text-gray-900 mb-6">Курси</h1>
            
            {/* Faculty Selection */}
            <div className="flex flex-col sm:flex-row gap-4 mb-6">
              <CustomSelect
                value={selectedFaculty}
                onChange={(value) => setSelectedFaculty(value as 'medical' | 'pharmaceutical')}
                options={[
                  { value: 'medical', label: 'Медицина' },
                  { value: 'pharmaceutical', label: 'Фармація' }
                ]}
                className="min-w-[140px]"
              />
            </div>
          </div>

          {/* Loading State */}
          {loading && (
            <div className="text-center py-12">
              <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
              <div className="text-gray-500 text-lg mt-4">Завантаження курсів...</div>
            </div>
          )}

          {/* Medical Systems Grid */}
          {!loading && selectedFaculty === 'medical' && (
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-2 gap-x-[50px] gap-y-[50px] justify-items-center">
              {medicalSystems.map((system) => (
                <SystemCard
                  key={system.id}
                  title={system.title}
                />
              ))}
            </div>
          )}

          {/* Pharmaceutical Courses Grid */}
          {!loading && selectedFaculty === 'pharmaceutical' && courses.length > 0 && (
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-2 gap-x-[50px] gap-y-[50px] justify-items-center">
              {courses.map((course) => (
                <SystemCard
                  key={course.id}
                  title={course.title}
                  description={course.description || undefined}
                />
              ))}
            </div>
          )}

          {/* Empty State для фармації */}
          {!loading && selectedFaculty === 'pharmaceutical' && courses.length === 0 && (
            <div className="text-center py-12">
              <div className="text-gray-500 text-lg">
                Немає доступних курсів для обраного факультету
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
