-- 1. Jelenítse meg a budapesti diákok összes adatát.
SELECT *
FROM `diakok`
WHERE `lakcim` LIKE 'Budapest%';

-- 2. Jelenítse meg a 11-es diákok teljes nevét, és születési évüket. Kezdje a legmagasabb diákkal.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       YEAR(`szuletett`) AS `szuletesi_ev`
FROM `diakok`
WHERE `osztaly` LIKE '11.%'
ORDER BY `magassag_cm` DESC;

-- 3. Mely diákok használják a *"Gmail"*-t, mint levelező szolgáltatót?
--    Az eredményben jelenjen meg a teljes nevük ABC sorrendben, illetve a használt e-mail címük is.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       `email`
FROM `diakok`
WHERE `email` LIKE '%@gmail.com'
ORDER BY `teljes_nev` ASC;

-- 4. Jelenítse meg, hogy melyik diáknak hány éve van még a nagykorúságig.
--    Akik már betöltötték 18 életévüket ne jelenítse meg az eredményben!
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       (18 - `kor`) AS `evek_a_nagykorusagig`
FROM `diakok`
WHERE `kor` < 18;

-- 5. A 3.5-ös átlagnál jobb átlaggal rendelkező diákok könyvjutalmat kapnak. "jegyenként" 3 000 Ft-ot,
--    azaz az átlagukat felfelé kerekítve kell venni, majd beszorozni 3 000 Ft-tal.
--    Az eredményben jelenjen meg a diákok vezeték- és keresztneve, az átlaga és a jutalom összege is.
SELECT `vezeteknev`,
       `keresztnev`,
       `atlag`,
       CEIL(`atlag`) * 3000 AS `jutalom`
FROM `diakok`
WHERE `atlag` > 3.5;


-- 6. Jelenítse meg a diákok teljes nevét egyetlen oszlopban úgy, hogy a vezetéknév csupa nagybetűs legyen.
SELECT CONCAT(UPPER(`vezeteknev`), ' ', `keresztnev`) AS `teljes_nev`
FROM `diakok`;

-- 7. Jelenítse meg a diákok teljes nevét és magasságát méterben úgy, hogy a mértékegység is szerepeljen!
--    Az eredményt 2 tizedesre kerekítse és rendezze magasság szerint növekvő sorrendbe!
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       CONCAT(ROUND(`magassag_cm` / 100, 2), ' m') AS `magassag_m`
FROM `diakok`
ORDER BY `magassag_cm` ASC;

-- 8. Hogy hívják azt a diákot, akinek a leghosszabb a neve, továbbá hány karakterből áll?
--    Amennyiben több diáknak is ugyanolyan hosszú a neve, úgy elegendő egyet megjelenítenie.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       CHAR_LENGTH(CONCAT(`vezeteknev`, ' ', `keresztnev`)) AS `karakterek_szama`
FROM `diakok`
ORDER BY `karakterek_szama` DESC
LIMIT 1;

-- 9. Jelenítse meg a diákok teljes nevét és azt, hogy melyik városban laknak.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       TRIM(LEFT(`lakcim`, INSTR(`lakcim`, ',') - 1)) AS `varos`
FROM `diakok`;

-- 10. Jelenítse meg, hogy milyen e-mail cím szolgáltatót választottak a diákok.
--     Ügyeljen rá, hogy ne legyenek ismétlődések! Az eredményt ABC sorrendben jelenítse meg!
SELECT DISTINCT
       LOWER(
           SUBSTRING(
               `email`,
               INSTR(`email`, '@') + 1,
               CHAR_LENGTH(`email`) - INSTR(`email`, '@') 
           )
       ) AS `email_szolgaltato`
FROM `diakok`
WHERE `email` IS NOT NULL
ORDER BY `email_szolgaltato` ASC;

-- 11. Jelenítse meg a születési dátumot úgy, hogy a kötőjelek helyett pont legyen az elválasztó karakter.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       REPLACE(`szuletett`, '-', '.') AS `szuletett_ponttal`
FROM `diakok`;

