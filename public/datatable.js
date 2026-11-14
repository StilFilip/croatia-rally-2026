
const tableBody = document.getElementById('table-body');
const resultCount = document.getElementById('result-count');

const filterForm = document.getElementById('filter-form');
const searchInput = document.getElementById('search-input');
const attributeSelect = document.getElementById('attribute-select');
const clearButton = document.getElementById('clear-button');

const downloadCsvButton = document.getElementById('download-csv');
const downloadJsonButton = document.getElementById('download-json');


let trenutniPodaci = [];


function prikaziPodatke(podaci) {
    tableBody.innerHTML = '';

    if (podaci.length === 0) {
        tableBody.innerHTML = `
            <tr>
                <td colspan="21">Nema pronađenih podataka.</td>
            </tr>
        `;

        resultCount.textContent = 'Broj pronađenih zapisa: 0';
        return;
    }

    podaci.forEach(zapis => {
        const redak = document.createElement('tr');

        const vrijednosti = [
            zapis.id,
            zapis.rally,
            zapis.godina_rallyja,
            zapis.oznaka,
            zapis.naziv,
            zapis.prolazak,
            zapis.datum,
            zapis.vrijeme_starta,
            zapis.duljina_km,
            zapis.podloga,
            zapis.zupanija,
            zapis.power_stage,
            zapis.start_lokacija,
            zapis.start_sirina,
            zapis.start_duzina,
            zapis.cilj_lokacija,
            zapis.cilj_sirina,
            zapis.cilj_duzina,
            zapis.najbrze_vrijeme,
            zapis.vozac,
            zapis.suvozac
        ];

        vrijednosti.forEach(vrijednost => {
            const celija = document.createElement('td');

            celija.textContent =
                vrijednost === null || vrijednost === undefined
                    ? '-'
                    : vrijednost;

            redak.appendChild(celija);
        });

        tableBody.appendChild(redak);
    });

    resultCount.textContent =
        `Broj pronađenih zapisa: ${podaci.length}`;
}


async function dohvatiPodatke(pojam = '', atribut = 'svi') {
    try {
        resultCount.textContent = 'Učitavanje podataka...';

        const parametri = new URLSearchParams({
            q: pojam,
            atribut: atribut
        });

        const odgovor = await fetch(
            `/api/brzinski-ispiti?${parametri.toString()}`
        );

        if (!odgovor.ok) {
            throw new Error('Greška pri dohvaćanju podataka.');
        }

        const podaci = await odgovor.json();

        trenutniPodaci = podaci;

        prikaziPodatke(trenutniPodaci);

    } catch (greska) {
        console.error('Greška:', greska);

        tableBody.innerHTML = `
            <tr>
                <td colspan="21">
                    Došlo je do greške pri učitavanju podataka.
                </td>
            </tr>
        `;

        resultCount.textContent = 'Podaci nisu učitani.';
    }
}

filterForm.addEventListener('submit', function(event) {
    event.preventDefault();

    const pojam = searchInput.value.trim();
    const atribut = attributeSelect.value;

    dohvatiPodatke(pojam, atribut);
});

clearButton.addEventListener('click', function() {
    searchInput.value = '';
    attributeSelect.value = 'svi';

    dohvatiPodatke();
});


function preuzmiDatoteku(sadrzaj, nazivDatoteke, tip) {
    const datoteka = new Blob([sadrzaj], {
        type: tip
    });

    const poveznica = document.createElement('a');
    const url = URL.createObjectURL(datoteka);

    poveznica.href = url;
    poveznica.download = nazivDatoteke;

    document.body.appendChild(poveznica);
    poveznica.click();
    poveznica.remove();

    URL.revokeObjectURL(url);
}


function preuzmiCSV() {
    if (trenutniPodaci.length === 0) {
        alert('Nema podataka za preuzimanje.');
        return;
    }

    const atributi = [
        'id',
        'rally',
        'godina_rallyja',
        'oznaka',
        'naziv',
        'prolazak',
        'datum',
        'vrijeme_starta',
        'duljina_km',
        'podloga',
        'zupanija',
        'power_stage',
        'start_lokacija',
        'start_sirina',
        'start_duzina',
        'cilj_lokacija',
        'cilj_sirina',
        'cilj_duzina',
        'najbrze_vrijeme',
        'vozac',
        'suvozac'
    ];

    const zaglavlje = atributi.join(',');

    const redci = trenutniPodaci.map(zapis => {
        return atributi.map(atribut => {
            const vrijednost = zapis[atribut] ?? '';


            return `"${String(vrijednost).replace(/"/g, '""')}"`;
        }).join(',');
    });

    const csv = '\uFEFF' + [zaglavlje, ...redci].join('\r\n');

    preuzmiDatoteku(
        csv,
        'filtrirani_brzinski_ispiti.csv',
        'text/csv;charset=utf-8;'
    );
}


function preuzmiJSON() {
    if (trenutniPodaci.length === 0) {
        alert('Nema podataka za preuzimanje.');
        return;
    }

    const json = JSON.stringify(trenutniPodaci, null, 2);

    preuzmiDatoteku(
        json,
        'filtrirani_brzinski_ispiti.json',
        'application/json;charset=utf-8;'
    );
}


downloadCsvButton.addEventListener('click', preuzmiCSV);
downloadJsonButton.addEventListener('click', preuzmiJSON);


dohvatiPodatke();
