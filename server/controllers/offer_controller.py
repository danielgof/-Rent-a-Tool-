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
                "lat": offer.lat,
                "lng": offer.lng,
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


def delete_offer_by_id(data: dict) -> bool:
    offer: Offer = session.query(Offer).filter(Offer.id == data["id"]).first()
    if offer:
        offer.delete()
        session.commit()
        return True
    else:
        return False


"""
upd offer by its id
"""


def upd_offer_by_id(data: dict) -> bool:
    offer: Offer = session.query(Offer).filter(Offer.id == data["id"]).first()
    if offer:
        session.query(Offer).filter(Offer.id == data["id"]).update(
            {
                Offer.tool_name: data["tool_name"],
                Offer.tool_description: data["tool_description"],
                Offer.location: data["location"],
                Offer.price: data["price"],
                Offer.date_start: data["date_start"],
                Offer.date_finish: data["date_finish"],
                Offer.owner_name: data["owner_name"],
                Offer.phone_number: data["phone_number"],
            },
            synchronize_session=False,
        )
        session.commit()
        return True
    else:
        return False


"""
get all offers for particular user
"""


def all_offers_user(user_info: dict) -> list:
    user = session.query(User).filter(User.username == user_info).first()
    user_offers = user.offers
    responce = []
    for offer in user_offers:
        responce.append(
            {
                "id": offer.id,
                "tool_name": offer.tool_name,
                "tool_description": offer.tool_description,
                "location": offer.location,
                "lat": offer.lat,
                "lng": offer.lng,
                "price": offer.price,
                "date_start": offer.date_start,
                "date_finish": offer.date_finish,
                "owner_name": offer.owner_name,
                "phone_number": offer.phone_number,
            }
        )
    return responce
