'use client'

import { useState, type ReactNode } from 'react'
import Link from 'next/link'
import AuthGuard from '@/components/auth/AuthGuard'
import { sections as fundamentalSections } from './fundamental-medico-biological-knowledge/data'
import { sections as organicCompoundsSections } from './organic-compounds-basics/data'
import { CustomSelect } from '@/components/ui/CustomSelect'

const courses = [
  {
    id: 'fundamental-medico-biological-knowledge',
    title: 'Фундаментальні медико-біологічні знання',
    description:
      'Комплексний курс із молекулярної біології, генетики та біохімії для майбутніх медиків.',
    slug: '/systems/fundamental-medico-biological-knowledge',
    price: '5990 грн',
    isTrialAvailable: true,
    topicsCount: fundamentalSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🧬'
  },
  {
    id: 'blood-system-and-immunity',
    title: 'Система кровотворення й імунного захисту, кров',
    description:
      'Комплексний курс з гематології, імунології та системи крові для майбутніх медиків.',
    slug: '/systems/blood-system-and-immunity',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: 0,
    faculty: 'medical' as const,
    emoji: '🛡️'
  },
  {
    id: 'organic-compounds-basics',
    title: 'Основи знань про органічні сполуки',
    description:
      'Комплексний курс з органічної хімії: будова, номенклатура, ізомерія, хімічні властивості та ідентифікація органічних сполук для майбутніх фармацевтів.',
    slug: '/systems/organic-compounds-basics',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: organicCompoundsSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '⚗️'
  }
]

const facultyOptions = [
  { value: 'medical', label: 'Медицина' },
  { value: 'pharmaceutical', label: 'Фармація' }
] as const

function Badge({ children }: { children: ReactNode }) {
  return (
    <span className="inline-flex items-center gap-1 rounded-full bg-rose-500 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-white shadow-sm">
      <span aria-hidden="true">🔒</span>
      {children}
    </span>
  )
}

function CoinIcon() {
  return (
    <svg
      className="h-4 w-4 text-amber-500"
      viewBox="0 0 24 24"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M12 2C6.486 2 2 5.589 2 10c0 3.595 2.861 6.633 6.786 7.74l2.102 3.325a1 1 0 001.724 0l2.102-3.325C19.139 16.633 22 13.595 22 10c0-4.411-4.486-8-10-8zm0 2c3.86 0 7 2.468 7 6 0 2.64-2.088 4.82-5.209 5.63a1 1 0 00-.673.478L12 19.055l-1.118-1.947a1 1 0 00-.673-.478C7.088 12.82 5 10.64 5 8c0-3.532 3.14-6 7-6z" />
    </svg>
  )
}

export default function CoursesPage() {
  const [selectedFaculty, setSelectedFaculty] = useState<(typeof facultyOptions)[number]['value']>('medical')
  const filteredCourses = courses.filter((course) => course.faculty === selectedFaculty)

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
        <div className="relative z-10 px-6 py-16 sm:px-8 md:px-12">
          <div className="mx-auto max-w-5xl">
            <header className="mb-12 flex justify-end">
              <CustomSelect
                value={selectedFaculty}
                onChange={(value) => setSelectedFaculty(value as (typeof facultyOptions)[number]['value'])}
                options={facultyOptions.map(({ value, label }) => ({ value, label }))}
                className="w-40"
              />
            </header>

            <div className="grid gap-8 sm:grid-cols-2">
              {filteredCourses.map((course) => (
                <Link
                  key={course.id}
                  href={course.slug}
                  className="group relative flex min-h-[420px] flex-col overflow-hidden rounded-[32px] border border-blue-100 bg-white shadow-[0_24px_50px_rgba(37,99,235,0.08)] transition-transform duration-200 hover:-translate-y-2 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-400 focus-visible:ring-offset-2 focus-visible:ring-offset-blue-50"
                >
                  <div className="relative h-56 bg-gradient-to-r from-blue-200 via-blue-100 to-sky-100">
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_top,_rgba(59,130,246,0.15),_transparent_60%)]"></div>
                    <div className="absolute inset-0 flex items-center justify-center">
                      <span className="text-7xl" aria-hidden="true">
                        {course.emoji}
                      </span>
                    </div>
                    <div className="pointer-events-none absolute inset-0 flex items-center justify-center rounded-none bg-white/75 backdrop-blur-sm opacity-0 transition-opacity duration-200 group-hover:opacity-100">
                      <div className="flex flex-col items-center gap-2 text-gray-800">
                        <span className="text-3xl" aria-hidden="true">
                          ☰
                        </span>
                        <span className="text-sm font-semibold uppercase tracking-wide">
                          Переглянути теми
                        </span>
                      </div>
                    </div>
                  </div>

                  <div className="flex flex-1 flex-col px-6 py-8 sm:px-8 sm:py-10">
                    <div className="space-y-3">
                      <h2 className="text-xl font-semibold text-gray-900 sm:text-2xl transition-colors duration-150 group-hover:text-blue-600">
                        {course.title}
                      </h2>
                    </div>

                    <div className="mt-8 flex items-center justify-end">
                      <span className="inline-flex items-center gap-2 rounded-full bg-blue-500 px-5 py-2 text-sm font-semibold text-white shadow-lg shadow-blue-500/30 transition-colors duration-150 group-hover:bg-blue-600">
                        Купити
                      </span>
                    </div>
                  </div>
                </Link>
              ))}
            </div>

            {filteredCourses.length === 0 && (
              <div className="mt-12 rounded-3xl border border-blue-100 bg-white/70 px-8 py-10 text-center text-gray-600 shadow-inner">
                Для обраного факультету курси поки недоступні. Слідкуйте за оновленнями — нові програми
                з’являться зовсім скоро.
              </div>
            )}
          </div>
        </div>
      </div>
    </AuthGuard>
  )
}
