# 2. modul - Workshop

A [db1.sql](./workshop-sources/db1.sql) fájl, (ami tartalmilag megegyezik az első modul fájljával) tartalmazza az `iskola` adatbázist, mely az alábbi táblákat tartalmazza. Az elsődleges kulcsokat `[PK]`-val jelöltük.

## `tanarok` tábla

| Mező neve    | Típus             | Leírás                             |
| ------------ | ----------------- | ---------------------------------- |
| `id`         | Egész szám [PK]   | Egyedi azonosító, elsődleges kulcs |
| `vezeteknev` | Szöveg (max. 50)  | Tanár vezetékneve                  |
| `keresztnev` | Szöveg (max. 50)  | Tanár keresztneve                  |
| `szuletett`  | Dátum             | Születési dátum                    |
| `kor`        | Egész szám        | Életkor (évben)                    |
| `nem`        | Logikai           | A tanár neme: 0 = nő, 1 = férfi    |
| `szak`       | Szöveg (max. 20)  | Szakok megnevezése                 |
| `hobbi`      | Szöveg (max. 100) | Hobbi megnevezése                  |
| `tanora`     | Egész szám        | Heti tanórák száma                 |
| `szakkor`    | Egész szám        | Szakkörök száma                    |

## `diakok` tábla

| Mező neve     | Típus             | Leírás                             |
| ------------- | ----------------- | ---------------------------------- |
| `id`          | Egész szám [PK]   | Egyedi azonosító, elsődleges kulcs |
| `vezeteknev`  | Szöveg (max. 50)  | Diák vezetékneve                   |
| `keresztnev`  | Szöveg (max. 50)  | Diák keresztneve                   |
| `nem`         | Logikai           | A diák neme: 0 = nő, 1 = férfi     |
| `osztaly`     | Szöveg (max. 10)  | Osztály (pl. 9.A, 10.B)            |
| `szuletett`   | Dátum             | Születési dátum                    |
| `kor`         | Egész szám        | Életkor (évben)                    |
| `email`       | Szöveg (max. 120) | E-mail cím                         |
| `magassag_cm` | Egész szám        | Magasság centiméterben             |
| `atlag`       | Valós szám        | Tanulmányi átlag                   |
| `irsz`        | Egész szám        | Irányítószám                       |
| `lakcim`      | Szöveg (max. 100) | Lakcím                             |

## LIKE

1. Jelenítse meg a budapesti diákok összes adatát.
<details>
<summary>Tipp</summary>

A `lakcim` mező elején áll a város neve.

</details>


2. Jelenítse meg a 11-es diákok teljes nevét, és születési évüket. Kezdje a legmagasabb diákkal.
3. Mely diákok használják a *"Gmail"*-t, mint levelező szolgáltatót? Az eredményben jelenjen meg a teljes nevük ABC sorrendben, illetve a használt e-mail címük is.

## Számított mezők

4. Jelenítse meg, hogy melyik diáknak hány éve van még a nagykorúságig. Akik már betöltötték 18 életévüket ne jelenítse meg az eredményben!
5. A 3.5-ös átlagnál jobb átlaggal rendelkező diákok könyvjutalmat kapnak. "jegyenként" 3 000 Ft-ot, azaz az átlagukat felfelé kerekítve kell venni, majd beszorozni 3 000 Ft-tal. Az eredményben jelenjen meg a diákok vezeték- és keresztneve, az átlaga és a jutalom összege is.

## Szövegfüggvények
6. Jelenítse meg a diákok teljes nevét egyetlen oszlopban úgy, hogy a vezetéknév csupa nagybetűs legyen.

<details>
<summary>Tipp</summary>

Az `UPPER` és `LOWER` függvények teszik kis- és nagybetűssé a szövegeket.

</details>

7. Jelenítse meg a diákok teljes nevét és magasságát méterben úgy, hogy a mértékegység is szerepeljen! Az eredményt 2 tizedesre kerekítse és rendezze magasság szerint növekvő sorrendbe!

