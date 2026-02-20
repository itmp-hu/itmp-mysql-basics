# 2. modul - Függvények és csoportosítás

## A modul témakörei

- LIKE
- ALIAS
- DUAL "tábla"
- Aritmetikai operátorok
- Függvények: Matematikai, dátum és szöveg függvények
- Összesítő függvények (NULL értékek kezelése)
- Csoportosítás GROUP BY

## Joker (Wildcard) karakterek

| ANSI szabvány és MySQL | Access         | Jelentés                                         |
| ----------------------- | -------------- | ------------------------------------------------ |
| `_` (aláhúzás)          | `?` (kérdőjel) | **Pontosan 1** tetszőleges karakter              |
| `%` (százalék)          | `*` (csillag)  | 0, 1, 2 vagy több **tetszőleges számú** karakter |

- Előfordul, hogy a keresett adatnak csak egy részét ismerjük
- Az ismeretlen karaktereket wildcard karakterekkel helyettesíthetjük

## Példák mintákra

- *"a" betűvel kezdődik*
    - `a%`
    - ✅ a ✅ ablak ❌ baba ❌ b

- *Pontosan két betű*
    - `__` (két aláhúzás)
    - ✅ te ✅ az ❌ a ❌ kutya

- *Szerepel benne "b" betű*
    - `%b%`
    - ✅ abba ✅ bab ✅ b ❌ autó

- *Az első betű "é", az utolsó "k"*
    - `é%k`
    - ✅ ék ✅ élénk ❌ kék ❌ ki ❌ én

- *A 3. betű/karakter "c"*
    - `__c%` (két aláhúzás az elején)
    - ✅ abc ✅ macska ❌ cipő

- *Az utolsó betű előtti betű "d"*
    - `%d_`
    - ✅ labda ✅ Ady ❌ autó ❌ pad

## LIKE példa I.
Listázza ki azokat a tanárokat, akiknek a keresztneve *"A"* betűvel **kezdődik**

```sql
SELECT * FROM `tanarok`
WHERE `keresztnev` LIKE 'A%';
```

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`         | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------- | ------- | -------- | --------- |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia | fotózás | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan   | fotózás | 12       | 0         |

## LIKE példa II.
Listázza ki azokat a tanárokat, akiknek a vezetékneve *"h"* betűvel **végződik**

```sql
SELECT * FROM `tanarok`
WHERE `vezeteknev` LIKE '%h';
```

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`               | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------------- | ------- | -------- | --------- |
| 3    | Tóth         | Gábor        | 1996-02-20  | 30    | 1     | Testnevelés/Biológia | -       | 12       | 0         |
| 5    | Tóth         | Miklós       | 1979-09-18  | 46    | 1     | -                    | -       | 22       | 2         |

## LIKE példa III.

Listázzuk ki azokat a tanárokat, akiknek a keresztneve tartalmaz *"A"* betűt:

```sql
SELECT * FROM `tanarok` 
WHERE `keresztnev` LIKE '%A%';
```

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`               | `hobbi`    | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------------- | ---------- | -------- | --------- |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia       | fotózás    | 22       | 2         |
| 3    | Tóth         | Gábor        | 1996-02-20  | 30    | 1     | Testnevelés/Biológia | -          | 12       | 0         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan         | fotózás    | 12       | 0         |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia     | TEREPFUTÁS | 20       | 1         |

- Nem csak Anna, hanem Mária is megjelenik, mert a kis- és nagybetűket nem különbözteti meg.
- Gábor is megjelenik `utf8mb4_hungarian_ci` beállítás mellett, mert az ékezetes betűket nem különbözteti meg ékezetes párjától

## LIKE példa IV.

Listázzuk ki azokat a tanárokat, akiknek a hobbija tartalmazza a *"fut"* szórészletet:

```sql
SELECT * FROM `tanarok` 
WHERE `hobbi` LIKE '%fut%';
```

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi`    | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ---------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás      | 24       | 1         |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia  | TEREPFUTÁS | 20       | 1         |

