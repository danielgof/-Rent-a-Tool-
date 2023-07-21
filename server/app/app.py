from flask import Flask
from flask_cors import CORS
import os
import logging
from datetime import date
import click
# from flask_socketio import SocketIO, emit

from api.api_auth import auth
from api.api_offer import offer
from api.api_chat import chat
from main import app


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(
    filename=f"./log/{date.today()}.log",
    level=logging.DEBUG,
    format="%(asctime)-15s %(name)-5s %(levelname)-8s %(message)s",
)


class RemoveColorFilter(logging.Filter):
    def filter(self, record):
        if record and record.msg and isinstance(record.msg, str):
            record.msg = click.unstyle(record.msg)
        return True


remove_color_filter = RemoveColorFilter()
logging.getLogger("werkzeug").addFilter(remove_color_filter)


# socketio = SocketIO()
# socketio.init_app(app)
app.register_blueprint(auth)
app.register_blueprint(offer)
app.register_blueprint(chat)
CORS(app)


if __name__ == "__main__":
    app.run(port=3444)
    # socketio.run(app, port=3444)
