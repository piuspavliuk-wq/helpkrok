'use client'

import { useState } from 'react'
import { Filter, X, Calendar, GraduationCap, BookOpen } from 'lucide-react'

interface SearchFiltersProps {
  onFiltersChange: (filters: SearchFilters) => void
  totalResults: number
  sources: string[]
}

interface SearchFilters {
  faculty?: string
  year?: number
  sourceType?: string
  difficulty?: string
}

export default function SearchFilters({ onFiltersChange, totalResults, sources }: SearchFiltersProps) {
  const [isOpen, setIsOpen] = useState(false)
  const [filters, setFilters] = useState<SearchFilters>({})

  const handleFilterChange = (key: keyof SearchFilters, value: string | number | undefined) => {
    const newFilters = { ...filters, [key]: value }
    setFilters(newFilters)
    onFiltersChange(newFilters)
  }

  const clearFilters = () => {
    setFilters({})
    onFiltersChange({})
  }

  const hasActiveFilters = Object.values(filters).some(value => value !== undefined)

  return (
    <div className="mb-6">
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center space-x-4">
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="flex items-center space-x-2 px-4 py-2 bg-blue-100 text-blue-700 rounded-lg hover:bg-blue-200 transition-colors"
          >
            <Filter className="w-4 h-4" />
            <span>Фільтри</span>
            {hasActiveFilters && (
              <span className="w-2 h-2 bg-blue-600 rounded-full"></span>
            )}
          </button>
          
          {hasActiveFilters && (
            <button
              onClick={clearFilters}
              className="flex items-center space-x-2 px-3 py-2 text-gray-600 hover:text-gray-800 transition-colors"
            >
              <X className="w-4 h-4" />
              <span>Очистити</span>
            </button>
          )}
        </div>

        <div className="text-sm text-gray-600">
          Знайдено {totalResults} питань
        </div>
      </div>

      {isOpen && (
        <div className="bg-white/80 backdrop-blur-sm rounded-xl border border-blue-200/50 p-6 space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            {/* Факультет */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                <GraduationCap className="w-4 h-4 inline mr-1" />
                Факультет
              </label>
              <select
                value={filters.faculty || ''}
                onChange={(e) => handleFilterChange('faculty', e.target.value || undefined)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-transparent"
              >
                <option value="">Всі факультети</option>
                <option value="medical">Медичний</option>
                <option value="pharmaceutical">Фармацевтичний</option>
              </select>
            </div>

            {/* Рік */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                <Calendar className="w-4 h-4 inline mr-1" />
                Рік
              </label>
              <select
                value={filters.year || ''}
                onChange={(e) => handleFilterChange('year', e.target.value ? parseInt(e.target.value) : undefined)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-transparent"
              >
                <option value="">Всі роки</option>
                <option value="2024">2024</option>
                <option value="2023">2023</option>
                <option value="2022">2022</option>
                <option value="2021">2021</option>
                <option value="2020">2020</option>
                <option value="2019">2019</option>
                <option value="2018">2018</option>
                <option value="2017">2017</option>
                <option value="2016">2016</option>
                <option value="2015">2015</option>
                <option value="2014">2014</option>
                <option value="2013">2013</option>
                <option value="2012">2012</option>
                <option value="2011">2011</option>
                <option value="2010">2010</option>
                <option value="2009">2009</option>
                <option value="2008">2008</option>
                <option value="2007">2007</option>
                <option value="2006">2006</option>
              </select>
            </div>

            {/* Тип джерела */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                <BookOpen className="w-4 h-4 inline mr-1" />
                Тип тесту
              </label>
              <select
                value={filters.sourceType || ''}
                onChange={(e) => handleFilterChange('sourceType', e.target.value || undefined)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-transparent"
              >
                <option value="">Всі типи</option>
                <option value="КРОК тести">КРОК тести</option>
                <option value="Анатомія">Анатомія</option>
                <option value="Біологія">Біологія</option>
                <option value="Біохімія">Біохімія</option>
                <option value="Гістологія">Гістологія</option>
                <option value="Мікробіологія">Мікробіологія</option>
                <option value="Патологія">Патологія</option>
                <option value="Патологічна фізіологія">Патологічна фізіологія</option>
                <option value="Патоморфологія">Патоморфологія</option>
                <option value="Фармакологія">Фармакологія</option>
                <option value="Фізіологія">Фізіологія</option>
                <option value="Фармацевтичні тести">Фармацевтичні тести</option>
              </select>
            </div>

            {/* Складність */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Складність
              </label>
              <select
                value={filters.difficulty || ''}
                onChange={(e) => handleFilterChange('difficulty', e.target.value || undefined)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-400 focus:border-transparent"
              >
                <option value="">Всі рівні</option>
                <option value="easy">Легкий</option>
                <option value="medium">Середній</option>
                <option value="hard">Важкий</option>
              </select>
            </div>
          </div>

        </div>
      )}
    </div>
  )
}
