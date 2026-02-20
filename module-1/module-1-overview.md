# 1. modul - Adatok lekérdezése, szűrés, rendezés

## A modul témakörei

- MySQL, MariaDB, MS SQL/Access, Oracle
- Jelölések az SQL-ben
- SELECT felépítése
- Operátorok, precedencia
- És/vagy használata, összetett feltételek
- IN, BETWEEN
- Rendezés  
- Sorok limitálása 
- NULL értékek kezelése 


## Jelölések

- A MySQL aposztróffal jelöli a szöveget.

    ```sql
    'szöveg'
    ```
    - `shift` + `1` 
    


- Adatbázisok, táblák és mezőnevek jelölése.

    ```sql
    `tablanev`
    ```

    - `altgr` + `7`

- A MySQL eltér az ANSI szabványtól, ahol az azonosítókat idézőjelekkel jelölik.

---

## Értéktípusok



- Szöveg:

    ```sql
    'Nagy Lajos'
    ```


<v-click>

- Dátum, idő:

    ```sql
    '2018-12-01'
    '15:55:30'
    '2018-12-01 12:55:30'
    ```
    - A dátum/idő értékeket szövegként adjuk meg, `ÉÉÉÉ-HH-NN ÓÓ:PP:MM` formátumban

</v-click>
<v-click>

- Szám:

    ```sql
    10
    10.5
    ```
    - Számok esetében elhagyható az aposztróf
    - Tizedes vessző helyett **tizedes pontot** kell alkalmazni

</v-click>
---

## Megjegyzések

- Több soros megjegyzés

    ```sql
    /* több soros megjegyzés */
    ```
    - A C nyelv szintaxisát követi

<v-click>

- Egy soros megjegyzés

    ```sql
    # megjegyzés
    ```

    - MySQL-ben használható a nem szabványos `#` is

    ```sql
    -- megjegyzés
    ```

    - **A `--` után egy szóköznek kell állnia!**

</v-click>

<v-click>

- https://dev.mysql.com/doc/refman/9.6/en/ansi-diff-comments.html

</v-click>

## SELECT felépítése

```sql
SELECT `vezeteknev`, `keresztnev`
FROM `tanarok`
WHERE `nem` = 1
    AND `hobbi` = 'futás';
```

---

## Egyszerű SELECT: minden adat

Listázza ki a `tanarok` tábla összes adatát!

```sql
SELECT *
FROM `tanarok`;
```

