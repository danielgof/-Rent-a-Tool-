import yaml
"""
ger credits for data base
"""
def config_db(path):
    with open(path, "r") as stream:
        try:
            data = yaml.safe_load(stream)
            db_name = data["database"]["dbname"]
            username = data["database"]["username"]
            password = data["database"]["password"]
        except yaml.YAMLError as exc:
            print(exc)
    return db_name, username, password

"""
get credits for registration
"""
def config_auth(path):
    with open(path, "r") as stream:
        try:
            data = yaml.safe_load(stream)
            SECRET_KEY = data["auth"]["secret_key"]
            MAIL_SERVER = data["auth"]["mail_server"]
            MAIL_PORT = data["auth"]["mail_port"]
            MAIL_USERNAME = data["auth"]["mail_username"]
            MAIL_PASSWORD = data["auth"]["mail_password"]
            MAIL_USE_TLS = data["auth"]["mail_use_tls"]
            MAIL_USE_SSL = data["auth"]["mail_use_ssl"]
        except yaml.YAMLError as exc:
            print(exc)
    return SECRET_KEY, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD, MAIL_USE_TLS, MAIL_USE_SSL
