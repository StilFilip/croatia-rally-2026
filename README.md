# Croatia Rally 2026 – brzinski ispiti

## Opis
Skup sadrži podatke o brzinskim ispitima natjecanja Croatia Rally 2026. Svaki prolazak brzinskog ispita zaseban je zapis; Shakedown je uključen kao zaseban zapis. Podaci se čuvaju u PostgreSQL bazi, a CSV i JSON generiraju se automatiziranom Node.js skriptom.

## Metapodaci

| Polje | Vrijednost |
|---|---|
| Naziv | Croatia Rally 2026 – brzinski ispiti |
| Autor | Filip Stilinović |
| Verzija skupa | 1.0.0 |
| Datum objave | 2026-11-01 |
| Jezik | Hrvatski |
| Tema | Sport, automobilizam, rally |
| Geografsko područje | Hrvatska |
| Vremensko razdoblje | 2026. |
| Formati | CSV, JSON |
| Izvorna baza | PostgreSQL |
| Licenca | Creative Commons Imenovanje 4.0 International (CC BY 4.0) |
| Učestalost ažuriranja | Jednokratni skup; izvoz se može ponovno generirati |
| Broj zapisa | 21 prema trenutačnom izvozu |

## Atributi

| Atribut | Opis |
|---|---|
| `id` | Jedinstveni identifikator brzinskog ispita |
| `rally` | Podaci o rallyju: ID, naziv, godina, datumi i lokacija |
| `oznaka` | Oznaka brzinskog ispita |
| `naziv` | Naziv brzinskog ispita |
| `prolazak` | Redni broj prolaska |
| `datum` | Datum održavanja |
| `vrijeme_starta` | Vrijeme starta |
| `duljina_km` | Duljina ispita u kilometrima |
| `podloga` | Vrsta podloge |
| `zupanija` | Županija |
| `power_stage` | Označava je li ispit Power Stage |
| `lokacija_starta` | ID, naziv i GPS koordinate starta |
| `lokacija_cilja` | ID, naziv i GPS koordinate cilja |
| `najbrzi_rezultat` | Najbrže vrijeme i posada; `null` ako rezultat nije evidentiran |

## Povezanost podataka
Jedan rally obuhvaća više brzinskih ispita. Svaki ispit povezan je s lokacijom starta i cilja. Ispit može imati najbrži rezultat, a rezultat je povezan s posadom (vozačem i suvozačem). JSON prikazuje povezane podatke ugniježđeno, a CSV ih prikazuje u zasebnim stupcima.

## Datoteke
- `data/brzinski_ispiti.csv` – tablični izvoz.
- `data/brzinski_ispiti.json` – ugniježđeni JSON izvoz.
- `scripts/export.js` – automatizirana skripta za izvoz iz PostgreSQL-a.
- `package.json` – Node.js ovisnosti i naredbe.
- `.env.example` – primjer konfiguracije veze s bazom.

## Ponovno generiranje
1. Instalirati Node.js.
2. Pokrenuti `npm install`.
3. Kopirati `.env.example` u `.env` i upisati podatke za lokalnu PostgreSQL bazu.
4. Pokrenuti `npm run export`.

Skripta dohvaća podatke iz baze i stvara CSV i JSON datoteke u mapi `data/`.

## Ograničenja
Skup prikazuje podatke unesene u pripadajuću bazu. `null` za najbrži rezultat znači da rezultat nije evidentiran. Skup nije nužno cjelovita službena arhiva svih podataka natjecanja.

## Licenca
Skup se objavljuje pod licencom Creative Commons Imenovanje 4.0 International (CC BY 4.0). Pri korištenju potrebno je navesti autora i izvor te poveznicu na licencu.
