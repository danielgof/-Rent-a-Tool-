from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *

"""Offer table"""


class Offer(Base):
    __tablename__ = "offer"
    id = Column(Integer, primary_key=True)
    tool_name = Column(String(256), nullable=False)
    tool_description = Column(String(256), nullable=False)
    lat = Column(String(256), nullable=False)
    lng = Column(String(256), nullable=False)
    price = Column(String(256), nullable=False)
    date_start = Column(Date, nullable=False)
    date_finish = Column(Date, nullable=False)
    owner_name = Column(String(256), nullable=False)
    phone_number = Column(String(256), nullable=False)


people_offers_association = Table(
    "people_offers",
    Base.metadata,
    Column(
        "user_id",
        Integer,
        ForeignKey("users.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
    Column(
        "offer_id",
        Integer,
        ForeignKey("offer.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
)
