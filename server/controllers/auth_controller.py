from create import *

"""
create user in database
"""


def add_user(user_name: str, email: str, phone: str, paswd: str) -> None:
    session.add(User(username=user_name, phone=phone, email=email, password=paswd))
    session.commit()
    session.close()
