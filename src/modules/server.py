from flask import Flask, request
import json
from .user import User
from .objects import *
import modules.settings as set

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
        user_pub_key = None

        if data["user_pub_key"]:
          user_pub_key = data.pop("user_pub_key")

        with set.path_to_self("users-online.json").open() as f:
          file_data = decrypt_object(json.load(f), user.private_key)

        if find_in_object(file_data, data) == None:
          data['user_pub_key'] = user_pub_key
          file_data['users_online'].append(data)

          with set.path_to_self("users-online.json").open("w") as f:
            f.write(json.dumps(encrypt_object(file_data, user.public_key)))
   
    @app.post('/remove-user')
    def remove_user():
      removed_user: dict = decrypt_object(request.get_json(), user.private_key)
      file_data: dict

      with set.path_to_self("users-online.json").open() as f:
        file_data = decrypt_object(json.load(f), user.private_key)

      if find_in_object(file_data, removed_user) != None:
        with set.path_to_self("users-online.json").open("w") as f:
          f.write(json.dumps(encrypt_object(file_data['users_online'].remove(removed_user), user.public_key)))

      return user.user_info
    
    @app.post(f'/message')
    def recv_message():
      req = request.get_json()
      data: dict = decrypt_object(req, user.private_key)
      print(f'From:{data["user_name"]}\nMessage:{data["message"]}')
      chat: dict = set.chat()
      chat_object: dict = set.chat_object(data['user_name'], data['user_ip'], data['message'])
      chat["chat"].append(chat_object)

      if not set.path_to_chat(chat_object['user_name'], chat_object['user_ip']).exists():
        set.path_to_chat(chat_object['user_name'], chat_object['user_ip']).mkdir()

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open("w") as f:
          f.write(json.dumps(encrypt_object(chat, user.public_key), sort_keys=True))

      else:

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open() as f:
          chat = json.load(f) 

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open("w") as f:
          f.write(json.dumps(encrypt_object(chat, user.public_key), sort_keys=True))

      return str(request.headers)
    
    app.run(host='0.0.0.0', port=9091)
