import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { createClient } from '@supabase/supabase-js';

interface PackageInfo {
  id: string;
  name: string;
  attempts: number;
  price: number;
}

const PACKAGES: Record<string, PackageInfo> = {
  'single': {
    id: 'single',
    name: 'Одна спроба',
    attempts: 1,
    price: 180
  },
  'pack-5': {
    id: 'pack-5',
    name: 'Пакет 5 спроб',
    attempts: 5,
    price: 650
  },
  'pack-10': {
    id: 'pack-10',
    name: 'Пакет 10 спроб',
    attempts: 10,
    price: 1450
  }
};

export async function POST(request: NextRequest) {
  try {
    // Перевірка авторизації
    const session = await getServerSession(authOptions);
    if (!session || !session.user?.email) {
      return NextResponse.json(
        { error: 'Не авторизовано' },
        { status: 401 }
      );
    }

    // Отримання даних з запиту
    const body = await request.json();
    const { packageId } = body;

    if (!packageId || !PACKAGES[packageId]) {
      return NextResponse.json(
        { error: 'Невірний пакет' },
        { status: 400 }
      );
    }

    const packageInfo = PACKAGES[packageId];

    // Ініціалізація Supabase
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      console.error('Supabase credentials not configured');
      return NextResponse.json(
        { error: 'Помилка конфігурації бази даних' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

    // Отримання користувача з бази даних
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('id, email, name')
      .eq('email', session.user.email)
      .single();

    if (userError || !user) {
      console.error('User not found:', userError);
      return NextResponse.json(
        { error: 'Користувача не знайдено' },
        { status: 404 }
      );
    }

    // Перевірка змінних оточення
    const monoToken = process.env.MONOBANK_API_TOKEN;
    const webhookUrl = process.env.MONOBANK_WEBHOOK_URL || process.env.NEXT_PUBLIC_APP_URL + '/api/payments/mono/webhook';

    if (!monoToken) {
      console.error('MONOBANK_API_TOKEN не налаштовано');
      return NextResponse.json(
        { error: 'Помилка конфігурації платіжної системи' },
        { status: 500 }
      );
    }

    // Створення інвойсу через Monobank API
    const monoResponse = await fetch('https://api.monobank.ua/api/merchant/invoice/create', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Token': monoToken
      },
      body: JSON.stringify({
        amount: packageInfo.price * 100, // Конвертація в копійки
        ccy: 980, // UAH
        merchantPaymInfo: {
          reference: `randomizer-${packageId}-${Date.now()}`,
          destination: `Randomizer PRO: ${packageInfo.name}`,
          comment: `${packageInfo.attempts} ${packageInfo.attempts === 1 ? 'спроба' : 'спроб'}`
        },
        redirectUrl: `${process.env.NEXT_PUBLIC_APP_URL}/randomizer/payment/success`,
        webHookUrl: webhookUrl,
        validity: 3600, // 1 година
        paymentType: 'debit'
      })
    });

    if (!monoResponse.ok) {
      const errorText = await monoResponse.text();
      console.error('Помилка Monobank API:', errorText);
      return NextResponse.json(
        { error: 'Помилка створення інвойсу', details: errorText },
        { status: 500 }
      );
    }

    const monoData = await monoResponse.json();

    // Збереження платежу в базу даних
    const { data: payment, error: paymentError } = await supabase
      .from('payments')
      .insert({
        user_id: user.id,
        invoice_id: monoData.invoiceId,
        amount: packageInfo.price * 100,
        status: 'pending',
        payment_type: 'randomizer',
        package_id: packageInfo.id,
        attempts_count: packageInfo.attempts,
        page_url: monoData.pageUrl,
        qr_code_data: monoData.qrId || null,
        metadata: JSON.stringify({
          packageName: packageInfo.name,
          userEmail: user.email,
          userName: user.name
        })
      })
      .select()
      .single();

    if (paymentError || !payment) {
      console.error('Error creating payment:', paymentError);
      return NextResponse.json(
        { error: 'Помилка збереження платежу' },
        { status: 500 }
      );
    }

    console.log('Створено платіж:', payment.id, 'для користувача:', user.email);

    return NextResponse.json({
      success: true,
      paymentId: payment.id,
      invoiceId: monoData.invoiceId,
      pageUrl: monoData.pageUrl,
      qrCodeData: monoData.qrId
    });

  } catch (error) {
    console.error('Помилка створення платежу:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера', details: error instanceof Error ? error.message : 'Unknown error' },
      { status: 500 }
    );
  }
}

