from flask import Blueprint, request, abort, Response
from flask import current_app
import jwt
from models.db_offer import *
from models.db_auth import *
from create import *
from config import *
from setup import *
from security import *
from controllers.offer_controller import *

offer = Blueprint("offer", __name__, url_prefix="/api/v1/offer")


"""
api offer
"""


@offer.route("/all_all", methods=["GET"])
# @token_required
# def get_all_offers(current_user):
def get_all_offers() -> dict:
    try:
        responce = all_offers()
        return {"status": "success", "data": responce}, 200
    except Exception as e:
        current_app.logger.info("exception: ", e)
        return {"message": f"error {e}"}, 500


@offer.route("/save", methods=["POST"])
@token_required
def save_offer(current_user) -> dict:
    try:
        if not request.get_json(force=True):
            abort(400)
        token = request.headers["Authorization"]
        data = request.get_json(force=True)
        user_info = jwt.decode(token, SECRET_KEY, algorithms=[
                               "HS256"])["username"]
        add_offer_to_user(username=user_info, data=data)
        return {"status": "success"}, 200
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500


@offer.route("/all", methods=["GET"])
@token_required
def get_all_user_offers(current_user) -> dict:
    try:
        token = request.headers["Authorization"]
        user_info = jwt.decode(token, SECRET_KEY, algorithms=[
                               "HS256"])["username"]
        responce = all_offers_user(user_info=user_info)
        return {"data": responce}
    except Exception as e:
        current_app.logger.info("failed to log in")
        return {"message": f"error {e}"}, 500


@offer.route("/delete", methods=["DELETE"])
@token_required
def delete_offer(current_user) -> dict:
    try:
        if not request.get_json(force=True):
            abort(400)
        data_id = request.get_json(force=True)
        result = delete_offer_by_id(data=data_id)
        if result:
            return {"status": "success"}, 200
        else:
            return {"status": "error"}, 404
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500


@offer.route("/upd", methods=["PUT"])
@token_required
def update_offer(current_user) -> dict:
    try:
        if not request.get_json(force=True):
            abort(400)
        new_offer = request.get_json(force=True)
        upd_offer_by_id(data=new_offer)
        return {"status": "success"}, 200
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500


@offer.route("/query", methods=["POST"])
def query_offer() -> dict:
    try:
        if not request.get_json(force=True):
            abort(400)
        data = request.get_json(force=True)
        query = data["query"]
        res: list = list()
        res = offers_by_query(query=query)
        return {"status": "success", "data": res}, 200
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500


@offer.route("/save_logo", methods=["POST"])
def save_logo() -> dict:
    try:
        home_dir = os.getcwd()
        token = request.headers["Authorization"]
        img = request.files["logo"]
        uname: str = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        if not os.path.exists(f"images/offers/{uname}/"):
            os.mkdir(f"images/offers/{uname}/")
        os.chdir(f"images/offers/{uname}/")
        filename = secure_filename(img.filename)
        img.save(filename)
        os.chdir(home_dir)
        return {"message": "saved"}, 200
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500


@offer.route("/logo", methods=["POST", "GET"])
def get_offer_logo() -> dict:
    try:
        home_path = os.getcwd()
        logo = request.get_json()["img"]
        data = {}
        os.chdir(f"./images/offers/")
        unames = os.listdir()
        for user in unames:
            os.chdir(f"./{user}/")
            tmp_files = os.listdir()
            data[user] = tmp_files
            os.chdir("..")
        for f in data:
            for _ in data[f]:
                if (_ == logo):
                    user = f
                    avatar = _
        os.chdir(f"./{user}/")
        file = open(avatar, "rb")
        encoded_string = base64.b64encode(file.read())
        os.chdir(home_path)
        return Response(encoded_string, direct_passthrough=True, mimetype="text/plain")
    except Exception as e:
        current_app.logger.info(f"exeption {e}")
        return {"message": f"error {e}"}, 500
