from flask import Flask
from Auth.api import Auth

app = Flask(__name__)
app.register_blueprint(Auth)


if __name__ == "__main__":
    app.run()