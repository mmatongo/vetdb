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