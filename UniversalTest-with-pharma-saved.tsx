'use client';

import { useState, useEffect, useRef } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useSession } from 'next-auth/react';
import { Bookmark, BookmarkCheck, Brain, Check, X, MoreVertical, Eye, EyeOff, Trash2 } from 'lucide-react';
import AIExplanation from '@/components/ui/AIExplanation';
import ConfirmationModal from '@/components/ui/confirmation-modal';
import FolderManager from '@/components/ui/FolderManager';

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

interface SavedQuestionStatus {
  [key: string]: boolean; // Ключ: "questionType_questionId"
}

interface UniversalTestProps {
  testType: 'anatomy' | 'histology' | 'krok' | 'biology' | 'microbiology' | 'pharmacology' | 'physiology' | 'pathophysiology' | 'pathology' | 'analytical-chemistry';
  testName: string;
  isRandomizer?: boolean;
}

export default function UniversalTest({ testType, testName, isRandomizer = false }: UniversalTestProps) {
  const { data: session } = useSession();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [selectedAnswers, setSelectedAnswers] = useState<{[key: number]: string}>({});
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [isTestStarted, setIsTestStarted] = useState(false);
  const [isTestCompleted, setIsTestCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [savedQuestionsStatus, setSavedQuestionsStatus] = useState<SavedQuestionStatus>({});
  const [savingQuestion, setSavingQuestion] = useState<number | null>(null);
  const [loadingSavedStatus, setLoadingSavedStatus] = useState(false);
  const [shuffledQuestions, setShuffledQuestions] = useState<Question[]>([]);
  const [showAIExplanation, setShowAIExplanation] = useState(false);
  const [currentQuestionForAI, setCurrentQuestionForAI] = useState<any>(null);
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set());
  const [showAnswers, setShowAnswers] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const [revealAllAnswers, setRevealAllAnswers] = useState(false);
  const [enableAI, setEnableAI] = useState(false);
  const menuRef = useRef<HTMLDivElement>(null);
  const [showClearModal, setShowClearModal] = useState(false);

  // Завантаження питань з бази даних та автоматичний запуск тесту
  useEffect(() => {
    loadQuestions();
    // Очищуємо статус збережених питань при зміні типу тесту
    setSavedQuestionsStatus({});
  }, [testType]);

  // Автоматичний запуск тесту після завантаження питань
  useEffect(() => {
    if (questions.length > 0 && !isTestStarted && !isTestCompleted) {
      console.log(`Запускаємо тест з ${questions.length} питаннями`);
      startTest();
    } else if (questions.length === 0 && !isLoading) {
      console.log('Немає питань для тесту');
    }
  }, [questions.length, isTestStarted, isTestCompleted, isLoading]);

  // Завантаження статусу збережених питань (тільки для не-randomizer тестів)
  useEffect(() => {
    if (session?.user?.id && questions.length > 0 && !isRandomizer) {
      loadSavedQuestionsStatus();
    }
  }, [session?.user?.id, questions, testType, isRandomizer]);

  // Закриття меню при кліку поза ним
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (menuRef.current && !menuRef.current.contains(event.target as Node)) {
        setShowMenu(false);
      }
    };

    if (showMenu) {
      document.addEventListener('mousedown', handleClickOutside);
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [showMenu]);

  // Завантаження прогресу після створення перемішаних питань
  useEffect(() => {
    if (session?.user?.id && shuffledQuestions.length > 0) {
      loadTestProgress();
    }
  }, [session?.user?.id, shuffledQuestions, testType]);

  // Контроль видимості мобільної навігації
  useEffect(() => {
    if (isTestStarted && !isTestCompleted) {
      document.body.classList.add('hide-mobile-nav');
      console.log('Mobile navigation hidden during test');
    } else {
      document.body.classList.remove('hide-mobile-nav');
      console.log('Mobile navigation shown');
    }
    
    // Cleanup при unmount
    return () => {
      document.body.classList.remove('hide-mobile-nav');
      console.log('Mobile navigation cleanup');
    };
  }, [isTestStarted, isTestCompleted]);

  // Додатковий useEffect для приховування навігації під час завантаження
  useEffect(() => {
    if (isLoading) {
      document.body.classList.add('hide-mobile-nav');
    } else if (!isTestStarted) {
      document.body.classList.remove('hide-mobile-nav');
    }
  }, [isLoading, isTestStarted]);

  // Закриваємо меню при кліку поза ним
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (showMenu && !(event.target as Element).closest('.relative')) {
        setShowMenu(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [showMenu]);

  const loadQuestions = async () => {
    setIsLoading(true);
    try {
      let url = `/api/${testType}/questions`;
      
      // Для КРОК тестів додаємо параметри з URL
      if (testType === 'krok') {
        const urlParams = new URLSearchParams(window.location.search);
        const year = urlParams.get('year');
        const faculty = urlParams.get('faculty');
        
        // Для randomizer додаємо параметри random та limit
        if (isRandomizer) {
          url += '?random=true&limit=150';
        } else {
          if (year) url += `?year=${year}`;
          if (faculty) url += `${year ? '&' : '?'}faculty=${faculty}`;
        }
      }
      
      // Для фармацевтичних тестів використовуємо новий API
      if (testType === 'analytical-chemistry') {
        url = `/api/pharmaceutical/questions?subject=analytical_chemistry&limit=1000`;
      }
      
      const response = await fetch(url);
      if (response.ok) {
        const data = await response.json();
        const questions = data.questions || data;
        
        // Для КРОК питань фільтруємо тільки ті, що мають варіанти відповідей
        if (testType === 'krok' && questions.length > 0) {
          const validQuestions = questions.filter((q: any) => q.options && q.options.length > 0);
          console.log(`Завантажено ${validQuestions.length} КРОК питань з ${questions.length} загальних`);
          setQuestions(validQuestions);
        } else {
          console.log(`Завантажено ${questions.length} питань для ${testType}`);
          setQuestions(questions);
        }
      } else {
        console.error(`Помилка завантаження питань з ${testName}`);
      }
    } catch (error) {
      console.error('Помилка:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const loadSavedQuestionsStatus = async () => {
    if (!session?.user?.id) {
      console.log('Користувач не авторизований, пропускаємо завантаження збережених питань');
      return;
    }

    // Для фармацевтичних тестів використовуємо pharmaceutical API
    if (testType === 'analytical-chemistry') {
      try {
        const response = await fetch(`/api/pharmaceutical/saved?subject=analytical_chemistry`);
        console.log(`Pharmaceutical saved questions response status: ${response.status}`);
        if (response.ok) {
          const data = await response.json();
          console.log('Pharmaceutical API response data:', data);
          const savedQuestions = data.savedQuestions || [];
          const statusMap: SavedQuestionStatus = {};
          savedQuestions.forEach((item: any) => {
            const key = `${testType}_${item.question_id}`;
            statusMap[key] = true;
            console.log(`Added to status map: ${key}`);
          });
          console.log(`Завантажено ${savedQuestions.length} збережених питань для фармації`);
          console.log('Final status map:', statusMap);
          setSavedQuestionsStatus(statusMap);
        } else {
          console.error(`Помилка відповіді API для ${testType}:`, response.status);
        }
      } catch (error) {
        console.error(`Помилка завантаження збережених питань з фармації:`, error);
      } finally {
        setLoadingSavedStatus(false);
      }
      return;
    }

    console.log(`loadSavedQuestionsStatus для ${testType}, user_id: ${session.user.id}`);
    setLoadingSavedStatus(true);
    try {
      console.log(`Завантаження збережених питань для ${testType}...`);
      const response = await fetch(`/api/${testType}/saved`);
      console.log(`Response status: ${response.status}`);
      if (response.ok) {
        const data = await response.json();
        console.log('API response data:', data);
        const savedQuestions = data.savedQuestions || [];
        const statusMap: SavedQuestionStatus = {};
        savedQuestions.forEach((item: any) => {
          // Використовуємо комбінацію question_type + question_id як ключ
          const key = `${testType}_${item.question_id}`;
          statusMap[key] = true;
          console.log(`Added to status map: ${key}`);
        });
        console.log(`Завантажено ${savedQuestions.length} збережених питань для ${testType}`);
        console.log('Final status map:', statusMap);
        setSavedQuestionsStatus(statusMap);
      } else {
        console.error(`Помилка відповіді API для ${testType}:`, response.status);
        // Не показуємо помилку користувачу, просто логуємо
        if (response.status === 401) {
          console.log('Користувач не авторизований для збережених питань');
        }
      }
    } catch (error) {
      console.error(`Помилка завантаження збережених питань з ${testName}:`, error);
      // Не показуємо помилку користувачу, просто логуємо
    } finally {
      setLoadingSavedStatus(false);
    }
  };

  const loadTestProgress = async () => {
    if (!session?.user?.id) return;

    try {
      const response = await fetch(`/api/test-progress?testType=${testType}`);
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.progress) {
          // Конвертуємо збережені оригінальні ключі в display ключі для поточного перемішування
          const convertedAnswers: {[key: number]: string} = {};
          
          Object.entries(data.progress).forEach(([questionIdStr, originalAnswerKey]) => {
            const questionId = parseInt(questionIdStr);
            const question = shuffledQuestions.find(q => q.id === questionId);
            
            if (question && question.shuffledOptions) {
              // Знаходимо display ключ для оригінального ключа
              const option = question.shuffledOptions.find(opt => opt.originalKey === originalAnswerKey);
              if (option) {
                convertedAnswers[questionId] = option.displayKey;
              }
            } else if (question) {
              // Якщо немає перемішування, використовуємо оригінальний ключ
              convertedAnswers[questionId] = originalAnswerKey as string;
            }
          });
          
          setSelectedAnswers(convertedAnswers);
        }
      }
    } catch (error) {
      console.error(`Помилка завантаження прогресу з ${testName}:`, error);
    }
  };

  const toggleSaveQuestion = async (questionId: number) => {
    if (!session?.user?.id) {
      alert('Будь ласка, увійдіть в систему для збереження питань');
      return;
    }

    console.log('UniversalTest toggleSaveQuestion:', { questionId, testType, user_id: session.user.id });
    setSavingQuestion(questionId);
    const key = `${testType}_${questionId}`;
    const isCurrentlySaved = savedQuestionsStatus[key];
    console.log('Current saved status:', { key, isCurrentlySaved });

    try {
      let response;
      
      // Визначаємо URL для API в залежності від типу тесту
      let baseUrl = `/api/${testType}/saved`;
      
      // Для фармацевтичних тестів використовуємо pharmaceutical API
      if (testType === 'analytical-chemistry') {
        baseUrl = '/api/pharmaceutical/saved';
      }

      if (isCurrentlySaved) {
        // DELETE запит з query параметром
        console.log('Attempting DELETE for question:', questionId);
        response = await fetch(`${baseUrl}?questionId=${questionId}`, {
          method: 'DELETE',
        });
      } else {
        // POST запит з body
        console.log('Attempting POST for question:', questionId);
        response = await fetch(baseUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            questionId: questionId,
          }),
        });
      }

      console.log('Response status:', response.status);
      if (response.ok) {
        const responseData = await response.json();
        console.log('Response data:', responseData);
        console.log('Updating saved status from', isCurrentlySaved, 'to', !isCurrentlySaved);
        setSavedQuestionsStatus(prev => {
          const newStatus = {
            ...prev,
            [key]: !isCurrentlySaved
          };
          console.log('New saved status:', newStatus);
          return newStatus;
        });
      } else {
        const errorData = await response.json();
        console.error('Помилка API:', errorData);
        throw new Error(errorData.error || 'Помилка збереження питання');
      }
    } catch (error) {
      console.error('Помилка:', error);
      alert('Помилка збереження питання');
    } finally {
      setSavingQuestion(null);
    }
  };

  const shuffleAnswers = (question: Question) => {
    // Для КРОК питань використовуємо options, для інших - option_a, option_b, etc.
    let options;
    
    if (question.options && question.options.length > 0) {
      // КРОК питання
      options = question.options.map(opt => ({
        originalKey: opt.letter,
        text: opt.text
      }));
    } else {
      // Анатомія/Гістологія питання
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
  };

  const handleAnswerSelect = async (questionId: number, answer: string) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }));

    // Додаємо питання до списку відповіданих, якщо showAnswers увімкнено
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
            testType,
            questionId,
            selectedAnswer: originalAnswerKey, // Зберігаємо оригінальний ключ
            correctAnswer
          }),
        });

        if (response.ok) {
          // Відправляємо подію про оновлення рейтингу
          window.dispatchEvent(new CustomEvent('ratingUpdated'));
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
      
      // Для КРОК питань використовуємо options, для інших - correct_answer
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
          attempt_type: testType,
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
    setSelectedAnswers({});
    setTestResults([]);
    setIsTestStarted(false);
    setIsTestCompleted(false);
    setAnsweredQuestions(new Set());
  };

  const toggleShowAnswers = () => {
    setShowAnswers(!showAnswers);
    if (!showAnswers) {
      // Якщо увімкнюємо показ відповідей, додаємо всі відповідані питання
      const answeredIds = new Set(Object.keys(selectedAnswers).map(Number));
      setAnsweredQuestions(answeredIds);
    } else {
      // Якщо вимикаємо показ відповідей, приховуємо всі відповіді
      setAnsweredQuestions(new Set());
    }
  };

  const toggleRevealAllAnswers = () => {
    setRevealAllAnswers(!revealAllAnswers);
    if (!revealAllAnswers) {
      // Якщо увімкнюємо розкриття всіх відповідей, додаємо всі питання
      const allQuestionIds = new Set(shuffledQuestions.map(q => q.id));
      setAnsweredQuestions(allQuestionIds);
    } else {
      // Якщо вимикаємо розкриття всіх відповідей, залишаємо тільки ті, на які користувач відповів
      const answeredIds = new Set(Object.keys(selectedAnswers).map(Number));
      setAnsweredQuestions(answeredIds);
    }
  };

  const toggleAI = () => {
    setEnableAI(!enableAI);
  };

  const handleClearAnswersClick = () => {
    setShowMenu(false);
    setShowClearModal(true);
  };

  const handleClearAnswersConfirm = async () => {
    if (!session?.user?.id) {
      alert('Будь ласка, увійдіть в систему для видалення відповідей');
      setShowClearModal(false);
      return;
    }

    try {
      const response = await fetch(`/api/test-progress?testType=${testType}`, {
        method: 'DELETE',
      });

      if (response.ok) {
        setSelectedAnswers({});
        setAnsweredQuestions(new Set());
      } else {
        throw new Error('Помилка видалення відповідей');
      }
    } catch (error) {
      console.error('Помилка видалення відповідей:', error);
      alert('Помилка видалення відповідей');
    } finally {
      setShowClearModal(false);
    }
  };

  const handleClearAnswersCancel = () => {
    setShowClearModal(false);
  };

  const getAnswerText = (question: Question, optionKey: string) => {
    // Для КРОК питань використовуємо options
    if (question.options && question.options.length > 0) {
      const option = question.options.find(opt => opt.letter === optionKey);
      return option?.text || '';
    }
    
    // Для анатомії/гістології використовуємо option_a, option_b, etc.
    switch (optionKey) {
      case 'A': return question.option_a || '';
      case 'B': return question.option_b || '';
      case 'C': return question.option_c || '';
      case 'D': return question.option_d || '';
      case 'E': return question.option_e || '';
      default: return '';
    }
  };

  const getCorrectAnswersCount = () => {
    return testResults.filter(result => result.isCorrect).length;
  };

  const showAIExplanationForQuestion = (question: any) => {
    let selectedAnswer = selectedAnswers[question.id];
    let correctAnswer = question.shuffledCorrectAnswer || question.correct_answer;
    
    // Якщо ми в результатах тесту, використовуємо дані з testResults
    if (isTestCompleted) {
      const result = testResults.find(r => r.questionId === question.id);
      if (result) {
        selectedAnswer = result.selectedAnswer;
        correctAnswer = result.correctAnswer;
      }
    }
    
    // Формуємо опції для AI пояснення
    let options: Array<{key: string, text: string}>;
    if (question.shuffledOptions) {
      // Якщо є перемішані опції, використовуємо їх
      options = question.shuffledOptions.map((option: any) => ({
        key: option.displayKey,
        text: option.text
      }));
    } else if (question.options && question.options.length > 0) {
      // Для КРОК питань використовуємо options
      options = question.options.map((option: any) => ({
        key: option.letter,
        text: option.text
      }));
    } else {
      // Якщо немає перемішаних опцій, використовуємо стандартні
      options = [
        { key: 'A', text: question.option_a || '' },
        { key: 'B', text: question.option_b || '' },
        { key: 'C', text: question.option_c || '' },
        { key: 'D', text: question.option_d || '' },
        { key: 'E', text: question.option_e || '' }
      ].filter(opt => opt.text); // Видаляємо порожні варіанти
    }
    
    setCurrentQuestionForAI({
      questionText: question.question_text,
      selectedAnswer: selectedAnswer || '',
      correctAnswer: correctAnswer || '',
      options: options
    });
    setShowAIExplanation(true);
  };

  const getAnswerButtonClass = (answerKey: string, question: any, selectedAnswer?: string) => {
    const isSelected = selectedAnswer === answerKey;
    const isAnswered = answeredQuestions.has(question.id) || revealAllAnswers;
    
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

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-xl text-gray-600">Завантаження питань з {testName}...</p>
        </div>
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
                Результати тесту з {testName}
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
              <Button 
                onClick={resetTest}
                className="bg-blue-600 hover:bg-blue-700 text-white"
              >
                🔄 Пройти знову
              </Button>
            </CardContent>
          </Card>

          {/* Детальні результати */}
          <div className="space-y-4">
            {shuffledQuestions.map((question, index) => {
              const result = testResults.find(r => r.questionId === question.id);
              const isCorrect = result?.isCorrect || false;
              
              return (
                <Card key={question.id} className={`${
                  isCorrect ? 'border-green-500 bg-green-50' : 'border-red-500 bg-red-50'
                }`}>
                  <CardContent className="p-6">
                    <div className="flex items-start space-x-4">
                      <div className={`w-8 h-8 rounded-full flex items-center justify-center font-bold text-white ${
                        isCorrect ? 'bg-green-500' : 'bg-red-500'
                      }`}>
                        {isCorrect ? '✓' : '✗'}
                      </div>
                      <div className="flex-1">
                        <div className="flex items-start justify-between mb-3">
                          <h3 className="font-semibold text-gray-800 flex-1">
                            <span className="text-blue-600 font-bold mr-3">{index + 1}.</span>
                            {question.question_text}
                          </h3>
                          <div className="flex items-center space-x-2 ml-4">
                            {!isRandomizer && (
                              <Button
                                variant="outline"
                                size="sm"
                                onClick={() => toggleSaveQuestion(question.id)}
                                disabled={savingQuestion === question.id}
                                title={!session?.user?.id ? 'Увійдіть в систему для збереження питань' : ''}
                              >
                                {savingQuestion === question.id ? (
                                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-gray-600"></div>
                                ) : savedQuestionsStatus[`${testType}_${question.id}`] ? (
                                  <BookmarkCheck className="w-4 h-4" />
                                ) : (
                                  <Bookmark className="w-4 h-4" />
                                )}
                              </Button>
                            )}
                          </div>
                        </div>
                        <div className="space-y-2">
                          {question.shuffledOptions?.map((option) => (
                            <div key={option.displayKey} className={`p-2 rounded border ${
                              option.displayKey === question.shuffledCorrectAnswer ? 'bg-green-100 border-green-500 text-green-700' :
                              option.displayKey === result?.selectedAnswer && !isCorrect ? 'bg-red-100 border-red-500 text-red-700' :
                              'bg-gray-50 border-gray-300'
                            }`}>
                              <span className="font-semibold">{option.displayKey}.</span> {option.text}
                              {option.displayKey === question.shuffledCorrectAnswer && (
                                <span className="ml-2 text-green-600 font-semibold">(Правильна відповідь)</span>
                              )}
                              {option.displayKey === result?.selectedAnswer && !isCorrect && (
                                <span className="ml-2 text-red-600 font-semibold">(Ваша відповідь)</span>
                              )}
                            </div>
                          ))}
                        </div>
                        
                        {/* Кнопка AI пояснення в результатах */}
                        <div className="mt-4 flex justify-end">
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => showAIExplanationForQuestion(question)}
                            className="bg-purple-50 border-purple-300 text-purple-700 hover:bg-purple-100"
                          >
                            <Brain className="w-4 h-4 mr-2" />
                            🤖 AI Пояснення
                          </Button>
                        </div>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
          
          {/* AI Пояснення модалка в результатах */}
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
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 p-4">
      <div className="max-w-4xl mx-auto pt-16 md:pt-20">
        {/* Заголовок та перемикач */}
        <Card className="mb-6">
          <CardHeader>
            <div className="flex items-center justify-between">
              <CardTitle className="text-2xl font-bold text-blue-800">
                Тест з {testName} ({shuffledQuestions.length} питань)
                {isRandomizer && (
                  <span className="text-sm font-normal text-gray-600 ml-2">
                    з бази 2991 питань
                  </span>
                )}
              </CardTitle>
              <div className="flex items-center space-x-3">
                {shuffledQuestions.length > 0 && (
                  <div className="text-sm text-gray-600 bg-blue-50 px-3 py-1 rounded-full">
                    Питання 1-{shuffledQuestions.length}
                  </div>
                )}
                {!session?.user?.id && !isRandomizer && (
                  <div className="text-sm text-amber-600 bg-amber-50 px-3 py-1 rounded-full">
                    🔒 Увійдіть для збереження питань
                  </div>
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
                  <div className="flex items-start justify-between">
                    <CardTitle className="text-lg font-bold text-gray-800 flex-1">
                      <span className="text-blue-600 font-bold mr-3">{index + 1}.</span>
                      {question.question_text}
                    </CardTitle>
                    <div className="flex items-center space-x-2 ml-4">
                      <button
                        onClick={() => toggleSaveQuestion(question.id)}
                        disabled={savingQuestion === question.id}
                        title={!session?.user?.id ? 'Увійдіть в систему для збереження питань' : ''}
                        className="p-2 hover:bg-gray-100 rounded focus:outline-none focus:ring-0 transition-colors duration-200 disabled:opacity-50"
                      >
                        {savingQuestion === question.id ? (
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-gray-600"></div>
                        ) : savedQuestionsStatus[`${testType}_${question.id}`] ? (
                          <BookmarkCheck className="w-4 h-4 text-blue-600" />
                        ) : (
                          <Bookmark className="w-4 h-4 text-gray-400" />
                        )}
                      </button>
                      
                      {session?.user?.id && (
                        <div className="relative">
                          <FolderManager
                            questionId={question.id}
                            questionType={testType as any}
                            isSaved={savedQuestionsStatus[`${testType}_${question.id}`] || false}
                            onSaveChange={(saved) => {
                              setSavedQuestionsStatus(prev => ({
                                ...prev,
                                [`${testType}_${question.id}`]: saved
                              }));
                            }}
                          />
                        </div>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-3">
                  {question.shuffledOptions?.map((option, optionIndex) => {
                    const isAnswered = answeredQuestions.has(question.id) || revealAllAnswers;
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
                          <span className="flex-1">{option.text}</span>
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
                    const isAnswered = answeredQuestions.has(question.id) || revealAllAnswers;
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
                  
                  {/* Кнопка AI Пояснення - коли AI увімкнено або після завершення тесту */}
                  {(enableAI || isTestCompleted) && (
                    <div className="mt-4">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => showAIExplanationForQuestion(question)}
                        className="w-full bg-purple-50 border-purple-300 text-purple-700 hover:bg-purple-100"
                      >
                        <Brain className="w-4 h-4 mr-2" />
                        🤖 Згенерувати AI відповідь
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

        {/* Фіксована кнопка меню в правому верхньому куті */}
        <div className="fixed top-4 right-4 z-[9999]">
          <div className="relative" ref={menuRef}>
            <button
              onClick={() => setShowMenu(!showMenu)}
              className="p-3 hover:bg-white/80 bg-white/90 backdrop-blur-sm shadow-lg border border-gray-200 rounded focus:outline-none focus:ring-0 transition-colors duration-200"
            >
              <MoreVertical className="w-5 h-5" />
            </button>
            
            {showMenu && (
              <div className="absolute right-0 top-full mt-2 w-64 bg-white rounded-lg shadow-xl border border-gray-200 z-[9999]">
                <div className="py-2">
                  {/* Показувати відповіді */}
                  <div className="flex items-center justify-between px-4 py-3 hover:bg-gray-50">
                    <div className="flex items-center space-x-3">
                      {showAnswers ? <Eye className="w-4 h-4 text-blue-600" /> : <EyeOff className="w-4 h-4 text-gray-400" />}
                      <span className="text-sm font-medium text-gray-700">Показувати відповіді</span>
                    </div>
                    <label className="relative inline-flex items-center cursor-pointer">
                      <input
                        type="checkbox"
                        checked={showAnswers}
                        onChange={toggleShowAnswers}
                        className="sr-only peer"
                      />
                      <div className="w-9 h-5 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-blue-600"></div>
                    </label>
                  </div>
                  
                  {/* Розкрити всі відповіді */}
                  <div className="flex items-center justify-between px-4 py-3 hover:bg-gray-50">
                    <div className="flex items-center space-x-3">
                      <Eye className="w-4 h-4 text-green-600" />
                      <span className="text-sm font-medium text-gray-700">Розкрити всі відповіді</span>
                    </div>
                    <label className="relative inline-flex items-center cursor-pointer">
                      <input
                        type="checkbox"
                        checked={revealAllAnswers}
                        onChange={toggleRevealAllAnswers}
                        className="sr-only peer"
                      />
                      <div className="w-9 h-5 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-blue-600"></div>
                    </label>
                  </div>
                  
                  {/* AI пояснення */}
                  <div className="flex items-center justify-between px-4 py-3 hover:bg-gray-50">
                    <div className="flex items-center space-x-3">
                      <Brain className="w-4 h-4 text-purple-600" />
                      <span className="text-sm font-medium text-gray-700">AI пояснення</span>
                    </div>
                    <label className="relative inline-flex items-center cursor-pointer">
                      <input
                        type="checkbox"
                        checked={enableAI}
                        onChange={toggleAI}
                        className="sr-only peer"
                      />
                      <div className="w-9 h-5 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:bg-blue-600"></div>
                    </label>
                  </div>
                  
                  {/* Видалити всі відповіді */}
                  <div 
                    className="flex items-center px-4 py-3 hover:bg-gray-50 cursor-pointer"
                    onClick={handleClearAnswersClick}
                  >
                    <Trash2 className="w-4 h-4 text-red-600" />
                    <span className="text-sm font-medium text-red-600 ml-3">Видалити всі відповіді</span>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Прогрес-бар і кнопка завершення - закріплені знизу на мобільних, зверху на ПК */}
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

      {/* Модальне вікно підтвердження видалення всіх відповідей */}
      <ConfirmationModal
        isOpen={showClearModal}
        onClose={handleClearAnswersCancel}
        onConfirm={handleClearAnswersConfirm}
        title="Видалення всіх відповідей"
        message="Ви впевнені, що хочете видалити всі свої відповіді? Цю дію неможливо скасувати."
        confirmText="Видалити"
        cancelText="Скасувати"
      />
    </div>
  );
}
