SET foreign_key_checks = 0;

DROP DATABASE IF EXISTS `iskola`;

CREATE DATABASE `iskola`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_hungarian_ci;

USE `iskola`;


DROP TABLE IF EXISTS `tanarok`;
CREATE TABLE `tanarok` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `vezeteknev` VARCHAR(50) NOT NULL,
  `keresztnev` VARCHAR(50) NOT NULL,
  `szuletett` DATE NOT NULL,
  `kor` INT NOT NULL,
  `nem` BOOLEAN NOT NULL,
  `szak` VARCHAR(20) DEFAULT NULL,
  `hobbi` VARCHAR(100) NULL,
  `tanora` INT NOT NULL,
  `szakkor` INT DEFAULT 0
);

DROP TABLE IF EXISTS `osztalyok`;
CREATE TABLE `osztalyok` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nev` VARCHAR(10) NOT NULL,
  `terem` VARCHAR(20),
  `osztalyfonok` VARCHAR(100)
);



DROP TABLE IF EXISTS `diakok`;
CREATE TABLE `diakok` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `vezeteknev` VARCHAR(50) NOT NULL,
  `keresztnev` VARCHAR(50) NOT NULL,
  `nem` BOOLEAN NOT NULL,
  `szuletett` DATE NOT NULL,
  `kor` INT NOT NULL,
  `email` VARCHAR(120) DEFAULT NULL UNIQUE,
  `magassag_cm` INT NOT NULL,
  `atlag` FLOAT NOT NULL,
  `irsz` INT NOT NULL,
  `lakcim` VARCHAR(100) NOT NULL,

  `osztaly_id` INT NOT NULL,
  FOREIGN KEY (`osztaly_id`) REFERENCES `osztalyok`(`id`)
);

DROP TABLE IF EXISTS `tantargyak`;
CREATE TABLE `tantargyak` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nev` VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS `diak_tantargy`;
CREATE TABLE `diak_tantargy` (
  `diak_id` INT NOT NULL,
  `tantargy_id` INT NOT NULL,
  PRIMARY KEY (`diak_id`, `tantargy_id`),
  FOREIGN KEY (`diak_id`) REFERENCES `diakok`(`id`),
  FOREIGN KEY (`tantargy_id`) REFERENCES `tantargyak`(`id`)
);

DROP TABLE IF EXISTS `jegyek`;
CREATE TABLE `jegyek` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `diak_id` INT NOT NULL,
  `tanar_id` INT NOT NULL,
  `tantargy_id` INT NOT NULL,
  `ertek` INT NOT NULL,
  `suly` FLOAT NOT NULL,
  `rogzitve` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`diak_id`) REFERENCES `diakok`(`id`),
  FOREIGN KEY (`tanar_id`) REFERENCES `tanarok`(`id`),
  FOREIGN KEY (`tantargy_id`) REFERENCES `tantargyak`(`id`)
);

INSERT INTO `tanarok` (`vezeteknev`, `keresztnev`, `szuletett`, `kor`, `nem`, `szak`, `hobbi`, `tanora`, `szakkor`)
VALUES
('Nagy',     'Péter',   '1982-04-12', 43, 1, 'Matematika/Fizika', 'futás', 24, 1),
('Kovács',   'Anna',    '1986-11-03', 40, 0, 'Angol/Biológia', 'fotózás', 22, 2),
('Tóth',     'Gábor',   '1996-02-20', 30, 1, 'Testnevelés/Biológia',NULL, 12,0),
('Szabó',    'Eszter',  '1988-07-01', 37, 0, 'Digitális kultúra','kertészkedés', 14,2),
('Tóth',    'Miklós',  '1979-09-18', 46, 1, NULL, NULL, 22,2),
('Nagy',  'Anna',   '1992-12-05', 33, 0, 'Etika/Hittan','fotózás', 12,0),
('Karácsony',  'Mária',   '1980-12-05', 45, 0, 'Matematika/Kémia', 'TEREPFUTÁS',20,1);

