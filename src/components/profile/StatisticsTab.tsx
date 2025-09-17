'use client'

import { Info } from 'lucide-react'

export default function StatisticsTab() {
  // Mock data for statistics
  const statistics = {
    correctAnswers: 3319,
    incorrectAnswers: 464,
    averagePercentage: 88.2,
    ratioPercentage: 87.7,
    totalTests: 96
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      {/* Правильні відповіді */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="text-center">
          <p className="text-sm font-medium text-gray-600 mb-2">Правильні відповіді</p>
          <p className="text-3xl font-bold text-blue-600">{statistics.correctAnswers}</p>
        </div>
      </div>

      {/* Хибні відповіді */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="text-center">
          <p className="text-sm font-medium text-gray-600 mb-2">Хибні відповіді</p>
          <p className="text-3xl font-bold text-blue-600">{statistics.incorrectAnswers}</p>
        </div>
      </div>

      {/* Середній % */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="text-center">
          <div className="flex items-center justify-center gap-1 mb-2">
            <p className="text-sm font-medium text-gray-600">Середній %</p>
            <Info className="w-4 h-4 text-gray-400" />
          </div>
          <p className="text-3xl font-bold text-blue-600">{statistics.averagePercentage}%</p>
        </div>
      </div>

      {/* Співвідношення % */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="text-center">
          <div className="flex items-center justify-center gap-1 mb-2">
            <p className="text-sm font-medium text-gray-600">Співвідношення %</p>
            <Info className="w-4 h-4 text-gray-400" />
          </div>
          <p className="text-3xl font-bold text-blue-600">{statistics.ratioPercentage}%</p>
        </div>
      </div>

      {/* Тестів */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="text-center">
          <p className="text-sm font-medium text-gray-600 mb-2">Тестів</p>
          <p className="text-3xl font-bold text-blue-600">{statistics.totalTests}</p>
        </div>
      </div>
    </div>
  )
}
