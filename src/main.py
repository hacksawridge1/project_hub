from modules.user import User
from modules.app import App
from modules.new_server import start_server
from threading import Thread
import sys
from time import localtime
from modules.objects import decrypt_data, encrypt_object, decrypt_object, find_in_object
import json

user_name = input("Введите ваше имя:\t")
print('Генерируем данные...')

app = App()
user = User(user_name)

data = {
  "chat": [
      {
        "user_name": "ivan",
        "time": f"{localtime().tm_hour}:{localtime().tm_min}",
        "user_ip": "192.168.3.0",
        "message": "some-text"
      }
  ]
}

enc_data = encrypt_object(data, user.public_key)

print(enc_data)
print(decrypt_object(enc_data, user.private_key))

#server_thread = Thread(target=start_server, args=(user, ))
#server_thread.start()
#init_thread = Thread(target=user.initial)
#init_thread.start()

#print("Генерация прошла успешно")
#print(user.users_online)
#
#reciever_ip = input('Введите ip пользователя:\t')
#reciever_name = input('Введите имя пользователя:\t')
#
#while True:
#  data = input('Введите сообщение:\t')
#  if data == 'stop':
#    user.call_to_remove_user()
#    sys.exit()
#  elif data == 'Пользователи':
#    print(user.users_online)
#  else:
#    user.send_message(reciever_ip, reciever_name, data)
