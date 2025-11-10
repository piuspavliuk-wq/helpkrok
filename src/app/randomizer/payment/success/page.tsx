'use client'

import { useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { CheckCircle, Loader2, ArrowRight } from 'lucide-react'
import Link from 'next/link'
import AuthGuard from '@/components/auth/AuthGuard'

export default function PaymentSuccessPage() {
  const [isLoading, setIsLoading] = useState(true)
  const router = useRouter()

  useEffect(() => {
    // Даємо час на обробку webhook
    const timer = setTimeout(() => {
      setIsLoading(false)
    }, 3000)

    return () => clearTimeout(timer)
  }, [])

  return (
    <AuthGuard>
      <div className="min-h-screen bg-gradient-to-br from-green-50 via-blue-50 to-blue-100 flex items-center justify-center px-4">
        <Card className="max-w-md w-full">
          <CardHeader className="text-center">
            {isLoading ? (
              <>
                <div className="mx-auto mb-4">
                  <Loader2 className="h-16 w-16 text-blue-600 animate-spin" />
                </div>
                <CardTitle className="text-2xl">Обробка платежу...</CardTitle>
                <CardDescription>
                  Будь ласка, зачекайте. Ми обробляємо ваш платіж.
                </CardDescription>
              </>
            ) : (
              <>
                <div className="mx-auto mb-4 bg-green-100 rounded-full p-4">
                  <CheckCircle className="h-16 w-16 text-green-600" />
                </div>
                <CardTitle className="text-2xl text-green-600">
                  Оплата успішна!
                </CardTitle>
                <CardDescription>
                  Дякуємо за покупку Randomizer PRO
                </CardDescription>
              </>
            )}
          </CardHeader>

          {!isLoading && (
            <CardContent className="space-y-4">
              <div className="bg-blue-50 p-4 rounded-lg space-y-2 text-sm">
                <p className="text-blue-900">
                  ✅ Спроби успішно додані до вашого профілю
                </p>
                <p className="text-blue-900">
                  ✅ Ви можете розпочати проходження тестів прямо зараз
                </p>
                <p className="text-blue-900">
                  ✅ Спроби не мають терміну дії
                </p>
              </div>

              <div className="space-y-2">
                <Link href="/randomizer/settings" className="block">
                  <Button className="w-full bg-blue-600 hover:bg-blue-700">
                    Перейти до Randomizer
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Button>
                </Link>
                
                <Link href="/dashboard" className="block">
                  <Button variant="outline" className="w-full">
                    На головну
                  </Button>
                </Link>
              </div>

              <p className="text-xs text-center text-gray-600">
                Деталі платежу надіслані на вашу електронну пошту
              </p>
            </CardContent>
          )}
        </Card>
      </div>
    </AuthGuard>
  )
}

