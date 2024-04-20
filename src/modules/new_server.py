from flask import Flask, request
from modules.user import User
from modules.objects import *

class Server:
  def __init__(self, user: User):
    self.__app = Flask(__name__)
    self.routing(user)
    self.start(user)

  def start(self, user: User):
    self.__app.run(host=user.ip, port=9091)

  def routing(self, user: User):
    @self.__app.route('/')
    def hello():
      return user.name
    @self.__app.route('/hi')
    def hi():
      return 'hi'
    @self.__app.route('/init')
    def init():
      return user.users_online
    @self.__app.post('/init')
    def post_init():
      print(request.form)
      user.users_online['usersonline'].append(decrypt_object(request.form, user.private_key))