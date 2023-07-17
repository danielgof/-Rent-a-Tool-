from flask import request, jsonify
from functools import wraps
import jwt

from create import *
from setup import *

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        head = request.headers
        token = head.get("Authorization")
        if not token:
            return {"status":"token is missing"}, 403
        try:
            data = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
            current_user = session.query(User).filter(User.username == data["username"]).first()
        except:
            return {"status":"token is invalid"}, 401
        return f(current_user, *args, **kwargs)
    return decorated