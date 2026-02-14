"""
Usage:
  python pdf_to_tests_with_images.py "path/to/input.pdf" > supabase/tema1-with-images.sql
  python pdf_to_tests_with_images.py "path/to/input.pdf" "Нітрогеновмісні органічні сполуки" tema2 > supabase/tema2-with-images.sql

Цей скрипт:
- зчитує PDF із тестами (кулі bullet * / • / ●, варіанти o, правильна відповідь з @),
- зберігає зображення по сторінках у IMAGES_DIR,
- зіставляє зображення з питаннями за позицією на сторінці (y-координата),
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

# Мінімальний розмір зображення (пікселі) — фільтруємо дрібні іконки/логотипи
MIN_IMAGE_WIDTH = 50
MIN_IMAGE_HEIGHT = 50


if len(sys.argv) < 2:
  print("Usage: python pdf_to_tests_with_images.py input.pdf [topic_title] [images_subdir] > output.sql", file=sys.stderr)
  sys.exit(1)

pdf_path = sys.argv[1]
if not os.path.isfile(pdf_path):
  print(f"File not found: {pdf_path}", file=sys.stderr)
  sys.exit(1)

if len(sys.argv) >= 3:
  TOPIC_TITLE = sys.argv[2]
if len(sys.argv) >= 4:
  subdir = sys.argv[3].strip().strip("/")
  IMAGES_DIR = f"public/test-images/organic/{subdir}"
  PUBLIC_PREFIX = f"/test-images/organic/{subdir}"

os.makedirs(IMAGES_DIR, exist_ok=True)


def sql_escape(text: str) -> str:
  return text.replace("'", "''")


doc = fitz.open(pdf_path)

pages = []  # [{text, images: [(y0, public_url)], blocks}]

for page_index, page in enumerate(doc):
  text = page.get_text("text")
  blocks = page.get_text("blocks")

  raw_images = page.get_images(full=True)
  seen_xrefs = {}  # xref -> rel_name (щоб не дублювати однакові зображення)

  images_with_pos = []  # [(y0, public_url), ...]

  for img_index, img in enumerate(raw_images):
    xref = img[0]
    try:
      pix = fitz.Pixmap(doc, xref)
    except Exception:
      continue

    w, h = pix.width, pix.height
    if w < MIN_IMAGE_WIDTH or h < MIN_IMAGE_HEIGHT:
      pix = None
      continue

    if xref in seen_xrefs:
      rel_name = seen_xrefs[xref]
    else:
      rel_name = f"page{page_index + 1}_img{len(seen_xrefs) + 1}.png"
      abs_path = os.path.join(IMAGES_DIR, rel_name)
      if pix.n > 4:
        pix = fitz.Pixmap(fitz.csRGB, pix)
      pix.save(abs_path)
      seen_xrefs[xref] = rel_name

    pix = None

    try:
      bbox = page.get_image_bbox(img)
      y0 = bbox.y0 if bbox else 0
    except Exception:
      y0 = 0

    public_url = f"{PUBLIC_PREFIX}/{rel_name}"
    images_with_pos.append((y0, public_url))

  images_with_pos.sort(key=lambda x: x[0])

  pages.append({
    "text": text,
    "images": [url for _, url in images_with_pos],
    "images_with_pos": images_with_pos,
    "blocks": blocks,
  })

doc.close()


def _question_starts_block(content: str) -> bool:
  """Перевіряє, чи блок є початком питання (• * ●)."""
  s = (content or "").strip()
  return s.startswith("\u25cf") or s.startswith("\u2022") or s.startswith("*") or s.startswith("\uf0b7")


def _assign_images_to_questions(page_questions, page_data):
  """
  Прив'язує зображення до питань за позицією на сторінці.
  - Якщо 1 зображення — всі питання сторінки отримують його.
  - Якщо кілька — кожне питання отримує зображення, найближче вище нього по y.
  """
  images_with_pos = page_data.get("images_with_pos", [])
  blocks = page_data.get("blocks", [])

  if not images_with_pos:
    for q in page_questions:
      q["image_url"] = None
    return

  if len(images_with_pos) == 1:
    url = images_with_pos[0][1]
    for q in page_questions:
      q["image_url"] = url
    return

  question_y_positions = []
  for blk in blocks:
    if len(blk) >= 7 and blk[6] == 0:
      content = blk[4] if isinstance(blk[4], str) else ""
      if _question_starts_block(content):
        question_y_positions.append(blk[1])

  if len(question_y_positions) != len(page_questions):
    for q in page_questions:
      q["image_url"] = images_with_pos[0][1]
    return

  for i, q in enumerate(page_questions):
    q_y = question_y_positions[i] if i < len(question_y_positions) else 0
    above = [(img_y, url) for img_y, url in images_with_pos if img_y <= q_y]
    if above:
      above.sort(key=lambda x: x[0], reverse=True)
      q["image_url"] = above[0][1]
    else:
      q["image_url"] = images_with_pos[0][1]


def _looks_like_question(content: str) -> bool:
  """Чи виглядає рядок як текст питання (а не варіант відповіді)."""
  if not content or len(content) < 10:
    return False
  s = content.strip()
  if s.endswith("?") or s.endswith(":"):
    return True
  if len(s) > 45 and any(
    s.startswith(x) or x in s[:50]
    for x in ("Вкажіть", "Який", "Яка", "При ", "Яку", "Які", "У якому", "Для якого", "Аміди є", "Більшість", "Первинні та")
  ):
    return True
  return False


def parse_format_circle_bullet(pages):
  """Формат: ● або ■ (чорний квадрат) — буллет, контент на наступному рядку.
  Питання відрізняємо за змістом (? : або довгий текст з ключовими словами), не за кількістю варіантів. @ = правильна."""
  questions = []
  circle_bullet = "\u25cf"  # ●
  square_bullet = "\u25A0"  # ■
  bullet_markers = ("\u25cf", "\u25cf\u200b", "\u25cf ")  # ●, ●\u200b, ● space
  max_options_per_question = 12

  for page in pages:
    lines = [l.strip() for l in page["text"].splitlines()]
    page_start = len(questions)
    i = 0
    current = None

    while i < len(lines):
      line = lines[i]
      if not line:
        i += 1
        continue
      is_square = line.startswith(square_bullet)
      is_circle = line.startswith(circle_bullet) or line in bullet_markers
      if not (is_square or is_circle):
        i += 1
        continue

      i += 1
      content = lines[i].strip() if i < len(lines) else ""
      i += 1
      if not content:
        continue

      is_correct = content.endswith("@")
      if is_correct:
        content = content[:-1].strip()

      if is_square:
        if current:
          questions.append(current)
        current = {"text": content, "options": []}
        continue

      if is_circle:
        if current is None:
          current = {"text": content, "options": []}
          continue
        if _looks_like_question(content) and len(current["options"]) > 0:
          if current:
            questions.append(current)
          current = {"text": content, "options": []}
        elif len(current["options"]) < max_options_per_question:
          current["options"].append({"text": content, "is_correct": is_correct})
        continue
      i += 1

    if current:
      questions.append(current)

    _assign_images_to_questions(questions[page_start:], page)

  return questions


# Буллети: • (U+2022), *, U+F0B7, ● (часто в PDF)
_bullet = "\u2022*\uf0b7"
question_pattern = re.compile("^[" + _bullet + "]\\s+(.*)")
option_pattern = re.compile(r"^o\s+(.*)")

questions = []
# Визначаємо формат: ● або ■ (чорний квадрат) — формат з буллетами
use_circle_format = False
for page in pages:
  for line in page["text"].splitlines():
    s = line.strip()
    if s.startswith("\u25cf") or s == "\u25cf\u200b" or s.startswith("\u25A0"):
      use_circle_format = True
      break
  if use_circle_format:
    break

if use_circle_format:
  questions = parse_format_circle_bullet(pages)
else:
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

    _assign_images_to_questions(questions[page_start_index:], page)


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
  opts = q["options"]
  if not opts:
    # Питання без варіантів — один порожній варіант, щоб SQL був валідним
    out.append("  ((SELECT id FROM inserted_question), '-', false, 0);\n\n")
  else:
    for oi, opt in enumerate(opts):
      out.append(
        f"  ((SELECT id FROM inserted_question), "
        f"'{sql_escape(opt['text'])}', "
        f"{'true' if opt['is_correct'] else 'false'}, {oi})"
      )
      out.append(";\n\n" if oi == len(opts) - 1 else ",\n")

out.append("COMMIT;\n")

sys.stdout.write("".join(out))

