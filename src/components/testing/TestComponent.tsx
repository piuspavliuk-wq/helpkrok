'use client'

import { useState, useEffect } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { 
  CheckCircle, 
  XCircle, 
  Clock, 
  RotateCcw,
  ArrowRight,
  ArrowLeft,
  AlertCircle
} from 'lucide-react'

interface Question {
  id: string
  question_text: string
  explanation?: string
  difficulty: 'easy' | 'medium' | 'hard'
  options: QuestionOption[]
}

interface QuestionOption {
  id: string
  option_text: string
  is_correct: boolean
}

interface TestResult {
  score: number
  total_questions: number
  correct_answers: number
  time_spent: number
  passed: boolean
  answers: TestAnswer[]
}

interface TestAnswer {
  question_id: string
  selected_option_id: string
  time_spent: number
}

interface TestComponentProps {
  topicId: string
  userId: string
  onTestComplete: (result: TestResult) => void
  onTestExit: () => void
}

export function TestComponent({ topicId, userId, onTestComplete, onTestExit }: TestComponentProps) {
  const [questions, setQuestions] = useState<Question[]>([])
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0)
  const [selectedAnswers, setSelectedAnswers] = useState<Record<string, string>>({})
  const [questionStartTime, setQuestionStartTime] = useState(Date.now())
  const [testStartTime] = useState(Date.now())
  const [isLoading, setIsLoading] = useState(true)
  const [showResults, setShowResults] = useState(false)
  const [testResult, setTestResult] = useState<TestResult | null>(null)
  const [timeRemaining, setTimeRemaining] = useState(0)

  useEffect(() => {
    fetchQuestions()
  }, [topicId])

  useEffect(() => {
    if (questions.length > 0) {
      setQuestionStartTime(Date.now())
    }
  }, [currentQuestionIndex, questions.length])

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeRemaining(prev => prev - 1)
    }, 1000)

    return () => clearInterval(timer)
  }, [])

  const fetchQuestions = async () => {
    try {
      setIsLoading(true)
      const response = await fetch(`/api/questions?topic_id=${topicId}`)
      if (response.ok) {
        const data = await response.json()
        setQuestions(data.questions)
        setTimeRemaining(data.questions.length * 60) // 1 хвилина на питання
      }
    } catch (error) {
      console.error('Error fetching questions:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const handleAnswerSelect = (optionId: string) => {
    const currentQuestion = questions[currentQuestionIndex]
    if (!currentQuestion) return

    setSelectedAnswers(prev => ({
      ...prev,
      [currentQuestion.id]: optionId
    }))
  }

  const handleNextQuestion = () => {
    const currentQuestion = questions[currentQuestionIndex]
    if (!currentQuestion) return

    // Зберігаємо час, витрачений на поточне питання
    const timeSpent = Math.floor((Date.now() - questionStartTime) / 1000)
    
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1)
    } else {
      // Останнє питання - завершуємо тест
      finishTest()
    }
  }

  const handlePreviousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1)
    }
  }

  const finishTest = () => {
    const totalTimeSpent = Math.floor((Date.now() - testStartTime) / 1000)
    let correctAnswers = 0
    const answers: TestAnswer[] = []

    questions.forEach(question => {
      const selectedOptionId = selectedAnswers[question.id]
      if (selectedOptionId) {
        const selectedOption = question.options.find(opt => opt.id === selectedOptionId)
        if (selectedOption?.is_correct) {
          correctAnswers++
        }
        
        answers.push({
          question_id: question.id,
          selected_option_id: selectedOptionId,
          time_spent: 60 // Mock time per question
        })
      }
    })

    const score = Math.round((correctAnswers / questions.length) * 100)
    const passed = score >= 80 // Правило 80%

    const result: TestResult = {
      score,
      total_questions: questions.length,
      correct_answers: correctAnswers,
      time_spent: totalTimeSpent,
      passed,
      answers
    }

    setTestResult(result)
    setShowResults(true)
    
    // Зберігаємо результат тесту
    saveTestResult(result)
  }

  const saveTestResult = async (result: TestResult) => {
    try {
      await fetch('/api/tests/attempts', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          topic_id: topicId,
          attempt_type: 'topic_test',
          total_questions: result.total_questions,
          correct_answers: result.correct_answers,
          score: result.score,
          time_spent: result.time_spent,
          completed_at: new Date().toISOString(),
        }),
      })

      // Оновлюємо прогрес користувача
      await fetch('/api/user/progress', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          topic_id: topicId,
          test_completed: true,
          test_score: result.score,
        }),
      })

      // Оновлюємо рейтинг користувача

      // Відправляємо подію про оновлення рейтингу

    } catch (error) {
      console.error('Error saving test result:', error)
    }
  }

  const restartTest = () => {
    setCurrentQuestionIndex(0)
    setSelectedAnswers({})
    setShowResults(false)
    setTestResult(null)
    setTimeRemaining(questions.length * 60)
  }

  const formatTime = (seconds: number) => {
    const minutes = Math.floor(seconds / 60)
    const remainingSeconds = seconds % 60
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`
  }

  if (isLoading) {
    return (
      <Card className="w-full">
        <CardContent className="p-8">
          <div className="flex items-center justify-center">
            <div className="spinner w-8 h-8"></div>
            <span className="ml-3 text-gray-600">Завантаження питань...</span>
          </div>
        </CardContent>
      </Card>
    )
  }

  if (showResults && testResult) {
    return (
      <Card className="w-full">
        <CardHeader className="text-center">
          <CardTitle className="text-2xl">
            {testResult.passed ? 'Вітаємо! Тест пройдено!' : 'Тест не пройдено'}
          </CardTitle>
          <CardDescription>
            {testResult.passed 
              ? 'Ви успішно пройшли тест з результатом 80% або вище'
              : 'Для успішного проходження потрібно набрати 80% або більше'
            }
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Results Summary */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="text-center">
              <div className="text-3xl font-bold text-primary-500">{testResult.score}%</div>
              <div className="text-sm text-gray-600">Загальний бал</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-gray-900">{testResult.correct_answers}</div>
              <div className="text-sm text-gray-600">Правильних відповідей</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-gray-900">{testResult.total_questions}</div>
              <div className="text-sm text-gray-600">Всього питань</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-gray-900">{formatTime(testResult.time_spent)}</div>
              <div className="text-sm text-gray-600">Час виконання</div>
            </div>
          </div>

          {/* Pass/Fail Status */}
          <div className={`p-4 rounded-lg text-center ${
            testResult.passed 
              ? 'bg-success-50 border border-success-200' 
              : 'bg-error-50 border border-error-200'
          }`}>
            <div className={`flex items-center justify-center space-x-2 ${
              testResult.passed ? 'text-success-600' : 'text-error-600'
            }`}>
              {testResult.passed ? (
                <CheckCircle className="h-6 w-6" />
              ) : (
                <XCircle className="h-6 w-6" />
              )}
              <span className="font-semibold">
                {testResult.passed ? 'Тест пройдено!' : 'Тест не пройдено'}
              </span>
            </div>
            <p className={`text-sm mt-1 ${
              testResult.passed ? 'text-success-700' : 'text-error-700'
            }`}>
              {testResult.passed 
                ? 'Ви можете перейти до наступної теми'
                : 'Рекомендуємо повторити матеріал та пройти тест знову'
              }
            </p>
          </div>

          {/* Action Buttons */}
          <div className="flex flex-col sm:flex-row gap-4">
            <Button
              onClick={restartTest}
              className="flex-1 btn-outline"
            >
              <RotateCcw className="h-4 w-4 mr-2" />
              Пройти тест знову
            </Button>
            <Button
              onClick={onTestExit}
              className="flex-1 btn-primary"
            >
              Повернутися до теми
            </Button>
          </div>
        </CardContent>
      </Card>
    )
  }

  const currentQuestion = questions[currentQuestionIndex]
  if (!currentQuestion) return null

  const selectedAnswer = selectedAnswers[currentQuestion.id]
  const isAnswered = !!selectedAnswer

  return (
    <Card className="w-full">
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle>
            Питання {currentQuestionIndex + 1} з {questions.length}
          </CardTitle>
          <div className="flex items-center space-x-4">
            <div className="flex items-center space-x-1 text-sm text-gray-600">
              <Clock className="h-4 w-4" />
              <span>{formatTime(timeRemaining)}</span>
            </div>
            <div className="text-sm text-gray-600">
              {Math.round(((currentQuestionIndex + 1) / questions.length) * 100)}% завершено
            </div>
          </div>
        </div>
        
        {/* Progress Bar */}
        <div className="mt-4">
          <div className="progress-bar">
            <div 
              className="progress-fill" 
              style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
            ></div>
          </div>
        </div>
      </CardHeader>
      
      <CardContent className="space-y-6">
        {/* Question */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 mb-4">
            {currentQuestion.question_text}
          </h3>
          
          {/* Difficulty Badge */}
          <div className="mb-4">
            <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${
              currentQuestion.difficulty === 'easy' ? 'bg-success-100 text-success-700' :
              currentQuestion.difficulty === 'medium' ? 'bg-warning-100 text-warning-700' :
              'bg-error-100 text-error-700'
            }`}>
              {currentQuestion.difficulty === 'easy' ? 'Легко' :
               currentQuestion.difficulty === 'medium' ? 'Середньо' : 'Складно'}
            </span>
          </div>
        </div>

        {/* Answer Options */}
        <div className="space-y-3">
          {currentQuestion.options.map((option) => (
            <button
              key={option.id}
              onClick={() => handleAnswerSelect(option.id)}
              className={`w-full p-4 text-left rounded-lg border-2 transition-colors ${
                selectedAnswer === option.id
                  ? 'border-primary-500 bg-primary-50 text-primary-700'
                  : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
              }`}
            >
              <div className="flex items-center space-x-3">
                <div className={`w-4 h-4 rounded-full border-2 ${
                  selectedAnswer === option.id
                    ? 'border-primary-500 bg-primary-500'
                    : 'border-gray-300'
                }`}>
                  {selectedAnswer === option.id && (
                    <div className="w-full h-full rounded-full bg-white scale-50"></div>
                  )}
                </div>
                <span>{option.option_text}</span>
              </div>
            </button>
          ))}
        </div>

        {/* Navigation */}
        <div className="flex items-center justify-between pt-4">
          <Button
            onClick={handlePreviousQuestion}
            disabled={currentQuestionIndex === 0}
            variant="outline"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Попереднє
          </Button>

          <div className="flex items-center space-x-2">
            {!isAnswered && (
              <div className="flex items-center space-x-1 text-sm text-warning-600">
                <AlertCircle className="h-4 w-4" />
                <span>Оберіть відповідь</span>
              </div>
            )}
          </div>

          <Button
            onClick={handleNextQuestion}
            disabled={!isAnswered}
            className="btn-primary"
          >
            {currentQuestionIndex === questions.length - 1 ? 'Завершити тест' : 'Наступне'}
            <ArrowRight className="h-4 w-4 ml-2" />
          </Button>
        </div>
      </CardContent>
    </Card>
  )
}