INSERT INTO `osztalyok` (`nev`, `terem`, `osztalyfonok`) VALUES
('9.A',  '101. terem', 'Kovácsné Erzsébet'),
('9.B',  '102. terem', 'Varga László'),
('9.C',  '103. terem', 'Nagy Gábor'),
('10.A', '201. terem', 'Szabó István'),
('10.B', '202. terem', 'Tóth Erika'),
('10.C', '203. terem', 'Papp Ferenc'),
('11.A', '301. terem', 'Molnár Judit'),
('11.B', '302. terem', 'Bíró Attila'),
('12.A', '401. terem', 'Farkas Pál'),
('12.B', '402. terem', 'Simon Klára');


INSERT INTO `diakok` (`vezeteknev`, `keresztnev`, `nem`, `osztaly_id`, `szuletett`, `kor`, `email`, `magassag_cm`, `atlag`, `irsz`, `lakcim`) VALUES
('Kiss',     'Anna',    0, 1,  '2010-06-15', 15, 'kiss.anna@gmail.com', 162, 4.2, 1031, 'Budapest, Vízi utca 5.'),
('Szabó',    'Bence',   1, 1,  '2010-01-08', 16, 'szabo.bence@freemail.hu', 170, 3.8, 4024, 'Debrecen, Piac utca 12.'),
('Varga',    'Dóra',    0, 5,  '2009-09-30', 16, 'varga.dora@icloud.com', 158, 4.9, 6720, 'Szeged, Tisza Lajos krt. 3.'),
('Tóth',     'Máté',    1, 5,  '2009-03-21', 16, 'toth.mate@gmail.hu', 175, 3.2, 3525, 'Miskolc, Városház tér 1.'),
('Nagy',     'Lili',    0, 2,  '2010-11-02', 15, NULL, 160, 4.5, 7621, 'Pécs, Király utca 8.'),
('Kovács',   'Levente', 1, 2,  '2010-05-27', 15, 'kovacs.levente@gmail.com', 168, 3.4, 9022, 'Győr, Baross út 15.'),
('Horváth',  'Réka',    0, 7,  '2008-12-12', 17, 'horvath.reka@yahoo.com', 164, 4.1, 8000, 'Székesfehérvár, Fő utca 2.'),
('Balogh',   'Ádám',    1, 7,  '2008-08-09', 17, 'balogh.adam@freemail.hu', 178, 2.7, 4400, 'Nyíregyháza, Kossuth tér 5.'),
('Balogh',   'Ádám',    1, 7,  '2008-03-15', 17, 'balogha@gmail.hu', 182, 4.8, 1192, 'Budapest, Pannónia út 6.'),
('Farkas',   'Zsófi',   0, 4,  '2009-01-14', 17, 'farkas.zsofi@gmail.com', 161, 4.8, 6000, 'Kecskemét, Rákóczi út 10.'),
('Papp',     'Noel',    1, 4,  '2009-07-05', 16, 'papp.noel@outlook.com', 172, 3.9, 5000, 'Szolnok, Kossuth út 3.'),
('Lakatos',  'Kinga',   0, 3,  '2010-02-25', 15, 'lakatos.kinga@gmail.hu', 159, 4.3, 2030, 'Érd, Budai út 45.'),
('Horváth',  'Gergő',   1, 3,  '2010-09-18', 15, 'molnar.gergo@freemail.hu', 166, 3.1, 2800, 'Tatabánya, Fő tér 12.'),
('Nagy',     'Emese',   0, 8,  '2008-04-28', 17, 'szalai.emese@gmail.com', 165, 4.6, 9700, 'Szombathely, Rohonci út 4.'),
('Kelemen',  'Dániel',  1, 8,  '2008-10-03', 17, NULL, 180, 3.6, 8200, 'Veszprém, Egyetem utca 10.'),
('Oláh',     'Petra',   0, 9,  '2007-06-01', 18, 'olah.petra@gmail.com', 167, 4.9, 7400, 'Kaposvár, Ady Endre utca 7.'),
('Mészáros', 'Bálint',  1, 9,  '2007-02-17', 19, 'meszaros.balint@yahoo.com', 182, 3.4, 4032, 'Debrecen, Egyetem tér 1.'),
('Bíró',     'Vivien',  0, 10, '2007-09-09', 18, 'biro.vivien@icloud.com', 163, 4.2, 1117, 'Budapest, Október 23. utca 8.'),
('Takács',   'Tamás',   1, 10, '2007-12-20', 18, 'takacs.tamas@gmail.hu', 176, 2.8, 6724, 'Szeged, Londoni krt. 12.'),
('Nagy',     'Nóra',    0, 6,  '2009-11-11', 16, 'sipos.nora@freemail.hu', 160, 4.7, 3530, 'Miskolc, Szemere utca 4.'),
('Simon',    'Zalán',   1, 6,  '2009-05-16', 16, 'simon.zalan@gmail.com', 174, 3.5, 1042, 'Budapest, Árpád út 20.');


