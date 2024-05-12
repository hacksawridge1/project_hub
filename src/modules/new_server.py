import os
from flask import Flask, request
import json
from time import localtime
from .user import User
from .objects import *
from .settings import *

def start_server(user: User):
    app = Flask(__name__)

    @app.get('/')
    def hello():
      return user.name
    
    @app.route('/user', methods=['GET', 'POST'])
    def init():
      if request.method == 'GET':
        return user.user_info
      if request.method == 'POST':
        data: dict = decrypt_object(request.get_json(), user.private_key)
        file_data: dict  

        if data["user_pub_key"]:
          data.pop("user_pub_key")

        with open('objects/self/users-online.json', 'r') as f:
          file_data = decrypt_object(json.load(f), user.private_key)
          f.close()

        if find_in_object(file_data, data) == None:
          file_data['users_online'].append(data)

          with open('objects/self/users-online.json', 'w') as f:
            f.write(json.dumps(encrypt_object(file_data, user.public_key)))
            f.close()

        return user.user_info
   
    @app.post('/remove-user')
    def remove_user():
      removed_user: dict = decrypt_object(request.get_json(), user.private_key)
      file_data: dict

      with open('objects/self/users-online.json', 'r') as f:
        file_data = decrypt_object(json.load(f), user.private_key)
        f.close()

      if find_in_object(file_data, removed_user) != None:
        with open('objects/self/users-online.json', 'w') as f:
          f.write(json.dumps(encrypt_object(file_data['users_online'].remove(removed_user), user.public_key)))
          f.close()

      return user.user_info
    
    @app.post(f'/message')
    def recv_message():
      req = request.get_json()
      data: dict = decrypt_object(req, user.private_key)
      print(f'From:{data["user_name"]}\nMessage:{data["message"]}')
      chat: dict = CHAT
      chat_object: dict = CHAT_OBJECT
      chat_object["user_name"] = data["user_name"]
      chat_object["user_ip"] = data["user_ip"]
      chat_object["time"] = f"{localtime().tm_hour}:{localtime().tm_min}" 
      chat_object["message"] = data["message"]
      chat["chat"].append(chat_object)
      
      if not os.path.exists(os.getcwd() + f'/objects/chat/{chat_object["user_name"]}_{chat_object["user_ip"]}'):
        os.makedirs(os.getcwd() + f'/objects/chat/{chat_object["user_name"]}_{chat_object["user_ip"]}')

        with open(os.getcwd() + f'/objects/chat/{chat_object["user_name"]}_{chat_object["user_ip"]}/chat.json', 'w') as f:
          f.write(json.dumps(encrypt_object(chat, user.public_key), sort_keys=True))
          f.close()
      else:

        with open(f'objects/chat/{chat_object["user_name"]}_{chat_object["user_ip"]}/chat.json', 'r') as f:
          chat = json.load(f) 
          f.close()

        with open(f'objects/chat/{chat_object["user_name"]}_{chat_object["user_ip"]}/chat.json', 'w') as f:
          f.write(json.dumps(encrypt_object(chat, user.public_key), sort_keys=True))
          f.close()
      return str(request.headers)
    
    app.run(host='0.0.0.0', port=9091)
