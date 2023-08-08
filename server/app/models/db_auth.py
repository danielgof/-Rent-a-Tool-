from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from models.db_offer import *
from models.db_message import *
from models.db_inbox import *
from base import *
from config import *
from images import *


class User(Base):
    """Users table"""
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String(256), nullable=False)
    phone = Column(String(256), nullable=False)
    email = Column(String(256), nullable=False)
    password = Column(String(256))
    confirmed = Column(Integer, default=0)
    img = Column(TEXT, nullable=False, default=PLACEHOLDER)
    offers = relationship("Offer", secondary=people_offers_association)
    inbox = relationship("Inbox", secondary=people_inbox_association)
