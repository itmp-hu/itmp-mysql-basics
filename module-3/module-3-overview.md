# 3. modul - Overview

## A modul témakörei

- Feltételek csoportokra: HAVING
- DESCARTES szorzat
- INNER JOIN 

## HAVING

- A `WHERE` feltételben **nem használhatók** a csoportosító függvények, mert
    - a csoportosítás előtt szűr
    - az eredeti tábla értékeit használhatjuk szűrésre
- A `HAVING` záradékkal a csoportosított részeredményekre vonatkozó feltételeket adhatunk meg
    - a csoportosítás után szűr
    - csak `GROUP BY`-ban lévő mezőre, vagy összesítő függvény eredményére szűrhetünk vele
- Ha mindkét helyen szűrhetünk, akkor a `WHERE` a javasolt

---

## Szűrés számított mezőre
- Melyik hobbit hány tanár jelölte meg?
- Csak azok a sorok jelenjenek meg, amelyeket több mint 1 tanár szeret

```sql
SELECT `hobbi`, COUNT(`id`) AS `fo`
FROM `tanarok`
WHERE `hobbi` IS NOT NULL
GROUP BY `hobbi`
HAVING `fo` > 1;
```

---
layout: two-cols-title
---

::title::

## Matematika szakos tanárok

Adja meg szakonként hány tanár van, de csak a legalább részben matematika szakos tanárokat vegye figyelembe

::left::
```sql
SELECT `szak`, COUNT(*) AS `fo`
FROM `tanarok`
GROUP BY `szak`
HAVING `szak` LIKE '%matematika%';
```

<div class="my-4">

| `szak`            | `fo` |
| ----------------- | ---- |
| Matematika/Fizika | 1    |
| Matematika/Kémia  | 1    |

- Működik, de fölöslegesen hozott létre csoportokat, majd utána szűrt ⚠️

</div>

::right::

```sql
SELECT `szak`, COUNT(*) AS `fo`
FROM `tanarok`
WHERE `szak` LIKE '%matematika%'
GROUP BY `szak`;
```

<div class="my-4">

| `szak`            | `fo` |
| ----------------- | ---- |
| Matematika/Fizika | 1    |
| Matematika/Kémia  | 1    |

</div>

- Ha lehet, akkor szűrjünk előre! ✅



---
layout: two-cols-title
---

::title::

## Szakok és tanárok 45 év alatt

Adja meg szakonként hány 45 év alatti tanár van.

::left::

```sql
SELECT `szak`, COUNT(*) AS `fo`
FROM `tanarok`
GROUP BY `szak`
HAVING `kor` < 45;
```


<div class="my-4">

<AdmonitionType type="caution" title="Hiba!">

- Error: Unknown column 'kor' in 'having clause'

- A `kor` a csoportosítás után nem hivatkozható!

</AdmonitionType>


</div>


::right::

```sql
SELECT `szak`, COUNT(*) AS `fo`
FROM `tanarok`
WHERE `kor` < 45
GROUP BY `szak`;
```


| `szak`               | `fo` |
| -------------------- | ---- |
| Matematika/Fizika    | 1    |
| Angol/Biológia       | 1    |
| Testnevelés/Biológia | 1    |
| Digitális kultúra    | 1    |
| Etika/Hittan         | 1    |



# Adatbázis terv

<img src="../assets/img/db2-diagram.png" style="width: 75%">

---
layout: two-cols-title
---

::title::

##  Descartes-szorzat


Vegyük az alábbi adatokat:

::left::

**diakok (részlet)**
| id  | vezeteknev | keresztnev | osztaly_id |
| :-- | :--------- | :--------- | :--------- |
| 1   | Kiss       | Anna       | 1          |
| 2   | Szabó      | Bence      | 1          |
| 3   | Varga      | Dóra       | 5          |

::right::

**osztalyok (részlet)**
| id  | nev  | terem      |
| :-- | :--- | :--------- |
| 1   | 9.A  | 101. terem |
| 5   | 10.B | 202. terem |

---

## Descartes-szorzat eredménye

Vegyük a két tábla Descartes-szorzatát

```sql
SELECT `d`.`id`, `d`.`vezeteknev`, `d`.`keresztnev`, `d`.`osztaly_id`,
       `o`.`id`, `o`.`nev`, `o`.`terem`
FROM `diakok` AS `d`, `osztalyok` AS `o`
```

<div class="my-4">

