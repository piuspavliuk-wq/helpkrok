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

    // Якщо платіж успішний, додаємо спроби користувачу
    if (paymentStatus === 'success') {
      try {
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
      } catch (error) {
        console.error('Помилка додавання спроб:', error);
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

