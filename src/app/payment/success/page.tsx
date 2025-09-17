'use client'

import { useEffect, useState, Suspense } from 'react'
import { useSearchParams } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { CheckCircle, ArrowRight, Home } from 'lucide-react'
import Link from 'next/link'

function PaymentSuccessContent() {
  const searchParams = useSearchParams()
  const sessionId = searchParams.get('session_id')
  const [isLoading, setIsLoading] = useState(true)
  const [subscription, setSubscription] = useState<any>(null)

  useEffect(() => {
    if (sessionId) {
      // Тут має бути логіка перевірки статусу платежу
      // Для демонстрації просто встановлюємо успішний статус
      setTimeout(() => {
        setSubscription({
          id: sessionId,
          status: 'active',
          plan: 'Медичний факультет',
          amount: 1200,
          currency: 'UAH'
        })
        setIsLoading(false)
      }, 2000)
    } else {
      setIsLoading(false)
    }
  }, [sessionId])

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-500 mx-auto mb-4"></div>
          <p className="text-gray-600">Перевіряємо статус платежу...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-4">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <div className="bg-success-100 w-16 h-16 rounded-full flex items-center justify-center">
              <CheckCircle className="h-8 w-8 text-success-500" />
            </div>
          </div>
          <CardTitle className="text-2xl font-bold text-success-700">
            Оплата успішна!
          </CardTitle>
          <CardDescription>
            Ваша підписка активована
          </CardDescription>
        </CardHeader>
        
        <CardContent className="space-y-6">
          {subscription && (
            <div className="bg-gray-50 p-4 rounded-lg">
              <h3 className="font-semibold text-gray-900 mb-2">Деталі підписки:</h3>
              <div className="space-y-1 text-sm text-gray-600">
                <p><strong>План:</strong> {subscription.plan}</p>
                <p><strong>Сума:</strong> {subscription.amount} {subscription.currency}</p>
                <p><strong>Статус:</strong> <span className="text-success-600">Активна</span></p>
              </div>
            </div>
          )}

          <div className="space-y-3">
            <Button className="w-full btn-primary">
              <Link href="/profile">
                Перейти до дашборду
                <ArrowRight className="h-4 w-4 ml-2" />
              </Link>
            </Button>
            
            <Button variant="outline" className="w-full">
              <Link href="/">
                <Home className="h-4 w-4 mr-2" />
                На головну
              </Link>
            </Button>
          </div>

          <div className="text-center text-sm text-gray-500">
            <p>
              Дякуємо за довіру! Тепер ви маєте повний доступ до всіх матеріалів.
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}

export default function PaymentSuccessPage() {
  return (
    <Suspense fallback={<div>Завантаження...</div>}>
      <PaymentSuccessContent />
    </Suspense>
  )
}
