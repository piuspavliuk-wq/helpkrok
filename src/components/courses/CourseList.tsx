'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { 
  BookOpen, 
  Play, 
  Clock, 
  CheckCircle, 
  Lock,
  ChevronRight,
  Video,
  FileText
} from 'lucide-react'

interface Course {
  id: string
  title: string
  description: string
  faculty: 'medical' | 'pharmaceutical'
  order_index: number
  topics?: Topic[]
}

interface Topic {
  id: string
  course_id: string
  title: string
  description: string
  video_url?: string
  lecture_notes?: string
  order_index: number
  progress?: UserTopicProgress
  access?: UserTopicAccess
}

interface UserTopicProgress {
  id: string
  user_id: string
  topic_id: string
  video_progress: number
  video_completed: boolean
  test_completed: boolean
  test_score?: number
  last_accessed: string
}

interface UserTopicAccess {
  id: string
  user_id: string
  topic_id: string
  access_granted: boolean
  granted_at?: string
  expires_at?: string
}

interface CourseListProps {
  faculty?: 'medical' | 'pharmaceutical'
  userSubscription?: {
    subscription_type: 'medical' | 'pharmaceutical' | 'premium'
    status: 'active' | 'expired' | 'cancelled'
  }
}

export function CourseList({ faculty, userSubscription }: CourseListProps) {
  const [courses, setCourses] = useState<Course[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedCourse, setSelectedCourse] = useState<Course | null>(null)

  useEffect(() => {
    fetchCourses()
  }, [faculty])

  const fetchCourses = async () => {
    try {
      setLoading(true)
      const response = await fetch(`/api/courses${faculty ? `?faculty=${faculty}` : ''}`)
      if (response.ok) {
        const data = await response.json()
        setCourses(data.courses)
      }
    } catch (error) {
      console.error('Error fetching courses:', error)
    } finally {
      setLoading(false)
    }
  }

  const hasAccess = (topic: Topic) => {
    if (!userSubscription) return false
    if (userSubscription.status !== 'active') return false
    
    if (userSubscription.subscription_type === 'premium') return true
    if (userSubscription.subscription_type === topic.course_id) return true
    
    return false
  }

  const getProgressPercentage = (topic: Topic) => {
    if (!topic.progress) return 0
    return Math.round(topic.progress.video_progress)
  }

  const getStatusIcon = (topic: Topic) => {
    if (!hasAccess(topic)) {
      return <Lock className="h-4 w-4 text-gray-400" />
    }
    
    if (topic.progress?.test_completed) {
      return <CheckCircle className="h-4 w-4 text-success-500" />
    }
    
    if (topic.progress?.video_completed) {
      return <Play className="h-4 w-4 text-primary-500" />
    }
    
    return <Play className="h-4 w-4 text-gray-400" />
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {[1, 2, 3].map((i) => (
            <Card key={i} className="animate-pulse">
              <CardHeader>
                <div className="h-4 bg-gray-200 rounded w-3/4"></div>
                <div className="h-3 bg-gray-200 rounded w-1/2"></div>
              </CardHeader>
              <CardContent>
                <div className="h-3 bg-gray-200 rounded w-full mb-2"></div>
                <div className="h-3 bg-gray-200 rounded w-2/3"></div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  if (selectedCourse) {
    return (
      <div className="space-y-6">
        {/* Back button */}
        <Button
          onClick={() => setSelectedCourse(null)}
          variant="outline"
          className="mb-4"
        >
          ← Назад до курсів
        </Button>

        {/* Course header */}
        <div className="bg-white rounded-2xl shadow-soft p-6">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            {selectedCourse.title}
          </h1>
          <p className="text-gray-600 text-lg">
            {selectedCourse.description}
          </p>
        </div>

        {/* Topics list */}
        <div className="space-y-4">
          {selectedCourse.topics?.map((topic) => (
            <Card key={topic.id} className="card-hover">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div className="flex items-center space-x-4 flex-1">
                    <div className="flex-shrink-0">
                      {getStatusIcon(topic)}
                    </div>
                    <div className="flex-1">
                      <h3 className="text-lg font-semibold text-gray-900 mb-1">
                        {topic.title}
                      </h3>
                      <p className="text-gray-600 text-sm mb-2">
                        {topic.description}
                      </p>
                      
                      {/* Progress bar */}
                      {topic.progress && hasAccess(topic) && (
                        <div className="w-full">
                          <div className="flex justify-between text-xs text-gray-500 mb-1">
                            <span>Прогрес</span>
                            <span>{getProgressPercentage(topic)}%</span>
                          </div>
                          <div className="progress-bar">
                            <div 
                              className="progress-fill" 
                              style={{ width: `${getProgressPercentage(topic)}%` }}
                            ></div>
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                  
                  <div className="flex items-center space-x-2">
                    {/* Video button */}
                    {topic.video_url && hasAccess(topic) && (
                      <Button
                        size="sm"
                        variant="outline"
                        className="flex items-center space-x-1"
                      >
                        <Video className="h-4 w-4" />
                        <span>Відео</span>
                      </Button>
                    )}
                    
                    {/* Notes button */}
                    {topic.lecture_notes && hasAccess(topic) && (
                      <Button
                        size="sm"
                        variant="outline"
                        className="flex items-center space-x-1"
                      >
                        <FileText className="h-4 w-4" />
                        <span>Конспект</span>
                      </Button>
                    )}
                    
                    {/* Test button */}
                    {hasAccess(topic) && (
                      <Button
                        size="sm"
                        className="btn-primary flex items-center space-x-1"
                      >
                        <CheckCircle className="h-4 w-4" />
                        <span>Тест</span>
                      </Button>
                    )}
                    
                    {/* Lock icon for no access */}
                    {!hasAccess(topic) && (
                      <div className="text-gray-400 text-sm">
                        <Lock className="h-4 w-4" />
                      </div>
                    )}
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">
          Ваші курси
        </h1>
        <p className="text-gray-600 text-lg">
          Оберіть курс для початку навчання
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {courses.map((course) => {
          const completedTopics = course.topics?.filter(topic => 
            topic.progress?.test_completed
          ).length || 0
          const totalTopics = course.topics?.length || 0
          const progressPercentage = totalTopics > 0 ? Math.round((completedTopics / totalTopics) * 100) : 0

          return (
            <div 
              key={course.id} 
              className="card-hover cursor-pointer"
              onClick={() => setSelectedCourse(course)}
            >
              <Card>
                <CardHeader>
                  <div className="flex items-center justify-between mb-2">
                    <div className="bg-primary-100 p-2 rounded-lg">
                      <BookOpen className="h-6 w-6 text-primary-500" />
                    </div>
                    <ChevronRight className="h-5 w-5 text-gray-400" />
                  </div>
                  <CardTitle className="text-xl">{course.title}</CardTitle>
                  <CardDescription>{course.description}</CardDescription>
                </CardHeader>
                <CardContent>
                <div className="space-y-4">
                  <div className="flex justify-between text-sm text-gray-600">
                    <span>Теми завершено</span>
                    <span>{completedTopics}/{totalTopics}</span>
                  </div>
                  
                  <div className="progress-bar">
                    <div 
                      className="progress-fill" 
                      style={{ width: `${progressPercentage}%` }}
                    ></div>
                  </div>
                  
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-gray-600">
                      {course.topics?.length || 0} тем
                    </span>
                    <span className="text-primary-500 font-medium">
                      {progressPercentage}% завершено
                    </span>
                  </div>
                </div>
              </CardContent>
              </Card>
            </div>
          )
        })}
      </div>
    </div>
  )
}
