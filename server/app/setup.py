from config import *
import click
import logging


class RemoveColorFilter(logging.Filter):
    """Class to remove filter in log files"""

    def filter(self, record):
        if record and record.msg and isinstance(record.msg, str):
            record.msg = click.unstyle(record.msg)
        return True


SECRET_KEY = "key"
