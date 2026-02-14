#!/usr/bin/env python3
"""
Парсить Untitled document.txt (питання * , варіанти пробіли+* текст@).
Виводить SQL: видалення старих питань теми + INSERT нових.
Використання: python parse_untitled_document.py <шлях до .txt> [назва теми]
  Назва теми за замовчуванням: Нітрогеновмісні органічні сполуки
  Приклад для Вуглеводні: python parse_untitled_document.py "Untitled document (1).txt" "Вуглеводні та їх галогенопохідні"
"""
import sys
import re

COURSE_TITLE = "Основи знань про органічні сполуки"
DEFAULT_TOPIC_TITLE = "Нітрогеновмісні органічні сполуки"
DIFFICULTY = "medium"


def sql_escape(text: str) -> str:
    return text.replace("'", "''")


def main():
    if len(sys.argv) < 2:
        print("Usage: python parse_untitled_document.py path/to/Untitled document.txt [topic title]", file=sys.stderr)
        sys.exit(1)

    path = sys.argv[1]
    topic_title = sys.argv[2] if len(sys.argv) > 2 else DEFAULT_TOPIC_TITLE

    with open(path, "r", encoding="utf-8-sig") as f:
        lines = [line.rstrip("\n\r") for line in f]

    questions = []
    current = None

    for line in lines:
        if re.match(r"^\* ", line):
            if current and (current["text"] or current["options"]):
                questions.append(current)
            text = line[2:].strip()
            current = {"text": text, "options": []}
        elif re.match(r"^\s+\* ", line):
            if current is None:
                current = {"text": "", "options": []}
            # довільна кількість пробілів перед * — зрізаємо до першого *
            opt = line[line.index("*") + 1 :].strip()
            if opt.startswith("* "):
                opt = opt[2:].strip()
            is_correct = opt.endswith("@")
            if is_correct:
                opt = opt[:-1].strip()
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
    out.append(f"-- Видалити старі питання теми {topic_title}\n\n")
    out.append("DELETE FROM question_options\n")
    out.append("WHERE question_id IN (\n")
    out.append("  SELECT q.id FROM questions q\n")
    out.append("  JOIN topics t ON t.id = q.topic_id\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
    out.append(");\n\n")
    out.append("DELETE FROM questions\n")
    out.append("WHERE topic_id = (\n")
    out.append("  SELECT t.id FROM topics t\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
    out.append(");\n\n")

    out.append("-- Курс і тема мають вже існувати; вставляємо лише питання з документа\n\n")
    for idx, q in enumerate(questions, start=1):
        text = q["text"] or "-"
        out.append(f"-- Question {idx}\n")
        out.append("WITH inserted_question AS (\n")
        out.append(
            "  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)\n"
        )
        out.append(
            f"  SELECT t.id, '{sql_escape(text)}', NULL, '{DIFFICULTY}', {idx}, true, NULL\n"
        )
        out.append("  FROM topics t\n")
        out.append("  JOIN courses c ON c.id = t.course_id\n")
        out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
        out.append(f"    AND t.title = '{sql_escape(topic_title)}'\n")
        out.append("  RETURNING id\n")
        out.append(")\n")
        opts = q["options"]
        if opts:
            out.append("INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES\n")
            for oi, opt in enumerate(opts):
                out.append(
                    f"  ((SELECT id FROM inserted_question), '{sql_escape(opt['text'])}', "
                    f"{'true' if opt['is_correct'] else 'false'}, {oi})"
                )
                out.append(";\n\n" if oi == len(opts) - 1 else ",\n")
        out.append("\n")
    out.append("COMMIT;\n")
    sys.stdout.write("".join(out))


if __name__ == "__main__":
    main()
