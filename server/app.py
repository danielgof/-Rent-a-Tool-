from flask import Flask
from flask_cors import CORS

from api_auth import auth
from api_offer import offer


app = Flask(__name__)
app.register_blueprint(auth)
app.register_blueprint(offer)
CORS(app)

if __name__ == "__main__":
    app.run()