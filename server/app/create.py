from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from models.db_auth import *
from models.db_offer import *
from models.db_message import *
from models.db_inbox import *
from config import *
from base import *
from db_models import *

db_name, db_username, db_password = config_db("config_local.yaml")

"""local postgres"""
engine = create_engine(
    f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}"
)

Session = sessionmaker(bind=engine)
Base.metadata.create_all(engine)
session = Session()


user1.offers = [offer1, offer3]
user2.offers = [offer2, offer4, offer5, offer6]
user1.inbox = [inbox1, inbox2]
user2.inbox = [inbox3]
# # user2.requests = [request1, request2]

# user1.messages = [message1, message2]

session = Session()
session.add_all(messages)

session.add(user1)
session.add(user2)
session.add(user3)

session.commit()
session.close()
