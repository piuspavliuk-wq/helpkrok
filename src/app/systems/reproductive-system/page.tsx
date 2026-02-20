'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { useSession } from 'next-auth/react'
import AuthGuard from '@/components/auth/AuthGuard'
import { sections } from './data'

const courseTitle = 'Репродуктивна система'
const previousCourseTitle = 'Сечова система'

export default function ReproductiveSystemPage() {
  const { data: session } = useSession()
  const [sectionProgress, setSectionProgress] = useState<Record<string, { score: number | null; completed: boolean }>>({})
  const [loading, setLoading] = useState(true)
  const [hasCourseAccess, setHasCourseAccess] = useState(false)
  const [courseId, setCourseId] = useState<string | null>(null)
  const [previousCourseCompleted, setPreviousCourseCompleted] = useState(false)
  const [checkingPreviousCourse, setCheckingPreviousCourse] = useState(true)
  const baseSectionNumber = 35

  useEffect(() => {
    if (session?.user?.id) {
      fetchCourseAccess()
      fetchAllProgress()
      checkPreviousCourseCompletion()
    } else {
      setLoading(false)
      setCheckingPreviousCourse(false)
    }
  }, [session?.user?.id])

  async function fetchCourseAccess() {
    if (!session?.user?.id) return
    try {
      const courseResponse = await fetch('/api/courses?faculty=medical')
      const courseData = await courseResponse.json()
      if (!courseData.success || !courseData.courses) return
      const course = courseData.courses.find((c: { title: string }) => c.title === courseTitle)
      if (!course) return
      setCourseId(course.id)
      const accessResponse = await fetch(`/api/courses/check-access?course_id=${course.id}`)
      const accessData = await accessResponse.json()
      if (accessData.success) setHasCourseAccess(accessData.hasAccess)
    } catch (error) {
      console.error('Помилка перевірки доступу до курсу:', error)
    }
  }

  async function checkPreviousCourseCompletion() {
    if (!session?.user?.id) {
      setCheckingPreviousCourse(false)
      return
    }
    try {
      const coursesResponse = await fetch('/api/courses?faculty=medical')
      const coursesData = await coursesResponse.json()
      if (!coursesData.success || !coursesData.courses) {
        setCheckingPreviousCourse(false)
        return
      }
      const previousCourse = coursesData.courses.find((c: { title: string }) => c.title === previousCourseTitle)
      if (!previousCourse) {
        setCheckingPreviousCourse(false)
        return
      }
      const accessResponse = await fetch(`/api/courses/check-access?course_id=${previousCourse.id}`)
      const accessData = await accessResponse.json()
      if (!accessData.success || !accessData.hasAccess) {
        setPreviousCourseCompleted(false)
        setCheckingPreviousCourse(false)
        return
      }
      const topicsResponse = await fetch(`/api/topics?course_id=${previousCourse.id}`)
      const topicsData = await topicsResponse.json()
      if (topicsData.success && topicsData.topics?.length > 0) {
        const progressPromises = topicsData.topics.map(async (topic: { id: string }) => {
          const progressResponse = await fetch(`/api/topics/progress?topic_id=${topic.id}`)
          const progressData = await progressResponse.json()
          return progressData.success && progressData.progress
            ? { completed: progressData.progress.test_completed, score: progressData.progress.test_score || 0 }
            : { completed: false, score: 0 }
        })
        const progressResults = await Promise.all(progressPromises)
        const allCompleted =
          progressResults.every((p) => p.completed && p.score >= 80) && progressResults.length === topicsData.topics.length
        setPreviousCourseCompleted(allCompleted)
      } else {
        setPreviousCourseCompleted(false)
      }
    } catch (error) {
      console.error('Помилка перевірки попереднього курсу:', error)
      setPreviousCourseCompleted(false)
    } finally {
      setCheckingPreviousCourse(false)
    }
  }

  async function fetchAllProgress() {
    if (!session?.user?.id) {
      setLoading(false)
      return
    }
    try {
      const courseResponse = await fetch('/api/courses?faculty=medical')
      const courseData = await courseResponse.json()
      if (!courseData.success || !courseData.courses) {
        setLoading(false)
        return
      }
      const course = courseData.courses.find((c: { title: string }) => c.title === courseTitle)
      if (!course) {
        setLoading(false)
        return
      }
      const topicsResponse = await fetch(`/api/topics?course_id=${course.id}`)
      const topicsData = await topicsResponse.json()
      if (!topicsData.success || !topicsData.topics) {
        setLoading(false)
        return
      }
      const progressPromises = topicsData.topics.map(async (topic: { id: string; title: string }) => {
        const progressResponse = await fetch(`/api/topics/progress?topic_id=${topic.id}`)
        const progressData = await progressResponse.json()
        const section = sections.find((s) => topic.title.toLowerCase().includes(s.title.toLowerCase().substring(0, 20)))
        if (section) {
          return {
            sectionSlug: section.slug,
            progress:
              progressData.success && progressData.progress
                ? { score: progressData.progress.test_score, completed: progressData.progress.test_completed }
                : { score: null, completed: false }
          }
        }
        return null
      })
      const results = await Promise.all(progressPromises)
      const progressMap: Record<string, { score: number | null; completed: boolean }> = {}
      results.forEach((result) => {
        if (result) progressMap[result.sectionSlug] = result.progress
      })
      setSectionProgress(progressMap)
    } catch (error) {
      console.error('Помилка завантаження прогресу:', error)
    } finally {
      setLoading(false)
    }
  }

  function canAccessSection(sectionIndex: number): boolean {
    const isAdmin = session?.user?.email === 'admin@helpkrok.com'
    if (isAdmin) return true
    if (!hasCourseAccess) return false
    if (sectionIndex === 0) return true
    const previousSection = sections[sectionIndex - 1]
    const previousProgress = sectionProgress[previousSection.slug]
    if (!previousProgress) return false
    return previousProgress.completed && (previousProgress.score || 0) >= 80
  }

  return (
    <AuthGuard>
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden">
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
              <h1 className="text-3xl font-bold text-gray-900">{courseTitle}</h1>
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
                    <div
                      onClick={(e) => { e.preventDefault(); e.stopPropagation() }}
                      className="w-full flex items-start gap-4 rounded-lg bg-blue-50/50 px-6 py-4 text-left sm:px-8 md:px-12 cursor-not-allowed pointer-events-none"
                    >
                      <div className="flex-1">
                        <div className="font-medium text-gray-600 mb-1 flex items-center gap-3">
                          <svg className="w-5 h-5 text-gray-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                          </svg>
                          <span className="font-semibold">Розділ {section.sectionNumberLabel ?? baseSectionNumber + index}: </span>
                          <span>{section.title}</span>
                        </div>
                        {section.topics.length > 0 && (
                          <p className="text-sm text-gray-500 ml-8">
                            {section.topics.map((topic, idx) => (
                              <span key={topic.slug}>{topic.title}{idx < section.topics.length - 1 && ', '}</span>
                            ))}
                          </p>
                        )}
                        <p className="text-sm text-gray-500 mt-2 ml-8">
                          {!hasCourseAccess && !checkingPreviousCourse
                            ? `Спочатку пройдіть попередній курс "${previousCourseTitle}" на 80% і більше`
                            : index === 0 && !previousCourseCompleted && !checkingPreviousCourse
                              ? `Спочатку пройдіть попередній курс "${previousCourseTitle}" на 80% і більше`
                              : index > 0
                                ? 'Спочатку пройдіть попередній розділ на 80% і більше'
                                : checkingPreviousCourse
                                  ? 'Перевірка доступу...'
                                  : 'Для доступу до цього розділу необхідна оплата курсу'}
                        </p>
                      </div>
                    </div>
                  ) : (
                    <Link
                      href={`/systems/reproductive-system/${section.slug}`}
                      className="w-full flex items-start gap-4 rounded-lg bg-blue-50/80 px-6 py-4 text-left transition-colors duration-150 hover:bg-blue-100/80 sm:px-8 md:px-12 cursor-pointer"
                    >
                      <div className="flex-1">
                        <div className="font-medium text-gray-900 mb-1 flex items-center gap-2">
                          <span className="font-semibold">Розділ {section.sectionNumberLabel ?? baseSectionNumber + index}: </span>
                          {section.title}
                        </div>
                        {section.topics.length > 0 && (
                          <p className="text-sm text-gray-600">
                            {section.topics.map((topic, idx) => (
                              <span key={topic.slug}>{topic.title}{idx < section.topics.length - 1 && ', '}</span>
                            ))}
                          </p>
                        )}
                        {progress?.completed && progress.score !== null && (
                          <p className={`text-sm mt-2 font-semibold ${progress.score >= 80 ? 'text-blue-600' : 'text-blue-400'}`}>
                            Результат тесту: {progress.score}% {progress.score >= 80 ? '✓' : ''}
                          </p>
                        )}
                      </div>
                    </Link>
                  )}
                  {!isLast && <div className="border-b border-dashed border-blue-200 my-0"></div>}
                </div>
              )
            })}
          </div>
        </div>
      </div>
    </AuthGuard>
  )
}
