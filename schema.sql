/* Database schema to keep the structure of entire database. */
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(100),
	age INT,
	PRIMARY KEY (id)
);

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	PRIMARY KEY (id)
);

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY (id),
	-- Add column species_id which is a foreign key referencing species table
	species_id INT REFERENCES species (id),
	--Add column owner_id which is a foreign key referencing the owners table
	owner_id INT REFERENCES owners (id)
);

CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY (id)
);

CREATE TABLE specializations (
	vet_id INT REFERENCES vets (id),
	species_id INT REFERENCES species (id)
);

CREATE TABLE visits (
	vet_id INT REFERENCES vets (id),
	animal_id INT REFERENCES animals (id),
	date_of_visit DATE
);