-- 12. Jelenítse meg a 2009-ben született diákok összes adatát, kezdje a legidősebbel!
SELECT *
FROM `diakok`
WHERE YEAR(`szuletett`) = 2009
ORDER BY `szuletett` ASC;

-- 13. Hogy hívják azokat a diákokat, akiknek iskolakezdésre, azaz szeptemberre esik a születésnapjuk?
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`,
       `szuletett`
FROM `diakok`
WHERE MONTH(`szuletett`) = 9;


-- 14. Összesen hány diák jár az iskolába az adatbázis szerint?
SELECT COUNT(*) AS `diakok_szama`
FROM `diakok`;

-- 15. Hány 11-es diák van az adatbázis szerint?
SELECT COUNT(*) AS `tizenegy`
FROM `diakok`
WHERE `osztaly` LIKE '11.%';

-- 16. Hány centi a legmagasabb tanuló?
SELECT MAX(`magassag_cm`) AS `legmagasabb_cm`
FROM `diakok`;

-- 17. Hogy hívják a legalacsonyabb tanulót? Ha több legalacsonyabb is van, akkor elegendő egy diák nevét megadni.
SELECT CONCAT(`vezeteknev`, ' ', `keresztnev`) AS `teljes_nev`
FROM `diakok`
ORDER BY `magassag_cm` ASC
LIMIT 1;

-- 18. Átlagosan milyen magasak a 9. osztályos tanulók?
SELECT AVG(`magassag_cm`) AS `kilenc_atlag`
FROM `diakok`
WHERE `osztaly` LIKE '9.%';

-- 19. Határozza meg osztályonként, hogy átlagosan milyen átlaggal rendelkeznek a benne tanuló diákok.
--     Az átlagot 2 tizedesre kerekítse!
SELECT `osztaly`,
       ROUND(AVG(`atlag`),2) AS `atlagos_atlag`
FROM `diakok`
GROUP BY `osztaly`
ORDER BY `atlagos_atlag` DESC;

-- 20. Határozza meg osztályonként a legmagasabb diák magasságát. Az eredményt kezdje a magasság bajnokával.
SELECT `osztaly`,
       MAX(`magassag_cm`) AS `legmagasabb_cm`
FROM `diakok`
GROUP BY `osztaly`
ORDER BY `legmagasabb_cm` DESC;

-- 21. Határozza meg, hogy az év melyik hónapjában hány diák született. Az eredményt a hónapok sorrendjében jelenítse meg.
SELECT MONTH(`szuletett`) AS `honap`,
       COUNT(*) AS `diakok_szama`
FROM `diakok`
GROUP BY MONTH(`szuletett`)
ORDER BY `honap` ASC;

-- 22. Igaz-e, hogy a 11.B osztály tanulói átlagosan jobb eredményt érnek el,
--     mint a 11.B osztály tanulói? Ennek megállapítására készítsen egy olyan lekérdezést,
--     ami megjeleníti mindkét osztály tanulóinak átlagát,
--     kezdje az erősebb átlaggal rendelkező osztállyal.
SELECT `osztaly`,
       AVG(`atlag`) AS `osztaly_atlag`
FROM `diakok`
WHERE `osztaly` IN ('11.A', '11.B')
GROUP BY `osztaly`
ORDER BY `osztaly_atlag` DESC;

-- 23. Évfolyamonként jelenítse meg milyen magas tornyot tudnának képezni az évfolyam diákjai, ha egymáson állnának.
SELECT 
    SUBSTRING(osztaly, 1, INSTR(osztaly, '.') - 1) AS evfolyam,
    ROUND(SUM(magassag_cm) / 100, 2) AS torony_meter
FROM diakok
GROUP BY SUBSTRING(osztaly, 1, INSTR(osztaly, '.') - 1)
ORDER BY evfolyam * 1 ASC;
