from modules.user import User
from modules.app import App

def main():
  user = User('Ivan_Borodkin', 'secret')
  app = App('', 9090)
  User.send_message('Some message', '192.168.3.72')

if __name__ == '__main__':
  main()