| `id`  | `vezeteknev` | `keresztnev` | `osztaly_id` | `id` | `nev` | `terem`    |     |
| ----- | ------------ | ------------ | ------------ | ---- | ----- | ---------- | --- |
| **1** | **Kiss**     | **Anna**     | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **1** | **Kiss**     | **Anna**     | **1**        | 5    | 10.B  | 202. terem | ❌  |
| **2** | **Szabó**    | **Bence**    | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **2** | **Szabó**    | **Bence**    | **1**        | 5    | 10.B  | 202. terem | ❌  |
| **3** | **Varga**    | **Dóra**     | **5**        | 1    | 9.A   | 101. terem | ❌  |
| **3** | **Varga**    | **Dóra**     | **5**        | 5    | 10.B  | 202. terem | ✅  |

</div>

- Tartalmaz olyan sorokat, amelyek nem felelnek meg a valóságnak

---

## Descartes-szorzat eredmény

Ki, melyik osztályba jár?

```sql
SELECT `d`.`id`, `d`.`vezeteknev`, `d`.`keresztnev`, `d`.`osztaly_id`,
       `o`.`id`, `o`.`nev`, `o`.`terem`
FROM `diakok` AS `d`, `osztalyok` AS `o`
WHERE `d`.`osztaly_id` = `o`.`id`;
```

<div class="my-4">

| `id`  | `vezeteknev` | `keresztnev` | `osztaly_id` | `id` | `nev` | `terem`    |     |
| ----- | ------------ | ------------ | ------------ | ---- | ----- | ---------- | --- |
| **1** | **Kiss**     | **Anna**     | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **2** | **Szabó**    | **Bence**    | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **3** | **Varga**    | **Dóra**     | **5**        | 5    | 10.B  | 202. terem | ✅  |

</div>

- A `WHERE` záradékkal lehet szűrni

---

## Descartes-szorzat feltétellel (hibás)

Melyik osztályba jár Anna és Dóra?
```sql
SELECT `d`.`id`, `d`.`vezeteknev`, `d`.`keresztnev`, `d`.`osztaly_id`,
       `o`.`id`, `o`.`nev`, `o`.`terem`
FROM `diakok` AS `d`, `osztalyok` AS `o`
WHERE `d`.`osztaly_id` = `o`.`id`
AND `d`.`keresztnev` = 'Anna' OR `d`.`keresztnev` = 'Dóra';
```

<div class="my-4">

| `id`  | `vezeteknev` | `keresztnev` | `osztaly_id` | `id` | `nev` | `terem`    |     |
| ----- | ------------ | ------------ | ------------ | ---- | ----- | ---------- | --- |
| **1** | **Kiss**     | **Anna**     | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **2** | **Szabó**    | **Bence**    | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **3** | **Varga**    | **Dóra**     | **5**        | 1    | 9.A   | 101. terem | ❌  |
| **3** | **Varga**    | **Dóra**     | **5**        | 5    | 10.B  | 202. terem | ✅  |

</div>

- Ha nincs jól zárójelezve, akkor összekeveredik az összekapcsolás feltétele és a tényleges szűrés
- Anna esetében jól szűr, de Dóra mellett hibás sorok is megjelennek

---

## INNER JOIN (2 tábla)

Ki, melyik osztályba jár?

```sql
SELECT `d`.`id`, `d`.`vezeteknev`, `d`.`keresztnev`, `d`.`osztaly_id`,
       `o`.`id`, `o`.`nev`, `o`.`terem`
FROM `diakok` AS `d`
    INNER JOIN `osztalyok` AS `o`
        ON `d`.`osztaly_id` = `o`.`id`;
```

<div class="my-4">

| `id`  | `vezeteknev` | `keresztnev` | `osztaly_id` | `id` | `nev` | `terem`    |     |
| ----- | ------------ | ------------ | ------------ | ---- | ----- | ---------- | --- |
| **1** | **Kiss**     | **Anna**     | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **2** | **Szabó**    | **Bence**    | **1**        | 1    | 9.A   | 101. terem | ✅  |
| **3** | **Varga**    | **Dóra**     | **5**        | 5    | 10.B  | 202. terem | ✅  |

</div>

- Az `INNER JOIN` csak azt jeleníti meg, amihez kapcsolódik valami a másik táblában
- Az `ON` záradékban a `WHERE`-hez hasonlóan logikai kifejezésnek kell szerepelnie
- Az *"ANSI-92"* szabványában már létezett


---

## INNER JOIN (több tábla)

Melyik tanuló mit tanul?

```sql
SELECT
    CONCAT_WS(' ',`d`.`vezeteknev`, `d`.`keresztnev`) AS `teljes_nev`,
    `t`.`nev`
FROM `diakok` AS `d`
    INNER JOIN `diak_tantargy` AS `dt`
        ON `d`.`id` = `dt`.`diak_id`
    INNER JOIN `tantargyak` AS `t`
        ON `dt`.`tantargy_id` = `t`.`id`;
```

