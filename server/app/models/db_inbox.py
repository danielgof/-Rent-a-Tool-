from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *


class Inbox(Base):
    """Inbox table"""
    __tablename__ = "inbox"
    id = Column(Integer, primary_key=True)
    # u_name = Column(String)
    opponent = Column(String(256), nullable=False)
    room_id = Column(Integer, nullable=False)
    date = Column(Date, nullable=False)
    last_message = Column(String(256), nullable=False)
    # img = Column(String(256), nullable=False)


people_inbox_association = Table(
    "people_inbox",
    Base.metadata,
    Column(
        "user_id",
        Integer,
        ForeignKey("users.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
    Column(
        "inbox_id",
        Integer,
        ForeignKey("inbox.id", ondelete="CASCADE", onupdate="CASCADE"),
    ),
)
