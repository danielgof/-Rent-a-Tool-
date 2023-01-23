from flask import Blueprint, request, jsonify, abort
from datetime import date
from flask import current_app
import os
import jwt
from functools import wraps
import logging
from create import session
from db_offer import *
from db_auth import *
from create import *
from config import *

SECRET_KEY, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD, MAIL_USE_TLS, MAIL_USE_SSL = config_auth("./config.yaml")


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


if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f"./log/{date.today()}.log", level=logging.DEBUG)
offer = Blueprint("offer", __name__)


@offer.route("/api/v1/offer/all_all", methods=["GET"])
@token_required
def get_all_offers():
    try:
        offers = session.query(Offer).all()
        responce = []
        for offer in offers:
            responce.append({
                "id":offer.id,
                "tool_name": offer.tool_name ,
                "tool_description": offer.tool_description ,
                "location": offer.location ,
                "price": offer.price ,
                "date_start": offer.date_start ,
                "date_finish": offer.date_finish,
                "owner_name": offer.owner_name,
                "phone_number": offer.phone_number
            })
        return responce
        # return jsonify({"result": offers}) 
    except Exception as e:
        current_app.logger.info('exception: ', e)
        abort(500)  


@offer.route("/api/v1/offer/save", methods=["POST"])
@token_required
def save_offer(current_user):
    token = request.headers["Authorization"]
    data = request.get_json()
    user_info = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])["username"]
    user = session.query(User).filter(User.username == user_info).first()
    user_offers = user.offers
    offer = Offer(
        data["tool_name"], data["tool_description"], 
        data["location"], data["price"], data["date_start"],
        data["date_finish"], data["owner_name"], data["phone_number"]
    )
    user_offers.append(offer)
    session.add(offer)
    session.commit()
    # print(user_offers)
    return "success"


@offer.route("/api/v1/offer/all", methods=["GET"])
@token_required
def get_all_user_offers(current_user):
    token = request.headers["Authorization"]
    user_info = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])["username"]
    user = session.query(User).filter(User.username == user_info).first()
    user_offers = user.offers
    print(user_offers)
    responce  = []
    for offer in user_offers:
        responce.append({
            "tool_name": offer.tool_name,
            "tool_description": offer.tool_description,
            "location": offer.location,
            "price": offer.price,
            "date_start": offer.date_start,
            "date_finish": offer.date_finish,
            "owner_name": offer.owner_name,
            "phone_number": offer.phone_number
        })
    print(responce)
    return jsonify({"result": responce})