'use client';

import { useState, useEffect, useRef } from 'react';
import { useSession } from 'next-auth/react';
import { useParams, useRouter } from 'next/navigation';
import { ArrowLeft, BookOpen, Calendar, Trash2, Eye, MoreVertical, Play, EyeOff, Brain } from 'lucide-react';
import Link from 'next/link';
import FolderTest from '@/components/testing/FolderTest';
import ConfirmationModal from '@/components/ui/confirmation-modal';

interface Question {
  id: number;
  question?: string;
  question_text?: string;
  options: string[] | Array<{letter: string, text: string, is_correct: boolean}>;
  correct_answer: string | number;
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

export default function FolderPage() {
  const { data: session } = useSession();
  const params = useParams();
  const router = useRouter();
  const folderId = params.id as string;
  
  const [folder, setFolder] = useState<Folder | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);
  const [removing, setRemoving] = useState<string | null>(null);
  const [testMode, setTestMode] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const [showAnswers, setShowAnswers] = useState(true);
  const [revealAllAnswers, setRevealAllAnswers] = useState(false);
  const [enableAI, setEnableAI] = useState(false);
  const [selectedAnswers, setSelectedAnswers] = useState<{[key: number]: number}>({});
  const [answeredQuestions, setAnsweredQuestions] = useState<Set<number>>(new Set());
  const menuRef = useRef<HTMLDivElement>(null);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [questionToDelete, setQuestionToDelete] = useState<{id: number, type: string, text: string} | null>(null);

