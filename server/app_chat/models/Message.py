from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *

"""Offer table"""


class Message(Base):
    """Class to represent 'Message' entity"""
    __tablename__ = "Message"
    id = Column(Integer, primary_key=True)
    room_id = Column(Integer, nullable=False)
    user_name = Column(String(256), nullable=False)
    date = Column(Date, nullable=False)
    message = Column(String(256), nullable=False)
