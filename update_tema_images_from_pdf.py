"""
Витягує зображення з PDF у папку, парсить питання, зіставляє картинки за позицією,
генерує SQL для UPDATE image_url по order_index (питання 1 в PDF = order_index 1 в БД).

Usage:
  python update_tema_images_from_pdf.py "path/to/Тема 3.pdf" ["Тема 3"] [tema3]
  # За замовчуванням: topic_title="Тема 3", subdir=tema3
  # Вивід — SQL у stdout; перенаправ у файл і виконай у Supabase.

Порядок питань у БД має збігатися з порядком у PDF.
"""

import sys
import os
import re

import fitz  # PyMuPDF

COURSE_TITLE = "Основи знань про органічні сполуки"
MIN_IMAGE_WIDTH = 50
MIN_IMAGE_HEIGHT = 50

if len(sys.argv) < 2:
  print("Usage: python update_tema_images_from_pdf.py path/to.pdf [topic_title] [subdir]", file=sys.stderr)
  print("  Example: python update_tema_images_from_pdf.py \"~/Downloads/Тема 3.pdf\" \"Тема 3\" tema3", file=sys.stderr)
  sys.exit(1)

pdf_path = os.path.expanduser(sys.argv[1])
if not os.path.isfile(pdf_path):
  print(f"File not found: {pdf_path}", file=sys.stderr)
  sys.exit(1)

TOPIC_TITLE = sys.argv[2].strip() if len(sys.argv) >= 3 else "Тема 3"
subdir = (sys.argv[3].strip().strip("/") if len(sys.argv) >= 4 else "tema3")
IMAGES_DIR = f"public/test-images/organic/{subdir}"
PUBLIC_PREFIX = f"/test-images/organic/{subdir}"

os.makedirs(IMAGES_DIR, exist_ok=True)
print(f"Images dir: {IMAGES_DIR}", file=sys.stderr)
print(f"Topic: {TOPIC_TITLE}", file=sys.stderr)


def sql_escape(text: str) -> str:
  return text.replace("'", "''")


def _question_starts_block(content: str) -> bool:
  s = (content or "").strip()
  return s.startswith("\u25cf") or s.startswith("\u2022") or s.startswith("*") or s.startswith("\uf0b7") or s.startswith("\u25A0")


def _looks_like_question(content: str) -> bool:
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


# ---------- Витягуємо зображення та текст з PDF ----------
def extract_images_from_page(page, page_index, doc):
  """Витягує зображення: спочатку get_images, якщо 0 — рендеримо області з get_image_info."""
  text = page.get_text("text")
  blocks = page.get_text("blocks")
  raw_images = page.get_images(full=True)
  images_with_pos = []

  if raw_images:
    seen_xrefs = {}
    for img in raw_images:
      xref = img[0]
      try:
        pix = fitz.Pixmap(doc, xref)
      except Exception:
        continue
      w, h = pix.width, pix.height
      if w < MIN_IMAGE_WIDTH or h < MIN_IMAGE_HEIGHT:
        pix = None
        continue
      rel_name = f"page{page_index + 1}_img{len(seen_xrefs) + 1}.png"
      abs_path = os.path.join(IMAGES_DIR, rel_name)
      if pix.n > 4:
        pix = fitz.Pixmap(fitz.csRGB, pix)
      pix.save(abs_path)
      pix = None
      try:
        bbox = page.get_image_bbox(img)
        y0 = bbox.y0 if bbox else 0
      except Exception:
        y0 = 0
      images_with_pos.append((y0, f"{PUBLIC_PREFIX}/{rel_name}"))
      seen_xrefs[xref] = rel_name
  else:
    # Запасний варіант: get_image_info + рендер clip-області
    try:
      info_list = page.get_image_info()
    except Exception:
      info_list = []
    for img_idx, info in enumerate(info_list):
      bbox = info.get("bbox")
      if not bbox or len(bbox) < 4:
        continue
      rect = fitz.Rect(bbox)
      if rect.width < MIN_IMAGE_WIDTH or rect.height < MIN_IMAGE_HEIGHT:
        continue
      try:
        mat = fitz.Matrix(2, 2)
        pix = page.get_pixmap(matrix=mat, clip=rect, alpha=False)
        rel_name = f"page{page_index + 1}_img{img_idx + 1}.png"
        abs_path = os.path.join(IMAGES_DIR, rel_name)
        pix.save(abs_path)
        images_with_pos.append((bbox[1], f"{PUBLIC_PREFIX}/{rel_name}"))
      except Exception:
        continue

  images_with_pos.sort(key=lambda x: x[0])
  return {"text": text, "images_with_pos": images_with_pos, "blocks": blocks}


