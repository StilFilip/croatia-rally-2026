-- =========================================
-- 02d_UNOS_BRZINSKIH_ISPITA.SQL
-- Croatia Rally 2026
-- Izvor rasporeda: sluzbeni WRC itinerer
-- =========================================

INSERT INTO brzinski_ispit (
    rally_id,
    oznaka,
    naziv,
    prolazak,
    datum,
    vrijeme_starta,
    duljina_km,
    podloga,
    zupanija,
    power_stage,
    start_lokacija_id,
    cilj_lokacija_id
)
SELECT
    r.id,
    v.oznaka,
    v.naziv,
    v.prolazak,
    v.datum,
    v.vrijeme_starta,
    v.duljina_km,
    'Asfalt',
    NULL,
    v.power_stage,
    ls.id,
    lc.id
FROM (
    VALUES
    ('SD', 'Shakedown', NULL::INTEGER, DATE '2026-04-09', TIME '10:01', 3.44, FALSE, 'Shakedown - Start', 'Shakedown - Finish'),

    ('SS1', 'Vodice - Brest', 1, DATE '2026-04-10', TIME '09:13', 14.12, FALSE, 'SS 1/5 - Start', 'SS 1/5 - Finish'),
    ('SS2', 'Lake Butoniga - Motovun', 1, DATE '2026-04-10', TIME '10:11', 13.78, FALSE, 'SS 2/6 - Start', 'SS 2/6 - Finish'),
    ('SS3', 'Beram - Cerovlje', 1, DATE '2026-04-10', TIME '11:14', 23.78, FALSE, 'SS 3/7 - Start', 'SS 3/7 - Finish'),
    ('SS4', 'Ucka', 1, DATE '2026-04-10', TIME '12:02', 11.75, FALSE, 'SS 4/8 - Start', 'SS 4/8 - Finish'),

    ('SS5', 'Vodice - Brest', 2, DATE '2026-04-10', TIME '15:15', 14.12, FALSE, 'SS 1/5 - Start', 'SS 1/5 - Finish'),
    ('SS6', 'Lake Butoniga - Motovun', 2, DATE '2026-04-10', TIME '16:13', 13.78, FALSE, 'SS 2/6 - Start', 'SS 2/6 - Finish'),
    ('SS7', 'Beram - Cerovlje', 2, DATE '2026-04-10', TIME '17:16', 23.78, FALSE, 'SS 3/7 - Start', 'SS 3/7 - Finish'),
    ('SS8', 'Ucka', 2, DATE '2026-04-10', TIME '18:04', 11.75, FALSE, 'SS 4/8 - Start', 'SS 4/8 - Finish'),

    ('SS9', 'Platak', 1, DATE '2026-04-11', TIME '08:43', 16.26, FALSE, 'SS 9/16 - Start', 'SS 9/16 - Finish'),
    ('SS10', 'Ravna Gora - Skrad', 1, DATE '2026-04-11', TIME '09:41', 10.13, FALSE, 'SS 10/15 - Start', 'SS 10/15 - Finish'),
    ('SS11', 'Generalski Stol - Zdihovo', 1, DATE '2026-04-11', TIME '11:05', 22.48, FALSE, 'SS 11/14 - Start', 'SS 11/14 - Finish'),
    ('SS12', 'Pecurkovo Brdo - Mreznicki Novaki', 1, DATE '2026-04-11', TIME '12:03', 9.11, FALSE, 'SS 12/13 - Start', 'SS 12/13 - Finish'),

    ('SS13', 'Pecurkovo Brdo - Mreznicki Novaki', 2, DATE '2026-04-11', TIME '14:12', 9.11, FALSE, 'SS 12/13 - Start', 'SS 12/13 - Finish'),
    ('SS14', 'Generalski Stol - Zdihovo', 2, DATE '2026-04-11', TIME '15:05', 22.48, FALSE, 'SS 11/14 - Start', 'SS 11/14 - Finish'),
    ('SS15', 'Ravna Gora - Skrad', 2, DATE '2026-04-11', TIME '16:23', 10.13, FALSE, 'SS 10/15 - Start', 'SS 10/15 - Finish'),
    ('SS16', 'Platak', 2, DATE '2026-04-11', TIME '17:22', 16.26, FALSE, 'SS 9/16 - Start', 'SS 9/16 - Finish'),

    ('SS17', 'Bribir - Novi Vinodolski', 1, DATE '2026-04-12', TIME '08:05', 14.17, FALSE, 'SS 17/19 - Start', 'SS 17/19 - Finish'),
    ('SS18', 'Alan - Senj', 1, DATE '2026-04-12', TIME '09:05', 14.56, FALSE, 'SS 18/20 - Start', 'SS 18/20 - Finish'),
    ('SS19', 'Bribir - Novi Vinodolski', 2, DATE '2026-04-12', TIME '10:38', 14.17, FALSE, 'SS 17/19 - Start', 'SS 17/19 - Finish'),
    ('SS20', 'Alan - Senj', 2, DATE '2026-04-12', TIME '13:15', 14.56, TRUE, 'SS 18/20 - Start', 'SS 18/20 - Finish')

) AS v (
    oznaka,
    naziv,
    prolazak,
    datum,
    vrijeme_starta,
    duljina_km,
    power_stage,
    start_naziv,
    cilj_naziv
)
JOIN rally r
    ON r.naziv = 'Croatia Rally'
   AND r.godina = 2026
JOIN lokacija ls
    ON ls.naziv = v.start_naziv
JOIN lokacija lc
    ON lc.naziv = v.cilj_naziv;