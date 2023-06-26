from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *


class Inbox(Base):
    """Inbox table"""
    __tablename__ = "inbox"
    id = Column(Integer, primary_key=True)
    uid = Column(Integer)
    opponent = Column(String, nullable=False)
    message_text = Column(String, nullable=False)
    img = Column(String, nullable=False)
    date = Column(Date, nullable=False)


people_messges_association = Table(
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
