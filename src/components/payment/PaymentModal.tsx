'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Loader2, CreditCard, QrCode, ExternalLink, CheckCircle2, XCircle } from 'lucide-react'
import { Alert, AlertDescription } from '@/components/ui/alert'

interface PaymentModalProps {
  isOpen: boolean
  onClose: () => void
  packageId: string
  packageName: string
  packagePrice: number
  packageAttempts: number
}

export default function PaymentModal({
  isOpen,
  onClose,
  packageId,
  packageName,
  packagePrice,
  packageAttempts
}: PaymentModalProps) {
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [paymentUrl, setPaymentUrl] = useState<string | null>(null)
  const [qrCodeData, setQrCodeData] = useState<string | null>(null)

  const handlePayment = async () => {
    setIsLoading(true)
    setError(null)

    try {
      const response = await fetch('/api/payments/mono/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          packageId
        })
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Помилка створення платежу')
      }

      if (data.pageUrl) {
        setPaymentUrl(data.pageUrl)
        setQrCodeData(data.qrCodeData)
        
        // Відкриваємо сторінку оплати в новому вікні
        window.open(data.pageUrl, '_blank')
      }

    } catch (err) {
      console.error('Помилка оплати:', err)
      setError(err instanceof Error ? err.message : 'Невідома помилка')
    } finally {
      setIsLoading(false)
    }
  }

  const handleClose = () => {
    setPaymentUrl(null)
    setQrCodeData(null)
    setError(null)
    onClose()
  }

  return (
    <Dialog open={isOpen} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Оплата {packageName}</DialogTitle>
          <DialogDescription>
            {packageAttempts} {packageAttempts === 1 ? 'спроба' : 'спроб'} • {packagePrice} ₴
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          {error && (
            <Alert variant="destructive">
              <XCircle className="h-4 w-4" />
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          )}

          {!paymentUrl && !error && (
            <div className="space-y-4">
              <div className="bg-blue-50 p-4 rounded-lg space-y-2">
                <div className="flex items-start space-x-2">
                  <CheckCircle2 className="h-5 w-5 text-blue-600 mt-0.5 flex-shrink-0" />
                  <div className="text-sm text-blue-900">
                    <p className="font-medium">Безпечна оплата через Monobank</p>
                    <p className="text-blue-700 mt-1">
                      Ви будете перенаправлені на захищену сторінку оплати
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-50 p-4 rounded-lg space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-gray-600">Пакет:</span>
                  <span className="font-medium">{packageName}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-gray-600">Кількість спроб:</span>
                  <span className="font-medium">{packageAttempts}</span>
                </div>
                <div className="border-t border-gray-200 pt-2 mt-2">
                  <div className="flex justify-between">
                    <span className="font-medium">Всього до оплати:</span>
                    <span className="text-lg font-bold text-blue-600">{packagePrice} ₴</span>
                  </div>
                </div>
              </div>

              <Button
                onClick={handlePayment}
                disabled={isLoading}
                className="w-full bg-blue-600 hover:bg-blue-700"
              >
                {isLoading ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Створення платежу...
                  </>
                ) : (
                  <>
                    <CreditCard className="mr-2 h-4 w-4" />
                    Перейти до оплати
                  </>
                )}
              </Button>
            </div>
          )}

          {paymentUrl && (
            <div className="space-y-4">
              <Alert>
                <CheckCircle2 className="h-4 w-4" />
                <AlertDescription>
                  Платіжна сторінка відкрита в новому вікні. Якщо вікно не відкрилося, скористайтеся кнопкою нижче.
                </AlertDescription>
              </Alert>

              <Button
                onClick={() => window.open(paymentUrl, '_blank')}
                className="w-full"
                variant="outline"
              >
                <ExternalLink className="mr-2 h-4 w-4" />
                Відкрити сторінку оплати
              </Button>

              <div className="text-center">
                <p className="text-sm text-gray-600 mb-3">
                  Або відскануйте QR-код для оплати через додаток Monobank:
                </p>
                {qrCodeData && (
                  <div className="flex justify-center">
                    <div className="bg-white p-4 rounded-lg border-2 border-gray-200">
                      <img 
                        src={`https://api.monobank.ua/api/merchant/qr/${qrCodeData}`}
                        alt="QR код для оплати"
                        className="w-48 h-48"
                      />
                    </div>
                  </div>
                )}
              </div>

              <div className="bg-yellow-50 p-3 rounded-lg">
                <p className="text-sm text-yellow-800">
                  💡 Після успішної оплати спроби автоматично з&apos;являться у вашому профілі
                </p>
              </div>

              <Button
                onClick={handleClose}
                variant="outline"
                className="w-full"
              >
                Закрити
              </Button>
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  )
}

