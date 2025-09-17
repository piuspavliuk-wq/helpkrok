#!/bin/bash

echo "🚀 Запуск ngrok для Telegram Bot..."

# Перевіряємо чи працює Next.js
if ! curl -s http://localhost:3000 > /dev/null; then
    echo "❌ Next.js не працює на порту 3000"
    echo "Запустіть: npm run dev"
    exit 1
fi

echo "✅ Next.js працює на localhost:3000"

# Спробуємо запустити ngrok
echo "🔄 Запуск ngrok..."

# Додаємо npm global bin до PATH
export PATH="$PATH:/Users/bohdanpavliuk/.npm-global/bin"

# Запускаємо ngrok
ngrok http 3000 &
NGROK_PID=$!

# Чекаємо поки ngrok запуститься
sleep 5

# Отримуємо URL
echo "🔍 Отримуємо ngrok URL..."
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if data['tunnels']:
        print(data['tunnels'][0]['public_url'])
    else:
        print('No tunnels found')
except:
    print('Error getting URL')
" 2>/dev/null)

if [ "$NGROK_URL" = "No tunnels found" ] || [ "$NGROK_URL" = "Error getting URL" ]; then
    echo "❌ Не вдалося отримати ngrok URL"
    echo "Спробуйте запустити ngrok вручну:"
    echo "export PATH=\"\$PATH:/Users/bohdanpavliuk/.npm-global/bin\""
    echo "ngrok http 3000"
    kill $NGROK_PID 2>/dev/null
    exit 1
fi

echo "✅ ngrok URL: $NGROK_URL"
echo ""
echo "📋 Наступні кроки:"
echo "1. Відкрийте Telegram"
echo "2. Знайдіть @BotFather"
echo "3. Надішліть команду: /setdomain"
echo "4. Виберіть бота: @HelpKrokBot"
echo "5. Введіть домен: $NGROK_URL"
echo ""
echo "6. Тестуйте: $NGROK_URL/auth/signin"
echo ""
echo "🔄 ngrok працює в фоновому режимі (PID: $NGROK_PID)"
echo "Для зупинки: kill $NGROK_PID"
