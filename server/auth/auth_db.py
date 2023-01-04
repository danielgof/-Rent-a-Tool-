from sqlalchemy import Column, ForeignKey, String, Integer, Date, CHAR
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from datetime import date
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

from auth.config import *

db_name, db_username, db_password = config_db("./auth/config.yaml")

engine = create_engine(f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}")
Session = sessionmaker(bind=engine)
# print("session created succesfully")

"""Create a base class"""
Base = declarative_base()
"""Tables"""
"""Users table"""
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    email = Column(String, nullable=False)
    password = Column(String, nullable=False)
    confirmed = Column(CHAR, nullable=False)
    def __init__(self, username, phone, email, password, confirmed):
        self.username = username
        self.phone = phone
        self.email = email
        self.password = password
        self.confirmed = confirmed


# Base.metadata.create_all(engine)
# session = Session()
# user1 = User("JL", "+1***********", "picard@gmail.com", "NCC-1701-D", 1)
# session.add(user1)
# session.commit()
# session.close()