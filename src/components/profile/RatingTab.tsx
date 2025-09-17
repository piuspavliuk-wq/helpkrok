'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { Trophy, Medal, Star, Crown, Award, TrendingUp } from 'lucide-react'

interface UserRanking {
  id: string
  name: string
  avatar?: string
  faculty: string
  totalScore: number
  testsCompleted: number
  averageScore: number
  rank: number
  points: number
  achievements: number
}

interface RankingData {
  currentUser: UserRanking
  topUsers: UserRanking[]
  facultyRanking: {
    medical: UserRanking[]
    pharmaceutical: UserRanking[]
  }
  achievements: Array<{
    id: string
    title: string
    description: string
    icon: string
    points: number
    unlocked: boolean
    unlockedAt?: string
  }>
}

export default function RatingTab() {
  const { data: session } = useSession()
  const [rankingData, setRankingData] = useState<RankingData | null>(null)
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState<'overall' | 'medical' | 'pharmaceutical'>('overall')

  useEffect(() => {
    if (session?.user?.id) {
      fetchRankingData()
    }
  }, [session])

  const fetchRankingData = async () => {
    try {
      setLoading(true)
      const response = await fetch('/api/user/ranking')
      const data = await response.json()
      
      if (data.success) {
        setRankingData(data.rankingData)
      } else {
        // Fallback mock data
        setRankingData({
          currentUser: {
            id: session?.user?.id || '1',
            name: session?.user?.name || 'Ви',
            avatar: session?.user?.image || undefined,
            faculty: 'medical',
            totalScore: 1250,
            testsCompleted: 12,
            averageScore: 78.5,
            rank: 15,
            points: 1250,
            achievements: 8
          },
          topUsers: [
            {
              id: '2',
              name: 'Олександр Петренко',
              faculty: 'medical',
              totalScore: 2450,
              testsCompleted: 25,
              averageScore: 92.5,
              rank: 1,
              points: 2450,
              achievements: 15
            },
            {
              id: '3',
              name: 'Марія Коваленко',
              faculty: 'medical',
              totalScore: 2380,
              testsCompleted: 23,
              averageScore: 91.2,
              rank: 2,
              points: 2380,
              achievements: 14
            },
            {
              id: '4',
              name: 'Дмитро Іваненко',
              faculty: 'pharmaceutical',
              totalScore: 2200,
              testsCompleted: 22,
              averageScore: 89.1,
              rank: 3,
              points: 2200,
              achievements: 12
            }
          ],
          facultyRanking: {
            medical: [
              {
                id: '2',
                name: 'Олександр Петренко',
                faculty: 'medical',
                totalScore: 2450,
                testsCompleted: 25,
                averageScore: 92.5,
                rank: 1,
                points: 2450,
                achievements: 15
              },
              {
                id: '3',
                name: 'Марія Коваленко',
                faculty: 'medical',
                totalScore: 2380,
                testsCompleted: 23,
                averageScore: 91.2,
                rank: 2,
                points: 2380,
                achievements: 14
              }
            ],
            pharmaceutical: [
              {
                id: '4',
                name: 'Дмитро Іваненко',
                faculty: 'pharmaceutical',
                totalScore: 2200,
                testsCompleted: 22,
                averageScore: 89.1,
                rank: 1,
                points: 2200,
                achievements: 12
              }
            ]
          },
          achievements: [
            {
              id: 'first_test',
              title: 'Перший крок',
              description: 'Пройдіть свій перший тест',
              icon: '🎯',
              points: 50,
              unlocked: true,
              unlockedAt: '2024-01-10T10:00:00Z'
            },
            {
              id: 'perfect_score',
              title: 'Ідеальний результат',
              description: 'Отримайте 100% в тесті',
              icon: '⭐',
              points: 100,
              unlocked: false
            },
            {
              id: 'streak_7',
              title: 'Тиждень навчання',
              description: 'Навчайтеся 7 днів поспіль',
              icon: '🔥',
              points: 75,
              unlocked: true,
              unlockedAt: '2024-01-15T10:00:00Z'
            },
            {
              id: 'top_10',
              title: 'Топ-10',
              description: 'Потрапте в топ-10 рейтингу',
              icon: '🏆',
              points: 200,
              unlocked: false
            }
          ]
        })
      }
    } catch (error) {
      console.error('Error fetching ranking data:', error)
    } finally {
      setLoading(false)
    }
  }

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Crown className="w-5 h-5 text-yellow-500" />
    if (rank === 2) return <Medal className="w-5 h-5 text-gray-400" />
    if (rank === 3) return <Award className="w-5 h-5 text-amber-600" />
    return <span className="text-sm font-medium text-gray-600">#{rank}</span>
  }

  const getFacultyColor = (faculty: string) => {
    return faculty === 'medical' ? 'text-blue-600' : 'text-green-600'
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded w-1/3 mb-4"></div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {[...Array(3)].map((_, i) => (
              <div key={i} className="h-32 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  if (!rankingData) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-600">Не вдалося завантажити рейтинг</p>
      </div>
    )
  }

  const currentRanking = activeTab === 'overall' 
    ? rankingData.topUsers 
    : rankingData.facultyRanking[activeTab]

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold text-gray-900">Рейтинг</h2>
        <div className="flex gap-2">
          {(['overall', 'medical', 'pharmaceutical'] as const).map((tab) => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={`px-3 py-1 rounded-md text-sm font-medium transition-colors ${
                activeTab === tab
                  ? 'bg-blue-500 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {tab === 'overall' ? 'Загальний' : tab === 'medical' ? 'Медицина' : 'Фармація'}
            </button>
          ))}
        </div>
      </div>

      {/* Current User Stats */}
      <div className="bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg p-6 text-white">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-4">
            <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center">
              <Trophy className="w-8 h-8" />
            </div>
            <div>
              <h3 className="text-xl font-bold">{rankingData.currentUser.name}</h3>
              <p className="text-blue-100">
                {rankingData.currentUser.faculty === 'medical' ? 'Медичний факультет' : 'Фармацевтичний факультет'}
              </p>
            </div>
          </div>
          <div className="text-right">
            <div className="mb-2">
              <span className="text-2xl font-bold">{rankingData.currentUser.points}</span>
            </div>
            <p className="text-blue-100">очок</p>
          </div>
        </div>
        
        <div className="grid grid-cols-2 gap-4 mt-6">
          <div className="text-center">
            <p className="text-2xl font-bold">{rankingData.currentUser.testsCompleted}</p>
            <p className="text-blue-100 text-sm">Тестів пройдено</p>
          </div>
          <div className="text-center">
            <p className="text-2xl font-bold">{rankingData.currentUser.averageScore.toFixed(1)}%</p>
            <p className="text-blue-100 text-sm">Середній бал</p>
          </div>
        </div>
      </div>

      {/* Ranking Table */}
      <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">
          {activeTab === 'overall' ? 'Загальний рейтинг' : 
           activeTab === 'medical' ? 'Рейтинг медичного факультету' : 
           'Рейтинг фармацевтичного факультету'}
        </h3>
        
        <div className="space-y-3">
          {currentRanking.map((user, index) => (
            <div 
              key={user.id}
              className={`flex items-center justify-between p-4 rounded-lg ${
                user.id === rankingData.currentUser.id 
                  ? 'bg-blue-50 border-2 border-blue-200' 
                  : 'bg-gray-50/50 hover:bg-gray-100/50'
              }`}
            >
              <div className="flex items-center space-x-4">
                <div className="flex items-center justify-center w-8 h-8">
                  {getRankIcon(user.rank)}
                </div>
                <div className="w-10 h-10 bg-gray-200 rounded-full flex items-center justify-center">
                  <span className="text-sm font-medium text-gray-600">
                    {user.name.charAt(0).toUpperCase()}
                  </span>
                </div>
                <div>
                  <p className="font-medium text-gray-900">{user.name}</p>
                  <p className={`text-sm ${getFacultyColor(user.faculty)}`}>
                    {user.faculty === 'medical' ? 'Медицина' : 'Фармація'}
                  </p>
                </div>
              </div>
              
              <div className="flex items-center space-x-6">
                <div className="text-center">
                  <p className="text-sm text-gray-500">Тестів</p>
                  <p className="font-medium text-gray-900">{user.testsCompleted}</p>
                </div>
                <div className="text-center">
                  <p className="text-sm text-gray-500">Середній бал</p>
                  <p className="font-medium text-gray-900">{user.averageScore.toFixed(1)}%</p>
                </div>
                <div className="text-center">
                  <p className="text-sm text-gray-500">Очки</p>
                  <p className="font-bold text-gray-900">{user.points}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>


    </div>
  )
}
