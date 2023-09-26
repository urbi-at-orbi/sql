-- Solutions for "Aufgaben SQL II"
-- by urbi@orbi.baby as PD

--
-- Aufgabe 1
--
INSERT INTO
  mitarbeiter_projekte
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname = "Groß"),(SELECT id FROM projekte WHERE bezeichnung="Schwimmende Tribüne")),
  ((SELECT id FROM mitarbeiter WHERE nachname = "Bier"),(SELECT id FROM projekte WHERE bezeichnung="Schwimmende Tribüne"));

--
-- Aufgabe 2
--
SELECT
  p.bezeichnung, m.personalnummer, m.nachname
FROM
  mitarbeiter_projekte mp
JOIN
   projekte p ON p.id = mp.id_projekt
JOIN
  mitarbeiter m ON m.id = mp.id_mitarbeiter
ORDER BY
  p.bezeichnung, m.personalnummer DESC;


--
-- Aufgabe 3
--
