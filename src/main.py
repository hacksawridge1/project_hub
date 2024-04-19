from modules.user import User
from modules.app import App
from textwrap import wrap
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object

def main():
  app = App()
  user = User('Ivan_Borodkin', 'secret')
  print(user.users_online)
  encrypted_data = encrypt_object(user.users_online, app.public_key)
  new_data = decrypt_object(encrypted_data, app.private_key)
  print(new_data)

if __name__ == '__main__':
  main()