- A futás megjelenik az eredményben, ahogy a TEREPFUTÁS is

## LIKE példa V.

Listázzuk ki azokat a tanárokat, akiknek a hobbija nem *"f"* betűvel kezdődik:

```sql
SELECT * FROM `tanarok` 
WHERE `hobbi` NOT LIKE 'f%';
```

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi`      | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------------ | -------- | --------- |
| 4    | Szabó        | Eszter       | 1988-07-01  | 37    | 0     | Digitális kultúra | kertészkedés | 14       | 2         |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia  | TEREPFUTÁS   | 20       | 1         |

- A fotózás így nem fog megjelenni, sem a futás

## Love

<!-- https://www.informatikatanarok.hu/media/uploads/Informatika_erettsegi/Emelt/e_inf_21maj_fl.pdf -->

" ...Készítsen lekérdezést, amely megadja azon dalokat, amelyeknek a
címében a *"love"* szó (nem szórészlet) előfordul!
Figyeljen arra, hogy az adott szó lehet önállóan a dal címe, illetve a dal
címének elején, közepén vagy akár a végén is szerepelhet! ..."

Informatika EMELT - 2021. május 17.


- Önállóan a dal címe:

    ```sql
    `cim` = 'love' OR
    ```

    - Az egyenlőséggel pontos egyezést nézünk, itt nem kell `LIKE`

- A dal címének közepén:

    ```sql
    `cim` LIKE '% love %' OR
    ```

    - Szóközök nélkül szórészletre is keresne, a *"beloved"* is illeszkedne, de így nem ✅ 

- A dal címének elején:

    ```sql
    `cim` LIKE 'love %' OR
    ```

    - Fontos a százalék előtt álló szóköz, különben a *"lovely"*-ra is illeszkedne,  de így nem ✅ 

- A dal címének végén:

    ```sql
    `cim` LIKE '% love'
    ```

    - Szóköz nélkül a *"glove"* is illeszkedne, de így nem ✅ 

## Alias / álnév

```sql
SELECT `vezeteknev` AS `Családnév`, `keresztnev` AS `Utónév`
FROM `tanarok`;
```

- A lekérdezés során az alábbi elemek átnevezhetők:
    - adatbázis
    - tábla
    - mező
    - számított mező

> [!WARNING]  
> Szabvány szerint a `WHERE` záradékban nem használható átnevezett mező!

> [!WARNING]  
> A MySQL elfogadja, ha backtick helyett aposztrófot használunk, de rendezésnél problémát okoz!

## Tábla neve lekérdezésben

```sql
SELECT `tanarok`.`vezeteknev`, `tanarok`.`hobbi`
FROM `tanarok`;
```

- A `SELECT` záradékban szerepelhet a tábla neve is (meg az adatbázisé is)

```sql
SELECT `t`.`vezeteknev`, `t`.`hobbi`
FROM `tanarok` AS `t`;
```

- A tábla átnevezhető, innentől a tábla eredeti neve helyett az álnevét kell használni
- Különösen hasznos, ha hosszú a táblanév, vagy több táblával dolgozunk

```sql
SELECT `t`.`vezeteknev`, `t`.`hobbi`
FROM `iskola`.`tanarok` AS `t`;
```

- Az `iskola` adatbázis `tanarok` tábláját egyszerűen csak `t`-nek hívjuk
- Sokkal rövidebb, mint az `iskola.tanarok.hobbi` végig gépelve a `SELECT`-ben

## Számított mezők

- Az SQL-ben lehetőség van arra, hogy ne csak nyers adatokat, hanem számítások eredményeit is megjelenítsük.
- Szerepelhet benne:
    - Konstans érték: `1`, `'hello'`, `'2000-01-01'`, `true`
    - Adatbázis mező: `vezeteknev`, `kor`
    - Különböző függvények: `UPPER(vezeteknev)`, `SQRT(9)`

## A DUAL tábla

- Előfordulhatnak olyan lekérdezések, melyek nem köthetők konkrét táblához
- A szabvány szerint a `FROM` záradék nem hagyható el

```sql
SELECT 10 + 5 AS `eredmeny`
FROM DUAL;
```

- A `DUAL` egy 1 sorból és 1 oszlopból álló tábla
- Backtickek közé rakva egy konkrétan ilyen nevű táblát keresne, így hagyjuk el
- https://en.wikipedia.org/wiki/DUAL_table

```sql
SELECT NOW() AS `Pontos idő`
```

- MySQL-ben elhagyható, de más rendszerek megkövetelhetik

## Aritmetikai műveletek

| Operátor       | Művelet                          |
| -------------- | -------------------------------- |
| `*`            | Szorzás                          |
| `/`            | (Valós) Osztás                   |
| `MOD` vagy `%` | Modulo operátor / Maradék képzés |
| `DIV`          | Egész osztás                     |
| `+`            | Összeadás                        |
| `-`            | Kivonás                          |

```sql
SELECT `vezeteknev`, `keresztnev`, 
       65 - `kor` AS `evek_a_nyugdijig`
