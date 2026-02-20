-- 1. Jelenítse meg a `tanulok` (diakok) tábla összes adatát.
SELECT *
FROM `diakok`;

-- 2. Jelenítse meg minden tanuló vezeték- és keresztnevét.
SELECT `vezeteknev`, `keresztnev`
FROM `diakok`;

-- 3. Jelenítse meg a fiúk minden adatát.
SELECT *
FROM `diakok`
WHERE `nem` = 1;

-- 4. Hogy hívják azt a diákot, aki 2009-03-21-én született?
SELECT `vezeteknev`, `keresztnev`
FROM `diakok`
WHERE `szuletett` = '2009-03-21';

-- 5. Jelenítse meg a lányok vezeték- és keresztneveit, és a magasságukat is.
--    Az eredményt névsorban jelenítse meg!
SELECT `vezeteknev`, `keresztnev`, `magassag_cm`
FROM `diakok`
WHERE `nem` = 0
ORDER BY `vezeteknev` ASC, `keresztnev` ASC;

-- 6. Milyen keresztnevű diákok járnak az iskolába?
SELECT DISTINCT `keresztnev`
FROM `diakok`
ORDER BY `keresztnev` ASC;

-- 7. A 10 legjobb tanuló jutalomkiránduláson vehet részt. Kik mehetnek?
--    Az eredményben jelenjen meg a vezetéknevük, keresztnevük, az osztályuk és az átlaguk is.
SELECT `vezeteknev`, `keresztnev`, `osztaly`, `atlag`
FROM `diakok`
ORDER BY `atlag` DESC
LIMIT 10;

-- 8. Jelenítse meg a vezeték- és keresztnevét, továbbá magasságát is
--    azoknak a tanulóknak, akik nem érték el a 185 cm magasságot.
SELECT `vezeteknev`, `keresztnev`, `magassag_cm`
FROM `diakok`
WHERE `magassag_cm` < 185;

-- 9. Kik azok, és melyik osztályba járnak, akik legalább 160 cm,
--    de legfeljebb 180 cm magasak? Magasság szerint növekvő sorrendben.
SELECT `vezeteknev`, `keresztnev`,  `osztaly`, `magassag_cm`
FROM `diakok`
WHERE `magassag_cm` BETWEEN 160 AND 180
ORDER BY `magassag_cm` ASC;

-- 10. Hogy hívják azokat, akik "Kiss", "Nagy", vagy "Balogh" vezetéknevűek,
--     és legalább 162 cm magasak?
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `nev`,
       `magassag_cm`
FROM `diakok`
WHERE `vezeteknev` IN ('Kiss', 'Nagy', 'Balogh')
  AND `magassag_cm` >= 162;

-- 11. Jelenítse meg a "9.a", "9.b" és "9.c" osztályokba járó lányokat,
--     akik legalább 4-es átlagot értek el, és magasabbak, mint 160 cm.
SELECT `vezeteknev`, `keresztnev`, `osztaly`, `atlag`, `magassag_cm`
FROM `diakok`
WHERE `osztaly` IN ('9.A', '9.B', '9.C')
  AND `nem` = 0
  AND `atlag` >= 4
  AND `magassag_cm` > 160
ORDER BY `osztaly` ASC, `vezeteknev` ASC, `keresztnev` ASC;

-- 12. Hogy hívják a legfiatalabb diákot és melyik osztályba jár?
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `nev`,
       `osztaly`,
       `kor`,
       `szuletett`
FROM `diakok`
ORDER BY `kor` ASC, `szuletett` DESC
LIMIT 1;

-- 13. Milyen korú diákok járnak az iskolába?
SELECT DISTINCT `kor`
FROM `diakok`
ORDER BY `kor` DESC;


-- 14. Ki az, aki nem adta meg az e-mail címét?
SELECT `vezeteknev`, `keresztnev`, `osztaly`
FROM `diakok`
WHERE `email` IS NULL;

-- 15. Jelenítse meg a diákok vezeték- és keresztnevét, születési dátumát és az e-mail címét.
--     Amennyiben nincs kiöltve az e-mail, úgy az *"Ismeretlen"* szöveg jelenjen meg.
--     Kezdje a legidősebbel. Azonos korok esetén ABC sorrendben jelenjenek meg.
SELECT `vezeteknev`,
       `keresztnev`,
       `szuletett`,
       COALESCE(`email`, 'Ismeretlen') AS `email`
FROM `diakok`
ORDER BY `kor` DESC, `vezeteknev` ASC , `keresztnev` ASC;
