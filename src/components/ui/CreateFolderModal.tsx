'use client';

import { useState } from 'react';

interface CreateFolderModalProps {
  isOpen: boolean;
  onClose: () => void;
  onCreate: (folderData: { name: string }) => void;
  isLoading?: boolean;
}


export default function CreateFolderModal({
  isOpen,
  onClose,
  onCreate,
  isLoading = false
}: CreateFolderModalProps) {
  const [formData, setFormData] = useState({
    name: ''
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (formData.name.trim()) {
      onCreate(formData);
    }
  };

  const handleClose = () => {
    setFormData({ name: '' });
    onClose();
  };

  if (!isOpen) return null;

  return (
    <div 
      className="fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm flex items-center justify-center z-50"
      onClick={(e) => e.target === e.currentTarget && handleClose()}
    >
      <div className="bg-white rounded-xl shadow-xl w-full max-w-md mx-4 relative">
        {/* Заголовок */}
        <div className="px-6 py-5">
          <h2 className="text-xl font-semibold text-gray-900">
            Створити папку
          </h2>
        </div>

        {/* Форма */}
        <form onSubmit={handleSubmit} className="px-6 pb-5">
          <div className="space-y-4">
            {/* Назва папки */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Назва папки
              </label>
              <input
                type="text"
                value={formData.name}
                onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors"
                placeholder="Введіть назву папки"
                required
              />
            </div>
          </div>

          {/* Кнопки */}
          <div className="flex justify-end space-x-3 mt-6">
            <button
              type="button"
              onClick={handleClose}
              className="text-gray-600 hover:text-gray-800 transition-colors font-medium"
            >
              Скасувати
            </button>
            <button
              type="submit"
              disabled={isLoading || !formData.name.trim()}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors font-medium"
            >
              {isLoading ? 'Створення...' : 'Створити'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
