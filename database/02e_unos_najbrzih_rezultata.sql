-- =========================================
-- 02e_UNOS_NAJBRZIH_REZULTATA.SQL
-- Croatia Rally 2026
-- Izvor: Rally-Base, kategorija All
-- =========================================

INSERT INTO najbrzi_rezultat (
    brzinski_ispit_id,
    posada_id,
    vrijeme
)
SELECT
    bi.id,
    p.id,
    v.vrijeme::INTERVAL
FROM (
    VALUES
    ('SS1',  'Elfyn Evans',       'Scott Martin',       '00:07:59.7'),
    ('SS2',  'Elfyn Evans',       'Scott Martin',       '00:07:33.9'),
    ('SS3',  'Thierry Neuville',  'Martijn Wydaeghe',   '00:13:20.5'),
    ('SS4',  'Sami Pajari',       'Marko Salminen',     '00:06:55.3'),
    ('SS5',  'Sami Pajari',       'Marko Salminen',     '00:08:14.6'),
    ('SS6',  'Thierry Neuville',  'Martijn Wydaeghe',   '00:07:39.0'),
    ('SS7',  'Thierry Neuville',  'Martijn Wydaeghe',   '00:13:19.8'),
    ('SS8',  'Sami Pajari',       'Marko Salminen',     '00:06:50.2'),
    ('SS9',  'Oliver Solberg',    'Elliott Edmondson',  '00:08:36.8'),
    ('SS10', 'Oliver Solberg',    'Elliott Edmondson',  '00:05:43.0'),
    ('SS11', 'Oliver Solberg',    'Elliott Edmondson',  '00:13:44.9'),
    ('SS12', 'Oliver Solberg',    'Elliott Edmondson',  '00:04:49.0'),
    ('SS13', 'Takamoto Katsuta',  'Aaron Johnston',     '00:04:47.0'),
    ('SS14', 'Oliver Solberg',    'Elliott Edmondson',  '00:13:59.5'),
    ('SS15', 'Oliver Solberg',    'Elliott Edmondson',  '00:05:46.9'),
    ('SS16', 'Elfyn Evans',       'Scott Martin',       '00:08:49.5'),
    ('SS17', 'Oliver Solberg',    'Elliott Edmondson',  '00:07:10.7'),
    ('SS18', 'Oliver Solberg',    'Elliott Edmondson',  '00:07:03.2'),
    ('SS19', 'Oliver Solberg',    'Elliott Edmondson',  '00:07:16.4'),
    ('SS20', 'Oliver Solberg',    'Elliott Edmondson',  '00:07:03.3')
) AS v (
    oznaka,
    vozac,
    suvozac,
    vrijeme
)
JOIN brzinski_ispit bi
    ON bi.oznaka = v.oznaka
JOIN posada p
    ON p.vozac = v.vozac
   AND p.suvozac = v.suvozac
ON CONFLICT (brzinski_ispit_id)
DO UPDATE SET
    posada_id = EXCLUDED.posada_id,
    vrijeme = EXCLUDED.vrijeme;