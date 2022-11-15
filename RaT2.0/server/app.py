from flask import Flask, request, jsonify
from flask_login import LoginManager, login_user, login_required, current_user, login_fresh
from flask_login.utils import logout_user
import datetime

from db import *

Base.metadata.create_all(engine)
session = Session()

app = Flask(__name__)

login_manager = LoginManager(app)
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
            cookieDuration = datetime.timedelta(seconds = 10)
            login_user(user, remember=True, duration=cookieDuration)
            return jsonify({ "isAuth" : True })

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
def add_request():
    try:
        """get data from request"""
        data = request.get_json(force=True)
        """create session to isert data into Request table"""
        session.add(Request(data["toolName"], data["toolDescription"], 
        data["location"], datetime.strptime(data["dateStart"], "%m/%d/%Y") , datetime.strptime(data["dateFinish"], "%m/%d/%Y"), 
        data["ownerName"], data["phoneNumber"]))
        """add data to db"""
        session.commit()
        session.close()
        return jsonify(200, "OK")
    except Exception as e:
        return jsonify(403, f"Error occured in {e}")
 
@app.route("/api/v1/request/update", methods=["PUT"])
def upd_request():
    res = request.get_json(force=True)
    print(res)
    return "see data to upd"

@app.route("/api/v1/request/delete", methods=["DELETE"])
def delete_request():
    res = request.get_json(force=True)
    print(res.get("id"))
    return "should be deleting request with id"

"""
rent offer api
"""
@app.route("/api/v1/offer/add", methods=["POST"])
def add_offer():
    data = request.get_json(force=True)
    print(data)
    return "see console log"

@app.route("/api/v1/offer/update", methods=["PUT"])
def upd_offer():
    res = request.get_json(force=True)
    print(res)
    return "see data to upd"

@app.route("/api/v1/offer/delete", methods=["DELETE"])
def delete_offer():
    res = request.get_json(force=True)
    print(res.get("id"))
    return "should be deleting request with id"

if __name__ == "__main__":
    app.run()