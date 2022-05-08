from main import one_animal
from flask import Flask, jsonify


app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False




@app.route('/<int:itemid>/')
def index(itemid):
    animal = one_animal(itemid)
    return jsonify(animal)

app.run()