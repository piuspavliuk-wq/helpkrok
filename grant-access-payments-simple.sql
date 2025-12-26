-- ПРОСТИЙ SQL для надання доступу до курсу через payments
-- Виконайте в Supabase Dashboard → SQL Editor
--
-- ЗАМІНІТЬ 'EMAIL_КОРИСТУВАЧА' на реальний email дівчини

-- Надання доступу до курсу "Центральна нервова система"
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
    'granted-access-' || gen_random_uuid()::text,
    0,
    'success',
    'course',
    'central-nervous-system',
    0,
    '{"reason":"Надано доступ за виграш курсу"}'::text,
    NOW(),
    NOW()
FROM users
WHERE email = 'EMAIL_КОРИСТУВАЧА'  -- ЗАМІНІТЬ НА РЕАЛЬНИЙ EMAIL
  AND NOT EXISTS (
    SELECT 1 FROM payments p2
    WHERE p2.user_id = users.id
      AND p2.package_id = 'central-nervous-system'
      AND p2.payment_type = 'course'
      AND p2.status = 'success'
  )
ON CONFLICT (invoice_id) DO NOTHING;

-- Перевірка: подивитися чи доступ надано
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
WHERE u.email = 'EMAIL_КОРИСТУВАЧА'  -- ЗАМІНІТЬ НА РЕАЛЬНИЙ EMAIL
  AND p.package_id = 'central-nervous-system'
  AND p.payment_type = 'course'
  AND p.status = 'success'
ORDER BY p.created_at DESC;

