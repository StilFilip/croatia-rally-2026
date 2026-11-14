require('dotenv').config();

const express = require('express');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const PORT = 3000;

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: process.env.DB_SSL === 'true'
});


app.use(express.static(path.join(__dirname, 'public')));
app.use('/data', express.static(path.join(__dirname, 'data')));

// Početna ruta
app.get('/api/test', async (req, res) => {
    try {
        const result = await pool.query('SELECT NOW()');

        res.json({
            message: 'Veza s bazom uspješna!',
            time: result.rows[0].now
        });
    } catch (error) {
        console.error('Greška pri povezivanju s bazom:', error);
        res.status(500).json({ error: 'Greška pri povezivanju s bazom.' });
    }
});



app.get('/api/brzinski-ispiti', async (req, res) => {
    try {
        const pojam = req.query.q || '';
        const atribut = req.query.atribut || 'svi';

        const query = `
            SELECT
                b.id,
                r.naziv AS rally,
                r.godina AS godina_rallyja,
                b.oznaka,
                b.naziv,
                b.prolazak,
                b.datum,
                b.vrijeme_starta,
                b.duljina_km,
                b.podloga,
                b.zupanija,
                b.power_stage,

                start.naziv AS start_lokacija,
                start.sirina AS start_sirina,
                start.duzina AS start_duzina,

                cilj.naziv AS cilj_lokacija,
                cilj.sirina AS cilj_sirina,
                cilj.duzina AS cilj_duzina,

                nr.vrijeme AS najbrze_vrijeme,
                p.vozac,
                p.suvozac

            FROM brzinski_ispit b

            JOIN rally r
                ON b.rally_id = r.id

            LEFT JOIN lokacija start
                ON b.start_lokacija_id = start.id

            LEFT JOIN lokacija cilj
                ON b.cilj_lokacija_id = cilj.id

            LEFT JOIN najbrzi_rezultat nr
                ON nr.brzinski_ispit_id = b.id

            LEFT JOIN posada p
                ON nr.posada_id = p.id

            WHERE
                $1 = ''
                OR (
                    $2 = 'svi'
                    AND (
                        r.naziv ILIKE $3
                        OR b.oznaka ILIKE $3
                        OR b.naziv ILIKE $3
                        OR b.prolazak::text ILIKE $3
                        OR b.datum::text ILIKE $3
                        OR b.vrijeme_starta::text ILIKE $3
                        OR b.duljina_km::text ILIKE $3
                        OR b.podloga ILIKE $3
                        OR b.zupanija ILIKE $3
                        OR b.power_stage::text ILIKE $3
                        OR start.naziv ILIKE $3
                        OR cilj.naziv ILIKE $3
                        OR p.vozac ILIKE $3
                        OR p.suvozac ILIKE $3
                    )
                )
                OR (
                    $2 = 'rally'
                    AND r.naziv ILIKE $3
                )
                OR (
                    $2 = 'naziv'
                    AND b.naziv ILIKE $3
                )
                OR (
                    $2 = 'oznaka'
                    AND b.oznaka ILIKE $3
                )
                OR (
                    $2 = 'podloga'
                    AND b.podloga ILIKE $3
                )
                OR (
                    $2 = 'zupanija'
                    AND b.zupanija ILIKE $3
                )
                OR (
                    $2 = 'vozac'
                    AND p.vozac ILIKE $3
                )

            ORDER BY b.id;
        `;

        const vrijednosti = [
            pojam,
            atribut,
            `%${pojam}%`
        ];

        const result = await pool.query(query, vrijednosti);

        res.json(result.rows);

    } catch (error) {
        console.error('Greška pri dohvaćanju brzinskih ispita:', error);

        res.status(500).json({
            error: 'Greška pri dohvaćanju podataka.'
        });
    }
});



app.listen(PORT, () => {
    console.log(`Poslužitelj pokrenut na http://localhost:${PORT}`);
});