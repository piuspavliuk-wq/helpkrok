# Інструкція з підключення Plata by Mono

## ✅ Що вже зроблено:

1. **Оновлено Prisma схему** - додано модель `Payment` для зберігання платежів
2. **Створено API endpoints:**
   - `/api/payments/mono/create` - створення інвойсу
   - `/api/payments/mono/webhook` - обробка webhook від Monobank
3. **Створено UI компоненти:**
   - `PaymentModal` - модальне вікно для оплати
   - Оновлено сторінку `/randomizer/buy` з функціоналом оплати
   - Створено сторінку успіху `/randomizer/payment/success`

## 🔧 Що потрібно зробити вручну:

### 1. Створити таблицю `payments` в Supabase

Перейди в Supabase Dashboard → SQL Editor і виконай цей SQL запит:

```sql
-- Створення таблиці payments
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    invoice_id TEXT UNIQUE NOT NULL,
    amount INTEGER NOT NULL,
    status TEXT DEFAULT 'pending' NOT NULL,
    payment_type TEXT NOT NULL,
    package_id TEXT NOT NULL,
    attempts_count INTEGER NOT NULL,
    page_url TEXT,
    qr_code_data TEXT,
    metadata TEXT,
    failure_reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Створення індексів
CREATE INDEX IF NOT EXISTS idx_payments_user_id ON payments(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_invoice_id ON payments(invoice_id);

-- Додавання функції для автоматичного оновлення updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Створення тригера
DROP TRIGGER IF EXISTS update_payments_updated_at ON payments;
CREATE TRIGGER update_payments_updated_at
    BEFORE UPDATE ON payments
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
```

### 2. Налаштувати webhook в Monobank

⚠️ **ВАЖЛИВО:** Для роботи webhook в локальному середовищі потрібно використовувати ngrok або подібний сервіс.

#### Для локальної розробки:

1. Встанови ngrok (якщо ще не встановлено):
```bash
brew install ngrok
# або
npm install -g ngrok
```

2. Запусти ngrok:
```bash
ngrok http 3000
```

3. Скопіюй HTTPS URL, який надасть ngrok (наприклад: `https://abc123.ngrok.io`)

4. Оновіть `.env.local`:
```env
MONOBANK_WEBHOOK_URL=https://abc123.ngrok.io/api/payments/mono/webhook
```

#### Для production:

Оновіть `.env.local` (або налаштування Vercel):
```env
MONOBANK_WEBHOOK_URL=https://your-domain.com/api/payments/mono/webhook
```

### 3. Налаштування Monobank

1. Перейди на https://web.monobank.ua/
2. Увійди в особистий кабінет
3. Перейди в розділ "Для бізнесу" → "Інтернет-еквайринг"
4. Отримай `X-Token` для API
5. Додай webhook URL в налаштуваннях

### 4. Перевірка налаштувань

Запусти сервер:
```bash
npm run dev
```

Відкрий http://localhost:3000/randomizer/buy і спробуй створити платіж.

### 5. Тестування webhook

Перевір доступність webhook:
```bash
curl http://localhost:3000/api/payments/mono/webhook
```

Повинен повернути:
```json
{
  "status": "ok",
  "message": "Monobank webhook endpoint працює"
}
```

## 📝 Структура платежів

### Пакети Randomizer PRO:

1. **Одна спроба** - 180 ₴
2. **Пакет 5 спроб** - 650 ₴ (популярний)
3. **Пакет 10 спроб** - 1450 ₴

### Статуси платежів:

- `pending` - очікування оплати
- `processing` - обробка платежу
- `success` - платіж успішний
- `failure` - помилка платежу
- `expired` - час оплати минув

## 🔍 Діагностика проблем

### Якщо платіж не створюється:

1. Перевір логи в консолі браузера та терміналу
2. Перевір чи правильно налаштовано `MONOBANK_API_TOKEN`
3. Перевір чи таблиця `payments` створена в Supabase

### Якщо webhook не спрацьовує:

1. Перевір чи ngrok запущено (для локальної розробки)
2. Перевір чи URL webhook правильний
3. Перевір логи в `/api/payments/mono/webhook`
4. Перевір чи таблиця `randomizer_attempts` існує

### Перевірка через Supabase SQL Editor:

```sql
-- Перевірка платежів
SELECT * FROM payments ORDER BY created_at DESC LIMIT 10;

-- Перевірка спроб користувачів
SELECT * FROM randomizer_attempts ORDER BY created_at DESC LIMIT 10;

-- Статистика платежів
SELECT status, COUNT(*), SUM(amount) FROM payments GROUP BY status;
```

## 🚀 Наступні кроки після налаштування:

1. ✅ Перейди на http://localhost:3000/randomizer/buy
2. ✅ Обери пакет
3. ✅ Натисни "Купити зараз"
4. ✅ Пройди процес оплати через Monobank
5. ✅ Спроби автоматично додадуться до профілю

## 🔐 Безпека

- Ніколи не комітьте `.env.local` файл
- Тримайте `MONOBANK_API_TOKEN` в секреті
- В production використовуйте HTTPS для webhook
- Рекомендується додати верифікацію підпису webhook (закоментовано в коді)

## 📞 Підтримка

Якщо виникли проблеми, перевір:
1. Логи сервера Next.js
2. Логи в Supabase Dashboard
3. Статус платежів в таблиці `payments`

