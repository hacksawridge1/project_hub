from flask import Flask, request
from modules.user import User
from modules.objects import *
import json

# class Server:
#   def __init__(self, user: User):
#     self.__app = Flask(__name__)
#     self.routing(user)

#   def start(self, user: User):
#     self.__app.run(host=user.ip, port=9091)

#   def routing(self, user: User):
#     @self.__app.route('/')
#     def hello():
#       return user.name
#     @self.__app.route('/hi')
#     def hi():
#       return 'hi'
#     @self.__app.route('/init')
#     def init():
#       return user.users_online
#     @self.__app.post('/init')
#     def post_init():
#       req = eval(request.form.get('data'))
#       user.users_online['usersonline'].append(decrypt_object(req, user.private_key))
#       return user.users_online
#     @self.__app.post(f'/{user.name}/message')
#     def recv_message():
#       req = eval(request.form.get('data'))
#       print(decrypt_data(req))

def start_server(user: User):
    app = Flask(__name__)

    @app.route('/')
    def hello():
      return user.name
    
    @app.route('/user', methods=['GET', 'POST'])
    def init():
      if request.method == 'GET':
        return user.user_info
      if request.method == 'POST':
        req = eval(request.form.get('data'))
        user.add_user = decrypt_object(req, user.private_key)
        return 'ok'
    
    @app.post('/remove-user')
    def remove_user():
      req = eval(request.form.get('data'))
      user.remove_user = decrypt_object(req, user.private_key)
      return 'ok'
    
    @app.post(f'/message')
    def recv_message():
      req = eval(request.form.get('data'))
      print(f'\nMessage from [{request.remote_addr}]:\t' + decrypt_data(req, user.private_key))
      return str(request.headers)
    
    
    
    app.run(host='0.0.0.0', port=9091)
