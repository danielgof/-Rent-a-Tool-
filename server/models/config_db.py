import yaml

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
