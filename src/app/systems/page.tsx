export default function SystemsPage() {
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
      
      <div className="p-8 relative z-10">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">Системи</h1>
        <div className="bg-white/80 backdrop-blur-sm rounded-lg shadow-sm border border-blue-200/50 p-6">
          <p className="text-gray-600">Тут будуть налаштування системи та конфігурація платформи.</p>
        </div>
      </div>
    </div>
  )
}
