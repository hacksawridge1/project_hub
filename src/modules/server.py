from os import path
import sys
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from flask import Flask, request
import json
from zlib import decompress
from .user import User
from .objects import *
from app.control import Controller
import modules.settings as set

def start_server(user: User, control: Controller):
    app = Flask(__name__)

    @app.get("/")
    def hello():
      return user.name
    
    @app.route("/user", methods=["GET", "POST"]) #type: ignore
    def init():
      if request.method == "GET":
        return user.user_info
      if request.method == "POST":
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
        
          control.add_user.emit(data["user_name"], data["user_ip"])
        return "ok"
   
    @app.post("/remove-user")
    def remove_user():
      removed_user: dict = decrypt_object(request.get_json(), user.private_key)
      file_data: dict

      with set.path_to_self("users-online.json").open() as f:
        file_data = decrypt_object(json.load(f), user.private_key)

      if find_in_object(file_data, removed_user) != None:
        with set.path_to_self("users-online.json").open("w") as f:
          f.write(json.dumps(encrypt_object(file_data['users_online'].remove(removed_user), user.public_key)))

      return user.user_info
    
    @app.post("/message")
    def recv_message():
      req = request.get_json()
      data: dict = decrypt_object(req, user.private_key)
      chat: dict = set.chat()
      chat_object: dict = set.chat_object(data['user_name'], data['user_ip'], data['message'])

      if not set.path_to_chat(chat_object['user_name'], chat_object['user_ip']).exists():
        set.path_to_chat(chat_object['user_name'], chat_object['user_ip']).mkdir(parents=True)

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open('w') as f:
          chat['chat'].append(encrypt_object(chat_object, user.public_key))
          f.write(json.dumps(chat, sort_keys=True))

      else:

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open() as f:
          chat = json.load(f) 
          chat['chat'].append(encrypt_object(data, user.public_key))

        with set.path_to_chat(chat_object['user_name'], chat_object['user_ip'], "chat.json").open('w') as f:
          f.write(json.dumps(chat, sort_keys=True))

      control.add_message.emit(data['user_name'], data['user_ip'], data['message'])

      return str(request.headers)

    @app.get(f"/download/<string:file_name>")
    def download(file_name):
      recv = request.get_json()
      data: dict = decrypt_object(recv, user.private_key)
      if not set.path_to_upload(data['user_name'], request.remote_addr).exists():
        return "File Not Found"

      with set.path_to_upload(data['user_name'], request.remote_addr, file_name).open('rb') as f:
        file_data: bytes = f.read()
        return file_data
    
    app.run(host='0.0.0.0', port=9091)
