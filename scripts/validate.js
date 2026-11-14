
const fs = require('fs');
const path = require('path');
const Ajv2020 = require('ajv/dist/2020').default;
const addFormats = require('ajv-formats');

// Učitavanje JSON Scheme
const schemaPath = path.join(__dirname, '..', 'schema.json');
const schema = JSON.parse(fs.readFileSync(schemaPath, 'utf8'));

// Učitavanje JSON podataka
const dataPath = path.join(
    __dirname,
    '..',
    'data',
    'brzinski_ispiti.json'
);

const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

// Postavljanje validatora za Draft 2020-12
const ajv = new Ajv2020({
    allErrors: true,
    strict: false
});

addFormats(ajv);

// Provjera podataka prema shemi
const validate = ajv.compile(schema);
const isValid = validate(data);

if (isValid) {
    console.log('JSON podaci uspješno prolaze provjeru!');
    console.log(`Provjereno zapisa: ${data.length}`);
} else {
    console.log('JSON podaci ne odgovaraju JSON Schemi.');
    console.log('\nPronađene pogreške:');

    validate.errors.forEach(error => {
        console.log(
            `- ${error.instancePath || '/'}: ${error.message}`
        );
    });
}
