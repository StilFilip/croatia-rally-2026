# Croatia Rally 2026 – brzinski ispiti

## Opis

Skup sadrži podatke o brzinskim ispitima natjecanja Croatia Rally 2026. Svaki prolazak brzinskog ispita zaseban je zapis; Shakedown je uključen kao zaseban zapis. Podaci se čuvaju u PostgreSQL bazi, a CSV i JSON generiraju se automatiziranom Node.js skriptom.

Projekt uključuje i web-aplikaciju koja omogućuje pregled, pretraživanje i filtriranje podataka. Podaci se u tablici dohvaćaju iz PostgreSQL baze putem poslužiteljske aplikacije, bez ponovnog učitavanja stranice.

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
| `zupanija` | Županija početne lokacije brzinskog ispita |
| `power_stage` | Označava je li ispit Power Stage |
| `lokacija_starta` | ID, naziv i GPS koordinate starta |
| `lokacija_cilja` | ID, naziv i GPS koordinate cilja |
| `najbrzi_rezultat` | Najbrže vrijeme i posada; `null` ako rezultat nije evidentiran |

## Povezanost podataka

Jedan rally obuhvaća više brzinskih ispita. Svaki ispit povezan je s lokacijom starta i cilja. Ispit može imati najbrži rezultat, a rezultat je povezan s posadom (vozačem i suvozačem). JSON prikazuje povezane podatke ugniježđeno, a CSV ih prikazuje u zasebnim stupcima.

Atribut `zupanija` označava županiju u kojoj se nalazi početna lokacija brzinskog ispita. Ako ispit prolazi kroz više županija, evidentira se samo županija početne lokacije.

## Web-aplikacija

Web-aplikacija omogućuje ljudima pregled i pretraživanje skupa podataka te preuzimanje podataka u strojno čitljivim formatima.

- `public/index.html` – početna stranica s opisom skupa podataka, metapodacima i poveznicama za preuzimanje CSV i JSON datoteka.
- `public/datatable.html` – stranica s tabličnim prikazom podataka, obrascem za filtriranje i mogućnostima preuzimanja rezultata.
- `public/style.css` – stilovi web-aplikacije.
- `public/datatable.js` – dohvaćanje podataka, prikaz tablice, filtriranje i preuzimanje rezultata.
- `server.js` – poslužiteljska aplikacija izrađena pomoću Node.js i Express okvira. Povezuje se s PostgreSQL bazom i omogućuje dohvat podataka putem API-ja.

Podaci se u tablicu dohvaćaju asinkrono pomoću JavaScript funkcije `fetch()`, bez ponovnog učitavanja stranice.

### Filtriranje i preuzimanje

Korisnik može unijeti pojam za pretraživanje i odabrati atribut prema kojem želi filtrirati podatke. Zadana mogućnost pretražuje sve podržane atribute, a moguće je odabrati i pojedinačni atribut.

Brisanje filtra vraća prikaz svih zapisa. Trenutačno prikazani, odnosno filtrirani rezultati mogu se preuzeti u CSV ili JSON formatu.

## JSON Schema

Datoteka `schema.json` opisuje strukturu JSON skupa podataka i vrste vrijednosti pojedinih atributa. JSON podaci provjeravaju se prema definiranoj shemi pomoću biblioteka Ajv i ajv-formats.

Skripta `scripts/validate.js` provodi validaciju datoteke `data/brzinski_ispiti.json` i ispisuje rezultat provjere.

## Datoteke

- `data/brzinski_ispiti.csv` – tablični izvoz.
- `data/brzinski_ispiti.json` – ugniježđeni JSON izvoz.
- `schema.json` – JSON Schema za opis strukture podataka.
- `scripts/export.js` – automatizirana skripta za izvoz iz PostgreSQL-a.
- `scripts/validate.js` – skripta za validaciju JSON podataka.
- `server.js` – poslužiteljska aplikacija i API.
- `public/index.html` – početna stranica.
- `public/datatable.html` – stranica s tabličnim prikazom.
- `public/datatable.js` – funkcionalnosti tablice.
- `public/style.css` – stilovi stranica.
- `package.json` – Node.js ovisnosti i naredbe.
- `.env.example` – primjer konfiguracije veze s bazom.

## Pokretanje i korištenje

Za pokretanje projekta potrebno je imati instalirane Node.js i PostgreSQL.

1. Preuzeti ili klonirati repozitorij.
2. Pokrenuti `npm install` za instalaciju potrebnih paketa.
3. Kopirati `.env.example` u `.env` i upisati podatke za lokalnu PostgreSQL bazu.
4. Osigurati da je baza podataka `croatia_rally` kreirana i da sadrži potrebne tablice i podatke.
5. Pokrenuti `npm start` za pokretanje web-poslužitelja.
6. Otvoriti `http://localhost:3000` u pregledniku.

Za ponovno generiranje CSV i JSON datoteka iz baze pokrenuti:

`npm run export`

Za provjeru JSON datoteke prema JSON Schemi pokrenuti:

`node scripts/validate.js`

## Ograničenja

Skup prikazuje podatke unesene u pripadajuću bazu. `null` za najbrži rezultat znači da rezultat nije evidentiran. Skup nije nužno cjelovita službena arhiva svih podataka natjecanja.

Atribut `zupanija` temelji se na županiji početne lokacije brzinskog ispita, a ne na svim županijama kroz koje ispit eventualno prolazi.

## Licenca

Skup se objavljuje pod licencom Creative Commons Imenovanje 4.0 International (CC BY 4.0). Pri korištenju potrebno je navesti autora i izvor te poveznicu na licencu.
