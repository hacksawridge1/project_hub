import json
from user.user_modules.user_info import get_local_ip, generate_user_id
import security.modules.generate_keys as gk
import security.modules.objects as cipher

gk.generate_app_keys()
gk.generate_user_keys(passphrase = 'secret')
user_name = str(input('Введите имя пользователя:\t'))
user_ip = str(get_local_ip())
user_id = str(generate_user_id())
messages = list('message1', 'message2')

user_object = {'username': user_name, 'userip': user_ip, 'userid': user_id, 'messages': messages, 'userpublickey': gk.get_public_key('../client.pub')}
user_object = json.dumps(user_object)
user_object = json.loads(user_object)