<div class="text-sm">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`               | `hobbi`      | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------------- | ------------ | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika    | futás        | 24       | 1         |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia       | fotózás      | 22       | 2         |
| 3    | Tóth         | Gábor        | 1996-02-20  | 30    | 1     | Testnevelés/Biológia | -            | 12       | 0         |
| 4    | Szabó        | Eszter       | 1988-07-01  | 37    | 0     | Digitális kultúra    | kertészkedés | 14       | 2         |
| 5    | Tóth         | Miklós       | 1979-09-18  | 46    | 1     | -                    | -            | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan         | fotózás      | 12       | 0         |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia     | TEREPFUTÁS   | 20       | 1         |

</div>


--- 

## Egyszerű SELECT: megadott mezők lekérése

Listázza ki a tanárok vezeték- és keresztnevét!

```sql
SELECT `vezeteknev`, `keresztnev`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` |
| ------------ | ------------ |
| Nagy         | Péter        |
| Kovács       | Anna         |
| Tóth         | Gábor        |
| Szabó        | Eszter       |
| Tóth         | Miklós       |
| Nagy         | Anna         |
| Karácsony    | Mária        |


---
layout: two-cols-title
---

::title::

## Egyedi értékek


Listázza ki a tanárok keresztnevét! Ügyeljen rá, hogy **ne legyen benne ismétlődés**!

::left ::


```sql
SELECT `keresztnev`
FROM `tanarok`;
```

| `keresztnev` |
| ------------ |
| Péter        |
| Anna         |
| Gábor        |
| Eszter       |
| Miklós       |
| Anna         |
| Mária        |

- Anna többször is megjelenik ❌

::right::



```sql
SELECT DISTINCT `keresztnev`
FROM `tanarok`;
```

| `keresztnev` |
| ------------ |
| Péter        |
| Anna         |
| Gábor        |
| Eszter       |
| Miklós       |
| Mária        |

- Anna már csak egyszer szerepel ✅


---

## Egyedi értékek (folytatás)

Listázza ki a tanárok neveit, ügyeljen rá, hogy ne legyen benne ismétlődés!

```sql
SELECT DISTINCT `vezeteknev`, `keresztnev`
FROM `tanarok`;
```

| `vezeteknev` | `keresztnev` |
| ------------ | ------------ |
| Nagy         | Péter        |
| Kovács       | Anna         |
| Tóth         | Gábor        |
| Szabó        | Eszter       |
| Tóth         | Miklós       |
| Nagy         | Anna         |
| Karácsony    | Mária        |


- A `DISTINCT` a teljes sorra vonatkozik, nem csak a `vezeteknev`-re. 

## Összehasonlító operátorok
  | Operátor | Jelentés             |
  | :------: | -------------------- |
  |   `<`    | kisebb               |
  |   `>`    | nagyobb              |
  |   `<=`   | kisebb vagy egyenlő  |
  |   `>=`   | nagyobb vagy egyenlő |
  |   `=`    | egyenlő              |
  |   `<>`   | nem egyenlő          |

- `<>` az ANSI szabvány szerinti forma.
- A `!=` is használható, mint nem egyenlő operátor

---

## Logikai operátorok

  | Operátor | Jelentés |
  | :------: | -------- |
  |  `NOT`   | nem      |
  |  `AND`   | és       |
  |   `OR`   | vagy     |

  - Az operátorok precedencia szerint csökkenő sorrendben szerepelnek
  - A nem szabványos `&&` és `||` operátorok elavultnak számítanak, és kivezetésre fognak kerülni
  - https://dev.mysql.com/doc/refman/9.6/en/logical-operators.html

---

## Egyszerű feltétel I.

Jelenítse meg a női tanárok minden adatát!

```sql
SELECT *
FROM `tanarok`
WHERE `nem` = 0;
```

<div class="text-sm">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi`      | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------------ | -------- | --------- |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia    | fotózás      | 22       | 2         |
| 4    | Szabó        | Eszter       | 1988-07-01  | 37    | 0     | Digitális kultúra | kertészkedés | 14       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás      | 12       | 0         |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia  | TEREPFUTÁS   | 20       | 1         |

</div>

---

## Egyszerű feltétel II.

Jelenítse meg minden adatát azoknak, akik szeretnek fotózni!

```sql
SELECT *
FROM `tanarok`
WHERE `hobbi` = 'fotózás';
```

<div class="text-sm">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`         | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------- | ------- | -------- | --------- |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia | fotózás | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan   | fotózás | 12       | 0         |


</div>

---

## Egyszerű feltétel ÉS kapcsolattal

Jelenítse meg a *"Nagy"* vezetéknevű, 30 és 45 év közötti férfi tanárok vezeték- és keresztnevét, továbbá a korát is.

```sql
SELECT `vezeteknev`, `keresztnev`, `kor`
FROM `tanarok`
WHERE `vezeteknev` = 'Nagy'
    AND `kor` >= 30
    AND `kor` <= 45
    AND `nem` = 1;
```

| `vezeteknev` | `keresztnev` | `kor` |
| --- | --- | --- |
| Nagy | Péter | 43 |


---

## Szűrés intervallumra

Jelenítse meg a 30 és 45 év közötti tanárok `vezeteknev`, `keresztnev` és `kor` mezőit.

```sql
SELECT `vezeteknev`, `keresztnev`, `kor`
FROM `tanarok`
WHERE `kor` BETWEEN 30 AND 45;
```

| `vezeteknev` | `keresztnev` | `kor` |
| ------------ | ------------ | ----- |
| Nagy         | Péter        | 43    |
| Kovács       | Anna         | 40    |
| Tóth         | Gábor        | 30    |
| Szabó        | Eszter       | 37    |
| Nagy         | Anna         | 33    |
| Karácsony    | Mária        | 45    |


- A határok is beletartoznak, így a `30` és `45` éves tanárok is megjelennek a végeredményben

---

## És a hétköznapi nyelvben (hibás)

Jelenítse meg a *"Nagy"* és a *"Horváth"* vezetéknevű tanárokat!

```sql
SELECT *
FROM `tanarok`
WHERE `vezeteknev` = 'Nagy'
   AND `vezeteknev` = 'Horváth';
