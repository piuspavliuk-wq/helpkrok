'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { 
  CreditCard, 
  Shield, 
  CheckCircle, 
  Loader2,
  AlertCircle,
  Star
} from 'lucide-react'

type PaymentProvider = 'mono'

interface PaymentPlan {
  id: string
  name: string
  type: 'medical' | 'pharmaceutical' | 'premium'
  price: number
  currency: 'UAH'
  duration_months: number
  description: string
  features: string[]
  popular?: boolean
}

interface PaymentComponentProps {
  selectedPlan: PaymentPlan
  onPaymentSuccess: (subscription: any) => void
  onPaymentCancel: () => void
}

export function PaymentComponent({ selectedPlan, onPaymentSuccess, onPaymentCancel }: PaymentComponentProps) {
  const [paymentMethod, setPaymentMethod] = useState<PaymentProvider>('mono')
  const [isProcessing, setIsProcessing] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handlePayment = async () => {
    setIsProcessing(true)
    setError(null)

    try {
      const response = await fetch('/api/payments/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          plan_type: selectedPlan.type,
          payment_provider: paymentMethod,
          amount: selectedPlan.price,
          currency: selectedPlan.currency,
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
    } finally {
      setIsProcessing(false)
    }
  }

  const paymentProviders = [
    {
      id: 'mono' as PaymentProvider,
      name: 'Plata by mono',
      description: 'Українські картки monobank та інших банків',
      icon: '💜',
      available: true
    }
  ]

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      {/* Plan Summary */}
      <Card className="border-2 border-primary-500">
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-xl">{selectedPlan.name}</CardTitle>
              <CardDescription>{selectedPlan.description}</CardDescription>
            </div>
            {selectedPlan.popular && (
              <div className="bg-primary-500 text-white px-3 py-1 rounded-full text-sm font-medium flex items-center space-x-1">
                <Star className="h-4 w-4" />
                <span>Популярний</span>
              </div>
            )}
          </div>
        </CardHeader>
        <CardContent>
          <div className="flex items-center justify-between">
            <div>
              <div className="text-3xl font-bold text-gray-900">
                {selectedPlan.price} {selectedPlan.currency}
              </div>
              <div className="text-gray-600">
                за {selectedPlan.duration_months} місяців
              </div>
            </div>
            <div className="text-right">
              <div className="text-sm text-gray-600">
                {Math.round(selectedPlan.price / selectedPlan.duration_months)} {selectedPlan.currency}/місяць
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Features */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Що включено</CardTitle>
        </CardHeader>
        <CardContent>
          <ul className="space-y-2">
            {selectedPlan.features.map((feature, index) => (
              <li key={index} className="flex items-center space-x-2">
                <CheckCircle className="h-5 w-5 text-success-500 flex-shrink-0" />
                <span className="text-gray-700">{feature}</span>
              </li>
            ))}
          </ul>
        </CardContent>
      </Card>

      {/* Payment Method Selection */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Спосіб оплати</CardTitle>
          <CardDescription>Оберіть зручний для вас спосіб оплати</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {paymentProviders.map((provider) => (
              <button
                key={provider.id}
                onClick={() => setPaymentMethod(provider.id as any)}
                disabled={!provider.available}
                className={`w-full p-4 rounded-lg border-2 transition-colors ${
                  paymentMethod === provider.id
                    ? 'border-primary-500 bg-primary-50'
                    : 'border-gray-200 hover:border-gray-300'
                } ${!provider.available ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'}`}
              >
                <div className="flex items-center space-x-3">
                  <div className="text-2xl">{provider.icon}</div>
                  <div className="flex-1 text-left">
                    <div className="font-medium text-gray-900">{provider.name}</div>
                    <div className="text-sm text-gray-600">{provider.description}</div>
                  </div>
                  <div className={`w-4 h-4 rounded-full border-2 ${
                    paymentMethod === provider.id
                      ? 'border-primary-500 bg-primary-500'
                      : 'border-gray-300'
                  }`}>
                    {paymentMethod === provider.id && (
                      <div className="w-full h-full rounded-full bg-white scale-50"></div>
                    )}
                  </div>
                </div>
              </button>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Security Notice */}
      <Card className="bg-gray-50">
        <CardContent className="p-4">
          <div className="flex items-center space-x-2 text-sm text-gray-600">
            <Shield className="h-4 w-4 text-success-500" />
            <span>
              Ваші платежі захищені SSL-шифруванням. Ми не зберігаємо дані ваших карток.
            </span>
          </div>
        </CardContent>
      </Card>

      {/* Error Message */}
      {error && (
        <Card className="border-error-200 bg-error-50">
          <CardContent className="p-4">
            <div className="flex items-center space-x-2 text-error-700">
              <AlertCircle className="h-4 w-4" />
              <span>{error}</span>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Action Buttons */}
      <div className="flex flex-col sm:flex-row gap-4">
        <Button
          onClick={onPaymentCancel}
          variant="outline"
          className="flex-1"
          disabled={isProcessing}
        >
          Скасувати
        </Button>
        <Button
          onClick={handlePayment}
          className="flex-1 btn-primary"
          disabled={isProcessing}
        >
          {isProcessing ? (
            <>
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              Обробка...
            </>
          ) : (
            <>
              <CreditCard className="h-4 w-4 mr-2" />
              Оплатити {selectedPlan.price} {selectedPlan.currency}
            </>
          )}
        </Button>
      </div>

      {/* Terms */}
      <div className="text-center text-sm text-gray-500">
        <p>
          Натискаючи "Оплатити", ви погоджуєтесь з{' '}
          <a href="/terms" className="text-primary-500 hover:underline">
            умовами використання
          </a>{' '}
          та{' '}
          <a href="/privacy" className="text-primary-500 hover:underline">
            політикою конфіденційності
          </a>
        </p>
      </div>
    </div>
  )
}
