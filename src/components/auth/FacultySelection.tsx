'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { GraduationCap, Stethoscope, Pill } from 'lucide-react'

interface FacultySelectionProps {
  onFacultySelect: (faculty: 'medical' | 'pharmaceutical') => void
  onSkip: () => void
}

export function FacultySelection({ onFacultySelect, onSkip }: FacultySelectionProps) {
  const [selectedFaculty, setSelectedFaculty] = useState<'medical' | 'pharmaceutical' | null>(null)

  const handleContinue = () => {
    if (selectedFaculty) {
      onFacultySelect(selectedFaculty)
    }
  }

  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-4">
      <Card className="w-full max-w-2xl">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center">
              <GraduationCap className="h-8 w-8 text-primary-500" />
            </div>
          </div>
          <CardTitle className="text-2xl font-bold">Оберіть ваш факультет</CardTitle>
          <CardDescription>
            Це допоможе нам налаштувати особистий план навчання для вас
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Medical Faculty */}
            <div 
              className={`cursor-pointer transition-all duration-200 ${
                selectedFaculty === 'medical' 
                  ? 'ring-2 ring-primary-500 bg-primary-50' 
                  : 'hover:shadow-medium'
              }`}
              onClick={() => setSelectedFaculty('medical')}
            >
              <div className="p-6 text-center">
                <div className="bg-primary-100 w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Stethoscope className="h-6 w-6 text-primary-500" />
                </div>
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  Медичний факультет
                </h3>
                <p className="text-gray-600 text-sm">
                  Підготовка до КРОК для студентів медичного факультету
                </p>
                <div className="mt-4 text-primary-500 font-medium">
                  1200 ₴/рік
                </div>
              </div>
            </div>

            {/* Pharmaceutical Faculty */}
            <div 
              className={`cursor-pointer transition-all duration-200 ${
                selectedFaculty === 'pharmaceutical' 
                  ? 'ring-2 ring-primary-500 bg-primary-50' 
                  : 'hover:shadow-medium'
              }`}
              onClick={() => setSelectedFaculty('pharmaceutical')}
            >
              <div className="p-6 text-center">
                <div className="bg-primary-100 w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Pill className="h-6 w-6 text-primary-500" />
                </div>
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  Фармацевтичний факультет
                </h3>
                <p className="text-gray-600 text-sm">
                  Підготовка до КРОК для студентів фармацевтичного факультету
                </p>
                <div className="mt-4 text-primary-500 font-medium">
                  1000 ₴/рік
                </div>
              </div>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-4">
            <Button
              onClick={handleContinue}
              disabled={!selectedFaculty}
              className="flex-1 btn-primary"
            >
              Продовжити
            </Button>
            <Button
              onClick={onSkip}
              variant="outline"
              className="flex-1"
            >
              Пропустити зараз
            </Button>
          </div>

          <div className="text-sm text-gray-600 text-center">
            <p>Ви зможете змінити факультет пізніше в налаштуваннях</p>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
