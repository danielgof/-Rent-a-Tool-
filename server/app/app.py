"""Import installed or standart modules"""
import logging
import os
from datetime import date
from flask_cors import CORS

from api.api_auth import auth
from api.api_offer import offer
from api.api_chat import chat
from setup import RemoveColorFilter
from main import app


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(
    filename=f"./log/{date.today()}.log",
    level=logging.DEBUG,
    format="%(asctime)-15s %(name)-5s %(levelname)-8s %(message)s",
)

remove_color_filter = RemoveColorFilter()
logging.getLogger("werkzeug").addFilter(remove_color_filter)

app.register_blueprint(auth)
app.register_blueprint(offer)
app.register_blueprint(chat)
CORS(app)


if __name__ == "__main__":
    app.run(port=3444)
    # socketio.run(app, port=3444)
