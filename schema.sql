DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS animals;

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