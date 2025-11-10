# ⚡ Швидкий старт - Plata by Mono

## ✅ Все готово до роботи!

Таблиця `payments` створена ✅  
API endpoints працюють ✅  
Frontend готовий ✅  

## 🚀 Для локального тестування:

### 1. Запустіть ngrok (в окремому терміналі):
```bash
ngrok http 3000
```

### 2. Скопіюйте HTTPS URL і оновіть `.env.local`:
```env
MONOBANK_WEBHOOK_URL=https://YOUR-NGROK-URL.ngrok.io/api/payments/mono/webhook
```

### 3. Перезапустіть сервер:
```bash
npm run dev
```

### 4. Відкрийте в браузері:
```
http://localhost:3000/randomizer/buy
```

### 5. Натисніть "Купити зараз" і тестуйте! 🎉

## 📝 Ваші дані з .env.local:

```env
# Supabase (вже налаштовано) ✅
NEXT_PUBLIC_SUPABASE_URL=https://nttyhnbjlsnrxbcoxglw.supabase.co
DATABASE_URL=postgresql://postgres:...@db.nttyhnbjlsnrxbcoxglw.supabase.co:5432/postgres

# Monobank (вже налаштовано) ✅
MONOBANK_API_TOKEN=m8egFLGc_rjl82DHgShK3Lw

# Потрібно ТІЛЬКИ оновити після запуску ngrok:
MONOBANK_WEBHOOK_URL=https://YOUR-NGROK-URL.ngrok.io/api/payments/mono/webhook
```

## 🔍 Перевірка що все працює:

```bash
# Перевірте webhook
curl http://localhost:3000/api/payments/mono/webhook

# Повинен повернути:
# {"status":"ok","message":"Monobank webhook endpoint працює"}
```

## 📊 Моніторинг платежів:

### В терміналі (де запущено npm run dev):
Ви побачите логи типу:
```
✅ Успішний платіж! Користувач user@email.com отримав 5 спроб
```

### В Supabase Dashboard (SQL Editor):
```sql
SELECT * FROM payments ORDER BY created_at DESC LIMIT 5;
SELECT * FROM randomizer_attempts ORDER BY created_at DESC LIMIT 5;
```

## 🐛 Якщо щось не працює:

1. **Перевірте чи запущено ngrok**
2. **Перевірте чи оновлено MONOBANK_WEBHOOK_URL**
3. **Перезапустіть npm run dev**
4. **Подивіться логи в терміналі**

## 📖 Детальна інструкція:
Дивіться `PAYMENT_INSTRUCTIONS.md` для повної інформації.

---

**Все готово! Залишилось тільки запустити ngrok та протестувати! 🚀**

