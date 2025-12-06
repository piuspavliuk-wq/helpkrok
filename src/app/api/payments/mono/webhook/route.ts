import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import crypto from 'crypto';

// Функція для верифікації підпису webhook від Monobank
function verifyWebhookSignature(body: string, signature: string, publicKey: string): boolean {
  try {
    const verify = crypto.createVerify('SHA256');
    verify.update(body);
    verify.end();
    return verify.verify(publicKey, signature, 'base64');
  } catch (error) {
    console.error('Помилка верифікації підпису:', error);
    return false;
  }
}

export async function POST(request: NextRequest) {
  try {
    // Отримання даних webhook
    const body = await request.text();
    const webhookData = JSON.parse(body);

    console.log('Отримано webhook від Monobank:', webhookData);

    const { invoiceId, status, failureReason } = webhookData;

    if (!invoiceId) {
      console.error('invoiceId відсутній у webhook');
      return NextResponse.json(
        { error: 'invoiceId обов\'язковий' },
        { status: 400 }
      );
    }

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      console.error('Supabase credentials not configured for webhook');
      return NextResponse.json(
        { error: 'Database configuration error' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

    // Знаходимо платіж в базі даних
    const { data: payment, error: paymentFetchError } = await supabase
      .from('payments')
      .select('*, user:users(id, email)')
      .eq('invoice_id', invoiceId)
      .single();

    if (paymentFetchError || !payment) {
      console.error('Платіж не знайдено:', invoiceId, paymentFetchError);
      return NextResponse.json(
        { error: 'Платіж не знайдено' },
        { status: 404 }
      );
    }

    console.log('Знайдено платіж:', payment.id, 'Статус:', status);

    // Оновлюємо статус платежу
    let paymentStatus = 'pending';

    if (status === 'success') {
      paymentStatus = 'success';
    } else if (status === 'failure') {
      paymentStatus = 'failure';
    } else if (status === 'processing') {
      paymentStatus = 'processing';
    } else if (status === 'expired') {
      paymentStatus = 'expired';
    }

    const { data: updatedPayment, error: updatePaymentError } = await supabase
      .from('payments')
      .update({
        status: paymentStatus,
        failure_reason: failureReason || null
      })
      .eq('invoice_id', invoiceId)
      .select()
      .single();

    if (updatePaymentError || !updatedPayment) {
      console.error('Помилка оновлення платежу:', updatePaymentError);
      return NextResponse.json(
        { error: 'Не вдалося оновити платіж' },
        { status: 500 }
      );
    }

    console.log('Оновлено платіж:', updatedPayment.id, 'Новий статус:', paymentStatus);

    // Якщо платіж успішний, обробляємо залежно від типу платежу
    if (paymentStatus === 'success') {
      try {
        if (payment.payment_type === 'randomizer') {
          // Обробка оплати randomizer
          const { data: userAttempts, error: attemptsFetchError } = await supabase
            .from('randomizer_attempts')
            .select('*')
            .eq('user_id', payment.user_id)
            .maybeSingle();

          if (attemptsFetchError) {
            console.error('Помилка отримання спроб користувача:', attemptsFetchError);
          }

          if (userAttempts) {
            const { error: attemptsUpdateError } = await supabase
              .from('randomizer_attempts')
              .update({
                total_attempts: userAttempts.total_attempts + payment.attempts_count,
                used_attempts: userAttempts.used_attempts
              })
              .eq('id', userAttempts.id);

            if (attemptsUpdateError) {
              console.error('Помилка оновлення спроб користувача:', attemptsUpdateError);
            } else {
              console.log('Оновлено спроби користувача:', userAttempts.id);
            }
          } else {
            const { error: attemptsInsertError } = await supabase
              .from('randomizer_attempts')
              .insert({
                user_id: payment.user_id,
                total_attempts: payment.attempts_count,
                used_attempts: 0,
                payment_id: payment.id
              });

            if (attemptsInsertError) {
              console.error('Помилка створення запису спроб:', attemptsInsertError);
            } else {
              console.log('Створено новий запис спроб для користувача:', payment.user_id);
            }
          }

          console.log(`✅ Успішний платіж! Користувач ${payment.user.email} отримав ${payment.attempts_count} спроб`);
        } else if (payment.payment_type === 'course') {
          // Обробка оплати курсу
          // Створюємо запис про доступ до курсу в таблиці course_access
          // Спочатку перевіряємо чи існує таблиця course_access
          const { data: courseAccess, error: courseAccessError } = await supabase
            .from('course_access')
            .select('*')
            .eq('user_id', payment.user_id)
            .eq('course_id', payment.package_id) // Використовуємо package_id для зберігання course_id
            .maybeSingle();

          if (courseAccessError && courseAccessError.code !== 'PGRST116') {
            // PGRST116 - таблиця не існує, створюємо запис через payments
            console.log('Таблиця course_access не існує, використовуємо payments для перевірки доступу');
          } else if (!courseAccess) {
            // Створюємо новий запис доступу
            const { error: insertError } = await supabase
              .from('course_access')
              .insert({
                user_id: payment.user_id,
                course_id: payment.package_id,
                access_granted: true,
                granted_at: new Date().toISOString(),
                payment_id: payment.id
              });

            if (insertError) {
              console.error('Помилка створення доступу до курсу:', insertError);
              // Якщо таблиця не існує, просто логуємо - доступ буде перевірятися через payments
            } else {
              console.log('Створено доступ до курсу для користувача:', payment.user_id);
            }
          }

          console.log(`✅ Успішний платіж! Користувач ${payment.user.email} отримав доступ до курсу`);
        } else if (payment.payment_type === 'subscription') {
          // Обробка оплати підписки
          try {
            const metadata = payment.metadata ? JSON.parse(payment.metadata) : {};
            const subscriptionType = metadata.subscriptionType || 'medical';
            const subscriptionId = metadata.subscriptionId || 'standard';
            
            console.log('Обробка підписки:', { subscriptionType, subscriptionId, metadata, payment_id: payment.id });
            
            // Визначаємо дати підписки (1 рік)
            const startDate = new Date();
            const endDate = new Date();
            endDate.setFullYear(endDate.getFullYear() + 1);

            // Створюємо або оновлюємо підписку
            const { data: existingSubscription, error: fetchError } = await supabase
              .from('user_subscriptions')
              .select('*')
              .eq('user_id', payment.user_id)
              .eq('subscription_type', subscriptionType)
              .eq('status', 'active')
              .maybeSingle();

            if (fetchError && fetchError.code !== 'PGRST116') {
              console.error('Помилка перевірки підписки:', fetchError);
            }

            if (existingSubscription) {
              // Оновлюємо існуючу підписку
              const { error: updateError } = await supabase
                .from('user_subscriptions')
                .update({
                  status: 'active',
                  start_date: startDate.toISOString(),
                  end_date: endDate.toISOString(),
                  payment_id: payment.id,
                  updated_at: new Date().toISOString()
                })
                .eq('id', existingSubscription.id);

              if (updateError) {
                console.error('Помилка оновлення підписки:', updateError);
              } else {
                console.log('Оновлено підписку для користувача:', payment.user_id);
              }
            } else {
              // Створюємо нову підписку
              const { error: insertError, data: insertedSubscription } = await supabase
                .from('user_subscriptions')
                .insert({
                  user_id: payment.user_id,
                  subscription_type: subscriptionType,
                  status: 'active',
                  start_date: startDate.toISOString(),
                  end_date: endDate.toISOString(),
                  payment_provider: 'mono',
                  payment_id: String(payment.id) // Перетворюємо в рядок для сумісності з VARCHAR
                })
                .select();

              if (insertError) {
                console.error('Помилка створення підписки:', insertError);
              } else {
                console.log('✅ Створено нову підписку для користувача:', payment.user_id, 'Тип:', subscriptionType, 'Підписка ID:', insertedSubscription?.[0]?.id);
              }
            }

            console.log(`✅ Успішний платіж! Користувач ${payment.user.email} отримав підписку ${subscriptionType}`);
            
            // Автоматично надаємо доступ до всіх курсів медичного факультету при оплаті підписки
            if (subscriptionType === 'medical' || subscriptionType === 'premium') {
              const courses = ['fundamental-medico-biological-knowledge', 'organic-compounds-basics', 'blood-system-and-immunity'];
              
              for (const courseId of courses) {
                try {
                  // Перевіряємо чи вже є доступ
                  const { data: existingAccess } = await supabase
                    .from('course_access')
                    .select('*')
                    .eq('user_id', payment.user_id)
                    .eq('course_id', courseId)
                    .maybeSingle();

                  if (!existingAccess) {
                    // Створюємо доступ до курсу
                    const { error: courseAccessError } = await supabase
                      .from('course_access')
                      .insert({
                        user_id: payment.user_id,
                        course_id: courseId,
                        access_granted: true,
                        granted_at: new Date().toISOString(),
                        payment_id: String(payment.id)
                      });

                    if (courseAccessError && courseAccessError.code !== 'PGRST116') {
                      console.error(`Помилка створення доступу до курсу ${courseId}:`, courseAccessError);
                    } else {
                      console.log(`✅ Надано доступ до курсу ${courseId} для користувача ${payment.user_id}`);
                    }
                  }
                } catch (error) {
                  console.error(`Помилка обробки доступу до курсу ${courseId}:`, error);
                }
              }
            }
          } catch (error) {
            console.error('Помилка обробки підписки:', error);
          }
        }
      } catch (error) {
        console.error('Помилка обробки платежу:', error);
      }
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Помилка обробки webhook:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера', details: error instanceof Error ? error.message : 'Unknown error' },
      { status: 500 }
    );
  }
}

// Метод GET для перевірки доступності endpoint
export async function GET() {
  return NextResponse.json({
    status: 'ok',
    message: 'Monobank webhook endpoint працює'
  });
}

