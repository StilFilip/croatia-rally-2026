-- =========================================
-- 1. TABLICA: RALLY
-- Osnovni podaci o rallyju
-- =========================================

CREATE TABLE rally (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naziv VARCHAR(150) NOT NULL,
    godina INTEGER NOT NULL,
    datum_pocetka DATE NOT NULL,
    datum_zavrsetka DATE NOT NULL,
    lokacija VARCHAR(150),

    CONSTRAINT chk_rally_datumi
        CHECK (datum_zavrsetka >= datum_pocetka),

    CONSTRAINT uq_rally_naziv_godina
        UNIQUE (naziv, godina)
);


-- =========================================
-- 2. TABLICA: LOKACIJA
-- GPS koordinate starta i cilja
-- =========================================

CREATE TABLE lokacija (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naziv VARCHAR(150) NOT NULL,
    sirina DECIMAL(10,7) NOT NULL,
    duzina DECIMAL(10,7) NOT NULL,

    CONSTRAINT chk_lokacija_sirina
        CHECK (sirina BETWEEN -90 AND 90),

    CONSTRAINT chk_lokacija_duzina
        CHECK (duzina BETWEEN -180 AND 180)
);


-- =========================================
-- 3. TABLICA: POSADA
-- Vozač i suvozač
-- =========================================

CREATE TABLE posada (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vozac VARCHAR(100) NOT NULL,
    suvozac VARCHAR(100) NOT NULL,

    CONSTRAINT uq_posada
        UNIQUE (vozac, suvozac)
);


-- =========================================
-- 4. TABLICA: BRZINSKI ISPIT
-- Svaki pojedinačni prolazak je zaseban zapis
-- =========================================

CREATE TABLE brzinski_ispit (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    rally_id INTEGER NOT NULL,
    oznaka VARCHAR(20) NOT NULL,
    naziv VARCHAR(150) NOT NULL,
    prolazak INTEGER,

    datum DATE NOT NULL,
    vrijeme_starta TIME NOT NULL,
    duljina_km DECIMAL(6,2) NOT NULL,
    podloga VARCHAR(50) NOT NULL DEFAULT 'Asfalt',
    zupanija VARCHAR(100),
    power_stage BOOLEAN NOT NULL DEFAULT FALSE,

    start_lokacija_id INTEGER NOT NULL,
    cilj_lokacija_id INTEGER NOT NULL,

    CONSTRAINT fk_ispit_rally
        FOREIGN KEY (rally_id)
        REFERENCES rally(id),

    CONSTRAINT fk_ispit_start_lokacija
        FOREIGN KEY (start_lokacija_id)
        REFERENCES lokacija(id),

    CONSTRAINT fk_ispit_cilj_lokacija
        FOREIGN KEY (cilj_lokacija_id)
        REFERENCES lokacija(id),

    CONSTRAINT chk_ispit_prolazak
        CHECK (prolazak IS NULL OR prolazak >= 1),

    CONSTRAINT chk_ispit_duljina
        CHECK (duljina_km > 0),

    CONSTRAINT uq_ispit_oznaka
        UNIQUE (rally_id, oznaka),

    CONSTRAINT uq_ispit_prolazak
        UNIQUE (rally_id, naziv, prolazak)
);


-- =========================================
-- 5. TABLICA: NAJBRZI REZULTAT
-- Najbrže vrijeme i pripadajuća posada
-- =========================================

CREATE TABLE najbrzi_rezultat (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    brzinski_ispit_id INTEGER NOT NULL,
    posada_id INTEGER NOT NULL,
    vrijeme INTERVAL NOT NULL,

    CONSTRAINT fk_rezultat_ispit
        FOREIGN KEY (brzinski_ispit_id)
        REFERENCES brzinski_ispit(id),

    CONSTRAINT fk_rezultat_posada
        FOREIGN KEY (posada_id)
        REFERENCES posada(id),

    CONSTRAINT uq_rezultat_ispit
        UNIQUE (brzinski_ispit_id),

    CONSTRAINT chk_rezultat_vrijeme
        CHECK (vrijeme > INTERVAL '0')
);
