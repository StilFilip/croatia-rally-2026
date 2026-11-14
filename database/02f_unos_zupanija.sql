
BEGIN;

UPDATE brzinski_ispit
SET zupanija = CASE
    -- Primorsko-goranska županija
    WHEN id IN (1, 8, 9, 10, 11, 12, 13, 18, 19)
        THEN 'Primorsko-goranska'

    -- Istarska županija
    WHEN id IN (2, 3, 4, 5, 6, 7)
        THEN 'Istarska'

    -- Karlovačka županija
    WHEN id IN (14, 15, 16, 17)
        THEN 'Karlovačka'

    -- Ličko-senjska županija
    WHEN id IN (20, 21)
        THEN 'Ličko-senjska'
END
WHERE id IN (
    1, 2, 3, 4, 5, 6, 7,
    8, 9, 10, 11, 12, 13,
    14, 15, 16, 17, 18, 19, 20, 21
);

COMMIT;
