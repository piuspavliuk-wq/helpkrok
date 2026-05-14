'use client'

import { useState, useEffect, type ReactNode } from 'react'
import Link from 'next/link'
import { useSession } from 'next-auth/react'
import AuthGuard from '@/components/auth/AuthGuard'
import { sections as fundamentalSections } from './fundamental-medico-biological-knowledge/data'
import { sections as organicCompoundsSections } from './organic-compounds-basics/data'
import { sections as centralNervousSystemSections } from './central-nervous-system/data'
import { sections as pharmaceuticalAnalysisSections } from './pharmaceutical-analysis-theory/data'
import { sections as physicalPhysicochemicalSections } from './physical-physicochemical-basics/data'
import { sections as pharmaceuticalBotanySections } from './pharmaceutical-botany/data'
import { sections as pathologicalProcessesSections } from './pathological-processes/data'
import { sections as biochemicalProcessesSections } from './biochemical-processes/data'
import { sections as infectiousDiseaseAgentsSections } from './infectious-disease-agents/data'
import { sections as rationalDrugUseSections } from './rational-drug-use/data'
import { sections as morphologicalStructureVegetativeOrgansSections } from './morphological-structure-vegetative-organs/data'
import { sections as integumentarySystemSections } from './integumentary-system/data'
import { sections as musculoskeletalSystemSections } from './musculoskeletal-system/data'
import { sections as respiratorySystemSections } from './respiratory-system/data'
import { sections as cardiovascularSystemSections } from './cardiovascular-system/data'
import { sections as digestiveSystemSections } from './digestive-system/data'
import { sections as urinarySystemSections } from './urinary-system/data'
import { sections as reproductiveSystemSections } from './reproductive-system/data'
import { sections as endocrineSystemSections } from './endocrine-system/data'
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
    id: 'central-nervous-system',
    title: 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття',
    description:
      'Комплексний курс з центральної та периферичної нервової системи та органів чуття для майбутніх медиків.',
    slug: '/systems/central-nervous-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: centralNervousSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🧠'
  },
  {
    id: 'integumentary-system',
    title: 'Загальний покрив (шкіра та її деривати)',
    description:
      'Комплексний курс з загального покриву: шкіра та її похідні для майбутніх медиків.',
    slug: '/systems/integumentary-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: integumentarySystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🩹'
  },
  {
    id: 'musculoskeletal-system',
    title: 'Опорно-руховий апарат. Анатомія',
    description:
      'Комплексний курс з анатомії опорно-рухового апарату для майбутніх медиків.',
    slug: '/systems/musculoskeletal-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: musculoskeletalSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🦴'
  },
  {
    id: 'respiratory-system',
    title: 'Дихальна система',
    description:
      'Комплексний курс з дихальної системи для майбутніх медиків.',
    slug: '/systems/respiratory-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: respiratorySystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🫁'
  },
  {
    id: 'cardiovascular-system',
    title: 'Серцево-судинна система',
    description:
      'Комплексний курс з серцево-судинної системи для майбутніх медиків.',
    slug: '/systems/cardiovascular-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: cardiovascularSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '❤️'
  },
  {
    id: 'digestive-system',
    title: 'Травна система',
    description:
      'Комплексний курс з травної системи для майбутніх медиків.',
    slug: '/systems/digestive-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: digestiveSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🫃',
    iconUrl: 'https://cdn-icons-png.flaticon.com/512/4848/4848865.png'
  },
  {
    id: 'urinary-system',
    title: 'Сечова система',
    description:
      'Комплексний курс з сечової системи для майбутніх медиків.',
    slug: '/systems/urinary-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: urinarySystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🫘',
    iconUrl: 'https://cdn-icons-png.freepik.com/512/16825/16825756.png'
  },
  {
    id: 'reproductive-system',
    title: 'Репродуктивна система',
    description:
      'Комплексний курс з репродуктивної системи для майбутніх медиків.',
    slug: '/systems/reproductive-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: reproductiveSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🫃',
    iconUrl: 'https://image.similarpng.com/file/similarpng/original-picture/2020/07/Female-reproductive-system-Clipart-PNG.png'
  },
  {
    id: 'endocrine-system',
    title: 'Ендокринна система',
    description:
      'Комплексний курс з ендокринної системи для майбутніх медиків.',
    slug: '/systems/endocrine-system',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: endocrineSystemSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'medical' as const,
    emoji: '🩺'
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
  },
  {
    id: 'pharmaceutical-analysis-theory',
    title: 'Теоретичні основи фармацевтичного аналізу',
    description:
      'Комплексний курс з теоретичних основ фармацевтичного аналізу для майбутніх фармацевтів.',
    slug: '/systems/pharmaceutical-analysis-theory',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: pharmaceuticalAnalysisSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🔬'
  },
  {
    id: 'physical-physicochemical-basics',
    title: 'Фізичні та фізико-хімічні основи хіміко-біологічних процесів і фармацевтичної технології',
    description:
      'Комплексний курс з фізичних та фізико-хімічних основ хіміко-біологічних процесів і фармацевтичної технології для майбутніх фармацевтів.',
    slug: '/systems/physical-physicochemical-basics',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: physicalPhysicochemicalSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '⚛️'
  },
  {
    id: 'pharmaceutical-botany',
    title: 'Фармацевтична ботаніка',
    description:
      'Комплексний курс з фармацевтичної ботаніки для майбутніх фармацевтів.',
    slug: '/systems/pharmaceutical-botany',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: pharmaceuticalBotanySections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🌿'
  },
  {
    id: 'pathological-processes',
    title: 'Основні патологічні процеси',
    description:
      'Комплексний курс з основних патологічних процесів для майбутніх фармацевтів.',
    slug: '/systems/pathological-processes',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: pathologicalProcessesSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🩺'
  },
  {
    id: 'biochemical-processes',
    title: 'Основні біохімічні процеси',
    description:
      'Комплексний курс з основних біохімічних процесів для майбутніх фармацевтів.',
    slug: '/systems/biochemical-processes',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: biochemicalProcessesSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🧪'
  },
  {
    id: 'infectious-disease-agents',
    title: 'Основи знань про збудників інфекційних хвороб',
    description:
      'Комплексний курс з основ знань про збудників інфекційних хвороб для майбутніх фармацевтів.',
    slug: '/systems/infectious-disease-agents',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: infectiousDiseaseAgentsSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🦠'
  },
  {
    id: 'rational-drug-use',
    title: 'Основи раціонального застосування лікарських засобів',
    description:
      'Комплексний курс з основ раціонального застосування лікарських засобів для майбутніх фармацевтів.',
    slug: '/systems/rational-drug-use',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: rationalDrugUseSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '💊'
  },
  {
    id: 'morphological-structure-vegetative-organs',
    title: 'Морфологічна будова вегетативних органів',
    description:
      'морфологічна будова кореня, стебла, листка та їх видозміни',
    slug: '/systems/morphological-structure-vegetative-organs',
    price: '3000 грн',
    isTrialAvailable: true,
    topicsCount: morphologicalStructureVegetativeOrgansSections.reduce((total, section) => total + section.topics.length, 0),
    faculty: 'pharmaceutical' as const,
    emoji: '🌱'
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
  const { data: session } = useSession()
  const [selectedFaculty, setSelectedFaculty] = useState<(typeof facultyOptions)[number]['value']>('medical')
  const [courseAccess, setCourseAccess] = useState<Record<string, boolean>>({})
  const [loadingAccess, setLoadingAccess] = useState(true)
  const [hasSubscription, setHasSubscription] = useState(false)
  const [profileLoaded, setProfileLoaded] = useState(false)
  const filteredCourses = courses.filter((course) => course.faculty === selectedFaculty)
  
  // Визначаємо порядок курсів медичного факультету
  const medicalCourseOrder = [
    'fundamental-medico-biological-knowledge',
    'blood-system-and-immunity',
    'central-nervous-system',
    'integumentary-system',
    'musculoskeletal-system',
    'respiratory-system',
    'cardiovascular-system',
    'digestive-system',
    'urinary-system',
    'reproductive-system',
    'endocrine-system'
  ]
  
  // Визначаємо порядок курсів фармацевтичного факультету
  const pharmaceuticalCourseOrder = [
    'organic-compounds-basics',
    'pharmaceutical-analysis-theory',
    'physical-physicochemical-basics',
    'pharmaceutical-botany',
    'pathological-processes',
    'biochemical-processes',
    'infectious-disease-agents',
    'rational-drug-use',
    'morphological-structure-vegetative-organs'
  ]
  
  // Визначаємо порядок курсів для поточного факультету
  const currentCourseOrder = selectedFaculty === 'medical' ? medicalCourseOrder : pharmaceuticalCourseOrder

  // Завантажуємо профіль користувача для встановлення факультету за замовчуванням
  useEffect(() => {
    async function loadUserProfile() {
      if (!session?.user?.id) {
        setProfileLoaded(true)
        return
      }

      try {
        const response = await fetch('/api/user/profile')
        const data = await response.json()

        if (data.success && data.profile?.faculty) {
          const userFaculty = data.profile.faculty as 'medical' | 'pharmaceutical'
          // Встановлюємо факультет з профілю, якщо він валідний
          if (userFaculty === 'medical' || userFaculty === 'pharmaceutical') {
            setSelectedFaculty(userFaculty)
          }
        }
      } catch (error) {
        console.error('Помилка завантаження профілю:', error)
      } finally {
        setProfileLoaded(true)
      }
    }

    loadUserProfile()
  }, [session?.user?.id])

  useEffect(() => {
    if (session?.user?.id && profileLoaded) {
      checkCourseAccess()
    } else if (!session?.user?.id) {
      setLoadingAccess(false)
    }
  }, [session?.user?.id, selectedFaculty, profileLoaded])

  async function checkCourseAccess() {
    if (!session?.user?.id) {
      setLoadingAccess(false)
      return
    }

    try {
      // Отримуємо всі курси для обраного факультету
      const response = await fetch(`/api/courses?faculty=${selectedFaculty}`)
      const data = await response.json()

      if (!data.success || !data.courses) {
        setLoadingAccess(false)
        return
      }

      // Перевіряємо доступ для кожного курсу
      const accessPromises = data.courses.map(async (course: { id: string; title: string }) => {
        try {
          const accessResponse = await fetch(`/api/courses/check-access?course_id=${course.id}`)
          const accessData = await accessResponse.json()
          
          return {
            courseTitle: course.title,
            hasAccess: accessData.success ? accessData.hasAccess : false
          }
        } catch (error) {
          console.error(`Помилка перевірки доступу для курсу ${course.title}:`, error)
          return {
            courseTitle: course.title,
            hasAccess: false
          }
        }
      })

      const results = await Promise.all(accessPromises)
      const accessMap: Record<string, boolean> = {}
      
      results.forEach(result => {
        accessMap[result.courseTitle] = result.hasAccess
      })

      setCourseAccess(accessMap)

      // Перевіряємо чи є у користувача підписка/оплата
      await checkSubscriptionStatus()

    } catch (error) {
      console.error('Помилка перевірки доступу до курсів:', error)
    } finally {
      setLoadingAccess(false)
    }
  }

  async function checkSubscriptionStatus() {
    if (!session?.user?.id) {
      setHasSubscription(false)
      return
    }

    try {
      // Перевіряємо чи є активна підписка через API перевірки доступу до першого курсу відповідного факультету
      // Якщо є hasSubscriptionAccess або hasSubscriptionPayment - значить є підписка
      const firstCourseId = selectedFaculty === 'medical' 
        ? 'fundamental-medico-biological-knowledge'
        : 'organic-compounds-basics'
      
      const response = await fetch(`/api/courses/check-access?course_id=${firstCourseId}`)
      const data = await response.json()

      if (data.success) {
        // Якщо є будь-який доступ до першого курсу (підписка, оплата, course_access) —
        // вважаємо що користувач заплатив і ховаємо кнопку "Купити доступ"
        const hasSub =
          data.hasAccess ||
          data.debug?.hasSubscriptionAccess ||
          data.debug?.hasSubscriptionPayment ||
          data.debug?.hasCourseAccess
        setHasSubscription(hasSub || false)
      } else {
        setHasSubscription(false)
      }
    } catch (error) {
      console.error('Помилка перевірки підписки:', error)
      setHasSubscription(false)
    }
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
        <div className="relative z-10 px-6 py-16 sm:px-8 md:px-12">
          <div className="mx-auto max-w-5xl">
            <header className="mb-12 flex justify-between items-center">
              <div>
                {!loadingAccess && 
                 !hasSubscription && 
                 filteredCourses.length > 0 && 
                 filteredCourses.some((course) => !courseAccess[course.title]) && (
                  <Link
                    href="/#pricing"
                    className="inline-flex items-center gap-2 rounded-full bg-blue-500 px-6 py-3 text-base font-semibold text-white shadow-lg shadow-blue-500/30 transition-colors duration-150 hover:bg-blue-600"
                  >
                    Купити доступ до курсів
                  </Link>
                )}
              </div>
              <CustomSelect
                value={selectedFaculty}
                onChange={(value) => setSelectedFaculty(value as (typeof facultyOptions)[number]['value'])}
                options={facultyOptions.map(({ value, label }) => ({ value, label }))}
                className="w-40"
              />
            </header>

            <div className="grid gap-8 sm:grid-cols-2">
              {filteredCourses.map((course) => {
                const hasAccess = courseAccess[course.title] || false

                return (
                  <div
                    key={course.id}
                    className="group relative flex min-h-[420px] flex-col overflow-hidden rounded-[32px] border border-blue-100 bg-white shadow-[0_24px_50px_rgba(37,99,235,0.08)] transition-transform duration-200 hover:-translate-y-2"
                  >
                    <Link
                      href={course.slug}
                      className="flex-1 flex flex-col"
                    >
                      <div className="relative h-56 bg-gradient-to-r from-blue-200 via-blue-100 to-sky-100">
                        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top,_rgba(59,130,246,0.15),_transparent_60%)]"></div>
                        <div className="absolute inset-0 flex items-center justify-center">
                          {'iconUrl' in course && course.iconUrl ? (
                            <img
                              src={course.iconUrl}
                              alt=""
                              className="h-20 w-20 object-contain sm:h-24 sm:w-24"
                              aria-hidden
                            />
                          ) : (
                            <span className="text-7xl" aria-hidden="true">
                              {course.emoji}
                            </span>
                          )}
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
                      </div>
                    </Link>

                  </div>
                )
              })}
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
