import { NextRequest, NextResponse } from 'next/server';

const GEMINI_API_KEY = process.env.GOOGLE_GEMINI_API_KEY;

// Пріоритет моделей за вартістю: спочатку найдешевші (Flash), потім Pro.
// Gemini 2.5 Flash — оптимальний варіант: недорого й якісно.
const CHEAPEST_MODELS_FIRST = [
  'gemini-2.5-flash',
  'gemini-2.0-flash',
  'gemini-1.5-flash',
  'gemini-2.5-pro',
  'gemini-1.5-pro',
  'gemini-pro'
];

// Функція для отримання доступних моделей та вибору найвигіднішої (найдешевшої)
async function fetchAvailableModel(): Promise<string> {
  try {
    if (!GEMINI_API_KEY) {
      return CHEAPEST_MODELS_FIRST[0];
    }

    const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models?key=${GEMINI_API_KEY}`, {
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      console.warn('Не вдалося отримати список моделей, використовуємо дефолт');
      return CHEAPEST_MODELS_FIRST[0];
    }

    const data = await response.json();
    const models = data.models || [];

    const toModelId = (name: string) => (name || '').replace(/^models\//, '');

    // Збираємо id моделей, які підтримують generateContent
    const availableIds = new Set<string>();
    for (const model of models) {
      const methods = model.supportedGenerationMethods || [];
      if (methods.includes('generateContent')) {
        const id = toModelId(model.name);
        if (id) availableIds.add(id);
      }
    }
    if (availableIds.size === 0) {
      for (const model of models) {
        const methods = model.supportedGenerationMethods || [];
        if (methods.includes('generateText')) {
          const id = toModelId(model.name);
          if (id) availableIds.add(id);
        }
      }
    }

    // Обираємо першу з нашого списку "від дешевих до дорогих", яка доступна
    for (const id of CHEAPEST_MODELS_FIRST) {
      if (availableIds.has(id)) {
        console.log(`✅ Вибрано найвигіднішу модель: ${id}`);
        return id;
      }
    }

    // Якщо жодна з пріоритетних недоступна — беремо будь-яку першу з API
    for (const model of models) {
      const methods = model.supportedGenerationMethods || [];
      if (methods.includes('generateContent') || methods.includes('generateText')) {
        const id = toModelId(model.name);
        if (id) {
          console.log(`✅ Вибрано модель з API: ${id}`);
          return id;
        }
      }
    }

    console.warn('Не знайдено підходящих моделей, використовуємо дефолт');
    return CHEAPEST_MODELS_FIRST[0];
  } catch (error) {
    console.error('Помилка при отриманні моделей:', error);
    return CHEAPEST_MODELS_FIRST[0];
  }
}

// Метод API для генерації тексту.
const SUPPORTED_METHOD = 'generateContent';

// Функція для очищення форматування від AI та покращення структури тексту
function cleanAIFormatting(text: string): string {
  return text
    // Прибираємо жирний текст **text** -> text
    .replace(/\*\*(.*?)\*\*/g, '$1')
    // Прибираємо курсив *text* -> text
    .replace(/\*(.*?)\*/g, '$1')
    // Прибираємо заголовки ### -> 
    .replace(/^#{1,6}\s*/gm, '')
    // Покращуємо списки з - або * (додаємо відступи)
    .replace(/^[\s]*[-*]\s*/gm, '• ')
    // Покращуємо нумеровані списки (додаємо відступи)
    .replace(/^[\s]*\d+\.\s*/gm, '• ')
    // Додаємо відступи після заголовків (якщо є)
    .replace(/^([А-ЯІЇЄҐ][^:\n]*):\s*$/gm, '$1:\n')
    // Додаємо відступи після основних розділів
    .replace(/(\d+\.\s*[А-ЯІЇЄҐ][^:\n]*):\s*/g, '$1:\n')
    // Додаємо відступи між абзацами
    .replace(/\n\n+/g, '\n\n')
    // Додаємо відступи перед списками
    .replace(/([.!?])\n•/g, '$1\n\n•')
    // Додаємо відступи після списків
    .replace(/•[^\n]*\n(?=[А-ЯІЇЄҐ])/g, (match) => match + '\n')
    // Очищаємо зайві пробіли
    .replace(/[ \t]+/g, ' ')
    .trim();
}

export async function POST(request: NextRequest) {
  try {
    if (!GEMINI_API_KEY) {
      return NextResponse.json(
        { error: 'Google Gemini API key не налаштований' },
        { status: 500 }
      );
    }

    // Цей код автоматично вибирає правильну модель, яку реально підтримує API-ключ
    let GEMINI_MODEL = await fetchAvailableModel();
    
    // Fallback: якщо обрано дефолтну модель, перевіряємо по списку від дешевих до дорогих
    if (GEMINI_MODEL === CHEAPEST_MODELS_FIRST[0]) {
      const fallbackModels = [...CHEAPEST_MODELS_FIRST];
      
      for (const model of fallbackModels) {
        try {
          const testUrl = `https://generativelanguage.googleapis.com/v1beta/models/${model}:${SUPPORTED_METHOD}`;
          const testResponse = await fetch(`${testUrl}?key=${GEMINI_API_KEY}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ contents: [{ parts: [{ text: 'test' }] }] })
          });
          
          if (testResponse.status !== 404) {
            GEMINI_MODEL = model;
            console.log(`✅ Fallback: вибрано модель ${model}`);
            break;
          }
        } catch (error) {
          console.log(`❌ Модель ${model} недоступна`);
        }
      }
    }
    
    const GEMINI_API_URL = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:${SUPPORTED_METHOD}`;

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

Будь ласка, надай структуровану відповідь з чіткими розділами:

1. Пояснення правильної відповіді:
   - Коротке пояснення
   - Детальний опис

2. Чому інші варіанти неправильні:
   - Для кожного неправильного варіанту коротке пояснення

3. Додаткова корисна інформація:
   - Клінічні особливості
   - Практичні приклади

4. Практичні рекомендації:
   - Клінічні випадки
   - Важливі моменти

Відповідай українською мовою, будь точним та професійним. Використовуй чітку структуру з заголовками та списками.
`;

    console.log('🔍 Відправляємо запит до Gemini API...');
    console.log('🔑 API Key:', GEMINI_API_KEY ? 'Налаштований' : 'Відсутній');
    console.log('🤖 Вибрана модель:', GEMINI_MODEL);
    console.log('🔧 Метод:', SUPPORTED_METHOD);
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
          maxOutputTokens: 4096,
        }
      })
    });

    console.log('📊 Статус відповіді Gemini:', response.status);
    console.log('📊 Статус текст Gemini:', response.statusText);

    if (!response.ok) {
      const errorData = await response.text();
      console.error('❌ Gemini API error:', response.status, errorData);
      
      // Спеціальна обробка помилки 400 (API key expired / invalid)
      if (response.status === 400) {
        try {
          const errJson = JSON.parse(errorData);
          const msg = errJson?.error?.message || '';
          const isKeyError = msg.includes('expired') || msg.includes('API key') ||
            (Array.isArray(errJson?.error?.details) && errJson.error.details.some((d: { reason?: string }) => d.reason === 'API_KEY_INVALID'));
          if (isKeyError) {
            return NextResponse.json(
              {
                error: 'Ключ Google Gemini застарів або недійсний.\n\nПереконайтесь, що:\n1. Ключ створений на https://aistudio.google.com/apikey\n2. У .env.local вказано GOOGLE_GEMINI_API_KEY=ваш_ключ\n3. Після зміни .env.local перезапущено dev-сервер (npm run dev)',
                errorCode: 400,
                errorType: 'API_KEY_INVALID'
              },
              { status: 500 }
            );
          }
        } catch (_) { /* ignore */ }
      }
      
      // Спеціальна обробка помилки 429 (Quota exceeded)
      if (response.status === 429) {
        let errorMessage = 'Досягнуто ліміт безкоштовного тарифу Google Gemini API.';
        try {
          const errorJson = JSON.parse(errorData);
          if (errorJson.error?.message) {
            errorMessage = `Досягнуто ліміт безкоштовного тарифу:\n\n${errorJson.error.message}`;
          }
        } catch (e) {
          // Якщо не вдалося розпарсити JSON, використовуємо стандартне повідомлення
        }
        
        return NextResponse.json(
          { 
            error: errorMessage,
            errorCode: 429,
            errorType: 'QUOTA_EXCEEDED',
            suggestion: 'Квоти відновлюються щодня або щомісяця. Перевірте статус на https://ai.dev/usage або перейдіть на платний план.'
          },
          { status: 429 }
        );
      }
      
      // Якщо помилка 404, спробуємо іншу модель
      if (response.status === 404) {
        console.log('🔄 Спробуємо іншу модель через fallback...');
        const fallbackModels = [...CHEAPEST_MODELS_FIRST];
        
        for (const fallbackModel of fallbackModels) {
          try {
            const fallbackUrl = `https://generativelanguage.googleapis.com/v1beta/models/${fallbackModel}:${SUPPORTED_METHOD}`;
            console.log(`🔄 Тестуємо модель: ${fallbackModel}`);
            
            const fallbackResponse = await fetch(`${fallbackUrl}?key=${GEMINI_API_KEY}`, {
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
                  maxOutputTokens: 4096,
                }
              })
            });
            
            if (fallbackResponse.ok) {
              console.log(`✅ Успішно використано модель: ${fallbackModel}`);
              const data = await fallbackResponse.json();
              const explanation = data.candidates?.[0]?.content?.parts?.[0]?.text;
              
              if (explanation) {
                return NextResponse.json({
                  success: true,
                  explanation: cleanAIFormatting(explanation),
                  generatedAt: new Date().toISOString(),
                  model: fallbackModel
                });
              }
            }
          } catch (fallbackError) {
            console.log(`❌ Модель ${fallbackModel} не працює:`, fallbackError);
          }
        }
      }
      
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
      explanation: cleanAIFormatting(explanation),
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
