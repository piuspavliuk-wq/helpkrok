'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { Bookmark, BookOpen, Play, FileText, Trash2, Eye, Clock } from 'lucide-react'

interface SavedItem {
  id: string
  itemType: 'test' | 'course' | 'question' | 'video'
  itemId: string
  itemTitle: string
  itemData: {
    description?: string
    duration?: number
    questions?: number
    difficulty?: string
    subject?: string
    step?: string
    faculty?: string
  }
  createdAt: string
}

export default function SavedTab() {
  const { data: session } = useSession()
  const [savedItems, setSavedItems] = useState<SavedItem[]>([])
  const [loading, setLoading] = useState(true)
  const [filter, setFilter] = useState<'all' | 'test' | 'course' | 'question' | 'video'>('all')

  useEffect(() => {
    if (session?.user?.id) {
      fetchSavedItems()
    }
  }, [session])

  const fetchSavedItems = async () => {
    try {
      setLoading(true)
      const response = await fetch('/api/user/saved')
      const data = await response.json()
      
      if (data.success) {
        setSavedItems(data.savedItems)
      } else {
        // Fallback mock data
        setSavedItems([
          {
            id: '1',
            itemType: 'test',
            itemId: 'anatomy',
            itemTitle: 'Анатомія - Крок 1',
            itemData: {
              description: 'Тест з анатомії для підготовки до КРОК 1',
              questions: 50,
              difficulty: 'medium',
              subject: 'Анатомія',
              step: 'krok1',
              faculty: 'medical'
            },
            createdAt: '2024-01-15T10:30:00Z'
          },
          {
            id: '2',
            itemType: 'course',
            itemId: 'physiology-course',
            itemTitle: 'Курс фізіології',
            itemData: {
              description: 'Повний курс фізіології з відеолекціями',
              duration: 1800,
              difficulty: 'hard',
              subject: 'Фізіологія',
              step: 'krok1',
              faculty: 'medical'
            },
            createdAt: '2024-01-14T15:45:00Z'
          },
          {
            id: '3',
            itemType: 'video',
            itemId: 'biochemistry-video',
            itemTitle: 'Біохімія: Обмін речовин',
            itemData: {
              description: 'Відеолекція про обмін речовин в організмі',
              duration: 1200,
              difficulty: 'medium',
              subject: 'Біохімія',
              step: 'krok1',
              faculty: 'medical'
            },
            createdAt: '2024-01-13T09:20:00Z'
          },
          {
            id: '4',
            itemType: 'question',
            itemId: 'question-123',
            itemTitle: 'Питання про серце',
            itemData: {
              description: 'Складне питання про будову серця',
              difficulty: 'hard',
              subject: 'Анатомія',
              step: 'krok1',
              faculty: 'medical'
            },
            createdAt: '2024-01-12T14:15:00Z'
          }
        ])
      }
    } catch (error) {
      console.error('Error fetching saved items:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleRemoveItem = async (itemId: string) => {
    try {
      const response = await fetch(`/api/user/saved/${itemId}`, {
        method: 'DELETE'
      })
      
      if (response.ok) {
        setSavedItems(prev => prev.filter(item => item.id !== itemId))
      }
    } catch (error) {
      console.error('Error removing item:', error)
    }
  }

  const getItemIcon = (type: string) => {
    switch (type) {
      case 'test':
        return <FileText className="w-5 h-5 text-blue-600" />
      case 'course':
        return <BookOpen className="w-5 h-5 text-green-600" />
      case 'video':
        return <Play className="w-5 h-5 text-purple-600" />
      case 'question':
        return <Bookmark className="w-5 h-5 text-orange-600" />
      default:
        return <Bookmark className="w-5 h-5 text-gray-600" />
    }
  }

  const getItemTypeLabel = (type: string) => {
    switch (type) {
      case 'test':
        return 'Тест'
      case 'course':
        return 'Курс'
      case 'video':
        return 'Відео'
      case 'question':
        return 'Питання'
      default:
        return 'Елемент'
    }
  }

  const formatDuration = (seconds: number) => {
    const minutes = Math.floor(seconds / 60)
    return `${minutes} хв`
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('uk-UA')
  }

  const filteredItems = filter === 'all' 
    ? savedItems 
    : savedItems.filter(item => item.itemType === filter)

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded w-1/3 mb-4"></div>
          <div className="space-y-4">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="h-24 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold text-gray-900">Збережені</h2>
        <div className="flex gap-2">
          {(['all', 'test', 'course', 'video', 'question'] as const).map((type) => (
            <button
              key={type}
              onClick={() => setFilter(type)}
              className={`px-3 py-1 rounded-md text-sm font-medium transition-colors ${
                filter === type
                  ? 'bg-blue-500 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {type === 'all' ? 'Всі' : getItemTypeLabel(type)}
            </button>
          ))}
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-4">
          <div className="flex items-center">
            <div className="p-2 bg-blue-100 rounded-lg">
              <Bookmark className="w-5 h-5 text-blue-600" />
            </div>
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-600">Всього</p>
              <p className="text-xl font-bold text-gray-900">{savedItems.length}</p>
            </div>
          </div>
        </div>
        
        <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-4">
          <div className="flex items-center">
            <div className="p-2 bg-green-100 rounded-lg">
              <FileText className="w-5 h-5 text-green-600" />
            </div>
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-600">Тестів</p>
              <p className="text-xl font-bold text-gray-900">
                {savedItems.filter(item => item.itemType === 'test').length}
              </p>
            </div>
          </div>
        </div>
        
        <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-4">
          <div className="flex items-center">
            <div className="p-2 bg-purple-100 rounded-lg">
              <Play className="w-5 h-5 text-purple-600" />
            </div>
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-600">Відео</p>
              <p className="text-xl font-bold text-gray-900">
                {savedItems.filter(item => item.itemType === 'video').length}
              </p>
            </div>
          </div>
        </div>
        
        <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-4">
          <div className="flex items-center">
            <div className="p-2 bg-orange-100 rounded-lg">
              <BookOpen className="w-5 h-5 text-orange-600" />
            </div>
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-600">Курсів</p>
              <p className="text-xl font-bold text-gray-900">
                {savedItems.filter(item => item.itemType === 'course').length}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Items List */}
      {filteredItems.length === 0 ? (
        <div className="text-center py-12">
          <Bookmark className="w-16 h-16 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">Немає збережених елементів</h3>
          <p className="text-gray-600">
            {filter === 'all' 
              ? 'Почніть зберігати тести, курси та відео для швидкого доступу'
              : `Немає збережених ${getItemTypeLabel(filter).toLowerCase()}`
            }
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {filteredItems.map((item) => (
            <div 
              key={item.id}
              className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-6 hover:shadow-md transition-shadow"
            >
              <div className="flex items-start justify-between">
                <div className="flex items-start space-x-4 flex-1">
                  <div className="flex-shrink-0">
                    {getItemIcon(item.itemType)}
                  </div>
                  
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center space-x-2 mb-2">
                      <h3 className="text-lg font-semibold text-gray-900 truncate">
                        {item.itemTitle}
                      </h3>
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                        {getItemTypeLabel(item.itemType)}
                      </span>
                    </div>
                    
                    {item.itemData.description && (
                      <p className="text-gray-600 mb-3">{item.itemData.description}</p>
                    )}
                    
                    <div className="flex items-center space-x-4 text-sm text-gray-500">
                      {item.itemData.subject && (
                        <span className="flex items-center">
                          <span className="font-medium">Предмет:</span>
                          <span className="ml-1">{item.itemData.subject}</span>
                        </span>
                      )}
                      
                      {item.itemData.step && (
                        <span className="flex items-center">
                          <span className="font-medium">Крок:</span>
                          <span className="ml-1">{item.itemData.step.toUpperCase()}</span>
                        </span>
                      )}
                      
                      {item.itemData.questions && (
                        <span className="flex items-center">
                          <FileText className="w-4 h-4 mr-1" />
                          <span>{item.itemData.questions} питань</span>
                        </span>
                      )}
                      
                      {item.itemData.duration && (
                        <span className="flex items-center">
                          <Clock className="w-4 h-4 mr-1" />
                          <span>{formatDuration(item.itemData.duration)}</span>
                        </span>
                      )}
                      
                      <span className="flex items-center">
                        <span className="font-medium">Додано:</span>
                        <span className="ml-1">{formatDate(item.createdAt)}</span>
                      </span>
                    </div>
                  </div>
                </div>
                
                <div className="flex items-center space-x-2 ml-4">
                  <button
                    onClick={() => {
                      // Navigate to item
                      if (item.itemType === 'test') {
                        window.location.href = `/test/${item.itemId}`
                      } else if (item.itemType === 'course') {
                        window.location.href = `/course/${item.itemId}`
                      } else if (item.itemType === 'video') {
                        window.location.href = `/video/${item.itemId}`
                      }
                    }}
                    className="p-2 text-gray-400 hover:text-blue-600 transition-colors"
                    title="Переглянути"
                  >
                    <Eye className="w-5 h-5" />
                  </button>
                  
                  <button
                    onClick={() => handleRemoveItem(item.id)}
                    className="p-2 text-gray-400 hover:text-red-600 transition-colors"
                    title="Видалити з збережених"
                  >
                    <Trash2 className="w-5 h-5" />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
