from models.db_offer import *
from create import *

def all_offers() -> list:
    offers = session.query(Offer).all()
    responce = []
    for offer in offers:
        responce.append({
            "id":offer.id,
            "tool_name": offer.tool_name ,
            "tool_description": offer.tool_description ,
            "location": offer.location ,
            "price": offer.price ,
            "date_start": offer.date_start ,
            "date_finish": offer.date_finish,
            "owner_name": offer.owner_name,
            "phone_number": offer.phone_number
        })
    return responce