```

- A lekérdezés problémás, mert nem lehet egyszerre *"Nagy"* és *"Horváth"* is a vezetéknév!
- Hétköznapi értelemben a *"Nagy"* és a *"Horváth"* vezetéknevűeket **is** meg kell jeleníteni 

---

## És a hétköznapi nyelvben (jó)

Jelenítse meg a *"Nagy"* és a *"Horváth"* vezetéknevű tanárokat!

```sql
SELECT *
FROM `tanarok`
WHERE `vezeteknev` = 'Nagy'
   OR `vezeteknev` = 'Horváth';
```

<div class="text-sm">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás | 12       | 0         |

</div>
---

## VAGY (hibás használat)

Hogy hívják azokat a tanárokat, akik fotózni, illetve futni szeretnek?

```sql
SELECT *
FROM `tanarok`
WHERE `hobbi` = 'futás' 
    OR 'fotózás';
```

<div class="text-sm">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |

</div>


- Itt az `OR` bal oldalán logikai kifejezés áll, míg a jobb oldalon egyszerű szöveg található
- A *"fotózás"* szövegnek van logikai értéke: `true`
- A jobb oldal kiértékelve minden esetben igaz lesz

---

## VAGY (helyes használat)

Hogy hívják azokat a tanárokat, akik fotózni, illetve futni szeretnek?

```sql
SELECT *
FROM `tanarok`
WHERE `hobbi` = 'futás'
    OR `hobbi` = 'fotózás';
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia    | fotózás | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás | 12       | 0         |

</div>

- Az `OR` operátor mindkét oldalán logikai kifejezés álljon
- A mezőnevet így meg kell ismételni


---

## Az IN operátor

```sql
SELECT *
FROM `tanarok`
WHERE `hobbi` IN ('futás', 'fotózás');
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia    | fotózás | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás | 12       | 0         |

</div>

- Az `IN` operátor után zárójelben kell felsorolni a lehetséges értékeket
- Szám értékek esetében az aposztróf elhagyható

---

## Tagadás: Jegyek ellenőrzése (hibás)

Jelenítse meg a nem megfelelő értékkel felvitt jegyek minden adatát!

```sql
SELECT *
FROM `jegyek`
WHERE `jegy` >= 1 AND `jegy` <= 5;
```

- Ez megjeleníti a jó jegyeket

```sql
SELECT *
FROM `jegyek`
WHERE `jegy` < 1 AND `jegy` > 5;
```

- Kézzel tagadva könnyű hibázni
- Nem létezik olyan jegy, amire egyszerre igaz, hogy `<1` és az is, hogy `>5`

---

## Tagadás: Jegyek ellenőrzése (jó)

Jelenítse meg a nem megfelelő értékkel felvitt jegyek minden adatát!

```sql
SELECT *
FROM `jegyek`
WHERE NOT (1 < `jegy` AND `jegy` < 5);
```

- Ha tudjuk, hogy mi lesz megfelelő, akkor egyszerűen tagadjuk le!
- Zárójellel biztosítjuk a megfelelő műveleti sorrendet

```sql
SELECT *
FROM `jegyek`
WHERE `jegy` < 1 OR 5 < `jegy`;
```

- "Az a jegy hibás, ami `<1` **illetve** ami `>5`"
- A DeMorgan azonosság miatt a zárójel felbontásakor az `AND` helyett `OR` fog kelleni

---

## Összetett feltétel I. (hibás)

Jelenítse meg a *"Nagy"* vezetéknevű tanárok közül azokat, akik 40 és 45 év közöttiek, vagy a hobbijuk a *"fotózás"*.

```sql
SELECT *
FROM `tanarok`
WHERE `vezeteknev` = 'Nagy'
  AND `kor` >= 40
  AND `kor` <= 45
  OR `hobbi` = 'fotózás';
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia    | fotózás | 22       | 2         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás | 12       | 0         |

</div>

<v-click>

- Az `AND` logikai operátor előbb jön a műveleti sorrendben
- Mindenkit megjelenít, akinek a *fotózás* a hobbija, de zárójelezéssel javítható

</v-click>

---

## Összetett feltétel I. (jó)

Jelenítse meg a *"Nagy"* vezetéknevű tanárok közül azokat, akik 40 és 45 év közöttiek, vagy a hobbijuk a *"fotózás"*.

```sql
SELECT *
FROM `tanarok`
WHERE (`vezeteknev` = 'Nagy')
  AND (`kor` BETWEEN 40 AND 45 OR `hobbi` = 'fotózás');
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`            | `hobbi` | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | ----------------- | ------- | -------- | --------- |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika | futás   | 24       | 1         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan      | fotózás | 12       | 0         |