INSERT INTO `tantargyak` (`nev`) VALUES
('Matematika'),
('Magyar nyelv és irodalom'),
('Történelem'),
('Fizika'),
('Informatika'),
('Angol nyelv');


INSERT INTO `diak_tantargy` (`diak_id`, `tantargy_id`)
SELECT `id`, 1 FROM `diakok`;
INSERT INTO `diak_tantargy` (`diak_id`, `tantargy_id`)
SELECT `id`, 2 FROM `diakok`;

-- Csak a 10. osztályosok felett (id > 6) tanulnak Fizikát (4)
INSERT INTO `diak_tantargy` (`diak_id`, `tantargy_id`)
SELECT `id`, 4 FROM `diakok` WHERE `id` > 6;

-- Mindenki tanul Angolt (6)
INSERT INTO `diak_tantargy` (`diak_id`, `tantargy_id`)
SELECT `id`, 6 FROM `diakok`;

-- INSERT INTO `jegyek` (`diak_id`, `tanar_id`, `tantargy_id`, `ertek`, `suly`, `rogzitve`)
-- SELECT 
--     d.`id` AS `diak_id`,
--     (SELECT `id` FROM `tanarok` ORDER BY RAND() LIMIT 1) AS `tanar_id`,
--     (SELECT `tantargy_id` FROM `diak_tantargy` WHERE `diak_id` = d.`id` ORDER BY RAND() LIMIT 1) AS `tantargy_id`,
--     FLOOR(1 + (RAND() * 5)) AS `ertek`, -- 1 és 5 közötti jegy
--     ELT(FLOOR(1 + (RAND() * 3)), 0.5, 1.0, 2.0) AS `suly`, -- Véletlenszerű súly: 50%, 100% vagy 200%
--     FROM_UNIXTIME(
--         UNIX_TIMESTAMP('2025-09-01 08:00:00') + 
--         RAND() * (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP('2025-09-01 08:00:00'))
--     ) AS `rogzitve`
-- FROM `diakok` d
-- CROSS JOIN (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS `multiplier`;



INSERT INTO `jegyek` (`id`, `diak_id`, `tanar_id`, `tantargy_id`, `ertek`, `suly`, `rogzitve`) VALUES
(1, 19, 5, 2, 3, 0.5, '2026-02-03 02:11:04'),
(2, 18, 4, 6, 1, 1, '2025-11-17 02:02:49'),
(3, 17, 3, 6, 3, 0.5, '2025-12-02 04:06:35'),
(4, 16, 6, 2, 5, 0.5, '2025-12-07 13:22:19'),
(5, 15, 4, 1, 5, 1, '2025-09-12 18:18:08'),
(6, 14, 4, 2, 5, 1, '2026-02-20 12:11:15'),
(7, 9, 4, 4, 3, 0.5, '2025-12-23 05:26:06'),
(8, 8, 5, 1, 2, 0.5, '2026-01-20 12:48:55'),
(9, 7, 2, 1, 1, 2, '2025-09-23 15:36:07'),
(10, 21, 3, 1, 2, 0.5, '2025-11-15 02:07:27'),
(11, 20, 7, 1, 4, 2, '2026-01-01 13:14:26'),
(12, 4, 1, 1, 3, 2, '2025-10-25 15:08:52'),
(13, 3, 5, 6, 5, 0.5, '2025-12-15 16:59:09'),
(14, 11, 4, 2, 3, 1, '2025-09-11 15:41:36'),
(15, 10, 3, 6, 2, 2, '2025-11-14 18:35:17'),
(16, 13, 5, 4, 2, 0.5, '2025-11-27 19:22:59'),
(17, 12, 6, 1, 1, 1, '2026-01-17 02:48:25'),
(18, 6, 1, 2, 3, 1, '2026-01-12 15:34:47'),
(19, 5, 1, 2, 3, 1, '2025-10-24 20:35:41'),
(20, 2, 1, 6, 4, 1, '2026-02-01 00:55:34'),
(21, 1, 5, 2, 5, 1, '2025-11-10 13:29:58'),
(22, 19, 7, 6, 1, 1, '2025-11-19 17:33:31'),
(23, 18, 3, 4, 2, 0.5, '2025-10-01 06:44:04'),
(24, 17, 7, 2, 1, 0.5, '2026-02-04 22:49:55'),
(25, 16, 6, 1, 1, 0.5, '2026-01-17 19:44:19'),
(26, 15, 2, 4, 4, 2, '2025-10-29 02:25:55'),
(27, 14, 1, 1, 1, 1, '2025-10-07 16:06:09'),
(28, 9, 7, 1, 5, 1, '2026-02-14 15:26:51'),
(29, 8, 7, 4, 1, 1, '2025-12-24 05:22:12'),
(30, 7, 4, 6, 5, 1, '2025-11-29 12:52:57'),
(31, 21, 4, 1, 2, 1, '2026-01-28 06:45:08'),
(32, 20, 5, 1, 4, 2, '2026-01-26 12:41:24'),
(33, 4, 4, 1, 4, 1, '2026-01-08 01:50:14'),
(34, 3, 3, 6, 5, 1, '2025-11-05 04:35:34'),
(35, 11, 6, 1, 4, 2, '2026-01-07 09:33:12'),
(36, 10, 6, 6, 5, 1, '2026-01-23 10:52:02'),
(37, 13, 2, 4, 5, 1, '2026-02-10 09:18:33'),
(38, 12, 3, 4, 1, 0.5, '2025-11-23 20:34:42'),
(39, 6, 5, 1, 1, 2, '2025-10-09 17:13:59'),
(40, 5, 2, 1, 3, 2, '2025-10-18 11:39:57'),
(41, 2, 1, 2, 3, 2, '2025-10-06 01:44:22'),
(42, 1, 7, 2, 5, 0.5, '2025-12-27 07:14:14'),
(43, 19, 2, 2, 3, 0.5, '2025-12-25 02:45:47'),
(44, 18, 7, 6, 5, 1, '2025-09-15 08:18:09'),
(45, 17, 7, 6, 4, 1, '2025-12-09 21:30:54'),
(46, 16, 2, 2, 4, 2, '2026-01-02 11:26:17'),
(47, 15, 2, 4, 1, 2, '2026-02-09 04:54:38'),
(48, 14, 5, 2, 2, 0.5, '2025-11-15 14:52:31'),
(49, 9, 4, 6, 3, 2, '2025-12-26 02:42:23'),
(50, 8, 4, 4, 4, 0.5, '2025-11-27 08:16:50'),
(51, 7, 7, 1, 1, 2, '2025-10-05 07:00:42'),
(52, 21, 5, 2, 4, 1, '2026-01-30 21:45:12'),
(53, 20, 1, 2, 3, 2, '2026-01-05 20:09:10'),
(54, 4, 4, 6, 3, 2, '2025-11-17 19:35:01'),
(55, 3, 5, 1, 4, 1, '2026-01-14 23:09:27'),
(56, 11, 3, 4, 5, 2, '2026-01-19 08:51:11'),
(57, 10, 2, 4, 1, 1, '2025-09-17 00:03:05'),
(58, 13, 2, 6, 5, 1, '2026-01-09 15:23:05'),
(59, 12, 3, 6, 5, 2, '2025-12-27 22:41:57'),
(60, 6, 5, 6, 2, 2, '2026-02-06 18:46:41'),
(61, 5, 7, 6, 4, 1, '2025-10-25 12:11:10'),
(62, 2, 4, 6, 5, 0.5, '2025-10-30 07:53:04'),
(63, 1, 5, 2, 4, 2, '2025-11-20 07:10:12'),
(64, 19, 7, 1, 5, 2, '2026-01-18 20:01:32'),
(65, 18, 7, 2, 4, 1, '2025-12-20 15:27:05'),
(66, 17, 6, 6, 5, 0.5, '2025-10-05 20:09:23'),
(67, 16, 2, 2, 4, 2, '2025-12-13 02:52:53'),
(68, 15, 7, 6, 5, 2, '2026-02-03 04:06:33'),
(69, 14, 2, 1, 3, 0.5, '2025-12-10 10:31:59'),
(70, 9, 6, 4, 5, 1, '2026-01-17 12:55:20'),
(71, 8, 3, 2, 3, 2, '2025-10-20 20:36:44'),
(72, 7, 4, 6, 1, 1, '2026-02-05 06:07:55'),
(73, 21, 1, 4, 4, 0.5, '2025-12-14 06:32:42'),
(74, 20, 4, 6, 5, 2, '2026-01-11 06:28:22'),
(75, 4, 6, 1, 3, 2, '2025-11-02 16:13:21'),
(76, 3, 2, 2, 1, 2, '2025-12-01 01:27:05'),
(77, 11, 4, 1, 4, 2, '2025-12-07 13:19:58'),
(78, 10, 2, 4, 1, 2, '2025-12-26 18:21:00'),
(79, 13, 4, 1, 5, 2, '2025-09-07 02:01:12'),
(80, 12, 6, 1, 5, 2, '2026-01-10 23:57:05'),
(81, 6, 1, 1, 1, 1, '2025-10-23 12:54:30'),
(82, 5, 5, 6, 4, 0.5, '2025-10-22 14:06:27'),
(83, 2, 7, 6, 2, 2, '2026-01-18 19:15:48'),
(84, 1, 3, 1, 2, 2, '2025-09-22 15:42:22'),
(85, 19, 4, 1, 2, 1, '2025-09-09 09:14:37'),
(86, 18, 6, 4, 4, 0.5, '2025-09-05 00:31:39'),
(87, 17, 6, 2, 5, 1, '2026-01-04 07:05:04'),
(88, 16, 3, 1, 4, 2, '2025-12-13 07:34:49'),
(89, 15, 7, 1, 5, 1, '2025-12-31 02:18:17'),
(90, 14, 6, 4, 4, 0.5, '2025-11-29 11:29:49'),
(91, 9, 6, 2, 2, 1, '2026-02-04 06:35:31'),
(92, 8, 5, 6, 5, 2, '2025-11-27 00:24:55'),
(93, 7, 2, 1, 1, 1, '2025-09-03 00:09:36'),
(94, 21, 3, 2, 3, 1, '2025-09-10 21:03:20'),
(95, 20, 3, 6, 2, 1, '2025-12-10 18:43:16'),
(96, 4, 2, 1, 5, 2, '2026-01-01 03:40:39'),
(97, 3, 3, 1, 4, 2, '2026-01-31 00:39:28'),
(98, 11, 3, 6, 2, 0.5, '2025-10-31 06:55:43'),
(99, 10, 4, 1, 2, 0.5, '2025-09-11 13:37:36'),
(100, 13, 3, 1, 3, 1, '2026-02-16 05:36:14'),
(101, 12, 5, 2, 2, 1, '2026-02-12 04:36:33'),
(102, 6, 2, 1, 2, 1, '2025-10-06 01:51:31'),
(103, 5, 3, 1, 5, 2, '2026-01-17 03:14:54'),
(104, 2, 4, 2, 4, 0.5, '2026-02-07 22:09:41'),
(105, 1, 4, 6, 1, 1, '2025-09-14 10:59:28'),
(106, 1, 2, 1, 1, 1, '2025-09-14 10:59:28'),
(107, 20, 2, 1, 2, 1, '2025-12-10 18:43:16');

SET foreign_key_checks = 1;