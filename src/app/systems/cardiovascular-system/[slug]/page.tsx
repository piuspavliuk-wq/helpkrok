'use client'

import { useEffect, use, useState } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { useSession } from 'next-auth/react'
import AuthGuard from '@/components/auth/AuthGuard'
import { topicMap, sectionMap, sections } from '../data'
import SectionContent from '@/components/sections/SectionContent'

const courseTitle = 'Серцево-судинна система'

interface PageProps {
  params: Promise<{ slug: string }>
}

export default function SectionOrTopicPage({ params }: PageProps) {
  const router = useRouter()
  const { slug } = use(params)
  const { data: session } = useSession()
  const section = sectionMap[slug]
  const topic = topicMap[slug]
  const [sectionProgress, setSectionProgress] = useState<Record<string, { score: number | null; completed: boolean }>>({})
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!section && !topic) {
      router.push('/systems/cardiovascular-system')
    }
  }, [section, topic, router])

  useEffect(() => {
    if (session?.user?.id && section) {
      fetchSectionProgress()
    } else {
      setLoading(false)
    }
  }, [session?.user?.id, section])

  async function fetchSectionProgress() {
    if (!session?.user?.id) return
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

  function canAccessSection(sectionSlug: string): boolean {
    const isAdmin = session?.user?.email === 'admin@helpkrok.com'
    if (isAdmin) return true
    const sectionIndex = sections.findIndex((s) => s.slug === sectionSlug)
    if (sectionIndex === 0) return true
    const previousSection = sections[sectionIndex - 1]
    const previousProgress = sectionProgress[previousSection.slug]
    if (!previousProgress) return false
    return previousProgress.completed && (previousProgress.score || 0) >= 80
  }

  if (!section && !topic) return null

  if (section) {
    const sectionIndex = sections.findIndex((s) => s.slug === section.slug)
    const canAccess = canAccessSection(section.slug)

    if (!canAccess && sectionIndex > 0 && !loading) {
      return (
        <AuthGuard>
          <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden">
            <div className="relative z-10">
              <div className="px-6 py-8 sm:px-8 md:px-12">
                <Link href="/systems/cardiovascular-system" className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 transition-colors">
                  <span aria-hidden="true">&larr;</span>
                  <span>Назад до розділів</span>
                </Link>
              </div>
              <div className="px-6 py-8 sm:px-8 md:px-12">
                <div className="max-w-2xl mx-auto bg-white rounded-lg shadow-lg p-8 text-center">
                  <div className="mb-6">
                    <svg className="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Доступ обмежений</h2>
                    <p className="text-gray-600 mb-4">
                      Спочатку пройдіть попередній розділ на 80% і більше, щоб отримати доступ до цього розділу.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </AuthGuard>
      )
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
            <div className="px-[3px] py-8 md:px-6 sm:px-8 md:px-12">
              <Link href="/systems/cardiovascular-system" className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 transition-colors px-3 md:px-0">
                <span aria-hidden="true">&larr;</span>
                <span>Назад до розділів</span>
              </Link>
            </div>
            <SectionContent section={section} faculty="medical" courseTitle={courseTitle} />
          </div>
        </div>
      </AuthGuard>
    )
  }

  if (topic) {
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
          <div className="px-8 pt-20 pb-8 relative z-10">
            <div className="mx-auto max-w-[900px] space-y-8">
              <Link href="/systems/cardiovascular-system" className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 transition-colors">
                <span aria-hidden="true">&larr;</span>
                <span>Назад до розділів</span>
              </Link>
              <header>
                <p className="text-sm uppercase tracking-wide text-blue-600 font-semibold">{topic.sectionTitle}</p>
                <h1 className="mt-2 text-3xl font-bold text-gray-900">{topic.title}</h1>
                <p className="mt-4 text-gray-600">
                  Навчальні матеріали для цієї теми готуються. Незабаром тут зʼявляться конспекти, інтерактивні вправи та тести для самоперевірки.
                </p>
              </header>
              <section className="bg-white border border-blue-100 shadow-xl rounded-3xl p-10">
                <div className="space-y-4 text-gray-600">
                  <p>Поки контент не доступний, ви можете повернутися до інших розділів курсу, щоб продовжити навчання.</p>
                  <Link href="/systems/cardiovascular-system" className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 font-medium">
                    <span aria-hidden="true">&larr;</span>
                    <span>Перейти до списку розділів</span>
                  </Link>
                </div>
              </section>
            </div>
          </div>
        </div>
      </AuthGuard>
    )
  }

  return null
}