<details>
<summary>Tipp</summary>

Az összefűzés után már szövegként rendezi a magasságot (méterben)!

</details>

8. Hogy hívják azt a diákot, akinek a leghosszabb a neve, továbbá hány karakterből áll? Amennyiben több diáknak is ugyanolyan hosszú a neve, úgy elegendő egyet megjelenítenie.

<details>
<summary>Tipp</summary>

A `LENGTH()` nem kezeli jól az multibyte karaktereket, helyette itt a `CHAR_LENGTH()`.

</details>

9. Jelenítse meg a diákok teljes nevét és azt, hogy melyik városban laknak.

<details>
<summary>Tipp</summary>

Keresni az `INSTR()` függvénnyel lehet, míg a bal oldali szöveget a `LEFT()` adja vissza.

</details>

10. Jelenítse meg, hogy milyen e-mail cím szolgáltatót választottak a diákok. Ügyeljen rá, hogy ne legyenek ismétlődések! Az eredményt ABC sorrendben jelenítse meg!

<details>
<summary>Tipp</summary>

Keresni az `INSTR()` függvénnyel lehet. Ha megvan honnantól szeretnénk kivágni szöveget, akkor már csak azt kell megmondani, hogy hány karakternyi kell, végül a `SUBSTRING()` kimetszi a szükséges szövegrészt.

</details>

11. Jelenítse meg a születési dátumot úgy, hogy a kötőjelek helyett pont legyen az elválasztó karakter.

<details>
<summary>Tipp</summary>

A `REPLACE()` szövegfüggvény a dátumokra is alkalmazható

</details>

## Dátum függvények
12. Jelenítse meg a 2009-ben született diákok összes adatát, kezdje a legidősebbel!
13. Hogy hívják azokat a diákokat, akiknek iskolakezdésre, azaz szeptemberre esik a születésnapjuk?

## Összesítő függvények

14. Összesen hány diák jár az iskolába az adatbázis szerint?
15. Hány 11-es diák van az adatbázis szerint?
16. Hány centi a legmagasabb tanuló?
17. Hogy hívják a legalacsonyabb tanulót? Ha több legalacsonyabb is van, akkor elegendő egy diák nevét megadni.
18. Átlagosan milyen magasak a 9. osztályos tanulók?

## GROUP BY

19. Határozza meg osztályonként, hogy átlagosan milyen átlaggal rendelkeznek a benne tanuló diákok. Az átlagot 2 tizedesre kerekítse!
20. Határozza meg osztályonként a legmagasabb diák magasságát. Az eredményt kezdje a magasság bajnokával.
21. Határozza meg, hogy az év melyik hónapjában hány diák született. Az eredményt a hónapok sorrendjében jelenítse meg.
22. Igaz-e, hogy a 11.B osztály tanulói átlagosan jobb eredményt érnek el, mint a 11.A osztály tanulói? Ennek megállapítására készítsen egy olyan lekérdezést, ami megjeleníti mindkét osztály tanulóinak átlagát, kezdje az erősebb átlaggal rendelkező osztállyal.

<details>
<summary>Tipp</summary>

A feladat jól definiál két csoportot, szükség lehet a `GROUP BY`-ra.

</details>

23. Évfolyamonként jelenítse meg hány méter magas tornyot tudnának képezni az évfolyam diákjai, ha egymáson állnának. Az eredményt 2 tizedesjegyre kerekítse!

<details>
<summary>Tipp</summary>

- Tegyük fel, hogy mindenki a másik fején áll.
- A feladatban más a mértékegység, mint az adatbázisban eltárolt
- A csoportosítást nem az osztály szerint, hanem évfolyam szerint kell
- A `SUBSTRING()` szöveget ad vissza, így rendezéskor a kapott szám értékeket tényleges számmá kell alakítani: `*1`

</details>