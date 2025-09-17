'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { Save, ChevronDown, X } from 'lucide-react'

interface ProfileData {
  firstName: string
  lastName: string
  faculty: string
  university: string
  email: string
  step: string
}

const universities = [
  'Харківський національний університет імені В. Н. Каразіна',
  '(КиМУ) Київський міжнародний університет',
  'Черкаська медична академія',
  'Волинський національний університет імені Лесі Українки',
  'Київський національний університет імені Тараса Шевченка',
  'Чорноморський національний університет імені Петра Могили',
  'Харківський міжнародний медичний університет',
  'Міжнародний Європейський Університет',
  '(МАУП) Міжрегіональна Академія управління персоналом',
  'Дніпровський інститут медицини та громадського здоров\'я',
  'Київський міський медичний коледж',
  'Херсонський державний університет',
  'Медичний коледж «Монада»',
  'Івано-Франківський медичний фаховий коледж',
  'Житомирський медичний інститут',
  'Запорізький медичний коледж',
  'КЗВО «Волинський медичний інститут»',
  'Дніпровський базовий медичний коледж',
  'Шепетівський медичний фаховий коледж',
  'Харківський інститут медицини та біомедичних наук',
  '(ЖБФФК) Житомирський базовий фармацевтичний фаховий коледж',
  'Кам\'янець-Подільський медичний фаховий коледж',
  'Кам\'янський медичний коледж',
  'Навчально-науковий інститут медсестринства'
]

