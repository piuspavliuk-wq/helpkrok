'use client'

import { useState, useEffect } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { CheckCircle, ArrowLeft, Zap, Loader2 } from 'lucide-react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import AuthGuard from '@/components/auth/AuthGuard'
import PaymentModal from '@/components/payment/PaymentModal'

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
  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false)
  const [attemptsData, setAttemptsData] = useState<{ remainingAttempts: number; isUnlimited?: boolean } | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    // Перевіряємо чи є у користувача спроби
    fetch('/api/randomizer/attempts')
      .then(res => res.json())
      .then(data => {
        if (data.remainingAttempts > 0 || data.isUnlimited) {
          setAttemptsData(data)
        }
      })
      .catch(err => console.error('Error fetching attempts:', err))
      .finally(() => setIsLoading(false))
  }, [])

  const handleBuyPackage = (pkg: RandomizerPackage) => {
    setSelectedPackage(pkg)
    setIsPaymentModalOpen(true)
  }

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

  // Якщо завантажується
  if (isLoading) {
    return (
      <AuthGuard>
        <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
          <Loader2 className="w-12 h-12 text-blue-600 animate-spin" />
        </div>
      </AuthGuard>
    )
  }

  // Якщо є спроби - показуємо їх
  if (attemptsData && (attemptsData.remainingAttempts > 0 || attemptsData.isUnlimited)) {
    return (
      <AuthGuard>
        <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 py-12 px-4">
          <div className="max-w-4xl mx-auto">
            <Link href="/randomizer/settings">
              <Button
                variant="outline"
                className="mb-6 rounded-xl border-blue-200 text-gray-800 bg-white hover:bg-blue-50 hover:text-blue-600 shadow-sm px-5"
              >
                <ArrowLeft className="w-4 h-4 mr-2" />
                Назад
              </Button>
            </Link>

            <Card className="border border-blue-100 bg-white shadow-sm">
              <CardHeader className="text-center pt-8 pb-6">
                <div className="mx-auto mb-4 bg-blue-50 rounded-full p-4 w-20 h-20 flex items-center justify-center border border-blue-200">
                  <Zap className="w-10 h-10 text-blue-500" />
                </div>
                <CardTitle className="text-3xl font-semibold text-blue-700">
                  {(attemptsData.isUnlimited || attemptsData.remainingAttempts >= 999999) ? (
                    'У вас необмежена кількість спроб!'
                  ) : (
                    `У вас є ${attemptsData.remainingAttempts} ${attemptsData.remainingAttempts === 1 ? 'спроба' : 'спроб'}!`
                  )}
                </CardTitle>
                <CardDescription className="text-lg text-gray-600">
                  Ви можете розпочати повну імітацію КРОК-тесту
                </CardDescription>
              </CardHeader>
              <CardContent className="pt-0 pb-6">
                <div className="flex flex-col sm:flex-row items-center sm:justify-center gap-3 sm:gap-4">
                  <Link href="/randomizer/settings" className="w-full sm:w-auto">
                    <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white text-lg px-10 py-6 rounded-xl shadow-sm">
                      Розпочати тест
                      <ArrowLeft className="w-5 h-5 ml-2 rotate-180" />
                    </Button>
                  </Link>
                  <Button 
                    variant="outline" 
                    className="w-full sm:w-auto border-blue-500 text-blue-600 hover:bg-blue-50 hover:text-blue-700 rounded-xl px-10 py-6"
                    onClick={() => setAttemptsData(null)}
                  >
                    Переглянути пакети
                  </Button>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </AuthGuard>
    )
  }

  // Якщо немає спроб - показуємо сторінку покупки
  return (
    <AuthGuard>
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 py-12 px-4">
        <div className="max-w-6xl mx-auto">
          {/* Header */}
          <div className="mb-8">
            <Link href="/randomizer/settings">
              <Button
                variant="outline"
                className="mb-6 rounded-xl border-blue-200 text-gray-800 bg-white hover:bg-blue-50 hover:text-blue-600 shadow-sm px-5"
              >
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
                    onClick={() => handleBuyPackage(pkg)}
                    className={`w-full ${pkg.popular ? 'bg-blue-600 hover:bg-blue-700 text-white' : ''}`}
                  >
                    Купити зараз
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>

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
        </div>

        {/* Payment Modal */}
        {selectedPackage && (
          <PaymentModal
            isOpen={isPaymentModalOpen}
            onClose={() => {
              setIsPaymentModalOpen(false)
              setSelectedPackage(null)
            }}
            packageId={selectedPackage.id}
            packageName={selectedPackage.name}
            packagePrice={selectedPackage.price}
            packageAttempts={selectedPackage.attempts}
          />
        )}
      </div>
    </AuthGuard>
  )
}