FROM `tanarok`;
```

## WHERE és álnév

Kik azok, akiknek több mint 24 órájuk van a héten?

```sql
SELECT `vezeteknev`, `keresztnev`, 
       `tanora` + `szakkor` AS `ossz_ora`
FROM `tanarok`
WHERE `ossz_ora` > 24;
```

> [!WARNING]  
> #1054 - A(z) ossz_ora oszlop érvénytelen 'where clause'-ben
> Azaz a WHERE záradékban nem szerepelhet álnév!

```sql
SELECT `vezeteknev`, `keresztnev`, 
       `tanora` + `szakkor` AS `ossz_ora`
FROM `tanarok`
WHERE `tanora` + `szakkor` > 24;
```

- A `WHERE` feltételben álnév helyett meg kell ismételni a képletet!

## Matematikai függvények

A MySQL számos beépített függvényt kínál a precízebb adatkezeléshez.

| Függvény                | Leírás                                   | Példa                   |
| ----------------------- | ---------------------------------------- | ----------------------- |
| `PI()`                  | PI értéke                                | `PI() = 3.141593`       |
| `ABS(x)`                | Abszolút érték                           | `ABS(-5) = 5`           |
| `MOD(x,y)`              | Maradék képzés                           | `MOD(15,2) = 1`         |
| `POW(x,y)` `POWER(x,y)` | Hatványozás                              | `POW(2,8) = 256`        |
| `ROUND(x, d)`           | Matematikai kerekítés *d* tizedesjegyre  | `ROUND(4.256,2) = 4.26` |
| `CEIL(x)` `CEILING(x)`  | Felfelé kerekítés a legközelebbi egészre | `CEIL(522.123) = 523`   |
| `FLOOR(x)`              | Lefelé kerekítés a legközelebbi egészre  | `FLOOR(463.888) = 463`  |

- https://dev.mysql.com/doc/refman/9.6/en/mathematical-functions.html

## Dátum függvények

| Függvény    | Leírás                            | Példa                                     |
| ----------- | --------------------------------- | ----------------------------------------- |
| `YEAR()`    | Kinyeri az évszámot               | `SELECT YEAR(szuletett) FROM diakok;` |
| `MONTH()`   | Kinyeri a hónapot (1-12)          | `SELECT MONTH(szuletett) FROM tanarok;`   |
| `DAY()`     | Kinyeri a napot (1-31)            | `SELECT DAY(szuletett) FROM diakok;`      |
| `DATE()`    | Megadja a dátum részt (éé-hh-nn)  | `SELECT DATE(rogzitve) FROM jegyek;`      |
| `WEEKDAY()` | A hét napjának sorszáma (0=Hétfő) | `SELECT WEEKDAY(szuletett) FROM diakok;`  |
| `CURDATE()` | Az aktuális rendszerdátum         | `SELECT CURDATE();`                       |
| `NOW()`     | Aktuális dátum ÉS idő             | `SELECT NOW();`                           |

- A `WEEKDAY()` helyett a nap nevét a `DAYNAME()` függvény adja meg (pl. 'Monday')

## Idő függvények

| Függvény    | Leírás                                          | Példa                                  |
| ----------- | ----------------------------------------------- | -------------------------------------- |
| `HOUR()`    | Kinyeri az órát (0-23)                          | `SELECT HOUR(rogzitve) FROM jegyek;`   |
| `MINUTE()`  | Kinyeri a percet (0-59)                         | `SELECT MINUTE(rogzitve) FROM jegyek;` |
| `SECOND()`  | Kinyeri a másodpercet (0-59)                    | `SELECT SECOND(rogzitve) FROM jegyek;` |
| `TIME()`    | Megadja a teljes idő részt (óó:pp:mm)           | `SELECT TIME(rogzitve) FROM jegyek;`   |
| `CURTIME()` | Az aktuális rendszeridőt adja vissza (óó:pp:mm) | `SELECT CURTIME();`                    |

## Hány évesek a tanárok? I.

```sql
SELECT 
    `vezeteknev`, 
    `keresztnev`, 
    YEAR(CURDATE()) - YEAR(`szuletett`) AS `eletkor`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` | `eletkor` |
| ------------ | ------------ | --------- |
| Nagy         | Péter        | 44        |
| Kovács       | Anna         | 40        |
| Tóth         | Gábor        | 30        |
| Szabó        | Eszter       | 38        |
| Tóth         | Miklós       | 47        |
| Nagy         | Anna         | 34        |
| Karácsony    | Mária        | 46        |

- Csak az évet nézi, aki ebben az évben lesz nagykorú, azt már annak tekinti

## Hány évesek a tanárok? II.

```sql
SELECT 
    `vezeteknev`, 
    `keresztnev`, 
    FLOOR(DATEDIFF(CURDATE(),`szuletett`) / 365.25) AS `eletkor`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` | `eletkor` |
| ------------ | ------------ | --------- |
| Nagy         | Péter        | 43        |
| Kovács       | Anna         | 39        |
| Tóth         | Gábor        | 30        |
| Szabó        | Eszter       | 37        |
| Tóth         | Miklós       | 46        |
| Nagy         | Anna         | 33        |
| Karácsony    | Mária        | 45        |

- A `DATEDIFF` MySQL-ben fixen a napok számát adja vissza, máshol megadható, hogy hogyan kérjük
- Egy év 365 nap, időnként szökőév közbeszól, nem teljesen pontos

## Hány évesek a tanárok? III.

```sql
SELECT 
    `vezeteknev`, 
    `keresztnev`, 
    TIMESTAMPDIFF(YEAR, `szuletett`, CURDATE()) AS `eletkor`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` | `eletkor` |
| ------------ | ------------ | --------- |
| Nagy         | Péter        | 43        |
| Kovács       | Anna         | 39        |
| Tóth         | Gábor        | 30        |
| Szabó        | Eszter       | 37        |
| Tóth         | Miklós       | 46        |
| Nagy         | Anna         | 33        |
| Karácsony    | Mária        | 45        |

- A `TIMESTAMPDIFF` első paramétere, hogy milyen mértékegységben adja vissza az eredményt (pl. YEAR, MONTH, DAY).

## Szövegfüggvények I.

| Függvény            | Leírás                                                                  | Példa                                                         |
| ------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------- |
| `CONCAT()`          | Összefűzi a megadott karakterláncokat.                                  | `SELECT CONCAT(vezeteknev, ' ', keresztnev) FROM tanarok;`    |
| `CONCAT_WS()`       | Összefűzi a megadott karakterláncokat a megadott elválasztó karakterrel | `SELECT CONCAT_WS(' ', vezeteknev, keresztnev) FROM tanarok;` |
| `UPPER()` `UCASE()` | Csupa nagybetűssé alakítja a szöveget.                                  | `SELECT UPPER(szak) FROM tanarok;`                            |
| `LOWER()` `LCASE()` | Csupa kisbetűssé alakítja a szöveget.                                   | `SELECT LOWER(email) FROM diakok;`                            |
| `LENGTH()`          | Megadja a szöveg hosszát bájtokban.                                     | `SELECT LENGTH(vezeteknev) FROM tanarok;`                     |
| `CHAR_LENGTH()`     | Megadja a karakterek számát (speciális karaktereknél fontos).           | `SELECT CHAR_LENGTH(vezeteknev) FROM tanarok;`                |

## Szövegfüggvények II.

| Függvény                 | Leírás                                                        | Példa                                             |
| ------------------------ | ------------------------------------------------------------- | ------------------------------------------------- |
| `LEFT(str, len)`         | Kivágja a szöveg bal oldaláról a megadott számú karaktert.    | `SELECT LEFT(osztaly, 2) FROM diakok;` (Pl. '10') |
| `RIGHT(str, len)`        | Kivágja a szöveg jobb oldaláról a megadott számú karaktert.   | `SELECT RIGHT(osztaly, 1) FROM diakok;` (Pl. 'A') |
| `SUBSTR()` `SUBSTRING()` | Kivág egy részt a szövegből (honnan, hányat).                 | `SELECT SUBSTRING(email, 1, 4) FROM diakok;`      |
| `REPLACE()`              | Lecserél egy szövegrészt egy másikra.                         | `SELECT REPLACE(szak, '/', ' és ') FROM tanarok;` |
| `TRIM()`                 | Eltávolítja a felesleges szóközöket az elejéről és a végéről. | `SELECT TRIM(megjegyzes) FROM jegyek;`            |
| `INSTR()`                | Megkeresi egy szövegrész első előfordulásának helyét.         | `SELECT INSTR(email, '@') FROM diakok;`           |

- https://dev.mysql.com/doc/refman/9.6/en/string-functions.html

## Teljes név

Jelenítse meg a tanárok teljes nevét!

```sql
SELECT CONCAT(vezeteknev, ' ', keresztnev) AS tanar_neve 
FROM tanarok;
```

| `tanar_neve`    |
| --------------- |
| Nagy Péter      |
| Kovács Anna     |
| Tóth Gábor      |
| Szabó Eszter    |
| Tóth Miklós     |
| Nagy Anna       |
| Karácsony Mária |

## Évfolyam kinyerése

Jelenítse meg a diákok teljes nevét, és azt, hogy melyik évfolyamon tanulnak.

```sql
SELECT 
    CONCAT_WS(' ', `vezeteknev`, `keresztnev`),
    LEFT(osztaly, INSTR(osztaly, '.') - 1) AS evfolyam 
