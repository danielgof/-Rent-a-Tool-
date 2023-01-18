from flask import Flask
# from models.create import *
from api.api_auth import auth
from api.api_offer import offer

app = Flask(__name__)
app.register_blueprint(auth)
app.register_blueprint(offer)


if __name__ == "__main__":
    app.run()