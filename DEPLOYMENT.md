# 🚀 Інструкції для деплою Help Krok Platform

## 📋 Передумови

- GitHub репозиторій
- Vercel акаунт
- Supabase проект
- Налаштована база даних

## 🔧 Крок 1: Підготовка проекту

### 1.1 Очищення проекту
Проект вже очищений від непотрібних файлів. Всі SQL скрипти, тестові файли та документація виключені з репозиторію.

### 1.2 Змінні середовища
Створіть файл `.env.local` на основі `env.example`:

```bash
cp env.example .env.local
```

## 🌐 Крок 2: Деплой на Vercel

### 2.1 Підключення до Vercel

1. Перейдіть на [vercel.com](https://vercel.com)
2. Увійдіть через GitHub
3. Натисніть "New Project"
4. Виберіть ваш репозиторій `help-krok-platform`
5. Натисніть "Import"

### 2.2 Налаштування змінних середовища

В Vercel Dashboard:

1. Перейдіть до Settings → Environment Variables
2. Додайте наступні змінні:

#### Обов'язкові змінні:
```
DATABASE_URL=postgresql://postgres.nttyhnbjlsnrxbcoxglw:your_password@aws-0-eu-central-1.pooler.supabase.com:6543/postgres
NEXTAUTH_URL=https://your-app-name.vercel.app
NEXTAUTH_SECRET=your-secret-key-here
NEXT_PUBLIC_SUPABASE_URL=https://nttyhnbjlsnrxbcoxglw.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50dHlobmJqbHNucnhiY294Z2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5NDUyMzEsImV4cCI6MjA3MzUyMTIzMX0.l6ieAE6s5CPxJ8Mw39MYLXAIvhwhFZzwFEea5z1EA-8
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key_here
NEXT_PUBLIC_APP_URL=https://your-app-name.vercel.app
```

#### Опціональні змінні (для повної функціональності):
```
EMAIL_SERVER_HOST=smtp.gmail.com
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER=your-email@gmail.com
EMAIL_SERVER_PASSWORD=your-app-password
EMAIL_FROM=noreply@helpkrok.com
TELEGRAM_BOT_TOKEN=your_telegram_bot_token
TELEGRAM_BOT_USERNAME=your_bot_username
GOOGLE_GEMINI_API_KEY=your_google_gemini_api_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_key
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=whsec_your_stripe_webhook_secret
```

### 2.3 Налаштування Build Settings

В Vercel Dashboard:

1. Перейдіть до Settings → General
2. Build Command: `npm run build`
3. Output Directory: `.next`
4. Install Command: `npm install`

### 2.4 Деплой

1. Натисніть "Deploy"
2. Дочекайтеся завершення білду
3. Перевірте, що сайт працює

## 🗄️ Крок 3: Налаштування бази даних

### 3.1 Supabase налаштування

1. Перейдіть до вашого Supabase проекту
2. Переконайтеся, що всі таблиці створені
3. Перевірте RLS (Row Level Security) політики
4. Налаштуйте аутентифікацію

### 3.2 Створення адміністратора

Після деплою створіть адміністраторський акаунт через API або Supabase Dashboard.

## 🔍 Крок 4: Перевірка та тестування

### 4.1 Базова перевірка

1. Відкрийте сайт
2. Перевірте реєстрацію/логін
3. Протестуйте основні функції
4. Перевірте мобільну версію

### 4.2 Налаштування домену (опціонально)

1. В Vercel Dashboard → Settings → Domains
2. Додайте ваш домен
3. Налаштуйте DNS записи

## 🚨 Вирішення проблем

### Проблема: Build fails
- Перевірте всі змінні середовища
- Переконайтеся, що всі залежності встановлені
- Перевірте логи білду

### Проблема: Database connection error
- Перевірте DATABASE_URL
- Переконайтеся, що Supabase проект активний
- Перевірте RLS політики

### Проблема: Authentication не працює
- Перевірте NEXTAUTH_URL та NEXTAUTH_SECRET
- Переконайтеся, що Supabase аутентифікація налаштована

## 📞 Підтримка

При виникненні проблем:
1. Перевірте логи в Vercel Dashboard
2. Перевірте Supabase Dashboard
3. Переконайтеся, що всі змінні середовища налаштовані правильно

## 🎉 Готово!

Ваш сайт тепер доступний за адресою: `https://your-app-name.vercel.app`

---

**Примітка**: Цей проект використовує Next.js 15, React 19, Supabase та інші сучасні технології. Переконайтеся, що всі залежності сумісні.