FROM diakok;
```

- A `CONCAT_WS` első paramétere az elválasztó karakter (itt szóköz)
- Az `INSTR` meghatározza a pont helyét az osztályban
    - *"9.a"* és *"11.c"* esetén máshol lesz
- A `LEFT` a pontig tartó részt veszi ki, a `-1` miatt maga a pont már nem kerül bele az eredménybe

## Aggregált (összesítő) függvények

- Ezek a függvények több sor adatait dolgozzák fel
- Egyetlen eredményt adnak vissza.
- Alapértelmezetten a `NULL` értékeket figyelmen kívül hagyják
- Függvények:
    - `COUNT()`
    - `SUM()`
    - `AVG()`
    - `MIN()`
    - `MAX()`

## COUNT 

- Megszámolja a **nem** `NULL` értékeket a meghatározott mezőn
- Amennyiben nincs egyetlen találat sem, úgy `0` értéket ad.
- MySQL-ben számokat és szöveget tartalmazó oszlopokra is alkalmazható


Hány tanárnak van valamilyen hobbija?

```sql
SELECT COUNT(`hobbi`) as `fo` FROM `tanarok`;
```

| `fo` |
| --- |
| 5 |

- Ahol a `hobbi` értéke `NULL`, azokat a sorokat figyelmen kívül hagyja

## COUNT - sorok száma

Hány tanár található az iskolában?

```sql
SELECT COUNT(`id`) as `letszam` FROM `tanarok`;
```

vagy

```sql
SELECT COUNT(*) as `letszam` FROM `tanarok`;
```

| `letszam` |
| --- |
| 7 |

- A kulcs kitöltése kötelező, így a teljes létszámot adja meg
- A `*` is a sorok számát határozza meg

## COUNT - egyedi értékek

Hány különböző hobbit űznek a tanárok?

```sql
SELECT COUNT(DISTINCT `hobbi`) as `egyedi` FROM `tanarok`;
```

| `egyedi` |
| -------- |
| 4        |

- Csak az egyedi értékeket veszi figyelembe
- Többen is ugyanazt írták be a hobbi oszlopba, és az ismétlődéseket csak egyszer számolja

## SUM 

- Összeadja a megadott mező értékeit
- Amennyiben nincs egyetlen találat sem, úgy `NULL` értéket ad.

Hány óra szakkört tartanak **összesen** a tanárok?

```sql
SELECT SUM(`szakkor`) as `ora` FROM `tanarok`;
```

| `ora` |
| ----- |
| 8     |

## SUM() - feltétellel

Hány **órányi szakkört** tartanak **összesen** azok a tanárok, akik nem töltötték ki a hobbi mezőt?

```sql
SELECT SUM(`szakkor`) as `szakkor_ora`
FROM `tanarok`
WHERE `hobbi`  IS NULL;
```

| `szakkor_ora` |
| ------------- |
| 2             |

Hány **órát és szakkört** tartanak **összesen** azok a tanárok, akik *"matematika"* szakosok?

```sql
SELECT SUM(`tanora` + `szakkor`) as `ossz_ora`
FROM `tanarok`
WHERE `szak` LIKE '%Matematika%';
```

| `ossz_ora` |
| ---------- |
| 46         |

## AVG 

- Kiszámítja az adott mező átlagát
- Amennyiben nincs egyetlen találat sem, úgy `NULL` értéket ad.

Átlagosan hány tanórája van az iskola egy tanárának?

```sql
SELECT FLOOR(AVG(`tanora`)) as `atlag` FROM `tanarok`;
```

| `atlag` |
| ------- |
| 18      |

## MIN és MAX 

- Kiszámítja az adott mező minimumát/maximumát
- Amennyiben nincs egyetlen találat sem, úgy `NULL` értéket ad.

Hány éves a legfiatalabb?

```sql
SELECT MIN(`kor`) as `legfiatalabb` FROM `tanarok`;
```

| `legfiatalabb` |
| -------------- |
| 30             |

Kinek a vezetékneve van ABC sorrendben leghátul?

```sql
SELECT MAX(`vezeteknev`) as `utolso` FROM `tanarok`;
```

| `utolso` |
| -------- |
| Tóth     |

## Összesítő függvények vegyesen

Hány éves a legfiatalabb, a legidősebb tanár, illetve mennyi az átlagos koruk?

```sql
SELECT
    MIN(`kor`) as `legfiatalabb`,
    MAX(`kor`) as `legidosebb`,
    FLOOR(AVG(`kor`)) as `atlag`
