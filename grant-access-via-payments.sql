-- Надання доступу до курсу через таблицю payments
-- Це створить фіктивний платіж зі статусом 'success',
-- який система використовує для перевірки доступу
--
-- ЗАМІНІТЬ 'EMAIL_КОРИСТУВАЧА' на реальний email дівчини

-- Перевірка чи вже є доступ (опціонально)
SELECT 
    p.id,
    u.email,
    u.first_name,
    u.last_name,
    p.package_id as course_id,
    p.status,
    p.created_at
FROM payments p
JOIN users u ON u.id = p.user_id
WHERE u.email = 'EMAIL_КОРИСТУВАЧА'  -- ЗАМІНІТЬ НА РЕАЛЬНИЙ EMAIL
  AND p.package_id = 'central-nervous-system'
  AND p.payment_type = 'course'
  AND p.status = 'success';

-- Надання доступу (виконайте цей запит)
INSERT INTO payments (
    user_id,
    invoice_id,
    amount,
    status,
    payment_type,
    package_id,
    attempts_count,
    metadata,
    created_at,
    updated_at
)
SELECT 
    id,
    'granted-access-' || gen_random_uuid()::text,  -- Унікальний invoice_id
    0,  -- Безкоштовно
    'success',  -- Статус успішного платежу
    'course',  -- Тип: курс
    'central-nervous-system',  -- ID курсу
    0,  -- Без спроб
    '{"reason":"Надано доступ за виграш курсу","granted_by":"admin"}'::text,  -- JSON metadata
    NOW(),
    NOW()
FROM users
WHERE email = 'EMAIL_КОРИСТУВАЧА'  -- ЗАМІНІТЬ НА РЕАЛЬНИЙ EMAIL
  AND NOT EXISTS (
    -- Перевіряємо чи вже немає такого платежу
    SELECT 1 FROM payments p2
    WHERE p2.user_id = users.id
      AND p2.package_id = 'central-nervous-system'
      AND p2.payment_type = 'course'
      AND p2.status = 'success'
  )
ON CONFLICT (invoice_id) DO NOTHING;

-- Перевірка: подивитися чи платіж створено
SELECT 
    p.id,
    u.email,
    u.first_name,
    u.last_name,
    p.package_id as course_id,
    p.status,
    p.payment_type,
    p.created_at
FROM payments p
JOIN users u ON u.id = p.user_id
WHERE p.package_id = 'central-nervous-system'
  AND p.payment_type = 'course'
  AND p.status = 'success'
ORDER BY p.created_at DESC;

