import { NextRequest, NextResponse } from 'next/server'
import { supabase } from '@/lib/supabase'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const faculty = searchParams.get('faculty') as 'medical' | 'pharmaceutical' | null
    const step = searchParams.get('step') as 'krok1' | 'krok2' | 'krok3' | null
    const yearRange = searchParams.get('yearRange') as '2001-2015' | '2015-2025' | null

    // Тимчасово використовуємо mock дані поки база даних не налаштована
    const mockSubjects = [
      { id: 'anatomy', title: 'Анатомія', totalQuestions: 207 },
      { id: 'biology', title: 'Біологія', totalQuestions: 142 },
      { id: 'biochemistry', title: 'Біохімія', totalQuestions: 308 },
      { id: 'physiology', title: 'Фізіологія', totalQuestions: 280 },
      { id: 'histology', title: 'Гістологія', totalQuestions: 102 },
      { 
        id: 'microbiology', 
        title: 'Мікробіологія', 
        totalQuestions: 144, 
        completedQuestions: 0, 
        hasProgress: true 
      },
      { 
        id: 'pathomorphology', 
        title: 'Патоморфологія', 
        totalQuestions: 228, 
        completedQuestions: 5, 
        hasProgress: true, 
        isCompleted: true 
      },
      { 
        id: 'pathophysiology', 
        title: 'Патофізіологія', 
        totalQuestions: 274, 
        completedQuestions: 0, 
        hasProgress: true 
      },
      { 
        id: 'pharmacology', 
        title: 'Фармакологія', 
        totalQuestions: 267, 
        completedQuestions: 0, 
        bestScore: 78.0, 
        hasProgress: true 
      }
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
        faculty,
        step,
        yearRange
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