FROM
    `tanarok`;
```

| `legfiatalabb` | `legidosebb` | `atlag` |
| -------------- | ------------ | ------- |
| 30             | 46           | 39      |

- Egyetlen lekérdezésben több összesítő függvényt is lehet alkalmazni

## GROUP BY

- A `GROUP BY` záradék arra szolgál, hogy az azonos értékkel rendelkező sorokat csoportokba foglalja

> [!WARNING]  
> Csoportosításnál olyan mező állhat a `SELECT` után, ami vagy szerepel a `GROUP BY` után, vagy valamilyen **összesítő függvényben** van.

Hány tanár űzi az egyes hobbikat?

```sql
SELECT `hobbi`, COUNT(`id`) AS `fo`
FROM `tanarok`
GROUP BY `hobbi`;
```

- 2 tanár esetében a hobbi értéke `NULL`

| `hobbi`      | `fo` |
| ------------ | ---- |
| futás        | 1    |
| fotózás      | 2    |
| -            | 2    |
| kertészkedés | 1    |
| TEREPFUTÁS   | 1    |

## Nemek szerinti órák

Határozza meg nemek szerint, hogy hány órát tartanak (szakkörökkel együtt) a tanárok!

```sql
SELECT
    IF(`nem` = 0,'Nő', 'Férfi') AS `neme`,
    AVG(`tanora` + `szakkor`) AS `atlag`
