/* Populate database with sample data. */
INSERT INTO
  animals (
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
  )
VALUES
  (
    'Agumon',
    '2020-02-03',
    '10.2',
    '1',
    '0'
  ),
  (
    'Gabumon',
    '2018-11-15',
    '8',
    '1',
    '2'
  ),
  (
    'Pikachu',
    '2020-01-07',
    '15.04',
    '0',
    '1'
  ),
  (
    'Devimon',
    '2017-05-12',
    '11',
    '1',
    '5'
  ),
  (
    'Charmander',
    '2020-02-08',
    '-11',
    '0',
    '0'
  ),
  (
    'Plantmon',
    '2022-11-15',
    '-5.7',
    '1',
    '2'
  ),
  (
    'Squirtle',
    '1993-01-07',
    '-12.13',
    '0',
    '3'
  ),
  (
    'Angemon',
    '2005-06-12',
    '-45',
    '1',
    '1'
  ),
  (
    'Boarmon',
    '2005-06-7',
    '20.4',
    '1',
    '7'
  ),
  ('Blossom', '1998-10-13', '17', '1', '3') (
    'Angemon',
    '1998-10-13',
    '17',
    '1',
    '3'
  );

-- Owners
INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Species
INSERT INTO
  species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

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
      name = 'Digimon'
  )
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
      name = 'Pokemon'
  )
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
      full_name = 'Sam Smith'
  )
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
      full_name = 'Jennifer Orwell'
  )
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
      full_name = 'Bob'
  )
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
      full_name = 'Melody Pond'
  )
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
      full_name = 'Dean Winchester'
  )
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
      name = 'Pokemon'
  );

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
      name = 'Digimon'
  )
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
      name = 'Digimon'
  )
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
  COUNT(animals.name) DESC;

BEGIN;

INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

COMMIT;

-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO
  specializations (vet_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  );

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO
  specializations (vet_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  );

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO
  specializations (vet_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  );

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-05-24'
  );

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-07-22'
  );

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-02'
  );

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-05-14'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-03-08'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-01-05'
  );

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2021-05-04'
  );

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-24'
  );

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-12-21'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-08-10'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2021-04-07'
  );

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2019-09-29'
  );

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-10-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-11-04'
  );

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-01-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-05-15'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-02-27'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-08-03'
  );

-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2021-01-11'
  );