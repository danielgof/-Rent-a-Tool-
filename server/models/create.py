from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from datetime import date

import db_auth
import db_offer
import db_request
from config_db import *
from base import *

db_name, db_username, db_password = config_db("config.yaml")
engine = create_engine(f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}")
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)

Base.metadata.create_all(engine)
user1 = db_auth.User("JL", "+19993459872", "picard@gmail.com", "NCC-1701-D", 1)
user2 = db_auth.User("test", "+19993452342", "test@testmail.com", "test", 1)

offer1 = db_offer.Offer(
    "tool_name",
    "some description",
    "test location",
    "9000",
    date(2023, 1, 1),
    date(2023, 2, 12),
    "owner name",
    "owner phone number"
)
offer2 = db_offer.Offer(
    "tool_name2",
    "some description2",
    "test location2",
    "1200",
    date(2022, 1, 1),
    date(2022, 2, 12),
    "owner name2",
    "owner phone number2"
)

request1 = db_request.Request(
    "tool_name",
    "some description",
    "test location",
    date(2023, 1, 1),
    date(2023, 2, 12),
    "owner name",
    "owner phone number"
)
request2 = db_request.Request(
    "tool_name2",
    "some description2",
    "test location2",
    date(2022, 1, 1),
    date(2022, 2, 12),
    "owner name2",
    "owner phone number2"
)

user1.offers = [offer1]
user2.offers = [offer2]
user2.requests = [request1, request2]

session = Session()

session.add(user1)
session.add(user2)

session.commit()
session.close()
