-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 29. Jun 2021 um 00:18
-- Server-Version: 10.4.19-MariaDB
-- PHP-Version: 8.0.6



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `projektverwaltung`
--

DROP DATABASE IF EXISTS projektverwaltung;

CREATE DATABASE projektverwaltung;

USE projektverwaltung;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mitarbeiter`
--

CREATE TABLE `mitarbeiter` (
  `id` int(11) NOT NULL,
  `personalnummer` varchar(10) DEFAULT NULL,
  `nachname` varchar(100) NOT NULL,
  `vorname` varchar(100) DEFAULT NULL,
  `strasse` varchar(100) DEFAULT NULL,
  `hausnummer` varchar(10) DEFAULT NULL,
  `ort` int(11) DEFAULT NULL,
  `ressort` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mitarbeiter_projekte`
--

CREATE TABLE `mitarbeiter_projekte` (
  `id_mitarbeiter` int(11) DEFAULT NULL,
  `id_projekt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orte`
--

CREATE TABLE `orte` (
  `id` int(11) NOT NULL,
  `plz` varchar(15) DEFAULT NULL,
  `ortsname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projekte`
--

CREATE TABLE `projekte` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(50) DEFAULT NULL,
  `beginn` date DEFAULT NULL,
  `abschluss` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ressorts`
--

CREATE TABLE `ressorts` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `mitarbeiter`
--
ALTER TABLE `mitarbeiter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personalnummer` (`personalnummer`),
  ADD KEY `const_mitarbeiter_ressort` (`ressort`),
  ADD KEY `const_mitarbeiter_ort` (`ort`);

--
-- Indizes für die Tabelle `mitarbeiter_projekte`
--
ALTER TABLE `mitarbeiter_projekte`
  ADD KEY `const_mitarbeiter_maprojekte` (`id_mitarbeiter`),
  ADD KEY `const_projekt_maprojekte` (`id_projekt`);

--
-- Indizes für die Tabelle `orte`
--
ALTER TABLE `orte`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `projekte`
--
ALTER TABLE `projekte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bezeichnung` (`bezeichnung`);

--
-- Indizes für die Tabelle `ressorts`
--
ALTER TABLE `ressorts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bezeichnung` (`bezeichnung`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `mitarbeiter`
--
ALTER TABLE `mitarbeiter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `orte`
--
ALTER TABLE `orte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `projekte`
--
ALTER TABLE `projekte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ressorts`
--
ALTER TABLE `ressorts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `mitarbeiter`
--
ALTER TABLE `mitarbeiter`
  ADD CONSTRAINT `const_mitarbeiter_ort` FOREIGN KEY (`ort`) REFERENCES `orte` (`id`),
  ADD CONSTRAINT `const_mitarbeiter_ressort` FOREIGN KEY (`ressort`) REFERENCES `ressorts` (`id`);

--
-- Constraints der Tabelle `mitarbeiter_projekte`
--
ALTER TABLE `mitarbeiter_projekte`
  ADD CONSTRAINT `const_mitarbeiter_maprojekte` FOREIGN KEY (`id_mitarbeiter`) REFERENCES `mitarbeiter` (`id`),
  ADD CONSTRAINT `const_projekt_maprojekte` FOREIGN KEY (`id_projekt`) REFERENCES `projekte` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