</div>

- A `BETWEEN` és az `IN` leegyszerűsíti az összetett feltételek írását, csökkenthetik a hibázási lehetőséget
- Itt az első zárójel valójában elhagyható

---
layout: two-cols-title
---

::title::


## Összetett feltétel II. 

Jelenítse meg a keresztnevét, nemét és hobbiját azoknak a férfi tanároknak, akik legalább 40 évesek, továbbá azoknak a női tanároknak, akik szeretnek kertészkedni illetve fotózni, vagy pedig Annának hívják.

::left::

```sql
SELECT `keresztnev`, `nem`, `hobbi`
FROM `tanarok`
WHERE 
      (`nem` = 1 AND `kor` >= 40)
   OR
      (`nem` = 0 AND 
          (
            `hobbi` = 'kertészkedés'
            OR `hobbi` = 'fotózás'
            OR `keresztnev` = 'Anna'
          )
      );
```

::right::

| `keresztnev` | `nem` | `hobbi`      |
| ------------ | ----- | ------------ |
| Péter        | 1     | futás        |
| Anna         | 0     | fotózás      |
| Eszter       | 0     | kertészkedés |
| Miklós       | 1     | -            |
| Anna         | 0     | fotózás      |


## Rendezés 1 mező szerint (növekvő sorrend)

Jelenítse meg a tanárok összes adatát `vezeteknev` szerint **növekvő** sorrendben.

```sql
SELECT *
FROM `tanarok`
ORDER BY `vezeteknev` ASC;
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak`               | `hobbi`      | `tanora` | `szakkor` |
| ---- | ------------ | ------------ | ----------- | ----- | ----- | -------------------- | ------------ | -------- | --------- |
| 7    | Karácsony    | Mária        | 1980-12-05  | 45    | 0     | Matematika/Kémia     | TEREPFUTÁS   | 20       | 1         |
| 2    | Kovács       | Anna         | 1986-11-03  | 40    | 0     | Angol/Biológia       | fotózás      | 22       | 2         |
| 1    | Nagy         | Péter        | 1982-04-12  | 43    | 1     | Matematika/Fizika    | futás        | 24       | 1         |
| 6    | Nagy         | Anna         | 1992-12-05  | 33    | 0     | Etika/Hittan         | fotózás      | 12       | 0         |
| 4    | Szabó        | Eszter       | 1988-07-01  | 37    | 0     | Digitális kultúra    | kertészkedés | 14       | 2         |
| 3    | Tóth         | Gábor        | 1996-02-20  | 30    | 1     | Testnevelés/Biológia | -            | 12       | 0         |
| 5    | Tóth         | Miklós       | 1979-09-18  | 46    | 1     | -                    | -            | 22       | 2         |

</div>


- `ASC` (**Asc**ending): Mivel ez alapértelmezett, így az `ASC` elhagyható

---

## Rendezés 1 mező szerint (csökkenő sorrend)

Jelenítse meg a tanárok összes adatát `vezeteknev` szerint **csökkenő** sorrendben.

```sql
SELECT *
FROM `tanarok`
ORDER BY `vezeteknev` DESC;
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak` | `hobbi` | `tanora` | `szakkor` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 3 | Tóth | Gábor | 1996-02-20 | 30 | 1 | Testnevelés/Biológia | - | 12 | 0 |
| 5 | Tóth | Miklós | 1979-09-18 | 46 | 1 | - | - | 22 | 2 |
| 4 | Szabó | Eszter | 1988-07-01 | 37 | 0 | Digitális kultúra | kertészkedés | 14 | 2 |
| 1 | Nagy | Péter | 1982-04-12 | 43 | 1 | Matematika/Fizika | futás | 24 | 1 |
| 6 | Nagy | Anna | 1992-12-05 | 33 | 0 | Etika/Hittan | fotózás | 12 | 0 |
| 2 | Kovács | Anna | 1986-11-03 | 40 | 0 | Angol/Biológia | fotózás | 22 | 2 |
| 7 | Karácsony | Mária | 1980-12-05 | 45 | 0 | Matematika/Kémia | TEREPFUTÁS | 20 | 1 |

</div>

- `DESC`: **Desc**ending

---
layout: two-cols-title
---

::title::

## Többszintű rendezés

Rendezze a tanárokat vezetéknév szerint növekvő sorrendbe, míg keresztnév szerint csökkenő sorrendbe!

