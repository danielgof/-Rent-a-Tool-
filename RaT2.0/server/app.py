from flask import Flask, request, jsonify
from flask_login import LoginManager, login_user, login_required, current_user, login_fresh
from flask_login.utils import logout_user
import jwt
from datetime import datetime, timedelta
from functools import wraps

from db import *

Base.metadata.create_all(engine)
session = Session()

app = Flask(__name__)

app.config["SECRET_KEY"] = "supersecretkey"

login_manager = LoginManager(app)

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.args.get("token")

        if not token:
            return jsonify({"message":"token is missing"}), 403

        try:
            data = jwt.decode(token, app.config["SECRET_KEY"])
        except:
            return jsonify({"message":"token is invalid"}), 402
        return f(*args, **kwargs)

    return decorated
"""
auth api
"""
@app.route("/api/v1/auth/register", methods=["POST"])
def register_user():
    try:
        data = request.get_json(force=True)
        session.add(User(data["username"], data["phone"], 
        data["email"], data["password"]))
        session.commit()
        session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/auth/login", methods=["POST", "GET"])
def login():
    try:
        data = request.get_json(force=True)

        user = session.query(User) \
            .filter(User.username == data["username"]).first()
        if user:
            token = jwt.encode({"username": data["username"], 
            "exp": datetime.utcnow() + timedelta(minutes=5)}, 
            app.config["SECRET_KEY"])
            return jsonify({"isAuth": token})

    except Exception as e:
        return jsonify(403, f"Error occured in {e}")


@app.route("/api/v1/auth/logout")
@login_required
def logout():
	logout_user()
	return jsonify({ "message" : "User Logout!" })
"""
rent request api  
"""
@app.route("/api/v1/request/add", methods=["POST"])
@token_required
def add_request():
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
def upd_request():
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
def delete_request():
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
def add_offer():
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
def upd_offer():
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
def delete_offer():
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


if __name__ == "__main__":
    app.run()