'use client'

import { useState, Suspense } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { Rocket } from 'lucide-react'

function RandomizerSettingsContent() {
  const router = useRouter()
  const searchParams = useSearchParams()
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical' | null>(null)
  const [showAnswers, setShowAnswers] = useState(searchParams.get('showAnswers') === 'true')

  const handleStartTest = () => {
    if (!selectedFaculty) return

    const params = new URLSearchParams()
    if (showAnswers) {
      params.set('showAnswers', 'true')
    }

    if (selectedFaculty === 'medical') {
      router.push(`/randomizer?${params.toString()}`)
    } else {
      router.push(`/pharmaceutical/randomizer?${params.toString()}`)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden flex items-center justify-center">
      {/* Фонові візерунки */}
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-20 left-20 w-32 h-32 border border-blue-200 rounded-full animate-pulse"></div>
        <div className="absolute top-40 right-32 w-24 h-24 border border-blue-200 rounded-full animate-pulse delay-1000"></div>
        <div className="absolute bottom-32 left-40 w-40 h-40 border border-blue-200 rounded-full animate-pulse delay-2000"></div>
        <div className="absolute bottom-20 right-20 w-28 h-28 border border-blue-200 rounded-full animate-pulse delay-500"></div>
        <div className="absolute top-1/2 left-1/4 w-20 h-20 border border-blue-200 rounded-full animate-pulse delay-1500"></div>
        <div className="absolute top-1/3 right-1/4 w-36 h-36 border border-blue-200 rounded-full animate-pulse delay-3000"></div>
      </div>

      {/* Settings Card */}
      <div className="relative z-10 w-full max-w-2xl mx-4">
        <div className="bg-white rounded-2xl shadow-xl p-8">
          {/* Header */}
          <div className="mb-8">
            <h1 className="text-3xl font-bold text-blue-600 mb-2">
              Налаштування Randomizer PRO
            </h1>
            <p className="text-gray-600">
              Налаштуйте параметри тесту перед початком
            </p>
          </div>

          {/* Faculty Selection */}
          <div className="mb-8">
            <h2 className="text-xl font-semibold text-gray-800 mb-4">
              Оберіть факультет
            </h2>
            <div className="grid grid-cols-2 gap-4">
              <button
                onClick={() => setSelectedFaculty('medical')}
                className={`p-6 rounded-xl border-2 transition-all ${
                  selectedFaculty === 'medical'
                    ? 'border-blue-600 bg-blue-50'
                    : 'border-gray-200 hover:border-blue-300 hover:bg-gray-50'
                }`}
              >
                <div className="text-center">
                  <div className="text-2xl mb-2">🏥</div>
                  <div className="text-lg font-semibold text-gray-800">
                    Медицина
                  </div>
                </div>
              </button>

              <button
                onClick={() => setSelectedFaculty('pharmaceutical')}
                className={`p-6 rounded-xl border-2 transition-all ${
                  selectedFaculty === 'pharmaceutical'
                    ? 'border-blue-600 bg-blue-50'
                    : 'border-gray-200 hover:border-blue-300 hover:bg-gray-50'
                }`}
              >
                <div className="text-center">
                  <div className="text-2xl mb-2">💊</div>
                  <div className="text-lg font-semibold text-gray-800">
                    Фармація
                  </div>
                </div>
              </button>
            </div>
          </div>

          {/* Toggle Settings */}
          <div className="mb-8 p-4 bg-gray-50 rounded-xl">
            <div className="flex items-center justify-between mb-2">
              <div>
                <h3 className="text-lg font-semibold text-gray-800">
                  Показувати відповіді
                </h3>
                <p className="text-sm text-gray-600">
                  Показувати правильну відповідь одразу після вибору
                </p>
              </div>
              <button
                type="button"
                onClick={() => setShowAnswers(!showAnswers)}
                className={`
                  relative inline-flex h-7 w-12 flex-shrink-0 cursor-pointer rounded-full 
                  border-2 border-transparent transition-colors duration-200 ease-in-out 
                  focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2
                  ${showAnswers ? 'bg-blue-600' : 'bg-gray-300'}
                `}
              >
                <span
                  className={`
                    pointer-events-none inline-block h-6 w-6 transform rounded-full bg-white shadow transform ring-0 transition duration-200 ease-in-out
                    ${showAnswers ? 'translate-x-5' : 'translate-x-0'}
                  `}
                />
              </button>
            </div>
          </div>

          {/* Start Button */}
          <button
            onClick={handleStartTest}
            disabled={!selectedFaculty}
            className={`
              w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 
              text-white font-semibold py-4 px-6 rounded-xl transition-all duration-200 
              shadow-md hover:shadow-lg
              ${!selectedFaculty ? 'opacity-50 cursor-not-allowed' : ''}
            `}
          >
            <Rocket className="w-5 h-5" />
            Почати тест
          </button>
        </div>
      </div>
    </div>
  )
}

export default function RandomizerSettingsPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження...</p>
        </div>
      </div>
    }>
      <RandomizerSettingsContent />
    </Suspense>
  )
}

