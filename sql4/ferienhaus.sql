DROP DATABASE IF EXISTS ferienhaus;

CREATE DATABASE ferienhaus;

USE ferienhaus;

SET @mt = MONTH(CURDATE());
SET @year = YEAR(CURDATE()); -- current year


CREATE TABLE Ferienhaus (
  Ferienhaus_ID INT AUTO_INCREMENT,
  Eigentuemer_ID INT,
  Adresse_ID INT,
  AnzahlSchlafzimmer INT,
  
  PRIMARY KEY (Ferienhaus_ID)
);

CREATE TABLE Eigentuemer (
  Eigentuemer_ID INT AUTO_INCREMENT,
  Adresse_ID INT,
  Name VARCHAR(100),
  
  PRIMARY KEY (Eigentuemer_ID)
);

CREATE TABLE Kunde (
  Kunde_ID INT AUTO_INCREMENT,
  Adresse_ID INT,
  Name VARCHAR(100),
  
  PRIMARY KEY (Kunde_ID)
);

CREATE TABLE Maengelanzeige (
  Maengelanzeige_ID INT AUTO_INCREMENT,
  Ferienhaus_ID INT,
  Meldedatum DATE,
  Beschreibung TEXT,
  
  PRIMARY KEY (Maengelanzeige_ID)
);

CREATE TABLE Mietvertrag (
  Mietvertrag_ID INT AUTO_INCREMENT,
  Ferienhaus_ID INT,
  Kunde_ID INT,
  Beginn DATE,
  Ende DATE,
  Tage INT,
  
  PRIMARY KEY (Mietvertrag_ID)
);

CREATE TABLE Adresse (
  Adresse_ID INT AUTO_INCREMENT,
  Adresse TEXT NOT NULL,
  
  PRIMARY KEY (Adresse_ID)
);





ALTER TABLE
  Ferienhaus
ADD CONSTRAINT
  fh_eigentuemer
FOREIGN KEY
  (Eigentuemer_ID)
REFERENCES
  Eigentuemer(Eigentuemer_ID);
  
ALTER TABLE
  Ferienhaus
ADD CONSTRAINT
  fh_adresse
FOREIGN KEY
  (Adresse_ID)
REFERENCES
  Adresse(Adresse_ID);


ALTER TABLE
  Eigentuemer
ADD CONSTRAINT
  et_adresse
FOREIGN KEY
  (Adresse_ID)
REFERENCES
  Adresse(Adresse_ID);
 

ALTER TABLE
  Kunde
ADD CONSTRAINT
  kd_adresse
FOREIGN KEY
  (Adresse_ID)
REFERENCES
  Adresse(Adresse_ID);
  
ALTER TABLE
  Maengelanzeige
ADD CONSTRAINT
  maz_ferienhaus
FOREIGN KEY
  (Ferienhaus_ID)
REFERENCES
  Ferienhaus(Ferienhaus_ID);  
  
ALTER TABLE
  Mietvertrag
ADD CONSTRAINT
  mv_ferienhaus
FOREIGN KEY
  (Ferienhaus_ID)
REFERENCES
  Ferienhaus(Ferienhaus_ID);
  
ALTER TABLE
  Mietvertrag
ADD CONSTRAINT
  mv_kunde
FOREIGN KEY
  (Kunde_ID)
REFERENCES
  Kunde(Kunde_ID);


-- fill data to DATABASE

INSERT INTO
  adresse (adresse)
VALUES
  ("Zum dunklen Keller 187 - Kurzleben"),
  ("Unter der Treppe unter Harries Zimmer 0 - Doofleben"),
  ("Oberkanteunterlippe 3 - Fakju"),
  ("Fallersleben 1 - Socken"),
  ("Einhornstr. 7 - Kirchentellinsfurt"),
  ("Wernichtwillderhat-Schon 17 - Lulli"),
  ("Zur Einöde 3 - Doof"),
  ("Zur traurigen Hölle 7 - Willnichtleben"),
  ("Drei-IQ-Sind-Zweizuviel - Debil-Doof"),
  ("Fortytwo 56 - Magratea");
  
INSERT INTO
  kunde (Adresse_ID, Name)
