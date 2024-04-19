# from modules.user import User
from modules.app import App
from textwrap import wrap
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_json
from server.main import start_server

def main():
  # user_name = input("Введите ваше имя:\t")
  # user_passphrase = input("Введите кодовое слово для защиты ваших ключей:\t")
  # print('Генерируем данные...')
  # try:
  #   app = App()
  #   user = User(user_name, user_passphrase)
  #   print("Генерация прошла успешно")
  # except:
  #   print("Ошибка генерации...")

  data = {
    "chat": [
      {
        "user_name": "hack",
        "user_id": "1",
        "user_ip": "192.168.3.121",
        "date": "D_M_Y/H_M_S",
        "message": [
          "some_message01",
          "some_message02"
        ]
      },
      {
        "user_name": "shmak",
        "user_id": "2",
        "user_ip": "192.168.3.123",
        "date": "D_M_Y/H_M_S",
        "message": [
          "some_message01",
          "some_message02"
        ]
      },
      {
        "user_name": "chubak",
        "user_id": "3",
        "user_ip": "192.168.3.125",
        "date": "D_M_Y/H_M_S",
        "message": [
          "some_message01",
          "some_message02"
        ]
      }
    ]
  }
  object = find_in_json(data, "chubak")
  print(object)


if __name__ == '__main__':
  main()