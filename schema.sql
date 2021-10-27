/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id INT GENERATED ALWAYS AS IDENTITY, 
   name VARCHAR(100),
   date_of_birth DATE,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL,
   PRIMARY KEY(id)
);

<<<<<<< Updated upstream
/* Add a table for spiecies */
ALTER TABLE animals ADD COLUMN species VARCHAR(100);
=======
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
>>>>>>> Stashed changes