```sql
SELECT `vezeteknev`, `keresztnev`
FROM `tanarok`
ORDER BY `vezeteknev` ASC, `keresztnev` DESC;
```

::left::

- Azonos vezetéknév esetén a másodlagos feltétel a keresztnév lesz
- Több rendezési irányt is megadhatunk, vesszővel elválasztva
- A rendezés irányát külön-külön kell meghatározni



::right::


<div class="text-sm my-4 w-100">

| `vezeteknev` | `keresztnev` |
| --- | --- |
| Karácsony | Mária |
| Kovács | Anna |
| Nagy | Péter |
| Nagy | Anna |
| Szabó | Eszter |
| Tóth | Miklós |
| Tóth | Gábor |

</div>


---
layout: two-cols-title
---

::title::

## Rendezés oszlopszám alapján

Jelenítse meg a tanárok `vezeteknev` és `kor` mezőit, majd rendezze az eredményt a második oszlop szerint csökkenő sorrendbe.

```sql
SELECT `vezeteknev`, `kor`
FROM `tanarok`
ORDER BY 2 DESC;
```

::left::

- Az oszlop neve helyett megadható a sorszáma
- Nem az eredeti táblában, hanem a `SELECT` részben meghatározott oszlopra vonatkozik

::right::

<div class="text-sm my-4 w-100">

| `vezeteknev` | `kor` |
| --- | --- |
| Tóth | 46 |
| Karácsony | 45 |
| Nagy | 43 |
| Kovács | 40 |
| Szabó | 37 |
| Nagy | 33 |
| Tóth | 30 |


</div>



---

## Első N eredmény (LIMIT)

Jelenítse meg a `tanarok` tábla első 3 rekordját.

```sql
SELECT *
FROM `tanarok`
LIMIT 3;
```

<div class="text-sm my-4">

| `id` | `vezeteknev` | `keresztnev` | `szuletett` | `kor` | `nem` | `szak` | `hobbi` | `tanora` | `szakkor` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Nagy | Péter | 1982-04-12 | 43 | 1 | Matematika/Fizika | futás | 24 | 1 |
| 2 | Kovács | Anna | 1986-11-03 | 40 | 0 | Angol/Biológia | fotózás | 22 | 2 |
| 3 | Tóth | Gábor | 1996-02-20 | 30 | 1 | Testnevelés/Biológia | - | 12 | 0 |

</div>

- Rendezés nélkül a sorrend nem garantálható

---

## TOP (Access)

Jelenítse meg a `tanarok` tábla első 3 rekordját.


```sql
SELECT TOP 3 *
FROM `tanarok`;
```

- Access-ben a `SELECT` elején `TOP N` szerepel a `LIMIT N` helyett

```sql
SELECT TOP 10 PERCENT *
FROM tanarok
ORDER BY kor DESC;
```

- A `TOP` kezeli a százalékot is

<br>  

<AdmonitionType type="warning" title="Figyelem!">

A `TOP` MySQL-ben **nem** használható!

</AdmonitionType>

---

## Legfiatalabb

**Feladat:** Listázza ki a legfiatalabb tanár vezeték- és keresztnevét, továbbá a korát.

```sql
SELECT `vezeteknev`, `keresztnev`, `kor`
FROM `tanarok`
ORDER BY `kor` ASC
LIMIT 1;
```

- Amennyiben több legfiatalabb is van, úgy csak az egyik fog megjelenni
- Kor alapján **növekvő** sorrendbe kell rendezni

```sql
SELECT `vezeteknev`, `keresztnev`, `kor`
FROM `tanarok`
ORDER BY `szuletett` DESC
LIMIT 1;
```

- Születési dátum alapján **csökkenő** sorrendbe kell rendezni

---
layout: two-cols-title
---

::title::

## Szűrés, rendezés és limit

Jelenítse meg a 40 év alatti tanárok vezeték- és keresztnevét, ABC sorrendben. Az eredményben legfeljebb három tanár jelenjen meg.

```sql
SELECT `vezeteknev`, `keresztnev`
FROM `tanarok`
WHERE `kor` < 40 
ORDER BY `vezeteknev`, `keresztnev`
LIMIT 3;
```

::left::

- A különböző záradékoknak (`SELECT`, `FROM`, `WHERE`, ...) a sorrendje kötött
- Alapértelmezés szerint növekvő sorrendbe rendezi az adatokat
- Azonos vezetéknevű tanárok esetében keresztnév szerint is növekvő sorrendben lesznek


