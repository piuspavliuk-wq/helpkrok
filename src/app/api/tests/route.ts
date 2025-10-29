import { NextRequest, NextResponse } from 'next/server'

// Кеш для тестів (в пам'яті)
const testsCache = new Map<string, { data: any; timestamp: number }>();
const CACHE_DURATION = 10 * 60 * 1000; // 10 хвилин (довше ніж буклети, оскільки це статичні дані)

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty') as 'medical' | 'pharmaceutical' | null

    // Перевіряємо кеш
    const cacheKey = `tests_${faculty || 'all'}`;
    const cached = testsCache.get(cacheKey);
    
    if (cached && (Date.now() - cached.timestamp) < CACHE_DURATION) {
      console.log('📦 Returning cached tests data');
      return NextResponse.json(cached.data);
    }

    // Тимчасово використовуємо mock дані поки база даних не налаштована
    const mockSubjects = [
      { id: 'anatomy', title: 'Анатомія', totalQuestions: 200, hasProgress: true },
      { id: 'histology', title: 'Гістологія', totalQuestions: 100, hasProgress: true },
      { id: 'physiology', title: 'Фізіологія', totalQuestions: 300, hasProgress: true },
      { id: 'pharmacology', title: 'Фармакологія', totalQuestions: 296, hasProgress: true },
      { id: 'biology', title: 'Біологія', totalQuestions: 140, hasProgress: true },
      { id: 'pathology', title: 'Патологія', totalQuestions: 221, hasProgress: true },
      { id: 'pathophysiology', title: 'Патологічна фізіологія', totalQuestions: 270, hasProgress: true },
      { id: 'microbiology', title: 'Мікробіологія', totalQuestions: 147, hasProgress: true },
      { id: 'pathomorphology', title: 'Патоморфологія', totalQuestions: 229, hasProgress: true }
    ]

  const pharmaceuticalSubjects = [
    { id: 'analytical-chemistry', title: 'Аналітична хімія', totalQuestions: 376, hasProgress: true },
    { id: 'microbiology-pharmaceutical', title: 'Мікробіологія', totalQuestions: 269, hasProgress: true },
    { id: 'biochemistry-pharmaceutical', title: 'Біохімія', totalQuestions: 340, hasProgress: true },
    { id: 'pharmacology-pharmaceutical', title: 'Фармакологія', totalQuestions: 352, hasProgress: true },
    { id: 'botany-pharmaceutical', title: 'Ботаніка', totalQuestions: 313, hasProgress: true },
    { id: 'pathophysiology-pharmaceutical', title: 'Патофізіологія', totalQuestions: 370, hasProgress: true },
    { id: 'physical-chemistry-pharmaceutical', title: 'Фізична та колоїдна хімія', totalQuestions: 283, hasProgress: true },
        { id: 'organic-chemistry-pharmaceutical', title: 'Органічна хімія', totalQuestions: 318, hasProgress: true }
  ]

    // Фільтруємо за спеціальністю
    const subjects = faculty === 'pharmaceutical' ? pharmaceuticalSubjects : mockSubjects

    // Зберігаємо в кеш
    const responseData = {
      success: true,
      subjects,
      filters: {
        faculty
      },
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    };
    
    testsCache.set(cacheKey, {
      data: responseData,
      timestamp: Date.now()
    });
    
    console.log('💾 Cached tests data for key:', cacheKey);

    return NextResponse.json(responseData)

  } catch (error) {
    console.error('Tests API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
