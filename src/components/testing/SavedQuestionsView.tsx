'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useSession } from 'next-auth/react';
import { BookmarkCheck, Trash2, Loader2, MoreVertical, Play } from 'lucide-react';
import ConfirmationModal from '@/components/ui/confirmation-modal';
import ContextMenu from '@/components/ui/context-menu';

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
  option_a?: string;
  option_b?: string;
  option_c?: string;
  option_d?: string;
  option_e?: string;
  correct_answer?: string;
  options?: Array<{
    letter: string;
    text: string;
    is_correct: boolean;
  }>;
}

export default function SavedQuestionsView() {
  const { data: session } = useSession();
  const [savedQuestions, setSavedQuestions] = useState<SavedQuestion[]>([]);
  const [questionsData, setQuestionsData] = useState<Record<string, QuestionData>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [removingQuestion, setRemovingQuestion] = useState<string | null>(null);
  const [confirmationModal, setConfirmationModal] = useState<{
    isOpen: boolean;
    questionId: number | null;
    questionType: string | null;
    questionText: string | null;
  }>({
    isOpen: false,
    questionId: null,
    questionType: null,
    questionText: null
  });
  
  // Стан для контекстного меню
  const [contextMenu, setContextMenu] = useState<{
    isOpen: boolean;
    position: { x: number; y: number };
  }>({
    isOpen: false,
    position: { x: 0, y: 0 }
  });
  
  // Опції відображення
  const [showAnswers, setShowAnswers] = useState(true);
  
  // Стан для інтерактивних відповідей
  const [selectedAnswers, setSelectedAnswers] = useState<{[key: string]: string}>({});

  useEffect(() => {
    // Завантажуємо збережені питання тільки для авторизованих користувачів
    if (session?.user?.id) {
      loadSavedQuestions();
    }
  }, [session?.user?.id]);

  const loadSavedQuestions = async () => {
    try {
      setIsLoading(true);
      console.log('Початок завантаження збережених питань...');
      
      // Завантажуємо збережені питання поточного користувача
      if (!session?.user?.id) {
        console.log('Користувач не авторизований, пропускаємо завантаження збережених питань');
        setIsLoading(false);
        return;
      }
      
      console.log('Fetching from /api/saved-questions for user:', session.user.id);
      const response = await fetch('/api/saved-questions');
      console.log('Response status:', response.status);
      
      // Також завантажуємо КРОК питання
      console.log('Fetching from /api/krok/saved for user:', session.user.id);
      const krokResponse = await fetch('/api/krok/saved');
      console.log('KROK response status:', krokResponse.status);
      
      let savedQuestions = [];
      let krokQuestions = [];
      
      if (response.ok) {
        const data = await response.json();
        savedQuestions = data.savedQuestions || [];
        console.log('Отримано збережені питання:', savedQuestions);
      }
      
      if (krokResponse.ok) {
        const krokData = await krokResponse.json();
        krokQuestions = krokData.savedQuestions || [];
        console.log('Отримано КРОК питання:', krokQuestions);
        
        // Додаємо question_type для КРОК питань
        krokQuestions = krokQuestions.map((q: any) => ({
          ...q,
          question_type: 'krok'
        }));
      }
      
      // Об'єднуємо всі збережені питання
      const allSavedQuestions = [...savedQuestions, ...krokQuestions];
      console.log('Всі збережені питання:', allSavedQuestions);
        
        // Завантажуємо дані питань для кожного типу
        const questionsData: Record<string, QuestionData> = {};
        
        // Групуємо питання по типах
        const questionsByType: Record<string, number[]> = {};
        allSavedQuestions.forEach((sq: SavedQuestion) => {
          // Для КРОК питань використовуємо 'krok' як тип
          const questionType = sq.question_type || 'krok';
          if (!questionsByType[questionType]) {
            questionsByType[questionType] = [];
          }
          questionsByType[questionType].push(sq.question_id);
        });
        
        // Завантажуємо дані питань для кожного типу
        for (const [questionType, questionIds] of Object.entries(questionsByType)) {
          try {
            console.log(`Завантаження питань типу ${questionType} з ID:`, questionIds);
            let questionsResponse;
            if (questionType === 'krok') {
              // Для КРОК використовуємо оптимізований API з конкретними ID
              const idsParam = questionIds.join(',');
              questionsResponse = await fetch(`/api/krok/questions-by-ids?ids=${idsParam}`);
            } else if (questionType === 'pharmaceutical') {
              // Для фармації використовуємо pharmaceutical API
              const idsParam = questionIds.join(',');
              questionsResponse = await fetch(`/api/pharmaceutical/questions-by-ids?ids=${idsParam}&subject=analytical_chemistry`);
            } else {
              // Для інших предметів спочатку пробуємо оптимізований API
              const idsParam = questionIds.join(',');
              questionsResponse = await fetch(`/api/${questionType}/questions-by-ids?ids=${idsParam}`);
              
              // Якщо оптимізований API не існує, використовуємо старий
              if (!questionsResponse.ok && questionsResponse.status === 404) {
                console.log(`Optimized API for ${questionType} not found, using fallback`);
                questionsResponse = await fetch(`/api/${questionType}/questions`);
              }
            }
            
            if (questionsResponse.ok) {
              const questionsDataResponse = await questionsResponse.json();
              const questions = questionsDataResponse.questions || [];
              console.log(`Отримано ${questions.length} питань типу ${questionType}`);
              
              // Додаємо дані питань до загального об'єкту
              questions.forEach((question: QuestionData) => {
                if (questionIds.includes(question.id)) {
                  const key = `${questionType}_${question.id}`;
                  if (questionsData[key]) {
                    console.warn(`Ключ ${key} вже існує! Перезаписуємо...`);
                  }
                  questionsData[key] = question;
                  console.log(`Додано питання ${key}:`, question);
                }
              });
            } else {
              console.error(`Помилка API для ${questionType}:`, questionsResponse.status);
            }
          } catch (error) {
            console.error(`Помилка завантаження питань ${questionType}:`, error);
          }
        }
        
        setSavedQuestions(allSavedQuestions);
        setQuestionsData(questionsData);
      
    } catch (error) {
      console.error('Помилка завантаження збережених питань:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleDeleteClick = (questionId: number, questionType: string) => {
    const questionData = questionsData[`${questionType}_${questionId}`];
    const questionText = questionData?.question_text || `Питання #${questionId}`;
    
    setConfirmationModal({
      isOpen: true,
      questionId,
      questionType,
      questionText
    });
  };

  const handleConfirmDelete = async () => {
    // Перевіряємо, чи це видалення всіх питань
    if (confirmationModal.questionId === null && confirmationModal.questionType === null) {
      // Видаляємо всі збережені питання
      setRemovingQuestion('all');
      
      try {
        const response = await fetch('/api/saved-questions?deleteAll=true', {
          method: 'DELETE',
        });

        if (response.ok) {
          // Очищуємо всі дані
          setSavedQuestions([]);
          setQuestionsData({});
          
          // Закриваємо модальне вікно
          setConfirmationModal({
            isOpen: false,
            questionId: null,
            questionType: null,
            questionText: null
          });
        } else {
          console.error('Помилка видалення всіх питань');
        }
      } catch (error) {
        console.error('Помилка видалення всіх питань:', error);
      } finally {
        setRemovingQuestion(null);
      }
      return;
    }

    // Звичайна логіка видалення одного питання
    if (!confirmationModal.questionId || !confirmationModal.questionType) return;
    
    const { questionId, questionType } = confirmationModal;
    setRemovingQuestion(`${questionType}_${questionId}`);
    
    try {
      // Знаходимо ID запису в таблиці збережених питань
      const savedQuestion = savedQuestions.find(sq => 
        sq.question_id === questionId && sq.question_type === questionType
      );
      
      if (!savedQuestion) {
        console.error('Saved question not found');
        return;
      }
      
      console.log('Removing saved question:', {
        questionId,
        questionType,
        savedQuestionId: savedQuestion.id
      });
      
      // Використовуємо правильний API endpoint для видалення
      let response;
      if (questionType === 'krok') {
        // Для КРОК питань використовуємо /api/krok/saved
        response = await fetch(`/api/krok/saved?questionId=${questionId}`, {
          method: 'DELETE',
        });
      } else {
        // Для інших типів використовуємо /api/{type}/saved з savedQuestionId
        response = await fetch(`/api/${questionType}/saved?questionId=${questionId}&savedQuestionId=${savedQuestion.id}`, {
          method: 'DELETE',
        });
      }

      if (response.ok) {
        // Оновлюємо список збережених питань
        setSavedQuestions(prev => 
          prev.filter(sq => sq.id !== savedQuestion.id)
        );
        
        // Видаляємо дані питання
        setQuestionsData(prev => {
          const newData = { ...prev };
          delete newData[`${questionType}_${questionId}`];
          return newData;
        });
        
        // Закриваємо модальне вікно
        setConfirmationModal({
          isOpen: false,
          questionId: null,
          questionType: null,
          questionText: null
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

  const handleCancelDelete = () => {
    setConfirmationModal({
      isOpen: false,
      questionId: null,
      questionType: null,
      questionText: null
    });
  };

  // Функції для контекстного меню
  const handleContextMenuClick = (event: React.MouseEvent) => {
    event.preventDefault();
    event.stopPropagation();
    
    setContextMenu({
      isOpen: true,
      position: { x: event.clientX, y: event.clientY }
    });
  };

  const handleCloseContextMenu = () => {
    setContextMenu({
      isOpen: false,
      position: { x: 0, y: 0 }
    });
  };

  const handleToggleShowAnswers = () => {
    setShowAnswers(!showAnswers);
    // Не закриваємо меню, щоб користувач міг керувати кількома опціями
  };

  const handleClearAnswers = () => {
    setSelectedAnswers({});
    handleCloseContextMenu();
  };

  const handleDeleteAll = () => {
    setConfirmationModal({
      isOpen: true,
      questionId: null,
      questionType: null,
      questionText: 'Ви впевнені, що бажаєте видалити всі збережені питання?'
    });
    handleCloseContextMenu();
  };

  const handleAnswerClick = (questionId: number, answer: string) => {
    const key = `${questionId}`;
    // Перевіряємо, чи вже є відповідь на це питання
    if (selectedAnswers[key]) {
      return; // Не дозволяємо змінювати відповідь
    }
    
    setSelectedAnswers(prev => ({
      ...prev,
      [key]: answer
    }));
  };

  const getQuestionData = (savedQuestion: SavedQuestion): QuestionData | null => {
    const questionType = savedQuestion.question_type || 'krok';
    return questionsData[`${questionType}_${savedQuestion.question_id}`] || null;
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
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження збережених питань...</p>
        </div>
      </div>
    );
  }


  if (!session?.user?.id) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <Card className="max-w-md mx-auto">
          <CardContent className="p-6 text-center">
            <p className="text-gray-600">Будь ласка, увійдіть в систему, щоб переглянути збережені питання.</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      <div className="w-full px-4 py-6">
        {/* Заголовок без білого фону */}
        <div className="text-center relative mb-6">
          <h1 className="text-2xl font-bold text-blue-700 flex items-center justify-center">
            <BookmarkCheck className="mr-2 h-6 w-6" />
              Збережені питання {savedQuestions.length}
          </h1>
          
          {/* Кнопка контекстного меню */}
          <div className="absolute top-0 right-4">
            <button
              onClick={handleContextMenuClick}
              className="text-gray-600 hover:text-gray-600 focus:outline-none p-2 rounded-md transition-colors"
            >
              <MoreVertical className="h-5 w-5" />
            </button>
          </div>
        </div>

        {/* Питання з сірим фоном майже на всю ширину */}
        <div className="space-y-6">
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
                    <div key={savedQuestion.id} className="w-full bg-white rounded-lg p-6">
                      <div className="flex items-center justify-between">
                        <div>
                          <p className="text-gray-600 text-lg font-semibold">Завантаження даних питання...</p>
                        </div>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleDeleteClick(savedQuestion.question_id, savedQuestion.question_type)}
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
                  <div key={savedQuestion.id} className="w-full bg-white rounded-lg p-6">
                    <div className="flex items-start justify-between mb-4">
                      <div className="flex-1">
                        <p className="text-gray-700 mb-3 text-lg font-semibold">{questionData.question_text}</p>
                        
                        <div className="space-y-2">
                          {questionData.options ? (
                            // КРОК питання з масивом options
                            questionData.options.map((option) => {
                              const selectedAnswer = selectedAnswers[savedQuestion.question_id];
                              const isSelected = selectedAnswer === option.letter;
                              const isCorrect = option.is_correct;
                              const showCorrectness = selectedAnswer !== undefined;
                              const showAnswersMode = showAnswers;
                              
                              // Якщо увімкнено показ відповідей, показуємо правильні відповіді
                              if (showAnswersMode) {
                                return (
                                  <div
                                    key={option.letter}
                                    className={`w-full p-3 rounded-lg text-left ${
                                      isCorrect
                                        ? 'bg-green-100 text-green-800 border-2 border-green-500'
                                        : 'bg-gray-100 text-gray-700 border border-gray-300'
                                    }`}
                                  >
                                    <span className="font-medium">{option.letter}.</span> {option.text}
                                    {isCorrect && <span className="ml-2 text-green-600 font-semibold">✓ Правильна відповідь</span>}
                                  </div>
                                );
                              }
                              
                              // Інакше показуємо інтерактивні кнопки
                              const isAnswered = selectedAnswer !== undefined;
                              return (
                                <button
                                  key={option.letter}
                                  onClick={() => handleAnswerClick(savedQuestion.question_id, option.letter)}
                                  disabled={isAnswered}
                                  className={`w-full p-3 rounded-lg text-left transition-colors ${
                                    showCorrectness
                                      ? isCorrect
                                        ? 'bg-green-100 text-green-800 border-2 border-green-500'
                                        : isSelected
                                        ? 'bg-red-100 text-red-800 border-2 border-red-500'
                                        : 'bg-gray-100 text-gray-700 border border-gray-300'
                                      : isSelected
                                      ? 'bg-blue-100 text-blue-800 border-2 border-blue-500'
                                      : 'bg-gray-100 text-gray-700 border border-gray-300 hover:bg-gray-200'
                                  } ${isAnswered ? 'cursor-not-allowed opacity-75' : 'cursor-pointer'}`}
                                >
                                  <span className="font-medium">{option.letter}.</span> {option.text}
                                  {showCorrectness && isCorrect && <span className="ml-2 text-green-600 font-semibold">✓ Правильно</span>}
                                  {showCorrectness && isSelected && !isCorrect && <span className="ml-2 text-red-600 font-semibold">✗ Неправильно</span>}
                                </button>
                              );
                            })
                          ) : (
                            // Звичайні питання з option_a, option_b, etc.
                            ['A', 'B', 'C', 'D', 'E'].map((option) => {
                              const optionText = questionData[`option_${option.toLowerCase()}` as keyof QuestionData] as string;
                              if (!optionText) return null;
                              
                              const selectedAnswer = selectedAnswers[savedQuestion.question_id];
                              const isSelected = selectedAnswer === option;
                              const isCorrect = questionData.correct_answer === option;
                              const showCorrectness = selectedAnswer !== undefined;
                              const showAnswersMode = showAnswers;
                              
                              // Якщо увімкнено показ відповідей, показуємо правильні відповіді
                              if (showAnswersMode) {
                                return (
                                  <div
                                    key={option}
                                    className={`w-full p-3 rounded-lg text-left ${
                                      isCorrect
                                        ? 'bg-green-100 text-green-800 border-2 border-green-500'
                                        : 'bg-gray-100 text-gray-700 border border-gray-300'
                                    }`}
                                  >
                                    <span className="font-medium">{option}.</span> {optionText}
                                    {isCorrect && <span className="ml-2 text-green-600 font-semibold">✓ Правильна відповідь</span>}
                                  </div>
                                );
                              }
                              
                              // Інакше показуємо інтерактивні кнопки
                              const isAnswered = selectedAnswer !== undefined;
                              return (
                                <button
                                  key={option}
                                  onClick={() => handleAnswerClick(savedQuestion.question_id, option)}
                                  disabled={isAnswered}
                                  className={`w-full p-3 rounded-lg text-left transition-colors ${
                                    showCorrectness
                                      ? isCorrect
                                        ? 'bg-green-100 text-green-800 border-2 border-green-500'
                                        : isSelected
                                        ? 'bg-red-100 text-red-800 border-2 border-red-500'
                                        : 'bg-gray-100 text-gray-700 border border-gray-300'
                                      : isSelected
                                      ? 'bg-blue-100 text-blue-800 border-2 border-blue-500'
                                      : 'bg-gray-100 text-gray-700 border border-gray-300 hover:bg-gray-200'
                                  } ${isAnswered ? 'cursor-not-allowed opacity-75' : 'cursor-pointer'}`}
                                >
                                  <span className="font-medium">{option}.</span> {optionText}
                                  {showCorrectness && isCorrect && <span className="ml-2 text-green-600 font-semibold">✓ Правильно</span>}
                                  {showCorrectness && isSelected && !isCorrect && <span className="ml-2 text-red-600 font-semibold">✗ Неправильно</span>}
                                </button>
                              );
                            }).filter(Boolean)
                          )}
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
                      
                        <button
                          onClick={() => handleDeleteClick(savedQuestion.question_id, savedQuestion.question_type || 'krok')}
                          disabled={removingQuestion === `${savedQuestion.question_type || 'krok'}_${savedQuestion.question_id}`}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50 ml-4"
                          title="Видалити зі збережених"
                        >
                          {removingQuestion === `${savedQuestion.question_type || 'krok'}_${savedQuestion.question_id}` ? (
                            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-red-600"></div>
                          ) : (
                            <Trash2 className="w-4 h-4" />
                          )}
                        </button>
                    </div>
                  </div>
                );
              })
            )}
        </div>
        
        {/* Модальне вікно підтвердження видалення */}
        <ConfirmationModal
          isOpen={confirmationModal.isOpen}
          onClose={handleCancelDelete}
          onConfirm={handleConfirmDelete}
          title={confirmationModal.questionId === null ? "Видалення всіх питань" : "Видалення питання"}
          message={confirmationModal.questionText || "Ви впевнені, що бажаєте видалити це питання зі збережених?"}
          confirmText="Видалити"
          cancelText="Скасувати"
          isLoading={removingQuestion !== null}
        />
        
        {/* Контекстне меню */}
        <ContextMenu
          isOpen={contextMenu.isOpen}
          onClose={handleCloseContextMenu}
          position={contextMenu.position}
          onToggleShowAnswers={handleToggleShowAnswers}
          onClearAnswers={handleClearAnswers}
          onDeleteAll={handleDeleteAll}
          showAnswers={showAnswers}
        />
      </div>
    </div>
  );
}