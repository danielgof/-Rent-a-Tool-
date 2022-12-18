
from os import abort
from flask import Flask, request, jsonify, Blueprint
from flask_login import LoginManager
from flask_login.utils import logout_user
from flask_cors import CORS
from flask_mail import Mail, Message
import jwt
from datetime import datetime, timedelta, date
from functools import wraps
import logging

from db import *
from server.api import *

logging.basicConfig(filename=f'./log/{date.today()}.log', level=logging.DEBUG)

Base.metadata.create_all(engine)
session = Session()

app = Flask(__name__)


@app.route("/api/v1/auth/logout")
@token_required
def logout(current_user):
	logout_user()
	return jsonify({ "message" : "User Logout!" })
"""
rent request api  
"""
@app.route("/api/v1/request/user_requests")
@token_required
def user_requests(current_user):
    try:
        """get data from request"""
        head = request.headers
        token = head["Authorization"]
        data = jwt.decode(token, app.config["SECRET_KEY"], algorithms=['HS256'])
        user = session.query(User).filter(User.username == data["username"]).first()
        requests = session.query(Request) \
            .filter(Request.user_id == user.id).all()
        print(requests)
        res = list()
        for req in requests:
            print(req.tool_name)
            res.append({
            "tool_name": req.tool_name,
            "tool_description": req.tool_description,
            "location": req.location,
            "date_start": req.date_start,
            "date_finish": req.date_finish,
            "owner_name": req.owner_name,
            "phone_number": req.phone_number
            })
        return res, 200

    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/request/add", methods=["POST"])
@token_required
def add_request(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """create session to isert data into Request table"""
        session.add(
            Request(data["toolName"], data["toolDescription"], 
            data["location"], 
            datetime.strptime(data["dateStart"], "%m/%d/%Y").date(), 
            datetime.strptime(data["dateFinish"], "%m/%d/%Y").date(), 
            data["ownerName"], data["phoneNumber"]))
        """add data to db"""
        session.commit()
        # session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")
 

@app.route("/api/v1/request/update", methods=["PUT"])
@token_required
def upd_request(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """create session to isert data into Request table"""
        session.query(Request) \
            .filter(Request.id == data["id"]) \
            .update({Request.tool_description: data["toolDescription"]})
        """add data to db"""
        session.commit()
        # session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/request/delete", methods=["DELETE"])
@token_required
def delete_request(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """delete user by username"""
        session.query(Request) \
            .filter(Request.id == data["id"]).delete()
        """add data to db"""
        session.commit()
        # session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")
"""
rent offer api
"""
@app.route("/api/v1/offer/add", methods=["POST"])
@token_required
def add_offer(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """create session to isert data into Offer table"""
        session.add(Offer(data["toolName"], data["toolDescription"], 
        data["location"], data["price"], 
        datetime.strptime(data["dateStart"], "%m/%d/%Y").date(), 
        datetime.strptime(data["dateFinish"], "%m/%d/%Y").date(), 
        data["ownername"], data["phoneNumber"]))
        """add data to db"""
        session.commit()
        session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/offer/update", methods=["PUT"])
@token_required
def upd_offer(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """create session to isert data into Offer table"""
        session.query(Offer) \
            .filter(Offer.id == data["id"]) \
            .update({Offer.tool_description: data["toolDescription"]})
        """add data to db"""
        session.commit()
        session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/offer/delete", methods=["DELETE"])
@token_required
def delete_offer(current_user):
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """delete user by username"""
        session.query(Offer) \
            .filter(Offer.id == data["id"]).delete()
        """add data to db"""
        session.commit()
        session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


# if __name__ == "__main__":
#     app.run(debug=True)