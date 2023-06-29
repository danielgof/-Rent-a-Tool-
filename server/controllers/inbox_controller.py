from models.db_inbox import *
from create import *


def user_inbox(user_info: str) -> list:
    """get all inbox messages for particular user"""
    user = session.query(User).filter(User.username == user_info).first()
    user_inbox = user.inbox
    responce = []
    for chat in user_inbox:
        responce.append(
            {
                "id": str(chat.id),
                "opponent": chat.opponent,
                "room_id": str(chat.room_id),
                "date": chat.date,
                "last_message": chat.last_message,
                "img": chat.img,
            }
        )
    return responce
