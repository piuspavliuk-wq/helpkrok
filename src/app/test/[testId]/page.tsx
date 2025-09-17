'use client'

import { useState, useEffect } from 'react'
import { useSearchParams } from 'next/navigation'

interface Question {
  id: string
  question_text: string
  explanation: string | null
  difficulty: 'easy' | 'medium' | 'hard'
  options: QuestionOption[]
}

interface QuestionOption {
  id: string
  option_text: string
  is_correct: boolean
}

export default function TestPage() {
  const searchParams = useSearchParams()
  const testId = searchParams.get('testId') || 'anatomy'
  const step = searchParams.get('step') || 'krok1'
  const faculty = searchParams.get('faculty') || 'medical'
  const yearRange = searchParams.get('yearRange') || '2001-2015'

  const [questions, setQuestions] = useState<Question[]>([])
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0)
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null)
  const [answers, setAnswers] = useState<Record<string, string>>({})
  const [loading, setLoading] = useState(true)
  const [testStarted, setTestStarted] = useState(false)
  const [timeLeft, setTimeLeft] = useState(3600) // 1 година в секундах

  // Mock questions for demonstration
  const mockQuestions: Question[] = [
    {
      id: '1',
      question_text: 'Яка основна функція серця в організмі людини?',
      explanation: 'Серце виконує функцію насоса, що забезпечує циркуляцію крові по всьому організму.',
      difficulty: 'medium',
      options: [
        { id: '1a', option_text: 'Перетравлення їжі', is_correct: false },
        { id: '1b', option_text: 'Циркуляція крові', is_correct: true },
        { id: '1c', option_text: 'Дихання', is_correct: false },
        { id: '1d', option_text: 'Фільтрація токсинів', is_correct: false }
      ]
    },
    {
      id: '2',
      question_text: 'Скільки камер має серце людини?',
      explanation: 'Серце людини має 4 камери: 2 передсердя та 2 шлуночки.',
      difficulty: 'easy',
      options: [
        { id: '2a', option_text: '2', is_correct: false },
        { id: '2b', option_text: '3', is_correct: false },
        { id: '2c', option_text: '4', is_correct: true },
        { id: '2d', option_text: '5', is_correct: false }
      ]
    }
  ]

  useEffect(() => {
    // Simulate loading questions
    setTimeout(() => {
      setQuestions(mockQuestions)
      setLoading(false)
    }, 1000)
  }, [testId])

  useEffect(() => {
    if (testStarted && timeLeft > 0) {
      const timer = setTimeout(() => setTimeLeft(timeLeft - 1), 1000)
      return () => clearTimeout(timer)
    }
  }, [testStarted, timeLeft])

  const formatTime = (seconds: number) => {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    const secs = seconds % 60
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }

  const handleAnswerSelect = (optionId: string) => {
    setSelectedAnswer(optionId)
    setAnswers(prev => ({
      ...prev,
      [questions[currentQuestionIndex].id]: optionId
    }))
  }

  const handleNextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1)
      setSelectedAnswer(answers[questions[currentQuestionIndex + 1].id] || null)
    }
  }

  const handlePreviousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1)
      setSelectedAnswer(answers[questions[currentQuestionIndex - 1].id] || null)
    }
  }

  const handleStartTest = () => {
    setTestStarted(true)
  }

  const handleFinishTest = () => {
    // Calculate score
    let correctAnswers = 0
    questions.forEach(question => {
      const userAnswer = answers[question.id]
      const correctOption = question.options.find(opt => opt.is_correct)
      if (userAnswer === correctOption?.id) {
        correctAnswers++
      }
    })

    const score = (correctAnswers / questions.length) * 100
    alert(`Тест завершено! Ваш результат: ${score.toFixed(1)}% (${correctAnswers}/${questions.length})`)
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
          <div className="text-gray-500 text-lg mt-4">Завантаження тесту...</div>
        </div>
      </div>
    )
  }

  if (!testStarted) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100">
        <div className="container mx-auto px-4 py-8">
          <div className="max-w-2xl mx-auto">
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
              <h1 className="text-3xl font-bold text-gray-900 mb-6">Тест: {testId}</h1>
              
              <div className="space-y-4 mb-8">
                <div className="flex justify-between">
                  <span className="text-gray-600">Крок:</span>
                  <span className="font-medium">{step}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Спеціальність:</span>
                  <span className="font-medium">{faculty === 'medical' ? 'Медицина' : 'Фармація'}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Рік:</span>
                  <span className="font-medium">{yearRange}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Кількість питань:</span>
                  <span className="font-medium">{questions.length}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Час:</span>
                  <span className="font-medium">60 хвилин</span>
                </div>
              </div>

              <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
                <h3 className="font-medium text-blue-900 mb-2">Інструкції:</h3>
                <ul className="text-sm text-blue-800 space-y-1">
                  <li>• Виберіть одну відповідь на кожне питання</li>
                  <li>• Ви можете повернутися до попередніх питань</li>
                  <li>• Тест автоматично завершиться через 60 хвилин</li>
                  <li>• Результат буде показано після завершення</li>
                </ul>
              </div>

              <button
                onClick={handleStartTest}
                className="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-3 px-6 rounded-lg transition-colors"
              >
                Почати тест
              </button>
            </div>
          </div>
        </div>
      </div>
    )
  }

  const currentQuestion = questions[currentQuestionIndex]

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4 mb-6">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-xl font-bold text-gray-900">Тест: {testId}</h1>
              <p className="text-gray-600">Питання {currentQuestionIndex + 1} з {questions.length}</p>
            </div>
            <div className="text-right">
              <div className="text-lg font-bold text-blue-600">{formatTime(timeLeft)}</div>
              <div className="text-sm text-gray-500">залишилося часу</div>
            </div>
          </div>
          
          {/* Progress Bar */}
          <div className="mt-4">
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div 
                className="bg-blue-500 h-2 rounded-full transition-all duration-300"
                style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
              />
            </div>
          </div>
        </div>

        {/* Question */}
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-8 mb-6">
          <h2 className="text-xl font-semibold text-gray-900 mb-6">
            {currentQuestion.question_text}
          </h2>

          <div className="space-y-3">
            {currentQuestion.options.map((option) => (
              <label
                key={option.id}
                className={`block p-4 rounded-lg border cursor-pointer transition-colors ${
                  selectedAnswer === option.id
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <input
                  type="radio"
                  name="answer"
                  value={option.id}
                  checked={selectedAnswer === option.id}
                  onChange={() => handleAnswerSelect(option.id)}
                  className="sr-only"
                />
                <div className="flex items-center">
                  <div className={`w-4 h-4 rounded-full border-2 mr-3 ${
                    selectedAnswer === option.id
                      ? 'border-blue-500 bg-blue-500'
                      : 'border-gray-300'
                  }`}>
                    {selectedAnswer === option.id && (
                      <div className="w-2 h-2 bg-white rounded-full mx-auto mt-0.5" />
                    )}
                  </div>
                  <span className="text-gray-900">{option.option_text}</span>
                </div>
              </label>
            ))}
          </div>
        </div>

        {/* Navigation */}
        <div className="flex justify-between">
          <button
            onClick={handlePreviousQuestion}
            disabled={currentQuestionIndex === 0}
            className="px-6 py-2 bg-gray-500 hover:bg-gray-600 disabled:bg-gray-300 disabled:cursor-not-allowed text-white rounded-lg transition-colors"
          >
            Попереднє
          </button>

          <div className="flex gap-2">
            {questions.map((_, index) => (
              <button
                key={index}
                onClick={() => {
                  setCurrentQuestionIndex(index)
                  setSelectedAnswer(answers[questions[index].id] || null)
                }}
                className={`w-8 h-8 rounded-full text-sm font-medium transition-colors ${
                  index === currentQuestionIndex
                    ? 'bg-blue-500 text-white'
                    : answers[questions[index].id]
                    ? 'bg-green-500 text-white'
                    : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                }`}
              >
                {index + 1}
              </button>
            ))}
          </div>

          {currentQuestionIndex === questions.length - 1 ? (
            <button
              onClick={handleFinishTest}
              className="px-6 py-2 bg-green-500 hover:bg-green-600 text-white rounded-lg transition-colors"
            >
              Завершити тест
            </button>
          ) : (
            <button
              onClick={handleNextQuestion}
              className="px-6 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-lg transition-colors"
            >
              Наступне
            </button>
          )}
        </div>
      </div>
    </div>
  )
}
