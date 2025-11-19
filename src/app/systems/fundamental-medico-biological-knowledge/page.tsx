'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { useSession } from 'next-auth/react'
import AuthGuard from '@/components/auth/AuthGuard'
import { sections } from './data'

const topics = sections.flatMap((section) => section.topics)
const trialTopicSlug = topics[0]?.slug

export default function FundamentalMedicoBiologicalKnowledgePage() {
  const { data: session } = useSession()
  const [sectionProgress, setSectionProgress] = useState<Record<string, { score: number | null; completed: boolean }>>({})
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (session?.user?.id) {
      fetchAllProgress()
    } else {
      setLoading(false)
    }
  }, [session?.user?.id])

  async function fetchAllProgress() {
    if (!session?.user?.id) return

    try {
      // Отримуємо курс
      const courseResponse = await fetch('/api/courses?faculty=medical')
      const courseData = await courseResponse.json()
      
      if (!courseData.success || !courseData.courses) {
        setLoading(false)
        return
      }

      const course = courseData.courses.find((c: { title: string }) => 
        c.title === 'Фундаментальні медико-біологічні знання'
      )

      if (!course) {
        setLoading(false)
        return
      }

      // Отримуємо всі topics
      const topicsResponse = await fetch(`/api/topics?course_id=${course.id}`)
      const topicsData = await topicsResponse.json()

      if (!topicsData.success || !topicsData.topics) {
        setLoading(false)
        return
      }

      // Отримуємо прогрес для кожного topic
      const progressPromises = topicsData.topics.map(async (topic: { id: string; title: string }) => {
        const progressResponse = await fetch(`/api/topics/progress?topic_id=${topic.id}`)
        const progressData = await progressResponse.json()
        
        // Знаходимо відповідний section slug
        const section = sections.find(s => 
          topic.title.toLowerCase().includes(s.title.toLowerCase().substring(0, 20))
        )
        
        if (section) {
          return {
            sectionSlug: section.slug,
            progress: progressData.success && progressData.progress 
              ? { 
                  score: progressData.progress.test_score, 
                  completed: progressData.progress.test_completed 
                }
              : { score: null, completed: false }
          }
        }
        return null
      })

      const results = await Promise.all(progressPromises)
      const progressMap: Record<string, { score: number | null; completed: boolean }> = {}
      
      results.forEach(result => {
        if (result) {
          progressMap[result.sectionSlug] = result.progress
        }
      })

      setSectionProgress(progressMap)
    } catch (error) {
      console.error('Помилка завантаження прогресу:', error)
    } finally {
      setLoading(false)
    }
  }

  function canAccessSection(sectionIndex: number): boolean {
    // Тимчасово відкриваємо всі розділи для тестування
    return true
    
    // Перший розділ завжди доступний
    // if (sectionIndex === 0) return true

    // Перевіряємо попередній розділ
    // const previousSection = sections[sectionIndex - 1]
    // const previousProgress = sectionProgress[previousSection.slug]

    // if (!previousProgress) return false

    // return previousProgress.completed && (previousProgress.score || 0) >= 80
  }

  return (
    <AuthGuard>
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
        <div className="relative z-10">
          <div className="px-6 py-8 sm:px-8 md:px-12">
            <Link
              href="/systems"
              className="inline-flex items-center gap-2 text-blue-600 transition-colors duration-150 hover:text-blue-700"
            >
              <span aria-hidden="true">&larr;</span>
              <span>Назад до курсів</span>
            </Link>
          </div>

          <div className="px-6 py-8 sm:px-8 md:px-12">
            <div className="space-y-2 mb-10">
              <h1 className="text-3xl font-bold text-gray-900">
                Фундаментальні медико-біологічні знання
              </h1>
            </div>
          </div>

          <div className="space-y-0 pb-16 md:pb-20">
            {sections.map((section, index) => {
              const isLast = index === sections.length - 1
              const canAccess = canAccessSection(index)
              const progress = sectionProgress[section.slug]
              const isLocked = !canAccess

              return (
                <div key={section.title}>
                  {isLocked ? (
                    <div className="w-full flex items-start gap-4 rounded-lg bg-blue-50/50 px-6 py-4 text-left sm:px-8 md:px-12 cursor-not-allowed">
                      <div className="flex-1">
                        <div className="font-medium text-gray-600 mb-1 flex items-center gap-3">
                          <svg 
                            className="w-5 h-5 text-gray-400 flex-shrink-0" 
                            fill="none" 
                            viewBox="0 0 24 24" 
                            stroke="currentColor"
                          >
                            <path 
                              strokeLinecap="round" 
                              strokeLinejoin="round" 
                              strokeWidth={2} 
                              d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" 
                            />
                          </svg>
                          <span className="font-semibold">Розділ {index + 1}: </span>
                          <span>{section.title}</span>
                        </div>
                        {section.topics.length > 0 && (
                          <p className="text-sm text-gray-500 ml-8">
                            {section.topics.map((topic, idx) => (
                              <span key={topic.slug}>
                                {topic.title}
                                {idx < section.topics.length - 1 && ', '}
                              </span>
                            ))}
                          </p>
                        )}
                        <p className="text-sm text-gray-500 mt-2 ml-8">
                          Спочатку пройдіть попередній розділ на 80% і більше
                        </p>
                      </div>
                    </div>
                  ) : (
                    <Link
                      href={`/systems/fundamental-medico-biological-knowledge/${section.slug}`}
                      className="w-full flex items-start gap-4 rounded-lg bg-blue-50/80 px-6 py-4 text-left transition-colors duration-150 hover:bg-blue-100/80 sm:px-8 md:px-12 cursor-pointer"
                    >
                      <div className="flex-1">
                        <div className="font-medium text-gray-900 mb-1 flex items-center gap-2">
                          <span className="font-semibold">Розділ {index + 1}: </span>
                          {section.title}
                        </div>
                        {section.topics.length > 0 && (
                          <p className="text-sm text-gray-600">
                            {section.topics.map((topic, idx) => (
                              <span key={topic.slug}>
                                {topic.title}
                                {idx < section.topics.length - 1 && ', '}
                              </span>
                            ))}
                          </p>
                        )}
                        {progress && progress.completed && progress.score !== null && (
                          <p className={`text-sm mt-2 font-semibold ${
                            progress.score >= 80 ? 'text-blue-600' : 'text-blue-400'
                          }`}>
                            Результат тесту: {progress.score}% {progress.score >= 80 ? '✓' : ''}
                          </p>
                        )}
                      </div>
                    </Link>
                  )}
                  {!isLast && (
                    <div className="border-b border-dashed border-blue-200 my-0"></div>
                  )}
                </div>
              )
            })}
          </div>
        </div>
      </div>
    </AuthGuard>
  )
}