doc = fitz.open(pdf_path)
pages = []
for page_index in range(len(doc)):
  page = doc[page_index]
  pages.append(extract_images_from_page(page, page_index, doc))
doc.close()

print(f"Extracted {sum(len(p['images_with_pos']) for p in pages)} images, {len(pages)} pages", file=sys.stderr)


# ---------- Парсинг питань (● / ■ або • / o) ----------
question_pattern = re.compile(r"^[\u2022*\uf0b7]\s+(.*)")
option_pattern = re.compile(r"^o\s+(.*)")
circle_bullet = "\u25cf"
square_bullet = "\u25A0"
bullet_markers = ("\u25cf", "\u25cf\u200b", "\u25cf ")
max_options_per_question = 12


def parse_format_circle_square(pages):
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
          qs.append(current)
        current = {"text": content, "options": []}
        continue

      if is_circle:
        if current is None:
          current = {"text": content, "options": []}
          continue
        if _looks_like_question(content) and len(current["options"]) > 0:
          if current:
            qs.append(current)
          current = {"text": content, "options": []}
        elif len(current["options"]) < max_options_per_question:
          current["options"].append({"text": content, "is_correct": is_correct})
        continue
      i += 1

    if current:
      qs.append(current)
    _assign_images_to_questions(qs[page_start:], page)
  return qs


def parse_o_format(pages):
  """Формат: текст питання, потім рядки 'o' або 'o текст' — варіанти, @ = правильна відповідь."""
  qs = []
  for page in pages:
    lines = [l.strip() for l in page["text"].splitlines()]
    page_start = len(qs)
    i = 0
    current = None

    while i < len(lines):
      line = lines[i]
      if not line or line in ("Тема 3", "Оксигено- та сульфуровмісні органічні сполуки") or line == "\ue12c":
        i += 1
        continue

      is_option = line == "o" or (line.startswith("o ") and len(line) > 2) or (len(line) <= 3 and line.startswith("o"))
      if is_option:
        if line == "o" or line == "o " or len(line.strip()) <= 2:
          i += 1
          while i < len(lines) and lines[i].strip() in ("o", "o "):
            i += 1
          opt_text = lines[i].strip() if i < len(lines) else ""
          i += 1
        else:
          opt_text = line[1:].strip()
          i += 1

        is_correct = opt_text.endswith("@")
        if is_correct:
          opt_text = opt_text[:-1].strip()
        if current is None:
          current = {"text": "", "options": []}
        current["options"].append({"text": opt_text, "is_correct": is_correct})
        continue

      # Текст питання
      if current and current["options"]:
        qs.append(current)
        current = {"text": line, "options": []}
      elif current:
        current["text"] = (current["text"] + " " + line).strip()
      else:
        current = {"text": line, "options": []}
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


use_circle_format = any(
  s.startswith(circle_bullet) or s in bullet_markers or s.startswith(square_bullet)
  for p in pages
  for s in p["text"].splitlines()
  if s.strip()
)
use_o_format = any(
  s.strip() == "o" or (s.strip().startswith("o ") and len(s.strip()) > 2)
  for p in pages
  for s in p["text"].splitlines()
)

if use_circle_format:
  questions = parse_format_circle_square(pages)
elif use_o_format:
  questions = parse_o_format(pages)
else:
  questions = parse_bullet_format(pages)
print(f"Parsed {len(questions)} questions", file=sys.stderr)


# ---------- SQL: очистити + прив'язати за order_index ----------
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


topic_subquery = (
  "SELECT t.id FROM topics t "
  "JOIN courses c ON c.id = t.course_id "
  f"WHERE c.title = '{sql_escape(COURSE_TITLE)}' AND t.title = '{sql_escape(TOPIC_TITLE)}'"
)

out = []
out.append(f"-- Зображення з PDF для теми «{TOPIC_TITLE}». Картинки збережено в {IMAGES_DIR}\n")
out.append("-- Порядок питань у БД (order_index) має збігатися з порядком у PDF.\n\n")
out.append("ALTER TABLE questions ADD COLUMN IF NOT EXISTS image_url TEXT;\n\n")
out.append(f"UPDATE questions SET image_url = NULL WHERE topic_id = ({topic_subquery});\n\n")
out.append("-- Прив'язка за діапазонами order_index\n")

for start, end, img_url in ranges_with_same_image():
  if img_url:
    out.append(
      f"UPDATE questions SET image_url = '{sql_escape(img_url)}' "
      f"WHERE topic_id = ({topic_subquery}) AND order_index BETWEEN {start} AND {end};\n"
    )

print("".join(out))
