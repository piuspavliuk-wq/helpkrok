'use client'

import { useRouter } from 'next/navigation'

interface TestSelectionModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function TestSelectionModal({
  isOpen,
  onClose
}: TestSelectionModalProps) {
  const router = useRouter();

  if (!isOpen) return null;

  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  const handleMedicalTest = () => {
    onClose();
    router.push('/medical-test');
  };

  const handlePharmacyTest = () => {
    onClose();
    router.push('/pharmaceutical-test');
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
                  Оберіть факультет
                </h2>
              </div>

              {/* Повідомлення */}
              <div className="px-6 pb-5">
                <p className="text-gray-700">
                  Виберіть факультет для початку підготовки
                </p>
              </div>
        
        {/* Розділювальна лінія */}
        <div className="border-t border-gray-200"></div>
        
        {/* Кнопки */}
              <div className="px-6 py-4 flex flex-col space-y-3">
                <button
                  onClick={handleMedicalTest}
                  className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg transition-all duration-300 shadow-sm hover:shadow-md"
                >
                  Медицина
                </button>
                <button
                  onClick={handlePharmacyTest}
                  className="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg transition-all duration-300 shadow-sm hover:shadow-md"
                >
                  Фармація
                </button>
          <button
            onClick={onClose}
            className="w-full text-gray-600 hover:text-gray-700 text-sm font-medium py-2 px-4 transition-colors"
          >
            Скасувати
          </button>
        </div>
      </div>
    </div>
  );
}
