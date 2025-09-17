'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { 
  BarChart3, 
  TrendingUp, 
  Clock, 
  Target,
  BookOpen,
  CheckCircle,
  AlertCircle,
  Trophy
} from 'lucide-react'

interface UserAnalytics {
  total_topics_completed: number
  total_tests_taken: number
  average_score: number
  total_study_time: number
  weak_areas: string[]
  strong_areas: string[]
  progress_by_faculty: {
    medical: number
    pharmaceutical: number
  }
  recent_activity: ActivityItem[]
  performance_trend: PerformanceData[]
}

interface ActivityItem {
  id: string
  type: 'video' | 'test' | 'topic_completed'
  title: string
  timestamp: string
  score?: number
}

interface PerformanceData {
  date: string
  score: number
  topics_completed: number
}

interface AnalyticsProps {
  userId: string
}

export function Analytics({ userId }: AnalyticsProps) {
  const [analytics, setAnalytics] = useState<UserAnalytics | null>(null)
  const [loading, setIsLoading] = useState(true)
  const [timeRange, setTimeRange] = useState<'week' | 'month' | 'year'>('month')

  useEffect(() => {
    fetchAnalytics()
  }, [userId, timeRange])

  const fetchAnalytics = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`/api/analytics?user_id=${userId}&range=${timeRange}`)
      if (response.ok) {
        const data = await response.json()
        setAnalytics(data.analytics)
      }
    } catch (error) {
      console.error('Error fetching analytics:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const formatTime = (minutes: number) => {
    const hours = Math.floor(minutes / 60)
    const mins = minutes % 60
    return `${hours}г ${mins}хв`
  }

  const getScoreColor = (score: number) => {
    if (score >= 80) return 'text-success-600'
    if (score >= 60) return 'text-warning-600'
    return 'text-error-600'
  }

  const getScoreIcon = (score: number) => {
    if (score >= 80) return <Trophy className="h-5 w-5 text-success-500" />
    if (score >= 60) return <Target className="h-5 w-5 text-warning-500" />
    return <AlertCircle className="h-5 w-5 text-error-500" />
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {[1, 2, 3, 4].map((i) => (
            <Card key={i} className="animate-pulse">
              <CardContent className="p-6">
                <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
                <div className="h-8 bg-gray-200 rounded w-1/2"></div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  if (!analytics) {
    return (
      <Card>
        <CardContent className="p-8 text-center">
          <AlertCircle className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Немає даних для аналітики
          </h3>
          <p className="text-gray-600">
            Почніть навчання, щоб побачити детальну аналітику вашого прогресу
          </p>
        </CardContent>
      </Card>
    )
  }

  return (
    <div className="space-y-6">
      {/* Time Range Selector */}
      <div className="flex justify-end">
        <div className="flex space-x-2">
          {(['week', 'month', 'year'] as const).map((range) => (
            <button
              key={range}
              onClick={() => setTimeRange(range)}
              className={`px-3 py-1 rounded-lg text-sm font-medium transition-colors ${
                timeRange === range
                  ? 'bg-primary-500 text-white'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}
            >
              {range === 'week' ? 'Тиждень' : range === 'month' ? 'Місяць' : 'Рік'}
            </button>
          ))}
        </div>
      </div>

      {/* Key Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center">
              <div className="bg-primary-100 p-3 rounded-full">
                <BookOpen className="h-6 w-6 text-primary-500" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Завершено тем</p>
                <p className="text-2xl font-bold text-gray-900">
                  {analytics.total_topics_completed}
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center">
              <div className="bg-success-100 p-3 rounded-full">
                <CheckCircle className="h-6 w-6 text-success-500" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Тестів пройдено</p>
                <p className="text-2xl font-bold text-gray-900">
                  {analytics.total_tests_taken}
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center">
              <div className="bg-warning-100 p-3 rounded-full">
                {getScoreIcon(analytics.average_score)}
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Середній бал</p>
                <p className={`text-2xl font-bold ${getScoreColor(analytics.average_score)}`}>
                  {analytics.average_score}%
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center">
              <div className="bg-primary-100 p-3 rounded-full">
                <Clock className="h-6 w-6 text-primary-500" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Час навчання</p>
                <p className="text-2xl font-bold text-gray-900">
                  {formatTime(analytics.total_study_time)}
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Progress by Faculty */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <BarChart3 className="h-5 w-5" />
              <span>Прогрес по факультетах</span>
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div>
                <div className="flex justify-between text-sm text-gray-600 mb-1">
                  <span>Медичний факультет</span>
                  <span>{analytics.progress_by_faculty.medical}%</span>
                </div>
                <div className="progress-bar">
                  <div 
                    className="progress-fill" 
                    style={{ width: `${analytics.progress_by_faculty.medical}%` }}
                  ></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between text-sm text-gray-600 mb-1">
                  <span>Фармацевтичний факультет</span>
                  <span>{analytics.progress_by_faculty.pharmaceutical}%</span>
                </div>
                <div className="progress-bar">
                  <div 
                    className="progress-fill" 
                    style={{ width: `${analytics.progress_by_faculty.pharmaceutical}%` }}
                  ></div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <TrendingUp className="h-5 w-5" />
              <span>Сильні та слабкі сторони</span>
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div>
                <h4 className="font-semibold text-success-600 mb-2">Сильні сторони</h4>
                <div className="space-y-1">
                  {analytics.strong_areas.map((area, index) => (
                    <div key={index} className="flex items-center space-x-2">
                      <CheckCircle className="h-4 w-4 text-success-500" />
                      <span className="text-sm text-gray-700">{area}</span>
                    </div>
                  ))}
                </div>
              </div>
              <div>
                <h4 className="font-semibold text-error-600 mb-2">Потребують уваги</h4>
                <div className="space-y-1">
                  {analytics.weak_areas.map((area, index) => (
                    <div key={index} className="flex items-center space-x-2">
                      <AlertCircle className="h-4 w-4 text-error-500" />
                      <span className="text-sm text-gray-700">{area}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Recent Activity */}
      <Card>
        <CardHeader>
          <CardTitle>Остання активність</CardTitle>
          <CardDescription>Ваші останні дії на платформі</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {analytics.recent_activity.map((activity) => (
              <div key={activity.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div className="flex items-center space-x-3">
                  <div className="bg-primary-100 p-2 rounded-full">
                    {activity.type === 'video' ? (
                      <BookOpen className="h-4 w-4 text-primary-500" />
                    ) : activity.type === 'test' ? (
                      <CheckCircle className="h-4 w-4 text-success-500" />
                    ) : (
                      <Trophy className="h-4 w-4 text-warning-500" />
                    )}
                  </div>
                  <div>
                    <p className="font-medium text-gray-900">{activity.title}</p>
                    <p className="text-sm text-gray-600">
                      {new Date(activity.timestamp).toLocaleDateString('uk-UA')}
                    </p>
                  </div>
                </div>
                {activity.score && (
                  <div className={`font-semibold ${getScoreColor(activity.score)}`}>
                    {activity.score}%
                  </div>
                )}
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
