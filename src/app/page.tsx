'use client'

import { GraduationCap, BookOpen, Users, Award, CheckCircle, Star } from 'lucide-react'
import { useSession } from 'next-auth/react'
import Link from 'next/link'
import Image from 'next/image'

export default function Home() {
  const { data: session, status } = useSession()

  return (
    <div className="min-h-screen bg-background">
      {/* Hero Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto text-center">
          {/* Logo */}
          <div className="mb-8 flex flex-col items-center">
            <Image 
              src="/logo-original.png" 
              alt="Help Krok Logo" 
              width={120} 
              height={120}
              className="w-30 h-30 mb-4"
            />
            <h2 className="text-3xl font-bold mb-2" style={{color: '#4C1D95'}}>HelpKrok</h2>
            <p className="text-lg" style={{color: '#8B5CF6'}}>by j.helpNMU</p>
          </div>
          
          <h1 className="text-4xl md:text-6xl font-bold text-gray-900 mb-6">
            Підготовка до <span className="text-gradient">КРОК</span>
          </h1>
          <p className="text-xl text-gray-600 mb-8 max-w-3xl mx-auto">
            Сучасна платформа для підготовки студентів медичного та фармацевтичного факультетів до складання екзаменів КРОК
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            {session ? (
              <Link href="/profile" className="btn-primary text-lg px-8 py-4 inline-block">
                Перейти до панелі
              </Link>
            ) : (
              <Link href="/auth/signin" className="btn-primary text-lg px-8 py-4 inline-block">
                Увійти в систему
              </Link>
            )}
            <Link href="#pricing" className="btn-outline text-lg px-8 py-4">
              Дізнатися більше
            </Link>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Чому обирають Help Krok?
            </h2>
            <p className="text-xl text-gray-600 max-w-2xl mx-auto">
              Комплексний підхід до підготовки з використанням сучасних технологій
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <BookOpen className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Відеолекції</h3>
              <p className="text-gray-600">
                Якісні відеолекції з можливістю контролю прогресу та повторного перегляду
              </p>
            </div>

            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <CheckCircle className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Інтерактивні тести</h3>
              <p className="text-gray-600">
                Тести з правилом 80% для успішного проходження та детальною аналітикою помилок
              </p>
            </div>

            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <Award className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">КРОК симуляція</h3>
              <p className="text-gray-600">
                150 випадкових питань за 2.5 години для максимально реалістичної підготовки
              </p>
            </div>

            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <Users className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Персональний прогрес</h3>
              <p className="text-gray-600">
                Детальна аналітика успішності з рекомендаціями по слабких місцях
              </p>
            </div>

            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <Star className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Буклети за роками</h3>
              <p className="text-gray-600">
                Архів тестів з 2006 по 2025 рік для комплексної підготовки
              </p>
            </div>

            <div className="card p-8 text-center">
              <div className="bg-primary-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <GraduationCap className="h-8 w-8 text-primary-500" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 mb-4">Два факультети</h3>
              <p className="text-gray-600">
                Спеціалізовані курси для медичного та фармацевтичного факультетів
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Pricing Section */}
      <section id="pricing" className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Тарифні плани
            </h2>
            <p className="text-xl text-gray-600">
              Оберіть план, який підходить саме вам
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 items-stretch">
            {/* VIP Premium */}
            <div className="card p-6 border-2 border-primary-500 relative flex flex-col">
              <div className="absolute -top-3 left-1/2 transform -translate-x-1/2">
                <span className="bg-primary-500 text-white px-3 py-1 rounded-full text-xs font-medium">
                  🔥 VIP Premium
                </span>
              </div>
              <h3 className="text-xl font-bold text-gray-900 mb-3">VIP Premium</h3>
              <div className="text-2xl font-bold text-gray-900 mb-4">
                <div>Медицина: 14 500 ₴</div>
                <div className="text-lg text-gray-600">Фармація: 11 500 ₴</div>
              </div>
              <ul className="space-y-2 mb-6 text-sm">
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підготовка до української частини
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підготовка до англійської частини
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Доступ до всіх матеріалів
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Онлайн-заняття з викладачами
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Необмежена імітація КРОК
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підтримка в чаті
                </li>
              </ul>
              <button className="bg-gradient-to-r from-[#1128C6] to-[#D23DE3] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200 w-full mt-auto">
                Обрати VIP Premium
              </button>
            </div>

            {/* Premium Standard */}
            <div className="card p-6 border-2 border-blue-300 relative flex flex-col">
              <div className="absolute -top-3 left-1/2 transform -translate-x-1/2">
                <span className="bg-blue-500 text-white px-3 py-1 rounded-full text-xs font-medium">
                  🌟 Premium Standard
                </span>
              </div>
              <h3 className="text-xl font-bold text-gray-900 mb-3">Premium Standard</h3>
              <div className="text-2xl font-bold text-gray-900 mb-4">
                <div>Медицина: 10 000 ₴</div>
                <div className="text-lg text-gray-600">Фармація: 9 000 ₴</div>
              </div>
              <ul className="space-y-2 mb-6 text-sm">
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підготовка до української частини
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Доступ до матеріалів платформи
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Онлайн-заняття
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Необмежена імітація КРОК
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підтримка в чаті
                </li>
              </ul>
              <button className="bg-[#1128C6] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200 w-full mt-auto">
                Обрати Premium
              </button>
            </div>

            {/* Standard */}
            <div className="card p-6 flex flex-col">
              <h3 className="text-xl font-bold text-gray-900 mb-3">📘 Standard</h3>
              <div className="text-2xl font-bold text-gray-900 mb-4">
                <div>Медицина: 8 500 ₴</div>
                <div className="text-lg text-gray-600">Фармація: 7 500 ₴</div>
              </div>
              <ul className="space-y-2 mb-6 text-sm">
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підготовка до української частини
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Доступ до матеріалів платформи
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Імітація КРОК (до 3 спроб/день)
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підтримка в чаті
                </li>
              </ul>
              <button className="bg-[#1128C6] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200 w-full mt-auto">
                Обрати Standard
              </button>
            </div>

            {/* Базове самоопрацювання */}
            <div className="card p-6 flex flex-col">
              <h3 className="text-xl font-bold text-gray-900 mb-3">📚 Базове самоопрацювання</h3>
              <div className="text-2xl font-bold text-gray-900 mb-4">
                <div>Медицина: 6 500 ₴</div>
                <div className="text-lg text-gray-600">Фармація: 5 500 ₴</div>
              </div>
              <ul className="space-y-2 mb-6 text-sm">
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Підготовка до української частини
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Доступ до матеріалів платформи
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Імітація КРОК (до 2 спроб/день)
                </li>
              </ul>
              <button className="bg-[#1128C6] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200 w-full mt-auto">
                Обрати Базовий
              </button>
            </div>

            {/* Randomizer PRO */}
            <div className="card p-6 border border-purple-200 flex flex-col">
              <h3 className="text-xl font-bold text-gray-900 mb-3">🎯 Randomizer PRO</h3>
              <div className="text-2xl font-bold text-gray-900 mb-4">
                <div>180 ₴ за спробу</div>
                <div className="text-sm text-gray-600">5 спроб: 650 ₴ | 10 спроб: 1 450 ₴</div>
              </div>
              <ul className="space-y-2 mb-6 text-sm">
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Повна імітація КРОК-тесту
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Автоматичний підрахунок результатів
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Збереження спроби в кабінеті
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Пояснення з теорією
                </li>
                <li className="flex items-start">
                  <CheckCircle className="h-4 w-4 text-success-500 mr-2 mt-0.5 flex-shrink-0" />
                  Перехід до лекцій
                </li>
              </ul>
              <button className="bg-[#1128C6] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200 w-full mt-auto">
                Спробувати Randomizer
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 bg-white">
        <div className="max-w-4xl mx-auto text-center px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-6">
            Готові розпочати підготовку?
          </h2>
          <p className="text-xl text-gray-600 mb-8">
            Пройдіть тест, щоб зрозуміти де ви зараз
          </p>
          <button className="bg-gradient-to-r from-[#1128C6] to-[#D23DE3] text-white px-8 py-4 rounded-xl font-medium text-lg hover:opacity-90 transition-opacity duration-200">
            Почати зараз
          </button>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center space-x-2 mb-4">
                <GraduationCap className="h-6 w-6 text-primary-400" />
                <h3 className="text-xl font-bold">Help Krok</h3>
              </div>
              <p className="text-gray-400">
                Сучасна платформа для підготовки до екзаменів КРОК
              </p>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Продукт</h4>
              <ul className="space-y-2 text-gray-400">
                <li><a href="#" className="hover:text-white transition-colors">Функції</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Тарифи</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Демо</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Підтримка</h4>
              <ul className="space-y-2 text-gray-400">
                <li><a href="#" className="hover:text-white transition-colors">Допомога</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Контакти</a></li>
                <li><a href="#" className="hover:text-white transition-colors">FAQ</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Контакти</h4>
              <ul className="space-y-2 text-gray-400">
                <li>help@krok.ua</li>
                <li>+380 (XX) XXX XX XX</li>
              </ul>
            </div>
          </div>
          <div className="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2024 Help Krok. Всі права захищені.</p>
          </div>
        </div>
      </footer>
    </div>
  )
}
