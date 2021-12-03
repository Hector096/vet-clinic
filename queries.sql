/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE   date_of_birth > '01/01/2016' AND date_of_birth   <= '31/12/2019';
SELECT * FROM animals WHERE   escape_attempts < '3' AND neutered = true
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT NAME, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE NOT SELECT * FROM animals WHERE   escape_attempts < '3' AND neutered = true;
SELECT * FROM animals WHERE NAME != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



SELECT COUNT(name) FROM animals;
SELECT COUNT(name) FROM animals WHERE escape_attempt = 0;
SELECT AVG(WEIGHT_KG) FROM animals;
SELECT name, escape_attempt FROM animals WHERE escape_attempt = (SELECT MAX(escape_attempt) FROM animals);
SELECT species, MIN(WEIGHT_KG), MAX(WEIGHT_KG) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempt) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;



