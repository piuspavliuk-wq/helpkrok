'use client'

import { useState } from 'react'
import { Clock, Flag, Trophy } from 'lucide-react'

interface TestCardProps {
  id: string
  title: string
  totalQuestions: number
  completedQuestions?: number
  bestScore?: number
  hasProgress?: boolean
  isCompleted?: boolean
  onStartTest: (testId: string) => void
}

export function TestCard({
  id,
  title,
  totalQuestions,
  completedQuestions = 0,
  bestScore,
  hasProgress = false,
  isCompleted = false,
  onStartTest
}: TestCardProps) {
  const progressPercentage = totalQuestions > 0 ? (completedQuestions / totalQuestions) * 100 : 0

  return (
    <div className="bg-white/30 backdrop-blur-sm rounded-lg shadow-sm border border-white/40 p-6 hover:shadow-md hover:bg-white/40 transition-all duration-300">
      {/* Best Score Banner */}
      {bestScore && (
        <div className="bg-yellow-100/80 backdrop-blur-sm border border-yellow-200/60 rounded-md px-3 py-2 mb-4 shadow-sm">
          <div className="flex items-center gap-2">
            <Trophy className="w-4 h-4 text-yellow-600" />
            <span className="text-sm font-medium text-yellow-800">
              Найкращий результат: {bestScore}%
            </span>
          </div>
        </div>
      )}

      {/* Test Title */}
      <h3 className="text-lg font-semibold text-gray-900 mb-3">{title}</h3>

      {/* Progress Info */}
      {hasProgress && (
        <div className="mb-4">
          <div className="flex items-center justify-between text-sm text-gray-600 mb-2">
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4" />
              <span>{completedQuestions}/{totalQuestions}</span>
            </div>
            <span className="font-medium text-blue-600">
              {Math.round(progressPercentage)}%
            </span>
          </div>
          
          {/* Progress Bar */}
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div 
              className="bg-blue-500 h-2 rounded-full transition-all duration-300"
              style={{ width: `${progressPercentage}%` }}
            />
          </div>
        </div>
      )}

      {/* Question Count (if no progress) */}
      {!hasProgress && (
        <div className="text-sm text-gray-500 mb-4">
          {totalQuestions} питань
        </div>
      )}

      {/* Flags for completed tests */}
      {isCompleted && (
        <div className="flex items-center gap-2 mb-4">
          <div className="flex items-center gap-1">
            <Flag className="w-4 h-4 text-green-600" />
            <span className="text-sm text-green-600 font-medium">3</span>
          </div>
        </div>
      )}

      {/* Action Button */}
      <button
        onClick={() => onStartTest(id)}
        className="w-full bg-blue-500/80 backdrop-blur-sm hover:bg-blue-600/90 text-white font-medium py-2 px-4 rounded-lg transition-all duration-300 shadow-sm hover:shadow-md"
      >
        {hasProgress && completedQuestions > 0 ? 'Продовжити' : 'Почати спробу'}
      </button>
    </div>
  )
}
