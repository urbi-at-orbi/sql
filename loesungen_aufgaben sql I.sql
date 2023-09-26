-- Solutions for "Aufgaben SQL I"
-- by urbi@orbi.baby as PD

--
-- Aufgabe 1
--
INSERT INTO
  projekte (bezeichnung, beginn, abschluss)
VALUES
  ("Aus Grau wird Bunt", "2023-08-01", "2024-01-31");


INSERT INTO
  ressorts (bezeichnung)
VALUES
  ("Stadtgärtnerei");


INSERT INTO
  orte (plz, ortsname)
VALUES
  ("56271", "Kleinmaischeid"),
  ("45739", "Oer-Erkenschwick"),
  ("06131", "Zornheim");


INSERT INTO
  mitarbeiter(nachname, vorname, strasse, hausnummer, ort, ressort)
VALUES
  ("Groß", "Henriette", "Düsterwald Str.", "3", (SELECT id FROM orte WHERE plz = "56271"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Holstein", "Manfred", "Engelbertstr.", "23", (SELECT id FROM orte WHERE plz = "45739"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Ganz", "Anette", "Engelbertstr.", "25", (SELECT id FROM orte WHERE plz = "45739"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Brown", "Sharon", "Engelbertstr.", "26", (SELECT id FROM orte WHERE plz = "45739"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Neuneier", "Felix", "Professor-Kneib-Str.", "349", (SELECT id FROM orte WHERE plz = "06131"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Neuneier", "Sabiene", "Professor-Kneib-Str.", "349", (SELECT id FROM orte WHERE plz = "06131"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei")),
  ("Neuneier", "Sarah", "Professor-Kneib-Str.", "349", (SELECT id FROM orte WHERE plz = "06131"), (SELECT id FROM ressorts WHERE bezeichnung = "Stadtgärtnerei"));


INSERT INTO
  mitarbeiter_projekte
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname="Groß" AND vorname="Henriette") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt")),
  ((SELECT id FROM mitarbeiter WHERE nachname="Holstein" AND vorname="Manfred") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt")),
  ((SELECT id FROM mitarbeiter WHERE nachname="Ganz" AND vorname="Anette") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt")),
  ((SELECT id FROM mitarbeiter WHERE nachname="Brown" AND vorname="Sharon") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt")),
  ((SELECT id FROM mitarbeiter WHERE nachname="Neuneier" AND vorname="Felix") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt"));


--
-- Aufgabe 2
--
UPDATE
  mitarbeiter
SET
  personalnummer = "2701007"
WHERE
  nachname = "Groß" AND
  vorname = "Henriette";

UPDATE
  mitarbeiter
SET
  personalnummer = "2802123"
WHERE
  nachname = "Holstein" AND
  vorname = "Manfred";

UPDATE
  mitarbeiter
SET
  personalnummer = "2903258"
WHERE
  nachname = "Ganz" AND
  vorname = "Anette";

UPDATE
  mitarbeiter
SET
  personalnummer = "3004951"
WHERE
  nachname = "Brown" AND
  vorname = "Sharon";

UPDATE
  mitarbeiter
SET
  personalnummer = "3105351"
WHERE
  nachname = "Neuneier" AND
  vorname = "Felix";
  
  
--
-- Aufgabe 3
--
UPDATE
  orte
SET
  plz = 55270
WHERE
  ortsname = "Zornheim";


DELETE FROM
  mitarbeiter
WHERE
  nachname = "Neuneier" AND
  vorname = "Sarah";


--
-- Aufgabe 4
--
INSERT INTO
  ressorts (bezeichnung)
VALUES
  ("Stadtkasse");


INSERT INTO
  orte (plz, ortsname)
VALUES
  ("56203", "Höhr-Grenzhausen");


INSERT INTO
  mitarbeiter (personalnummer, nachname, vorname, strasse, hausnummer, ort, ressort)
VALUES
  ("3206369", "Neumann", "Lisa", "Gartenstr.", "20",
	(SELECT id FROM orte WHERE plz = "56203") , (SELECT id FROM ressorts WHERE bezeichnung = "Stadtkasse"));


INSERT INTO
  mitarbeiter_projekte
VALUES
  ((SELECT id FROM mitarbeiter WHERE personalnummer = "3206369") , (SELECT id FROM projekte WHERE bezeichnung = "Aus Grau wird Bunt"));


--
-- Aufgabe 5
--
UPDATE
  mitarbeiter
SET
  ort = (SELECT ort FROM mitarbeiter WHERE nachname = "Holstein"),
  strasse = (SELECT strasse FROM mitarbeiter WHERE nachname = "Holstein"),
  hausnummer = (SELECT hausnummer FROM mitarbeiter WHERE nachname = "Holstein")
WHERE
  nachname = "Groß";


--
-- Aufgabe 6
--
ALTER TABLE
  mitarbeiter
ADD
  geburtsdatum DATE;


-- Geburtstage eintragen
UPDATE
  mitarbeiter
SET
  geburtsdatum = "1975-02-25"
WHERE
  nachname = "Groß" AND
  vorname = "Henriette";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "1966-07-02"
WHERE
  nachname = "Holstein" AND
  vorname = "Manfred";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "1999-11-13"
WHERE
  nachname = "Ganz" AND
  vorname = "Anette";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "1998-10-14"
WHERE
  nachname = "Brown" AND
  vorname = "Sharon";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "1959-04-22"
WHERE
  nachname = "Neuneier" AND
  vorname = "Felix";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "2001-06-08"
WHERE
  nachname = "Neumann" AND
  vorname = "Lisa";

UPDATE
  mitarbeiter
SET
  geburtsdatum = "1997-08-11"
WHERE
  nachname = "Neuneier" AND
  vorname = "Sabiene";


--
-- Aufgabe 7
--
INSERT INTO
  projekte (bezeichnung, beginn, abschluss)
VALUES
  ("Money Money Money", "2020-07-06", "2022-10-28");


--
-- Aufgabe 8
--
SELECT
  m.nachname, m.vorname, p.bezeichnung, m.personalnummer
FROM
  mitarbeiter m
JOIN
  mitarbeiter_projekte mp ON m.id = mp.id_mitarbeiter
JOIN
  projekte p ON p.id = mp.id_projekt
WHERE
  p.bezeichnung = "Aus Grau wird Bunt"
ORDER BY
  m.personalnummer DESC;

/* combined JOIN	
SELECT
  m.nachname, m.vorname, p.bezeichnung, m.personalnummer
FROM
  mitarbeiter m, projekte p, mitarbeiter_projekte mp
WHERE
  p.id = mp.id_projekt AND
  m.id = mp.id_mitarbeiter AND
  p.bezeichnung = "Aus Grau wird Bunt"
ORDER BY
  m.personalnummer DESC;
*/


--
-- Aufgabe 9
--
SELECT
  vorname, nachname, geburtsdatum
FROM
  mitarbeiter 
ORDER BY
  geburtsdatum DESC;


-- nur das Küken
SELECT
  CONCAT(vorname, " ", nachname, ", geboren am ", geburtsdatum) AS 'Das Küken ist'
FROM
  mitarbeiter 
ORDER BY
  geburtsdatum DESC
LIMIT
  1;


--
-- Aufgabe 10
--
INSERT INTO
  projekte(bezeichnung)
VALUES
  ("Grün, Grüner, unsere Stadt"),
  ("Wein-Herbst"),
  ("Schwimmende Tribüne");


--
-- Aufgabe 11
--
UPDATE
  mitarbeiter
SET
  nachname = "Holstein-Groß"
WHERE
  nachname = "Holstein";


--
-- Aufgabe 12
--
UPDATE
  mitarbeiter_projekte
SET
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Schwimmende Tribüne")
WHERE
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Aus Grau wird Bunt") AND
  id_mitarbeiter = (SELECT id FROM mitarbeiter m WHERE m.nachname = "Holstein-Groß");


UPDATE
  projekte
SET
  beginn = "2022-08-11"
WHERE
  bezeichnung = "Schwimmende Tribüne";


--
-- Aufgabe 13
--
UPDATE
  projekte
SET
  abschluss = DATE_ADD(abschluss, INTERVAL 3 MONTH)
WHERE
  bezeichnung = "Aus Grau wird Bunt";


--
-- Aufgabe 14
--
SELECT
  nachname, vorname
FROM
  mitarbeiter
WHERE
  CONCAT(vorname, nachname) LIKE '%o%'
ORDER BY
  nachname;


--
-- Aufgabe 15
--
UPDATE
  projekte
SET
  beginn = "2022-07-01"
WHERE
  bezeichnung = "Grün, Grüner, unsere Stadt";

UPDATE
  projekte
SET
  beginn = "2021-09-12"
WHERE
  bezeichnung = "Wein-Herbst";


--
-- Aufgabe 16
--
INSERT INTO
  ressorts (bezeichnung)
VALUES
  ("Bauamt");


INSERT INTO
  orte (plz, ortsname)
VALUES
  ("22946", "Trittau"),
  ("56235", "Ransbach-Baumbach"),
  ("56154", "Boppard");


INSERT INTO
  mitarbeiter (personalnummer, nachname, vorname, strasse, hausnummer, ort, ressort, geburtsdatum)
VALUES
  ("3206555","Mallmann", "Peter", "Hinter den Höfen", "11", (SELECT id FROM orte WHERE plz = "22946"), (SELECT id FROM ressorts WHERE bezeichnung = "Bauamt"), "1980-02-29"),
  ("3307951", "Wieselbaum", "Joachim", "Lahnstr.", "24", (SELECT id FROM orte WHERE plz = "56235"), (SELECT id FROM ressorts WHERE bezeichnung = "Bauamt"), "1982-05-05"),
  ("3408069", "Bier", "Justin", "Mainzer Str.", "34", (SELECT id FROM orte WHERE plz = "56154"), (SELECT id FROM ressorts WHERE bezeichnung = "Bauamt"), "2002-09-13");


--
-- Aufgabe 17
--
SELECT
  nachname, vorname, geburtsdatum
FROM
  mitarbeiter
WHERE
  MONTH(geburtsdatum) = Month(NOW())
--MONTH(geburtsdatum) = Month(CURDATE())
ORDER BY
  nachname DESC;


--
-- Aufgabe 18
--
INSERT INTO
  mitarbeiter_projekte
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname = "Neumann"), (SELECT id FROM projekte WHERE bezeichnung = "Money Money Money"));


--
-- Aufgabe 19
--
SELECT
  vorname, nachname
FROM
  mitarbeiter
WHERE
  vorname LIKE "s%";


--
-- Aufgabe 20
--
ALTER TABLE
  mitarbeiter
ADD
  geschlecht ENUM('Divers', 'Frau', 'Mann') DEFAULT 'Divers';


UPDATE
  mitarbeiter
SET
  geschlecht = "Frau"
WHERE
  vorname
IN
  ("Henriette", "Anette", "Lisa", "Sabiene");

UPDATE
  mitarbeiter
SET
  geschlecht = "Mann"
WHERE
  vorname 
IN
  ("Manfred", "Felix", "Peter", "Joachim");


--	
-- Aufgabe 21
--
DELETE FROM
  projekte
WHERE
  bezeichnung="Wein-Herbst";


--
-- Aufgabe 22
--
SELECT
  *
FROM
  mitarbeiter
WHERE
  geschlecht = "Mann"
ORDER BY
  personalnummer;


--
-- Aufgabe 23
--
SELECT
  m.nachname, m.vorname, m.strasse, m.hausnummer, o.plz, o.ortsname
FROM
  mitarbeiter m
JOIN
  orte o ON m.ort = o.id
WHERE
  m.ressort = (SELECT id FROM ressorts r WHERE r.bezeichnung = "Bauamt")
ORDER BY
  o.plz;


/* combined JOIN
SELECT
  m.nachname, m.vorname, m.strasse, m.hausnummer, o.plz, o.ortsname
FROM
  mitarbeiter m, orte o
WHERE
  m.ressort = (SELECT id FROM ressorts r WHERE r.bezeichnung = "Bauamt") AND
  m.ort = o.id
ORDER BY
  o.plz;
*/


--
-- Aufgabe 24
--

-- Just deleting the entries...
UPDATE
  mitarbeiter
SET
  geschlecht = null;

-- ... or delete the whole column
ALTER TABLE
  mitarbeiter
DROP COLUMN
  geschlecht;


--
-- Aufgabe 25
--
CREATE TABLE rollen (
  id INTEGER AUTO_INCREMENT,
  bezeichnung VARCHAR(40) NOT NULL,

  PRIMARY KEY (id)
);


ALTER TABLE
  projekte
ADD COLUMN
  projektleitung INTEGER; -- id der Projektleitung

ALTER TABLE
  projekte
ADD CONSTRAINT
  projektleitung_mitarbeiter
FOREIGN KEY
  (projektleitung) REFERENCES mitarbeiter(id);


INSERT INTO
  rollen (bezeichnung)
VALUES
  ("Mitarbeiter:in"),
  ("Auszubildende:r");


-- Variable to buffer the id for "Mitarbeiter:in"
SET @default_rolle = (SELECT id FROM rollen WHERE bezeichnung = "Mitarbeiter:in");

ALTER TABLE
  mitarbeiter
ADD COLUMN
  (rolle_id INTEGER DEFAULT @default_rolle);

ALTER TABLE
  mitarbeiter
ADD CONSTRAINT
  rolle
FOREIGN KEY
	(rolle_id) REFERENCES rollen(id);


UPDATE
  projekte
SET
  projektleitung = (SELECT id FROM mitarbeiter m WHERE m.personalnummer = "2701007")
WHERE
  bezeichnung = "Aus Grau wird Bunt";


UPDATE
  mitarbeiter
SET
  rolle_id = (SELECT id FROM rollen WHERE bezeichnung = "Auszubildende:r")
WHERE
  vorname IN ("Sabiene", "Lisa");


--
-- Aufgabe 26
--
UPDATE
  projekte
SET
  abschluss = DATE_ADD(abschluss, INTERVAL 1 MONTH);
-- null automatically not in set


--
-- Aufgabe 27
--
INSERT INTO
  ressorts (bezeichnung)
VALUES
  ("Ordnungsamt");


INSERT INTO
  orte (plz, ortsname)
VALUES
  ("56204", "Hillscheid"),
  ("56203", "Grenzau");


INSERT INTO
  mitarbeiter (personalnummer, nachname, vorname, strasse, hausnummer, ort, ressort, geburtsdatum)
VALUES
  ("3509159", "Walder", "Jessica", "Schneebergstr.", "36", (SELECT id FROM orte WHERE plz = "56204"), (SELECT id FROM ressorts WHERE bezeichnung = "Ordnungsamt"), "1986-10-12"),
  ("3510582", "Hegenbergh", "Hendrik", "Hollersborn", "35", (SELECT id FROM orte WHERE ortsname="Grenzau"), (SELECT id FROM ressorts WHERE bezeichnung = "Ordnungsamt"), "1979-01-01");


CREATE TABLE verstoesse (
  id INTEGER AUTO_INCREMENT,
  taeterIn_id INTEGER NOT NULL,
  grund TEXT NOT NULL,
  tatdatum DATE NOT NULL,
  tatzeit TIME NOT NULL,
  erstellt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
  editiert_am DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id)
);

-- the 31'er
CREATE TABLE verraeterIn_verstoss (
  mitarbeiter_id INTEGER NOT NULL, -- traiting dorks
  verstoss_id INTEGER NOT NULL
);

ALTER TABLE
  verstoesse
ADD CONSTRAINT
  taeterIn FOREIGN KEY (taeterIn_id) REFERENCES mitarbeiter(id);

ALTER TABLE
  verraeterIn_verstoss
ADD CONSTRAINT
  verraeterIn FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(id);

ALTER TABLE
  verraeterIn_verstoss
ADD CONSTRAINT
  verstoss FOREIGN KEY (verstoss_id) REFERENCES verstoesse(id);


INSERT INTO
  verstoesse (taeterIn_id, grund, tatdatum, tatzeit)
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname = "Neuneier" AND vorname = "Sabiene"), "Hat eisern auf ihre Pause bestanden!", "2020-04-01", "19:42:56");
  -- I can't reference to sex because we killed sex


