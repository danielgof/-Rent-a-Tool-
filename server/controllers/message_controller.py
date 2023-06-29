from models.db_message import *
from create import *


def save_message(data: dict) -> bool:
    """Save message to sender and to receiver"""
    status: bool = False
    receiver: User = (
        session.query(User).filter(User.username ==
                                   data.get("recipient")).first()
    )
    sender: User = (
        session.query(User).filter(User.username == data.get("sender")).first()
    )
    receiver_messages: list = receiver.messages
    sender_messages: list = sender.messages
    message = Message(
        receiver=data.get("recipient"),
        sender=data.get("sender"),
        message_type=data.get("message_type"),
        text=data.get("text"),
        date=data.get("date"),
    )
    receiver_messages.append(message)
    sender_messages.append(message)
    session.add(message)
    session.commit()
    return status


def all_messages() -> list:
    """Get all availabel messages"""
    return session.query(Message).all()


def user_messages(username: str) -> list:
    """return all messages for particular user"""
    result: list = list()
    messages = all_messages()
    for message in messages:
        if message.receiver == username and message.sender == username:
            result.append(message)
    return result


def messages_by_room(room_id: int, u_name: str) -> list:
    """return all messages by given id"""
    return [{
            "id": message.id,
            "room_id": message.room_id,
            "messageType": "sender",
            "date": message.date,
            "messageContent": message.message,
            }
            if message.user_name == u_name else {
            "id": message.id,
            "room_id": message.room_id,
            "messageType": "receiver",
            "date": message.date,
            "messageContent": message.message,
            }
            for message in session.query(Message).filter(Message.room_id == room_id).all()]

    # {
    #     "id": message.id,
    #     "room_id": message.room_id,
    #     "username": message.user_name,
    #     "date": message.date,
    #     "message": message.message,
    # }
