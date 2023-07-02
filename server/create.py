from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from datetime import date
from models.db_auth import *
import models.db_offer as db_offer
from models.db_message import *
from models.db_inbox import *
from config import *
from base import *


db_name, db_username, db_password = config_db("config_local.yaml")
# db_name, db_username, db_password = config_db("config.yaml")
# engine = create_engine(
#     f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}"
# )
# engine = create_engine(
#     f"postgresql://{db_username}:{db_password}@ep-curly-mountain-716247.us-east-2.aws.neon.tech/{db_name}"
# )
engine = create_engine(
    "mysql+pymysql://brodon:admin@brodon.mysql.pythonanywhere-services.com/brodon$rt?charset=utf8mb4",
    pool_recycle=280
)

Session = sessionmaker(bind=engine)
Base.metadata.create_all(engine)
session = Session()

user1 = User(
    username="JL",
    phone="+19993459872",
    email="picard@gmail.com",
    password="NCC-1701-D",
    confirmed=1,
)
user2 = User(
    username="test",
    phone="+19993452342",
    email="test@testmail.com",
    password="test",
    confirmed=1,
)
user3 = User(
    username="WRicker",
    phone="1234567890",
    email="wr@starfleet.com",
    password="key",
    confirmed=1
)

offer1 = db_offer.Offer(
    tool_name="tool_name",
    tool_description="some description",
    lat="44.9",
    lng="4.9",
    price="9000",
    date_start=date(2023, 1, 1),
    date_finish=date(2023, 2, 12),
    owner_name="owner name",
    phone_number="+1893489384389"
)
offer2 = db_offer.Offer(
    tool_name="screw driver",
    tool_description="screw driver description",
    lat="47.9",
    lng="2.2",
    price="0",
    date_start=date(2023, 1, 1),
    date_finish=date(2023, 2, 12),
    owner_name="Jack",
    phone_number="+1893489384389"
)
offer3 = db_offer.Offer(
    tool_name="hammer",
    tool_description="hammer some description",
    lat="50.5",
    lng="0.78",
    price="9000",
    date_start=date(2023, 1, 1),
    date_finish=date(2023, 2, 12),
    owner_name="Alexander",
    phone_number="+1893489384389"
)
offer4 = db_offer.Offer(
    tool_name="bike",
    tool_description="bike some description",
    lat="48.9",
    lng="2.1",
    price="12",
    date_start=date(2023, 2, 1),
    date_finish=date(2023, 2, 12),
    owner_name="Volodya",
    phone_number="+7893489384389"
)
offer5 = db_offer.Offer(
    tool_name="Fan",
    tool_description="fan descr.",
    lat="60",
    lng="5",
    price="9",
    date_start=date(2023, 2, 11),
    date_finish=date(2023, 3, 12),
    owner_name="Dmitry",
    phone_number="+90893489384389"
)
offer6 = db_offer.Offer(
    tool_name="printer",
    tool_description="printer descr.",
    lat="50",
    lng="3",
    price="100",
    date_start=date(2023, 2, 14),
    date_finish=date(2023, 4, 12),
    owner_name="Feodr",
    phone_number="+78992839822938"
)

inbox1 = Inbox(
    opponent="Will Ricker",
    room_id=1,
    date=date(2023, 2, 14),
    last_message="how are you?",
    img="https://randomuser.me/api/portraits/men/5.jpg",
)

inbox2 = Inbox(
    opponent="test",
    room_id=2,
    date=date(2263, 2, 14),
    last_message="meet you at shuttle bay",
    img="https://randomuser.me/api/portraits/men/4.jpg",
)

inbox3 = Inbox(
    opponent="JL",
    room_id=2,
    date=date(2263, 2, 14),
    last_message="meet you at shuttle bay",
    img="https://randomuser.me/api/portraits/men/4.jpg",
)

messages = [
    Message(
        user_name="JL",
        room_id=1,
        date=date(2023, 2, 14),
        message="Hello, Will"
    ),
    Message(
        user_name="JL",
        room_id=1,
        date=date(2023, 2, 14),
        message="How have you been?"
    ),
    Message(
        user_name="WRicker",
        room_id=1,
        date=date(2023, 2, 14),
        message="Hey JL, I am doing fine dude."
    ),
    Message(
        user_name="WRicker",
        room_id=1,
        date=date(2023, 2, 14),
        message="How have you been so far?"
    ),
    Message(
        user_name="JL",
        room_id=1,
        date=date(2023, 2, 14),
        message="Just outer space missions.."
    ),
    Message(
        user_name="JL",
        room_id=2,
        date=date(2023, 2, 14),
        message="Hey, it JL. I need your help."
    ),
    Message(
        user_name="test",
        room_id=2,
        date=date(2023, 2, 14),
        message="No problem."
    ),
]

# # request1 = db_request.Request(
# #     "tool_name",
# #     "some description",
# #     "test location",
# #     date(2023, 1, 1),
# #     date(2023, 2, 12),
# #     "owner name",
# #     "owner phone number"
# # )
# # request2 = db_request.Request(
# #     "tool_name2",
# #     "some description2",
# #     "test location2",
# #     date(2022, 1, 1),
# #     date(2022, 2, 12),
# #     "owner name2",
# #     "owner phone number2"
# # )

user1.offers = [offer1, offer3]
user2.offers = [offer2, offer4, offer5, offer6]
user1.inbox = [inbox1, inbox2]
user2.inbox = [inbox3]
# # user2.requests = [request1, request2]

# user1.messages = [message1, message2]

session = Session()
session.add_all(messages)

session.add(user1)
session.add(user2)

session.commit()
session.close()
