import { NextRequest, NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';
import crypto from 'crypto';

const prisma = new PrismaClient();

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

    const { invoiceId, status, amount, reference, failureReason } = webhookData;

    if (!invoiceId) {
      console.error('invoiceId відсутній у webhook');
      return NextResponse.json(
        { error: 'invoiceId обов\'язковий' },
        { status: 400 }
      );
    }

    // Знаходимо платіж в базі даних
    const payment = await prisma.payment.findUnique({
      where: { invoiceId },
      include: { user: true }
    });

    if (!payment) {
      console.error('Платіж не знайдено:', invoiceId);
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

    // Оновлюємо платіж
    const updatedPayment = await prisma.payment.update({
      where: { invoiceId },
      data: {
        status: paymentStatus,
        failureReason: failureReason || null
      }
    });

    console.log('Оновлено платіж:', updatedPayment.id, 'Новий статус:', paymentStatus);

    // Якщо платіж успішний, додаємо спроби користувачу
    if (paymentStatus === 'success') {
      try {
        // Шукаємо існуючий запис спроб користувача
        let userAttempts = await prisma.randomizerAttempt.findFirst({
          where: { userId: payment.userId }
        });

        if (userAttempts) {
          // Оновлюємо існуючий запис
          userAttempts = await prisma.randomizerAttempt.update({
            where: { id: userAttempts.id },
            data: {
              totalAttempts: {
                increment: payment.attemptsCount
              },
              remainingAttempts: {
                increment: payment.attemptsCount
              }
            }
          });
          console.log('Оновлено спроби користувача:', userAttempts);
        } else {
          // Створюємо новий запис
          userAttempts = await prisma.randomizerAttempt.create({
            data: {
              userId: payment.userId,
              totalAttempts: payment.attemptsCount,
              usedAttempts: 0,
              remainingAttempts: payment.attemptsCount,
              paymentId: payment.id
            }
          });
          console.log('Створено новий запис спроб:', userAttempts);
        }

        // Логування успішного платежу
        console.log(`✅ Успішний платіж! Користувач ${payment.user.email} отримав ${payment.attemptsCount} спроб`);

      } catch (error) {
        console.error('Помилка додавання спроб:', error);
        // Не повертаємо помилку, щоб Monobank не надсилав webhook повторно
      }
    }

    return NextResponse.json({ success: true });

  } catch (error) {
    console.error('Помилка обробки webhook:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера', details: error instanceof Error ? error.message : 'Unknown error' },
      { status: 500 }
    );
  } finally {
    await prisma.$disconnect();
  }
}

// Метод GET для перевірки доступності endpoint
export async function GET() {
  return NextResponse.json({
    status: 'ok',
    message: 'Monobank webhook endpoint працює'
  });
}

