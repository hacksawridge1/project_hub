from modules.user import User
from modules.app import App
from modules.new_server import start_server
from threading import Thread
import sys
from time import sleep
from modules.objects import encrypt_object, decrypt_object, find_in_object
import json

#user_name = input("Введите ваше имя:\t")
#user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
#print('Генерируем данные...')

#app = App()
#user = User(user_name)

user = {
  'user_name': 'Ivan',
  'user_ip': '192.168.3.121'
}

data = {
  'users_online': [
    {
      'user_name': 'Ivan',
      'user_ip': '192.168.3.121'
    }
  ]
}

print(find_in_object(data, user))

#with open('objects/self/user-info.json', 'r') as f:
 #   print(decrypt_object(json.load(f), user.private_key))
  #  f.close()

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
