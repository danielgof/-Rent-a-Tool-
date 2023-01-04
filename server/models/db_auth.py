from sqlalchemy import Column, ForeignKey, String, Integer, Date, CHAR
from sqlalchemy.orm import relationship
from db_offer import *
from db_request import *
from base import *

"""Users table"""
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    email = Column(String, nullable=False)
    password = Column(String, nullable=False)
    confirmed = Column(CHAR, nullable=False)
    offers = relationship("Offer", secondary=people_offers_association)
    requests = relationship("Request", secondary=people_requests_association)

    def __init__(self, username, phone, email, password, confirmed):
        self.username = username
        self.phone = phone
        self.email = email
        self.password = password
        self.confirmed = confirmed

