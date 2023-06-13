import base64
from io import BytesIO
# import io
from flask import Blueprint, request, jsonify, abort, send_file, Response
from flask_cors import CORS
from werkzeug.wsgi import wrap_file
# from flask_mail import Mail, Message
from functools import wraps
from datetime import date, datetime, timedelta
from flask import current_app
import jwt
import os
import logging
from controllers.auth_controller import *
from create import *
from config import *
from security import *
from werkzeug.wsgi import FileWrapper

auth = Blueprint("auth", __name__, url_prefix="/api/v1/auth")
# SECRET_KEY, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD, MAIL_USE_TLS, MAIL_USE_SSL = config_auth("./config.yaml")
# mail = Mail(Auth)
"""
auth api
"""


@auth.route("/login", methods=["POST", "GET"])
def login() -> dict:
    """Login users"""
    try:
        data = request.get_json(force=True)
        user = session.query(User).filter(
            User.username == data["username"]).first()
        if user and data["password"] == user.password:
            token = jwt.encode(
                {
                    "username": data["username"],
                    "email": user.email,
                    "phone": user.phone,
                    "pass": user.password,
                    "exp": datetime.utcnow() + timedelta(days=365),
                },
                SECRET_KEY,
            )
            current_app.logger.info("%s logged in successfully", user.username)
            return {"status": "success", "token": token}, 200
        else:
            return {"status": "User not found"}, 404
    except Exception as e:
        current_app.logger.info("%s failed to log in", user.username)
        return {"message": "error"}, 500


@auth.route("/register", methods=["POST"])
def register_user() -> dict:
    """Register user in database"""
    try:
        data = request.get_json(force=True)
        add_user(data["username"], data["phone"],
                 data["email"], data["password"])
        # msg = Message("Subject", sender="daniilgofman1701@gmail.com", recipients=["daniilgofman1701@gmail.com"])
        # msg.body = "Veryfication link must be here"
        # mail.send(msg)
        return {"message": "success"}, 200
    except Exception as e:
        current_app.logger.info("Failed to register user %s", data["username"])
        return {"message": "error"}, 500


@auth.route("/upd", methods=["PUT"])
def upd_username() -> dict:
    """Updates user info"""
    try:
        data = request.get_json(force=True)
        """extracting values from json"""
        uname: str = data["username"]
        new_uname: str = data["new_uname"]
        email: str = data["email"]
        phone: str = data["phone"]
        passwd: str = data["passwd"]
        if (new_uname != ""):
            upd_uname(uname=uname, new_uname=new_uname)
        if (email != ""):
            upd_email(uname=uname, email=email)
        if (phone != ""):
            upd_phone(uname=uname, phone=phone)
        if (passwd != ""):
            upd_passwd(uname=uname, passwd=passwd)
        return {"message": "updated"}, 200
    except Exception as e:
        return {"message": e}, 500


@auth.route("/save_avatar", methods=["POST"])
def save_avtr() -> dict:
    try:
        token = request.headers["Authorization"]
        # print(request.get_data())
        img = request.files["logo"]
        # print(io.BytesIO(img))
        # print(img.__str__)
        uname: str = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        # print(uname)
        # data = request.get_json(force=True)
        save_avatar(img=img, username=uname)
        return {"message": "saved"}, 200
    except Exception as e:
        return {"message": e}, 500


@auth.route("/avatar", methods=["GET"])
def get_avtr() -> dict:
    try:
        home_path = os.getcwd()
        token = request.headers["Authorization"]
        uname: str = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        # with open(f"images/users/{uname}/user.png", "r") as file:
        #     res = file
        os.chdir(f"./images/users/{uname}")
        files = os.listdir()
        avatar: str = files[1]
        file = open(avatar, "rb")
        encoded_string = base64.b64encode(file.read())
        # print(file.read())
        # b = BytesIO(file)
        # res = BytesIO()

        # w = FileWrapper(encoded_string)
        # print(w)
        # with open(f"images/users/{uname}/{avatar}", "r") as fh:
        #     buf = fh.read()
        # w = wrap_file(buf)
        os.chdir(home_path)
        # return {"image": file.read()}, 200
        return Response(encoded_string, direct_passthrough=True, mimetype="text/plain")
        # return send_file(f"images/users/{uname}/{avatar}")
    except Exception as e:
        return {"message": e}, 500


@auth.route('/')
def hello_world():
    b = BytesIO(b"blah blah blah")
    print(b)
    w = FileWrapper(b)
    print(w)
    return Response(w, mimetype="text/plain", direct_passthrough=True)
