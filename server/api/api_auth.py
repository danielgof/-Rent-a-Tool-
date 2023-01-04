from flask import Blueprint, request, jsonify, abort
from flask_cors import CORS
from flask_mail import Mail, Message
from functools import wraps
from datetime import datetime, timedelta
from flask import current_app
import jwt
import os
import logging

from models.create import *
from config import *
from server.models.db_auth import User


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f'./log/{date.today()}.log', level=logging.DEBUG)
auth = Blueprint('auth', __name__)

@auth.route('/')
def index():
    return "This is an example app"

CORS(auth)
Base.metadata.create_all(engine)
session = Session()
SECRET_KEY, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD, MAIL_USE_TLS, MAIL_USE_SSL = config_auth("./auth/config.yaml")


# mail = Mail(Auth)

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        head = request.headers
        token = head["Authorization"]
        if not token:
            return jsonify({"message":"token is missing"}), 403
        try:
            data = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
            current_user = session.query(User).filter(User.username == data["username"]).first()
        except:
            return jsonify({"message":"token is invalid"}), 402
        return f(current_user, *args, **kwargs)

    return decorated
"""
auth api
"""
@auth.route("/api/v1/auth/login", methods=["POST", "GET"])
def login():
    try:
        data = request.get_json(force=True)
        user = session.query(User) \
            .filter(User.username == data["username"]).first()
        if user:
            token = jwt.encode({"username": data["username"], 
            "exp": datetime.utcnow() + timedelta(minutes=5)}, 
            SECRET_KEY)
            current_app.logger.info("%s logged in successfully", user.username)
            return jsonify({"token": token})
    except Exception as e:
        current_app.logger.info('%s failed to log in', user.username)
        abort(401)


@auth.route("/api/v1/auth/register", methods=["POST"])
def register_user():
    try:
        data = request.get_json(force=True)
        session.add(User(data["username"], data["phone"], 
        data["email"], data["password"]))
        session.commit()
        session.close()
        # msg = Message("Subject", sender="daniilgofman1701@gmail.com", recipients=["daniilgofman1701@gmail.com"])
        # msg.body = "Veryfication link must be here"
        # mail.send(msg)
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")