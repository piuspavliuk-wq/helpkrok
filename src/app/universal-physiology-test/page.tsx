'use client'

import { useState } from 'react'
import UniversalDiagnosticTest from '@/components/testing/UniversalDiagnosticTest'
import AuthGuard from '@/components/auth/AuthGuard'

export default function UniversalPhysiologyTestPage() {
  const [testType, setTestType] = useState<'medical' | 'pharmaceutical'>('medical')
  const [testStarted, setTestStarted] = useState(false)

  return (
    <AuthGuard>
      {testStarted ? (
        <UniversalDiagnosticTest
          testType={testType}
          testName={testType === 'medical' ? 'Діагностичний тест - Медицина' : 'Діагностичний тест - Фармація'}
          limit={10}
        />
      ) : (
        <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-4xl mx-auto px-4">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-4">
            📊 Діагностичний тест
          </h1>
          <p className="text-xl text-gray-600">
            Оберіть тип тесту для визначення вашого початкового рівня знань
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto">
          {/* Медичний тест */}
          <div className="bg-white rounded-lg shadow-md p-6 border border-blue-200">
            <div className="text-center">
              <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">🏥</span>
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                Медичний діагностичний тест
              </h3>
              <p className="text-gray-600 mb-4">
                Діагностика початкового рівня знань для студентів медичного факультету
              </p>
              <button
                onClick={() => {
                  setTestType('medical')
                  setTestStarted(true)
                }}
                className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition-colors"
              >
                Почати медичний тест
              </button>
            </div>
          </div>

          {/* Фармацевтичний тест */}
          <div className="bg-white rounded-lg shadow-md p-6 border border-purple-200">
            <div className="text-center">
              <div className="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">💊</span>
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                Фармацевтичний діагностичний тест
              </h3>
              <p className="text-gray-600 mb-4">
                Діагностика початкового рівня знань для студентів фармацевтичного факультету
              </p>
              <button
                onClick={() => {
                  setTestType('pharmaceutical')
                  setTestStarted(true)
                }}
                className="w-full bg-purple-600 hover:bg-purple-700 text-white font-medium py-3 px-6 rounded-lg transition-colors"
              >
                Почати фармацевтичний тест
              </button>
            </div>
          </div>
        </div>

        <div className="text-center mt-8">
          <button
            onClick={() => window.location.href = '/'}
            className="text-gray-600 hover:text-gray-800 transition-colors"
          >
            ← Назад на головну
          </button>
        </div>
      </div>
    </div>
      )}
    </AuthGuard>
  )
}
