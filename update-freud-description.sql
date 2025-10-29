-- Оновлюємо опис для тесту "Delving into dreams"
UPDATE krok_questions_unified 
SET description = 'In 1896, after his father died, Freud had a series of disturbing dreams, which he wrote down and studied as he began his self-analysis. In one dream, he received a hospital bill for someone who had been in the family home 40 years earlier, before his own birth: In the dream, his father''s ghost admitted to getting drunk and being detained. Freud believed, the dream indicated there was something that his unconscious mind would not allow him to see in his father''s past, such as a sexual abuse or other hidden vices. His relationship with his father had been difficult. Freud told a friend, German physician Wilhelm Fliess, that his self-analysis and dreams had revealed a jealousy of his father and love for his mother - something he later described as an Oedipus complex, from the Greek myth of Oedipus, king of Thebes, who killed his father and unwittingly married his mother. In his landmark 1899 text, The Interpretation of Dreams, Freud outlined his theory that repressed emotions or urges (often of a sexual nature) are expressed or acted out in dreams and nightmares in a form of wish-fulfilment. Dreams, he considered were the outlet of emotions too powerful and painful for the conscious mind to tolerate. He became increasingly convinced that it was traumatic events in childhoodsthat led to mental health issues in adults, as such memories were invariably repressed. As patients could not explain or understand feelings or behaviour caused by factors outside their realm of consciousness, the only route to a cure lay in probing the unconscious, and dreams were a potent route to this unknown area'
WHERE test_identifier = '2025-freud-dreams';

-- Перевірка оновлення
SELECT COUNT(*) as updated_records 
FROM krok_questions_unified 
WHERE test_identifier = '2025-freud-dreams' 
AND description IS NOT NULL;
