/* Database schema to keep the structure of entire database. */
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS vets;
DROP TABLE IF EXISTS specializations;
DROP TABLE IF EXISTS visits;

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempt INT,
    neutered BOOLEAN,
    WEIGHT_KG DECIMAL,
    species_id INT,
    owner_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_species
    FOREIGN KEY(species_id)
	REFERENCES species(id),
    CONSTRAINT fk_owners
    FOREIGN KEY(owner_id)
	REFERENCES owners(id)
);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    specie_id INT,
    vet_id INT,
    CONSTRAINT fk_species
    FOREIGN KEY(specie_id)
	REFERENCES species(id),
    CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
	REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit Date,
    CONSTRAINT fk_animal
    FOREIGN KEY(animal_id)
	REFERENCES animals(id),
    CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
	REFERENCES vets(id)
);

CREATE INDEX visits_animal_id ON visits(animal_id);
CREATE INDEX visits_vet_id ON visits(vet_id);
CREATE INDEX owners_email ON owners(email DESC);