FROM `tanarok`
GROUP BY `nem`;
```

| `neme` | `atlag` |
| ------ | ------- |
| Férfi  | 20.3333 |
| Nő     | 18.2500 |

- Az `IF` első paramétere a logikai feltétel, amit az igaz, majd a hamis érték követ
- Az átlagban nem egyetlen oszlop szerepel, hanem a tanórák és a szakkörök összege

## Legidősebb (hibás, megengedő módban)

Hogy hívják a legidősebb tanárt?

```sql
SET sql_mode='';

SELECT `vezeteknev`, `keresztnev`, MAX(`kor`) AS `max_kor`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` | `max_kor` |
| ------------ | ------------ | --------- |
| Nagy         | Péter        | 46        |

- `GROUP BY` nélkül egyetlen sort ad vissza
- Szigorú mód kikapcsolva lefut, DE hibás eredményt hozhat

> [!WARNING]  
> - A legidősebb 46 éves, ez jó ✅ DE Nagy Péter valójában 43 éves ❌
> - A nevek közül vette az első rekord értékét, azért lett hibás az eredmény

## Legidősebb (hibás, szigorú módban)

Hogy hívják a legidősebb tanárt?

```sql
SET sql_mode='only_full_group_by';

SELECT `vezeteknev`, `keresztnev`, MAX(`kor`)
FROM `tanarok`;
```

> [!WARNING]  
> #1140 - In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'iskola.tanarok.vezeteknev'; this is incompatible with sql_mode=only_full_group_by

- Szigorú módot bekapcsolva hibát kapunk
- A hiba most jót jelent, mert nem ad hamis biztonságot a hibás értékkel

## Legidősebb (jó)

Hogy hívják a legidősebb tanárt?

```sql
SELECT `vezeteknev`, `keresztnev`
FROM `tanarok`
ORDER BY `kor` DESC
LIMIT 1;
```

| `vezeteknev` | `keresztnev` |
| ------------ | ------------ |
| Tóth         | Miklós       |

- Ha a feladat nem kéri, akkor nem kell lekérni a kort, attól még rendezhetünk
- A hibaüzenet `GROUP BY`-ra utal, de a megoldásban **nem szerepel**

## GROUP BY - Összetett példa

- Jelenítse meg, hobbinként átlagosan hány tanórát tartanak a tanárok?
- Azok ne jelenjenek meg, akik nem adtak meg hobbit.
- Az eredményt tanórák átlaga szerint növekvő sorrendben jelenítse meg!

```sql
SELECT 
    `hobbi`, 
    AVG(`tanora`) AS `atlagos_tanora`
FROM `tanarok`
WHERE `hobbi` IS NOT NULL
GROUP BY `hobbi`
ORDER BY `atlagos_tanora` ASC;
```

| `hobbi`      | `atlagos_tanora` |
| ------------ | ---------------- |
| kertészkedés | 14.0000          |
| fotózás      | 17.0000          |
| TEREPFUTÁS   | 20.0000          |
| futás        | 24.0000          |

## Gyakori hibák GROUP BY esetén

- #1140 - In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column
    - Nincs `GROUP BY`, de használunk összesítő függvényt

- #1055 - Expression of SELECT list is not in GROUP BY clause
    - Bár van `GROUP BY`, de tartalmaz olyan mezőt a `SELECT`, ami nincs összesítve és nem is szerepel a `GROUP BY` után

- Lehetséges megoldások:
    - Kell `GROUP BY`
    - Összesítő függvénybe kell tenni a problémás mezőt
    - Ki kell venni valamit a `SELECT`-ből
    - Lehetséges, hogy nem az alapján csoportosítottunk, amit megjelenítünk, így más alapján kell
