import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty') as 'medical' | 'pharmaceutical' | null

    // Тимчасово використовуємо mock дані поки база даних не налаштована
    const mockSubjects = [
      { id: 'anatomy', title: 'Анатомія', totalQuestions: 200, hasProgress: true },
      { id: 'histology', title: 'Гістологія', totalQuestions: 100, hasProgress: true },
      { id: 'physiology', title: 'Фізіологія', totalQuestions: 300, hasProgress: true },
      { id: 'pharmacology', title: 'Фармакологія', totalQuestions: 296, hasProgress: true },
      { id: 'biology', title: 'Біологія', totalQuestions: 140, hasProgress: true },
      { id: 'pathology', title: 'Патологія', totalQuestions: 221, hasProgress: true },
      { id: 'pathophysiology', title: 'Патологічна фізіологія', totalQuestions: 107, hasProgress: true },
      { id: 'microbiology', title: 'Мікробіологія', totalQuestions: 563, hasProgress: true }
    ]

    const pharmaceuticalSubjects = [
      { id: 'pharm-chem', title: 'Фармацевтична хімія', totalQuestions: 180 },
      { id: 'pharm-tech', title: 'Фармацевтична технологія', totalQuestions: 220 },
      { id: 'pharm-analysis', title: 'Фармацевтичний аналіз', totalQuestions: 150 },
      { id: 'pharm-management', title: 'Фармацевтичне менеджмент', totalQuestions: 120 },
      { id: 'pharm-law', title: 'Фармацевтичне право', totalQuestions: 90 },
      { id: 'pharm-economics', title: 'Фармацевтична економіка', totalQuestions: 110 }
    ]

    // Фільтруємо за спеціальністю
    const subjects = faculty === 'pharmaceutical' ? pharmaceuticalSubjects : mockSubjects

    return NextResponse.json({
      success: true,
      subjects,
      filters: {
        faculty
      },
      note: 'Використовуються тестові дані. База даних буде налаштована пізніше.'
    })

  } catch (error) {
    console.error('Tests API error:', error)
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    )
  }
}
