'use client'

import { useEffect, use } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import AuthGuard from '@/components/auth/AuthGuard'
import { topicMap, sectionMap } from '../data'
import SectionContent from '@/components/sections/SectionContent'

interface PageProps {
  params: Promise<{
    slug: string
  }>
}

export default function SectionOrTopicPage({ params }: PageProps) {
  const router = useRouter()
  const { slug } = use(params)
  const section = sectionMap[slug]
  const topic = topicMap[slug]

  useEffect(() => {
    if (!section && !topic) {
      router.push('/systems/organic-compounds-basics')
    }
  }, [section, topic, router])

  if (!section && !topic) {
    return null
  }

  // Якщо це розділ
  if (section) {
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
              <Link
                href="/systems/organic-compounds-basics"
                className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 transition-colors px-3 md:px-0"
              >
                <span aria-hidden="true">&larr;</span>
                <span>Назад до розділів</span>
              </Link>
            </div>

            <SectionContent section={section} />
          </div>
        </div>
      </AuthGuard>
    )
  }

  // Якщо це тема
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
              <Link
                href="/systems/organic-compounds-basics"
                className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 transition-colors"
              >
                <span aria-hidden="true">&larr;</span>
                <span>Назад до розділів</span>
              </Link>

              <header>
                <p className="text-sm uppercase tracking-wide text-blue-600 font-semibold">
                  {topic.sectionTitle}
                </p>
                <h1 className="mt-2 text-3xl font-bold text-gray-900">{topic.title}</h1>
                <p className="mt-4 text-gray-600">
                  Навчальні матеріали для цієї теми готуються. Незабаром тут зʼявляться конспекти,
                  інтерактивні вправи та тести для самоперевірки.
                </p>
              </header>

              <section className="bg-white border border-blue-100 shadow-xl rounded-3xl p-10">
                <div className="space-y-4 text-gray-600">
                  <p>
                    Поки контент не доступний, ви можете повернутися до інших розділів курсу, щоб
                    продовжити навчання.
                  </p>
                  <Link
                    href="/systems/organic-compounds-basics"
                    className="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 font-medium"
                  >
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
}

