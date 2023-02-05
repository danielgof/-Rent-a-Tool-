from flask import Flask
from flask_cors import CORS
import os
import logging
from datetime import date
import click

from api.api_auth import auth
from api.api_offer import offer


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f'./log/{date.today()}.log',
                    level=logging.DEBUG,
                    format='%(asctime)-15s %(name)-5s %(levelname)-8s %(message)s')


class RemoveColorFilter(logging.Filter):
    def filter(self, record):
        if record and record.msg and isinstance(record.msg, str):
            record.msg = click.unstyle(record.msg)
        return True


remove_color_filter = RemoveColorFilter()
logging.getLogger("werkzeug").addFilter(remove_color_filter)


app = Flask(__name__)
app.register_blueprint(auth)
app.register_blueprint(offer)
CORS(app)

if __name__ == "__main__":
    app.run()