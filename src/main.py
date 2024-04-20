from modules.user import User
from modules.app import App
from textwrap import wrap
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_object
from modules.server import start_server
from modules.new_server import start_server
from threading import Thread
from multiprocessing import freeze_support, Process

user_name = input("Введите ваше имя:\t")
# user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
print('Генерируем данные...')
app = App()
user = User(user_name)
# server = Server(user)
server_thread = Thread(target=start_server(user))
server_thread.start()
init_thread = Thread(target=user.initial)
init_thread.start()
print("Генерация прошла успешно")

reciever_name = input('Введите имя получателя:\t')
reciever_ip = input('Введите айпи получателя:\t')

while True:
  data = input('Введите сообщение:\t')
  if data == 'stop':
    break  
  user.send_message(reciever_ip, reciever_name, data)
# server_thr = threading.Thread(target=start_server, args=('', 9091, user), name='server')
# server_thr.start()