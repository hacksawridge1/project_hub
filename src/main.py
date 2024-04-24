from modules.user import User
from modules.app import App
from modules.new_server import start_server
# from _thread import start_new_thread
from threading import Thread
import sys
from time import sleep
from modules.objects import encrypt_object

# def check_server():
#   while True:
#     print(server_thread.is_alive())
#     sleep(3)

# user_name = input("Введите ваше имя:\t")
# # user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
# print('Генерируем данные...')
# app = App()
user_name = 'ivan'
user = User(user_name)
data = user.user_info
print(data, end="\n\n")
encrypt_object(data, user.public_key)
print(data)
# # server = Server(user)
# server_thread = Thread(target=start_server, args=(user, ))
# server_thread.start()
# check_server_thread = Thread(target=check_server)
# check_server_thread.start()
# init_thread = Thread(target=user.initial)
# init_thread.start()
# print("Генерация прошла успешно")
# print(user.users_online)
# reciever_ip = input('Введите ip пользователя:\t')
# reciever_name = input('Введите имя пользователя:\t')
# while True:
#   data = input('Введите сообщение:\t')
#   if data == 'stop':
#     user.call_to_remove_user()
#     sys.exit()
#   elif data == 'Пользователи':
#     print(user.users_online)
#   else:
#     user.send_message(reciever_ip, reciever_name, data)
