'use client'

import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { XCircle, ArrowLeft, Home } from 'lucide-react'
import Link from 'next/link'

export default function PaymentCancelPage() {
  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-4">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <div className="bg-error-100 w-16 h-16 rounded-full flex items-center justify-center">
              <XCircle className="h-8 w-8 text-error-500" />
            </div>
          </div>
          <CardTitle className="text-2xl font-bold text-error-700">
            Оплата скасована
          </CardTitle>
          <CardDescription>
            Ви скасували процес оплати
          </CardDescription>
        </CardHeader>
        
        <CardContent className="space-y-6">
          <div className="bg-gray-50 p-4 rounded-lg">
            <h3 className="font-semibold text-gray-900 mb-2">Що далі?</h3>
            <div className="space-y-2 text-sm text-gray-600">
              <p>• Ви можете спробувати оплатити знову</p>
              <p>• Оберіть інший спосіб оплати</p>
              <p>• Зв'яжіться з нами для допомоги</p>
            </div>
          </div>

          <div className="space-y-3">
            <Button className="w-full btn-primary">
              <Link href="/payment">
                Спробувати знову
                <ArrowLeft className="h-4 w-4 ml-2" />
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
              Потрібна допомога?{' '}
              <a href="mailto:support@helpkrok.ua" className="text-primary-500 hover:underline">
                Зв'яжіться з нами
              </a>
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
