from models.db_message import *
from create import *


"""
Save message to sender and to receiver
"""


def save_message(data: dict) -> bool:
    status: bool = False
    receiver: User = (
        session.query(User).filter(User.username == data.get("recipient")).first()
    )
    sender: User = (
        session.query(User).filter(User.username == data.get("sender")).first()
    )
    receiver_messages: list = receiver.messages
    sender_messages: list = sender.messages
    message = Message(
        receiver=data.get("recipient"),
        sender=data.get("sender"),
        text=data.get("text"),
        date=data.get("date"),
    )
    receiver_messages.append(message)
    sender_messages.append(message)
    session.add(message)
    session.commit()
    return status


"""
Get all availabel messages
"""


def all_messages() -> list:
    return session.query(Message).all()
