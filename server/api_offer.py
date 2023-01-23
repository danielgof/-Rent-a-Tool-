from flask import Blueprint, request, jsonify, abort
from datetime import date
from flask import current_app
import os
import logging
from create import session
from db_offer import *

if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f"./log/{date.today()}.log", level=logging.DEBUG)
offer = Blueprint("offer", __name__)

@offer.route("/api/v1/offer/all", methods=["GET"])
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