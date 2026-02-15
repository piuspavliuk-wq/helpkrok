'use client'

import { useState, useEffect, useRef, useCallback } from 'react'
import { useSession } from 'next-auth/react'
import { Section } from '@/app/systems/fundamental-medico-biological-knowledge/data'

interface Question {
  id: string
  question_text: string
  explanation: string | null
  difficulty: 'easy' | 'medium' | 'hard'
  image_url?: string | null
  options: {
    id: string
    option_text: string
    is_correct: boolean
    order_index: number
  }[]
}

interface SectionContentProps {
  section: Section
  courseTitle?: string
  faculty?: 'medical' | 'pharmaceutical'
}

export default function SectionContent({ section, courseTitle, faculty = 'medical' }: SectionContentProps) {
  const { data: session } = useSession()
  const [activeTab, setActiveTab] = useState<'video' | 'notes' | 'tests'>('video')
  const [activeTestTab, setActiveTestTab] = useState<'test1' | 'test2'>('test1')
  const [questions, setQuestions] = useState<Question[]>([])
  const [loading, setLoading] = useState(false)
  const [loadingTopic, setLoadingTopic] = useState(false)
  const [selectedAnswers, setSelectedAnswers] = useState<Record<string, string>>({})
  const [showAnswers, setShowAnswers] = useState(false)
  const [topicId, setTopicId] = useState<string | null>(null)
  const [testCompleted, setTestCompleted] = useState(false)
  const [testScore, setTestScore] = useState<number | null>(null)
  const [savingResults, setSavingResults] = useState(false)
  const [pdfErrors, setPdfErrors] = useState<Record<string, boolean>>({})
  const checkingPdfRef = useRef<Set<string>>(new Set())
  const [loadingProgress, setLoadingProgress] = useState(false)
  const [imageModalSrc, setImageModalSrc] = useState<string | null>(null)
  const [failedImageKeys, setFailedImageKeys] = useState<Record<string, boolean>>({})

  // Унікальний ідентифікатор тесту для збереження прогресу
  const getTestIdentifier = useCallback(() => {
    const baseId = `${faculty}-${section.slug}`
    if (section.slug === 'section-3') {
      return `${baseId}-${activeTestTab}`
    }
    return baseId
  }, [faculty, section.slug, activeTestTab])

  // Перевіряємо наявність PDF файлів
  useEffect(() => {
    if (activeTab === 'notes' && ((section.notes && section.notes.length > 0) || (section.presentations && section.presentations.length > 0))) {
      const noteFiles = section.notes?.map(n => n.file) || []
      const presentationFiles = section.presentations?.map(p => p.file) || []
      const allFiles = [...noteFiles, ...presentationFiles]
      
      allFiles.forEach((file) => {
        // Перевіряємо, чи файл вже перевіряється або має помилку
        if (!pdfErrors[file] && !checkingPdfRef.current.has(file)) {
          checkingPdfRef.current.add(file)
          // Перевіряємо, чи файл існує
          fetch(file, { method: 'HEAD' })
            .then(response => {
              if (!response.ok || response.status === 404) {
                setPdfErrors(prev => ({ ...prev, [file]: true }))
              }
            })
            .catch(() => {
              setPdfErrors(prev => ({ ...prev, [file]: true }))
            })
            .finally(() => {
              checkingPdfRef.current.delete(file)
            })
        }
      })
    }
  }, [activeTab, section.notes, section.presentations, pdfErrors])

  // Отримуємо topic_id для поточного розділу та тесту
  useEffect(() => {
    if (activeTab === 'tests') {
      // Скидаємо попередній topicId при зміні розділу або тесту
      setTopicId(null)
      setQuestions([])
      setSelectedAnswers({})
      setShowAnswers(false)
      setTestCompleted(false)
      setTestScore(null)
      fetchTopicId()
    }
  }, [section.slug, section.title, activeTab, activeTestTab])

  // Завантажуємо питання коли є topic_id
  useEffect(() => {
    if (topicId && activeTab === 'tests') {
      fetchQuestions()
    }
  }, [topicId, activeTab])
  
  // Модалка зображення: Escape та блокування скролу body
  useEffect(() => {
    if (!imageModalSrc) return
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setImageModalSrc(null)
    }
    document.addEventListener('keydown', onKeyDown)
    document.body.style.overflow = 'hidden'
    return () => {
      document.removeEventListener('keydown', onKeyDown)
      document.body.style.overflow = ''
    }
  }, [imageModalSrc])

  // Завантажуємо збережений прогрес коли є питання і користувач авторизований
  useEffect(() => {
    if (questions.length > 0 && session?.user?.id && activeTab === 'tests' && !testCompleted) {
      loadSavedProgress()
    }
  }, [questions, session?.user?.id, activeTab, testCompleted])
  
  // Функція для завантаження збереженого прогресу
  async function loadSavedProgress() {
    if (!session?.user?.id || questions.length === 0) return
    
    const testType = getTestIdentifier()
    setLoadingProgress(true)
    
    try {
      const response = await fetch(`/api/test-progress?testType=${encodeURIComponent(testType)}`)
      const data = await response.json()
      
      if (data.success && data.progress) {
        console.log('Завантажено збережений прогрес:', data.progress)
        // Конвертуємо збережені відповіді (option_id) у формат для selectedAnswers
        const loadedAnswers: Record<string, string> = {}
        Object.entries(data.progress).forEach(([questionId, savedOptionId]) => {
          // Знаходимо питання і перевіряємо чи option_id валідний
          const question = questions.find(q => q.id === questionId)
          if (question) {
            const option = question.options.find(opt => opt.id === savedOptionId)
            if (option) {
              loadedAnswers[questionId] = savedOptionId as string
            }
          }
        })
        setSelectedAnswers(loadedAnswers)
      }
    } catch (error) {
      console.error('Помилка завантаження прогресу:', error)
    } finally {
      setLoadingProgress(false)
    }
  }
  
  // Функція для збереження відповіді в базу даних
  async function saveAnswerProgress(questionId: string, optionId: string) {
    if (!session?.user?.id) return
    
    const question = questions.find(q => q.id === questionId)
    if (!question) return
    
    const selectedOption = question.options.find(opt => opt.id === optionId)
    const correctOption = question.options.find(opt => opt.is_correct)
    
    if (!selectedOption || !correctOption) return
    
    const testType = getTestIdentifier()
    
    try {
      const response = await fetch('/api/test-progress', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          testType,
          questionId,
          selectedAnswer: optionId,
          correctAnswer: correctOption.id
        }),
      })
      
      if (!response.ok) {
        let errorBody: any = null
        try {
          errorBody = await response.json()
        } catch {
          // ігноруємо, якщо тіло не JSON
        }
        console.error('Помилка збереження прогресу:', response.status, errorBody)
      }
    } catch (error) {
      console.error('Помилка збереження прогресу:', error)
    }
  }

  async function fetchTopicId() {
    setLoadingTopic(true)
    try {
      // Визначаємо назву курсу
      let targetCourseTitle = courseTitle
      
      // Якщо courseTitle не передано, визначаємо на основі section slug
      if (!targetCourseTitle) {
        // Розділи 18-21 належать до нового курсу
        if (section.slug.startsWith('section-18') || 
            section.slug.startsWith('section-19') || 
            section.slug.startsWith('section-20') || 
            section.slug.startsWith('section-21')) {
          targetCourseTitle = 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
        } else {
          // Для інших розділів використовуємо старий курс
          targetCourseTitle = 'Фундаментальні медико-біологічні знання'
        }
      }

      const response = await fetch(`/api/courses?faculty=${faculty}`)
      const data = await response.json()

      if (data.success && data.courses) {
        const course = data.courses.find((c: { title: string }) =>
          c.title === targetCourseTitle
        )

        if (course) {
          // Для розділу 3 використовуємо різні назви для тестів
          let topicTitle = section.title
          if (section.slug === 'section-3') {
            topicTitle = activeTestTab === 'test1' 
              ? `${section.title} - Тест 1`
              : `${section.title} - Тест 2`
          }
          
          const topicsResponse = await fetch(`/api/topics?course_id=${course.id}&title=${encodeURIComponent(topicTitle)}`)
          const topicsData = await topicsResponse.json()

          console.log('Пошук topic:', {
            courseTitle: targetCourseTitle,
            courseId: course.id,
            topicTitle,
            response: topicsData
          })

          if (topicsData.success && topicsData.topics && topicsData.topics.length > 0) {
            setTopicId(topicsData.topics[0].id)
          } else {
            // Якщо topic не знайдено за точною назвою, спробуємо знайти всі topics курсу
            // і знайти найближчий за назвою
            const allTopicsResponse = await fetch(`/api/topics?course_id=${course.id}`)
            const allTopicsData = await allTopicsResponse.json()
            
            console.log('Всі topics курсу:', allTopicsData)
            
            if (allTopicsData.success && allTopicsData.topics) {
              // Шукаємо topic, який містить назву розділу
              const matchingTopic = allTopicsData.topics.find((t: { title: string }) => 
                t.title === topicTitle || 
                t.title.toLowerCase().includes(topicTitle.toLowerCase().substring(0, 30))
              )
              
              if (matchingTopic) {
                console.log('Знайдено topic за частковим зіставленням:', matchingTopic)
                setTopicId(matchingTopic.id)
              } else {
                console.log('Topic не знайдено навіть за частковим зіставленням')
                setTopicId(null)
              }
            } else {
              setTopicId(null)
            }
          }
        } else {
          console.error('Курс не знайдено:', targetCourseTitle)
          setTopicId(null)
        }
      }
    } catch (error) {
      console.error('Помилка отримання topic_id:', error)
      setTopicId(null)
    } finally {
      setLoadingTopic(false)
    }
  }

  async function fetchQuestions() {
    if (!topicId) return

    setLoading(true)
    try {
      const response = await fetch(`/api/questions?topic_id=${topicId}&limit=1000`)
      const data = await response.json()

      if (data.success && data.questions) {
        setQuestions(data.questions)
      }
    } catch (error) {
      console.error('Помилка завантаження питань:', error)
    } finally {
      setLoading(false)
    }
  }

  function handleAnswerSelect(questionId: string, optionId: string) {
    if (showAnswers || testCompleted) return
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: optionId
    }))
    
    // Зберігаємо відповідь в базу даних
    saveAnswerProgress(questionId, optionId)
  }

  async function handleClearAnswers() {
    setSelectedAnswers({})
    if (session?.user?.id) {
      const testType = getTestIdentifier()
      try {
        await fetch(`/api/test-progress?testType=${encodeURIComponent(testType)}`, {
          method: 'DELETE',
        })
      } catch (error) {
        console.error('Помилка видалення прогресу:', error)
      }
    }
  }

  async function handleRestartTest() {
    setTestCompleted(false)
    setTestScore(null)
    setShowAnswers(false)
    setSelectedAnswers({})

    // Видаляємо збережений прогрес з бази даних
    if (session?.user?.id) {
      const testType = getTestIdentifier()
      try {
        await fetch(`/api/test-progress?testType=${encodeURIComponent(testType)}`, {
          method: 'DELETE',
        })
      } catch (error) {
        console.error('Помилка видалення прогресу:', error)
      }
    }
  }

  async function handleCompleteTest() {
    if (!topicId || !session?.user?.id || questions.length === 0) return

    let correctCount = 0
    questions.forEach(question => {
      const selectedOptionId = selectedAnswers[question.id]
      if (selectedOptionId) {
        const selectedOption = question.options.find(opt => opt.id === selectedOptionId)
        if (selectedOption?.is_correct) {
          correctCount++
        }
      }
    })

    const score = Math.round((correctCount / questions.length) * 100)

    setSavingResults(true)
    try {
      const response = await fetch('/api/topics/progress', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          topic_id: topicId,
          score,
          total_questions: questions.length,
          correct_answers: correctCount,
        }),
      })

      const data = await response.json()

      if (!response.ok) {
        console.error('API error response:', data)
        alert(`Помилка збереження результатів: ${data.error || 'Невідома помилка'}\n${data.details || ''}`)
        return
      }

      if (data.success) {
        setTestCompleted(true)
        setTestScore(score)
        setShowAnswers(true)
      } else {
        console.error('API returned success=false:', data)
        alert(`Помилка збереження результатів: ${data.error || 'Невідома помилка'}`)
      }
    } catch (error) {
      console.error('Помилка збереження результатів:', error)
      alert(`Помилка збереження результатів: ${error instanceof Error ? error.message : 'Невідома помилка'}`)
    } finally {
      setSavingResults(false)
    }
  }

  function getAnswerClass(question: Question, optionId: string) {
    if (!showAnswers || !testCompleted) {
      return selectedAnswers[question.id] === optionId
        ? 'border-blue-500 bg-blue-50'
        : 'border-gray-200 hover:border-gray-300'
    }

    const option = question.options.find(opt => opt.id === optionId)
    const isSelected = selectedAnswers[question.id] === optionId
    const isCorrect = option?.is_correct

    if (isCorrect) {
      return 'border-green-500 bg-green-50'
    }
    if (isSelected && !isCorrect) {
      return 'border-red-500 bg-red-50'
    }
    return 'border-gray-200'
  }

  return (
    <>
      <div className="px-[3px] py-8 md:px-6 sm:px-8 md:px-12">
        <div className="mb-8 px-3 md:px-0">
          <h1 className="text-3xl font-bold text-gray-900 mb-0">{section.title}</h1>
          {section.description && (
            <p className="text-lg text-gray-600 font-normal mt-0">{section.description}</p>
          )}
        </div>

        {/* Tabs */}
        <div className="flex gap-2 mb-6 border-b border-blue-200 px-3 md:px-0 overflow-x-auto">
          <button
            onClick={() => setActiveTab('video')}
            className={`px-6 py-3 font-medium transition-colors whitespace-nowrap ${
              activeTab === 'video'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            Відео
          </button>
          <button
            onClick={() => setActiveTab('notes')}
            className={`px-6 py-3 font-medium transition-colors whitespace-nowrap ${
              activeTab === 'notes'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            Конспекти
          </button>
          <button
            onClick={() => setActiveTab('tests')}
            className={`px-6 py-3 font-medium transition-colors whitespace-nowrap ${
              activeTab === 'tests'
                ? 'text-blue-600 border-b-2 border-blue-600'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            Тести
          </button>
        </div>

        {/* Tab Content */}
        <div className="rounded-lg min-h-[400px]">
          {activeTab === 'video' && (
            <div className="px-[3px] md:px-8">
              {section.videos && section.videos.length > 0 ? (
                <div className="space-y-6">
                  {section.videos.map((videoId, index) => {
                    // Перевіряємо, чи це YouTube відео (містить нецифрові символи)
                    const isYouTube = /[^0-9]/.test(videoId)
                    const embedUrl = isYouTube
                      ? `https://www.youtube.com/embed/${videoId}`
                      : `https://player.vimeo.com/video/${videoId}?badge=0&autopause=0&player_id=0&app_id=58479`
                    
                    return (
                      <div key={videoId} className="w-full max-w-3xl">
                        <div className="relative w-full" style={{ paddingBottom: '56.25%' }}>
                          <iframe
                            src={embedUrl}
                            className="absolute top-0 left-0 w-full h-full rounded-lg"
                            frameBorder="0"
                            allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share"
                            referrerPolicy="strict-origin-when-cross-origin"
                            title={`video-${videoId}`}
                            allowFullScreen
                          />
                        </div>
                      </div>
                    )
                  })}
                </div>
              ) : (
                <div className="text-center text-gray-600 py-20">
                  <p className="text-lg mb-2">Відеоматеріали</p>
                  <p className="text-sm">Відеолекції для цього розділу готуються</p>
                </div>
              )}
            </div>
          )}
          {activeTab === 'notes' && (
            <div className="px-[3px] md:px-8">
              {(section.notes && section.notes.length > 0) || (section.presentations && section.presentations.length > 0) ? (
                <div className="space-y-12">
                  {/* Конспекти */}
                  {section.notes && section.notes.map((note) => {
                    const hasError = pdfErrors[note.file]
                    return (
                      <div
                        key={note.file}
                        className="bg-white/70 rounded-2xl shadow-md border border-blue-100 p-3 md:p-6"
                      >
                        {hasError ? (
                          <div className="w-full h-[600px] md:h-[720px] flex items-center justify-center rounded-xl border border-blue-100 bg-white">
                            <div className="text-center text-gray-600 px-6">
                              <p className="text-lg mb-2 font-semibold">{note.title || 'Конспект'}</p>
                              <p className="text-sm">Конспект готується і незабаром буде доступний</p>
                            </div>
                          </div>
                        ) : (
                          <div 
                            className="w-full h-[600px] md:h-[720px] relative rounded-xl border border-blue-100 bg-white overflow-hidden"
                            onContextMenu={(e) => e.preventDefault()}
                            onDragStart={(e) => e.preventDefault()}
                            style={{ userSelect: 'none' }}
                          >
                            <iframe
                              src={`${note.file}#toolbar=0&navpanes=0&scrollbar=1`}
                              className="w-full h-full border-0"
                              style={{ 
                                WebkitOverflowScrolling: 'touch',
                                overflow: 'auto'
                              }}
                              onContextMenu={(e) => e.preventDefault()}
                              title={note.title || 'PDF конспект'}
                              onError={() => {
                                setPdfErrors(prev => ({ ...prev, [note.file]: true }))
                              }}
                              onLoad={(e) => {
                                try {
                                  const iframe = e.target as HTMLIFrameElement
                                  setTimeout(() => {
                                    try {
                                      if (iframe.contentDocument?.location.href.includes('404') || 
                                          iframe.contentWindow?.location.href.includes('404')) {
                                        setPdfErrors(prev => ({ ...prev, [note.file]: true }))
                                      }
                                    } catch (err) {
                                      // CORS помилка
                                    }
                                  }, 2000)
                                } catch (err) {
                                  // Не можемо перевірити через CORS
                                }
                              }}
                            />
                          </div>
                        )}
                      </div>
                    )
                  })}
                  {/* Презентації (відображаються як конспекти) */}
                  {section.presentations && section.presentations.map((presentation) => {
                    const hasError = pdfErrors[presentation.file]
                    return (
                      <div
                        key={presentation.file}
                        className="bg-white/70 rounded-2xl shadow-md border border-blue-100 p-3 md:p-6"
                      >
                        {hasError ? (
                          <div className="w-full h-[600px] md:h-[720px] flex items-center justify-center rounded-xl border border-blue-100 bg-white">
                            <div className="text-center text-gray-600 px-6">
                              <p className="text-lg mb-2 font-semibold">{presentation.title || 'Конспект'}</p>
                              <p className="text-sm">Конспект готується і незабаром буде доступний</p>
                            </div>
                          </div>
                        ) : (
                          <div 
                            className="w-full h-[600px] md:h-[720px] relative rounded-xl border border-blue-100 bg-white overflow-hidden"
                            onContextMenu={(e) => e.preventDefault()}
                            onDragStart={(e) => e.preventDefault()}
                            style={{ userSelect: 'none' }}
                          >
                            <iframe
                              src={`${presentation.file}#toolbar=0&navpanes=0&scrollbar=1`}
                              className="w-full h-full border-0"
                              style={{ 
                                WebkitOverflowScrolling: 'touch',
                                overflow: 'auto'
                              }}
                              onContextMenu={(e) => e.preventDefault()}
                              title={presentation.title || 'PDF конспект'}
                              onError={() => {
                                setPdfErrors(prev => ({ ...prev, [presentation.file]: true }))
                              }}
                              onLoad={(e) => {
                                try {
                                  const iframe = e.target as HTMLIFrameElement
                                  setTimeout(() => {
                                    try {
                                      if (iframe.contentDocument?.location.href.includes('404') || 
                                          iframe.contentWindow?.location.href.includes('404')) {
                                        setPdfErrors(prev => ({ ...prev, [presentation.file]: true }))
                                      }
                                    } catch (err) {
                                      // CORS помилка
                                    }
                                  }, 2000)
                                } catch (err) {
                                  // Не можемо перевірити через CORS
                                }
                              }}
                            />
                          </div>
                        )}
                      </div>
                    )
                  })}
                </div>
              ) : (
                <div className="text-center text-gray-600 py-20">
                  <p className="text-lg mb-2">Конспекти</p>
                  <p className="text-sm">Конспекти для цього розділу готуються</p>
                </div>
              )}
            </div>
          )}
          {activeTab === 'tests' && (
            <div className="px-[3px] md:px-8">
              {/* Вкладки для тестів (тільки для розділу 3) */}
              {section.slug === 'section-3' && (
                <div className="flex gap-2 mb-6 border-b border-blue-200 overflow-x-auto">
                  <button
                    onClick={() => setActiveTestTab('test1')}
                    className={`px-6 py-3 font-medium transition-colors whitespace-nowrap ${
                      activeTestTab === 'test1'
                        ? 'text-blue-600 border-b-2 border-blue-600'
                        : 'text-gray-600 hover:text-gray-900'
                    }`}
                  >
                    Тест 1
                  </button>
                  <button
                    onClick={() => setActiveTestTab('test2')}
                    className={`px-6 py-3 font-medium transition-colors whitespace-nowrap ${
                      activeTestTab === 'test2'
                        ? 'text-blue-600 border-b-2 border-blue-600'
                        : 'text-gray-600 hover:text-gray-900'
                    }`}
                  >
                    Тест 2
                  </button>
                </div>
              )}
              
              {loadingTopic || loading || loadingProgress ? (
                <div className="text-center text-gray-600 py-20">
                  <p className="text-lg mb-2">
                    {loadingProgress ? 'Завантаження збереженого прогресу...' : 'Завантаження тестів...'}
                  </p>
                </div>
              ) : questions.length > 0 ? (
                <div className="space-y-8">
                  {/* Прогрес-бар */}
                  {!testCompleted && Object.keys(selectedAnswers).length > 0 && (
                    <div className="bg-blue-50 rounded-lg p-4 border border-blue-200">
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-sm text-gray-600">
                          Відповіді: {Object.keys(selectedAnswers).length} з {questions.length}
                        </span>
                        <span className="text-sm text-blue-600 font-medium">
                          {Math.round((Object.keys(selectedAnswers).length / questions.length) * 100)}%
                        </span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2">
                        <div 
                          className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                          style={{ width: `${(Object.keys(selectedAnswers).length / questions.length) * 100}%` }}
                        ></div>
                      </div>
                      <div className="flex items-center justify-between mt-2 gap-4">
                        <p className="text-xs text-gray-500">
                          ✓ Ваш прогрес автоматично зберігається
                        </p>
                        <button
                          type="button"
                          onClick={handleClearAnswers}
                          className="text-sm text-gray-600 hover:text-gray-800 underline focus:outline-none focus:ring-2 focus:ring-blue-400 rounded"
                        >
                          Скинути відповіді
                        </button>
                      </div>
                    </div>
                  )}
                  
                  {testCompleted && testScore !== null && (
                    <div className="mb-6">
                      <div className="space-y-2">
                        <p className={`text-lg font-semibold ${
                          testScore >= 80 ? 'text-green-600' : 'text-red-600'
                        }`}>
                          Ваш результат: {testScore}% {testScore >= 80 ? '✓' : '✗'}
                        </p>
                        {testScore < 80 && (
                          <p className="text-sm text-red-600">
                            Для відкриття наступного розділу потрібно набрати 80% і більше
                          </p>
                        )}
                      </div>
                    </div>
                  )}
                  
                  {questions.map((question, index) => (
                    <div
                      key={question.id}
                      className="bg-white/70 rounded-2xl shadow-md border border-blue-100 p-6 space-y-4"
                    >
                      <div className="flex items-start gap-3">
                        <div className="flex-1">
                          <h3 className="text-lg font-semibold text-gray-900 mb-4">
                            {question.question_text}
                          </h3>
                          {question.image_url && (
                            <div className="mb-4 flex-shrink-0 space-y-3" key={`img-wrap-${question.id}`}>
                              {(question.image_url.includes(',') ? question.image_url.split(',').map((u: string) => u.trim()) : [question.image_url])
                                .filter(Boolean)
                                .map((url, idx) => {
                                  const imgKey = `${question.id}-img-${idx}`
                                  const failed = failedImageKeys[imgKey]
                                  return (
                                    <button
                                      key={imgKey}
                                      type="button"
                                      onClick={() => !failed && setImageModalSrc(url)}
                                      className="block text-left focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2 rounded-lg"
                                    >
                                      {failed ? (
                                        <div
                                          className="rounded-lg border border-amber-200 bg-amber-50 text-amber-700 px-4 py-8 text-center text-sm"
                                          style={{ minHeight: '120px' }}
                                        >
                                          Зображення недоступне. Додайте файл у{' '}
                                          <code className="bg-amber-100 px-1 rounded">
                                            {url.startsWith('/') ? 'public' + url.substring(0, url.lastIndexOf('/')) : url.replace(/\/[^/]+$/, '')}/
                                          </code>
                                        </div>
                                      ) : (
                                        <img
                                          src={url}
                                          alt="Зображення до питання (натисніть для збільшення)"
                                          className="max-w-full w-auto h-auto rounded-lg border border-gray-200 object-contain cursor-zoom-in hover:opacity-90 transition-opacity"
                                          style={{ maxHeight: '400px', minHeight: '120px' }}
                                          onError={() => setFailedImageKeys(prev => ({ ...prev, [imgKey]: true }))}
                                        />
                                      )}
                                    </button>
                                  )
                                })}
                            </div>
                          )}
                          <div className="space-y-2">
                            {((question.options) || []).length === 0 ? (
                              <p className="text-amber-700 bg-amber-50 border border-amber-200 rounded-lg p-4">
                                Варіанти відповіді для цього питання відсутні в базі. Додайте їх або переімпортуйте тест з PDF.
                              </p>
                            ) : (
                              ((question.options) || [])
                                .sort((a, b) => (a.order_index ?? 0) - (b.order_index ?? 0))
                                .map((option, index) => {
                                  const optionLetter = String.fromCharCode(65 + index)
                                  return (
                                    <button
                                      key={option.id}
                                      onClick={() => handleAnswerSelect(question.id, option.id)}
                                      className={`w-full p-4 text-left rounded-lg border-2 transition-colors ${getAnswerClass(question, option.id)}`}
                                      disabled={showAnswers || testCompleted}
                                    >
                                      <div className="flex items-center gap-3">
                                        <span className="font-semibold text-gray-700">
                                          {optionLetter}.
                                        </span>
                                        <span className="flex-1">{option.option_text}</span>
                                        {showAnswers && option.is_correct && (
                                          <span className="text-green-600 font-bold">✓</span>
                                        )}
                                        {showAnswers && 
                                         selectedAnswers[question.id] === option.id && 
                                         !option.is_correct && (
                                          <span className="text-red-600 font-bold">✗</span>
                                        )}
                                      </div>
                                    </button>
                                  )
                                })
                            )}
                          </div>
                          
                          {showAnswers && question.explanation && (
                            <div className="mt-4 p-4 bg-blue-50 rounded-lg border border-blue-200">
                              <p className="text-sm text-gray-700">
                                <strong>Пояснення:</strong> {question.explanation}
                              </p>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>
                  ))}
                  
                  {!testCompleted && (
                    <div className="flex justify-center pt-6">
                      <button
                        onClick={handleCompleteTest}
                        disabled={savingResults || Object.keys(selectedAnswers).length === 0}
                        className="px-8 py-4 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors disabled:bg-gray-400 disabled:cursor-not-allowed text-lg font-semibold"
                      >
                        {savingResults ? 'Збереження...' : 'Завершити тест'}
                      </button>
                    </div>
                  )}
                  {testCompleted && (
                    <div className="flex justify-center pt-6">
                      <button
                        onClick={handleRestartTest}
                        className="px-8 py-4 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition-colors text-lg font-semibold"
                      >
                        Пройти тест знову
                      </button>
                    </div>
                  )}
                </div>
              ) : (
                <div className="text-center text-gray-600 py-20">
                  <p className="text-lg mb-2">Тести</p>
                  <p className="text-sm">Тести для цього розділу готуються</p>
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* Модалка збільшення зображення */}
      {imageModalSrc && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 p-4"
          onClick={() => setImageModalSrc(null)}
          onKeyDown={(e) => e.key === 'Escape' && setImageModalSrc(null)}
          role="dialog"
          aria-modal="true"
          aria-label="Збільшене зображення"
        >
          <button
            type="button"
            onClick={() => setImageModalSrc(null)}
            className="absolute top-4 right-4 z-10 w-10 h-10 flex items-center justify-center rounded-full bg-white/90 text-gray-700 hover:bg-white text-xl font-bold shadow-lg"
            aria-label="Закрити"
          >
            ×
          </button>
          <img
            src={imageModalSrc}
            alt="Збільшене зображення"
            className="max-w-[95vw] max-h-[95vh] w-auto h-auto object-contain rounded-lg shadow-2xl"
            onClick={(e) => e.stopPropagation()}
          />
        </div>
      )}
    </>
  )
}

