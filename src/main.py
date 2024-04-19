from modules.user import User
from modules.app import App
from textwrap import wrap
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_object
from modules.server import start_server
import threading

def main():
  global app
  global user
  user_name = input("Введите ваше имя:\t")
  user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
  print('Генерируем данные...')
  app = App()
  user = User(user_name)
  server_thr = threading.Thread(target=start_server, args=('', 9091, user), name='server')
  server_thr.start()
  print("Генерация прошла успешно")

if __name__ == '__main__':
  main()