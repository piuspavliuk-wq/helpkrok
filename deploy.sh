#!/bin/bash

# Скрипт для деплою Help Krok Platform на Vercel

echo "🚀 Деплой Help Krok Platform на Vercel"
echo ""

# Перевірка чи залогінений користувач
echo "📋 Перевірка авторизації Vercel..."
if ! npx vercel whoami &>/dev/null; then
    echo "⚠️  Ви не залогінені в Vercel"
    echo "🔐 Запускаю процес входу..."
    npx vercel login
fi

# Перевірка build
echo ""
echo "🔨 Перевірка build..."
if npm run build; then
    echo "✅ Build успішний!"
else
    echo "❌ Build не вдався. Виправте помилки перед деплоєм."
    exit 1
fi

# Деплой
echo ""
echo "🌐 Початок деплою..."
echo ""

# Деплой на production
read -p "Деплоїти на production? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Деплой на production..."
    npx vercel --prod
else
    echo "🚀 Деплой на preview..."
    npx vercel
fi

echo ""
echo "✅ Деплой завершено!"
echo ""
echo "⚠️  ВАЖЛИВО: Не забудьте додати змінні середовища в Vercel Dashboard:"
echo "   - DATABASE_URL"
echo "   - NEXTAUTH_URL"
echo "   - NEXTAUTH_SECRET"
echo "   - NEXT_PUBLIC_SUPABASE_URL"
echo "   - NEXT_PUBLIC_SUPABASE_ANON_KEY"
echo "   - SUPABASE_SERVICE_ROLE_KEY"
echo "   - NEXT_PUBLIC_APP_URL"
echo ""
echo "📚 Детальні інструкції: дивіться QUICK_DEPLOY.md або DEPLOYMENT.md"

