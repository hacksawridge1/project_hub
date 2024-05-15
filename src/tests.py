from random import randrange

names = ["John", "Ivan", "Dima", "Ilyaz", "Lera"]

def gen_users(names: list):
  users: list = []
  for i in range(len(names) - 1):
    print(i)
    k = randrange(len(names) - 1)
    users.append(
      {
        "user_name": names[k],
        "user_ip": f"192.168.3.{i}",
        "user_pub_key": "some_pub_key"
      }
    )
    print(users)
  return users
  

def get_users(users: list):
  for i in users:
    yield i

users = gen_users(names)
  
for i in range(5):
  print(next(get_users(users)))
  input()
