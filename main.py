import sqlite3


def one_animal(itemid):
    with sqlite3.connect('animal.db') as connection:
        cursor = connection.cursor()
    query = """
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
            WHERE new_animals_table.name_id = ?
    """
    cursor.execute(query, (itemid,))
    executed_query = cursor.fetchall()
    results = executed_query

    if len(results) == 1:
        animal = {'name': results[0][1],
                  'animal_type': results[0][2],
                  'breed': results[0][3],
                  'color1': results[0][4],
                  'date_of_birth': results[0][5],
                  'outcome_type': results[0][6],
                  'outcome_mounth': results[0][7],
                  'outcome_year': results[0][8]
                  }
        return animal
    else:

         animal = {'name': results[0][1],
                  'animal_type': results[0][2],
                  'breed': results[0][3],
                  'color1': results[0][4],
                  'color2': results[1][4],
                  'date_of_birth': results[0][5],
                  'outcome_type': results[0][6],
                  'outcome_mounth': results[0][7],
                  'outcome_year': results[0][8]
                  }
    return animal