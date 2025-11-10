'use client'

import { useState, useEffect, Suspense } from 'react'
import { useSession } from 'next-auth/react'
import { useSearchParams } from 'next/navigation'
import { Check, X } from 'lucide-react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import AuthGuard from '@/components/auth/AuthGuard'

interface PharmaceuticalQuestion {
  id: number
  question_number: number
  system?: string
  question_text: string
  option_a?: string
  option_b?: string
  option_c?: string
  option_d?: string
  option_e?: string
  correct_answer: string
  topic?: string
  recommendation?: string
  faculty: string
  options?: Array<{
    letter: string
    text: string
    is_correct?: boolean
  }>
}

function PharmaceuticalRandomizerContent() {
  const { data: session } = useSession()
  const searchParams = useSearchParams()
  const [questions, setQuestions] = useState<PharmaceuticalQuestion[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string>>({})
  const [testStarted, setTestStarted] = useState(false)
  const [showAnswers, setShowAnswers] = useState(searchParams.get('showAnswers') === 'true')
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set())
  const [totalQuestionsInDatabase, setTotalQuestionsInDatabase] = useState(0)
  const [remainingAttempts, setRemainingAttempts] = useState<number | null>(null)
  const [isCheckingAttempts, setIsCheckingAttempts] = useState(true)
  const [attemptUsed, setAttemptUsed] = useState(false)

  useEffect(() => {
    checkAttempts()
  }, [])

  const checkAttempts = async () => {
    setIsCheckingAttempts(true)
    try {
      const response = await fetch('/api/randomizer/attempts')
      if (response.ok) {
        const data = await response.json()
        setRemainingAttempts(data.remainingAttempts)
        
        if (data.remainingAttempts <= 0) {
          // Немає спроб - перенаправляємо на сторінку покупки
          window.location.href = '/randomizer/buy'
          return
        }
      }
    } catch (error) {
      console.error('Error checking attempts:', error)
    } finally {
      setIsCheckingAttempts(false)
    }
  }

  const consumeAttempt = async () => {
    try {
      const response = await fetch('/api/randomizer/attempts', {
        method: 'POST'
      })
      
      if (response.ok) {
        const data = await response.json()
        setRemainingAttempts(data.remainingAttempts)
        setAttemptUsed(true)
        console.log(`Спробу використано. Залишилось: ${data.remainingAttempts}`)
      } else {
        console.error('Помилка при використанні спроби')
      }
    } catch (error) {
      console.error('Error using attempt:', error)
    }
  }

  useEffect(() => {
    if (!isCheckingAttempts && remainingAttempts !== null && remainingAttempts > 0) {
      fetchQuestions()
    }
  }, [isCheckingAttempts, remainingAttempts])

  // Автоматично починаємо тест після завантаження питань
  useEffect(() => {
    if (questions.length > 0 && !testStarted && remainingAttempts && remainingAttempts > 0) {
      setTestStarted(true)
      
      // Списуємо спробу при старті тесту
      if (!attemptUsed) {
        consumeAttempt()
      }
    }
  }, [questions.length, testStarted, remainingAttempts, attemptUsed])

  const fetchQuestions = async () => {
    try {
      const response = await fetch('/api/pharmaceutical/questions?limit=150&random=true')
      const data = await response.json()
      
      console.log('Фармація - отримано відповідь:', data)
      
      if (data.error) {
        setError(data.error)
      } else {
        const questions = data.questions || []
        console.log(`Фармація - отримано ${questions.length} питань`)
        
        // Зберігаємо загальну кількість питань в базі
        if (data.total) {
          setTotalQuestionsInDatabase(data.total)
        }
        
        const validQuestions = questions.filter((q: any) => {
          const hasOptions = q.options && q.options.length > 0
          const hasOptionsFields = q.option_a || q.option_b || q.option_c || q.option_d
          return hasOptions || hasOptionsFields
        })
        
        const formattedQuestions = validQuestions.map((q: any) => ({
          id: q.id,
          question_number: q.id,
          system: q.subject || '',
          question_text: q.question_text,
          option_a: q.option_a || '',
          option_b: q.option_b || '',
          option_c: q.option_c || '',
          option_d: q.option_d || '',
          option_e: q.option_e || '',
          correct_answer: q.correct_answer,
          topic: q.category || '',
          recommendation: q.explanation || '',
          faculty: q.faculty || 'pharmaceutical',
          options: q.options || [
            { letter: 'A', text: q.option_a || '', is_correct: q.correct_answer === 'A' },
            { letter: 'B', text: q.option_b || '', is_correct: q.correct_answer === 'B' },
            { letter: 'C', text: q.option_c || '', is_correct: q.correct_answer === 'C' },
            { letter: 'D', text: q.option_d || '', is_correct: q.correct_answer === 'D' },
            { letter: 'E', text: q.option_e || '', is_correct: q.correct_answer === 'E' }
          ].filter((opt: any) => opt.text && opt.text.trim() !== '')
        }))
        
        console.log(`Завантажено ${formattedQuestions.length} валідних фармацевтичних питань`)
        setQuestions(formattedQuestions)
        
        if (formattedQuestions.length === 0) {
          setError('Не знайдено питань для фармації. Перевірте налаштування бази даних.')
        }
      }
    } catch (err) {
      console.error('Помилка завантаження питань:', err)
      setError('Помилка завантаження питань')
    } finally {
      setLoading(false)
    }
  }

  const handleAnswerSelect = (questionId: number, answer: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }))

    if (showAnswers) {
      setAnsweredQuestions(prev => new Set([...prev, questionId]))
    }
  }

  const finishTest = () => {
    const correctAnswers = getCorrectAnswersCount()
    const totalQuestions = questions.length
    alert(`Тест завершено!\nПравильних відповідей: ${correctAnswers} з ${totalQuestions}\nОцінка: ${Math.round((correctAnswers / totalQuestions) * 100)}%`)
  }

  const getCorrectAnswersCount = () => {
    let correct = 0
    questions.forEach(question => {
      if (selectedAnswers[question.id] === question.correct_answer) {
        correct++
      }
    })
    return correct
  }

  const getAnswerButtonClass = (answerKey: string, question: PharmaceuticalQuestion, selectedAnswer: string | undefined) => {
    const isSelected = selectedAnswer === answerKey
    const isAnswered = answeredQuestions.has(question.id)
    
    if (!isAnswered) {
      if (isSelected) {
        return 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200'
      }
      return 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50'
    }
    
    const isCorrectAnswer = question.correct_answer === answerKey
    if (isCorrectAnswer) {
      return 'bg-green-100 border-green-500 text-green-700'
    } else if (isSelected && !isCorrectAnswer) {
      return 'bg-red-100 border-red-500 text-red-700'
    } else {
      return 'bg-gray-50 border-gray-300 text-gray-500'
    }
  }

  if (isCheckingAttempts || loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">
            {isCheckingAttempts ? 'Перевірка спроб...' : 'Завантаження питань Randomizer PRO...'}
          </p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-red-600 mb-4">Помилка</h2>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    )
  }

  if (questions.length === 0) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-red-600 mb-4">Немає питань</h2>
          <p className="text-gray-600">Не знайдено питань для тесту</p>
        </div>
      </div>
    )
  }

  const answeredCount = Object.keys(selectedAnswers).length
  const progressPercentage = Math.round((answeredCount / questions.length) * 100)

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      {/* Закріплений прогрес-бар зверху */}
      <div className="fixed top-0 left-0 md:left-64 right-0 bg-white border-b border-gray-200 z-50 px-4 py-3">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          {/* Зліва: Прогрес */}
          <div className="flex items-center space-x-4 flex-1">
            <div className="text-sm text-gray-700 whitespace-nowrap">
              Відповідей: {answeredCount} з {questions.length} Прогрес: {progressPercentage}%
            </div>
            <div className="w-full max-w-md bg-gray-200 rounded-full h-2">
              <div
                className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                style={{ width: `${progressPercentage}%` }}
              ></div>
            </div>
          </div>
          
          {/* Справа: Кнопка завершення */}
          <div className="ml-4">
            <Button
              onClick={finishTest}
              className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2"
            >
              ✨ Завершити тест
            </Button>
          </div>
        </div>
      </div>

      {/* Контент з відступом для закріпленого бару */}
      <div className="p-4 pt-20">
        <div className="max-w-4xl mx-auto">
        {/* Заголовок */}
        <Card className="mb-6">
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle className="text-2xl font-bold text-blue-800">
                💊 Randomizer PRO ({questions.length} питань)
                <span className="text-sm font-normal text-gray-600 ml-2">
                  з бази {totalQuestionsInDatabase || questions.length} питань
                </span>
              </CardTitle>
              <div className="flex items-center space-x-3">
                {questions.length > 0 && (
                  <div className="text-sm text-gray-600 bg-blue-50 px-3 py-1 rounded-full">
                    Питання 1-{questions.length}
                  </div>
                )}
                {Object.keys(selectedAnswers).length > 0 && (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => {
                      setSelectedAnswers({})
                      setAnsweredQuestions(new Set())
                    }}
                    className="text-red-600 border-red-300 hover:bg-red-50"
                  >
                    🗑️ Видалити відповіді
                  </Button>
                )}
              </div>
            </div>
          </CardHeader>
        </Card>

        {/* Всі питання */}
        <div className="space-y-6">
          {questions.map((question, index) => {
            const selectedAnswer = selectedAnswers[question.id]
            const isAnswered = answeredQuestions.has(question.id)
            
            return (
              <Card key={question.id} className="mb-6">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-gray-800 flex-1">
                    <span className="text-blue-600 font-bold mr-3">{index + 1}.</span>
                    {question.question_text}
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  {question.options ? (
                    question.options.map((opt) => {
                      const isSelected = selectedAnswer === opt.letter
                      const isCorrectAnswer = opt.letter === question.correct_answer
                      
                      return (
                        <Button
                          key={opt.letter}
                          variant="outline"
                          className={`w-full justify-start text-left p-4 h-auto ${getAnswerButtonClass(opt.letter, question, selectedAnswer)}`}
                          onClick={() => handleAnswerSelect(question.id, opt.letter)}
                          disabled={showAnswers && isAnswered}
                        >
                          <div className="flex items-center w-full">
                            <span className="font-semibold mr-3">{opt.letter}.</span>
                            <span className="flex-1">{opt.text}</span>
                            {isAnswered && isCorrectAnswer && (
                              <Check className="w-5 h-5 text-green-600 ml-2" />
                            )}
                            {isAnswered && isSelected && !isCorrectAnswer && (
                              <X className="w-5 h-5 text-red-600 ml-2" />
                            )}
                          </div>
                        </Button>
                      )
                    })
                  ) : (
                    ['A', 'B', 'C', 'D'].filter(option => question[`option_${option.toLowerCase()}` as keyof PharmaceuticalQuestion]).map((option) => {
                      const optionText = question[`option_${option.toLowerCase()}` as keyof PharmaceuticalQuestion] as string
                      const isSelected = selectedAnswer === option
                      const isCorrectAnswer = option === question.correct_answer
                      
                      return (
                        <Button
                          key={option}
                          variant="outline"
                          className={`w-full justify-start text-left p-4 h-auto ${getAnswerButtonClass(option, question, selectedAnswer)}`}
                          onClick={() => handleAnswerSelect(question.id, option)}
                          disabled={showAnswers && isAnswered}
                        >
                          <div className="flex items-center w-full">
                            <span className="font-semibold mr-3">{option}.</span>
                            <span className="flex-1">{optionText}</span>
                            {isAnswered && isCorrectAnswer && (
                              <Check className="w-5 h-5 text-green-600 ml-2" />
                            )}
                            {isAnswered && isSelected && !isCorrectAnswer && (
                              <X className="w-5 h-5 text-red-600 ml-2" />
                            )}
                          </div>
                        </Button>
                      )
                    })
                  )}
                </CardContent>
              </Card>
            )
          })}
        </div>
        </div>
      </div>
    </div>
  )
}

export default function PharmaceuticalRandomizer() {
  return (
    <AuthGuard>
      <Suspense fallback={
        <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
          <div className="text-center">
            <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-xl text-gray-600">Завантаження...</p>
          </div>
        </div>
      }>
        <PharmaceuticalRandomizerContent />
      </Suspense>
    </AuthGuard>
  )
}