INSERT INTO
  verraeterIn_verstoss
VALUES
  ((SELECT id FROM mitarbeiter WHERE personalnummer = "3509159"), (SELECT v.id FROM verstoesse v, mitarbeiter m WHERE v.taeterIn_id = m.id AND vorname = "Sabiene" ORDER BY tatdatum DESC, tatzeit DESC LIMIT 1)),
  ((SELECT id FROM mitarbeiter WHERE personalnummer = "3510582"), (SELECT v.id FROM verstoesse v, mitarbeiter m WHERE v.taeterIn_id = m.id AND vorname = "Sabiene" ORDER BY tatdatum DESC, tatzeit DESC LIMIT 1));


-- debugging purposes
INSERT INTO
  verstoesse (taeterIn_id, grund, tatdatum, tatzeit)
VALUES
  ((SELECT id FROM mitarbeiter WHERE nachname = "Neuneier" AND vorname = "Sabiene"), "Hat pünktlich Feierabend gemacht!", "2020-04-03", "19:56:42");
-- end debugging purposes


--
-- Aufgabe 28
--
SELECT
  m.vorname, m.nachname, o.ortsname
FROM
  mitarbeiter m
JOIN
  orte o ON m.ort = o.id
WHERE NOT
  o.ortsname = "Oer-Erkenschwick";

