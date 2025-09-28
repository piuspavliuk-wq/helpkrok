'use client';

interface ConfirmationModalProps {
  isOpen: boolean;
  onClose: () => void;
  onConfirm: () => void;
  title: string;
  message: string;
  confirmText?: string;
  cancelText?: string;
  isLoading?: boolean;
}

export default function ConfirmationModal({
  isOpen,
  onClose,
  onConfirm,
  title,
  message,
  confirmText = 'Видалити',
  cancelText = 'Скасувати',
  isLoading = false
}: ConfirmationModalProps) {
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
      <div className="w-full max-w-md mx-4 bg-white/80 backdrop-blur-md rounded-2xl shadow-xl border border-white/20">
        {/* Заголовок */}
        <div className="px-6 py-5">
          <h2 className="text-lg font-semibold text-gray-800">
            {title}
          </h2>
        </div>
        
        {/* Повідомлення */}
        <div className="px-6 pb-5">
          <p className="text-gray-700">
            {message}
          </p>
        </div>
        
        {/* Розділювальна лінія */}
        <div className="border-t border-gray-200"></div>
        
        {/* Кнопки */}
        <div className="px-6 py-4 flex justify-end space-x-6">
          <button
            onClick={onClose}
            disabled={isLoading}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium disabled:opacity-50"
          >
            {cancelText}
          </button>
          <button
            onClick={onConfirm}
            disabled={isLoading}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium disabled:opacity-50"
          >
            {isLoading ? 'Видалення...' : confirmText}
          </button>
        </div>
      </div>
    </div>
  );
}
