from modules.user import User
from modules.app import App
from textwrap import wrap
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_object
from modules.server import start_server
from modules.new_server import Server
import threading

def main():
  global app
  global user
  user_name = input("Введите ваше имя:\t")
  user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
  print('Генерируем данные...')
  app = App()
  user = User(user_name)
  server = Server(user)
  server_thr = threading.Thread(target=server, name='thr_1')
  server_thr.start()
  while True:
    data = input('Введите сообщение:\t')
    if data == 'stop':
      break  
  # server_thr = threading.Thread(target=start_server, args=('', 9091, user), name='server')
  # server_thr.start()
  print("Генерация прошла успешно")


if __name__ == '__main__':
  main()