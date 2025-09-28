'use client';

import { useState, useRef, useEffect } from 'react';
import { MoreVertical, Trash2 } from 'lucide-react';

interface ContextMenuProps {
  isOpen: boolean;
  onClose: () => void;
  position: { x: number; y: number };
  onToggleShowAnswers: () => void;
  onClearAnswers: () => void;
  onDeleteAll: () => void;
  showAnswers: boolean;
}

export default function ContextMenu({
  isOpen,
  onClose,
  position,
  onToggleShowAnswers,
  onClearAnswers,
  onDeleteAll,
  showAnswers
}: ContextMenuProps) {
  const menuRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (menuRef.current && !menuRef.current.contains(event.target as Node)) {
        onClose();
      }
    };

    if (isOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  return (
    <div
      ref={menuRef}
      className="fixed bg-white rounded-lg shadow-lg border border-gray-200 py-2 min-w-48 z-50"
      style={{
        left: position.x - 250, // Переміщуємо лівіше на 200px
        top: position.y,
      }}
    >
      {/* Показувати відповіді */}
      <div className="pl-7 pr-4 py-3 hover:bg-gray-50 cursor-pointer" onClick={onToggleShowAnswers}>
        <div className="flex items-center justify-between">
          <span className="text-gray-800 text-sm">Показувати відповіді</span>
          <div className={`w-10 h-6 rounded-full transition-all duration-300 ease-in-out ml-3 ${showAnswers ? 'bg-blue-500' : 'bg-gray-300'}`}>
            <div className={`w-5 h-5 bg-white rounded-full shadow-md transition-all duration-300 ease-in-out ${showAnswers ? 'translate-x-4' : 'translate-x-0.5'} mt-0.5`}></div>
          </div>
        </div>
      </div>

      {/* Розділювальна лінія */}
      <div className="border-t border-gray-200"></div>

      {/* Очистити відповіді */}
      <div className="pl-7 pr-4 py-3 hover:bg-gray-50 cursor-pointer" onClick={onClearAnswers}>
        <span className="text-gray-800 text-sm">Очистити відповіді</span>
      </div>

      {/* Розділювальна лінія */}
      <div className="border-t border-gray-200"></div>

      {/* Видалити усі питання */}
      <div className="pl-7 pr-4 py-3 flex items-center justify-between hover:bg-gray-50 cursor-pointer" onClick={onDeleteAll}>
        <span className="text-red-600 text-sm">Видалити усі питання</span>
        <Trash2 className="w-4 h-4 text-red-600" />
      </div>
    </div>
  );
}
