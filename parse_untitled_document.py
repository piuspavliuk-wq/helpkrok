#!/usr/bin/env python3
"""
Парсить Untitled document.txt (питання "* ", варіанти з пробілами+"* " і правильний варіант позначений "@").

Генерує SQL:
- (опційно) створює курс і тему, якщо їх ще немає
- видаляє старі питання теми
- вставляє нові питання і варіанти

Приклад:
  python parse_untitled_document.py "/path/Untitled document.txt" --course "Система кровотворення й імунного захисту, кров" --topic "Нормальний розвиток і структура, вікові зміни"
"""

import argparse
import re
import sys

DEFAULT_COURSE_TITLE = "Основи знань про органічні сполуки"
DEFAULT_TOPIC_TITLE = "Нітрогеновмісні органічні сполуки"
DEFAULT_FACULTY = "pharmaceutical"
DEFAULT_COURSE_ORDER_INDEX = 1
DIFFICULTY = "medium"


def sql_escape(text: str) -> str:
    return (text or "").replace("'", "''")

def looks_like_question(text: str) -> bool:
    t = (text or "").strip()
    if len(t) < 15:
        return False
    return t.endswith("?") or t.endswith(":") or t.endswith(".")

def parse_option_text(raw: str) -> tuple[str, bool]:
    opt = (raw or "").strip()
    is_correct = opt.endswith("@")
    if is_correct:
        opt = opt[:-1].strip()
    return opt, is_correct

def main():
    parser = argparse.ArgumentParser(description="Parse Untitled document.txt and generate SQL for a topic.")
    parser.add_argument("path", help="Path to Untitled document.txt")
    parser.add_argument("--course", default=DEFAULT_COURSE_TITLE, help="Course title in DB")
    parser.add_argument("--topic", default=DEFAULT_TOPIC_TITLE, help="Topic title in DB (must match section.title for UI)")
    parser.add_argument("--faculty", default=DEFAULT_FACULTY, choices=["medical", "pharmaceutical"], help="Course faculty")
    parser.add_argument("--course-order-index", type=int, default=DEFAULT_COURSE_ORDER_INDEX, help="order_index for course insert")
    parser.add_argument("--ensure-course-topic", action="store_true", help="Insert course/topic if missing")
    args = parser.parse_args()

    path = args.path
    course_title = args.course
    topic_title = args.topic

    with open(path, "r", encoding="utf-8-sig") as f:
        lines = [line.rstrip("\n\r") for line in f]

    questions = []
    current = None

    for line in lines:
        if re.match(r"^\* ", line):
            if current and (current["text"] or current["options"]):
                questions.append(current)
            text = line[2:].strip()
            # Деякі файли мають варіанти без відступу (також починаються з "* ").
            # Якщо вже є поточне питання і рядок виглядає як короткий варіант відповіді,
            # не починаємо нове питання.
            if current is not None and len(current["options"]) < 10:
                opt, is_correct = parse_option_text(text)
                if opt and (is_correct or (not looks_like_question(opt) and len(opt) <= 40)):
                    current["options"].append({"text": opt, "is_correct": is_correct})
                    continue
            current = {"text": text, "options": []}
        elif re.match(r"^\s+\* ", line):
            if current is None:
                current = {"text": "", "options": []}
            # довільна кількість пробілів перед * — зрізаємо до першого *
            opt = line[line.index("*") + 1 :].strip()
            if opt.startswith("* "):
                opt = opt[2:].strip()
            opt, is_correct = parse_option_text(opt)
            # не додаємо порожні варіанти та варіанти "тире"
            if not opt or opt.strip() in ("-", "–", "—", "−"):
                continue
            # пропускаємо рядки-дублікати питання (довгий текст з ? або :)
            if len(opt) > 50 and (opt.endswith("?") or opt.rstrip().endswith(":")):
                continue
            current["options"].append({"text": opt.strip(), "is_correct": is_correct})

    if current and (current["text"] or current["options"]):
        questions.append(current)

    out = []
    out.append("BEGIN;\n\n")

    if args.ensure_course_topic:
        out.append(f"-- Переконатися, що курс і тема існують (якщо ще не створені)\n")
        out.append(
            "INSERT INTO courses (title, description, faculty, order_index, is_active, created_at, updated_at)\n"
        )
        out.append(
            f"SELECT '{sql_escape(course_title)}', 'Автоматично імпортований курс', '{args.faculty}', {args.course_order_index}, true, NOW(), NOW()\n"
        )
        out.append(
            f"WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = '{sql_escape(course_title)}');\n\n"
        )
        out.append("INSERT INTO topics (course_id, title, description, order_index, is_active, created_at, updated_at)\n")
        out.append(
            f"SELECT c.id, '{sql_escape(topic_title)}', 'Автоматично імпортована тема', 0, true, NOW(), NOW()\n"
        )
        out.append("FROM courses c\n")
        out.append(f"WHERE c.title = '{sql_escape(course_title)}'\n")
        out.append(
            f"  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = '{sql_escape(topic_title)}');\n\n"
        )

    out.append(f"-- Видалити старі питання теми {topic_title}\n\n")
    out.append("DELETE FROM question_options\n")
    out.append("WHERE question_id IN (\n")
    out.append("  SELECT q.id FROM questions q\n")
    out.append("  JOIN topics t ON t.id = q.topic_id\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(course_title)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
    out.append(");\n\n")
    out.append("DELETE FROM questions\n")
    out.append("WHERE topic_id = (\n")
    out.append("  SELECT t.id FROM topics t\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(course_title)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
    out.append(");\n\n")

    out.append("-- Вставляємо питання з документа\n\n")
    for idx, q in enumerate(questions, start=1):
        text = q["text"] or "-"
        out.append(f"-- Question {idx}\n")
        opts = q["options"]
        if opts:
            out.append("WITH inserted_question AS (\n")
            out.append(
                "  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)\n"
            )
            out.append(
                f"  SELECT t.id, '{sql_escape(text)}', NULL, '{DIFFICULTY}', {idx}, true, NULL\n"
            )
            out.append("  FROM topics t\n")
            out.append("  JOIN courses c ON c.id = t.course_id\n")
            out.append(f"  WHERE c.title = '{sql_escape(course_title)}'\n")
            out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
            out.append("  RETURNING id\n")
            out.append(")\n")
            out.append("INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES\n")
            for oi, opt in enumerate(opts):
                out.append(
                    f"  ((SELECT id FROM inserted_question), '{sql_escape(opt['text'])}', "
                    f"{'true' if opt['is_correct'] else 'false'}, {oi})"
                )
                out.append(";\n\n" if oi == len(opts) - 1 else ",\n")
        else:
            # Питання без варіантів — просто вставляємо питання, щоб SQL не ламався на CTE.
            out.append(
                "INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)\n"
            )
            out.append(
                f"SELECT t.id, '{sql_escape(text)}', NULL, '{DIFFICULTY}', {idx}, true, NULL\n"
            )
            out.append("FROM topics t\n")
            out.append("JOIN courses c ON c.id = t.course_id\n")
            out.append(f"WHERE c.title = '{sql_escape(course_title)}'\n")
            out.append(f"  AND t.title = '{sql_escape(topic_title)}';\n\n")
        out.append("\n")
    out.append("COMMIT;\n")
    sys.stdout.write("".join(out))


if __name__ == "__main__":
    main()
