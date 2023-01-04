from flask import Flask
from models.create import *
from api.api_auth import auth

app = Flask(__name__)
app.register_blueprint(auth)


if __name__ == "__main__":
    app.run()