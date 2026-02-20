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

DROP TABLE IF EXISTS `diakok`;
CREATE TABLE `diakok` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `vezeteknev` VARCHAR(50) NOT NULL,
  `keresztnev` VARCHAR(50) NOT NULL,
  `nem` TINYINT NOT NULL,
  `osztaly` VARCHAR(10) NOT NULL,
  `szuletett` DATE NOT NULL,
  `kor` INT NOT NULL,
  `email` VARCHAR(120) NOT NULL UNIQUE,
  `magassag_cm` INT NOT NULL,
  `atlag` FLOAT NOT NULL,
  `irsz` INT NOT NULL,
  `lakcim` VARCHAR(100) NOT NULL
);

TRUNCATE TABLE `tanarok`;
INSERT INTO `tanarok` (`vezeteknev`, `keresztnev`, `szuletett`, `kor`, `nem`, `szak`, `hobbi`, `tanora`, `szakkor`)
VALUES
('Nagy',     'Péter',   '1982-04-12', 43, 1, 'Matematika/Fizika', 'futás', 24, 1),
('Kovács',   'Anna',    '1986-11-03', 40, 0, 'Angol/Biológia', 'fotózás', 22, 2),
('Tóth',     'Gábor',   '1996-02-20', 30, 1, 'Testnevelés/Biológia',NULL, 12,0),
('Szabó',    'Eszter',  '1988-07-01', 37, 0, 'Digitális kultúra','kertészkedés', 14,2),
('Tóth',    'Miklós',  '1979-09-18', 46, 1, NULL, NULL, 22,2),
('Nagy',  'Anna',   '1992-12-05', 33, 0, 'Etika/Hittan','fotózás', 12,0),
('Karácsony',  'Mária',   '1980-12-05', 45, 0, 'Matematika/Kémia', 'TEREPFUTÁS',20,1);

TRUNCATE TABLE `diakok`;
INSERT INTO `diakok` (`vezeteknev`, `keresztnev`, `nem`, `osztaly`, `szuletett`, `kor`, `email`, `magassag_cm`, `atlag`, `irsz`, `lakcim`) VALUES
('Kiss',     'Anna',    0,  '9.A',  '2010-06-15', 15, 'kiss.anna@gmail.com', 162, 4.2, 1031, 'Budapest, Vízi utca 5.'),
('Szabó',    'Bence',   1,  '9.A',  '2010-01-08', 16, 'szabo.bence@freemail.hu', 170, 3.8, 4024, 'Debrecen, Piac utca 12.'),
('Varga',    'Dóra',    0,  '10.B', '2009-09-30', 16, 'varga.dora@icloud.com', 158, 4.9, 6720, 'Szeged, Tisza Lajos krt. 3.'),
('Tóth',     'Máté',    1,  '10.B', '2009-03-21', 16, 'toth.mate@gmail.hu', 175, 3.2, 3525, 'Miskolc, Városház tér 1.'),
('Nagy',     'Lili',    0,  '9.B',  '2010-11-02', 15, NULL, 160, 4.5, 7621, 'Pécs, Király utca 8.'),
('Kovács',   'Levente', 1,  '9.B',  '2010-05-27', 15, 'kovacs.levente@gmail.com', 168, 3.4, 9022, 'Győr, Baross út 15.'),
('Horváth',  'Réka',    0,  '11.A', '2008-12-12', 17, 'horvath.reka@yahoo.com', 164, 4.1, 8000, 'Székesfehérvár, Fő utca 2.'),
('Balogh',   'Ádám',    1,  '11.A', '2008-08-09', 17, 'balogh.adam@freemail.hu', 178, 2.7, 4400, 'Nyíregyháza, Kossuth tér 5.'),
('Balogh',   'Ádám',    1,  '11.A', '2008-03-15', 17, 'balogha@gmail.hu', 182, 4.8, 1192, 'Budapest, Pannónia út 6.'),
('Farkas',   'Zsófi',   0,  '10.A', '2009-01-14', 17, 'farkas.zsofi@gmail.com', 161, 4.8, 6000, 'Kecskemét, Rákóczi út 10.'),
('Papp',     'Noel',    1,  '10.A', '2009-07-05', 16, 'papp.noel@outlook.com', 172, 3.9, 5000, 'Szolnok, Kossuth út 3.'),
('Lakatos',  'Kinga',   0,  '9.C',  '2010-02-25', 15, 'lakatos.kinga@gmail.hu', 159, 4.3, 2030, 'Érd, Budai út 45.'),
('Horváth',   'Gergő',   1,  '9.C',  '2010-09-18', 15, 'molnar.gergo@freemail.hu', 166, 3.1, 2800, 'Tatabánya, Fő tér 12.'),
('Nagy',   'Emese',   0,  '11.B', '2008-04-28', 17, 'szalai.emese@gmail.com', 165, 4.6, 9700, 'Szombathely, Rohonci út 4.'),
('Kelemen',  'Dániel',  1,  '11.B', '2008-10-03', 17, NULL, 180, 3.6, 8200, 'Veszprém, Egyetem utca 10.'),
('Oláh',     'Petra',   0,  '12.A', '2007-06-01', 18, 'olah.petra@gmail.com', 167, 4.9, 7400, 'Kaposvár, Ady Endre utca 7.'),
('Mészáros', 'Bálint',  1,  '12.A', '2007-02-17', 19, 'meszaros.balint@yahoo.com', 182, 3.4, 4032, 'Debrecen, Egyetem tér 1.'),
('Bíró',     'Vivien',  0,  '12.B', '2007-09-09', 18, 'biro.vivien@icloud.com', 163, 4.2, 1117, 'Budapest, Október 23. utca 8.'),
('Takács',   'Tamás',   1,  '12.B', '2007-12-20', 18, 'takacs.tamas@gmail.hu', 176, 2.8, 6724, 'Szeged, Londoni krt. 12.'),
('Nagy',    'Nóra',    0,  '10.C', '2009-11-11', 16, 'sipos.nora@freemail.hu', 160, 4.7, 3530, 'Miskolc, Szemere utca 4.'),
('Simon',    'Zalán',   1,  '10.C', '2009-05-16', 16, 'simon.zalan@gmail.com', 174, 3.5, 1042, 'Budapest, Árpád út 20.');
