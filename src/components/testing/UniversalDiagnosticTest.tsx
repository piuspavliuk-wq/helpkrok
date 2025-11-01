'use client'

import { useState, useEffect, useCallback } from 'react'
import { useSession } from 'next-auth/react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'

interface DiagnosticQuestion {
  id: number
  question_number: number
  system: string
  question_text: string
  situation?: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: string
  topic: string
  recommendation: string
  faculty?: string
}

interface UniversalDiagnosticTestProps {
  testType: 'medical' | 'pharmaceutical'
  testName: string
  limit?: number
}

export default function UniversalDiagnosticTest({ 
  testType, 
  testName, 
  limit = 10 
}: UniversalDiagnosticTestProps) {
  const { data: session } = useSession()
  const [questions, setQuestions] = useState<DiagnosticQuestion[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string>>({})
  const [showResults, setShowResults] = useState(false)
  const [testStarted, setTestStarted] = useState(false)

  useEffect(() => {
    // Додаємо невелику затримку для того, щоб сервер встиг запуститися
    const timer = setTimeout(() => {
      fetchQuestions()
    }, 100)
    
    return () => clearTimeout(timer)
  }, [testType, limit])

  const fetchQuestions = async () => {
    try {
      console.log('Fetching questions for:', testType, 'limit:', limit)
      
      // Додаємо retry логіку
      let retries = 3
      let response
      
      while (retries > 0) {
        try {
          const url =
            testType === 'pharmaceutical'
              ? `/api/pharmacy-knowledge/questions?limit=${limit}`
              : `/api/physiology/questions?limit=${limit}&faculty=${testType}`
          response = await fetch(url)
          if (response.ok) break
        } catch (err) {
          console.log('Retry attempt failed:', err)
        }
        retries--
        if (retries > 0) {
          await new Promise(resolve => setTimeout(resolve, 1000))
        }
      }
      
      if (!response || !response.ok) {
        throw new Error(`HTTP ${response?.status || 'No response'}`)
      }
      
      console.log('Response status:', response.status)
      
      const data = await response.json()
      console.log('API data:', data)
      
      if (data.error) {
        console.error('API error:', data.error)
        setError(data.error)
      } else {
        console.log('Questions loaded:', data.questions?.length || 0)
        setQuestions(data.questions || [])
      }
    } catch (err) {
      console.error('Fetch error:', err)
      setError('Помилка завантаження питань: ' + (err as any).message)
    } finally {
      setLoading(false)
    }
  }

  const startTest = useCallback(() => {
    setTestStarted(true)
    setSelectedAnswers({})
    setShowResults(false)
  }, [])

  // Автоматично починаємо тест після завантаження питань
  useEffect(() => {
    if (questions.length > 0 && !testStarted) {
      startTest()
    }
  }, [questions, testStarted, startTest])

  const handleAnswerSelect = (questionId: number, answer: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }))
  }

  // Функції навігації більше не потрібні, оскільки всі питання показуються одразу

  const calculateScore = () => {
    let correct = 0
    questions.forEach(question => {
      if (selectedAnswers[question.id] === question.correct_answer) {
        correct++
      }
    })
    return Math.round((correct / questions.length) * 100)
  }

  const getScoreColor = (score: number) => {
    if (score >= 80) return 'text-green-600'
    if (score >= 60) return 'text-yellow-600'
    return 'text-red-600'
  }

  // Таймер більше не потрібен, оскільки всі питання показуються одразу

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Завантаження питань...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-red-600 mb-4">Помилка</h2>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    )
  }

  if (showResults) {
    const score = calculateScore()
    const correctAnswers = questions.filter(q => selectedAnswers[q.id] === q.correct_answer).length
    
    return (
      <div className="min-h-screen bg-blue-50 py-12">
        <div className="max-w-6xl mx-auto px-4">
          <Card className="w-full max-w-6xl mx-auto">
            <CardHeader>
              <CardTitle className="text-2xl text-center">
                🎯 Результати тесту
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="text-center">
                <div className={`text-4xl font-bold mb-4 ${getScoreColor(score)}`}>
                  {score}%
                </div>
                <p className="text-gray-600 mb-6">
                  Правильних відповідей: {correctAnswers} з {questions.length}
                </p>
                
                <div className="space-y-6">
                  {questions.map((question, index) => {
                    const userAnswer = selectedAnswers[question.id]
                    const isCorrect = userAnswer === question.correct_answer
                    
                    return (
                      <div key={question.id} className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
                        <div className="flex items-center justify-between mb-3">
                          <span className="font-semibold text-lg text-left">Питання {index + 1}</span>
                          <span className={`text-sm font-medium px-3 py-1 rounded-full ${
                            isCorrect ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                          }`}>
                            {isCorrect ? '✓ Правильно' : '✗ Неправильно'}
                          </span>
                        </div>
                        
                        <p className="text-lg text-gray-900 mb-4 leading-relaxed text-left">{question.question_text}</p>
                        
                        <div className="space-y-3">
                          {['A', 'B', 'C', 'D'].map((option) => {
                            const optionText = question[`option_${option.toLowerCase()}` as keyof DiagnosticQuestion] as string
                            const isUserAnswer = userAnswer === option
                            const isCorrectAnswer = question.correct_answer === option
                            
                            return (
                              <div
                                key={option}
                                className={`p-4 rounded-lg border ${
                                  isCorrectAnswer
                                    ? 'bg-green-50 border-green-300'
                                    : isUserAnswer
                                    ? 'bg-red-50 border-red-300'
                                    : 'bg-gray-50 border-gray-200'
                                }`}
                              >
                                <div className="flex items-center">
                                  <span className="font-medium text-gray-700 mr-3 text-lg">{option}.</span>
                                  <span className="text-gray-900 text-lg text-left flex-1">{optionText}</span>
                                  {isCorrectAnswer && (
                                    <span className="ml-auto text-green-600 font-medium">(Правильна відповідь)</span>
                                  )}
                                  {isUserAnswer && !isCorrectAnswer && (
                                    <span className="ml-auto text-red-600 font-medium">(Ваша відповідь)</span>
                                  )}
                                </div>
                              </div>
                            )
                          })}
                        </div>
                        
                        {question.recommendation && (
                          <div className="mt-4 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                            <div className="flex items-start">
                              <span className="text-blue-600 mr-2">💡</span>
                              <p className="text-blue-800 text-sm text-left">{question.recommendation}</p>
                            </div>
                          </div>
                        )}
                      </div>
                    )
                  })}
                </div>
                
                <div className="mt-8 flex gap-4 justify-center">
                  <Button
                    onClick={() => {
                      setTestStarted(false)
                      setShowResults(false)
                      setSelectedAnswers({})
                    }}
                    className={`${
                      testType === 'medical'
                        ? 'bg-blue-600 hover:bg-blue-700'
                        : 'bg-purple-600 hover:bg-purple-700'
                    }`}
                  >
                    Пройти знову
                  </Button>
                  <Button
                    onClick={() => window.location.href = '/'}
                    variant="outline"
                  >
                    На головну
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  const answeredCount = Object.keys(selectedAnswers).length

  return (
    <div className="w-full">
      {/* Прогрес-бар і кнопка завершення - закріплені знизу на мобільних, зверху на ПК */}
      <div className="test-progress-bar fixed bottom-0 left-0 right-0 md:fixed md:top-0 md:left-64 md:right-0 md:w-auto md:h-[50px] bg-white md:bg-blue-50 md:backdrop-blur-sm border-t md:border-b border-gray-200 md:border-gray-200 shadow-lg md:shadow-sm p-3 md:px-6 md:py-2 md:pb-3 z-[200] relative">
            <div className="text-center md:flex md:items-center md:justify-between md:max-w-6xl md:mx-auto md:w-full">
          <div className="mb-4 md:mb-0 md:flex md:items-center md:space-x-4">
            <p className="text-gray-600 mb-2 md:mb-0 text-sm">
              Відповідей: {answeredCount} з {questions.length}
            </p>
            <p className="text-gray-500 text-xs mb-2 md:mb-0">
              Прогрес: {Math.round((answeredCount / questions.length) * 100)}%
            </p>
            <div className="w-full sm:w-48 md:w-64 lg:w-80 xl:w-96 progress-bar">
              <div 
                className="progress-fill"
                style={{ width: `${(answeredCount / questions.length) * 100}%` }}
              ></div>
            </div>
          </div>
          
          <button
            onClick={() => setShowResults(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white text-base md:text-base px-8 md:px-6 py-3 md:py-2 w-full md:w-auto rounded-xl"
          >
            🏁 Завершити тест
          </button>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-6xl mx-auto px-6 py-8 pb-20 md:pb-8 relative z-10">

        {/* All Questions */}
        <div className="space-y-6">
          {questions.map((question, index) => {
            const selectedAnswer = selectedAnswers[question.id]
            const isNewSystem = index === 0 || questions[index - 1].system !== question.system
            
            return (
              <div key={question.id}>
                {/* Заголовок системи */}
                {isNewSystem && (
                  <div className="mb-6 mt-8 first:mt-0">
                    <h2 className="text-2xl font-bold text-gray-800 bg-blue-50 px-6 py-4 rounded-lg border-l-4 border-blue-500">
                      {question.system}
                    </h2>
                  </div>
                )}
                
                <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                <div className="mb-4">
                  <div className="flex items-center gap-2 mb-3">
                    <span className="text-blue-600 font-semibold text-lg">
                      {index + 1}.
                    </span>
                  </div>
                  {
                    testType === 'pharmaceutical' && (question as any).situation && (
                      <div className="text-gray-500 mb-2 italic text-base">{(question as any).situation}</div>
                    )
                  }
                  <h2 className="text-xl font-medium text-gray-900 leading-relaxed mb-4">
                    {question.question_text}
                  </h2>
                </div>

                {/* Answer Options */}
                <div className="space-y-3">
                  {['A', 'B', 'C', 'D'].map((option) => {
                    const optionText = question[`option_${option.toLowerCase()}` as keyof DiagnosticQuestion] as string
                    return (
                      <label
                        key={option}
                        className={`block p-4 rounded-lg border cursor-pointer transition-all duration-200 ${
                          selectedAnswer === option
                            ? 'bg-blue-50 border-blue-300 shadow-sm'
                            : 'bg-gray-50 border-gray-200 hover:bg-gray-100 hover:border-gray-300'
                        }`}
                      >
                        <input
                          type="radio"
                          name={`question-${question.id}`}
                          value={option}
                          checked={selectedAnswer === option}
                          onChange={() => handleAnswerSelect(question.id, option)}
                          className="sr-only"
                        />
                        <div className="flex items-center">
                          <span className="font-medium text-gray-700 mr-3 text-lg">{option}.</span>
                          <span className="text-gray-900 text-lg">{optionText}</span>
                        </div>
                      </label>
                    )
                  })}
                </div>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
