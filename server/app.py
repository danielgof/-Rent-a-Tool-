from flask import Flask
from flask_cors import CORS
import os
import logging
from datetime import date
from api.api_auth import auth
from api.api_offer import offer


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f"./log/{date.today()}.log", level=logging.DEBUG)


app = Flask(__name__)
app.register_blueprint(auth)
app.register_blueprint(offer)
CORS(app)

if __name__ == "__main__":
    app.run()