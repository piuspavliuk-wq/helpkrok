#!/bin/bash

# Скрипт для push на GitHub через Personal Access Token

echo "🚀 Push на GitHub через Personal Access Token"
echo ""

# Перевірка чи є токен
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  Змінна GITHUB_TOKEN не встановлена"
    echo ""
    echo "Встановіть токен:"
    echo "export GITHUB_TOKEN=ваш_токен"
    echo ""
    echo "Або введіть токен зараз:"
    read -s GITHUB_TOKEN
    echo ""
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Токен не встановлено. Вихід."
    exit 1
fi

# Налаштування remote з токеном
echo "📋 Налаштування remote..."
git remote set-url origin https://${GITHUB_TOKEN}@github.com/piuspavliuk-wq/helpkrok.git

# Push
echo "📤 Push на GitHub..."
if git push origin main; then
    echo "✅ Успішно запушено на GitHub!"
    echo ""
    echo "🔗 Репозиторій: https://github.com/piuspavliuk-wq/helpkrok"
else
    echo "❌ Помилка при push"
    echo ""
    echo "Можливі причини:"
    echo "1. Токен не має права 'repo' (write access)"
    echo "2. Токен недійсний або застарілий"
    echo "3. Репозиторій не існує або немає доступу"
    echo ""
    echo "Створіть новий токен з правами 'repo':"
    echo "https://github.com/settings/tokens"
    exit 1
fi