export default function ProfileEditForm() {
  console.log('🚀 ProfileEditForm завантажується...')
  
  const { data: session } = useSession()
  const [profileData, setProfileData] = useState<ProfileData>({
    firstName: '',
    lastName: '',
    faculty: 'medical',
    university: '',
    email: '',
    step: 'krok1'
  })
  
  // Debug: логуємо зміни стану
  useEffect(() => {
    console.log('🔄 Стан профілю змінився:', profileData)
  }, [profileData])
  
  const [saving, setSaving] = useState(false)
  const [loading, setLoading] = useState(true)
  const [universityDropdownOpen, setUniversityDropdownOpen] = useState(false)
  const [facultyDropdownOpen, setFacultyDropdownOpen] = useState(false)
  const [stepDropdownOpen, setStepDropdownOpen] = useState(false)
  const [universitySearch, setUniversitySearch] = useState('')
  const [filteredUniversities, setFilteredUniversities] = useState(universities)

  useEffect(() => {
    if (session?.user?.id) {
      console.log('👤 Сесія користувача:', session.user)
      
      // Автоматично заповнюємо всі поля з сесії
      const nameParts = session.user.name?.split(' ') || []
      setProfileData(prev => ({
        ...prev,
        firstName: nameParts[0] || 'Користувач',
        lastName: nameParts.slice(1).join(' ') || 'Користувач',
        email: session.user.email || 'email@example.com',
        faculty: 'medical', // За замовчуванням
        step: 'krok1', // За замовчуванням
        university: prev.university // Залишаємо як є
      }))
      
      fetchProfileData()
    }
  }, [session])

  const fetchProfileData = async () => {
    try {
      setLoading(true)
      console.log('📥 Завантаження даних профілю...')
      
      const response = await fetch('/api/user/profile')
      const data = await response.json()
      
      console.log('📊 Дані профілю з API:', data)
      
      if (data.success && data.profile) {
        const newProfileData = {
          firstName: data.profile.firstName || '',
          lastName: data.profile.lastName || '',
          faculty: data.profile.faculty || 'medical',
          university: data.profile.university || '',
          email: data.profile.email || '',
          step: data.profile.step || 'krok1'
        }
        
        console.log('✅ Встановлюємо дані профілю:', newProfileData)
        setProfileData(newProfileData)
        setUniversitySearch(data.profile.university || '')
      } else {
        console.log('⚠️ Профіль не знайдено, використовуємо базові дані')
      }
    } catch (error) {
      console.error('❌ Помилка завантаження профілю:', error)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    // Фільтруємо університети за пошуковим запитом
    const filtered = universities.filter(uni =>
      uni.toLowerCase().includes(universitySearch.toLowerCase())
    )
    setFilteredUniversities(filtered)
  }, [universitySearch])

  const handleSave = async () => {
    setSaving(true)
    try {
      // Debug: перевіряємо дані перед відправкою
      console.log('📤 Відправляємо дані профілю:', profileData)
      
      // Перевіряємо тільки університет
      if (!profileData.university) {
        console.error('❌ Відсутній університет')
        alert('Будь ласка, оберіть університет')
        return
      }
      
      console.log('🔍 Перевірка полів:', {
        profileData,
        university: profileData.university
      })

      const response = await fetch('/api/user/profile', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(profileData),
      })

      const data = await response.json()
      console.log('📥 Відповідь від API:', data)

      if (response.ok && data.success) {
        alert('Профіль успішно збережено в Supabase!')
        // Перезавантажуємо дані
        fetchProfileData()
      } else {
        throw new Error(data.error || 'Помилка збереження профілю')
      }
    } catch (error) {
      console.error('Error saving profile:', error)
      alert('Помилка збереження профілю: ' + (error instanceof Error ? error.message : 'Невідома помилка'))
    } finally {
      setSaving(false)
    }
  }

  const handleUniversitySelect = (university: string) => {
    setProfileData(prev => ({ ...prev, university }))
    setUniversitySearch(university)
    setUniversityDropdownOpen(false)
  }

  const handleFacultySelect = (faculty: string) => {
    setProfileData(prev => ({ ...prev, faculty }))
    setFacultyDropdownOpen(false)
  }

  const handleStepSelect = (step: string) => {
    setProfileData(prev => ({ ...prev, step }))
    setStepDropdownOpen(false)
  }

  const getFacultyLabel = (faculty: string) => {
    return faculty === 'medical' ? 'Медицина' : 'Фармація'
  }

  const getStepLabel = (step: string) => {
    return step === 'krok1' ? 'Крок 1' : step === 'krok2' ? 'Крок 2' : 'Крок 3'
  }

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded w-1/3 mb-6"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="h-16 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold text-gray-900">Основні дані</h2>
      </div>

      {/* Form */}
      <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-white/60 p-6">
        <div className="space-y-6">
          {/* Тільки поле для університету */}
          <div className="relative">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Заклад освіти <span className="text-red-500">*</span>
            </label>
            <div className="relative">
              <input
                type="text"
                value={universitySearch}
                onChange={(e) => {
                  setUniversitySearch(e.target.value)
                  setUniversityDropdownOpen(true)
                }}
                onFocus={() => setUniversityDropdownOpen(true)}
                className="w-full px-3 py-2 pr-20 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-gray-50"
                placeholder="Введіть назву університету"
              />
              <div className="absolute right-2 top-1/2 transform -translate-y-1/2 flex items-center space-x-1">
                {universitySearch && (
                  <button
                    onClick={() => {
                      setUniversitySearch('')
                      setProfileData(prev => ({ ...prev, university: '' }))
                    }}
                    className="p-1 hover:bg-gray-200 rounded"
                  >
                    <X className="w-4 h-4 text-gray-400" />
                  </button>
                )}
                <button
                  onClick={() => setUniversityDropdownOpen(!universityDropdownOpen)}
                  className="p-1 hover:bg-gray-200 rounded"
                >
                  <ChevronDown className="w-4 h-4 text-gray-400" />
                </button>
              </div>
            </div>
            
            {universityDropdownOpen && (
              <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-50 max-h-60 overflow-y-auto">
                <div className="py-1">
                  {filteredUniversities.map((university) => (
                    <button
                      key={university}
                      onClick={() => handleUniversitySelect(university)}
                      className={`w-full px-3 py-2 text-left hover:bg-gray-100 flex items-center justify-between ${
                        profileData.university === university ? 'bg-blue-50' : ''
                      }`}
                    >
                      <span>{university}</span>
                      {profileData.university === university && (
                        <span className="text-blue-500">✓</span>
                      )}
                    </button>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Інформація про користувача (тільки для перегляду) */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Прізвище, ім'я
              </label>
              <div className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-100 text-gray-600">
                {`${profileData.firstName} ${profileData.lastName}`.trim()}
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <div className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-100 text-gray-600">
                {profileData.email}
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Факультет
              </label>
              <div className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-100 text-gray-600">
                {getFacultyLabel(profileData.faculty)}
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Крок
              </label>
              <div className="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-100 text-gray-600">
                {getStepLabel(profileData.step)}
              </div>
            </div>
          </div>
        </div>

        {/* Save Button */}
        <div className="flex justify-end mt-8">
          <button
            onClick={handleSave}
            disabled={saving}
            className="w-full bg-blue-500/80 backdrop-blur-sm hover:bg-blue-600/90 text-white font-medium py-2 px-4 rounded-lg transition-all duration-300 shadow-sm hover:shadow-md disabled:opacity-50"
          >
            <Save className="w-4 h-4 inline mr-2" />
            {saving ? 'Збереження...' : 'Зберегти університет'}
          </button>
        </div>
      </div>
    </div>
  )
}