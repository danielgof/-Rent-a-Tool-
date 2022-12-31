from flask import Flask
from auth.api import auth

app = Flask(__name__)
app.register_blueprint(auth)


if __name__ == "__main__":
    app.run()