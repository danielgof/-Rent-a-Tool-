from flask import request, Blueprint
from main import socketio

from controllers.message_controller import *
from setup import *


chat = Blueprint("chat", __name__, url_prefix="/api/v1/chat")
"""
api chat
"""


@chat.route("/send_message", methods=["POST"])
def send_message():
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
                    "text": message.text,
                    "date": message.date,
                }
            )
    return conversation
