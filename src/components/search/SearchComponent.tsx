'use client'

import { useState, useEffect } from 'react'
import { supabase } from '@/lib/supabase'
import { Database } from '@/lib/supabase'
import { Search, BookOpen, FileText, GraduationCap, Clock } from 'lucide-react'

type Course = Database['public']['Tables']['courses']['Row']
type Topic = Database['public']['Tables']['topics']['Row']
type Question = Database['public']['Tables']['questions']['Row']

interface SearchResult {
  id: string
  type: 'course' | 'topic' | 'question'
  title: string
  description?: string
  faculty?: string
  difficulty?: string
  course_title?: string
}

export default function SearchComponent() {
  const [searchQuery, setSearchQuery] = useState('')
  const [searchResults, setSearchResults] = useState<SearchResult[]>([])
  const [isLoading, setIsLoading] = useState(false)

  const searchInDatabase = async (query: string) => {
    if (!query.trim()) {
      setSearchResults([])
      return
    }

    setIsLoading(true)
    try {
      const searchTerm = `%${query.toLowerCase()}%`
      const results: SearchResult[] = []

      if (!supabase) {
        return results
      }

      // Пошук в курсах
      const { data: courses, error: coursesError } = await supabase
        .from('courses')
        .select('*')
        .or(`title.ilike.${searchTerm},description.ilike.${searchTerm}`)
        .eq('is_active', true)

      if (!coursesError && courses) {
        courses.forEach(course => {
          results.push({
            id: course.id,
            type: 'course',
            title: course.title,
            description: course.description || undefined,
            faculty: course.faculty
          })
        })
      }

      // Пошук в темах
      const { data: topics, error: topicsError } = await supabase
        .from('topics')
        .select(`
          *,
          courses!inner(title, faculty)
        `)
        .or(`title.ilike.${searchTerm},description.ilike.${searchTerm},lecture_notes.ilike.${searchTerm}`)
        .eq('is_active', true)

      if (!topicsError && topics) {
        topics.forEach(topic => {
          results.push({
            id: topic.id,
            type: 'topic',
            title: topic.title,
            description: topic.description || undefined,
            faculty: topic.courses.faculty,
            course_title: topic.courses.title
          })
        })
      }

      // Пошук в питаннях
      const { data: questions, error: questionsError } = await supabase
        .from('questions')
        .select(`
          *,
          topics!inner(title, courses!inner(title, faculty))
        `)
        .or(`question_text.ilike.${searchTerm},explanation.ilike.${searchTerm}`)
        .eq('is_active', true)

      if (!questionsError && questions) {
        questions.forEach(question => {
          results.push({
            id: question.id,
            type: 'question',
            title: question.question_text,
            description: question.explanation || undefined,
            faculty: question.topics.courses.faculty,
            course_title: question.topics.courses.title,
            difficulty: question.difficulty
          })
        })
      }

      setSearchResults(results)
    } catch (error) {
      console.error('Помилка пошуку:', error)
      setSearchResults([])
    } finally {
      setIsLoading(false)
    }
  }

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      searchInDatabase(searchQuery)
    }, 300) // Затримка для оптимізації запитів

    return () => clearTimeout(timeoutId)
  }, [searchQuery])

  const getIcon = (type: string) => {
    switch (type) {
      case 'course':
        return <GraduationCap className="w-5 h-5 text-blue-600" />
      case 'topic':
        return <BookOpen className="w-5 h-5 text-green-600" />
      case 'question':
        return <FileText className="w-5 h-5 text-blue-600" />
      default:
        return <Search className="w-5 h-5 text-gray-600" />
    }
  }

  const getTypeLabel = (type: string) => {
    switch (type) {
      case 'course':
        return 'Курс'
      case 'topic':
        return 'Тема'
      case 'question':
        return 'Питання'
      default:
        return 'Невідомо'
    }
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
              Знайди потрібні матеріали за секунди
            </h1>
            <p className="text-xl md:text-2xl text-gray-700">
              <span className="font-bold text-blue-600">Help Krok</span> — твій помічник у підготовці до КРОК
            </p>
          </div>

          {/* Пошукова форма */}
          <div className="mb-8">
            <div className="relative max-w-lg mx-auto">
              <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-500 w-6 h-6" />
              <input
                type="text"
                placeholder="Введіть у пошук слова, які є в питаннях"
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
          <div className="space-y-4">
            <div className="text-center mb-8">
              <h2 className="text-2xl font-semibold text-gray-800">
                Знайдено {searchResults.length} результатів
              </h2>
            </div>

            <div className="grid gap-4">
              {searchResults.map((result) => (
                <div
                  key={`${result.type}-${result.id}`}
                  className="bg-white/80 backdrop-blur-sm rounded-2xl border border-blue-200/50 p-6 hover:shadow-lg hover:bg-white/90 transition-all duration-200"
                >
                  <div className="flex items-start space-x-4">
                    <div className="flex-shrink-0 mt-1">
                      {getIcon(result.type)}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center space-x-3 mb-3">
                        <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                          {getTypeLabel(result.type)}
                        </span>
                        {result.faculty && (
                          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                            {getFacultyLabel(result.faculty)}
                          </span>
                        )}
                        {result.difficulty && (
                          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                            {getDifficultyLabel(result.difficulty)}
                          </span>
                        )}
                      </div>
                      <h3 className="text-xl font-semibold text-gray-900 mb-2">
                        {result.title}
                      </h3>
                      {result.description && (
                        <p className="text-gray-600 mb-3 line-clamp-2">
                          {result.description}
                        </p>
                      )}
                      {result.course_title && (
                        <p className="text-sm text-gray-500">
                          Курс: {result.course_title}
                        </p>
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
