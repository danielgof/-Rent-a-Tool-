from sqlalchemy import Column, ForeignKey, String, Integer, Date, CHAR, DateTime
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from datetime import date
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

from config import *

db_name, db_username, db_password = config("config.yaml")

engine = create_engine(f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}")
Session = sessionmaker(bind=engine)
print("session created succesfully")

"""Create a base class"""
Base = declarative_base()
"""Tables"""
"""1.Request table"""
class Request(Base):
    __tablename__ = "request"
    id = Column(Integer, primary_key=True)
    tool_name = Column(String)
    tool_description = Column(String)
    location = Column(String)
    date_start = Column(Date)
    date_finish = Column(Date)
    owner_name = Column(String)
    phone_number = Column(String)

    def __init__(self, tool_name, tool_description, location, date_start,
                date_finish, owner_name, phone_number):
        self.tool_name = tool_name
        self.tool_description = tool_description
        self.location = location
        self.date_start = date_start
        self.date_finish = date_finish
        self.owner_name = owner_name
        self.phone_number = phone_number

"""2.Offer table"""
class Offer(Base):
    __tablename__ = "offer"
    id = Column(Integer, primary_key=True)
    tool_name = Column(String)
    tool_description = Column(String)
    location = Column(String)
    price = Column(String)
    date_start = Column(Date)
    date_finish = Column(Date)
    owner_name = Column(String)
    phone_number = Column(String)

    def __init__(self, tool_name, tool_description, location, price, date_start,  
                date_finish, owner_name, phone_number):
        self.tool_name = tool_name
        self.tool_description = tool_description
        self.location = location
        self.price = price
        self.date_start = date_start
        self.date_finish = date_finish
        self.owner_name = owner_name
        self.phone_number = phone_number

"""3.Users table"""
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String)
    phone = Column(String)
    email = Column(String)
    password = Column(String)

    def __init__(self, username, phone, email, password):
        self.username = username
        self.phone = phone
        self.email = email
        self.password = password
            

# Base.metadata.create_all(engine)
# session = Session()
# # users = session.query(User) \
# #     .filter(User.username == "test")
# # for user in users:
# #     print(user.email)    

# # datetime.strptime('18/09/2019', "%m/%d/%Y")
# """add some test data"""
# request1 = Request("hammer", "ordinary hammer", "Nikolino", date(2023, 10, 11), 
#             datetime.strptime('08/09/2019', "%m/%d/%Y").date(), "Volodya", "+7**********")
# request2 = Request("stair", "stair for repairment", "Nikolino", date(2023, 11, 11), 
#             date(2023, 12, 15), "Boris", "+7**********")

# # offer1 = Offer("car washer", "car washer", "Nikolino", "200", date(2023, 10, 11), 
# #             date(2023, 10, 15), "-", "+7**********")
# # offer2 = Offer("bike", "bike stels", "Nikolino", "800", date(2023, 10, 11), 
# #             date(2023, 10, 15), "Mikhail", "+7**********")

# user1 = User("JL", "+1***********", "picard@gmail.com", "NCC-1701-D")

# session.add(request1)
# session.add(request2)
# # session.add(offer1)
# # session.add(offer2)
# session.add(user1)
# session.commit()
# session.close()

