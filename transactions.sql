BEGIN;
UPDATE animals
SET 
    species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals 
SET 
    species = 'digimon'
    WHERE name LIKE '%mon';

UPDATE animals 
SET 
    species = 'pokemon'
    WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals 
SET 
    WEIGHT_KG = WEIGHT_KG * -1;
ROLLBACK TO SP1;
UPDATE animals 
SET 
    WEIGHT_KG = WEIGHT_KG * -1
    WHERE WEIGHT_KG < -1;
COMMIT;