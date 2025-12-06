'use client'

import { useState } from 'react'

interface FacultySelectionModalProps {
  isOpen: boolean
  onClose: () => void
  planName: string
  medicalPrice: number
  pharmaceuticalPrice: number
  onSelectFaculty: (faculty: 'medical' | 'pharmaceutical') => void
}

export default function FacultySelectionModal({
  isOpen,
  onClose,
  planName,
  medicalPrice,
  pharmaceuticalPrice,
  onSelectFaculty
}: FacultySelectionModalProps) {
  if (!isOpen) return null

  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      onClose()
    }
  }

  const handleMedical = () => {
    onSelectFaculty('medical')
    // Не закриваємо тут - закриємо після встановлення станів
  }

  const handlePharmaceutical = () => {
    onSelectFaculty('pharmaceutical')
    // Не закриваємо тут - закриємо після встановлення станів
  }

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
            onClick={handleMedical}
            className="w-full bg-[#1128C6] text-white px-6 py-3 rounded-lg font-medium hover:bg-[#0e1fa3] transition-colors"
          >
            Придбати Медицина за {medicalPrice.toLocaleString('uk-UA')} ₴
          </button>
          <button
            onClick={handlePharmaceutical}
            className="w-full bg-[#1128C6] text-white px-6 py-3 rounded-lg font-medium hover:bg-[#0e1fa3] transition-colors"
          >
            Придбати Фармація за {pharmaceuticalPrice.toLocaleString('uk-UA')} ₴
          </button>
        </div>

        {/* Кнопка скасування */}
        <div className="px-6 pb-4">
          <button
            onClick={onClose}
            className="w-full text-gray-600 hover:text-gray-800 text-sm font-medium py-2"
          >
            Скасувати
          </button>
        </div>
      </div>
    </div>
  )
}

