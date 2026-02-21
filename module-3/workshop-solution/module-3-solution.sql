-- 1. Melyik diák melyik osztályba jár. A diák teljes neve egyetlen oszlopban jelenjen meg,
--    továbbá ügyeljen rá, hogy az egy osztályba járó diákok egymás után jöjjenek. Az osztályon belül ABC sorrendben legyenek.
SELECT CONCAT(`diakok`.`vezeteknev`, ' ', `diakok`.`keresztnev`) AS `tanulo_neve`, `osztalyok`.`nev` AS `osztaly`
FROM `diakok`
INNER JOIN `osztalyok` ON `diakok`.`osztaly_id` = `osztalyok`.`id`
ORDER BY `osztalyok`.`nev` ASC, `tanulo_neve` ASC;

-- 2. Ki az osztályfőnöke 'Kiss Anna' nevű diáknak?
SELECT `osztalyok`.`osztalyfonok`
FROM `diakok`
INNER JOIN `osztalyok` ON `diakok`.`osztaly_id` = `osztalyok`.`id`
WHERE `diakok`.`vezeteknev` = 'Kiss' AND `diakok`.`keresztnev` = 'Anna';

-- 3. Hány tanuló tanterme a 101-es?
SELECT COUNT(`diakok`.`id`) AS `tanulok_szama`
FROM `diakok`
INNER JOIN `osztalyok` ON `diakok`.`osztaly_id` = `osztalyok`.`id`
WHERE `osztalyok`.`terem` = '101. terem';

-- 4. Kik azok a 180 centiméternél alacsonyabb diákok, akik tanulnak matematikát?
SELECT DISTINCT `diakok`.`vezeteknev`, `diakok`.`keresztnev`
FROM `diakok`
INNER JOIN `diak_tantargy` ON `diakok`.`id` = `diak_tantargy`.`diak_id`
INNER JOIN `tantargyak` ON `diak_tantargy`.`tantargy_id` = `tantargyak`.`id`
WHERE `diakok`.`magassag_cm` < 180 AND `tantargyak`.`nev` = 'Matematika';

-- 5. Hány jegyet naplózott *"Nagy Péter"*?
SELECT COUNT(`jegyek`.`id`) AS `naplozott_jegyek`
FROM `jegyek`
INNER JOIN `tanarok` ON `jegyek`.`tanar_id` = `tanarok`.`id`
WHERE `tanarok`.`vezeteknev` = 'Nagy' AND `tanarok`.`keresztnev` = 'Péter';

-- 6. Jelenítse meg azon tanárok teljes nevét, és a beírt jegyek számát, akik legalább 15 jegyet beírtak már.
SELECT 
    CONCAT(`tanarok`.`vezeteknev`, ' ', `tanarok`.`keresztnev`) AS `tanar_teljes_neve`, 
    COUNT(`jegyek`.`id`) AS `beirt_jegyek_szama`
FROM `tanarok`
INNER JOIN `jegyek` ON `tanarok`.`id` = `jegyek`.`tanar_id`
GROUP BY `tanarok`.`id`
HAVING `beirt_jegyek_szama` >= 15;

-- 7. Határozza meg, hogy kinek hány jegyet írtak be 2026-ban.
SELECT `diakok`.`vezeteknev`, `diakok`.`keresztnev`, COUNT(`jegyek`.`id`) AS `jegyek_szama`
FROM `diakok`
INNER JOIN `jegyek` ON `diakok`.`id` = `jegyek`.`diak_id`
WHERE YEAR(`jegyek`.`rogzitve`) = 2026
GROUP BY `diakok`.`id`;

-- 8. Kik azok a diákok, akik kaptak már jegyet *"Angol nyelv"* tantárgyból és a saját termük a 200-as termek egyike.
SELECT DISTINCT `diakok`.`vezeteknev`, `diakok`.`keresztnev`
FROM `diakok`
INNER JOIN `osztalyok` ON `diakok`.`osztaly_id` = `osztalyok`.`id`
INNER JOIN `jegyek` ON `diakok`.`id` = `jegyek`.`diak_id`
INNER JOIN `tantargyak` ON `jegyek`.`tantargy_id` = `tantargyak`.`id`
WHERE `tantargyak`.`nev` = 'Angol nyelv' AND `osztalyok`.`terem` LIKE '20%';

-- 9. Jelenítse meg, hogy az egyes diákok melyik tárgyból milyen súlyozott átlagot szereztek eddig? Az eredményben jelenjen meg a jegy, a tantárgy és a diák teljes neve. Az eredményt ABC sorrendben adja meg.
SELECT 
    CONCAT(`diakok`.`vezeteknev`, ' ', `diakok`.`keresztnev`) AS `teljes_nev`,
    `tantargyak`.`nev` AS `tantargy`,
    SUM(`jegyek`.`ertek` * `jegyek`.`suly`) / SUM(`jegyek`.`suly`) AS `sulyozott_atlag`
FROM `diakok`
INNER JOIN `jegyek` ON `diakok`.`id` = `jegyek`.`diak_id`
INNER JOIN `tantargyak` ON `jegyek`.`tantargy_id` = `tantargyak`.`id`
GROUP BY `diakok`.`id`, `tantargyak`.`id`
ORDER BY `teljes_nev` ASC;

-- 10. Hogy hívják azokat a diákokat, akik kaptak már legalább 6 jegyet? Kezdje a legtöbb jegyet megszerző diákkal. Azonosság esetén ABC sorrendben jelenítse meg az adatokat.
SELECT 
    `diakok`.`vezeteknev`, 
    `diakok`.`keresztnev`, 
    COUNT(`jegyek`.`id`) AS `jegyek_szama`
FROM `diakok`
INNER JOIN `jegyek` ON `diakok`.`id` = `jegyek`.`diak_id`
GROUP BY `diakok`.`id`
HAVING `jegyek_szama` >= 6
ORDER BY `jegyek_szama` DESC, `diakok`.`vezeteknev` ASC, `diakok`.`keresztnev` ASC;

-- 11. Jelenítse meg, hogy melyik tantárgyból milyen a legrosszabb, legjobb jegy, illetve az átlagot is, de csak akkor, ha az átlag eléri a `2.8`-at

SELECT 
    `tantargyak`.`nev` AS `Tantárgy`,
    MIN(`jegyek`.`ertek`) AS `Legrosszabb_jegy`,
    MAX(`jegyek`.`ertek`) AS `Legjobb_jegy`,
    AVG(`jegyek`.`ertek`) AS `Atlag`
FROM `tantargyak`
INNER JOIN `jegyek` ON `tantargyak`.`id` = `jegyek`.`tantargy_id`
GROUP BY `tantargyak`.`id`, `tantargyak`.`nev`
HAVING `Atlag` >= 2.8;


-- 12. Hány lány és hány fiú tanulja a *"Fizika"* tantárgyat? Az eredményben jelenjen meg a nem és a darabszám.

SELECT 
    IF(`diakok`.`nem` = 0, 'lány', 'fiú') AS `nem_megnevezese`,
    COUNT(`diakok`.`id`) AS `letszam`
FROM `diakok`
INNER JOIN `diak_tantargy` ON `diakok`.`id` = `diak_tantargy`.`diak_id`
INNER JOIN `tantargyak` ON `diak_tantargy`.`tantargy_id` = `tantargyak`.`id`
WHERE `tantargyak`.`nev` = 'Fizika'
GROUP BY `diakok`.`nem`;