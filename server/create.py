from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from datetime import date
from models.db_auth import *
import models.db_offer as db_offer
from config import *
from base import *


db_name, db_username, db_password = config_db("config.yaml")
engine = create_engine(f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}")
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)

Base.metadata.create_all(engine)
session = Session()
# user1 = User(username="JL", 
#             phone="+19993459872",
#             email="picard@gmail.com", 
#             password="NCC-1701-D",
#             confirmed=1)
# user2 = User(username="test",
#             phone="+19993452342",
#             email="test@testmail.com",
#             password="test",
#             confirmed=1)

# offer1 = db_offer.Offer(
#     "tool_name",
#     "some description",
#     "test location",
#     "9000",
#     date(2023, 1, 1),
#     date(2023, 2, 12),
#     "owner name",
#     "+1893489384389"
# )
# offer2 = db_offer.Offer(
#     "screw driver",
#     "screw driver description",
#     "south gateway",
#     "0",
#     date(2023, 1, 1),
#     date(2023, 2, 12),
#     "Jack",
#     "+1893489384389"
# )
# offer3 = db_offer.Offer(
#     "hammer",
#     "hammer some description",
#     "Fl, Miami",
#     "9000",
#     date(2023, 1, 1),
#     date(2023, 2, 12),
#     "Alexander",
#     "+1893489384389"
# )
# offer4 = db_offer.Offer(
#     "bike",
#     "bike some description",
#     "Mos, Rus",
#     "12",
#     date(2023, 2, 1),
#     date(2023, 2, 12),
#     "Volodya",
#     "+7893489384389"
# )
# offer5 = db_offer.Offer(
#     "Fan",
#     "fan descr.",
#     "Tr, Selifke",
#     "9",
#     date(2023, 2, 11),
#     date(2023, 3, 12),
#     "Dmitry",
#     "+90893489384389"
# )
# offer6 = db_offer.Offer(
#     "printer",
#     "printer descr.",
#     "Mos, Rus",
#     "100",
#     date(2023, 2, 14),
#     date(2023, 4, 12),
#     "Feodr",
#     "+78992839822938"
# )



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

# user1.offers = [offer1]
# user2.offers = [offer2]
# # user2.requests = [request1, request2]

# session = Session()

# session.add(user1)
# session.add(user2)

# session.commit()
# session.close()
