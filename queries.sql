/* Queries that provide answers to the questions from all projects. */
-- Find all animals whose name ends in "mon".
SELECT
  name
FROM
  animals
WHERE
  name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE
  AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT
  name
FROM
  animals
WHERE
  name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg & animals with weight that equals precisely 10.4kg or 17.3kg).
SELECT
  name,
  weight_kg
FROM
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
 Then roll back the change and verify that species columns went back to the state before tranasction. */
BEGIN;

UPDATE
  animals
SET
  species = 'unspecified';

ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;

UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';

-- For all animals with null species, set species to pokemon.
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;

COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE FROM
  animals;

ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;

DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT animals_savepoint;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO animals_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape?
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals?
SELECT
  AVG(weight_kg)
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = (
    SELECT
      MAX(escape_attempts)
    FROM
      animals
  );

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

/* Queries that provide answers to the questions from all projects. */
-- Find all animals whose name ends in "mon".
SELECT
  name
FROM
  animals
WHERE
  name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE
  AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT
  name
FROM
  animals
WHERE
  name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg & animals with weight that equals precisely 10.4kg or 17.3kg).
SELECT
  name,
  weight_kg
FROM
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
 Then roll back the change and verify that species columns went back to the state before tranasction. */
BEGIN;

UPDATE
  animals
SET
  species = 'unspecified';

ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;

UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';

-- For all animals with null species, set species to pokemon.
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;

COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE FROM
  animals;

ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;

DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT animals_savepoint;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO animals_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape?
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals?
SELECT
  AVG(weight_kg)
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = (
    SELECT
      MAX(escape_attempts)
    FROM
      animals
  );

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

BEGIN;

-- Who was the last animal seen by William Tatcher?
SELECT
  animals.name,
  visits.date_of_visit
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'William Tatcher'
  )
ORDER BY
  visits.date_of_visit DESC
LIMIT
  1;

-- How many different animals did Stephanie Mendez see?
SELECT
  COUNT(DISTINCT animals.name)
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Stephanie Mendez'
  );

-- List all vets and their specializations, including vets with no specializations.
SELECT
  vets.name,
  specializations.species_id
FROM
  vets
  JOIN specializations ON vets.id = specializations.vet_id
  JOIN species ON specializations.species_id = species.id
ORDER BY
  vets.name;

--  List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Stephanie Mendez'
  )
  AND visits.date_of_visit BETWEEN '2020-04-01'
  AND '2020-08-30';

--  What animal has the most visits to vets?
SELECT
  animals.name
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
GROUP BY
  animals.name
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

-- Who was Maisy Smith's first visit?
SELECT
  animals.name
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Maisy Smith'
  )
ORDER BY
  visits.date_of_visit ASC
LIMIT
  1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name,
  vets.name,
  visits.date_of_visit
FROM
  animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vets ON visits.vet_id = vets.id
ORDER BY
  visits.date_of_visit DESC
LIMIT
  1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(*)
FROM
  visits
WHERE
  visits.vet_id NOT IN (
    SELECT
      vets.id
    FROM
      vets
      JOIN specializations ON vets.id = specializations.vet_id
      JOIN species ON specializations.species_id = species.id
  );

--  What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  specializations.species_id
FROM
  vets
  JOIN specializations ON vets.id = specializations.vet_id
  JOIN species ON specializations.species_id = species.id
WHERE
  vets.name = 'Maisy Smith'
GROUP BY
  specializations.species_id
ORDER BY
  COUNT(*) DESC
LIMIT
  1;
