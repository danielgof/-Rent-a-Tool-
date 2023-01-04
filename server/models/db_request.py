from sqlalchemy import Column, ForeignKey, String, Integer, Date, Table
from base import *

"""Request table"""
class Request(Base):
    __tablename__ = "request"
    id = Column(Integer, primary_key=True)
    tool_name = Column(String, nullable=False)
    tool_description = Column(String, nullable=False)
    location = Column(String, nullable=False)
    date_start = Column(Date, nullable=False)
    date_finish = Column(Date, nullable=False)
    owner_name = Column(String, nullable=False)
    phone_number = Column(String, nullable=False)


    def __init__(self, tool_name, tool_description, location, date_start,
                date_finish, owner_name, phone_number):
        self.tool_name = tool_name
        self.tool_description = tool_description
        self.location = location
        self.date_start = date_start
        self.date_finish = date_finish
        self.owner_name = owner_name
        self.phone_number = phone_number

people_requests_association = Table(
    'people_requests', Base.metadata,
    Column('user_id', Integer, ForeignKey('users.id', ondelete='CASCADE',
     onupdate='CASCADE')),
    Column('request_id', Integer, ForeignKey('request.id', ondelete='CASCADE',
     onupdate='CASCADE'))
)