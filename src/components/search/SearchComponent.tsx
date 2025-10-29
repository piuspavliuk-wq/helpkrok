'use client'

import { useState, useEffect } from 'react'
import { Search, BookOpen, FileText, GraduationCap, Clock, TestTube, Microscope, Heart, Pill } from 'lucide-react'
import SearchFilters from './SearchFilters'

interface SearchResult {
  id: string
  question_text: string
  source_table: string
  source_type: string
  faculty: string
  year?: number
  category?: string
  option_a?: string
  option_b?: string
  option_c?: string
  option_d?: string
  option_e?: string
  correct_answer?: string
  difficulty?: string
}

interface SearchFilters {
  faculty?: string
  year?: number
  sourceType?: string
  difficulty?: string
}

export default function SearchComponent() {
  const [searchQuery, setSearchQuery] = useState('')
  const [searchResults, setSearchResults] = useState<SearchResult[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [filters, setFilters] = useState<SearchFilters>({})
  const [sources, setSources] = useState<string[]>([])

  const searchInDatabase = async (query: string, currentFilters: SearchFilters = {}) => {
    if (!query.trim()) {
      setSearchResults([])
      setSources([])
      return
    }

    // Перевіряємо мінімальну довжину запиту
    if (query.trim().length < 2) {
      console.warn('Пошуковий запит занадто короткий')
      setSearchResults([])
      setSources([])
      return
    }

    setIsLoading(true)
    try {
      const params = new URLSearchParams({
        q: query.trim(),
        limit: '50'
      })

      // Додаємо фільтри до запиту
      if (currentFilters.faculty) params.append('faculty', currentFilters.faculty)
      if (currentFilters.year) params.append('year', currentFilters.year.toString())
      if (currentFilters.sourceType) params.append('sourceType', currentFilters.sourceType)
      if (currentFilters.difficulty) params.append('difficulty', currentFilters.difficulty)

      console.log('Searching with params:', params.toString())

      const response = await fetch(`/api/search?${params.toString()}`)
      
      if (response.ok) {
        const data = await response.json()
        console.log('Search results:', data)
        setSearchResults(data.results || [])
        setSources(data.sources || [])
        
        // Скрол до першого результату після завантаження
        if (data.results && data.results.length > 0) {
          setTimeout(() => {
            const firstResult = document.querySelector('[data-search-result="0"]')
            if (firstResult) {
              firstResult.scrollIntoView({ 
                behavior: 'smooth', 
                block: 'start',
                inline: 'nearest'
              })
            } else {
              // Альтернативний спосіб - скрол до секції результатів
              const resultsSection = document.querySelector('[data-results-section]')
              if (resultsSection) {
                resultsSection.scrollIntoView({ 
                  behavior: 'smooth', 
                  block: 'start'
                })
              }
            }
          }, 100) // Невелика затримка для рендерингу
        }
      } else {
        const errorData = await response.json().catch(() => ({}))
        console.error('Помилка API пошуку:', response.status, response.statusText, errorData)
        setSearchResults([])
        setSources([])
      }
    } catch (error) {
      console.error('Помилка пошуку:', error)
      setSearchResults([])
      setSources([])
    } finally {
      setIsLoading(false)
    }
  }

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      searchInDatabase(searchQuery, filters)
    }, 300) // Затримка для оптимізації запитів

    return () => clearTimeout(timeoutId)
  }, [searchQuery, filters])

  const handleFiltersChange = (newFilters: SearchFilters) => {
    setFilters(newFilters)
    
    // Скрол до результатів при зміні фільтрів
    if (searchQuery.trim().length >= 2) {
      setTimeout(() => {
        const resultsSection = document.querySelector('[data-results-section]')
        if (resultsSection) {
          resultsSection.scrollIntoView({ 
            behavior: 'smooth', 
            block: 'start'
          })
        }
      }, 200)
    }
  }

  const getIcon = (sourceType: string) => {
    switch (sourceType) {
      case 'КРОК тести':
        return <GraduationCap className="w-5 h-5 text-blue-600" />
      case 'Анатомія':
        return <Heart className="w-5 h-5 text-red-600" />
      case 'Біологія':
        return <Microscope className="w-5 h-5 text-green-600" />
      case 'Біохімія':
        return <TestTube className="w-5 h-5 text-yellow-600" />
      case 'Фармакологія':
      case 'Фармацевтичні тести':
        return <Pill className="w-5 h-5 text-purple-600" />
      default:
        return <FileText className="w-5 h-5 text-gray-600" />
    }
  }

  const getTypeLabel = (sourceType: string) => {
    return sourceType
  }

  const getFacultyLabel = (faculty?: string) => {
    switch (faculty) {
      case 'medical':
        return 'Медичний'
      case 'pharmaceutical':
        return 'Фармацевтичний'
      default:
        return ''
    }
  }

  const getDifficultyLabel = (difficulty?: string) => {
    switch (difficulty) {
      case 'easy':
        return 'Легкий'
      case 'medium':
        return 'Середній'
      case 'hard':
        return 'Важкий'
      default:
        return ''
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-blue-50 to-blue-100 relative overflow-hidden">
      {/* Фонові візерунки */}
      <div className="absolute inset-0 opacity-30">
        <div className="absolute top-20 left-20 w-32 h-32 border border-blue-200 rounded-full animate-pulse"></div>
        <div className="absolute top-40 right-32 w-24 h-24 border border-blue-200 rounded-full animate-pulse delay-1000"></div>
        <div className="absolute bottom-32 left-40 w-40 h-40 border border-blue-200 rounded-full animate-pulse delay-2000"></div>
        <div className="absolute bottom-20 right-20 w-28 h-28 border border-blue-200 rounded-full animate-pulse delay-500"></div>
        <div className="absolute top-1/2 left-1/4 w-20 h-20 border border-blue-200 rounded-full animate-pulse delay-1500"></div>
        <div className="absolute top-1/3 right-1/4 w-36 h-36 border border-blue-200 rounded-full animate-pulse delay-3000"></div>
      </div>

      <div className="relative z-10 flex flex-col items-center justify-center min-h-screen px-4">
        <div className="max-w-2xl w-full text-center">
          {/* Заголовок */}
          <div className="mb-12">
            <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4 leading-tight">
              Пошук тестів по словах
            </h1>
            <p className="text-xl md:text-2xl text-gray-700">
              Знайди потрібні питання з усіх баз даних (КРОК, анатомія, біологія, фармакологія та інші)
            </p>
          </div>

          {/* Пошукова форма */}
          <div className="mb-8">
            <div className="relative max-w-lg mx-auto">
              <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-500 w-6 h-6" />
              <input
                type="text"
                placeholder="Введіть ключові слова для пошуку тестів (наприклад: серце, кров, ліки, бактерії)"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-12 pr-6 py-4 text-lg bg-white/80 backdrop-blur-sm border border-blue-200/50 rounded-2xl focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-200 shadow-lg"
              />
            </div>
          </div>

        </div>
      </div>

      {/* Результати пошуку */}
      <div className="relative z-10 max-w-4xl mx-auto px-4 pb-8">
        {/* Фільтри */}
        {searchQuery && (
          <SearchFilters
            onFiltersChange={handleFiltersChange}
            totalResults={searchResults.length}
            sources={sources}
          />
        )}
        {isLoading && (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-10 w-10 border-2 border-blue-200 border-t-blue-600"></div>
            <span className="ml-3 text-gray-600 text-lg">Пошук...</span>
          </div>
        )}

        {!isLoading && searchQuery && searchResults.length === 0 && (
          <div className="text-center py-16">
            <div className="w-20 h-20 bg-white/60 backdrop-blur-sm rounded-full flex items-center justify-center mx-auto mb-6">
              <Search className="w-10 h-10 text-gray-400" />
            </div>
            <h3 className="text-xl font-semibold text-gray-800 mb-2">Результатів не знайдено</h3>
            <p className="text-gray-600 mb-2">За запитом "{searchQuery}" матеріалів не знайдено</p>
            <p className="text-sm text-gray-500">Спробуй інші ключові слова або зміни фільтр пошуку</p>
          </div>
        )}

        {!isLoading && searchResults.length > 0 && (
          <div className="space-y-4" data-results-section>
            <div className="text-center mb-8">
              <h2 className="text-2xl font-semibold text-gray-800">
                Знайдено {searchResults.length} питань
              </h2>
            </div>

            <div className="grid gap-4">
              {searchResults.map((result, index) => (
                <div
                  key={`${result.source_table}-${result.id}`}
                  data-search-result={index}
                  className="bg-white/80 backdrop-blur-sm rounded-2xl border border-blue-200/50 p-6 hover:shadow-lg hover:bg-white/90 transition-all duration-200"
                >
                  <div className="flex items-start space-x-4">
                    <div className="flex-shrink-0 mt-1">
                      {getIcon(result.source_type)}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center space-x-3 mb-3">
                        <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                          {getTypeLabel(result.source_type)}
                        </span>
                        {result.faculty && (
                          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                            {getFacultyLabel(result.faculty)}
                          </span>
                        )}
                        {result.year && (
                          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-800">
                            {result.year}
                          </span>
                        )}
                        {result.category && (
                          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-orange-100 text-orange-800">
                            {result.category}
                          </span>
                        )}
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 mb-3">
                        {result.question_text}
                      </h3>
                      
                      {/* Варіанти відповідей */}
                      {(result.option_a || result.option_b || result.option_c || result.option_d || result.option_e) && (
                        <div className="space-y-2 mb-4">
                          <h4 className="text-sm font-medium text-gray-700">Варіанти відповідей:</h4>
                          <div className="grid gap-2">
                            {result.option_a && (
                              <div className="flex items-center space-x-2">
                                <span className="w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-xs font-medium">A</span>
                                <span className="text-sm text-gray-700">{result.option_a}</span>
                              </div>
                            )}
                            {result.option_b && (
                              <div className="flex items-center space-x-2">
                                <span className="w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-xs font-medium">B</span>
                                <span className="text-sm text-gray-700">{result.option_b}</span>
                              </div>
                            )}
                            {result.option_c && (
                              <div className="flex items-center space-x-2">
                                <span className="w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-xs font-medium">C</span>
                                <span className="text-sm text-gray-700">{result.option_c}</span>
                              </div>
                            )}
                            {result.option_d && (
                              <div className="flex items-center space-x-2">
                                <span className="w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-xs font-medium">D</span>
                                <span className="text-sm text-gray-700">{result.option_d}</span>
                              </div>
                            )}
                            {result.option_e && (
                              <div className="flex items-center space-x-2">
                                <span className="w-6 h-6 bg-blue-100 text-blue-800 rounded-full flex items-center justify-center text-xs font-medium">E</span>
                                <span className="text-sm text-gray-700">{result.option_e}</span>
                              </div>
                            )}
                          </div>
                        </div>
                      )}
                      
                      {result.correct_answer && (
                        <div className="text-sm text-green-700 font-medium">
                          Правильна відповідь: {result.correct_answer}
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {!isLoading && !searchQuery && (
          <div className="text-center py-20">
            <div className="w-24 h-24 bg-white/60 backdrop-blur-sm rounded-full flex items-center justify-center mx-auto mb-8">
              <Search className="w-12 h-12 text-gray-300" />
            </div>
            <h3 className="text-2xl font-semibold text-gray-800 mb-3">Готовий до пошуку?</h3>
            <p className="text-gray-600 text-lg">Введи ключові слова в поле пошуку та знайди потрібні матеріали</p>
          </div>
        )}
      </div>
    </div>
  )
}
