'use client'

import { Info, Loader2, RefreshCw } from 'lucide-react'
import { useEffect, useState } from 'react'
import { useSession } from 'next-auth/react'

interface StatisticsData {
  totalQuestionsAnswered: number
  correctAnswers: number
  incorrectAnswers: number
  averagePercentage: number
  ratioPercentage: number
  totalTests: number
  completedTests: number
}

export default function StatisticsTab() {
  const { data: session } = useSession()
  const [statistics, setStatistics] = useState<StatisticsData | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [refreshing, setRefreshing] = useState(false)
  const [nextUpdate, setNextUpdate] = useState<number>(30)

  useEffect(() => {
    const fetchStatistics = async () => {
      if (!session?.user?.id) return

      try {
        setLoading(true)
        const response = await fetch('/api/user/statistics')
        
        if (!response.ok) {
          throw new Error('Failed to fetch statistics')
        }

        const data = await response.json()
        setStatistics(data.statistics)
      } catch (err) {
        console.error('Error fetching statistics:', err)
        setError(err instanceof Error ? err.message : 'Unknown error')
      } finally {
        setLoading(false)
      }
    }

    fetchStatistics()
    
    // Оновлюємо статистику кожні 30 секунд
    const interval = setInterval(fetchStatistics, 30000)
    
    // Відлік часу до наступного оновлення
    const countdownInterval = setInterval(() => {
      setNextUpdate(prev => {
        if (prev <= 1) {
          return 30 // Скидаємо на 30 секунд
        }
        return prev - 1
      })
    }, 1000)
    
    return () => {
      clearInterval(interval)
      clearInterval(countdownInterval)
    }
  }, [session?.user?.id])

  const refreshStatistics = async () => {
    if (!session?.user?.id) return

    try {
      setRefreshing(true)
      const response = await fetch('/api/user/statistics')
      
      if (!response.ok) {
        throw new Error('Failed to fetch statistics')
      }

      const data = await response.json()
      setStatistics(data.statistics)
      
      // Скидаємо таймер після ручного оновлення
      setNextUpdate(30)
    } catch (err) {
      console.error('Error refreshing statistics:', err)
      setError(err instanceof Error ? err.message : 'Unknown error')
    } finally {
      setRefreshing(false)
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="w-8 h-8 animate-spin text-blue-600" />
        <span className="ml-2 text-gray-600">Завантаження статистики...</span>
      </div>
    )
  }

  if (error) {
    return (
      <div className="text-center py-12">
        <p className="text-red-600 mb-4">Помилка завантаження статистики: {error}</p>
        <button 
          onClick={() => window.location.reload()} 
          className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
        >
          Спробувати знову
        </button>
      </div>
    )
  }

  if (!statistics) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-600">Статистика недоступна</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Заголовок */}
      <div className="text-center">
        <div className="flex items-center justify-center gap-4 mb-2">
          <h1 className="text-2xl font-bold text-gray-900">Ваша статистика</h1>
          <button
            onClick={refreshStatistics}
            disabled={refreshing}
            className="p-2 text-gray-600 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors disabled:opacity-50"
            title="Оновити статистику"
          >
            <RefreshCw className={`w-5 h-5 ${refreshing ? 'animate-spin' : ''}`} />
          </button>
        </div>
        <p className="text-gray-600">Реальні дані з ваших тестів</p>
        {refreshing ? (
          <p className="text-sm text-blue-600 mt-1">Оновлення...</p>
        ) : (
          <p className="text-sm text-gray-500 mt-1">
            Автооновлення через {nextUpdate}с
          </p>
        )}
      </div>

      {/* Основна статистика */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {/* Всього відповідей */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <p className="text-sm font-medium text-gray-600 mb-2">Всього відповідей</p>
            <p className="text-3xl font-bold text-blue-600">{statistics.totalQuestionsAnswered || 0}</p>
          </div>
        </div>

        {/* Правильні відповіді */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <p className="text-sm font-medium text-gray-600 mb-2">Правильні відповіді</p>
            <p className="text-3xl font-bold text-blue-600">{statistics.correctAnswers || 0}</p>
          </div>
        </div>

        {/* Неправильні відповіді */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <p className="text-sm font-medium text-gray-600 mb-2">Неправильні відповіді</p>
            <p className="text-3xl font-bold text-blue-600">{statistics.incorrectAnswers || 0}</p>
          </div>
        </div>

        {/* Середній % */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <div className="flex items-center justify-center gap-1 mb-2">
              <p className="text-sm font-medium text-gray-600">Середній %</p>
              <Info className="w-4 h-4 text-gray-400" />
            </div>
            <p className="text-3xl font-bold text-blue-600">{(statistics.averagePercentage || 0).toFixed(1)}%</p>
          </div>
        </div>
      </div>

      {/* Додаткова статистика */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Співвідношення % */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <div className="flex items-center justify-center gap-1 mb-2">
              <p className="text-sm font-medium text-gray-600">Співвідношення %</p>
              <Info className="w-4 h-4 text-gray-400" />
            </div>
            <p className="text-3xl font-bold text-blue-600">{(statistics.ratioPercentage || 0).toFixed(1)}%</p>
            <p className="text-xs text-gray-500 mt-1">Відношення правильних до загальних</p>
          </div>
        </div>

        {/* Завершених тестів */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="text-center">
            <p className="text-sm font-medium text-gray-600 mb-2">Завершених тестів</p>
            <p className="text-3xl font-bold text-blue-600">{statistics.completedTests || 0}</p>
            <p className="text-xs text-gray-500 mt-1">З {statistics.totalTests || 0} доступних</p>
          </div>
        </div>
      </div>

      {/* Прогрес бар */}
      {(statistics.totalQuestionsAnswered || 0) > 0 && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          <div className="mb-4">
            <div className="flex justify-between text-sm text-gray-600 mb-2">
              <span>Прогрес навчання</span>
              <span>{(statistics.averagePercentage || 0).toFixed(1)}%</span>
            </div>
            <div className="progress-bar">
              <div 
                className="progress-fill bg-blue-500"
                style={{ width: `${Math.min(statistics.averagePercentage || 0, 100)}%` }}
              ></div>
            </div>
          </div>
          <div className="text-center text-sm text-gray-600">
            {statistics.correctAnswers || 0} з {statistics.totalQuestionsAnswered || 0} відповідей правильні
          </div>
        </div>
      )}
    </div>
  )
}