-- alternative
SELECT
  m.vorname, m.nachname, o.ortsname
FROM
  mitarbeiter m
JOIN
  orte o ON m.ort = o.id
WHERE
  o.ortsname NOT IN ("Oer-Erkenschwick");

-- alternative
SELECT
  m.vorname, m.nachname, o.ortsname
FROM
  mitarbeiter m
JOIN
  orte o ON m.ort = o.id
WHERE
  o.ortsname != ("Oer-Erkenschwick");


/* combined JOIN
SELECT
  m.vorname, m.nachname, o.ortsname
FROM
  mitarbeiter m, orte o 
WHERE
  m.ort = o.id AND
  o.ortsname NOT IN ("Oer-Erkenschwick");
*/


--
-- Aufgabe 29
--
SELECT
  m.vorname, m.nachname, p.bezeichnung
FROM
  mitarbeiter m
JOIN
  mitarbeiter_projekte mp ON m.id = mp.id_mitarbeiter
JOIN
  projekte p ON p.id = mp.id_projekt
WHERE
  p.bezeichnung = "Aus Grau wird Bunt";

/* combined JOIN
SELECT
  m.vorname, m.nachname, p.bezeichnung
FROM
  mitarbeiter m, projekte p, mitarbeiter_projekte mp
WHERE
  m.id = mp.id_mitarbeiter AND
  p.id = mp.id_projekt AND
  p.bezeichnung = "Aus Grau wird Bunt";
*/


--
-- Aufgabe 30
--
INSERT INTO
  mitarbeiter_projekte (id_mitarbeiter, id_projekt)
SELECT
  id_mitarbeiter, (SELECT id FROM projekte p WHERE p.bezeichnung = "Grün, Grüner, unsere Stadt")
FROM
  mitarbeiter_projekte
WHERE
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Aus Grau wird Bunt") AND
  id_mitarbeiter != (SELECT id FROM mitarbeiter m WHERE m.nachname = "Neumann");


/*
-- change the projekt id without "history"
UPDATE
  mitarbeiter_projekte mp
SET
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Grün, Grüner, unsere Stadt")
WHERE
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Aus Grau wird Bunt") AND
  mp.id_mitarbeiter != (SELECT id FROM mitarbeiter m WHERE m.nachname = "Neumann");


-- it's not clear which state Mrs. Neumann gets. Maybe she's the last contact?
-- if not, delete the entry ->

DELETE FROM
  mitarbeiter_projekte
WHERE
  id_mitarbeiter = (SELECT id FROM mitarbeiter m WHERE m.nachname = "Neumann") AND
  id_projekt = (SELECT id FROM projekte p WHERE p.bezeichnung = "Aus Grau wird Bunt");
*/


--
-- FINISHED
--