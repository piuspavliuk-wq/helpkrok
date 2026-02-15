#!/usr/bin/env python3
"""
Парсить тест з Untitled document (2).txt (формат * питання,   * варіант@)
і співставляє зображення з tema3 за порядком питань (ті самі діапазони, що з PDF).

Використання:
  python parse_tema3_txt_with_images.py "/Users/bohdanpavliuk/Downloads/Untitled document (2).txt"
  # Вивід у stdout; перенаправ у supabase/tema3-from-untitled-document-2.sql

Тема: Оксигено- та сульфуровмісні органічні сполуки (або Тема 3 — одна тема в курсі).
"""
import sys
import re
from typing import Optional

COURSE_TITLE = "Основи знань про органічні сполуки"
TOPIC_TITLE = "Оксигено- та сульфуровмісні органічні сполуки"
DIFFICULTY = "medium"
IMAGE_PREFIX = "/test-images/organic/tema3"

# Кожне зображення — лише до одного питання (order_index)
IMAGE_BY_ORDER_INDEX = {
    1: "page1_img1.png",
    12: "page3_img1.png",
    15: "page4_img1.png",
    26: "page6_img1.png",
    41: "page9_img1.png",
    43: "page10_img1.png",
    47: "page11_img1.png",
    52: "page12_img1.png",
    60: "page14_img1.png",
    62: "page15_img1.png",
    71: "page18_img1.png",
    78: "page20_img1.png",
    84: "page21_img1.png",
    88: "page22_img1.png",
    91: "page23_img1.png",
    93: "page24_img1.png",
    94: "page25_img1.png",
    96: "page26_img1.png",
    98: "page27_img1.png",
    101: "page28_img1.png",
    105: "page29_img1.png",
    108: "page30_img1.png",
    110: "page31_img1.png",
    112: "page32_img1.png",
    117: "page33_img1.png",
    121: "page34_img1.png",
    124: "page35_img1.png",
    125: "page36_img1.png",
    128: "page37_img2.png",
    132: "page38_img1.png",
    142: "page40_img1.png",
    144: "page41_img1.png",
    148: "page42_img1.png",
}


def sql_escape(text: str) -> str:
    return text.replace("'", "''")


def image_for_order_index(idx: int) -> Optional[str]:
    name = IMAGE_BY_ORDER_INDEX.get(idx)
    return f"{IMAGE_PREFIX}/{name}" if name else None


def main():
    if len(sys.argv) < 2:
        print("Usage: python parse_tema3_txt_with_images.py path/to/Untitled document (2).txt", file=sys.stderr)
        sys.exit(1)

    path = sys.argv[1]
    topic = sys.argv[2] if len(sys.argv) > 2 else TOPIC_TITLE

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
            opt = line[line.index("*") + 1 :].strip()
            if opt.startswith("* "):
                opt = opt[2:].strip()
            is_correct = opt.endswith("@")
            if is_correct:
                opt = opt[:-1].strip()
            if not opt or opt.strip() in ("-", "–", "—", "−"):
                continue
            if len(opt) > 50 and (opt.endswith("?") or opt.rstrip().endswith(":")):
                continue
            current["options"].append({"text": opt.strip(), "is_correct": is_correct})

    if current and (current["text"] or current["options"]):
        questions.append(current)

    out = []
    out.append("BEGIN;\n\n")
    out.append(f"-- Тема: {topic}. Питання з Untitled document (2).txt + зображення з tema3.\n\n")
    out.append("-- Створити тему, якщо ще немає\n")
    out.append("INSERT INTO topics (course_id, title, description, order_index, is_active)\n")
    out.append(f"SELECT c.id, '{sql_escape(topic)}', 'Оксигено- та сульфуровмісні сполуки', 3, true\n")
    out.append("FROM courses c\n")
    out.append(f"WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
    out.append(f"  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = '{sql_escape(topic)}');\n\n")
    out.append("DELETE FROM question_options WHERE question_id IN (\n")
    out.append("  SELECT q.id FROM questions q\n")
    out.append("  JOIN topics t ON t.id = q.topic_id\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic)}'\n")
    out.append(");\n\n")
    out.append("DELETE FROM questions WHERE topic_id = (\n")
    out.append("  SELECT t.id FROM topics t\n")
    out.append("  JOIN courses c ON c.id = t.course_id\n")
    out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
    out.append(f"    AND t.title = '{sql_escape(topic)}'\n")
    out.append(");\n\n")

    for idx, q in enumerate(questions, start=1):
        text = q["text"] or "-"
        img = image_for_order_index(idx)
        img_val = f"'{sql_escape(img)}'" if img else "NULL"
        out.append(f"-- Question {idx}\n")
        out.append("WITH inserted_question AS (\n")
        out.append(
            "  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)\n"
        )
        out.append(
            f"  SELECT t.id, '{sql_escape(text)}', NULL, '{DIFFICULTY}', {idx}, true, {img_val}\n"
        )
        out.append("  FROM topics t\n")
        out.append("  JOIN courses c ON c.id = t.course_id\n")
        out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
        out.append(f"    AND t.title = '{sql_escape(topic)}'\n")
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
        else:
            out.append("INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES\n")
            out.append("  ((SELECT id FROM inserted_question), '-', false, 0);\n\n")

    out.append("COMMIT;\n")
    sys.stdout.write("".join(out))


if __name__ == "__main__":
    main()
