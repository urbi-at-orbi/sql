-- Solutions for "Aufgaben SQL II"
-- by urbi@orbi.baby as PD

-- preparation: Add unique constraint to "mitarbeiter_projekte"
ALTER TABLE
  mitarbeiter_projekte
ADD CONSTRAINT
  unique_ma_prj UNIQUE (id_mitarbeiter, id_projekt);

--
-- Aufgabe 1
--
INSERT INTO
  mitarbeiter_projekte
SELECT
  id, (SELECT id FROM projekte WHERE bezeichnung="Schwimmende Tribüne")
FROM
  mitarbeiter m
WHERE
  m.nachname IN ("Groß", "Bier");

/* -- Alternative
INSERT INTO
  mitarbeiter_projekte
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname = "Groß"),(SELECT id FROM projekte WHERE bezeichnung="Schwimmende Tribüne")),
  ((SELECT id FROM mitarbeiter WHERE nachname = "Bier"),(SELECT id FROM projekte WHERE bezeichnung="Schwimmende Tribüne"));
*/


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

-- to solve this excercise we need to reinstall sex (see ex. 20 sheet 1)
-- it's extended with an own entity for sex
CREATE TABLE geschlechter (
  id INTEGER AUTO_INCREMENT,
  bezeichnung VARCHAR(20),

  PRIMARY KEY (id)
);

INSERT INTO
  geschlechter (bezeichnung)
VALUES
  ("Divers"),
  ("Frau"),
  ("Mann"),
  ("Nonbinär"),
  ("Keine Angabe");

-- Variable for having "Divers" default sex 
SET @default_sex = (SELECT id FROM geschlechter WHERE bezeichnung = "Divers");
ALTER TABLE
  mitarbeiter
ADD
  geschlecht_id INTEGER DEFAULT @default_sex;

ALTER TABLE
  mitarbeiter
ADD CONSTRAINT
  mitarbeiter_geschlecht FOREIGN KEY (geschlecht_id) REFERENCES geschlechter(id);


UPDATE
  mitarbeiter
SET
  geschlecht_id = (SELECT id FROM geschlechter WHERE bezeichnung = "Frau")
WHERE
  vorname
IN
  ("Henriette", "Anette", "Lisa", "Sabiene", "Jessica");

UPDATE
  mitarbeiter
SET
  geschlecht_id = (SELECT id FROM geschlechter WHERE bezeichnung = "Mann")
WHERE
  vorname 
IN
  ("Manfred", "Felix", "Peter", "Joachim");

UPDATE
  mitarbeiter
SET
  geschlecht_id = (SELECT id FROM geschlechter WHERE bezeichnung = "Nonbinär")
WHERE
  vorname 
IN
  ("Hendrik");
-- end of reinstall sex

-- begin ex. 3
SELECT
  m.vorname, m.nachname, g.bezeichnung Geschlecht, r.bezeichnung Ressort, m.personalnummer
FROM
  mitarbeiter m
JOIN
  ressorts r ON m.ressort = r.id
JOIN
  geschlechter g ON m.geschlecht_id = g.id
WHERE
  r.bezeichnung = "Stadtgärtnerei" AND
  g.bezeichnung = "Frau";


--
-- Aufgabe 4
--
SELECT
  vorname, nachname
FROM
  mitarbeiter
WHERE
  vorname LIKE "l%";


--
-- Aufgabe 5
--
SELECT
  m.vorname, m.nachname
FROM
  mitarbeiter m
LEFT JOIN
  mitarbeiter_projekte mp ON m.id = mp.id_mitarbeiter
GROUP BY
  m.vorname, m.nachname
HAVING
  COUNT(mp.id_projekt) > 1;


--
-- Aufgabe 6
--
SELECT
  m.vorname, m.nachname, o.ortsname, r.bezeichnung
FROM
  mitarbeiter m
JOIN
  orte o ON m.ort = o.id
JOIN
  rollen r ON m.rolle_id = r.id
WHERE
  r.bezeichnung = "Auszubildende:r";


INSERT INTO
  mitarbeiter_projekte
SELECT
  m.id, (SELECT id FROM projekte p WHERE p.bezeichnung = "Schwimmende Tribüne")
FROM
  mitarbeiter m
WHERE
  m.rolle_id = (SELECT id FROM rollen r WHERE r.bezeichnung = "Auszubildende:r");

/* with JOIN
INSERT INTO
  mitarbeiter_projekte
SELECT
  m.id, (SELECT id FROM projekte p WHERE p.bezeichnung = "Schwimmende Tribüne")
FROM
  mitarbeiter m
JOIN
  rollen r ON m.rolle_id = r.id
WHERE
  r.bezeichnung = "Auszubildende:r";
*/


--
-- Aufgabe 7
--
SELECT
  p.bezeichnung, m.vorname, m.nachname
FROM
  mitarbeiter_projekte mp
JOIN
  mitarbeiter m ON m.id = mp.id_mitarbeiter
JOIN
  projekte p ON p.id = mp.id_projekt
WHERE
  p.abschluss IS NOT NULL;


--
-- Aufgabe 8
--

-- we don't have a rolle "Projektleiter:in" in our system
SELECT
  r.bezeichnung, COUNT(r.bezeichnung) Anzahl
FROM
  mitarbeiter m
JOIN
  rollen r ON m.rolle_id = r.id
GROUP BY
  r.bezeichnung


--
-- Aufgabe 9
--

Done


--
-- Aufgabe 10
--
