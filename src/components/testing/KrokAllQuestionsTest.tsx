'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useSession } from 'next-auth/react';

interface Question {
  id: number;
  question_text: string;
  year: number;
  faculty: string;
  category: string;
  difficulty: string;
  options: Answer[];
}

interface Answer {
  letter: string;
  text: string;
  is_correct: boolean;
}

interface TestResult {
  questionId: number;
  selectedAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  questionText: string;
  options: Answer[];
}

interface SavedQuestionStatus {
  [questionId: number]: boolean;
}

export default function KrokAllQuestionsTest() {
  const { data: session } = useSession();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [testQuestions, setTestQuestions] = useState<Question[]>([]);
  const [selectedAnswers, setSelectedAnswers] = useState<{ [key: number]: string }>({});
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [isTestStarted, setIsTestStarted] = useState(false);
  const [isTestCompleted, setIsTestCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [savedQuestionsStatus, setSavedQuestionsStatus] = useState<SavedQuestionStatus>({});
  const [savingQuestion, setSavingQuestion] = useState<number | null>(null);
  const [loadingSavedStatus, setLoadingSavedStatus] = useState(false);

  // Завантаження питань з бази даних
  useEffect(() => {
    loadQuestions();
  }, []);

  // Завантаження статусу збережених питань при зміні сесії
  useEffect(() => {
    if (session?.user?.id && questions.length > 0) {
      loadSavedQuestionsStatus(questions);
    }
  }, [session?.user?.id, questions]);

  // Контроль видимості мобільної навігації
  useEffect(() => {
    if (isTestStarted && !isTestCompleted) {
      document.body.classList.add('hide-mobile-nav');
    } else {
      document.body.classList.remove('hide-mobile-nav');
    }
    
    // Cleanup при unmount
    return () => {
      document.body.classList.remove('hide-mobile-nav');
    };
  }, [isTestStarted, isTestCompleted]);

  const loadQuestions = async () => {
    try {
      setIsLoading(true);
      // Завантажуємо всі доступні питання
      const response = await fetch('/api/krok/questions?random=true&limit=10000');
      if (response.ok) {
        const data = await response.json();
        setQuestions(data.questions || []);
        
        // Завантажуємо статус збереження питань асинхронно (не блокуємо основний UI)
        if (session?.user?.id) {
          loadSavedQuestionsStatus(data.questions || []);
        }
      }
    } catch (error) {
      console.error('Помилка завантаження питань:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const loadSavedQuestionsStatus = async (questionsList: Question[]) => {
    if (!session?.user?.id || questionsList.length === 0) return;

    try {
      setLoadingSavedStatus(true);
      // Отримуємо всі збережені питання одним запитом
      const response = await fetch('/api/krok/saved');
      if (response.ok) {
        const data = await response.json();
        const savedQuestionIds = new Set(data.savedQuestions?.map((sq: any) => sq.krok_questions?.id) || []);
        
        const statusMap: SavedQuestionStatus = {};
        questionsList.forEach(question => {
          statusMap[question.id] = savedQuestionIds.has(question.id);
        });
        
        setSavedQuestionsStatus(statusMap);
      }
    } catch (error) {
      console.error('Помилка завантаження статусу збережених питань:', error);
    } finally {
      setLoadingSavedStatus(false);
    }
  };

  const toggleSaveQuestion = async (questionId: number) => {
    if (!session?.user?.id) {
      alert('Для збереження питань необхідна авторизація');
      return;
    }

    setSavingQuestion(questionId);
    
    try {
      const isCurrentlySaved = savedQuestionsStatus[questionId];
      
      if (isCurrentlySaved) {
        // Видаляємо зі збережених
        const response = await fetch(`/api/krok/saved?questionId=${questionId}`, {
          method: 'DELETE'
        });
        
        if (response.ok) {
          setSavedQuestionsStatus(prev => ({
            ...prev,
            [questionId]: false
          }));
        } else {
          alert('Помилка видалення питання зі збережених');
        }
      } else {
        // Зберігаємо питання
        const response = await fetch('/api/krok/saved', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ questionId })
        });
        
        if (response.ok) {
          setSavedQuestionsStatus(prev => ({
            ...prev,
            [questionId]: true
          }));
        } else {
          const data = await response.json();
          if (data.alreadySaved) {
            setSavedQuestionsStatus(prev => ({
              ...prev,
              [questionId]: true
            }));
          } else {
            alert('Помилка збереження питання');
          }
        }
      }
    } catch (error) {
      console.error('Помилка збереження/видалення питання:', error);
      alert('Помилка збереження питання');
    } finally {
      setSavingQuestion(null);
    }
  };

  const startRandomTest = () => {
    if (questions.length < 10) {
      alert('Недостатньо питань для тесту. Потрібно мінімум 10 питань.');
      return;
    }

    // Функція для перевірки чи є у питання варіанти відповідей
    const hasAnswers = (question: Question) => {
      return question.options && question.options.length >= 4;
    };

    // Вибираємо питання з варіантами відповідей
    const questionsWithAnswers = questions.filter(hasAnswers);
    
    if (questionsWithAnswers.length < 10) {
      alert(`Недостатньо питань з варіантами відповідей. Доступно: ${questionsWithAnswers.length} з ${questions.length}`);
      return;
    }

    // Вибираємо 10 випадкових питань з варіантами відповідей
    const shuffled = [...questionsWithAnswers].sort(() => 0.5 - Math.random());
    const selectedQuestions = shuffled.slice(0, 10);
    
    setTestQuestions(selectedQuestions);
    setSelectedAnswers({});
    setTestResults([]);
    setIsTestStarted(true);
    setIsTestCompleted(false);
  };

  const handleAnswerSelect = (questionId: number, answerOption: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answerOption
    }));
  };

  const finishTest = () => {
    const results: TestResult[] = [];
    
    testQuestions.forEach(question => {
      const selectedAnswer = selectedAnswers[question.id];
      const correctAnswer = question.options.find(option => option.is_correct);
      
      results.push({
        questionId: question.id,
        selectedAnswer: selectedAnswer || '',
        correctAnswer: correctAnswer?.letter || '',
        isCorrect: selectedAnswer === correctAnswer?.letter,
        questionText: question.question_text,
        options: question.options
      });
    });
    
    setTestResults(results);
    setIsTestCompleted(true);
    
    // Зберігаємо результат тесту
    saveTestResult(results);
  };

  const saveTestResult = async (results: TestResult[]) => {
    try {
      const correctAnswers = results.filter(r => r.isCorrect).length;
      const totalQuestions = results.length;
      const score = Math.round((correctAnswers / totalQuestions) * 100);

      // Зберігаємо спробу тесту
      await fetch('/api/tests/attempts', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          topic_id: null,
          attempt_type: 'krok_all_questions',
          total_questions: totalQuestions,
          correct_answers: correctAnswers,
          score: score,
          time_spent: 0, // Можна додати таймер
          completed_at: new Date().toISOString(),
        }),
      });

      // Оновлюємо рейтинг користувача
      await fetch('/api/user/update-rating', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      // Відправляємо подію про оновлення рейтингу
      window.dispatchEvent(new CustomEvent('ratingUpdated'));

    } catch (error) {
      console.error('Error saving test result:', error);
    }
  };

  const resetTest = () => {
    setIsTestStarted(false);
    setIsTestCompleted(false);
    setTestQuestions([]);
    setSelectedAnswers({});
    setTestResults([]);
  };

  const getCorrectAnswersCount = () => {
    return testResults.filter(result => result.isCorrect).length;
  };

  const getPercentage = () => {
    return Math.round((getCorrectAnswersCount() / testResults.length) * 100);
  };

  const getQuestionAnswers = (questionId: number) => {
    const question = testQuestions.find(q => q.id === questionId);
    if (!question) return [];
    // Перемішуємо варіанти відповідей для кожного питання
    return question.options.sort(() => Math.random() - 0.5);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center p-8">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Завантаження питань...</p>
        </div>
      </div>
    );
  }

  if (isTestCompleted) {
    return (
      <Card className="w-full max-w-4xl mx-auto">
        <CardHeader>
          <CardTitle className="text-2xl text-center">
            🎯 Результати тесту
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Статистика */}
          <div className="text-center">
            <div className="text-4xl font-bold text-blue-600 mb-2">
              {getCorrectAnswersCount()}/{testResults.length}
            </div>
            <div className="text-2xl font-semibold text-gray-700 mb-4">
              {getPercentage()}% правильних відповідей
            </div>
            <div className="text-sm text-gray-500">
              {getPercentage() >= 70 ? '🎉 Відмінно!' : 
               getPercentage() >= 50 ? '👍 Добре!' : '📚 Треба більше вчитися!'}
            </div>
          </div>

          {/* Детальні результати */}
          <div className="space-y-4">
            <h3 className="text-lg font-semibold">Детальні результати:</h3>
            {testResults.map((result, index) => (
              <div key={result.questionId} className="border rounded-lg p-4">
                <div className="flex items-start justify-between mb-3">
                  <span className="font-medium text-sm text-gray-500">
                    Питання {index + 1}
                  </span>
                  <div className="flex items-center space-x-2">
                    <span className={`px-2 py-1 rounded text-sm font-medium ${
                      result.isCorrect 
                        ? 'bg-green-100 text-green-800' 
                        : 'bg-red-100 text-red-800'
                    }`}>
                      {result.isCorrect ? '✅ Правильно' : '❌ Неправильно'}
                    </span>
                    {session?.user?.id && (
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => toggleSaveQuestion(result.questionId)}
                        disabled={savingQuestion === result.questionId}
                        className={`${
                          savedQuestionsStatus[result.questionId] 
                            ? 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200 hover:text-gray-700' 
                            : 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50 hover:text-gray-700'
                        }`}
                      >
                        {savingQuestion === result.questionId ? (
                          <span className="animate-spin">⏳</span>
                        ) : savedQuestionsStatus[result.questionId] ? (
                          '⭐ Збережено'
                        ) : (
                          '💾 Зберегти'
                        )}
                      </Button>
                    )}
                  </div>
                </div>
                
                <p className="text-gray-800 mb-3 font-medium">
                  {result.questionText}
                </p>
                
                <div className="space-y-2">
                  {result.options.map((option, optionIndex) => {
                    return (
                      <div
                        key={optionIndex}
                        className={`p-2 rounded border ${
                          option.is_correct
                            ? 'bg-green-50 border-green-200 text-green-800 font-medium'
                            : result.selectedAnswer === option.letter
                            ? 'bg-red-50 border-red-200 text-red-800 font-medium'
                            : 'bg-gray-50 border-gray-200 text-gray-700'
                        }`}
                      >
                        <span className="font-medium">{option.letter}.</span> {option.text}
                        {option.is_correct && (
                          <span className="ml-2 text-green-600 font-bold">✓ Правильна відповідь</span>
                        )}
                        {result.selectedAnswer === option.letter && !option.is_correct && (
                          <span className="ml-2 text-red-600 font-bold">✗ Ваша відповідь</span>
                        )}
                      </div>
                    );
                  })}
                </div>
              </div>
            ))}
          </div>

          <div className="text-center">
            <Button onClick={resetTest} className="bg-blue-600 hover:bg-blue-700">
              🔄 Пройти тест знову
            </Button>
          </div>
        </CardContent>
      </Card>
    );
  }

  if (isTestStarted) {
    return (
      <div className="w-full max-w-6xl mx-auto">
        {/* Десктопна версія з контейнером */}
        <div className="hidden md:block">
          <Card className="w-full max-w-6xl mx-auto">
            <CardHeader>
              <CardTitle className="text-2xl text-center">
                Тест з 10 випадкових питань KROK
              </CardTitle>
              <div className="text-center text-gray-600">
                Відповідайте на питання та завершуйте тест коли будете готові
              </div>
            </CardHeader>
            <CardContent className="pb-[70px] pt-[70px] px-6">
              <div className="space-y-8">
                {testQuestions.map((question, index) => {
                  const questionAnswers = getQuestionAnswers(question.id);
                  const selectedAnswer = selectedAnswers[question.id];

                  return (
                    <div key={question.id} className="border rounded-lg p-6 bg-gray-50 mb-8">
                      <div className="flex items-start justify-between mb-4">
                        <h3 className="text-lg font-semibold text-gray-800">
                          Питання {index + 1}
                        </h3>
                        <div className="flex items-center space-x-3">
                          <span className="text-sm text-gray-500">
                            {selectedAnswer ? '✅ Відповідь вибрана' : '❓ Очікує відповіді'}
                          </span>
                          {session?.user?.id && (
                            <Button
                              variant="outline"
                              size="sm"
                              onClick={() => toggleSaveQuestion(question.id)}
                              disabled={savingQuestion === question.id}
                              className={`${
                                savedQuestionsStatus[question.id] 
                                  ? 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200 hover:text-gray-700' 
                                  : 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50 hover:text-gray-700'
                              }`}
                            >
                              {savingQuestion === question.id ? (
                                <span className="animate-spin">⏳</span>
                              ) : savedQuestionsStatus[question.id] ? (
                                '⭐ Збережено'
                              ) : (
                                '💾 Зберегти'
                              )}
                            </Button>
                          )}
                        </div>
                      </div>
                      
                      <p className="text-gray-700 mb-4 font-medium">
                        {question.question_text}
                      </p>
                      
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                        {questionAnswers.map((option, optionIndex) => {
                          return (
                            <button
                              key={optionIndex}
                              onClick={() => handleAnswerSelect(question.id, option.letter)}
                              className={`p-3 text-left border rounded-lg transition-all duration-200 ${
                                selectedAnswer === option.letter
                                  ? 'border-blue-500 bg-blue-100 text-gray-700 hover:bg-blue-200 hover:text-gray-700'
                                  : 'border-gray-300 hover:border-gray-300 hover:bg-blue-50 hover:text-gray-700'
                              }`}
                            >
                              <span className="font-medium">{option.letter}.</span> {option.text}
                            </button>
                          );
                        })}
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </div>
        
        {/* Мобільна версія без контейнера */}
        <div className="md:hidden px-[5px]">
          <div className="text-center mb-6 px-[5px]">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Тест з 10 випадкових питань KROK
            </h2>
            <p className="text-gray-600 text-sm">
              Відповідайте на питання та завершуйте тест коли будете готові
            </p>
          </div>
          <div className="space-y-8 px-[5px] pb-24">
            {testQuestions.map((question, index) => {
              const questionAnswers = getQuestionAnswers(question.id);
              const selectedAnswer = selectedAnswers[question.id];

              return (
                <div key={question.id} className="border rounded-lg p-6 bg-gray-50 mb-8">
                  <div className="flex items-start justify-between mb-4">
                    <h3 className="text-lg font-semibold text-gray-800">
                      Питання {index + 1}
                    </h3>
                    <div className="flex flex-col items-end space-y-2">
                      <span className="text-sm text-gray-500">
                        {selectedAnswer ? '✅ Відповідь вибрана' : '❓ Очікує відповіді'}
                      </span>
                      {session?.user?.id && (
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => toggleSaveQuestion(question.id)}
                          disabled={savingQuestion === question.id}
                          className={`${
                            savedQuestionsStatus[question.id] 
                              ? 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200 hover:text-gray-700' 
                              : 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50 hover:text-gray-700'
                          }`}
                        >
                          {savingQuestion === question.id ? (
                            <span className="animate-spin">⏳</span>
                          ) : savedQuestionsStatus[question.id] ? (
                            '⭐ Збережено'
                          ) : (
                            '💾 Зберегти'
                          )}
                        </Button>
                      )}
                    </div>
                  </div>
                  
                  <p className="text-gray-700 mb-4 font-medium">
                    {question.question_text}
                  </p>
                  
                  <div className="grid grid-cols-1 gap-3">
                    {questionAnswers.map((option, optionIndex) => {
                      return (
                        <button
                          key={optionIndex}
                          onClick={() => handleAnswerSelect(question.id, option.letter)}
                          className={`p-3 text-left border rounded-lg transition-all duration-200 ${
                            selectedAnswer === option.letter
                              ? 'border-blue-500 bg-blue-100 text-gray-700 hover:bg-blue-200 hover:text-gray-700'
                              : 'border-gray-300 hover:border-gray-300 hover:bg-blue-50 hover:text-gray-700'
                          }`}
                        >
                          <span className="font-medium">{option.letter}.</span> {option.text}
                        </button>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Прогрес-бар і кнопка завершення - закріплені знизу на мобільних, зверху на ПК */}
        <div className="fixed bottom-0 left-0 right-0 md:fixed md:top-0 md:left-64 md:right-0 md:w-auto md:h-[50px] bg-white md:bg-blue-50 md:backdrop-blur-sm border-t md:border-t-0 md:border-b-0 border-gray-200 md:border-gray-200 shadow-lg md:shadow-sm p-3 md:px-6 md:py-2 md:pb-3 z-40">
          <div className="text-center md:flex md:items-center md:justify-between md:max-w-4xl md:mx-auto md:w-full">
            <div className="mb-4 md:mb-0 md:flex md:items-center md:space-x-4">
              <p className="text-gray-600 mb-2 md:mb-0 text-sm">
                Відповідей: {Object.keys(selectedAnswers).length} з {testQuestions.length}
              </p>
              <div className="w-full md:w-40 progress-bar">
                <div 
                  className="progress-fill"
                  style={{ width: `${(Object.keys(selectedAnswers).length / testQuestions.length) * 100}%` }}
                ></div>
              </div>
            </div>
            
            <Button
              onClick={finishTest}
              className="bg-blue-600 hover:bg-blue-700 text-base md:text-base px-8 md:px-6 py-3 md:py-2 w-full md:w-auto rounded-xl"
            >
              🏁 Завершити тест
            </Button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl text-center">
          🎲 KROK Тест
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="text-center">
          <p className="text-gray-600 mb-4">
            Пройдіть тест з 10 випадкових питань KROK та перевірте свої знання!
          </p>
          
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
            <h3 className="font-semibold text-blue-800 mb-2">📊 Доступно питань: {questions.filter(q => q.options && q.options.length > 0).length}</h3>
            <p className="text-sm text-blue-600">
              Система випадково вибере 10 питань з питань, що мають варіанти відповідей
            </p>
            {session?.user?.id && (
              <p className="text-sm text-blue-600 mt-2">
                💾 Ви можете зберігати питання для подальшого повторення під час проходження тесту
              </p>
            )}
          </div>

          <Button
            onClick={startRandomTest}
            disabled={questions.filter(q => q.options && q.options.length > 0).length < 10}
            className="bg-blue-600 hover:bg-blue-700 text-lg px-8 py-3"
          >
            Почати тест
          </Button>
          
          {questions.filter(q => q.options && q.options.length > 0).length < 10 && (
            <p className="text-red-600 text-sm mt-2">
              Недостатньо питань з варіантами відповідей для тесту. Потрібно мінімум 10 питань.
            </p>
          )}
        </div>
      </CardContent>
    </Card>
  );
}