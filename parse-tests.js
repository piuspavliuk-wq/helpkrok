// node parse-tests.js input.txt > output.sql

const fs = require('fs');

// Configuration for course/topic
const COURSE_TITLE = 'Основи знань про органічні сполуки';
const TOPIC_TITLE = 'Вуглеводні та їх галогенопохідні';
const DIFFICULTY = 'medium';

if (process.argv.length < 3) {
  console.error('Usage: node parse-tests.js input.txt > output.sql');
  process.exit(1);
}

const inputPath = process.argv[2];
const raw = fs.readFileSync(inputPath, 'utf-8');

function sqlEscape(text) {
  return text.replace(/'/g, "''");
}

const lines = raw.split(/\r?\n/).map((l) => l.trim());

/**
 * Parsed questions:
 * { text: string, options: { text: string; isCorrect: boolean }[] }[]
 */
const questions = [];

let currentQuestion = null;

for (let i = 0; i < lines.length; i++) {
  let line = lines[i];

  if (!line || line.startsWith('--')) continue;

  if (line.startsWith('• ') || line.startsWith('* ')) {
    if (currentQuestion) {
      questions.push(currentQuestion);
    }
    let text = line.slice(2).trim();
    currentQuestion = { text, options: [] };

    // merge following lines that belong to the same question (until next bullet/option/page marker)
    while (i + 1 < lines.length) {
      const next = lines[i + 1].trim();
      if (!next || next.startsWith('• ') || next.startsWith('o ') || next.startsWith('--')) break;
      currentQuestion.text += ' ' + next;
      i++;
    }
  } else if (line.startsWith('o ')) {
    if (!currentQuestion) continue;
    let optionText = line.slice(2).trim();
    let isCorrect = false;
    if (optionText.endsWith('@')) {
      isCorrect = true;
      optionText = optionText.slice(0, -1).trim();
    }
    currentQuestion.options.push({ text: optionText, isCorrect });
  }
}

if (currentQuestion) {
  questions.push(currentQuestion);
}

let out = '';

out += 'BEGIN;\n\n';
out += '-- Auto-generated from text file\n';
out += 'INSERT INTO courses (title, description, faculty, order_index, is_active)\n';
out += `SELECT '${sqlEscape(
  COURSE_TITLE,
)}', 'Автоматично імпортований курс', 'pharmaceutical', 1, true\n`;
out += `WHERE NOT EXISTS (SELECT 1 FROM courses WHERE title = '${sqlEscape(
  COURSE_TITLE,
)}');\n\n`;

out += 'INSERT INTO topics (course_id, title, description, order_index, is_active)\n';
out += `SELECT c.id, '${sqlEscape(
  TOPIC_TITLE,
)}', 'Автоматично імпортована тема', 1, true\n`;
out += 'FROM courses c\n';
out += `WHERE c.title = '${sqlEscape(COURSE_TITLE)}'\n`;
out += '  AND NOT EXISTS (\n';
out += `    SELECT 1 FROM topics t WHERE t.course_id = c.id AND t.title = '${sqlEscape(
  TOPIC_TITLE,
)}'\n`;
out += '  );\n\n';

questions.forEach((q, idx) => {
  const qIndex = idx + 1;
  out += `-- Question ${qIndex}\n`;
  out += 'WITH inserted_question AS (\n';
  out += '  INSERT INTO questions (topic_id, question_text, explanation, difficulty, order_index, is_active)\n';
  out += '  SELECT t.id, ';
  out += `'${sqlEscape(q.text)}', NULL, '${DIFFICULTY}', ${qIndex}, true\n`;
  out += '  FROM topics t\n';
  out += '  JOIN courses c ON c.id = t.course_id\n';
  out += `  WHERE c.title = '${sqlEscape(COURSE_TITLE)}'\n`;
  out += `    AND t.title = '${sqlEscape(TOPIC_TITLE)}'\n`;
  out += '  RETURNING id\n';
  out += ')\n';
  out += 'INSERT INTO question_options (question_id, option_text, is_correct, order_index) VALUES\n';

  q.options.forEach((opt, i) => {
    out += `  ((SELECT id FROM inserted_question), '${sqlEscape(
      opt.text,
    )}', ${opt.isCorrect ? 'true' : 'false'}, ${i})`;
    out += i === q.options.length - 1 ? ';\n\n' : ',\n';
  });
});

out += 'COMMIT;\n';

process.stdout.write(out);

