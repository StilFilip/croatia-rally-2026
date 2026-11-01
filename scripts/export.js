require("dotenv").config();
const fs = require("fs");
const path = require("path");
const { Client } = require("pg");
const { stringify } = require("csv-stringify/sync");

const outputDir = path.join(__dirname, "..", "data");
fs.mkdirSync(outputDir, { recursive: true });

const client = new Client({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 5432),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : false
});

const sql = `
SELECT
  r.id AS rally_id, r.naziv AS rally_naziv, r.godina AS rally_godina,
  r.datum_pocetka AS rally_datum_pocetka,
  r.datum_zavrsetka AS rally_datum_zavrsetka, r.lokacija AS rally_lokacija,
  bi.id AS brzinski_ispit_id, bi.oznaka,
  bi.naziv AS brzinski_ispit_naziv, bi.prolazak, bi.datum,
  bi.vrijeme_starta, bi.duljina_km, bi.podloga, bi.zupanija, bi.power_stage,
  ls.id AS start_lokacija_id, ls.naziv AS start_naziv,
  ls.sirina AS start_sirina, ls.duzina AS start_duzina,
  lc.id AS cilj_lokacija_id, lc.naziv AS cilj_naziv,
  lc.sirina AS cilj_sirina, lc.duzina AS cilj_duzina,
  nr.id AS rezultat_id, nr.vrijeme AS najbrze_vrijeme,
  p.id AS posada_id, p.vozac, p.suvozac
FROM brzinski_ispit bi
JOIN rally r ON bi.rally_id = r.id
JOIN lokacija ls ON bi.start_lokacija_id = ls.id
JOIN lokacija lc ON bi.cilj_lokacija_id = lc.id
LEFT JOIN najbrzi_rezultat nr ON bi.id = nr.brzinski_ispit_id
LEFT JOIN posada p ON nr.posada_id = p.id
ORDER BY bi.datum, bi.vrijeme_starta, bi.oznaka, bi.prolazak;
`;

const num = v => v == null ? null : Number(v);

async function main() {
  if (!process.env.DB_NAME || !process.env.DB_USER || !process.env.DB_PASSWORD) {
    throw new Error("Nedostaje DB_NAME, DB_USER ili DB_PASSWORD u .env datoteci.");
  }
  await client.connect();
  const { rows } = await client.query(sql);

  const json = rows.map(x => ({
    id: x.brzinski_ispit_id,
    rally: {
      id: x.rally_id, naziv: x.rally_naziv, godina: x.rally_godina,
      datum_pocetka: x.rally_datum_pocetka,
      datum_zavrsetka: x.rally_datum_zavrsetka, lokacija: x.rally_lokacija
    },
    oznaka: x.oznaka, naziv: x.brzinski_ispit_naziv,
    prolazak: x.prolazak, datum: x.datum, vrijeme_starta: x.vrijeme_starta,
    duljina_km: num(x.duljina_km), podloga: x.podloga,
    zupanija: x.zupanija, power_stage: x.power_stage,
    lokacija_starta: {
      id: x.start_lokacija_id, naziv: x.start_naziv,
      sirina: num(x.start_sirina), duzina: num(x.start_duzina)
    },
    lokacija_cilja: {
      id: x.cilj_lokacija_id, naziv: x.cilj_naziv,
      sirina: num(x.cilj_sirina), duzina: num(x.cilj_duzina)
    },
    najbrzi_rezultat: x.rezultat_id == null ? null : {
      id: x.rezultat_id, vrijeme: x.najbrze_vrijeme,
      posada: { id: x.posada_id, vozac: x.vozac, suvozac: x.suvozac }
    }
  }));

  const columns = [
    "brzinski_ispit_id","rally_id","rally_naziv","rally_godina",
    "rally_datum_pocetka","rally_datum_zavrsetka","rally_lokacija",
    "oznaka","brzinski_ispit_naziv","prolazak","datum","vrijeme_starta",
    "duljina_km","podloga","zupanija","power_stage",
    "start_lokacija_id","start_naziv","start_sirina","start_duzina",
    "cilj_lokacija_id","cilj_naziv","cilj_sirina","cilj_duzina",
    "rezultat_id","najbrze_vrijeme","posada_id","vozac","suvozac"
  ];
  const csvRows = rows.map(x => ({
    brzinski_ispit_id:x.brzinski_ispit_id, rally_id:x.rally_id,
    rally_naziv:x.rally_naziv, rally_godina:x.rally_godina,
    rally_datum_pocetka:x.rally_datum_pocetka,
    rally_datum_zavrsetka:x.rally_datum_zavrsetka,
    rally_lokacija:x.rally_lokacija, oznaka:x.oznaka,
    brzinski_ispit_naziv:x.brzinski_ispit_naziv, prolazak:x.prolazak,
    datum:x.datum, vrijeme_starta:x.vrijeme_starta, duljina_km:x.duljina_km,
    podloga:x.podloga, zupanija:x.zupanija, power_stage:x.power_stage,
    start_lokacija_id:x.start_lokacija_id, start_naziv:x.start_naziv,
    start_sirina:x.start_sirina, start_duzina:x.start_duzina,
    cilj_lokacija_id:x.cilj_lokacija_id, cilj_naziv:x.cilj_naziv,
    cilj_sirina:x.cilj_sirina, cilj_duzina:x.cilj_duzina,
    rezultat_id:x.rezultat_id, najbrze_vrijeme:x.najbrze_vrijeme,
    posada_id:x.posada_id, vozac:x.vozac, suvozac:x.suvozac
  }));

  fs.writeFileSync(path.join(outputDir,"brzinski_ispiti.json"),
    JSON.stringify(json,null,2),"utf8");
  fs.writeFileSync(path.join(outputDir,"brzinski_ispiti.csv"),
    stringify(csvRows,{header:true,columns,bom:true}),"utf8");
  console.log(`Izvoz uspješan: ${rows.length} zapisa.`);
}
main()
  .catch(e => { console.error("Greška pri izvozu:",e.message); process.exitCode=1; })
  .finally(async () => { await client.end().catch(()=>{}); });
