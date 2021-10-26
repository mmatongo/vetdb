/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
		VALUES('Agumon', '2020-02-03', '10.2', '1', '0'), ('Gabumon', '2018-11-15', '8', '1', '2'), ('Pikachu', '2020-01-07', '15.04', '0', '1'), ('Devimon', '2017-05-12', '11', '1', '5'), ('Charmander', '2020-02-08', '-11', '0', '0'), ('Plantmon', '2022-11-15', '-5.7', '1', '2'), ('Squirtle', '1993-01-07', '-12.13', '0', '3'), ('Angemon', '2005-06-12', '-45', '1', '1'), ('Boarmon', '2005-06-7', '20.4', '1', '7'), ('Angemon', '1998-10-13', '17', '1', '3');

-- Owners
INSERT INTO owners (full_name, age)
		VALUES('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- Species
INSERT INTO species (name)
		VALUES('Pokemon'), ('Digimon');

-- Classifications
BEGIN;
-- If its name ends in mon then set it's species to Digimon
UPDATE
	animals
SET
	species_id = (
		SELECT
			id
		FROM
			species
		WHERE
			name = 'Digimon')
	WHERE
		name LIKE '%mon';
-- Everything else is Pokemon
UPDATE
	animals
SET
	species_id = (
		SELECT
			id
		FROM
			species
		WHERE
			name = 'Pokemon')
	WHERE
		name NOT LIKE '%mon';
COMMIT;

-- Give animals owners
BEGIN;
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		FROM
			owners
		WHERE
			full_name = 'Sam Smith')
	WHERE
		name = 'Agumon';
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		FROM
			owners
		WHERE
			full_name = 'Jennifer Orwell')
	WHERE
		name = 'Gabumon'
		OR name = 'Pikachu';
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		FROM
			owners
		WHERE
			full_name = 'Bob')
	WHERE
		name = 'Devimon'
		OR name = 'Plantmon';
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		FROM
			owners
		WHERE
			full_name = 'Melody Pond')
	WHERE
		name = 'Charmander'
		OR name = 'Squirtle'
		OR name = 'Blossom';
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		FROM
			owners
		WHERE
			full_name = 'Dean Winchester')
	WHERE
		name = 'Angemon'
		OR name = 'Boarmon';
COMMIT;

-- List all animals that belong to Melody Pond
SELECT
	animals.name
FROM
	animals
	JOIN owners ON animals.owner_id = owners.id
WHERE
	owners.full_name = 'Melody Pond';


-- List all animals that are pokemon (their type is Pokemon).
SELECT
	animals.name
FROM
	animals
	JOIN owners ON animals.owner_id = owners.id
WHERE
	species_id = (
		SELECT
			id
		FROM
			species
		WHERE
			name = 'Pokemon');

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
	owners.full_name,
	animals.name
FROM
	owners
	JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT
	species.name,
	COUNT(species.name)
FROM
	animals
	JOIN species ON animals.species_id = species.id
GROUP BY
	species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
	animals.name
FROM
	animals
	JOIN owners ON animals.owner_id = owners.id
WHERE
	species_id = (
		SELECT
			id
		FROM
			species
		WHERE
			name = 'Digimon')
		AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
	animals.name
FROM
	animals
	JOIN owners ON animals.owner_id = owners.id
WHERE
	species_id = (
		SELECT
			id
		FROM
			species
		WHERE
			name = 'Digimon')
		AND animals.escape_attempts = 0
		AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT
	owners.full_name,
	COUNT(animals.name)
FROM
	owners
	JOIN animals ON owners.id = animals.owner_id
GROUP BY
	owners.full_name
ORDER BY
	COUNT(animals.name)
	DESC;