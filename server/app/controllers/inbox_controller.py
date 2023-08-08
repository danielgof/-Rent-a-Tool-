from models.db_inbox import *
from controllers.message_controller import *
from create import *


def user_inbox(user_info: str) -> list:
    """get all inbox messages for particular user"""
    user = session.query(User).filter(User.username == user_info).first()
    user_inbox = user.inbox
    responce = []
    for chat in user_inbox:
        messages = messages_by_room(room_id=chat.room_id, u_name=user_info)
        responce.append(
            {
                "id": chat.id,
                "opponent": chat.opponent,
                "room_id": chat.room_id,
                "date": chat.date,
                "last_message": messages[-1]["messageContent"],
            }
        )
    return responce


