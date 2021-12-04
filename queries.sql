-- /*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name FROM animals WHERE neutered IS true AND escape_attempt < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name, escape_attempt FROM animals WHERE WEIGHT_KG > 10.5;

-- Find all animals that are neutered.

SELECT * FROM animals WHERE neutered IS true;

-- Find all animals not named Gabumon.

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg 
-- (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT * FROM animals WHERE WEIGHT_KG >= 10.4 AND WEIGHT_KG <= 17.3;

-- How many animals are there?

SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(name) FROM animals WHERE escape_attempt = 0;

-- What is the average weight of animals?

SELECT AVG(WEIGHT_KG) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT name, escape_attempt FROM animals 
WHERE escape_attempt = (SELECT MAX(escape_attempt) FROM animals);

-- What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(WEIGHT_KG), MAX(WEIGHT_KG) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempt) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?

SELECT owners.id, full_name, name
FROM owners
JOIN animals
ON owners.id = owner_id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT species.id, species.name, animals.name
FROM species 
JOIN animals
ON species.id = species_id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.id, owners.full_name, animals.name
FROM owners
LEFT JOIN animals
ON owners.id = owner_id;

-- How many animals are there per species?

SELECT species.id, species.name, COUNT(animals.name)
FROM species 
JOIN animals
ON species.id = species_id
GROUP BY species.id;

-- List all Digimon owned by Jennifer Orwell.

SELECT species_id, species.name AS specie, animals.name
FROM species 
JOIN animals
ON species.id = species_id
JOIN owners
ON owners.id = owner_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT owners.full_name, animals.name
FROM owners
JOIN animals
ON owners.id = owner_id
WHERE full_name = 'Dean Winchester' AND escape_attempt = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(owners.id)
FROM owners
JOIN animals
ON owners.id = owner_id
GROUP BY owners.id
ORDER BY COUNT(owners.id) DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?

SELECT animals.name, vets.name, date_of_visit
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT vets.name, COUNT(animals.name)
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON vets.id = vet_id
LEFT JOIN species
ON species.id = specie_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT vets.name, animals.name
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
WHERE vets.name = 'Stephanie Mendez' 
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name, COUNT(animals.name)
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
GROUP BY animals.name
ORDER BY COUNT(animals.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, vets.name, date_of_visit
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC FETCH FIRST ROW ONLY;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT *
FROM visits
JOIN animals
ON animals.id = animal_id
JOIN vets
ON vets.id = vet_id
ORDER BY date_of_visit DESC FETCH FIRST ROW ONLY;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT vets.name, COUNT(date_of_visit)
FROM vets
LEFT JOIN visits
ON vets.id = visits.vet_id
LEFT JOIN specializations
ON vets.id = specializations.vet_id
WHERE specializations.specie_id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(species.name)
FROM visits
JOIN vets
ON vets.id = vet_id
JOIN animals
ON animals.id = animal_id
JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC FETCH FIRST ROW ONLY;
