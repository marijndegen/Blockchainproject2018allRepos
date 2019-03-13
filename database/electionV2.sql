SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `election`
--
CREATE DATABASE IF NOT EXISTS `election` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `election`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `election`
--

CREATE TABLE `election` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `election`:
--

--
-- Gegevens worden geëxporteerd voor tabel `election`
--

INSERT INTO `election` (`id`, `name`, `startDate`, `endDate`) VALUES
(1, '2e kamer verkiezing', '2018-04-28 00:00:00', '2018-05-30 14:32:34'),
(2, 'Gemeenteraadsverkiezing 19', '2018-04-03 00:00:00', '2019-02-06 15:40:24'),
(3, 'Verkiezingen 2018', '2018-02-25 00:00:00', '2019-01-25 00:00:00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `electionaddress`
--

CREATE TABLE `electionaddress` (
  `ElectionID` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `electionaddress`:
--   `ElectionID`
--       `election` -> `id`
--

--
-- Gegevens worden geëxporteerd voor tabel `electionaddress`
--

INSERT INTO `electionaddress` (`ElectionID`, `Address`) VALUES
(1, '0x5747375bc7141e3841d1dc69b80b31f94c599405'),
(2, '0x7ede2dee4c119b1fc4cf613576eaf644e81f8dd9');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `electionparties`
--

CREATE TABLE `electionparties` (
  `id` int(11) NOT NULL,
  `ElectionID` int(11) NOT NULL,
  `PartyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `electionparties`:
--   `ElectionID`
--       `election` -> `id`
--   `PartyID`
--       `party` -> `id`
--

--
-- Gegevens worden geëxporteerd voor tabel `electionparties`
--

INSERT INTO `electionparties` (`id`, `ElectionID`, `PartyID`) VALUES
(4, 3, 5),
(5, 3, 6);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `electiontoken`
--

CREATE TABLE `electiontoken` (
  `electionID` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `electiontoken`:
--   `electionID`
--       `election` -> `id`
--   `token`
--       `tokenvoter` -> `token`
--

--
-- Gegevens worden geëxporteerd voor tabel `electiontoken`
--

INSERT INTO `electiontoken` (`electionID`, `token`) VALUES
(1, '1010-1010-1010'),
(1, '1111-1111-1111'),
(1, '2222-2222-2222'),
(1, '3333-3333-3333'),
(1, '4444-4444-4444'),
(1, '5555-5555-5555'),
(1, '6666-6666-6666'),
(1, '7777-7777-7777'),
(1, '8888-8888-8888'),
(1, '9999-9999-9999'),
(2, '6969-6969-6969');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `location`
--

CREATE TABLE `location` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `location`:
--

--
-- Gegevens worden geëxporteerd voor tabel `location`
--

INSERT INTO `location` (`name`) VALUES
('Amsterdam'),
('Arnhem'),
('Den Haag'),
('Nijmegen'),
('Rotterdam');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `Party_ID` int(11) NOT NULL,
  `initials` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `member`:
--   `location`
--       `location` -> `name`
--   `Party_ID`
--       `party` -> `id`
--

--
-- Gegevens worden geëxporteerd voor tabel `member`
--

INSERT INTO `member` (`id`, `Party_ID`, `initials`, `firstname`, `lastname`, `gender`, `location`, `position`) VALUES
(4, 4, 'M', 'piet', 'Rutte', 'M', 'Amsterdam', 1),
(5, 4, 'J.A.', 'piet', 'Hennis-Plasschaert', 'V', 'Den Haag', 2),
(6, 4, 'H.', 'piet', 'Zijlstra', 'M', 'Arnhem', 3),
(7, 4, 'T', 'piet', 'Ark', 'V', 'Rotterdam', 4),
(8, 4, 'K.H.D.M.', 'piet', 'Dijkhoff', 'M', 'Arnhem', 5),
(9, 4, 'S', 'piet', 'Dekker', 'M', 'Rotterdam', 6),
(10, 4, 'B', 'piet', 'Visser', 'V', 'Nijmegen', 7),
(11, 4, 'M.G.J.', 'piet', 'Harbers', 'M', 'Arnhem', 8),
(12, 4, 'J.H.', 'piet', 'Broeke', 'M', 'Amsterdam', 9),
(13, 4, 'M', 'piet', 'Azmani', 'M', 'Den Haag', 10),
(14, 5, 'G.', 'piet', 'Wilders', 'M', 'Nijmegen', 1),
(15, 5, 'M.', 'piet', 'Agema', 'V', 'Amsterdam', 2),
(16, 5, 'V.', 'piet', 'Maeijer', 'V', 'Arnhem', 3),
(17, 5, 'G.', 'piet', 'Markuszower', 'M', 'Den Haag', 4),
(18, 5, 'S.R.', 'piet', 'Fritsma', 'M', 'Rotterdam', 5),
(19, 5, 'M.', 'piet', 'Bosma', 'M', 'Amsterdam', 6),
(20, 5, 'B', 'piet', 'Madlener', '', 'Amsterdam', 7),
(21, 5, 'A.P.C.', 'piet', 'Dijck', 'M', 'Amsterdam', 8),
(22, 5, 'L.M.J.S.', 'piet', 'Helder', 'V', 'Nijmegen', 9),
(23, 5, 'H.J.', 'piet', 'Beertema', 'M', 'Rotterdam', 10),
(24, 6, 'S', 'piet', 'Haersma Buma', 'M', 'Amsterdam', 1),
(25, 6, 'M.C.G.', 'piet', 'Keijzer', 'V', 'Den Haag', 2),
(26, 6, 'W.P.H.J.', 'piet', 'Peters', 'M', 'Amsterdam', 3),
(27, 6, 'P.H.', 'piet', 'Omtzigt', 'M', 'Amsterdam', 4),
(28, 6, 'M.M.', 'piet', 'Toorenburg', 'V', 'Amsterdam', 5),
(29, 6, 'R.W.', 'piet', 'Knops', 'M', 'Den Haag', 6),
(30, 6, 'P.E.', 'piet', 'Heerma', 'M', 'Nijmegen', 7),
(31, 6, 'H.', 'piet', 'Molen', 'M', 'Rotterdam', 8),
(32, 6, 'H.G.J.', 'piet', 'Bruins Slot', 'V', 'Den Haag', 9),
(33, 6, 'J.L.', 'piet', 'Geurts', 'M', 'Arnhem', 10),
(34, 7, 'A', 'piet', 'Pechtold', 'M', 'Nijmegen', 1),
(35, 7, 'S', 'piet', 'Veldhoven', 'V', 'Arnhem', 2),
(36, 7, 'W', 'piet', 'Koolmees', 'M', 'Nijmegen', 3),
(37, 7, 'P.A.', 'piet', 'Dijkstra', 'V', 'Den Haag', 4),
(38, 7, 'I.K.', 'piet', 'Engelshoven', 'V', 'Rotterdam', 5),
(39, 7, 'V.A.', 'piet', 'Bergkamp', 'V', 'Nijmegen', 6),
(40, 7, 'K.', 'piet', 'Verhoeven', 'M', 'Amsterdam', 7),
(41, 7, 'P.H.', 'piet', 'Meenen', 'M', 'Nijmegen', 8),
(42, 7, 'J.M.', 'piet', 'Paternotte', 'M', 'Amsterdam', 9),
(43, 7, 'S.P.R.A.', 'piet', 'Weyenberg', 'M', 'Nijmegen', 10),
(44, 8, 'J.F.', 'piet', 'Klaver', 'M', 'Den Haag', 1),
(45, 8, 'K.M.', 'piet', 'Buitenweg', 'V', 'Amsterdam', 2),
(46, 8, 'T.M.T.', 'piet', 'Lee', 'M', 'Rotterdam', 3),
(47, 8, 'L.G.J.', 'piet', 'Voortman', 'V', 'Nijmegen', 4),
(48, 8, 'H.J.', 'piet', 'Grashoff', 'M', 'Rotterdam', 5),
(49, 8, 'L.', 'piet', 'Tongeren', 'V', 'Amsterdam', 6),
(50, 8, 'C.E.', 'piet', 'Ellemeet', 'V', 'Amsterdam', 7),
(51, 8, 'Z.', 'piet', 'Özdil', 'M', 'Amsterdam', 8),
(52, 8, 'B.A.W.', 'piet', 'Snels', 'M', 'Nijmegen', 9),
(53, 8, 'A.', 'piet', 'Ojik', 'M', 'Den Haag', 10);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `party`
--

CREATE TABLE `party` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `party`:
--

--
-- Gegevens worden geëxporteerd voor tabel `party`
--

INSERT INTO `party` (`id`, `name`) VALUES
(6, 'CDA'),
(7, 'Democraten 66'),
(8, 'GROENLINKS'),
(5, 'PVV'),
(4, 'VVD');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `tokenvoter`
--

CREATE TABLE `tokenvoter` (
  `voterID` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `tokenvoter`:
--   `voterID`
--       `voter` -> `id`
--

--
-- Gegevens worden geëxporteerd voor tabel `tokenvoter`
--

INSERT INTO `tokenvoter` (`voterID`, `token`) VALUES
(1, '1010-1010-1010'),
(1, '1111-1111-1111'),
(1, '2222-2222-2222'),
(1, '3333-3333-3333'),
(1, '4444-4444-4444'),
(1, '5555-5555-5555'),
(1, '6666-6666-6666'),
(1, '6969-6969-6969'),
(1, '7777-7777-7777'),
(1, '8888-8888-8888'),
(1, '9999-9999-9999');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `voter`
--

CREATE TABLE `voter` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `birthdate` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `postcode` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIES VOOR TABEL `voter`:
--   `location`
--       `location` -> `name`
--

--
-- Gegevens worden geëxporteerd voor tabel `voter`
--

INSERT INTO `voter` (`id`, `email`, `name`, `birthdate`, `address`, `postcode`, `location`) VALUES
(1, 'test@test.nl', 'Jan', '1995-11-11', 'Heyendaalseweg 98', '6555 BB', 'Nijmegen');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `election`
--
ALTER TABLE `election`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `electionaddress`
--
ALTER TABLE `electionaddress`
  ADD PRIMARY KEY (`ElectionID`);

--
-- Indexen voor tabel `electionparties`
--
ALTER TABLE `electionparties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_election_id` (`ElectionID`),
  ADD KEY `fk_party_id` (`PartyID`);

--
-- Indexen voor tabel `electiontoken`
--
ALTER TABLE `electiontoken`
  ADD PRIMARY KEY (`electionID`,`token`),
  ADD KEY `FK_Token_idx` (`token`);

--
-- Indexen voor tabel `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`name`);

--
-- Indexen voor tabel `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Woonplaats_Plaats_idx` (`location`),
  ADD KEY `FK_Partij_Partij_ID_idx` (`Party_ID`);

--
-- Indexen voor tabel `party`
--
ALTER TABLE `party`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `naam_UNIQUE` (`name`);

--
-- Indexen voor tabel `tokenvoter`
--
ALTER TABLE `tokenvoter`
  ADD PRIMARY KEY (`voterID`,`token`),
  ADD UNIQUE KEY `token_UNIQUE` (`token`);

--
-- Indexen voor tabel `voter`
--
ALTER TABLE `voter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Stemmer_Plaats_idx` (`location`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `election`
--
ALTER TABLE `election`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT voor een tabel `electionparties`
--
ALTER TABLE `electionparties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT voor een tabel `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT voor een tabel `party`
--
ALTER TABLE `party`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT voor een tabel `voter`
--
ALTER TABLE `voter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `electionaddress`
--
ALTER TABLE `electionaddress`
  ADD CONSTRAINT `FK_ElectionID_2` FOREIGN KEY (`ElectionID`) REFERENCES `election` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `electionparties`
--
ALTER TABLE `electionparties`
  ADD CONSTRAINT `fk_election_id` FOREIGN KEY (`ElectionID`) REFERENCES `election` (`id`),
  ADD CONSTRAINT `fk_party_id` FOREIGN KEY (`PartyID`) REFERENCES `party` (`id`);

--
-- Beperkingen voor tabel `electiontoken`
--
ALTER TABLE `electiontoken`
  ADD CONSTRAINT `FK_ElectionID` FOREIGN KEY (`electionID`) REFERENCES `election` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Token` FOREIGN KEY (`token`) REFERENCES `tokenvoter` (`token`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `FK_Location` FOREIGN KEY (`location`) REFERENCES `location` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PartyID` FOREIGN KEY (`Party_ID`) REFERENCES `party` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `tokenvoter`
--
ALTER TABLE `tokenvoter`
  ADD CONSTRAINT `FK_Voter` FOREIGN KEY (`voterID`) REFERENCES `voter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `voter`
--
ALTER TABLE `voter`
  ADD CONSTRAINT `FK_Location2` FOREIGN KEY (`location`) REFERENCES `location` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
