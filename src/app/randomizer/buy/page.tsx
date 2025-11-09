'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { CheckCircle, Loader2, ArrowLeft, Zap } from 'lucide-react'
import Link from 'next/link'
import AuthGuard from '@/components/auth/AuthGuard'

interface RandomizerPackage {
  id: string
  name: string
  attempts: number
  price: number
  pricePerAttempt: number
  popular?: boolean
  savings?: string
}

export default function RandomizerBuyPage() {
  const router = useRouter()
  const [selectedPackage, setSelectedPackage] = useState<RandomizerPackage | null>(null)
  const [isProcessing, setIsProcessing] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const packages: RandomizerPackage[] = [
    {
      id: 'single',
      name: 'Одна спроба',
      attempts: 1,
      price: 180,
      pricePerAttempt: 180
    },
    {
      id: 'pack-5',
      name: 'Пакет 5 спроб',
      attempts: 5,
      price: 650,
      pricePerAttempt: 130,
      savings: 'Економія 250 ₴',
      popular: true
    },
    {
      id: 'pack-10',
      name: 'Пакет 10 спроб',
      attempts: 10,
      price: 1450,
      pricePerAttempt: 145,
      savings: 'Економія 350 ₴'
    }
  ]

  const handlePurchase = async (pkg: RandomizerPackage) => {
    setIsProcessing(true)
    setError(null)
    setSelectedPackage(pkg)

    try {
      const response = await fetch('/api/payments/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          plan_type: 'randomizer',
          payment_provider: 'mono',
          amount: pkg.price,
          currency: 'UAH',
          attempts_count: pkg.attempts
        }),
      })

      if (!response.ok) {
        throw new Error('Помилка при створенні платежу')
      }

      const data = await response.json()
      
      if (data.payment_url) {
        // Перенаправляємо на сторінку оплати
        window.location.href = data.payment_url
      } else {
        throw new Error('Не отримано URL для оплати')
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Сталася невідома помилка')
      setIsProcessing(false)
    }
  }

  return (
    <AuthGuard>
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 py-12 px-4">
        <div className="max-w-6xl mx-auto">
          {/* Header */}
          <div className="mb-8">
            <Link href="/randomizer/settings">
              <Button variant="outline" className="mb-4">
                <ArrowLeft className="w-4 h-4 mr-2" />
                Назад
              </Button>
            </Link>
            
            <div className="text-center">
              <h1 className="text-4xl font-bold text-gray-900 mb-4">
                <Zap className="inline-block w-10 h-10 text-yellow-500 mr-2" />
                Randomizer PRO
              </h1>
              <p className="text-xl text-gray-600 max-w-2xl mx-auto">
                Оберіть пакет спроб для проходження повної імітації КРОК-тесту
              </p>
            </div>
          </div>

          {/* Packages Grid */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            {packages.map((pkg) => (
              <Card 
                key={pkg.id}
                className={`relative ${pkg.popular ? 'border-2 border-blue-600 shadow-xl' : ''}`}
              >
                {pkg.popular && (
                  <div className="absolute -top-4 left-1/2 transform -translate-x-1/2">
                    <div className="bg-blue-600 text-white px-4 py-1 rounded-full text-sm font-medium">
                      Найпопулярніше
                    </div>
                  </div>
                )}

                <CardHeader className="text-center">
                  <CardTitle className="text-2xl">{pkg.name}</CardTitle>
                  <CardDescription>
                    {pkg.attempts} {pkg.attempts === 1 ? 'спроба' : 'спроб'}
                  </CardDescription>
                </CardHeader>

                <CardContent className="space-y-6">
                  {/* Price */}
                  <div className="text-center">
                    <div className="text-4xl font-bold text-gray-900 mb-2">
                      {pkg.price} ₴
                    </div>
                    <div className="text-sm text-gray-600">
                      {pkg.pricePerAttempt} ₴ за спробу
                    </div>
                    {pkg.savings && (
                      <div className="text-sm text-green-600 font-medium mt-2">
                        {pkg.savings}
                      </div>
                    )}
                  </div>

                  {/* Features */}
                  <ul className="space-y-2">
                    <li className="flex items-center space-x-2">
                      <CheckCircle className="h-5 w-5 text-green-500 flex-shrink-0" />
                      <span className="text-sm text-gray-700">150 випадкових питань</span>
                    </li>
                    <li className="flex items-center space-x-2">
                      <CheckCircle className="h-5 w-5 text-green-500 flex-shrink-0" />
                      <span className="text-sm text-gray-700">2.5 години на тест</span>
                    </li>
                    <li className="flex items-center space-x-2">
                      <CheckCircle className="h-5 w-5 text-green-500 flex-shrink-0" />
                      <span className="text-sm text-gray-700">Детальна статистика</span>
                    </li>
                    <li className="flex items-center space-x-2">
                      <CheckCircle className="h-5 w-5 text-green-500 flex-shrink-0" />
                      <span className="text-sm text-gray-700">Збереження результатів</span>
                    </li>
                    <li className="flex items-center space-x-2">
                      <CheckCircle className="h-5 w-5 text-green-500 flex-shrink-0" />
                      <span className="text-sm text-gray-700">Без терміну дії</span>
                    </li>
                  </ul>

                  {/* Buy Button */}
                  <Button
                    onClick={() => handlePurchase(pkg)}
                    disabled={isProcessing}
                    className={`w-full ${pkg.popular ? 'bg-blue-600 hover:bg-blue-700' : ''}`}
                  >
                    {isProcessing && selectedPackage?.id === pkg.id ? (
                      <>
                        <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                        Обробка...
                      </>
                    ) : (
                      `Купити за ${pkg.price} ₴`
                    )}
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>

          {/* Error Message */}
          {error && (
            <Card className="border-red-200 bg-red-50 mb-8">
              <CardContent className="p-4">
                <p className="text-red-700">{error}</p>
              </CardContent>
            </Card>
          )}

          {/* Info Section */}
          <Card className="bg-blue-50 border-blue-200">
            <CardContent className="p-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">
                Що таке Randomizer PRO?
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-gray-700">
                <div>
                  <p className="mb-2">
                    <strong>Повна імітація КРОК:</strong> 150 випадкових питань з усієї бази, як на справжньому екзамені.
                  </p>
                  <p className="mb-2">
                    <strong>Обмеження часу:</strong> 2.5 години на проходження тесту.
                  </p>
                </div>
                <div>
                  <p className="mb-2">
                    <strong>Детальна аналітика:</strong> Отримайте повну статистику по темах і складності.
                  </p>
                  <p>
                    <strong>Без терміну дії:</strong> Спроби не згорають, використовуйте коли зручно.
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Security Notice */}
          <div className="text-center text-sm text-gray-500 mt-6">
            <p>
              Всі платежі захищені SSL-шифруванням через Plata by mono.
              Ми не зберігаємо дані ваших карток.
            </p>
          </div>
        </div>
      </div>
    </AuthGuard>
  )
}

