-- =========================================
-- UNOS POSADA
-- =========================================

INSERT INTO posada (vozac, suvozac)
VALUES
    ('Elfyn Evans', 'Scott Martin'),
    ('Thierry Neuville', 'Martijn Wydaeghe'),
    ('Sami Pajari', 'Marko Salminen'),
    ('Oliver Solberg', 'Elliott Edmondson'),
    ('Takamoto Katsuta', 'Aaron Johnston')
ON CONFLICT (vozac, suvozac) DO NOTHING;