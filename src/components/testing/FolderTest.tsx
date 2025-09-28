'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { ArrowLeft, BookOpen, Calendar, Trash2, Eye, EyeOff, MoreVertical, Brain } from 'lucide-react';
import Link from 'next/link';
import ConfirmationModal from '@/components/ui/confirmation-modal';

interface Question {
  id: number;
  question: string;
  options: string[];
  correct_answer: number;
  explanation?: string;
  question_type: string;
  created_at: string;
}

interface Folder {
  id: string;
  name: string;
  description: string;
  color: string;
  created_at: string;
}

interface FolderTestProps {
  folderId: string;
  onBack: () => void;
}

export default function FolderTest({ folderId, onBack }: FolderTestProps) {
  const { data: session } = useSession();
  const [folder, setFolder] = useState<Folder | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<{ [key: number]: number }>({});
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set());
  const [showAnswers, setShowAnswers] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const [revealAllAnswers, setRevealAllAnswers] = useState(false);
  const [enableAI, setEnableAI] = useState(false);
  const [loading, setLoading] = useState(true);
  const [removing, setRemoving] = useState<string | null>(null);
  const [showClearModal, setShowClearModal] = useState(false);

  useEffect(() => {
    if (session?.user?.id && folderId) {
      loadFolderData();
    }
  }, [session, folderId]);

  const loadFolderData = async () => {
    setLoading(true);
    try {
      // Завантажуємо інформацію про папку
      const folderResponse = await fetch(`/api/folders/${folderId}`);
      if (folderResponse.ok) {
        const folderData = await folderResponse.json();
        setFolder(folderData.folder);
      }

      // Завантажуємо питання з папки
      const questionsResponse = await fetch(`/api/folders/questions?folderId=${folderId}`);
      if (questionsResponse.ok) {
        const questionsData = await questionsResponse.json();
        console.log('Questions data received:', questionsData);
        setQuestions(questionsData.questions || []);
      }
    } catch (error) {
      console.error('Error loading folder data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleAnswerSelect = (answerIndex: number) => {
    const questionId = questions[currentQuestionIndex].id;
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answerIndex
    }));

    if (showAnswers) {
      setAnsweredQuestions(prev => new Set([...prev, questionId]));
    }
  };

  const toggleShowAnswers = () => {
    const newShowAnswers = !showAnswers;
    setShowAnswers(newShowAnswers);
    
    if (newShowAnswers) {
      // Показуємо відповіді для вже відповідених питань
      const answeredIds = Object.keys(selectedAnswers).map(Number);
      setAnsweredQuestions(new Set(answeredIds));
    } else {
      // Приховуємо всі відповіді
      setAnsweredQuestions(new Set());
    }
  };

  const toggleRevealAllAnswers = () => {
    const newRevealAll = !revealAllAnswers;
    setRevealAllAnswers(newRevealAll);
    
    if (newRevealAll) {
      // Показуємо всі відповіді
      const allQuestionIds = questions.map(q => q.id);
      setAnsweredQuestions(new Set(allQuestionIds));
    } else {
      // Показуємо тільки відповіді для відповідених питань
      const answeredIds = Object.keys(selectedAnswers).map(Number);
      setAnsweredQuestions(new Set(answeredIds));
    }
  };

  const toggleAI = () => {
    setEnableAI(!enableAI);
  };

  const handleClearAnswersClick = () => {
    setShowMenu(false);
    setShowClearModal(true);
  };

  const handleClearAnswersConfirm = () => {
    setSelectedAnswers({});
    setAnsweredQuestions(new Set());
    setShowClearModal(false);
  };

  const handleClearAnswersCancel = () => {
    setShowClearModal(false);
  };

  const nextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    }
  };

  const prevQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  };

  const removeQuestion = async (questionId: number, questionType: string) => {
    if (!confirm('Ви впевнені, що хочете видалити це питання з папки?')) return;
    
    setRemoving(questionId.toString());
    try {
      const response = await fetch('/api/folders/questions', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          folderId,
          questionType,
          questionId
        })
      });

      if (response.ok) {
        setQuestions(prev => prev.filter(q => q.id !== questionId));
        alert('Питання видалено з папки!');
      } else {
        const errorData = await response.json();
        alert(`Помилка: ${errorData.error || 'Не вдалося видалити питання'}`);
      }
    } catch (error) {
      console.error('Error removing question:', error);
      alert('Помилка при видаленні питання');
    } finally {
      setRemoving(null);
    }
  };

  const getAnswerButtonClass = (optionIndex: number, questionId: number) => {
    const isSelected = selectedAnswers[questionId] === optionIndex;
    const isCorrect = optionIndex === questions[currentQuestionIndex].correct_answer;
    const isAnswered = answeredQuestions.has(questionId) || revealAllAnswers;
    
    if (isAnswered) {
      if (isCorrect) {
        return 'bg-green-100 border-green-500 text-green-800';
      } else if (isSelected && !isCorrect) {
        return 'bg-red-100 border-red-500 text-red-800';
      } else {
        return 'bg-gray-100 border-gray-300 text-gray-600';
      }
    }
    
    if (isSelected) {
      return 'bg-blue-100 border-blue-500 text-blue-800';
    }
    
    return 'bg-white border-gray-300 text-gray-700 hover:bg-gray-50';
  };

  if (!session?.user?.id) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Увійдіть в систему</h1>
          <p className="text-gray-600 mb-6">Для доступу до папок потрібно увійти в систему</p>
          <Link
            href="/auth/signin"
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
          >
            Увійти
          </Link>
        </div>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
        <div className="p-6">
          <div className="max-w-4xl mx-auto">
            <div className="animate-pulse">
              <div className="h-8 bg-gray-200 rounded w-1/4 mb-6"></div>
              <div className="space-y-4">
                {[...Array(5)].map((_, i) => (
                  <div key={i} className="bg-white rounded-xl p-6 shadow-lg">
                    <div className="h-4 bg-gray-200 rounded mb-4"></div>
                    <div className="space-y-2">
                      <div className="h-3 bg-gray-200 rounded"></div>
                      <div className="h-3 bg-gray-200 rounded w-3/4"></div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (!folder) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Папка не знайдена</h1>
          <p className="text-gray-600 mb-6">Ця папка не існує або була видалена</p>
          <button
            onClick={onBack}
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
          >
            Повернутися до папок
          </button>
        </div>
      </div>
    );
  }

  if (questions.length === 0) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
        <div className="p-6">
          <div className="max-w-4xl mx-auto">
            {/* Заголовок */}
            <div className="flex items-center space-x-4 mb-8">
              <button
                onClick={onBack}
                className="p-2 text-gray-600 hover:text-gray-800 hover:bg-white rounded-lg transition-colors"
              >
                <ArrowLeft className="w-6 h-6" />
              </button>
              <div
                className="w-12 h-12 rounded-lg flex items-center justify-center text-white"
                style={{ backgroundColor: folder.color }}
              >
                <BookOpen className="w-6 h-6" />
              </div>
              <div>
                <h1 className="text-3xl font-bold text-gray-900">{folder.name}</h1>
                <p className="text-gray-600">{folder.description}</p>
              </div>
            </div>

            {/* Порожня папка */}
            <div className="text-center py-12">
              <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-4" />
              <h3 className="text-xl font-semibold text-gray-900 mb-2">Папка порожня</h3>
              <p className="text-gray-600 mb-6">Додайте питання до цієї папки</p>
              <Link
                href="/saved-questions"
                className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
              >
                Переглянути збережені питання
              </Link>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const currentQuestion = questions[currentQuestionIndex];
  const isTestCompleted = Object.keys(selectedAnswers).length === questions.length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      {/* Меню з трьома крапками */}
      <div className="fixed top-4 right-4 z-[9999]">
        <div className="relative">
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

      <div className="p-6">
        <div className="max-w-4xl mx-auto">
          {/* Заголовок */}
          <div className="flex items-center space-x-4 mb-8">
            <button
              onClick={onBack}
              className="p-2 text-gray-600 hover:text-gray-800 hover:bg-white rounded-lg transition-colors"
            >
              <ArrowLeft className="w-6 h-6" />
            </button>
            <div
              className="w-12 h-12 rounded-lg flex items-center justify-center text-white"
              style={{ backgroundColor: folder.color }}
            >
              <BookOpen className="w-6 h-6" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900">{folder.name}</h1>
              <p className="text-gray-600">{folder.description}</p>
            </div>
          </div>

          {/* Прогрес */}
          <div className="bg-white rounded-xl p-6 shadow-lg mb-8">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-semibold text-gray-900">
                Питання {currentQuestionIndex + 1} з {questions.length}
              </h2>
              <div className="flex items-center space-x-2">
                <button
                  onClick={prevQuestion}
                  disabled={currentQuestionIndex === 0}
                  className="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  Попереднє
                </button>
                <button
                  onClick={nextQuestion}
                  disabled={currentQuestionIndex === questions.length - 1}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  Наступне
                </button>
              </div>
            </div>
            
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
              ></div>
            </div>
          </div>

          {/* Питання */}
          <div className="bg-white rounded-xl p-8 shadow-lg">
            <div className="flex items-start justify-between mb-6">
              <div className="flex-1">
                <div className="flex items-center space-x-2 mb-4">
                  <span className="px-2 py-1 bg-blue-100 text-blue-800 text-xs font-medium rounded">
                    {currentQuestion.question_type === 'anatomy' ? 'Анатомія' : 
                     currentQuestion.question_type === 'histology' ? 'Гістологія' : 
                     currentQuestion.question_type === 'krok' ? 'Крок' : 
                     currentQuestion.question_type === 'physiology' ? 'Фізіологія' : 
                     currentQuestion.question_type === 'biology' ? 'Біологія' :
                     currentQuestion.question_type === 'microbiology' ? 'Мікробіологія' :
                     currentQuestion.question_type === 'pathology' ? 'Патологія' :
                     currentQuestion.question_type === 'pathophysiology' ? 'Патологічна фізіологія' :
                     currentQuestion.question_type === 'pharmacology' ? 'Фармакологія' :
                     currentQuestion.question_type}
                  </span>
                  <span className="text-sm text-gray-500 flex items-center">
                    <Calendar className="w-4 h-4 mr-1" />
                    {new Date(currentQuestion.created_at).toLocaleDateString('uk-UA')}
                  </span>
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-6">
                  {currentQuestion.question}
                </h3>
              </div>
              <button
                onClick={() => removeQuestion(currentQuestion.id, currentQuestion.question_type)}
                disabled={removing === currentQuestion.id.toString()}
                className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
                title="Видалити з папки"
              >
                {removing === currentQuestion.id.toString() ? (
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-red-600"></div>
                ) : (
                  <Trash2 className="w-4 h-4" />
                )}
              </button>
            </div>
            
            {/* Варіанти відповідей */}
            <div className="space-y-3 mb-6">
              {currentQuestion.options.map((option, index) => (
                <button
                  key={index}
                  onClick={() => handleAnswerSelect(index)}
                  className={`w-full p-4 text-left rounded-lg border-2 transition-all duration-200 ${getAnswerButtonClass(index, currentQuestion.id)}`}
                >
                  <span className="font-medium">
                    {String.fromCharCode(65 + index)}.
                  </span>
                  <span className="ml-2">{option}</span>
                </button>
              ))}
            </div>

            {/* AI пояснення */}
            {(enableAI || isTestCompleted) && (
              <div className="mt-6 p-4 bg-purple-50 rounded-lg">
                <div className="flex items-center space-x-2 mb-2">
                  <Brain className="w-5 h-5 text-purple-600" />
                  <h4 className="font-medium text-purple-900">AI Пояснення</h4>
                </div>
                <button className="w-full bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700 transition-colors">
                  Згенерувати AI відповідь
                </button>
              </div>
            )}

            {/* Пояснення */}
            {currentQuestion.explanation && (
              <div className="mt-6 p-4 bg-blue-50 rounded-lg">
                <h4 className="font-medium text-blue-900 mb-2">Пояснення:</h4>
                <p className="text-blue-800">{currentQuestion.explanation}</p>
              </div>
            )}
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
