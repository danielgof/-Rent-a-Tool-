from flask import request, Blueprint
from main import socketio

from controllers.message_controller import *
from setup import *


chat = Blueprint("chat", __name__, url_prefix="/api/v1/chat")
"""
api chat
"""


@chat.route("/", methods=["GET"])
def index():
    messages = [
        {"messageContent": "Hello, Will", "messageType": "receiver"},
        {"messageContent": "How have you been?", "messageType": "receiver"},
        {
            "messageContent": "Hey Kriss, I am doing fine dude. wbu?",
            "messageType": "sender",
        },
        {"messageContent": "ehhhh, doing OK.", "messageType": "receiver"},
        {"messageContent": "Is there any thing wrong?", "messageType": "sender"},
        {"messageContent": "test message", "messageType": "sender"},
    ]
    return messages


@chat.route("/send_message", methods=["POST"])
def send_message():
    data = request.get_json(force=True)
    sender = request.json.get("sender")
    recipient = request.json.get("recipient")
    message = request.json.get("message")
    message_data = {"sender": sender, "recipient": recipient, "message": message}
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


@chat.route("/all", methods=["GET"])
def all():
    all: list = all_messages()
    result: list = list()
    for message in all:
        result.append(
            {
                "id": message.id,
                "receiver": message.receiver,
                "sender": message.sender,
                "message_type": message.message_type,
                "text": message.text,
                "date": message.date,
            }
        )
    return result

@chat.route("/user_chats")
def get_all_chats():
    return ""