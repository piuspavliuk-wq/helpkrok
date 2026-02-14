"""
Оновлення image_url для існуючих питань теми "Вуглеводні та їх галогенопохідні".
Витягує картинки з PDF, зберігає в public/test-images/organic/tema1/,
зіставляє зображення з питаннями за позицією (як у pdf_to_tests_with_images.py),
генерує тільки UPDATE для questions (без дублювання питань).

Usage:
  python update_tema1_images_from_pdf.py "/path/to/Тема_1_Вуглеводні_та_їх_галогенопохідні.pdf"
  # Потім виконати виведений SQL у Supabase (або перенаправити в файл і виконати)
"""

import sys
import os
import re

import fitz  # PyMuPDF

COURSE_TITLE = "Основи знань про органічні сполуки"
TOPIC_TITLE = "Вуглеводні та їх галогенопохідні"

IMAGES_DIR = "public/test-images/organic/tema1"
PUBLIC_PREFIX = "/test-images/organic/tema1"
MIN_IMAGE_WIDTH = 50
MIN_IMAGE_HEIGHT = 50

if len(sys.argv) < 2:
  print("Usage: python update_tema1_images_from_pdf.py path/to.pdf [> updates.sql]", file=sys.stderr)
  sys.exit(1)

pdf_path = sys.argv[1]
if not os.path.isfile(pdf_path):
  print(f"File not found: {pdf_path}", file=sys.stderr)
  sys.exit(1)

os.makedirs(IMAGES_DIR, exist_ok=True)


def sql_escape(text: str) -> str:
  return text.replace("'", "''")


def _question_starts_block(content: str) -> bool:
  s = (content or "").strip()
  return s.startswith("\u25cf") or s.startswith("\u2022") or s.startswith("*") or s.startswith("\uf0b7")


def _assign_images_to_questions(page_questions, page_data):
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


doc = fitz.open(pdf_path)
pages = []

for page_index, page in enumerate(doc):
  text = page.get_text("text")
  blocks = page.get_text("blocks")
  raw_images = page.get_images(full=True)
  seen_xrefs = {}
  images_with_pos = []

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

    images_with_pos.append((y0, f"{PUBLIC_PREFIX}/{rel_name}"))

  images_with_pos.sort(key=lambda x: x[0])
  pages.append({"text": text, "images_with_pos": images_with_pos, "blocks": blocks})

doc.close()

question_pattern = re.compile(r"^[\u2022*\uf0b7]\s+(.*)")
option_pattern = re.compile(r"^o\s+(.*)")
questions = []
use_circle_format = any(
  s.startswith("\u25cf") or s == "\u25cf\u200b" or s == "\u25cf "
  for p in pages
  for s in p["text"].splitlines()
  if s.strip()
)


def parse_circle_format(pages):
  bullet_markers = ("\u25cf", "\u25cf\u200b", "\u25cf ")
  qs = []
  for page in pages:
    lines = [l.strip() for l in page["text"].splitlines()]
    page_start = len(qs)
    i, current = 0, None
    while i < len(lines):
      line = lines[i]
      if not line:
        i += 1
        continue
      if line.startswith("\u25cf") or line in bullet_markers:
        i += 1
        content = lines[i].strip() if i < len(lines) else ""
        i += 1
        if not content:
          continue
        is_correct = content.endswith("@")
        if is_correct:
          content = content[:-1].strip()
        if current is None or len(current["options"]) >= 5:
          if current:
            qs.append(current)
          current = {"text": content, "options": []}
        else:
          current["options"].append({"text": content, "is_correct": is_correct})
        continue
      i += 1
    if current:
      qs.append(current)
    _assign_images_to_questions(qs[page_start:], page)
  return qs


def parse_bullet_format(pages):
  qs = []
  for page in pages:
    lines = [l.strip() for l in page["text"].splitlines()]
    page_start_index = len(qs)
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
          qs.append(current)
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
        is_correct = opt.endswith("@")
        if is_correct:
          opt = opt[:-1].strip()
        current["options"].append({"text": opt, "is_correct": is_correct})
        i += 1
        continue
      i += 1
    if current:
      qs.append(current)
    _assign_images_to_questions(qs[page_start_index:], page)
  return qs


questions = parse_circle_format(pages) if use_circle_format else parse_bullet_format(pages)

# Збираємо діапазони: поспіль питання з однаковим image_url → один UPDATE (BETWEEN a AND b).
# Увага: це працює тільки якщо порядок питань у БД (order_index) збігається з порядком у PDF.
def ranges_with_same_image():
  if not questions:
    return
  start = 1
  prev_url = questions[0].get("image_url")
  for idx in range(2, len(questions) + 2):
    curr_url = questions[idx - 1].get("image_url") if idx <= len(questions) else None
    if idx > len(questions) or curr_url != prev_url:
      yield (start, idx - 1, prev_url)
      if idx <= len(questions):
        start = idx
        prev_url = curr_url
  return


topic_subquery = (
  "SELECT t.id FROM topics t "
  "JOIN courses c ON c.id = t.course_id "
  f"WHERE c.title = '{sql_escape(COURSE_TITLE)}' AND t.title = '{sql_escape(TOPIC_TITLE)}'"
)

out = []
out.append("-- Картинки тільки за номером питання (order_index). БЕЗ зіставлення за текстом.\n")
out.append("-- ВАЖЛИВО: порядок питань у БД має збігатися з порядком у PDF (питання 1 = перше в PDF, 2 = друге, тощо).\n")
out.append("-- Якщо у вас інший порядок — спочатку видаліть питання цієї теми і імпортуйте їх з PDF скриптом pdf_to_tests_with_images.py.\n\n")
out.append("ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;\n\n")
out.append("-- Очистити всі картинки в цій темі\n")
out.append(f"UPDATE questions SET image_url = NULL WHERE topic_id = ({topic_subquery});\n\n")
out.append("-- Прив'язати картинки за діапазонами order_index (як у PDF)\n")

for start, end, img_url in ranges_with_same_image():
  if img_url:
    out.append(
      f"UPDATE questions SET image_url = '{sql_escape(img_url)}' "
      f"WHERE topic_id = ({topic_subquery}) AND order_index BETWEEN {start} AND {end};\n"
    )
  # для NULL діапазонів нічого не робимо — вже очистили вище

print("".join(out))
