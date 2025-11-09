'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { Plus, Edit, Trash2, Clock, BookOpen, Target, Users, MapPin, Video, User } from 'lucide-react'

interface Lesson {
  id: string
  title: string
  description?: string
  subject: string
  step: string
  faculty: string
  startDate: string
  endDate: string
  location?: string
  teacherName?: string
  maxStudents?: number
  isOnline: boolean
  meetingLink?: string
  materials?: string
  status: 'scheduled' | 'ongoing' | 'completed' | 'cancelled'
  createdBy: string
  createdAt: string
  updatedAt: string
}

export default function ScheduleTab() {
  const { data: session } = useSession()
  const [lessons, setLessons] = useState<Lesson[]>([])
  const [lessonsLoading, setLessonsLoading] = useState(false)
  const [userRole, setUserRole] = useState<string>('student')
  const [showAddForm, setShowAddForm] = useState(false)
  const [editingLesson, setEditingLesson] = useState<Lesson | null>(null)

  useEffect(() => {
    if (session?.user?.id) {
      fetchLessons()
      setUserRole(session?.user?.role || 'student')
    }
  }, [session])

  const fetchLessons = async () => {
    try {
      setLessonsLoading(true)
      const response = await fetch('/api/lessons')
      const data = await response.json()
      
      if (data.success) {
        setLessons(data.lessons || [])
      }
    } catch (error) {
      console.error('Error fetching lessons:', error)
    } finally {
      setLessonsLoading(false)
    }
  }

  const handleLessonSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    const formData = new FormData(e.currentTarget)
    
    const lessonData = {
      title: formData.get('title') as string,
      description: formData.get('description') as string,
      subject: formData.get('subject') as string,
      step: formData.get('step') as string,
      faculty: formData.get('faculty') as string,
      startDate: formData.get('startDate') as string,
      endDate: formData.get('endDate') as string,
      location: formData.get('location') as string,
      teacherName: formData.get('teacherName') as string,
      maxStudents: parseInt(formData.get('maxStudents') as string) || null,
      isOnline: formData.get('isOnline') === 'on',
      meetingLink: formData.get('meetingLink') as string,
      materials: formData.get('materials') as string,
      status: 'scheduled'
    }

    try {
      const url = editingLesson ? `/api/lessons?id=${editingLesson.id}` : '/api/lessons'
      const method = editingLesson ? 'PUT' : 'POST'
      
      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(lessonData)
      })

      const data = await response.json()
      
      if (data.success) {
        await fetchLessons()
        setShowAddForm(false)
        setEditingLesson(null)
        alert(editingLesson ? 'Урок оновлено!' : 'Урок створено!')
      } else {
        alert('Помилка: ' + data.error)
      }
    } catch (error) {
      console.error('Error saving lesson:', error)
      alert('Помилка при збереженні уроку')
    }
  }

  const handleDeleteLesson = async (lessonId: string) => {
    if (!confirm('Ви впевнені, що хочете видалити цей урок?')) return

    try {
      const response = await fetch(`/api/lessons?id=${lessonId}`, {
        method: 'DELETE'
      })

      const data = await response.json()
      
      if (data.success) {
        await fetchLessons()
        alert('Урок видалено!')
      } else {
        alert('Помилка: ' + data.error)
      }
    } catch (error) {
      console.error('Error deleting lesson:', error)
      alert('Помилка при видаленні уроку')
    }
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('uk-UA', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })
  }

  const getRoleIcon = (role: string) => {
    switch (role) {
      case 'admin': return '👑'
      case 'teacher': return '👨‍🏫'
      case 'student': return '👨‍🎓'
      default: return '👤'
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Розклад навчання</h2>
          <p className="text-gray-600 mt-1">
            {getRoleIcon(userRole)} {userRole === 'admin' ? 'Адміністратор' : userRole === 'teacher' ? 'Викладач' : 'Студент'}
          </p>
        </div>
        
        {userRole === 'admin' && (
          <button
            onClick={() => setShowAddForm(true)}
            className="flex items-center gap-2 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors"
          >
            <Plus className="w-4 h-4" />
            Додати урок
          </button>
        )}
      </div>

      {/* Add/Edit Lesson Form */}
      {showAddForm && (
        <div className="bg-white rounded-lg shadow-sm border p-6">
          <h3 className="text-lg font-semibold mb-4">
            {editingLesson ? 'Редагувати урок' : 'Додати новий урок'}
          </h3>
          
          <form onSubmit={handleLessonSubmit} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Назва уроку *
                </label>
                <input
                  type="text"
                  name="title"
                  required
                  defaultValue={editingLesson?.title || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Предмет *
                </label>
                <input
                  type="text"
                  name="subject"
                  required
                  defaultValue={editingLesson?.subject || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Крок *
                </label>
                <select
                  name="step"
                  required
                  defaultValue={editingLesson?.step || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
                  <option value="">Оберіть крок</option>
                  <option value="krok1">KROK 1</option>
                  <option value="krok2">KROK 2</option>
                  <option value="krok3">KROK 3</option>
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Факультет *
                </label>
                <select
                  name="faculty"
                  required
                  defaultValue={editingLesson?.faculty || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
                  <option value="">Оберіть факультет</option>
                  <option value="medical">Медичний</option>
                  <option value="pharmaceutical">Фармацевтичний</option>
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Початок уроку *
                </label>
                <input
                  type="datetime-local"
                  name="startDate"
                  required
                  defaultValue={editingLesson?.startDate ? new Date(editingLesson.startDate).toISOString().slice(0, 16) : ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Кінець уроку *
                </label>
                <input
                  type="datetime-local"
                  name="endDate"
                  required
                  defaultValue={editingLesson?.endDate ? new Date(editingLesson.endDate).toISOString().slice(0, 16) : ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Місце проведення
                </label>
                <input
                  type="text"
                  name="location"
                  defaultValue={editingLesson?.location || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Викладач
                </label>
                <input
                  type="text"
                  name="teacherName"
                  defaultValue={editingLesson?.teacherName || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Максимальна кількість студентів
                </label>
                <input
                  type="number"
                  name="maxStudents"
                  defaultValue={editingLesson?.maxStudents || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Посилання на зустріч
                </label>
                <input
                  type="url"
                  name="meetingLink"
                  defaultValue={editingLesson?.meetingLink || ''}
                  className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Опис
              </label>
              <textarea
                name="description"
                rows={3}
                defaultValue={editingLesson?.description || ''}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Матеріали
              </label>
              <textarea
                name="materials"
                rows={2}
                defaultValue={editingLesson?.materials || ''}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Посилання на матеріали, файли тощо"
              />
            </div>
            
            <div className="flex items-center">
              <input
                type="checkbox"
                name="isOnline"
                defaultChecked={editingLesson?.isOnline || false}
                className="mr-2"
              />
              <label className="text-sm font-medium text-gray-700">
                Онлайн урок
              </label>
            </div>
            
            <div className="flex gap-2 pt-4">
              <button
                type="submit"
                className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition-colors"
              >
                {editingLesson ? 'Оновити урок' : 'Створити урок'}
              </button>
              <button
                type="button"
                onClick={() => {
                  setShowAddForm(false)
                  setEditingLesson(null)
                }}
                className="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600 transition-colors"
              >
                Скасувати
              </button>
            </div>
          </form>
        </div>
      )}

      {/* Lessons List */}
      <div className="bg-white rounded-lg shadow-sm border">
        <div className="p-6 border-b">
          <h3 className="text-lg font-semibold">Заплановані уроки</h3>
        </div>
        
        <div className="p-6">
          {lessonsLoading ? (
            <div className="text-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500 mx-auto"></div>
              <p className="text-gray-500 mt-2">Завантаження...</p>
            </div>
          ) : lessons.length === 0 ? (
            <div className="text-center py-8">
              <div className="text-gray-400 mb-4">
                <Clock className="w-16 h-16 mx-auto" />
              </div>
              <p className="text-gray-500">Немає запланованих уроків</p>
              <p className="text-sm text-gray-400 mt-1">Заплановані уроки з&apos;являться тут</p>
            </div>
          ) : (
            <div className="space-y-4">
              {lessons.map((lesson) => (
                <div key={lesson.id} className="border rounded-lg p-4 hover:shadow-md transition-shadow">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-2">
                        <h4 className="font-semibold text-gray-900">{lesson.title}</h4>
                        <span className={`px-2 py-1 text-xs rounded-full ${
                          lesson.step === 'krok1' ? 'bg-blue-100 text-blue-800' :
                          lesson.step === 'krok2' ? 'bg-green-100 text-green-800' :
                          'bg-purple-100 text-purple-800'
                        }`}>
                          {lesson.step.toUpperCase()}
                        </span>
                      </div>
                      
                      {lesson.description && (
                        <p className="text-gray-600 text-sm mb-2">{lesson.description}</p>
                      )}
                      
                      <div className="flex flex-wrap gap-4 text-sm text-gray-500">
                        <div className="flex items-center gap-1">
                          <BookOpen className="w-4 h-4" />
                          {lesson.subject}
                        </div>
                        <div className="flex items-center gap-1">
                          <Target className="w-4 h-4" />
                          {lesson.faculty === 'medical' ? 'Медичний' : 'Фармацевтичний'}
                        </div>
                        <div className="flex items-center gap-1">
                          <Clock className="w-4 h-4" />
                          {formatDate(lesson.startDate)}
                        </div>
                        {lesson.location && (
                          <div className="flex items-center gap-1">
                            <MapPin className="w-4 h-4" />
                            {lesson.location}
                          </div>
                        )}
                        {lesson.teacherName && (
                          <div className="flex items-center gap-1">
                            <User className="w-4 h-4" />
                            {lesson.teacherName}
                          </div>
                        )}
                        {lesson.isOnline && (
                          <div className="flex items-center gap-1">
                            <Video className="w-4 h-4" />
                            Онлайн
                          </div>
                        )}
                        {lesson.maxStudents && (
                          <div className="flex items-center gap-1">
                            <Users className="w-4 h-4" />
                            {lesson.maxStudents} студентів
                          </div>
                        )}
                      </div>
                    </div>
                    
                    {userRole === 'admin' && (
                      <div className="flex gap-2 ml-4">
                        <button
                          onClick={() => {
                            setEditingLesson(lesson)
                            setShowAddForm(true)
                          }}
                          className="p-2 text-blue-600 hover:bg-blue-50 rounded-md transition-colors"
                          title="Редагувати урок"
                        >
                          <Edit className="w-4 h-4" />
                        </button>
                        <button
                          onClick={() => handleDeleteLesson(lesson.id)}
                          className="p-2 text-red-600 hover:bg-red-50 rounded-md transition-colors"
                          title="Видалити урок"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
