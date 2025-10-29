'use client';

interface DeleteQuestionModalProps {
  isOpen: boolean;
  onClose: () => void;
  onConfirm: () => void;
  questionText: string;
  isLoading?: boolean;
}

export default function DeleteQuestionModal({
  isOpen,
  onClose,
  onConfirm,
  questionText,
  isLoading = false
}: DeleteQuestionModalProps) {
  if (!isOpen) return null;

  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  return (
    <div 
      className="fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm flex items-center justify-center z-50"
      onClick={handleBackdropClick}
    >
      <div className="bg-white rounded-xl shadow-xl w-full max-w-2xl mx-4 relative">
        {/* Заголовок */}
        <div className="px-6 py-5">
          <h2 className="text-xl font-semibold text-gray-900">
            Видалення питання
          </h2>
        </div>
        
        {/* Контент питання */}
        <div className="px-6 pb-5">
          <div className="text-gray-700 leading-relaxed whitespace-pre-wrap">
            {questionText}
          </div>
        </div>
        
        {/* Кнопки */}
        <div className="px-6 py-4 flex justify-end space-x-6 border-t border-gray-100">
          <button
            onClick={onClose}
            disabled={isLoading}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium disabled:opacity-50 transition-colors"
          >
            Скасувати
          </button>
          <button
            onClick={onConfirm}
            disabled={isLoading}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium disabled:opacity-50 transition-colors"
          >
            {isLoading ? 'Видалення...' : 'Видалити'}
          </button>
        </div>
      </div>
    </div>
  );
}
