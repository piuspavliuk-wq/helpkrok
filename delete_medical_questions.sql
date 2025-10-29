-- Безпечний скрипт для видалення тільки медичних питань
-- Видаляє тільки записи з faculty = 'medical'

-- Спочатку подивимося скільки записів є
SELECT COUNT(*) as total_medical_questions FROM physiology_questions WHERE faculty = 'medical';

-- Видаляємо тільки медичні питання
DELETE FROM physiology_questions WHERE faculty = 'medical';

-- Перевіряємо результат
SELECT COUNT(*) as remaining_medical_questions FROM physiology_questions WHERE faculty = 'medical';
SELECT COUNT(*) as total_remaining_questions FROM physiology_questions;
