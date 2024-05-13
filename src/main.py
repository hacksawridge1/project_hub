from threading import Thread
import sys
from modules.user import User
from modules.server import start_server

user_name = input("Введите ваше имя:\t")
print('Генерируем данные...')

user = User(user_name)

server_thread = Thread(target=start_server, args=(user, ))
server_thread.start()
init_thread = Thread(target=user.initial)
init_thread.start()

print(user.users_online)

reciever_ip = input('Введите ip пользователя:\t')
reciever_name = input('Введите имя пользователя:\t')

while True:
  data = input('Введите сообщение:\t')
  if data == 'stop':
    user.call_to_remove_user()
    sys.exit()
  elif data == 'Пользователи':
    print(user.users_online)
  elif data == "История":
    history = user.chat_info(reciever_name, reciever_ip)
    for i in history:
      print(i["message"])
  else:
    user.send_message(reciever_ip, reciever_name, data)
