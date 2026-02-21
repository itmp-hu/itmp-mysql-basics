# 3. modul - Workshop

A [db2.sql](./workshop-sources/db2.sql) fájl, (ami tartalmilag megegyezik az első modul fájljával) tartalmazza az `iskola` adatbázist, mely az alábbi táblákat tartalmazza. Az elsődleges kulcsokat `[PK]`-val jelöltük.

> [!WARNING]
> A már létező `diakok` tábla is módosult!


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


## `osztalyok` tábla

| Mező neve      | Típus             | Leírás                                 |
| -------------- | ----------------- | -------------------------------------- |
| `id`           | Egész szám [PK]   | Egyedi azonosító, elsődleges kulcs     |
| `nev`          | Szöveg (max. 10)  | Az osztály megnevezése (pl. 9.A, 12.B) |
| `terem`        | Szöveg (max. 20)  | Az osztályterem azonosítója            |
| `osztalyfonok` | Szöveg (max. 100) | Az osztályfőnök neve                   |


## `tantargyak` tábla

| Mező neve | Típus            | Leírás                                          |
| --------- | ---------------- | ----------------------------------------------- |
| `id`      | Egész szám [PK]  | Egyedi azonosító, elsődleges kulcs              |
| `nev`     | Szöveg (max. 50) | A tantárgy megnevezése (pl. Matematika, Fizika) |


## `diak_tantargy` tábla (Kapcsolótábla)


| Mező neve     | Típus           | Leírás                                                |
| ------------- | --------------- | ----------------------------------------------------- |
| `diak_id`     | Egész szám [FK] | Hivatkozás a diák azonosítójára (`diakok.id`)         |
| `tantargy_id` | Egész szám [FK] | Hivatkozás a tantárgy azonosítójára (`tantargyak.id`) |


## `jegyek` tábla

| Mező neve     | Típus           | Leírás                                                      |
| ------------- | --------------- | ----------------------------------------------------------- |
| `id`          | Egész szám [PK] | Egyedi azonosító, elsődleges kulcs                          |
| `diak_id`     | Egész szám [FK] | Hivatkozás a diákra, aki a jegyet kapta                     |
| `tanar_id`    | Egész szám [FK] | Hivatkozás a tanárra, aki a jegyet adta                     |
| `tantargy_id` | Egész szám [FK] | Hivatkozás a tantárgyra, amiből a jegyet adták              |
| `ertek`       | Egész szám      | Az érdemjegy értéke (1-5)                                   |
| `suly`        | Valós szám      | A jegy súlya (pl. 1.0 = 100%, 2.0 = témazáró)               |
| `rogzitve`    | Dátum és idő    | A jegy beírásának időpontja (alapértelmezett: aktuális idő) |

Az alábbi feladatokat az új `iskola` adatbázison kell megoldani.

1. Melyik diák melyik osztályba jár. A diák teljes neve egyetlen oszlopban jelenjen meg, továbbá ügyeljen rá, hogy az egy osztályba járó diákok egymás után jöjjenek. Az osztályon belül ABC sorrendben legyenek.
2. Ki az osztályfőnöke *"Kiss Anna"* nevű diáknak?
3. Hány diák tanterme a 101-es?
4. Kik azok a 180 centiméternél alacsonyabb diákok, akik tanulnak matematikát?
5. Hány jegyet naplózott *"Nagy Péter"*?
6. Jelenítse meg azon tanárok teljes nevét, és a beírt jegyek számát, akik legalább 15 jegyet beírtak már.
7. Határozza meg, hogy kinek hány jegyet írtak be 2026-ban.
8. Kik azok a diákok, akik kaptak már jegyet *"Angol nyelv"* tantárgyból és a saját termük a 200-as termek egyike.
9. Jelenítse meg, hogy az egyes diákok melyik tárgyból milyen súlyozott átlagot szereztek eddig? Az eredményben jelenjen meg az átlag, a tantárgy és a diák teljes neve. Az eredményt ABC sorrendben adja meg.

<details>
<summary>Tipp</summary>

Súlyozott átlag: `SUM(jegyek.ertek * jegyek.suly) / SUM(jegyek.suly)`

</details>

10. Hogy hívják azokat a diákokat, akik kaptak már legalább 10 jegyet? Kezdje a legtöbb jegyet megszerző diákkal. Azonosság esetén ABC sorrendben jelenítse meg az adatokat.

11. Jelenítse meg, hogy melyik tantárgyból milyen a legrosszabb, legjobb jegy, illetve az átlagot is, de csak akkor, ha az átlag eléri a `2.8`-at


12. Hány lány és hány fiú tanulja a *"Fizika"* tantárgyat? Az eredményben jelenjen meg a nem és a darabszám.

