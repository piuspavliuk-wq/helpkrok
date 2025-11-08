'use client';

import { useState, useEffect, Suspense } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useSession } from 'next-auth/react';
import { useSearchParams } from 'next/navigation';
import { Bookmark, BookmarkCheck, Brain, Check, X } from 'lucide-react';
import AIExplanation from '@/components/ui/AIExplanation';

interface Question {
  id: number;
  question_text: string;
  option_a?: string;
  option_b?: string;
  option_c?: string;
  option_d?: string;
  option_e?: string;
  correct_answer?: string;
  created_at?: string;
  year?: number;
  faculty?: string;
  category?: string;
  difficulty?: string;
  question_image?: string;
  option_images?: { [key: string]: string };
  options?: Array<{
    letter: string;
    text: string;
    is_correct: boolean;
  }>;
  shuffledOptions?: Array<{
    originalKey: string;
    text: string;
    displayKey: string;
  }>;
  shuffledCorrectAnswer?: string;
}

interface TestResult {
  questionId: number;
  selectedAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
}

function RandomizerTestContent() {
  const { data: session } = useSession();
  const searchParams = useSearchParams();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [selectedAnswers, setSelectedAnswers] = useState<{[key: number]: string}>({});
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [isTestStarted, setIsTestStarted] = useState(false);
  const [isTestCompleted, setIsTestCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [shuffledQuestions, setShuffledQuestions] = useState<Question[]>([]);
  const [showAIExplanation, setShowAIExplanation] = useState(false);
  const [currentQuestionForAI, setCurrentQuestionForAI] = useState<any>(null);
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set());
  const [showAnswers, setShowAnswers] = useState(searchParams.get('showAnswers') === 'true');
  const [showSettings, setShowSettings] = useState(false);
  const [totalQuestionsInDatabase, setTotalQuestionsInDatabase] = useState<number>(0);

  // Завантаження питань з бази даних
  useEffect(() => {
    loadQuestions();
  }, []);

  // Автоматично починаємо тест після завантаження питань, якщо тест ще не початий
  useEffect(() => {
    if (questions.length > 0 && !isTestStarted && !isTestCompleted) {
      // Не показуємо налаштування, одразу починаємо тест
      const shuffled = questions.map(question => shuffleAnswers(question));
      setShuffledQuestions(shuffled);
      setSelectedAnswers({});
      setTestResults([]);
      setIsTestStarted(true);
      setIsTestCompleted(false);
      setShowSettings(false);
    } else if (questions.length === 0 && !isLoading) {
      console.log('Немає питань для тесту');
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [questions.length, isTestStarted, isTestCompleted, isLoading]);

  const loadQuestions = async () => {
    setIsLoading(true);
    try {
      // Отримуємо 150 випадкових питань з усіх медичних питань
      const url = '/api/krok/questions?random=true&faculty=medical&limit=150';
      const response = await fetch(url);
      if (response.ok) {
        const data = await response.json();
        const questions = data.questions || data;
        
        // Фільтруємо тільки ті питання, що мають варіанти відповідей
        if (questions.length > 0) {
          const validQuestions = questions.filter((q: any) => q.options && q.options.length > 0);
          console.log(`Завантажено ${validQuestions.length} випадкових КРОК питань з бази ${data.total || 'невідомо'} питань`);
          setQuestions(validQuestions);
          setTotalQuestionsInDatabase(data.total || 0);
        } else {
          console.log('Немає питань для Randomizer PRO');
        }
      } else {
        console.error('Помилка завантаження питань для Randomizer PRO');
      }
    } catch (error) {
      console.error('Помилка завантаження питань:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const shuffleAnswers = (question: Question) => {
    // Для КРОК питань використовуємо options
    let options;
    
    if (question.options && question.options.length > 0) {
      // КРОК питання
      options = question.options.map(opt => ({
        originalKey: opt.letter,
        text: opt.text
      }));
    } else {
      // Fallback для інших типів питань
      options = [
        { originalKey: 'A', text: question.option_a || '' },
        { originalKey: 'B', text: question.option_b || '' },
        { originalKey: 'C', text: question.option_c || '' },
        { originalKey: 'D', text: question.option_d || '' },
        { originalKey: 'E', text: question.option_e || '' }
      ].filter(opt => opt.text); // Видаляємо порожні варіанти
    }

    // Перемішуємо масив варіантів
    const shuffled = [...options].sort(() => Math.random() - 0.5);
    
    // Знаходимо індекс правильної відповіді у перемішаному масиві
    const correctAnswer = question.correct_answer || (question.options?.find(opt => opt.is_correct)?.letter) || 'A';
    const correctIndex = shuffled.findIndex(option => option.originalKey === correctAnswer);
    
    // Присвоюємо нові букви A, B, C, D, E до перемішаних варіантів
    const shuffledWithNewKeys = shuffled.map((option, index) => ({
      ...option,
      displayKey: String.fromCharCode(65 + index) // 65 = 'A'
    }));

    return {
      ...question,
      shuffledOptions: shuffledWithNewKeys,
      shuffledCorrectAnswer: shuffledWithNewKeys[correctIndex]?.displayKey || 'A'
    };
  };

  const startTest = () => {
    // Перемішуємо питання та варіанти відповідей
    const shuffled = questions.map(question => shuffleAnswers(question));
    setShuffledQuestions(shuffled);
    setSelectedAnswers({});
    setTestResults([]);
    setIsTestStarted(true);
    setIsTestCompleted(false);
    setShowSettings(false);
  };

  const startTestWithSettings = () => {
    startTest();
  };

  const handleAnswerSelect = async (questionId: number, answer: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }));

    // Додаємо питання до списку відповіданих одразу, якщо showAnswers увімкнено
    if (showAnswers) {
      setAnsweredQuestions(prev => new Set([...prev, questionId]));
    }

    // Зберігаємо відповідь в базі даних
    if (session?.user?.id) {
      try {
        const question = shuffledQuestions.find(q => q.id === questionId);
        if (!question) return;

        // Знаходимо оригінальний ключ відповіді (A, B, C, D, E) замість позиції у перемішаному масиві
        let originalAnswerKey = answer;
        if (question.shuffledOptions) {
          const selectedOption = question.shuffledOptions.find(option => option.displayKey === answer);
          originalAnswerKey = selectedOption?.originalKey || answer;
        }

        // Визначаємо правильну відповідь (оригінальний ключ)
        let correctAnswer;
        if (question.options && question.options.length > 0) {
          const correctOption = question.options.find(opt => opt.is_correct);
          correctAnswer = correctOption?.letter || 'A';
        } else {
          correctAnswer = question.correct_answer || 'A';
        }
        
        const response = await fetch('/api/test-progress', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            testType: 'krok',
            questionId,
            selectedAnswer: originalAnswerKey, // Зберігаємо оригінальний ключ
            correctAnswer
          }),
        });

        if (response.ok) {
          // Відправляємо подію про оновлення рейтингу
        }
      } catch (error) {
        console.error('Помилка збереження відповіді:', error);
      }
    }
  };

  const finishTest = () => {
    const results: TestResult[] = shuffledQuestions.map(question => {
      const selectedAnswer = selectedAnswers[question.id];
      
      // Конвертуємо display ключ в оригінальний ключ для порівняння
      let originalSelectedAnswer = selectedAnswer;
      if (question.shuffledOptions && selectedAnswer) {
        const option = question.shuffledOptions.find(opt => opt.displayKey === selectedAnswer);
        originalSelectedAnswer = option?.originalKey || selectedAnswer;
      }
      
      // Для КРОК питань використовуємо options
      let correctAnswer;
      if (question.options && question.options.length > 0) {
        const correctOption = question.options.find(opt => opt.is_correct);
        correctAnswer = correctOption?.letter || 'A';
      } else {
        correctAnswer = question.correct_answer || 'A';
      }
      
      return {
        questionId: question.id,
        selectedAnswer: selectedAnswer || '', // Залишаємо display ключ для відображення
        correctAnswer: question.shuffledCorrectAnswer || correctAnswer, // Використовуємо display ключ для відображення
        isCorrect: originalSelectedAnswer === correctAnswer // Порівнюємо оригінальні ключі
      };
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
          attempt_type: 'krok_simulation',
          total_questions: totalQuestions,
          correct_answers: correctAnswers,
          score: score,
          time_spent: 0,
          completed_at: new Date().toISOString(),
        }),
      });

      // Оновлюємо рейтинг користувача

      // Відправляємо подію про оновлення рейтингу

    } catch (error) {
      console.error('Error saving test result:', error);
    }
  };

  const resetTest = () => {
    setSelectedAnswers({});
    setTestResults([]);
    setIsTestStarted(false);
    setIsTestCompleted(false);
    setAnsweredQuestions(new Set());
    setShowSettings(true);
    setShowAnswers(false);
  };

  const getCorrectAnswersCount = () => {
    return testResults.filter(result => result.isCorrect).length;
  };

  const getAnswerText = (question: Question, option: string) => {
    switch (option) {
      case 'A': return question.option_a || '';
      case 'B': return question.option_b || '';
      case 'C': return question.option_c || '';
      case 'D': return question.option_d || '';
      case 'E': return question.option_e || '';
      default: return '';
    }
  };

  const getAnswerButtonClass = (answerKey: string, question: any, selectedAnswer?: string) => {
    const isSelected = selectedAnswer === answerKey;
    const isAnswered = answeredQuestions.has(question.id);
    
    // Визначаємо правильну відповідь
    let correctAnswer;
    if (question.options && question.options.length > 0) {
      const correctOption = question.options.find((opt: any) => opt.is_correct);
      correctAnswer = correctOption?.letter || 'A';
    } else {
      correctAnswer = question.correct_answer || 'A';
    }
    
    const isCorrectAnswer = answerKey === (question.shuffledCorrectAnswer || correctAnswer);
    
    // Якщо питання ще не відповідано
    if (!isAnswered) {
      if (isSelected) {
        return 'bg-blue-100 border-blue-500 text-gray-700 hover:bg-blue-200 hover:text-gray-700';
      }
      return 'bg-white border-gray-300 text-gray-700 hover:bg-blue-50 hover:text-gray-700';
    }
    
    // Якщо питання вже відповідано - показуємо правильність
    if (isCorrectAnswer) {
      return 'bg-green-100 border-green-500 text-green-700 hover:bg-green-200 hover:text-green-700';
    } else if (isSelected && !isCorrectAnswer) {
      return 'bg-red-100 border-red-500 text-red-700 hover:bg-red-200 hover:text-red-700';
    } else {
      return 'bg-gray-50 border-gray-300 text-gray-500 hover:bg-gray-100 hover:text-gray-600';
    }
  };

  const showAIExplanationForQuestion = (question: Question) => {
    const selectedAnswer = selectedAnswers[question.id];
    const options = question.shuffledOptions?.map(opt => ({
      letter: opt.displayKey,
      text: opt.text
    })) || ['A', 'B', 'C', 'D', 'E'].map(letter => ({
      letter,
      text: getAnswerText(question, letter)
    }));

    setCurrentQuestionForAI({
      questionText: question.question_text,
      selectedAnswer: selectedAnswer || '',
      correctAnswer: question.shuffledCorrectAnswer || question.correct_answer || 'A',
      options: options
    });
    setShowAIExplanation(true);
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження питань з Randomizer PRO...</p>
        </div>
      </div>
    );
  }

  // Екран налаштувань для randomizer
  if (showSettings) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center p-4">
        <Card className="w-full max-w-md">
          <CardHeader className="text-center">
            <CardTitle className="text-2xl font-bold text-blue-800 mb-2">
              Налаштування Randomizer PRO
            </CardTitle>
            <p className="text-gray-600">
              Налаштуйте параметри тесту перед початком
            </p>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div>
                <h3 className="font-semibold text-gray-800">Показувати відповіді</h3>
                <p className="text-sm text-gray-600">
                  Показувати правильну відповідь одразу після вибору
                </p>
              </div>
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={showAnswers}
                  onChange={(e) => setShowAnswers(e.target.checked)}
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
              </label>
            </div>
            
            <div className="text-center">
              <Button
                onClick={startTestWithSettings}
                className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 text-lg rounded-xl w-full"
              >
                🚀 Почати тест
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (isTestCompleted) {
    const correctAnswers = getCorrectAnswersCount();
    const totalQuestions = shuffledQuestions.length;
    const percentage = Math.round((correctAnswers / totalQuestions) * 100);

    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 p-4">
        <div className="max-w-4xl mx-auto">
          <Card className="mb-6">
            <CardHeader className="text-center">
              <CardTitle className="text-3xl font-bold text-blue-800 mb-2">
                Результати Randomizer PRO
              </CardTitle>
              <div className="text-2xl text-gray-700">
                Правильних відповідей: <span className="font-bold text-green-600">{correctAnswers}</span> з {totalQuestions}
              </div>
              <div className={`text-4xl font-bold mt-2 ${
                percentage >= 80 ? 'text-green-600' : 
                percentage >= 60 ? 'text-yellow-600' : 'text-red-600'
              }`}>
                {percentage}%
              </div>
            </CardHeader>
            <CardContent className="text-center">
              <div className="space-y-4">
                <Button
                  onClick={resetTest}
                  className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 text-lg rounded-xl mr-4"
                >
                  🔄 Пройти ще раз
                </Button>
                <Button
                  onClick={() => window.location.href = '/'}
                  variant="outline"
                  className="px-8 py-3 text-lg rounded-xl"
                >
                  🏠 На головну
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 p-4">
      <div className="max-w-4xl mx-auto pt-16 md:pt-20">
        {/* Заголовок */}
        <Card className="mb-6">
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle className="text-2xl font-bold text-blue-800">
                Randomizer PRO ({shuffledQuestions.length} питань)
                <span className="text-sm font-normal text-gray-600 ml-2">
                  з бази {totalQuestionsInDatabase || questions.length} питань
                </span>
              </CardTitle>
              <div className="flex items-center space-x-3">
                {shuffledQuestions.length > 0 && (
                  <div className="text-sm text-gray-600 bg-blue-50 px-3 py-1 rounded-full">
                    Питання 1-{shuffledQuestions.length}
                  </div>
                )}
                {Object.keys(selectedAnswers).length > 0 && (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={resetTest}
                    className="text-red-600 border-red-300 hover:bg-red-50"
                  >
                    🗑️ Видалити відповіді
                  </Button>
                )}
              </div>
            </div>
          </CardHeader>
        </Card>

        {/* Всі питання */}
        <div className="space-y-6">
          {shuffledQuestions.map((question, index) => {
            const selectedAnswer = selectedAnswers[question.id];
            
            return (
              <Card key={question.id} className="mb-6">
                <CardHeader>
                  <CardTitle className="text-lg font-bold text-gray-800 flex-1">
                    <span className="text-blue-600 font-bold mr-3">{index + 1}.</span>
                    {question.question_text}
                    {/* Відображення зображення питання */}
                    {question.question_image && (
                      <div className="mt-4 mb-4">
                        <img 
                          src={question.question_image.startsWith('data:') ? question.question_image : `data:image/png;base64,${question.question_image}`}
                          alt="Зображення питання"
                          className="max-w-full h-auto rounded-lg border border-gray-200"
                          style={{ maxHeight: '400px' }}
                          onLoad={() => console.log('🔍 Зображення питання завантажено:', question.id)}
                          onError={(e) => console.error('🔍 Помилка завантаження зображення питання:', question.id, e)}
                        />
                      </div>
                    )}
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  {question.shuffledOptions?.map((option, optionIndex) => {
                    const isAnswered = answeredQuestions.has(question.id);
                    const isSelected = selectedAnswer === option.displayKey;
                    const isCorrectAnswer = option.displayKey === (question.shuffledCorrectAnswer || question.correct_answer);
                    
                    return (
                      <Button
                        key={option.originalKey}
                        variant="outline"
                        className={`w-full justify-start text-left p-4 h-auto ${getAnswerButtonClass(option.displayKey, question, selectedAnswer)}`}
                        onClick={() => handleAnswerSelect(question.id, option.displayKey)}
                      >
                        <div className="flex items-center w-full">
                          <span className="font-semibold mr-3">{option.displayKey}.</span>
                          <div className="flex-1">
                            <span>{option.text}</span>
                            {/* Відображення зображення варіанту відповіді */}
                            {question.option_images && question.option_images[option.originalKey] && (
                              <div className="mt-2">
                                <img 
                                  src={question.option_images[option.originalKey].startsWith('data:') 
                                    ? question.option_images[option.originalKey] 
                                    : `data:image/png;base64,${question.option_images[option.originalKey]}`}
                                  alt={`Зображення варіанту ${option.displayKey}`}
                                  className="max-w-full h-auto rounded border border-gray-200"
                                  style={{ maxHeight: '200px' }}
                                  onLoad={() => console.log('🔍 Зображення варіанту завантажено:', question.id, option.originalKey)}
                                  onError={(e) => console.error('🔍 Помилка завантаження зображення варіанту:', question.id, option.originalKey, e)}
                                />
                              </div>
                            )}
                          </div>
                          {isAnswered && isCorrectAnswer && (
                            <Check className="w-5 h-5 text-green-600 ml-2" />
                          )}
                          {isAnswered && isSelected && !isCorrectAnswer && (
                            <X className="w-5 h-5 text-red-600 ml-2" />
                          )}
                        </div>
                      </Button>
                    );
                  }) || ['A', 'B', 'C', 'D', 'E'].map(option => {
                    const isAnswered = answeredQuestions.has(question.id);
                    const isSelected = selectedAnswer === option;
                    const isCorrectAnswer = option === question.correct_answer;
                    
                    return (
                      <Button
                        key={option}
                        variant="outline"
                        className={`w-full justify-start text-left p-4 h-auto ${getAnswerButtonClass(option, question, selectedAnswer)}`}
                        onClick={() => handleAnswerSelect(question.id, option)}
                      >
                        <div className="flex items-center w-full">
                          <span className="font-semibold mr-3">{option}.</span>
                          <span className="flex-1">{getAnswerText(question, option)}</span>
                          {isAnswered && isCorrectAnswer && (
                            <Check className="w-5 h-5 text-green-600 ml-2" />
                          )}
                          {isAnswered && isSelected && !isCorrectAnswer && (
                            <X className="w-5 h-5 text-red-600 ml-2" />
                          )}
                        </div>
                      </Button>
                    );
                  })}
                  
                  {/* Кнопка AI Пояснення - тільки після завершення тесту */}
                  {isTestCompleted && (
                    <div className="mt-4">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => showAIExplanationForQuestion(question)}
                        className="w-full bg-purple-50 border-purple-300 text-purple-700 hover:bg-purple-100"
                      >
                        <Brain className="w-4 h-4 mr-2" />
                        🤖 Отримати AI Пояснення
                      </Button>
                    </div>
                  )}
                </CardContent>
              </Card>
            );
          })}
        </div>

        {/* AI Пояснення */}
        {showAIExplanation && currentQuestionForAI && (
          <AIExplanation
            questionText={currentQuestionForAI.questionText}
            selectedAnswer={currentQuestionForAI.selectedAnswer}
            correctAnswer={currentQuestionForAI.correctAnswer}
            options={currentQuestionForAI.options}
            onClose={() => {
              setShowAIExplanation(false);
              setCurrentQuestionForAI(null);
            }}
          />
        )}

        {/* Прогрес-бар і кнопка завершення */}
        <div className="test-progress-bar fixed bottom-0 left-0 right-0 md:fixed md:top-0 md:left-64 md:right-0 md:w-auto md:h-[50px] bg-white md:bg-blue-50 md:backdrop-blur-sm border-t md:border-b border-gray-200 md:border-gray-200 shadow-lg md:shadow-sm p-3 md:px-6 md:py-2 md:pb-3 z-[200] relative">
          <div className="text-center md:flex md:items-center md:justify-between md:max-w-4xl md:mx-auto md:w-full">
            <div className="mb-4 md:mb-0 md:flex md:items-center md:space-x-4">
              <p className="text-gray-600 mb-2 md:mb-0 text-sm">
                Відповідей: {Object.keys(selectedAnswers).length} з {shuffledQuestions.length}
              </p>
              <p className="text-gray-500 text-xs mb-2 md:mb-0">
                Прогрес: {Math.round((Object.keys(selectedAnswers).length / shuffledQuestions.length) * 100)}%
              </p>
              <div className="w-full sm:w-48 md:w-64 lg:w-80 xl:w-96 progress-bar">
                <div 
                  className="progress-fill"
                  style={{ width: `${(Object.keys(selectedAnswers).length / shuffledQuestions.length) * 100}%` }}
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
    </div>
  );
}

export default function RandomizerTest() {
  return (
    <Suspense fallback={
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження...</p>
        </div>
      </div>
    }>
      <RandomizerTestContent />
    </Suspense>
  );
}
