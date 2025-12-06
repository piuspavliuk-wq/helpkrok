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

interface CourseInfo {
  id: string;
  name: string;
  price: number;
}

interface SubscriptionInfo {
  id: string;
  name: string;
  medicalPrice: number;
  pharmaceuticalPrice: number;
}

const SUBSCRIPTIONS: Record<string, SubscriptionInfo> = {
  'subscription-vip-premium-medical': {
    id: 'vip-premium',
    name: 'VIP Premium - Медицина',
    medicalPrice: 1, // Тимчасово для тестування
    pharmaceuticalPrice: 11500
  },
  'subscription-vip-premium-pharmaceutical': {
    id: 'vip-premium',
    name: 'VIP Premium - Фармація',
    medicalPrice: 14500,
    pharmaceuticalPrice: 11500
  },
  'subscription-premium-standard-medical': {
    id: 'premium-standard',
    name: 'Premium Standard - Медицина',
    medicalPrice: 10000,
    pharmaceuticalPrice: 9000
  },
  'subscription-premium-standard-pharmaceutical': {
    id: 'premium-standard',
    name: 'Premium Standard - Фармація',
    medicalPrice: 10000,
    pharmaceuticalPrice: 9000
  },
  'subscription-standard-medical': {
    id: 'standard',
    name: 'Standard - Медицина',
    medicalPrice: 8500,
    pharmaceuticalPrice: 7500
  },
  'subscription-standard-pharmaceutical': {
    id: 'standard',
    name: 'Standard - Фармація',
    medicalPrice: 8500,
    pharmaceuticalPrice: 7500
  },
  'subscription-basic-medical': {
    id: 'basic',
    name: 'Базове самоопрацювання - Медицина',
    medicalPrice: 6500,
    pharmaceuticalPrice: 5500
  },
  'subscription-basic-pharmaceutical': {
    id: 'basic',
    name: 'Базове самоопрацювання - Фармація',
    medicalPrice: 6500,
    pharmaceuticalPrice: 5500
  }
};

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

const COURSES: Record<string, CourseInfo> = {
  'fundamental-medico-biological-knowledge': {
    id: 'fundamental-medico-biological-knowledge',
    name: 'Фундаментальні медико-біологічні знання',
    price: 5990
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
    const { packageId, courseId, subscriptionId, subscriptionType } = body;

    // Перевірка чи це оплата курсу, підписки або пакету
    let paymentType: 'randomizer' | 'course' | 'subscription' = 'randomizer';
    let itemInfo: PackageInfo | CourseInfo | SubscriptionInfo | null = null;
    let redirectUrl = `${process.env.NEXT_PUBLIC_APP_URL}/randomizer/payment/success`;
    let destination = '';
    let comment = '';
    let subscriptionFaculty: 'medical' | 'pharmaceutical' | null = null;

    if (courseId) {
      // Оплата курсу
      if (!COURSES[courseId]) {
        return NextResponse.json(
          { error: 'Невірний курс' },
          { status: 400 }
        );
      }
      paymentType = 'course';
      itemInfo = COURSES[courseId];
      redirectUrl = `${process.env.NEXT_PUBLIC_APP_URL}/systems/fundamental-medico-biological-knowledge?payment=success`;
      destination = `Курс: ${itemInfo.name}`;
      comment = 'Повний доступ до курсу';
    } else if (subscriptionId && subscriptionType) {
      // Оплата підписки
      const subscriptionKey = `${subscriptionId}-${subscriptionType}`;
      if (!SUBSCRIPTIONS[subscriptionKey]) {
        return NextResponse.json(
          { error: 'Невірна підписка' },
          { status: 400 }
        );
      }
      paymentType = 'subscription';
      itemInfo = SUBSCRIPTIONS[subscriptionKey];
      subscriptionFaculty = subscriptionType;
      redirectUrl = `${process.env.NEXT_PUBLIC_APP_URL}/?payment=success`;
      destination = `Підписка: ${itemInfo.name}`;
      comment = `Підписка на ${subscriptionType === 'medical' ? 'Медицину' : 'Фармацію'}`;
    } else if (packageId) {
      // Оплата пакету randomizer
      if (!PACKAGES[packageId]) {
        return NextResponse.json(
          { error: 'Невірний пакет' },
          { status: 400 }
        );
      }
      itemInfo = PACKAGES[packageId];
      const packageInfo = itemInfo as PackageInfo;
      destination = `Randomizer PRO: ${packageInfo.name}`;
      comment = `${packageInfo.attempts} ${packageInfo.attempts === 1 ? 'спроба' : 'спроб'}`;
    } else {
      return NextResponse.json(
        { error: 'Необхідно вказати packageId, courseId або subscriptionId з subscriptionType' },
        { status: 400 }
      );
    }

    if (!itemInfo) {
      return NextResponse.json(
        { error: 'Помилка обробки запиту' },
        { status: 400 }
      );
    }

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

    // Визначаємо ціну
    let price = 0;
    if (paymentType === 'subscription' && itemInfo && 'medicalPrice' in itemInfo) {
      price = subscriptionFaculty === 'medical' 
        ? itemInfo.medicalPrice 
        : itemInfo.pharmaceuticalPrice;
    } else if (itemInfo && 'price' in itemInfo) {
      price = itemInfo.price;
    }

    // Створення інвойсу через Monobank API
    const reference = courseId 
      ? `course-${courseId}-${Date.now()}`
      : subscriptionId
      ? `subscription-${subscriptionId}-${subscriptionType}-${Date.now()}`
      : `randomizer-${packageId}-${Date.now()}`;

    const monoResponse = await fetch('https://api.monobank.ua/api/merchant/invoice/create', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Token': monoToken
      },
      body: JSON.stringify({
        amount: price * 100, // Конвертація в копійки
        ccy: 980, // UAH
        merchantPaymInfo: {
          reference,
          destination,
          comment
        },
        redirectUrl,
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
    const paymentData: any = {
      user_id: user.id,
      invoice_id: monoData.invoiceId,
      amount: price * 100,
      status: 'pending',
      payment_type: paymentType,
      page_url: monoData.pageUrl,
      qr_code_data: monoData.qrId || null,
      metadata: JSON.stringify({
        userEmail: user.email,
        userName: user.name
      })
    };

    if (paymentType === 'randomizer' && 'attempts' in itemInfo) {
      paymentData.package_id = itemInfo.id;
      paymentData.attempts_count = itemInfo.attempts;
      paymentData.metadata = JSON.stringify({
        packageName: itemInfo.name,
        userEmail: user.email,
        userName: user.name
      });
    } else if (paymentType === 'course' && 'id' in itemInfo) {
      paymentData.package_id = itemInfo.id; // Використовуємо package_id для зберігання course_id
      paymentData.attempts_count = 0; // Для курсів не потрібні спроби
      paymentData.metadata = JSON.stringify({
        courseName: itemInfo.name,
        courseId: itemInfo.id,
        userEmail: user.email,
        userName: user.name
      });
    } else if (paymentType === 'subscription' && 'id' in itemInfo && subscriptionFaculty) {
      paymentData.package_id = itemInfo.id; // ID плану підписки
      paymentData.attempts_count = 0;
      paymentData.metadata = JSON.stringify({
        subscriptionName: itemInfo.name,
        subscriptionId: itemInfo.id,
        subscriptionType: subscriptionFaculty,
        userEmail: user.email,
        userName: user.name
      });
    }

    const { data: payment, error: paymentError } = await supabase
      .from('payments')
      .insert(paymentData)
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

