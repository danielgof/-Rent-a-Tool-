from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *

"""Offer table"""


class Message(Base):
    __tablename__ = "message"
    id = Column(Integer, primary_key=True)
    receiver = Column(String, nullable=False)
    sender = Column(String, nullable=False)
    message_type = Column(String, nullable=False)
    text = Column(String, nullable=False)
    date = Column(Date, nullable=False)


people_messges_association = Table(
    "people_messages",
    Base.metadata,
    Column(
        "user_id",
        Integer,
        ForeignKey("users.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
    Column(
        "message_id",
        Integer,
        ForeignKey("message.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
)
