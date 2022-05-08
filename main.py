import sqlite3


def one_animal(id):
    with sqlite3.connect('animal.db') as connection:
        cursor = connection.cursor()
    query = f"""
            SELECT  name,  animal_type, breed, colors, date_of_birth, outcome_type, outcome_month, outcome_year 
            FROM new_animals_table
            INNER JOIN animal_type ON new_animals_table.animal_type_id = animal_type.animal_type_id  
            INNER JOIN breed ON new_animals_table.breed_id = breed.breed_id
            INNER JOIN outcome_type ON new_animals_table.outcome_type_id = outcome_type.outcome_type_id
            INNER JOIN outcome_month ON new_animals_table.outcome_month_id = outcome_month.outcome_month_id
            INNER JOIN outcome_year ON new_animals_table.outcome_year_id = outcome_year.outcome_year_id
            JOIN animal_color ON animal_color.animals_id = new_animals_table.name_id
            JOIN colors ON colors.colors_id = animal_color.color_id
            WHERE name_id = '{id}'
            
            
            """
    cursor.execute(query)
    executed_query = cursor.fetchall()
    results = executed_query

    for i in results:
        return {
            'name': i[0],
            'animal_type': i[1],
            'breed': i[2],
            'colors': i[3],
            'date_of_birth': i[4],
            'outcome_type': i[5],
            'outcome_month': i[6],
            'outcome_year': i[7],
        }

print(one_animal(66))



