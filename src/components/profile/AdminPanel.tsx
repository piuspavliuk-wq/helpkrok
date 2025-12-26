'use client'

import { useState } from 'react'
import { useSession } from 'next-auth/react'
import { Shield, CheckCircle, XCircle, Loader2 } from 'lucide-react'

const MEDICAL_COURSES = [
  {
    id: 'fundamental-medico-biological-knowledge',
    title: 'Фундаментальні медико-біологічні знання'
  },
  {
    id: 'blood-system-and-immunity',
    title: 'Система кровотворення й імунного захисту, кров'
  },
  {
    id: 'central-nervous-system',
    title: 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття'
  }
]

const PHARMACEUTICAL_COURSES = [
  {
    id: 'organic-compounds-basics',
    title: 'Основи знань про органічні сполуки'
  },
  {
    id: 'pharmaceutical-analysis-theory',
    title: 'Теоретичні основи фармацевтичного аналізу'
  },
  {
    id: 'physical-physicochemical-basics',
    title: 'Фізичні та фізико-хімічні основи хіміко-біологічних процесів і фармацевтичної технології'
  },
  {
    id: 'pharmaceutical-botany',
    title: 'Фармацевтична ботаніка'
  },
  {
    id: 'pathological-processes',
    title: 'Основні патологічні процеси'
  },
  {
    id: 'biochemical-processes',
    title: 'Основні біохімічні процеси'
  },
  {
    id: 'infectious-disease-agents',
    title: 'Основи знань про збудників інфекційних хвороб'
  },
  {
    id: 'rational-drug-use',
    title: 'Основи раціонального застосування лікарських засобів'
  },
  {
    id: 'morphological-structure-vegetative-organs',
    title: 'Морфологічна будова вегетативних органів'
  }
]

export default function AdminPanel() {
  const { data: session } = useSession()
  const [email, setEmail] = useState('')
  const [faculty, setFaculty] = useState<'medical' | 'pharmaceutical'>('medical')
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState<{
    success: boolean
    message: string
    details?: any
  } | null>(null)

  const isAdmin = session?.user?.email === 'admin@helpkrok.com' || session?.user?.role === 'admin'

  if (!isAdmin) {
    return (
      <div className="bg-white rounded-lg shadow-lg p-6">
        <div className="text-center">
          <XCircle className="w-12 h-12 text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-gray-900 mb-2">
            Доступ заборонено
          </h2>
          <p className="text-gray-600">
            Тільки адміністратори можуть використовувати цю функцію.
          </p>
        </div>
      </div>
    )
  }

  const handleGrantAccess = async (e: React.FormEvent) => {
    e.preventDefault()
    
    if (!email.trim()) {
      setResult({
        success: false,
        message: 'Будь ласка, введіть email користувача'
      })
      return
    }

    setLoading(true)
    setResult(null)

    try {
      // Надаємо доступ до всіх курсів обраного факультету одним запитом
      const response = await fetch('/api/courses/grant-access', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: email.trim(),
          grantAllMedical: faculty === 'medical',
          grantAllPharmaceutical: faculty === 'pharmaceutical'
        })
      })

      const data = await response.json()

      if (data.success) {
        setResult({
          success: true,
          message: data.message || `✅ Доступ успішно надано до всіх курсів ${faculty === 'medical' ? 'медицини' : 'фармації'}!`,
          details: data.results
        })
        setEmail('')
      } else {
        setResult({
          success: false,
          message: data.message || data.error || 'Помилка при наданні доступу',
          details: data.results
        })
      }
    } catch (error) {
      console.error('Помилка надання доступу:', error)
      setResult({
        success: false,
        message: 'Помилка при наданні доступу. Спробуйте пізніше.'
      })
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex items-center space-x-3 mb-6">
        <Shield className="w-6 h-6 text-blue-600" />
        <h2 className="text-2xl font-semibold text-gray-900">
          Адмін-панель: Надання доступу до курсів
        </h2>
      </div>

      <div className="mb-6 space-y-4">
        <div>
          <label htmlFor="faculty" className="block text-sm font-medium text-gray-700 mb-2">
            Факультет
          </label>
          <select
            id="faculty"
            value={faculty}
            onChange={(e) => {
              setFaculty(e.target.value as 'medical' | 'pharmaceutical')
              setResult(null)
            }}
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            disabled={loading}
          >
            <option value="medical">Медицина</option>
            <option value="pharmaceutical">Фармація</option>
          </select>
        </div>

        <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
          <h3 className="font-semibold text-gray-900 mb-2">
            Доступ буде надано до всіх курсів {faculty === 'medical' ? 'медицини' : 'фармації'}:
          </h3>
          <ul className="space-y-2 text-sm text-gray-700 max-h-60 overflow-y-auto">
            {(faculty === 'medical' ? MEDICAL_COURSES : PHARMACEUTICAL_COURSES).map((course) => (
              <li key={course.id} className="flex items-start">
                <CheckCircle className="w-4 h-4 text-green-500 mr-2 mt-0.5 flex-shrink-0" />
                <span>{course.title}</span>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <form onSubmit={handleGrantAccess} className="space-y-4">
        <div>
          <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-2">
            Email користувача
          </label>
          <input
            type="email"
            id="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="user@example.com"
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            disabled={loading}
            required
          />
          <p className="mt-1 text-sm text-gray-500">
            Введіть email користувача, якому потрібно надати доступ
          </p>
        </div>

        <button
          type="submit"
          disabled={loading || !email.trim()}
          className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center space-x-2"
        >
          {loading ? (
            <>
              <Loader2 className="w-4 h-4 animate-spin" />
              <span>Надання доступу...</span>
            </>
          ) : (
            <>
              <Shield className="w-4 h-4" />
              <span>Надати доступ до всіх курсів {faculty === 'medical' ? 'медицини' : 'фармації'}</span>
            </>
          )}
        </button>
      </form>

      {result && (
        <div
          className={`mt-4 p-4 rounded-lg ${
            result.success
              ? 'bg-green-50 border border-green-200'
              : 'bg-red-50 border border-red-200'
          }`}
        >
          <div className="flex items-start space-x-2">
            {result.success ? (
              <CheckCircle className="w-5 h-5 text-green-600 mt-0.5 flex-shrink-0" />
            ) : (
              <XCircle className="w-5 h-5 text-red-600 mt-0.5 flex-shrink-0" />
            )}
            <div className="flex-1">
              <p
                className={`font-medium ${
                  result.success ? 'text-green-800' : 'text-red-800'
                }`}
              >
                {result.message}
              </p>
              {result.details && (
                <details className="mt-2">
                  <summary className="text-sm text-gray-600 cursor-pointer hover:text-gray-800">
                    Деталі
                  </summary>
                  <pre className="mt-2 text-xs bg-white p-2 rounded overflow-auto max-h-40">
                    {JSON.stringify(result.details, null, 2)}
                  </pre>
                </details>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

