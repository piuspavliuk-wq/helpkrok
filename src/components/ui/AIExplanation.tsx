'use client';

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Loader2, Brain, Lightbulb } from 'lucide-react';

interface AIExplanationProps {
  questionText: string;
  selectedAnswer?: string;
  correctAnswer: string;
  options: Array<{ key: string; text: string }>;
  onClose: () => void;
}

export default function AIExplanation({ 
  questionText, 
  selectedAnswer, 
  correctAnswer, 
  options, 
  onClose 
}: AIExplanationProps) {
  const [explanation, setExplanation] = useState<string>('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string>('');

  const generateExplanation = async () => {
    setIsLoading(true);
    setError('');

    try {
      const response = await fetch('/api/ai/explanation', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          questionText,
          selectedAnswer,
          correctAnswer,
          options
        })
      });

      const data = await response.json();

      if (data.success) {
        setExplanation(data.explanation);
      } else {
        // Спеціальна обробка помилки 429 (Quota exceeded)
        if (response.status === 429 || data.errorCode === 429) {
          setError(
            `⚠️ Досягнуто ліміт безкоштовного тарифу Google Gemini API.\n\n` +
            `Квоти відновлюються щодня або щомісяця (залежить від типу квоти).\n\n` +
            `Що можна зробити:\n` +
            `• Зачекати до наступного дня/місяця\n` +
            `• Перевірити статус квот: https://ai.dev/usage\n` +
            `• Перейти на платний план:\n` +
            `  → https://console.cloud.google.com/billing\n` +
            `  → Підключити білінг до проекту\n` +
            `  → Або створити новий проект з білінгом\n\n` +
            `${data.suggestion || ''}`
          );
        } else {
          setError(data.error || 'Помилка отримання пояснення');
        }
      }
    } catch (error) {
      setError('Помилка з\'єднання з сервером');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <Card className="w-full max-w-4xl max-h-[90vh] overflow-hidden">
        <CardHeader className="bg-gradient-to-r from-blue-500 to-purple-600 text-white">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <Brain className="w-6 h-6" />
              <CardTitle className="text-xl">AI Пояснення</CardTitle>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={onClose}
              className="text-white hover:bg-white hover:bg-opacity-20"
            >
              ✕
            </Button>
          </div>
        </CardHeader>
        
        <CardContent className="p-6 overflow-y-auto max-h-[calc(90vh-120px)]">
          {!explanation && !isLoading && !error && (
            <div className="text-center py-8">
              <Lightbulb className="w-16 h-16 text-yellow-500 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-gray-800 mb-2">
                Отримати пояснення від AI
              </h3>
              <p className="text-gray-600 mb-6">
                AI надасть детальне пояснення питання з анатомії, включаючи правильну відповідь та додаткову інформацію.
              </p>
              <Button 
                onClick={generateExplanation}
                className="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white px-6 py-2"
              >
                <Brain className="w-4 h-4 mr-2" />
                Згенерувати пояснення
              </Button>
            </div>
          )}

          {isLoading && (
            <div className="text-center py-8">
              <Loader2 className="w-12 h-12 text-blue-500 animate-spin mx-auto mb-4" />
              <p className="text-gray-600">AI генерує пояснення...</p>
              <p className="text-sm text-gray-500 mt-2">Це може зайняти кілька секунд</p>
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-4">
              <div className="flex items-center">
                <div className="text-red-600 mr-2">⚠️</div>
                <div>
                  <h4 className="font-semibold text-red-800">Помилка</h4>
                  <p className="text-red-700">{error}</p>
                </div>
              </div>
              <Button 
                onClick={generateExplanation}
                className="mt-3 bg-red-600 hover:bg-red-700 text-white"
                size="sm"
              >
                Спробувати знову
              </Button>
            </div>
          )}

          {explanation && (
            <div className="space-y-4">
              <div className="bg-green-50 border border-green-200 rounded-lg p-4">
                <div className="flex items-center mb-2">
                  <Brain className="w-5 h-5 text-green-600 mr-2" />
                  <h4 className="font-semibold text-green-800">AI Пояснення</h4>
                </div>
                <div className="prose prose-sm max-w-none">
                  <div className="whitespace-pre-wrap text-gray-700 leading-relaxed">
                    {explanation}
                  </div>
                </div>
              </div>
              
              <div className="flex justify-center space-x-3">
                <Button 
                  onClick={generateExplanation}
                  variant="outline"
                  size="sm"
                >
                  <Brain className="w-4 h-4 mr-2" />
                  Згенерувати нове пояснення
                </Button>
                <Button 
                  onClick={onClose}
                  className="bg-blue-600 hover:bg-blue-700 text-white"
                >
                  Закрити
                </Button>
              </div>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
