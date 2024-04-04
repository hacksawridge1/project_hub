import json
from user.user_modules.user_info import get_local_ip, generate_user_id
from security.modules.generate_keys import get_public_key, get_private_key
import security.modules.objects as cipher

user_name = input('Введите имя пользователя:\t')
user_ip = get_local_ip()
user_id = generate_user_id()
messages = ['message1', 'message2']

user_object = {'username': user_name, 'userip': str(user_ip), 'userid': str(user_id), 'messages': messages, 'userpublickey': get_public_key('../client.pub')}
user_object = json.dumps(user_object)
user_object = json.loads(user_object)

for i in user_object:
  k = 0
  if i != 'userpublickey':
    if type(user_object[i]) is list:
      while k < len(user_object[i]):
        user_object[i][k] = cipher.encrypt_data(user_object[i][k], get_public_key('../client.pub'))
        k += 1
    else:
      user_object[i] = cipher.encrypt_data(user_object[i], get_public_key('../client.pub'))

for i in user_object:
  k = 0
  if i != 'userpublickey':
    if type(user_object[i]) is list:
      while k < len(user_object[i]):
        user_object[i][k] = cipher.decrypt_data(user_object[i][k], get_private_key('../client.pem', 'secret'))
        k += 1
    else:
      user_object[i] = cipher.decrypt_data(user_object[i], get_private_key('../client.pem', 'secret'))

for message in user_object['messages']:
  print(message)