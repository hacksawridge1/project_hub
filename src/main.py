from modules.user import User
from modules.app import App

def initial(some_class: User):
  some_class.send_message('192.168.3.255', some_class.user_info)

def main():
  user = User('Ivan_Borodkin', 'secret')

if __name__ == '__main__':
  main()