---

# Mire kell figyelni?

- Az idegen kulcsot a megfelelő elsődleges kulccsal kell összekötni.
    - Általában az `id`-t nem az `id`-val kell összekötni
- Ne kapcsoljunk össze olyan táblát, ami nem szükséges feltétlenül
    - Lassítja a lekérdezést
    - Hibás eredményt is adhat
- Azonos mezőnevek problémát okozhatnak
- Az összekapcsolás sorrendje nem számít, de `SELECT *` esetén a sorrendet befolyásolja
- Több tábla esetén sose hagyjuk ki az összekötő táblákat


---

## Gyakori hibák: Az ID összekötése ID-val

```sql
SELECT `diakok`.`vezeteknev`, `diakok`.`keresztnev`, `osztalyok`.`nev`
FROM `diakok`
    INNER JOIN `osztalyok`
        ON `diakok`.`id` = `osztalyok`.`id`;
```


- A diák sorszámát az osztály sorszámával köti össze, nem pedig azzal az osztállyal, ahová a diák ténylegesen jár. ❌


```sql
SELECT `diakok`.`vezeteknev`, `diakok`.`keresztnev`, `osztalyok`.`nev`
FROM `diakok`
    INNER JOIN `osztalyok`
        ON `diakok`.`osztaly_id` = `osztalyok`.`id`;
```

- Az ábra szerint összekötve jó eredményt kapunk ✅


---

## Gyakori hibák: Szükségtelen táblák összekapcsolása

```sql
SELECT COUNT(*) AS `tanarok_szama`
FROM `tanarok`
    INNER JOIN `jegyek`
        ON `tanarok`.`id` = `jegyek`.`tanar_id`;
```

- Ahhoz, hogy megmondjuk hány tanár van az iskolában szükségtelen a `jegyek` tábla
- Minden egyes beírt jegyet egy különálló tanárnak számítja ❌

```sql
SELECT COUNT(*) AS `tanarok_szama` FROM `tanarok`;
```

- Itt csak 1 tábla szükséges ✅

---

## Gyakori hibák: Köztes táblák kihagyása

```sql
SELECT `diakok`.`vezeteknev`, `tantargyak`.`nev`
FROM `diakok`, `tantargyak`;
```

-  Mivel is kell összekötni mit? ❌

```sql
SELECT `diakok`.`vezeteknev`, `tantargyak`.`nev`
FROM `diakok`
    INNER JOIN `diak_tantargy`
        ON `diakok`.`id` = `diak_tantargy`.`diak_id`
    INNER JOIN `tantargyak`
        ON `diak_tantargy`.`tantargy_id` = `tantargyak`.`id`;
```

- Végig kell vezetni az ábrát az egyik táblából a másikba ✅


---

## Gyakori hibák: Azonos mezőnevek

```sql
SELECT `id`, `nev`, `vezeteknev`
FROM `diakok`
INNER JOIN `osztalyok` ON `osztaly_id` = `id`;
```

- Az `id` mező mindkét táblában létezik. ❌
- A MySQL nem tudja, hogy a diák azonosítóját vagy az osztály azonosítóját kéred-e
- Hasonló lenne a helyzet a `tanar.vezeteknev` és `diak.vezeteknev` ütközésekor


```sql
SELECT `diakok`.`id`, `diakok`.`vezeteknev`, `osztalyok`.`nev`
FROM `diakok`
INNER JOIN `osztalyok` ON `diakok`.`osztaly_id` = `osztalyok`.`id`;
```

-  Megoldás lehet, ha a tábla neve is szerepel a `SELECT`-ben, vagy ahol gondot okoz ✅
- `SELECT *` esetén lefut, de két `id` oszlopot kaphatunk

---

## Komplex példa

Határozza meg osztályonként a Matematika átlagát.
Az eredményt két tizedesre kerekítse. Kezdje a legerősebb osztállyal.


```sql
SELECT 
    `osztalyok`.`nev` AS `Osztály`, 
    ROUND(AVG(`jegyek`.`ertek`),2) AS `MatematikaAtlag`
FROM `osztalyok`
    INNER JOIN `diakok`
        ON `osztalyok`.`id` = `diakok`.`osztaly_id`
    INNER JOIN `jegyek`
        ON `diakok`.`id` = `jegyek`.`diak_id`
    INNER JOIN `tantargyak`
        ON `jegyek`.`tantargy_id` = `tantargyak`.`id`
WHERE `tantargyak`.`nev` = 'Matematika'
GROUP BY `osztalyok`.`nev`
ORDER BY `MatematikaAtlag` DESC;
```