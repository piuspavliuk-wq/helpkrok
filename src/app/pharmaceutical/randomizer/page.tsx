'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'

interface PharmaceuticalQuestion {
  id: number
  question_number: number
  system: string
  question_text: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: string
  topic: string
  recommendation: string
  faculty: string
}

export default function PharmaceuticalRandomizer() {
  const { data: session } = useSession()
  const [questions, setQuestions] = useState<PharmaceuticalQuestion[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string>>({})
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0)
  const [showResults, setShowResults] = useState(false)
  const [testStarted, setTestStarted] = useState(false)

  useEffect(() => {
    fetchQuestions()
  }, [])

  const fetchQuestions = async () => {
    try {
      // Поки що використовуємо ті ж питання фізіології, але з faculty=pharmaceutical
      const response = await fetch('/api/physiology/questions?limit=10&faculty=pharmaceutical')
      const data = await response.json()
      
      if (data.error) {
        setError(data.error)
      } else {
        setQuestions(data.questions)
      }
    } catch (err) {
      setError('Помилка завантаження питань')
    } finally {
      setLoading(false)
    }
  }

  const startTest = () => {
    setTestStarted(true)
    setCurrentQuestionIndex(0)
    setSelectedAnswers({})
    setShowResults(false)
  }

  const handleAnswerSelect = (questionId: number, answer: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }))
  }

  const nextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1)
    } else {
      setShowResults(true)
    }
  }

  const previousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1)
    }
  }

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

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-purple-600 mx-auto"></div>
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

  if (!testStarted) {
    return (
      <div className="min-h-screen bg-gray-50 py-12">
        <div className="max-w-4xl mx-auto px-4">
          <Card className="w-full max-w-2xl mx-auto">
            <CardHeader>
              <CardTitle className="text-2xl text-center">
                💊 Тест з фармації
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="text-center">
                <p className="text-gray-600 mb-4">
                  Пройдіть тест з 10 випадкових питань з фармації та перевірте свої знання!
                </p>
                
                <div className="bg-purple-50 border border-purple-200 rounded-lg p-4 mb-6">
                  <h3 className="font-semibold text-purple-800 mb-2">📊 Доступно питань: {questions.length}</h3>
                  <p className="text-sm text-purple-600">
                    Система випадково вибере 10 питань з питань фармації
                  </p>
                  {session?.user?.id && (
                    <p className="text-sm text-purple-600 mt-2">
                      💾 Ви можете зберігати питання для подальшого повторення під час проходження тесту
                    </p>
                  )}
                </div>

                <Button
                  onClick={startTest}
                  disabled={questions.length < 10}
                  className="bg-purple-600 hover:bg-purple-700 text-lg px-8 py-3"
                >
                  Почати тест
                </Button>
                
                {questions.length < 10 && (
                  <p className="text-red-600 text-sm mt-2">
                    Недостатньо питань для тесту. Потрібно мінімум 10 питань.
                  </p>
                )}
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  if (showResults) {
    const score = calculateScore()
    const correctAnswers = questions.filter(q => selectedAnswers[q.id] === q.correct_answer).length
    
    return (
      <div className="min-h-screen bg-gray-50 py-12">
        <div className="max-w-4xl mx-auto px-4">
          <Card className="w-full max-w-2xl mx-auto">
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
                
                <div className="space-y-4">
                  {questions.map((question, index) => {
                    const userAnswer = selectedAnswers[question.id]
                    const isCorrect = userAnswer === question.correct_answer
                    
                    return (
                      <div key={question.id} className={`p-4 rounded-lg border ${
                        isCorrect ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'
                      }`}>
                        <div className="flex items-center justify-between mb-2">
                          <span className="font-medium">Питання {index + 1}</span>
                          <span className={`text-sm font-medium ${
                            isCorrect ? 'text-green-600' : 'text-red-600'
                          }`}>
                            {isCorrect ? '✓ Правильно' : '✗ Неправильно'}
                          </span>
                        </div>
                        <p className="text-sm text-gray-700 mb-2">{question.question_text}</p>
                        <div className="text-xs text-gray-500">
                          <p>Ваша відповідь: {userAnswer || 'Не відповіли'}</p>
                          <p>Правильна відповідь: {question.correct_answer}</p>
                          {question.recommendation && (
                            <p className="mt-1 text-blue-600">💡 {question.recommendation}</p>
                          )}
                        </div>
                      </div>
                    )
                  })}
                </div>
                
                <div className="mt-6 flex gap-4 justify-center">
                  <Button
                    onClick={() => {
                      setTestStarted(false)
                      setShowResults(false)
                      setSelectedAnswers({})
                    }}
                    className="bg-purple-600 hover:bg-purple-700"
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

  const currentQuestion = questions[currentQuestionIndex]
  const selectedAnswer = selectedAnswers[currentQuestion.id]

  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-4xl mx-auto px-4">
        <Card className="w-full max-w-2xl mx-auto">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle className="text-xl">
                Питання {currentQuestionIndex + 1} з {questions.length}
              </CardTitle>
              <div className="text-sm text-gray-500">
                {currentQuestion.system}
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div>
              <h3 className="text-lg font-medium mb-4">{currentQuestion.question_text}</h3>
              
              <div className="space-y-3">
                {['A', 'B', 'C', 'D'].map((option) => {
                  const optionText = currentQuestion[`option_${option.toLowerCase()}` as keyof PharmaceuticalQuestion] as string
                  return (
                    <label
                      key={option}
                      className={`block p-4 rounded-lg border cursor-pointer transition-colors ${
                        selectedAnswer === option
                          ? 'bg-purple-50 border-purple-300'
                          : 'bg-white border-gray-200 hover:bg-gray-50'
                      }`}
                    >
                      <input
                        type="radio"
                        name={`question-${currentQuestion.id}`}
                        value={option}
                        checked={selectedAnswer === option}
                        onChange={() => handleAnswerSelect(currentQuestion.id, option)}
                        className="sr-only"
                      />
                      <div className="flex items-center">
                        <span className="font-medium mr-3">{option}.</span>
                        <span>{optionText}</span>
                      </div>
                    </label>
                  )
                })}
              </div>
            </div>
            
            <div className="flex justify-between">
              <Button
                onClick={previousQuestion}
                disabled={currentQuestionIndex === 0}
                variant="outline"
              >
                Попереднє
              </Button>
              
              <Button
                onClick={nextQuestion}
                disabled={!selectedAnswer}
                className="bg-purple-600 hover:bg-purple-700"
              >
                {currentQuestionIndex === questions.length - 1 ? 'Завершити' : 'Наступне'}
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
