from flask import request, Blueprint
from main import socketio

from setup import *


chat = Blueprint("chat", __name__, url_prefix="/api/v1/chat")
"""
api chat
"""
messages = []


@chat.route("/send_message", methods=["POST"])
def send_message():
    sender = request.json.get("sender")
    recipient = request.json.get("recipient")
    message = request.json.get("message")
    message_data = {"sender": sender, "recipient": recipient, "message": message}
    messages.append(message_data)
    socketio.emit("new_message", message_data)
    return {"message": "Message sent successfully!"}


@chat.route("/messages", methods=["GET"])
def get_messages():
    sender = request.args.get("sender")
    recipient = request.args.get("recipient")
    conversation = [
        m for m in messages if m["sender"] == sender and m["recipient"] == recipient
    ]
    return conversation
