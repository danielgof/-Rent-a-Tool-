from flask import current_app, request, Blueprint
import jwt
from flask_socketio import join_room, leave_room, send

from controllers.message_controller import *
from controllers.inbox_controller import *
from setup import *
from main import socketio


chat = Blueprint("chat", __name__, url_prefix="/api/v1/chat")
"""
api chat
"""


@chat.route("/send_message", methods=["POST"])
def send_message():
    data = request.get_json(force=True)
    sender = request.json.get("sender")
    recipient = request.json.get("recipient")
    message = request.json.get("message")
    message_data = {"sender": sender,
                    "recipient": recipient, "message": message}
    save_message(request.json)
    socketio.emit("new_message", message_data)
    return {"message": "Message sent successfully!"}


@chat.route("/messages", methods=["GET"])
def get_messages():
    sender = request.args.get("sender")
    receiver = request.args.get("recipient")
    messages = all_messages()
    conversation = list()
    for message in messages:
        if message.receiver == receiver and message.sender == sender:
            conversation.append(
                {
                    "id": message.id,
                    "receiver": message.receiver,
                    "sender": message.sender,
                    "message_type": message.message_type,
                    "text": message.text,
                    "date": message.date,
                }
            )
    return conversation


@socketio.on('message')
def handle_message(data):
    print('received message: ' + data["message"])


@socketio.on('join')
def on_join(data):
    username = data['username']
    room = data['room']
    join_room(room)
    send(username + ' has entered the room.', to=room)


@socketio.on('leave')
def on_leave(data):
    try:
        username = data['username']
        room = data['room']
        leave_room(room)
        send(username + ' has left the room.', to=room)
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": "error"}, 500


@chat.route("/inbox", methods=["GET"])
def get_all_chats():
    try:
        token = request.headers["Authorization"]
        user_info = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        chats: list = list()
        # print(user_info)
        chats = user_inbox(user_info=user_info)
        return chats
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": "error"}, 500


@chat.route("/room/<room_id>/", methods=["GET"])
def get_chat_messages(room_id) -> dict:
    try:
        token = request.headers["Authorization"]
        name = jwt.decode(token, SECRET_KEY, algorithms=[
            "HS256"])["username"]
        res = messages_by_room(room_id=room_id, u_name=name)
        return {"message": "success", "data": res}, 200
    except Exception as e:
        current_app.logger.info("failed to load messages")
        return {"message": "error"}, 500
