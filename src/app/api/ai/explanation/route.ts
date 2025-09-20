import { NextRequest, NextResponse } from 'next/server';

const GEMINI_API_KEY = process.env.GOOGLE_GEMINI_API_KEY;
const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

export async function POST(request: NextRequest) {
  try {
    if (!GEMINI_API_KEY) {
      return NextResponse.json(
        { error: 'Google Gemini API key не налаштований' },
        { status: 500 }
      );
    }

    const { questionText, selectedAnswer, correctAnswer, options } = await request.json();

    if (!questionText) {
      return NextResponse.json(
        { error: 'Необхідні дані питання' },
        { status: 400 }
      );
    }

    // Встановлюємо correctAnswer якщо не передано
    const finalCorrectAnswer = correctAnswer || selectedAnswer || 'A';

    // Формуємо запит до Gemini
    const prompt = `
Як експерт з медицини, надай детальне пояснення до питання з анатомії.

ПИТАННЯ: ${questionText}

ВАРІАНТИ ВІДПОВІДЕЙ:
${options.map((opt: any, index: number) => `${String.fromCharCode(65 + index)}. ${opt.text}`).join('\n')}

ПРАВИЛЬНА ВІДПОВІДЬ: ${finalCorrectAnswer}
${selectedAnswer ? `ОБРАНА ВІДПОВІДЬ: ${selectedAnswer}` : ''}

Будь ласка, надай:
1. Коротке пояснення правильної відповіді
2. Чому інші варіанти неправильні (якщо є)
3. Додаткову корисну інформацію з анатомії
4. Практичні приклади або клінічні випадки

Відповідай українською мовою, будь точним та професійним.
`;

    console.log('🔍 Відправляємо запит до Gemini API...');
    console.log('🔑 API Key:', GEMINI_API_KEY ? 'Налаштований' : 'Відсутній');
    console.log('🌐 URL:', GEMINI_API_URL);
    
    const response = await fetch(`${GEMINI_API_URL}?key=${GEMINI_API_KEY}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: prompt
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        }
      })
    });

    console.log('📊 Статус відповіді Gemini:', response.status);
    console.log('📊 Статус текст Gemini:', response.statusText);

    if (!response.ok) {
      const errorData = await response.text();
      console.error('❌ Gemini API error:', response.status, errorData);
      return NextResponse.json(
        { error: `Помилка отримання пояснення від AI: ${response.status} - ${errorData}` },
        { status: 500 }
      );
    }

    const data = await response.json();
    const explanation = data.candidates?.[0]?.content?.parts?.[0]?.text;

    if (!explanation) {
      return NextResponse.json(
        { error: 'Не вдалося отримати пояснення' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      explanation: explanation.trim(),
      generatedAt: new Date().toISOString()
    });

  } catch (error) {
    console.error('AI Explanation API error:', error);
    return NextResponse.json(
      { error: 'Внутрішня помилка сервера' },
      { status: 500 }
    );
  }
}
