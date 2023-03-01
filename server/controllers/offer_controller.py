from models.db_offer import *
from create import *

"""
extract all offers from database
"""


def all_offers() -> list:
    offers = session.query(Offer).all()
    responce = []
    for offer in offers:
        responce.append(
            {
                "id": offer.id,
                "tool_name": offer.tool_name,
                "tool_description": offer.tool_description,
                "location": offer.location,
                "price": offer.price,
                "date_start": offer.date_start,
                "date_finish": offer.date_finish,
                "owner_name": offer.owner_name,
                "phone_number": offer.phone_number,
            }
        )
    return responce


"""
add new offer to a user
"""


def add_offer_to_user(username: str, data: dict) -> None:
    user: User = session.query(User).filter(User.username == username).first()
    user_offers: list = user.offers
    offer = Offer(
        tool_name=data["tool_name"],
        tool_description=data["tool_description"],
        location=data["location"],
        price=data["price"],
        date_start=data["date_start"],
        date_finish=data["date_finish"],
        owner_name=data["owner_name"],
        phone_number=data["phone_number"],
    )
    user_offers.append(offer)
    session.add(offer)
    session.commit()


"""
delete user's offer
"""


def delete_offer_by_id(data: dict) -> None:
    session.query(Offer).filter(Offer.id == data["id"]).delete()
    session.commit()


