from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from models.db_offer import *
from base import *

"""Users table"""
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String, nullable=False)
    phone = Column(String, nullable=False)
    email = Column(String, nullable=False)
    password = Column(String)
    confirmed = Column(Integer, default=0)
    offers = relationship("Offer", secondary=people_offers_association)
    

    # def __init__(self, username, phone, email, password, confirmed):
    #     self.username = username
    #     self.phone = phone
    #     self.email = email
    #     self.password = password
    #     self.confirmed = confirmed