  useEffect(() => {
    if (session?.user?.id && folderId) {
      loadFolderData();
    }
  }, [session, folderId]);

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
      console.log('Loading questions for folder:', folderId);
      const questionsResponse = await fetch(`/api/folders/questions?folderId=${folderId}`);
      console.log('Questions response status:', questionsResponse.status);
      if (questionsResponse.ok) {
        const questionsData = await questionsResponse.json();
        console.log('Questions data received:', questionsData);
        console.log('Questions count:', questionsData.questions?.length || 0);
        if (questionsData.questions && questionsData.questions.length > 0) {
          console.log('First question correct_answer:', questionsData.questions[0].correct_answer, 'type:', typeof questionsData.questions[0].correct_answer);
        }
        setQuestions(questionsData.questions || []);
      } else {
        const errorData = await questionsResponse.json();
        console.error('Error loading questions:', errorData);
      }
    } catch (error) {
      console.error('Error loading folder data:', error);
    } finally {
      setLoading(false);
    }
  };

  const removeQuestion = (questionId: number, questionType: string) => {
    const question = questions.find(q => q.id === questionId);
    if (question) {
      setQuestionToDelete({
        id: questionId,
        type: questionType,
        text: question.question_text || question.question || 'Питання'
      });
      setShowDeleteModal(true);
    }
  };

  const handleConfirmDelete = async () => {
    if (!questionToDelete) return;
    
    console.log('Deleting question:', questionToDelete);
    setRemoving(questionToDelete.id.toString());
    try {
      const requestBody = {
        folderId,
        questionType: questionToDelete.type,
        questionId: questionToDelete.id
      };
      console.log('Request body:', requestBody);
      
      const response = await fetch('/api/folders/questions', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(requestBody)
      });

      if (response.ok) {
        setQuestions(prev => prev.filter(q => q.id !== questionToDelete.id));
      } else {
        const errorData = await response.json();
        alert(`Помилка: ${errorData.error || 'Не вдалося видалити питання'}`);
      }
    } catch (error) {
      console.error('Error removing question:', error);
      alert('Помилка при видаленні питання');
    } finally {
      setRemoving(null);
      setShowDeleteModal(false);
      setQuestionToDelete(null);
    }
  };

  const handleCancelDelete = () => {
    setShowDeleteModal(false);
    setQuestionToDelete(null);
  };

  // Функції для меню
  const toggleShowAnswers = () => {
    const newShowAnswers = !showAnswers;
    setShowAnswers(newShowAnswers);
    
    if (newShowAnswers) {
      // Якщо увімкнюємо показ відповідей, додаємо всі питання з вибраними відповідями
      const answeredIds = Object.keys(selectedAnswers).map(Number);
      setAnsweredQuestions(new Set(answeredIds));
    } else {
      // Якщо вимикаємо, очищаємо відповіді
      setAnsweredQuestions(new Set());
    }
  };

  const toggleRevealAllAnswers = () => {
    const newRevealAll = !revealAllAnswers;
    setRevealAllAnswers(newRevealAll);
    
    if (newRevealAll) {
      // Якщо увімкнюємо розкриття всіх відповідей, додаємо всі питання
      const allQuestionIds = questions.map(q => q.id);
      setAnsweredQuestions(new Set(allQuestionIds));
    } else {
      // Якщо вимикаємо, залишаємо тільки питання з вибраними відповідями
      const answeredIds = Object.keys(selectedAnswers).map(Number);
      setAnsweredQuestions(new Set(answeredIds));
    }
  };

  const toggleAI = () => {
    setEnableAI(!enableAI);
  };

  const clearAnswers = () => {
    console.log('Clearing answers...');
    setShowAnswers(false);
    setRevealAllAnswers(false);
    setEnableAI(false);
    setSelectedAnswers({});
    setAnsweredQuestions(new Set());
    console.log('Answers cleared');
  };

  // Функція для конвертації correct_answer в індекс
  const getCorrectAnswerIndex = (correctAnswer: string | number): number => {
    console.log('Converting correct_answer:', correctAnswer, 'type:', typeof correctAnswer);
    
    if (typeof correctAnswer === 'number') {
      console.log('Number format, returning:', correctAnswer);
      return correctAnswer;
    }
    
    // Конвертуємо A, B, C, D, E в 0, 1, 2, 3, 4
    const letterToIndex: {[key: string]: number} = {
      'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4
    };
    
    const result = letterToIndex[correctAnswer.toUpperCase()] ?? -1;
    console.log('Letter format, converted to:', result);
    return result;
  };

  // Обробка вибору відповіді
  const handleAnswerSelect = (questionId: number, optionIndex: number) => {
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: optionIndex
    }));

    if (showAnswers) {
      setAnsweredQuestions(prev => new Set([...prev, questionId]));
    }
  };

  // Закрити меню при кліку поза ним
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (showMenu && !(event.target as Element).closest('.menu-container')) {
        setShowMenu(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [showMenu]);

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
          <Link
            href="/folders"
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
          >
            Повернутися до папок
          </Link>
        </div>
      </div>
    );
  }

  // Якщо режим тестування, показуємо компонент тесту
  if (testMode) {
    return (
      <FolderTest 
        folderId={folderId} 
        onBack={() => setTestMode(false)} 
      />
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100">
      <div className="p-4">
        <div className="max-w-7xl mx-auto">
          {/* Заголовок */}
          <div className="text-center relative mb-6">
            <div className="flex items-center justify-center mb-4">
              <Link
                href="/folders"
                className="absolute left-0 p-2 text-gray-600 hover:text-gray-800 hover:bg-white rounded-lg transition-colors"
              >
                <ArrowLeft className="w-6 h-6" />
              </Link>
              <h1 className="text-2xl font-bold text-blue-700 flex items-center justify-center">
                <BookOpen className="mr-2 h-6 w-6" />
                {folder.name} {questions.length}
              </h1>
              {/* Кнопка "три крапки" */}
              <div className="absolute right-0 menu-container" ref={menuRef}>
                <button
                  onClick={() => setShowMenu(!showMenu)}
                  className="p-2 text-gray-600 hover:text-gray-800 hover:bg-white rounded-lg transition-colors"
                >
                  <MoreVertical className="w-5 h-5" />
                </button>
              </div>
            </div>
            <p className="text-gray-600">{folder.description}</p>
          </div>

          {/* Меню "три крапки" */}
          {showMenu && (
            <div className="fixed top-4 right-4 z-[9999] menu-container">
              <div className="relative">
                <div className="absolute right-0 top-0 w-64 bg-white rounded-lg shadow-xl border border-gray-200 z-[9999]">
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


                    {/* Очистити відповіді */}
                    <div
                      className="flex items-center px-4 py-3 hover:bg-gray-50 cursor-pointer"
                      onClick={() => {
                        setShowMenu(false);
                        clearAnswers();
                      }}
                    >
                      <Trash2 className="w-4 h-4 text-red-600" />
                      <span className="text-sm font-medium text-red-600 ml-3">Очистити відповіді</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}


          {/* Питання з сірим фоном майже на всю ширину */}
          <div className="space-y-6 w-full">
            {questions.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-600 text-lg">Папка порожня.</p>
                <p className="text-gray-500 mt-2">Додайте питання до цієї папки.</p>
                <Link
                  href="/saved-questions"
                  className="inline-block mt-4 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
                >
                  Переглянути збережені питання
                </Link>
              </div>
            ) : (
                questions.map((question, index) => (
                  <div key={`${question.question_type}_${question.id}_${index}`} className="w-full bg-white rounded-lg p-6 shadow-sm">
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex-1">
                      <p className="text-gray-700 mb-3 text-lg font-semibold">
                        {question.question_text || question.question}
                      </p>
                      
                      <div className="space-y-2">
                        {question.options && question.options.length > 0 ? (
                          question.options.map((option, optionIndex) => {
                            // Обробляємо як об'єкт (КРОК) так і рядок (інші типи)
                            const optionText = typeof option === 'string' ? option : option.text;
                            const optionLetter = typeof option === 'string' ? String.fromCharCode(65 + optionIndex) : option.letter;
                            const isCorrect = typeof option === 'string' 
                              ? optionIndex === getCorrectAnswerIndex(question.correct_answer)
                              : option.is_correct;
                            
                            const isSelected = selectedAnswers[question.id] === optionIndex;
                            const shouldShowAnswer = showAnswers || revealAllAnswers;
                            const isAnswered = answeredQuestions.has(question.id) || revealAllAnswers;
                            
                            let buttonClass = 'p-3 rounded-lg cursor-pointer transition-colors duration-200 ';
                            
                            if (isAnswered) {
                              if (isCorrect) {
                                buttonClass += 'bg-green-100 text-green-800 border-2 border-green-500';
                              } else if (isSelected) {
                                buttonClass += 'bg-red-100 text-red-800 border-2 border-red-500';
                              } else {
                                buttonClass += 'bg-gray-100 text-gray-700 border border-gray-300';
                              }
                            } else {
                              if (isSelected) {
                                buttonClass += 'bg-blue-100 text-blue-800 border-2 border-blue-500';
                              } else {
                                buttonClass += 'bg-gray-100 text-gray-700 border border-gray-300 hover:bg-gray-200';
                              }
                            }
                            
                            return (
                              <div
                                key={optionIndex}
                                className={buttonClass}
                                onClick={() => handleAnswerSelect(question.id, optionIndex)}
                              >
                                <span className="font-medium">
                                  {optionLetter}.
                                </span>
                                <span className="ml-2">{optionText}</span>
                                {isAnswered && isCorrect && (
                                  <span className="ml-2 text-green-600 font-semibold">✓ Правильна відповідь</span>
                                )}
                                {isAnswered && isSelected && !isCorrect && (
                                  <span className="ml-2 text-red-600 font-semibold">✗ Неправильна відповідь</span>
                                )}
                              </div>
                            );
                          })
                        ) : (
                          <div className="p-3 rounded-lg bg-yellow-50 border border-yellow-200">
                            <span className="text-yellow-800">Питання не має варіантів відповідей</span>
                          </div>
                        )}
                      </div>
                      

                      {/* AI пояснення кнопка */}
                      {enableAI && (
                        <div className="mt-4">
                          <button className="flex items-center space-x-2 px-4 py-2 bg-purple-100 text-purple-700 rounded-lg hover:bg-purple-200 transition-colors">
                            <Brain className="w-4 h-4" />
                            <span>Згенерувати AI пояснення</span>
                          </button>
                        </div>
                      )}
                    </div>
                    
                    <button
                      onClick={() => removeQuestion(question.id, question.question_type)}
                      disabled={removing === question.id.toString()}
                      className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
                      title="Видалити з папки"
                    >
                      {removing === question.id.toString() ? (
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-red-600"></div>
                      ) : (
                        <Trash2 className="w-4 h-4" />
                      )}
                    </button>
                  </div>
                  
                  <div className="text-sm text-gray-500">
                    Збережено: {new Date(question.created_at).toLocaleDateString('uk-UA')}, {new Date(question.created_at).toLocaleTimeString('uk-UA')}
                  </div>
                </div>
              ))
            )}
          </div>
        </div>
      </div>

      {/* Модальне вікно підтвердження видалення питання */}
      <ConfirmationModal
        isOpen={showDeleteModal}
        onClose={handleCancelDelete}
        onConfirm={handleConfirmDelete}
        title="Видалення питання з папки"
        message={questionToDelete ? `Ви впевнені, що хочете видалити це питання з папки?\n\n"${questionToDelete.text.substring(0, 100)}${questionToDelete.text.length > 100 ? '...' : ''}"` : "Ви впевнені, що хочете видалити це питання з папки?"}
        confirmText="Видалити"
        cancelText="Скасувати"
        isLoading={removing !== null}
      />
    </div>
  );
}
