CREATE TABLE animal_type (
    animal_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_type TEXT
);

INSERT INTO animal_type (animal_type)
SELECT DISTINCT animal_type
FROM animals;



CREATE TABLE breed (
    breed_id INTEGER PRIMARY KEY AUTOINCREMENT,
    breed TEXT
);

INSERT INTO breed (breed)
SELECT DISTINCT breed
FROM animals;

CREATE TABLE colors (
    colors_id INTEGER PRIMARY KEY AUTOINCREMENT,
    colors TEXT
);

CREATE TABLE animal_color (
    animals_id INTEGER,
    color_id INTEGER,
    FOREIGN KEY (animals_id) REFERENCES new_animals_table_TEST(name_id),
    FOREIGN KEY (color_id) REFERENCES colors(colors_id)

);

INSERT INTO colors (colors)
SELECT DISTINCT *
FROM (SELECT DISTINCT
          color1 AS colors
      FROM animals
      UNION ALL
      SELECT DISTINCT
          color2 AS colors
      FROM animals
          );
DELETE FROM colors
WHERE colors IS NULL;

INSERT INTO animal_color (animals_id, color_id)
SELECT DISTINCT new_animals_table.name_id, colors_id
FROM animals
INNER JOIN colors ON colors.colors = animals.color1
INNER JOIN new_animals_table ON new_animals_table.animal_id = animals.animal_id
UNION ALL
SELECT DISTINCT new_animals_table.name_id, colors_id
FROM animals
INNER JOIN colors ON colors.colors = animals.color2
INNER JOIN new_animals_table ON new_animals_table.animal_id = animals.animal_id;



CREATE TABLE outcome_subtype(
    outcome_subtype_id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_subtype TEXT
);

INSERT INTO outcome_subtype (outcome_subtype)
SELECT DISTINCT outcome_subtype
FROM animals;



CREATE TABLE outcome_type (
    outcome_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_type TEXT
);

INSERT INTO outcome_type (outcome_type)
SELECT DISTINCT outcome_type
FROM animals;

CREATE TABLE outcome_month (
    outcome_month_id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_month TEXT
);

INSERT INTO outcome_month (outcome_month)
SELECT DISTINCT outcome_month
FROM animals;

CREATE TABLE outcome_year (
    outcome_year_id INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_year TEXT
);

INSERT INTO outcome_year (outcome_year)
SELECT DISTINCT outcome_year
FROM animals;

CREATE TABLE new_animals_table (
    name_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT(50),
    animal_id TEXT,
    animal_type_id INTEGER ,
    breed_id  INTEGER,
    date_of_birth TEXT,
    outcome_subtype_id INTEGER,
    outcome_type_id	INTEGER,
    outcome_month_id INTEGER,
    outcome_year_id INTEGER,
    FOREIGN KEY (animal_type_id) REFERENCES animal_type(animal_type_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (breed_id) REFERENCES breed(breed_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (outcome_subtype_id) REFERENCES outcome_subtype(outcome_subtype_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (outcome_type_id) REFERENCES outcome_type(outcome_type_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (outcome_month_id) REFERENCES outcome_month(outcome_month_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (outcome_year_id) REFERENCES outcome_year(outcome_year_id) ON DELETE SET NULL ON UPDATE CASCADE
);



INSERT INTO new_animals_table (name, animal_id, date_of_birth, animal_type_id, breed_id, outcome_subtype_id,
                               outcome_type_id, outcome_month_id, outcome_year_id)
SELECT (name), (animal_id), (date_of_birth), (animal_type.animal_type_id), (breed.breed_id),
       (outcome_subtype.outcome_subtype_id), (outcome_type.outcome_type_id), (outcome_month.outcome_month_id),
       (outcome_year.outcome_year_id)
FROM animals
LEFT JOIN animal_type ON animals.animal_type = animal_type.animal_type
LEFT JOIN breed ON animals.breed = breed.breed
LEFT JOIN outcome_subtype ON animals.outcome_subtype = outcome_subtype.outcome_subtype
LEFT JOIN outcome_type ON animals.outcome_type = outcome_type.outcome_type
LEFT JOIN outcome_month ON animals.outcome_month = outcome_month.outcome_month
LEFT JOIN outcome_year ON animals.outcome_year = outcome_year.outcome_year;



SELECT new_animals_table.name_id, new_animals_table.name, animal_type.animal_type, breed.breed,
           colors.colors, new_animals_table.date_of_birth, outcome_type.outcome_type, outcome_month.outcome_month,
           outcome_year.outcome_year
FROM new_animals_table
JOIN animal_color ON animal_color.animals_id = new_animals_table.name_id
JOIN colors ON colors.colors_id = animal_color.color_id
INNER JOIN animal_type ON new_animals_table.animal_type_id = animal_type.animal_type_id
INNER JOIN breed ON new_animals_table.breed_id = breed.breed_id
INNER JOIN outcome_type ON new_animals_table.outcome_type_id = outcome_type.outcome_type_id
INNER JOIN outcome_month ON new_animals_table.outcome_month_id = outcome_month.outcome_month_id
INNER JOIN outcome_year ON new_animals_table.outcome_year_id = outcome_year.outcome_year_id