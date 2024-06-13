import sys
import os
from modules.objects import decrypt_data, encrypt_data
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from modules.user import User
from app.control import control

def main():
  user = User("Ivan", control)
  bytestr = b"11000001101010100000010101110101000000011110101011111110011101110101000000100101" + b"11000001101010100000010101110101000000011110101011111110011101110101000000100101" 
  data = encrypt_data(bytestr, user.public_key)
  data_decrypted = decrypt_data(data, user.private_key)
  
  print(bytestr)

  print(data_decrypted)

  print(len(bytestr), "\t", len(data_decrypted))

  print(bytestr == data_decrypted)

if __name__ == "__main__":
  main()
