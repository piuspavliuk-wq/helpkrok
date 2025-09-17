'use client'

export default function SimpleTelegramLogin() {
  return (
    <div className="flex flex-col items-center space-y-4">
      <div className="p-4 bg-gray-100 rounded-lg">
        <p className="text-sm text-gray-600 text-center max-w-sm">
          Telegram автентифікація більше не підтримується.
        </p>
        <p className="text-xs text-gray-500 text-center mt-2">
          Будь ласка, використовуйте email для входу в систему.
        </p>
      </div>
    </div>
  )
}