::right::

| `vezeteknev` | `keresztnev` |
| ------------ | ------------ |
| Nagy         | Anna         |
| Szabó        | Eszter       |
| Tóth         | Gábor        |


## Mi az a NULL?

- A `NULL` azt jelzi, hogy az adat **hiányzik, ismeretlen** vagy **nem értelmezhető**

- Jelölhet a jövőben megállapítható adatot, például mikor hozták vissza a könyvet/autót, stb...

- **Nem nulla!** A `0` egy szám. Ha egy diák magassága `0`, az fizikai képtelenség, de ha `NULL`, az azt jelenti, hogy még nem ismert, vagy nem lett rögzítve
- **Nem üres szöveg!** Az `''` (üres string) egy létező adat, aminek a hossza nulla. A `NULL` ezzel szemben az adat teljes hiánya


---

## NULL vizsgálata: `IS NULL` és `IS NOT NULL`


```sql
SELECT * FROM `tanarok` WHERE `hobbi` = NULL;
```

- Mindig üres listát eredményez
- A `NULL` értéket **nem** lehet az egyenlőséggel (`=`) vizsgálni


```sql
SELECT * FROM `tanarok` WHERE `hobbi` IS NULL;
```

- Megjeleníti azokat a tanárokat, akiknek nincs hobbi megadva (például nem akart válaszolni)


```sql
SELECT * FROM `jegyek` 
WHERE `megjegyzes` IS NOT NULL;
```

- Megjeleníti azokat a jegyeket, ahol ki lett töltve a megjegyzés

---
layout: two-cols-title
---

::title::

## A COALESCE() függvény


```sql
SELECT 
    `vezeteknev`, 
    `keresztnev`, 
    COALESCE(`hobbi`, 'Nincs adat') AS `hobbi_szoveg`
FROM `tanarok`;
```

::left::

- A `COALESCE()` függvény végigmegy a megadott listán, és az első olyat adja vissza, ami nem `NULL` 
- Ahol nincs megadva a hobbi, azaz `NULL`, ott a *"Nincs adat"* szöveg fog megjelenni
- Ahol a hobbi helyett üres szöveg szerepel, ott továbbra is üres szöveg lesz

::right::

| `vezeteknev` | `keresztnev` | `hobbi_szoveg` |
| ------------ | ------------ | -------------- |
| Nagy         | Péter        | futás          |
| Kovács       | Anna         | fotózás        |
| Tóth         | Gábor        | Nincs adat     |
| Szabó        | Eszter       | kertészkedés   |
| Tóth         | Miklós       | Nincs adat     |
| Nagy         | Anna         | fotózás        |
| Karácsony    | Mária        | TEREPFUTÁS     |


---


## Logikai műveletek és a NULL (Háromértékű logika)

- `AND` (ÉS) művelet **csak akkor IGAZ**, ha minden oldal `TRUE`
    - **A HAMIS dominál:** Ha az egyik oldal `FALSE`, a végeredmény akkor is `FALSE` lesz, ha a másik oldal `NULL`. (Mivel az ÉS már semmiképp sem teljesülhet)
    - **NULL hatása:** Ha az egyik oldal `TRUE`, a másik `NULL`, az eredmény `NULL` marad
- `OR` (VAGY) művelet **akkor IGAZ**, ha legalább az egyik oldal `TRUE`
    - **Az IGAZ dominál:** Ha az egyik oldal `TRUE`, a végeredmény akkor is `TRUE` lesz, ha a másik oldal `NULL`. (Mivel a feltétel már teljesült)
    - **A HAMIS nem dominál:** Ha egy `FALSE` értéket `NULL`-lal párosítunk `OR` műveletben, az eredmény `NULL` lesz (mert nem tudjuk, az ismeretlen mögött mi van)
- `NOT` (TAGADÁS) művelet
    - A `NULL` állapot nem fordítható meg: `NOT NULL` **`NULL`**
    - Az ismeretlen ellentéte is ismeretlen marad

---

## A NULL hatása a műveletekre

- `NULL` értékkel végzett műveletek eredménye szinte mindig `NULL` lesz

- **Matematika:** `5 + NULL`
    - Mennyi 5 meg egy ismeretlen szám? Szintén ismeretlen, azaz `NULL` lesz
- **Összehasonlítás:** `5 = NULL`
    - Összehasonlítás során az eredmény `NULL` lesz, ha bármelyik oldalon `NULL` szerepel
