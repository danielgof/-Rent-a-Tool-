from flask import current_app, request, Blueprint
import jwt

from controllers.message_controller import *
from controllers.inbox_controller import *
from setup import *


chat = Blueprint("chat", __name__, url_prefix="/api/v1/chat")
"""
api chat
"""


@chat.route("/inbox", methods=["GET"])
def get_all_chats():
    try:
        token = request.headers["Authorization"]
        user_info = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        chats: list = list()
        chats = user_inbox(user_info=user_info)
        return chats
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": f"error {e}"}, 500


@chat.route("/room/<room_id>/", methods=["GET"])
def get_chat_messages(room_id) -> dict:
    """Endpoint to get all messages for particular room"""
    try:
        token = request.headers["Authorization"]
        name = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        res = messages_by_room(room_id=room_id, u_name=name)
        return {"message": "success", "data": res}, 200
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": f"error {e}"}, 500


@chat.route("/save_msg/<room_id>/", methods=["POST"])
def add_msg(room_id) -> dict:
    """Endpoint to receive data with new message"""
    try:
        data = request.get_json(force=True)
        save_message(data=data, room=room_id)
        return {"message": "success"}, 200
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": f"error {e}"}, 500