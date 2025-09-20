'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useSession } from 'next-auth/react';
import { BookmarkCheck, Trash2, Loader2 } from 'lucide-react';

interface SavedQuestion {
  id: string;
  user_id: string;
  question_type: string;
  question_id: number;
  notes: string | null;
  saved_at: string;
}

interface QuestionData {
  id: number;
  question_text: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  option_e: string;
  correct_answer: string;
}

export default function SavedQuestionsView() {
  const { data: session } = useSession();
  const [savedQuestions, setSavedQuestions] = useState<SavedQuestion[]>([]);
  const [questionsData, setQuestionsData] = useState<Record<string, QuestionData>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [removingQuestion, setRemovingQuestion] = useState<string | null>(null);

  useEffect(() => {
    if (session?.user?.id) {
      loadSavedQuestions();
    }
  }, [session?.user?.id]);

  const loadSavedQuestions = async () => {
    try {
      setIsLoading(true);
      
      // Завантажуємо всі збережені питання з універсальної таблиці
      const response = await fetch('/api/saved-questions');
      
      if (response.ok) {
        const data = await response.json();
        const savedQuestions = data.savedQuestions || [];
        
        // Завантажуємо дані питань для кожного типу
        const questionsData: Record<string, QuestionData> = {};
        
        // Групуємо питання по типах
        const questionsByType: Record<string, number[]> = {};
        savedQuestions.forEach((sq: SavedQuestion) => {
          if (!questionsByType[sq.question_type]) {
            questionsByType[sq.question_type] = [];
          }
          questionsByType[sq.question_type].push(sq.question_id);
        });
        
        // Завантажуємо дані питань для кожного типу
        for (const [questionType, questionIds] of Object.entries(questionsByType)) {
          try {
            const questionsResponse = await fetch(`/api/${questionType}/questions`);
            if (questionsResponse.ok) {
              const questionsDataResponse = await questionsResponse.json();
              const questions = questionsDataResponse.questions || [];
              
              // Додаємо дані питань до загального об'єкту
              questions.forEach((question: QuestionData) => {
                if (questionIds.includes(question.id)) {
                  questionsData[`${questionType}_${question.id}`] = question;
                }
              });
            }
          } catch (error) {
            console.error(`Помилка завантаження питань ${questionType}:`, error);
          }
        }
        
        setSavedQuestions(savedQuestions);
        setQuestionsData(questionsData);
      }
      
    } catch (error) {
      console.error('Помилка завантаження збережених питань:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const removeSavedQuestion = async (questionId: number, questionType: string) => {
    setRemovingQuestion(`${questionType}_${questionId}`);
    
    try {
      const response = await fetch(`/api/saved-questions?type=${questionType}&questionId=${questionId}`, {
        method: 'DELETE',
      });

      if (response.ok) {
        // Оновлюємо список збережених питань
        setSavedQuestions(prev => 
          prev.filter(sq => !(sq.question_type === questionType && sq.question_id === questionId))
        );
        
        // Видаляємо дані питання
        setQuestionsData(prev => {
          const newData = { ...prev };
          delete newData[`${questionType}_${questionId}`];
          return newData;
        });
      } else {
        console.error('Помилка видалення питання');
      }
    } catch (error) {
      console.error('Помилка видалення питання:', error);
    } finally {
      setRemovingQuestion(null);
    }
  };

  const getQuestionData = (savedQuestion: SavedQuestion): QuestionData | null => {
    return questionsData[`${savedQuestion.question_type}_${savedQuestion.question_id}`] || null;
  };

  const getQuestionTypeLabel = (questionType: string): string => {
    const labels: Record<string, string> = {
      'anatomy': 'Анатомія',
      'histology': 'Гістологія',
      'krok': 'Крок',
      'biology': 'Біологія',
      'biochemistry': 'Біохімія',
      'microbiology': 'Мікробіологія',
      'pathophysiology': 'Патофізіологія',
      'pharmacology': 'Фармакологія',
      'pathology': 'Патологія'
    };
    return labels[questionType] || questionType;
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження збережених питань...</p>
        </div>
      </div>
    );
  }

  if (!session?.user?.id) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100 flex items-center justify-center">
        <Card className="max-w-md mx-auto">
          <CardContent className="p-6 text-center">
            <p className="text-gray-600">Будь ласка, увійдіть в систему, щоб переглянути збережені питання.</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-25 to-blue-100 p-4">
      <div className="max-w-4xl mx-auto">
        <Card className="mb-6">
          <CardHeader className="text-center">
            <CardTitle className="text-2xl font-bold text-blue-700 flex items-center justify-center">
              <BookmarkCheck className="mr-2 h-6 w-6" />
              💾 Збережені питання ({savedQuestions.length})
            </CardTitle>
            <div className="text-center text-gray-600">
              Питання, які ви зберегли для подальшого повторення
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {savedQuestions.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-600 text-lg">У вас поки немає збережених питань.</p>
                <p className="text-gray-500 mt-2">Перейдіть до тестів і збережіть питання для повторення.</p>
              </div>
            ) : (
              savedQuestions.map((savedQuestion, index) => {
                const questionData = getQuestionData(savedQuestion);
                
                if (!questionData) {
                  return (
                    <div key={savedQuestion.id} className="border rounded-lg p-6 bg-gray-50">
                      <div className="flex items-center justify-between">
                        <div>
                          <h3 className="text-lg font-semibold text-gray-800">
                            {getQuestionTypeLabel(savedQuestion.question_type)} #{savedQuestion.question_id}
                          </h3>
                          <p className="text-gray-600">Завантаження даних питання...</p>
                        </div>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => removeSavedQuestion(savedQuestion.question_id, savedQuestion.question_type)}
                          disabled={removingQuestion === `${savedQuestion.question_type}_${savedQuestion.question_id}`}
                          className="text-red-600 hover:text-red-700"
                        >
                          {removingQuestion === `${savedQuestion.question_type}_${savedQuestion.question_id}` ? (
                            <Loader2 className="h-4 w-4 animate-spin" />
                          ) : (
                            <Trash2 className="h-4 w-4" />
                          )}
                        </Button>
                      </div>
                    </div>
                  );
                }

                return (
                  <div key={savedQuestion.id} className="border rounded-lg p-6 bg-gray-50">
                    <div className="flex items-start justify-between mb-4">
                      <div className="flex-1">
                        <div className="flex items-center space-x-3 mb-2">
                          <h3 className="text-lg font-semibold text-gray-800">
                            {getQuestionTypeLabel(savedQuestion.question_type)} #{savedQuestion.question_id}
                          </h3>
                          <span className="px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded">
                            {getQuestionTypeLabel(savedQuestion.question_type)}
                          </span>
                        </div>
                        <p className="text-gray-700 mb-3">{questionData.question_text}</p>
                        
                        <div className="space-y-2">
                          {['A', 'B', 'C', 'D', 'E'].map((option) => {
                            const optionText = questionData[`option_${option.toLowerCase()}` as keyof QuestionData] as string;
                            const isCorrect = questionData.correct_answer === option;
                            
                            return (
                              <div
                                key={option}
                                className={`p-2 rounded text-sm ${
                                  isCorrect 
                                    ? 'bg-green-100 text-green-800 border border-green-300' 
                                    : 'bg-gray-100 text-gray-700'
                                }`}
                              >
                                <span className="font-medium">{option}.</span> {optionText}
                                {isCorrect && <span className="ml-2 text-green-600 font-semibold">✓ Правильна відповідь</span>}
                              </div>
                            );
                          })}
                        </div>
                        
                        {savedQuestion.notes && (
                          <div className="mt-3 p-3 bg-yellow-50 border border-yellow-200 rounded">
                            <p className="text-sm text-yellow-800">
                              <span className="font-medium">Примітки:</span> {savedQuestion.notes}
                            </p>
                          </div>
                        )}
                        
                        <div className="mt-3 text-xs text-gray-500">
                          Збережено: {new Date(savedQuestion.saved_at).toLocaleString('uk-UA')}
                        </div>
                      </div>
                      
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => removeSavedQuestion(savedQuestion.question_id, savedQuestion.question_type)}
                        disabled={removingQuestion === `${savedQuestion.question_type}_${savedQuestion.question_id}`}
                        className="text-red-600 hover:text-red-700 ml-4"
                      >
                        {removingQuestion === `${savedQuestion.question_type}_${savedQuestion.question_id}` ? (
                          <Loader2 className="h-4 w-4 animate-spin" />
                        ) : (
                          <Trash2 className="h-4 w-4" />
                        )}
                      </Button>
                    </div>
                  </div>
                );
              })
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}