'use client'

import { useState, useEffect, Suspense } from 'react'
import { useSession } from 'next-auth/react'
import { useSearchParams } from 'next/navigation'
import { Check, X, Brain } from 'lucide-react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import AuthGuard from '@/components/auth/AuthGuard'
import AIExplanation from '@/components/ui/AIExplanation'

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
  const [isTestCompleted, setIsTestCompleted] = useState(false)
  const [showAIExplanation, setShowAIExplanation] = useState(false)
  const [currentQuestionForAI, setCurrentQuestionForAI] = useState<any>(null)

  useEffect(() => {
    fetchQuestions()
  }, [])

  // Автоматично починаємо тест після завантаження питань
  useEffect(() => {
    if (questions.length > 0 && !testStarted) {
      setTestStarted(true)
    }
  }, [questions.length])

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
    setIsTestCompleted(true)
  }

  const resetTest = () => {
    setSelectedAnswers({})
    setAnsweredQuestions(new Set())
    setIsTestCompleted(false)
  }

  const showAIExplanationForQuestion = (question: PharmaceuticalQuestion) => {
    const selectedAnswer = selectedAnswers[question.id]
    const options = question.options?.map(opt => ({
      key: opt.letter,
      text: opt.text
    })) || ['A', 'B', 'C', 'D', 'E'].map(letter => {
      const optionText = question[`option_${letter.toLowerCase()}` as keyof PharmaceuticalQuestion] as string
      return {
        key: letter,
        text: optionText || ''
      }
    }).filter(option => option.text)

    setCurrentQuestionForAI({
      questionText: question.question_text,
      selectedAnswer: selectedAnswer || '',
      correctAnswer: question.correct_answer || 'A',
      options: options
    })
    setShowAIExplanation(true)
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
        return 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200 hover:text-gray-700'
      }
      return 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50 hover:text-gray-700'
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

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження питань Імітація крок...</p>
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

  // Екран результатів після завершення тесту
  if (isTestCompleted) {
    const correctAnswers = getCorrectAnswersCount()
    const totalQuestions = questions.length
    const percentage = Math.round((correctAnswers / totalQuestions) * 100)

    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 p-4">
        <div className="max-w-4xl mx-auto pt-16 md:pt-20">
          <Card className="mb-6">
            <CardHeader className="text-center">
              <CardTitle className="text-3xl font-bold text-blue-800 mb-2">
                Результати Імітація крок
              </CardTitle>
              <div className="text-2xl text-gray-700">
                Правильних відповідей: <span className="font-bold text-green-600">{correctAnswers}</span> з {totalQuestions}
              </div>
              <div className={`text-4xl font-bold mt-2 ${
                percentage >= 80 ? 'text-green-600' : 
                percentage >= 60 ? 'text-yellow-600' : 'text-red-600'
              }`}>
                {percentage}%
              </div>
            </CardHeader>
            <CardContent className="text-center">
              <div className="space-y-4">
                <Button
                  onClick={resetTest}
                  className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 text-lg rounded-xl mr-4"
                >
                  🔄 Пройти ще раз
                </Button>
                <Button
                  onClick={() => window.location.href = '/'}
                  variant="outline"
                  className="px-8 py-3 text-lg rounded-xl"
                >
                  🏠 На головну
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* Детальні результати по кожному питанню */}
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="text-2xl font-bold text-blue-800">
                Детальні результати
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {questions.map((question, index) => {
                  const selectedAnswer = selectedAnswers[question.id]
                  const correctAnswer = question.correct_answer
                  const isCorrect = selectedAnswer === correctAnswer

                  return (
                    <Card 
                      key={question.id} 
                      className={`border-2 ${
                        isCorrect ? 'border-green-300 bg-green-50' : 'border-red-300 bg-red-50'
                      }`}
                    >
                      <CardHeader>
                        <div className="flex items-start justify-between">
                          <CardTitle className="text-lg font-bold text-gray-800 flex-1">
                            <span className={`font-bold mr-3 ${
                              isCorrect ? 'text-green-600' : 'text-red-600'
                            }`}>
                              {index + 1}.
                            </span>
                            {question.question_text}
                          </CardTitle>
                          <div className="ml-4">
                            {isCorrect ? (
                              <div className="flex items-center text-green-600 font-semibold">
                                <Check className="w-6 h-6 mr-1" />
                                <span>Правильно</span>
                              </div>
                            ) : (
                              <div className="flex items-center text-red-600 font-semibold">
                                <X className="w-6 h-6 mr-1" />
                                <span>Неправильно</span>
                              </div>
                            )}
                          </div>
                        </div>
                      </CardHeader>
                      <CardContent className="space-y-2">
                        {question.options ? (
                          question.options.map((opt) => {
                            const isSelected = selectedAnswer === opt.letter
                            const isCorrectOption = opt.letter === correctAnswer

  return (
                              <div
                                key={opt.letter}
                                className={`p-3 rounded-lg border-2 ${
                                  isCorrectOption
                                    ? 'bg-green-100 border-green-500 text-green-800'
                                    : isSelected && !isCorrectOption
                                    ? 'bg-red-100 border-red-500 text-red-800'
                                    : 'bg-gray-50 border-gray-300 text-gray-600'
                                }`}
                              >
                                <div className="flex items-center">
                                  <span className="font-semibold mr-3">{opt.letter}.</span>
                                  <span className="flex-1">{opt.text}</span>
                                  {isCorrectOption && (
                                    <Check className="w-5 h-5 text-green-600 ml-2" />
                                  )}
                                  {isSelected && !isCorrectOption && (
                                    <X className="w-5 h-5 text-red-600 ml-2" />
                                  )}
                                </div>
            </div>
                            )
                          })
                        ) : (
                          ['A', 'B', 'C', 'D', 'E'].filter(option => {
                            const optionText = question[`option_${option.toLowerCase()}` as keyof PharmaceuticalQuestion] as string
                            return optionText && optionText.trim() !== ''
                          }).map((option) => {
                            const optionText = question[`option_${option.toLowerCase()}` as keyof PharmaceuticalQuestion] as string
                            const isSelected = selectedAnswer === option
                            const isCorrectOption = option === correctAnswer

                            return (
                              <div
                                key={option}
                                className={`p-3 rounded-lg border-2 ${
                                  isCorrectOption
                                    ? 'bg-green-100 border-green-500 text-green-800'
                                    : isSelected && !isCorrectOption
                                    ? 'bg-red-100 border-red-500 text-red-800'
                                    : 'bg-gray-50 border-gray-300 text-gray-600'
                                }`}
                              >
                                <div className="flex items-center">
                                  <span className="font-semibold mr-3">{option}.</span>
                                  <span className="flex-1">{optionText}</span>
                                  {isCorrectOption && (
                                    <Check className="w-5 h-5 text-green-600 ml-2" />
                                  )}
                                  {isSelected && !isCorrectOption && (
                                    <X className="w-5 h-5 text-red-600 ml-2" />
                                  )}
            </div>
          </div>
                            )
                          })
                        )}
                        
                        {/* Показуємо яку відповідь обрав користувач */}
                        {selectedAnswer && (
                          <div className="mt-3 p-2 bg-blue-50 border border-blue-200 rounded">
                            <p className="text-sm text-blue-800">
                              <strong>Ваша відповідь:</strong> {selectedAnswer}
                              {!isCorrect && (
                                <span className="ml-2">
                                  <strong>Правильна відповідь:</strong> {correctAnswer}
                                </span>
                              )}
                            </p>
                          </div>
                        )}

                        {/* Кнопка AI Пояснення */}
                        <div className="mt-4">
            <Button
                            variant="outline"
                            size="sm"
                            onClick={() => showAIExplanationForQuestion(question)}
                            className="w-full bg-purple-50 border-purple-300 text-purple-700 hover:bg-purple-100 hover:text-purple-800 hover:border-purple-400"
                          >
                            <Brain className="w-4 h-4 mr-2" />
                            🤖 Отримати AI Пояснення
            </Button>
          </div>
                      </CardContent>
                    </Card>
                  )
                })}
              </div>
            </CardContent>
          </Card>

          {/* AI Пояснення */}
          {showAIExplanation && currentQuestionForAI && (
            <AIExplanation
              questionText={currentQuestionForAI.questionText}
              selectedAnswer={currentQuestionForAI.selectedAnswer}
              correctAnswer={currentQuestionForAI.correctAnswer}
              options={currentQuestionForAI.options}
              onClose={() => {
                setShowAIExplanation(false)
                setCurrentQuestionForAI(null)
              }}
            />
          )}
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      {/* Контент з відступом для закріпленого бару */}
      <div className="p-4 pt-4 pb-24 md:pt-20 md:pb-4">
        <div className="max-w-4xl mx-auto">
        {/* Заголовок */}
        <Card className="mb-6">
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle className="text-2xl font-bold text-blue-800">
                💊 Імітація крок ({questions.length} питань)
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

      {/* AI Пояснення */}
      {showAIExplanation && currentQuestionForAI && (
        <AIExplanation
          questionText={currentQuestionForAI.questionText}
          selectedAnswer={currentQuestionForAI.selectedAnswer}
          correctAnswer={currentQuestionForAI.correctAnswer}
          options={currentQuestionForAI.options}
          onClose={() => {
            setShowAIExplanation(false)
            setCurrentQuestionForAI(null)
          }}
        />
      )}

      {/* Прогрес-бар і кнопка завершення */}
      <div className="test-progress-bar fixed bottom-0 left-0 right-0 md:fixed md:top-0 md:left-64 md:right-0 md:w-auto md:h-[50px] bg-white md:bg-blue-50 md:backdrop-blur-sm border-t md:border-b border-gray-200 md:border-gray-200 shadow-lg md:shadow-sm p-3 md:px-6 md:py-2 md:pb-3 z-[200] relative">
        <div className="text-center md:flex md:items-center md:justify-between md:max-w-4xl md:mx-auto md:w-full">
          <div className="mb-4 md:mb-0 md:flex md:items-center md:space-x-4">
            <p className="text-gray-600 mb-2 md:mb-0 text-sm">
              Відповідей: {answeredCount} з {questions.length}
            </p>
            <p className="text-gray-500 text-xs mb-2 md:mb-0">
              Прогрес: {progressPercentage}%
            </p>
            <div className="w-full sm:w-48 md:w-64 lg:w-80 xl:w-96 progress-bar">
              <div 
                className="progress-fill"
                style={{ width: `${progressPercentage}%` }}
              ></div>
            </div>
          </div>
          
          <Button
            onClick={finishTest}
            className="bg-blue-600 hover:bg-blue-700 text-base md:text-base px-8 md:px-6 py-3 md:py-2 w-full md:w-auto rounded-xl"
          >
            🏁 Завершити тест
          </Button>
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
