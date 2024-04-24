from modules.user import User
from modules.app import App
from modules.new_server import start_server
from _thread import start_new_thread

# user_name = input("Введите ваше имя:\t")
# # user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
# print('Генерируем данные...')
# app = App()
# user = User(user_name)
# # server = Server(user)
# server_thread = Thread(target=start_server, args=(user, ))
# server_thread.start()
# init_thread = Thread(target=user.initial)
# init_thread.start()
# print("Генерация прошла успешно")
# while True:
#   data = input('Введите сообщение:\t')
#   if data == 'stop':
#     break  
#   elif data == 'Пользователи':
#     print(user.users_online)
#   else:
#     user.send_message(reciever_ip, reciever_name, data)
# # server_thr = threading.Thread(target=start_server, args=('', 9091, user), name='server')
# # server_thr.start()