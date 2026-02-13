"""
Usage:
  python pdf_to_tests_with_images.py "path/to/input.pdf" > supabase/tema1-with-images.sql

Цей скрипт:
- зчитує PDF із тестами (кулі bullet * / •, варіанти o, правильна відповідь з @),
- зберігає зображення по сторінках у IMAGES_DIR,
- генерує SQL для таблиць courses/topics/questions/question_options,
  додаючи до questions поле image_url (ALTER TABLE IF NOT EXISTS).
"""

import sys
import os
import re

import fitz  # PyMuPDF

COURSE_TITLE = "Основи знань про органічні сполуки"
TOPIC_TITLE = "Вуглеводні та їх галогенопохідні"
DIFFICULTY = "medium"

# Куди зберігаємо PNG-картинки (відносно кореня проєкту)
IMAGES_DIR = "public/test-images/organic/tema1"
PUBLIC_PREFIX = "/test-images/organic/tema1"


if len(sys.argv) < 2:
  print("Usage: python pdf_to_tests_with_images.py input.pdf > output.sql", file=sys.stderr)
  sys.exit(1)

pdf_path = sys.argv[1]

os.makedirs(IMAGES_DIR, exist_ok=True)


def sql_escape(text: str) -> str:
  return text.replace("'", "''")


doc = fitz.open(pdf_path)

pages = []  # [{text: str, images: [public_url]}]

for page_index, page in enumerate(doc):
  text = page.get_text("text")
  images = []

  for img_index, img in enumerate(page.get_images(full=True)):
    xref = img[0]
    pix = fitz.Pixmap(doc, xref)
    rel_name = f"page{page_index + 1}_img{img_index + 1}.png"
    abs_path = os.path.join(IMAGES_DIR, rel_name)

    if pix.n > 4:
      pix = fitz.Pixmap(fitz.csRGB, pix)
    pix.save(abs_path)
    pix = None

    images.append(f"{PUBLIC_PREFIX}/{rel_name}")

  pages.append({"text": text, "images": images})


question_pattern = re.compile(r"^[•*]\s+(.*)")
option_pattern = re.compile(r"^o\s+(.*)")

questions = []  # [{text, options: [{text,is_correct}], image_url}]

for page in pages:
  lines = [l.strip() for l in page["text"].splitlines()]
  page_start_index = len(questions)
  current = None
  i = 0

  while i < len(lines):
    line = lines[i]
    if not line or line.startswith("--"):
      i += 1
      continue

    m_q = question_pattern.match(line)
    if m_q:
      if current:
        questions.append(current)
      text = m_q.group(1).strip()
      current = {"text": text, "options": []}

      # захопити можливі наступні рядки питання
      j = i + 1
      while j < len(lines):
        nxt = lines[j].strip()
        if not nxt or question_pattern.match(nxt) or option_pattern.match(nxt):
          break
        current["text"] += " " + nxt
        j += 1
      i = j
      continue

    m_o = option_pattern.match(line)
    if m_o and current:
      opt = m_o.group(1).strip()
      is_correct = False
      if opt.endswith("@"):
        is_correct = True
        opt = opt[:-1].strip()
      current["options"].append({"text": opt, "is_correct": is_correct})
      i += 1
      continue

    i += 1

  if current:
    questions.append(current)

  # Проста евристика: перше зображення сторінки прив'язуємо до всіх питань сторінки
  img_url = page["images"][0] if page["images"] else None
  for q in questions[page_start_index:]:
    q["image_url"] = img_url


out: list[str] = []

out.append("BEGIN;\n\n")
out.append("-- Auto-generated from PDF with images\n")
out.append("INSERT INTO courses (title, description, faculty, order_index, is_active)\n")
out.append(
  f"SELECT '{sql_escape(COURSE_TITLE)}', 'Автоматично імпортований курс', 'pharmaceutical', 1, true\n"
)
out.append(
  f"WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = '{sql_escape(COURSE_TITLE)}');\n\n"
)

out.append("INSERT INTO topics (course_id, title, description, order_index, is_active)\n")
out.append(
  f"SELECT c.id, '{sql_escape(TOPIC_TITLE)}', 'Автоматично імпортована тема', 1, true\n"
)
out.append("FROM courses c\n")
out.append(f"WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
out.append(
  f"  AND NOT EXISTS (SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = '{sql_escape(TOPIC_TITLE)}');\n\n"
)

out.append("ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;\n\n")

for idx, q in enumerate(questions, start=1):
  out.append(f"-- Question {idx}\n")
  out.append("WITH inserted_question AS (\n")
  out.append(
    "  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active, image_url)\n"
  )
  img_val = f"'{sql_escape(q['image_url'])}'" if q.get("image_url") else "NULL"
  out.append(
    "  SELECT t.id, "
    f"'{sql_escape(q['text'])}', NULL, '{DIFFICULTY}', {idx}, true, {img_val}\n"
  )
  out.append("  FROM topics t\n")
  out.append("  JOIN courses c ON c.id = t.course_id\n")
  out.append(f"  WHERE c.title = '{sql_escape(COURSE_TITLE)}'\n")
  out.append(f"    AND t.title = '{sql_escape(TOPIC_TITLE)}'\n")
  out.append("  RETURNING id\n")
  out.append(")\n")
  out.append(
    "INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES\n"
  )

  for oi, opt in enumerate(q["options"]):
    out.append(
      f"  ((SELECT id FROM inserted_question), "
      f"'{sql_escape(opt['text'])}', "
      f"{'true' if opt['is_correct'] else 'false'}, {oi})"
    )
    out.append(";\n\n" if oi == len(q["options"]) - 1 else ",\n")

out.append("COMMIT;\n")

sys.stdout.write("".join(out))

