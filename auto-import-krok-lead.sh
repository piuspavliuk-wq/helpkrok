#!/bin/bash

# Автоматичний імпорт питань з Krok Lead
# Використання: ./auto-import-krok-lead.sh [URL]

set -e  # Зупинити виконання при помилці

# Кольори для виводу
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функція для виводу кольорового тексту
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Перевірка аргументів
if [ $# -eq 0 ]; then
    URL="https://krok-lead.com/booklet/132fb2e9-fbfd-42d1-95b5-491075ca29d4?faculty=medical&krok=krok1"
    print_warning "URL не вказано, використовується за замовчуванням: $URL"
else
    URL="$1"
fi

print_status "Початок автоматичного імпорту з Krok Lead"
print_status "URL: $URL"

# Перевірка наявності Node.js
if ! command -v node &> /dev/null; then
    print_error "Node.js не встановлено. Будь ласка, встановіть Node.js"
    exit 1
fi

# Перевірка наявності npm
if ! command -v npm &> /dev/null; then
    print_error "npm не встановлено. Будь ласка, встановіть npm"
    exit 1
fi

# Перевірка наявності залежностей
if [ ! -d "node_modules" ]; then
    print_status "Встановлення залежностей..."
    npm install
fi

# Створення папки data якщо не існує
mkdir -p data

# Крок 1: Збір даних
print_status "Крок 1: Збір даних з сайту..."
TIMESTAMP=$(date +%s)
SCRAPED_FILE="data/krok-lead-scraped-$TIMESTAMP.json"

if node scrape-krok-lead-improved.js "$URL" > "data/scrape-log-$TIMESTAMP.txt" 2>&1; then
    # Знаходимо останній створений файл
    LATEST_SCRAPED=$(ls -t data/krok-lead-improved-*.json 2>/dev/null | head -1)
    if [ -n "$LATEST_SCRAPED" ]; then
        SCRAPED_FILE="$LATEST_SCRAPED"
        print_success "Дані зібрано: $SCRAPED_FILE"
    else
        print_error "Не вдалося знайти зібрані дані"
        exit 1
    fi
else
    print_error "Помилка при зборі даних. Перевірте логи в data/scrape-log-$TIMESTAMP.txt"
    exit 1
fi

# Крок 2: Конвертація даних
print_status "Крок 2: Конвертація даних..."
CONVERTED_FILE="data/krok-lead-converted-$TIMESTAMP.json"

if node import-krok-lead-data.js "$SCRAPED_FILE" > "data/convert-log-$TIMESTAMP.txt" 2>&1; then
    # Знаходимо останній створений JSON файл
    LATEST_CONVERTED=$(ls -t data/krok-lead-api-*.json 2>/dev/null | head -1)
    if [ -n "$LATEST_CONVERTED" ]; then
        CONVERTED_FILE="$LATEST_CONVERTED"
        print_success "Дані конвертовано: $CONVERTED_FILE"
    else
        print_error "Не вдалося знайти конвертовані дані"
        exit 1
    fi
else
    print_error "Помилка при конвертації даних. Перевірте логи в data/convert-log-$TIMESTAMP.txt"
    exit 1
fi

# Крок 3: Перевірка сервера
print_status "Крок 3: Перевірка сервера Next.js..."
if ! curl -s "http://localhost:3000/api/krok/unified?limit=1" > /dev/null 2>&1; then
    print_warning "Сервер Next.js не запущено. Запускаємо..."
    
    # Запускаємо сервер у фоновому режимі
    npm run dev > "data/server-log-$TIMESTAMP.txt" 2>&1 &
    SERVER_PID=$!
    
    # Чекаємо запуску сервера
    print_status "Чекаємо запуску сервера..."
    for i in {1..30}; do
        if curl -s "http://localhost:3000/api/krok/unified?limit=1" > /dev/null 2>&1; then
            print_success "Сервер запущено (PID: $SERVER_PID)"
            break
        fi
        sleep 2
    done
    
    if [ $i -eq 30 ]; then
        print_error "Не вдалося запустити сервер за 60 секунд"
        kill $SERVER_PID 2>/dev/null || true
        exit 1
    fi
else
    print_success "Сервер вже працює"
fi

# Крок 4: Імпорт через API
print_status "Крок 4: Імпорт через API..."
if node import-via-api.js "$CONVERTED_FILE" > "data/import-log-$TIMESTAMP.txt" 2>&1; then
    print_success "Імпорт завершено успішно!"
else
    print_error "Помилка при імпорті через API. Перевірте логи в data/import-log-$TIMESTAMP.txt"
    exit 1
fi

# Крок 5: Перевірка результатів
print_status "Крок 5: Перевірка результатів..."
CURRENT_YEAR=$(date +%Y)
QUESTIONS_COUNT=$(curl -s "http://localhost:3000/api/krok/unified?year=$CURRENT_YEAR" | grep -o '"total":[0-9]*' | cut -d':' -f2)

if [ -n "$QUESTIONS_COUNT" ] && [ "$QUESTIONS_COUNT" -gt 0 ]; then
    print_success "Знайдено $QUESTIONS_COUNT питань за $CURRENT_YEAR рік"
else
    print_warning "Не вдалося перевірити кількість питань"
fi

# Підсумок
print_success "Автоматичний імпорт завершено!"
echo ""
echo "📁 Створені файли:"
echo "  - Зібрані дані: $SCRAPED_FILE"
echo "  - Конвертовані дані: $CONVERTED_FILE"
echo "  - Логи збору: data/scrape-log-$TIMESTAMP.txt"
echo "  - Логи конвертації: data/convert-log-$TIMESTAMP.txt"
echo "  - Логи імпорту: data/import-log-$TIMESTAMP.txt"
echo "  - Логи сервера: data/server-log-$TIMESTAMP.txt"
echo ""
echo "🔍 Перевірте результати:"
echo "  - curl \"http://localhost:3000/api/krok/unified?year=$CURRENT_YEAR\""
echo "  - Відкрийте ваш сайт та перевірте нові питання"
echo ""
echo "📋 Наступні кроки:"
echo "  1. Перевірте якість імпортованих питань"
echo "  2. Додайте правильні відповіді та пояснення"
echo "  3. Протестуйте питання на сайті"
echo ""

# Зупиняємо сервер якщо ми його запускали
if [ -n "$SERVER_PID" ]; then
    print_status "Зупиняємо сервер..."
    kill $SERVER_PID 2>/dev/null || true
fi

print_success "Готово! 🎉"