VALUES
  (1, "Horst"),
  (1, "Horstiene"),
  (2, "Dumpfbacke"),
  (3, "Voll-Pfosten");
  
INSERT INTO
  eigentuemer (Adresse_ID, Name)
VALUES
  (6, "B. Zambano"),
  (7, "H. Vielgeldund-Keineeier"),
  (5, "R. Reichaberdoof"),
  (5, "M. Hausgarten-Auto");
  
INSERT INTO
  ferienhaus (Eigentuemer_ID, Adresse_ID, AnzahlSchlafzimmer)
VALUES
  (1, 5, 1),
  (1, 3, 2),
  (2, 4, 1),
  (2, 4, 2),
  (2, 4, 3),
  (3, 8, 1),
  (3, 9, 2),
  (3, 6, 1),
  (4, 1, 5),
  (4, 2, 2),
  (4, 7, 1);
  
  
 
SELECT COUNT(*) INTO @ak FROM kunde;


INSERT INTO
  mietvertrag (Ferienhaus_ID, Kunde_ID, Beginn, Ende)
VALUES
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (1, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),

  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-10")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-11")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-03-05")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),
  
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-14"), CONCAT(@year, "-05-25")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (3, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),

  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (4, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),
  
  
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (5, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),

  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-14"), CONCAT(@year, "-05-25")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (6, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),
  
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (7, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),

  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (8, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),
  
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-14"), CONCAT(@year, "-05-25")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (9, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),

  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (10, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31")),
  
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-14"), CONCAT(@year, "-05-25")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (11, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31"));
/*
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-01"), CONCAT(@year, "-01-15")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-01-19"), CONCAT(@year, "-02-13")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-02-27"), CONCAT(@year, "-04-01")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-02"), CONCAT(@year, "-04-12")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-04-14"), CONCAT(@year, "-05-25")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-01"), CONCAT(@year, "-06-17")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-06-21"), CONCAT(@year, "-06-30")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-02"), CONCAT(@year, "-07-23")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-07-25"), CONCAT(@year, "-07-31")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-01"), CONCAT(@year, "-08-15")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-08-22"), CONCAT(@year, "-09-20")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-09-24"), CONCAT(@year, "-09-27")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-03"), CONCAT(@year, "-10-07")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-10-10"), CONCAT(@year, "-10-30")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-01"), CONCAT(@year, "-11-15")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-11-18"), CONCAT(@year, "-12-13")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-15"), CONCAT(@year, "-12-21")),
  (2, FLOOR(RAND()*@ak)+1, CONCAT(@year, "-12-23"), CONCAT(@year, "-12-31"));
*/


SELECT COUNT(*) INTO @af FROM ferienhaus; -- Number of Ferienhäuser

INSERT INTO
  maengelanzeige (Ferienhaus_ID, Meldedatum, Beschreibung)
VALUES
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kotreste im Bett"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bett fehlt"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weißes Pulver auf dem Toilettenkasten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kein Cannabis in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Stuttgarter Hofbräu in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bayern München Trikot in der Vitrine"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weiße Flüssigkeit mit schleimiger Konsistenz auf den Kopfkissen"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Staub unter den Betten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze in Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze unter Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Mikrokatze in der Dusche")
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kotreste im Bett"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bett fehlt"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weißes Pulver auf dem Toilettenkasten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kein Cannabis in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Stuttgarter Hofbräu in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bayern München Trikot in der Vitrine"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weiße Flüssigkeit mit schleimiger Konsistenz auf den Kopfkissen"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Staub unter den Betten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze in Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze unter Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Mikrokatze in der Dusche")
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kotreste im Bett"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bett fehlt"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weißes Pulver auf dem Toilettenkasten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Kein Cannabis in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Stuttgarter Hofbräu in der Minibar"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Bayern München Trikot in der Vitrine"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Weiße Flüssigkeit mit schleimiger Konsistenz auf den Kopfkissen"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Staub unter den Betten"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze in Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Katze unter Mikrowelle"),
  (FLOOR(RAND()*@af)+1, CONCAT(@year, "-", FLOOR(RAND()*@mt)+1, "-", FLOOR(RAND()*28)+1), "Tote Mikrokatze in der Dusche");