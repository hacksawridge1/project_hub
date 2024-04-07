__author__ = "Maxim"

from model.json.settings import Json
from model.sql.dataBase import Sqlite

class Model():
    def __init__(self):
        self.json = Json()
        self.sql = Sqlite()
        self.name = "undefined"
        self.chat = ["temp"]