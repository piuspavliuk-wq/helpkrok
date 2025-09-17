'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { PaymentComponent } from '@/components/payment/PaymentComponent'
import { 
  CheckCircle, 
  Star,
  ArrowLeft,
  GraduationCap,
  Pill
} from 'lucide-react'

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

interface PlanSelectionProps {
  faculty?: 'medical' | 'pharmaceutical'
  onPlanSelect: (plan: PaymentPlan) => void
  onBack: () => void
}

export function PlanSelection({ faculty, onPlanSelect, onBack }: PlanSelectionProps) {
  const [selectedPlan, setSelectedPlan] = useState<PaymentPlan | null>(null)

  const plans: PaymentPlan[] = [
    {
      id: 'medical',
      name: 'Медичний факультет',
      type: 'medical',
      price: 1200,
      currency: 'UAH',
      duration_months: 12,
      description: 'Повний доступ до всіх матеріалів медичного факультету',
      features: [
        'Всі теми медичного факультету',
        'Відеолекції та конспекти',
        'Інтерактивні тести з правилом 80%',
        'Буклети за роками (2006-2025)',
        'КРОК симуляція',
        'Детальна аналітика прогресу',
        'Email підтримка'
      ],
      popular: true
    },
    {
      id: 'pharmaceutical',
      name: 'Фармацевтичний факультет',
      type: 'pharmaceutical',
      price: 1000,
      currency: 'UAH',
      duration_months: 12,
      description: 'Повний доступ до всіх матеріалів фармацевтичного факультету',
      features: [
        'Всі теми фармацевтичного факультету',
        'Відеолекції та конспекти',
        'Інтерактивні тести з правилом 80%',
        'Буклети за роками (2006-2025)',
        'КРОК симуляція',
        'Детальна аналітика прогресу',
        'Email підтримка'
      ]
    },
    {
      id: 'premium',
      name: 'Преміум',
      type: 'premium',
      price: 1800,
      currency: 'UAH',
      duration_months: 12,
      description: 'Доступ до всіх матеріалів обох факультетів',
      features: [
        'Обидва факультети (медичний + фармацевтичний)',
        'Всі відеолекції та конспекти',
        'Повний архів тестів',
        'КРОК симуляція',
        'Пріоритетна підтримка',
        'Розширена аналітика',
        'Ексклюзивні матеріали',
        'Персональний менеджер'
      ],
      popular: true
    }
  ]

  const filteredPlans = faculty 
    ? plans.filter(plan => plan.type === faculty || plan.type === 'premium')
    : plans

  const getFacultyIcon = (planType: string) => {
    switch (planType) {
      case 'medical':
        return <GraduationCap className="h-6 w-6 text-primary-500" />
      case 'pharmaceutical':
        return <Pill className="h-6 w-6 text-primary-500" />
      case 'premium':
        return <Star className="h-6 w-6 text-primary-500" />
      default:
        return <GraduationCap className="h-6 w-6 text-primary-500" />
    }
  }

  if (selectedPlan) {
    return (
      <div className="space-y-6">
        <Button
          onClick={() => setSelectedPlan(null)}
          variant="outline"
          className="mb-4"
        >
          <ArrowLeft className="h-4 w-4 mr-2" />
          Назад до планів
        </Button>
        
        <PaymentComponent
          selectedPlan={selectedPlan}
          onPaymentSuccess={(subscription) => {
            // Обробка успішної оплати
            console.log('Payment successful:', subscription)
          }}
          onPaymentCancel={() => setSelectedPlan(null)}
        />
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="text-center">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">
          Оберіть план підписки
        </h1>
        <p className="text-gray-600 text-lg">
          {faculty 
            ? `Спеціальні пропозиції для ${faculty === 'medical' ? 'медичного' : 'фармацевтичного'} факультету`
            : 'Оберіть план, який найкраще підходить для вашого навчання'
          }
        </p>
      </div>

      {/* Plans Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredPlans.map((plan) => (
          <div 
            key={plan.id} 
            className={`relative cursor-pointer transition-all duration-200 ${
              plan.popular 
                ? 'border-2 border-primary-500 shadow-medium' 
                : 'hover:shadow-medium'
            }`}
            onClick={() => setSelectedPlan(plan)}
          >
            <Card>
              {plan.popular && (
                <div className="absolute -top-4 left-1/2 transform -translate-x-1/2">
                  <div className="bg-primary-500 text-white px-4 py-1 rounded-full text-sm font-medium flex items-center space-x-1">
                    <Star className="h-4 w-4" />
                    <span>Популярний</span>
                  </div>
                </div>
              )}

              <CardHeader className="text-center">
              <div className="flex justify-center mb-4">
                <div className="bg-primary-100 p-3 rounded-full">
                  {getFacultyIcon(plan.type)}
                </div>
              </div>
              <CardTitle className="text-xl">{plan.name}</CardTitle>
              <CardDescription>{plan.description}</CardDescription>
            </CardHeader>

            <CardContent className="space-y-6">
              {/* Price */}
              <div className="text-center">
                <div className="text-4xl font-bold text-gray-900 mb-2">
                  {plan.price} {plan.currency}
                </div>
                <div className="text-gray-600">
                  за {plan.duration_months} місяців
                </div>
                <div className="text-sm text-gray-500 mt-1">
                  {Math.round(plan.price / plan.duration_months)} {plan.currency}/місяць
                </div>
              </div>

              {/* Features */}
              <div>
                <h4 className="font-semibold text-gray-900 mb-3">Що включено:</h4>
                <ul className="space-y-2">
                  {plan.features.map((feature, index) => (
                    <li key={index} className="flex items-start space-x-2">
                      <CheckCircle className="h-4 w-4 text-success-500 flex-shrink-0 mt-0.5" />
                      <span className="text-sm text-gray-700">{feature}</span>
                    </li>
                  ))}
                </ul>
              </div>

              {/* CTA Button */}
              <Button 
                className={`w-full ${
                  plan.popular ? 'btn-primary' : 'btn-outline'
                }`}
                onClick={() => setSelectedPlan(plan)}
              >
                Обрати план
              </Button>
            </CardContent>
            </Card>
          </div>
        ))}
      </div>

      {/* Free Trial Notice */}
      <Card className="bg-gray-50">
        <CardContent className="p-6 text-center">
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Спробуйте безкоштовно
          </h3>
          <p className="text-gray-600 mb-4">
            Отримайте доступ до 3 тем безкоштовно, щоб ознайомитися з платформою
          </p>
          <Button
            onClick={onBack}
            variant="outline"
          >
            Почати безкоштовно
          </Button>
        </CardContent>
      </Card>

      {/* Security Notice */}
      <div className="text-center text-sm text-gray-500">
        <p>
          Всі платежі захищені SSL-шифруванням. 
          Гарантуємо повернення коштів протягом 7 днів.
        </p>
      </div>
    </div>
  )
}
