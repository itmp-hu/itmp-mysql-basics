# 1. modul - Workshop

A [db1.sql](./workshop-sources/db1.sql) fájl tartalmazza az `iskola` adatbázist, mely az alábbi táblákat tartalmazza. Az elsődleges kulcsokat `[PK]`-val jelöltük

## `tanarok` tábla

| Mező neve    | Típus             | Leírás                             |
| ------------ | ----------------- | ---------------------------------- |
| `id`         | Egész szám [PK]   | Egyedi azonosító, elsődleges kulcs |
| `vezeteknev` | Szöveg (max. 50)  | Tanár vezetékneve                  |
| `keresztnev` | Szöveg (max. 50)  | Tanár keresztneve                  |
| `szuletett`  | Dátum             | Születési dátum                    |
| `kor`        | Egész szám        | Életkor (év)                       |
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

## Megválaszolandó kérdések

Válaszoljon az alábbi kérdésekre az `iskola` adatbázis `diakok` táblája alapján.

Az alábbi feladatokat az iskola adatbázison kell megoldani.

1. Jelenítse meg a `diakok` tábla összes adatát.
1. Jelenítse meg minden tanuló vezeték- és keresztnevét.
1. Jelenítse meg a fiúk minden adatát.
1. Hogy hívják azt a diákot, aki 2009 március 21-én született?
1. Jelenítse meg a lányok vezeték- és keresztneveit, és a magasságukat is. Az eredményt névsorban jelenítse meg!
1. Milyen keresztnevű diákok járnak az iskolába?
1. A 10 legjobb tanuló jutalomkiránduláson vehet részt. Kik mehetnek? Az eredményben jelenjen meg a vezetéknevük, keresztnevük, az osztályuk és az átlaguk is.
1. Jelenítse meg a vezeték- és keresztnevét, továbbá magasságát is azoknak a tanulóknak, akik nem érték el a 185 cm magasságot.
1. Kik azok, és melyik osztályba járnak, akik legalább 160 cm, de legfeljebb 180 cm magasak? Az eredményt magasság szerint növekvő sorrendben jelenítse meg.
1. Hogy hívják azokat, akik *"Kiss"*, *"Nagy"*, vagy *"Balogh"* vezetéknevűek, legalább 162 cm magasak.
1. Jelenítse meg a *"9.a"*, *"9.b"* és *"9.c"* osztályokba járó lányokat, akik legalább 4-es átlagot értek el, és magasabbak, mint 160 cm.
1. Hogy hívják a legfiatalabb diákot és melyik osztályba jár?
1. Milyen korú diákok járnak az iskolába? Az eredményben csak a kor oszlop jelenjen meg, de ne legyenek ismétlődések! Kezdje a legidősebb diák korával!
1. Ki az, aki nem adta meg az e-mail címét?
1. Jelenítse meg a diákok vezeték- és keresztnevét, születési dátumát és az e-mail címét. Amennyiben nincs kiöltve az e-mail, úgy az *"Ismeretlen"* szöveg jelenjen meg. Kezdje a legfiatalabbal. Azonos korok esetén ABC sorrendben jelenjenek meg.