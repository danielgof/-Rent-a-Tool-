from flask import Blueprint, request, jsonify, abort
from datetime import date
from flask import current_app
import os
import logging
from server.api.create import session
from models.db_offers import Offer

if not os.path.isdir("./log"):
    os.mkdir("./log")
logging.basicConfig(filename=f'./log/{date.today()}.log', level=logging.DEBUG)
offer = Blueprint("offer", __name__)

@offer.route("/api/v1/offer/all", methods=["GET"])
def get_all_offers():
    try:
        offers = session.db_offers.Offer().all()
        print(offers)
        return jsonify({"res": offers})
    except Exception as e:
        current_app.logger.info('exception: ', e)
        abort(500)  