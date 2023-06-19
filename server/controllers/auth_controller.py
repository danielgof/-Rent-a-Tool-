from create import *
from werkzeug.utils import secure_filename
import os


def add_user(user_name: str, email: str, phone: str, paswd: str) -> None:
    """create user in database"""
    session.add(User(username=user_name, phone=phone,
                email=email, password=paswd))
    session.commit()
    session.close()


"""
Update user's details section
"""


def upd_uname(uname: str, new_uname: str):
    """updates user's name"""
    res: bool
    user: User = session.query(User).filter(User.username == uname).first()
    if user:
        session.query(User).filter(User.username == uname).update(
            {
                User.username: new_uname
            },
            synchronize_session=False,
        )
        session.commit()
        res = True
    else:
        res = False
    return res


def upd_email(uname: str, email: str) -> bool:
    """updates user's email"""
    res: bool
    user: User = session.query(User).filter(User.username == uname).first()
    if user:
        session.query(User).filter(User.username == uname).update(
            {
                User.email: email
            },
            synchronize_session=False,
        )
        session.commit()
        res = True
    else:
        res = False
    return res


def upd_phone(uname: str, phone: str) -> bool:
    """updates user's phone"""
    res: bool
    user: User = session.query(User).filter(User.username == uname).first()
    if user:
        session.query(User).filter(User.username == uname).update(
            {
                User.phone: phone
            },
            synchronize_session=False,
        )
        session.commit()
        res = True
    else:
        res = False
    return res


def upd_passwd(uname: str, passwd: str) -> bool:
    """updates user's password"""
    res: bool
    user: User = session.query(User).filter(User.username == uname).first()
    if user:
        session.query(User).filter(User.username == uname).update(
            {
                User.password: passwd
            },
            synchronize_session=False,
        )
        session.commit()
        res = True
    else:
        res = False
    return res


def save_avatar(img, username: str) -> bool:
    """Saves avatar to folder with the same name as user's name"""
    res: bool = False
    # print(img)
    home_dir: str = os.getcwd()
    print("before: %s", os.getcwd())
    if not os.path.exists(f"images/users/{username}"):
        os.mkdir(f"images/users/{username}")
    os.chdir(f"images/users/{username}")
    filename = secure_filename(img.filename)
    print(len(os.listdir()))
    img.save(f"{len(os.listdir())+1}_"+filename)
    res = True
    os.chdir(home_dir)
    print("after: %s", os.getcwd())
    # print(os.getcwd())
    return res
