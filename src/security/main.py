import modules.generate_keys as gk
import modules.objects as obj
from dotenv import load_dotenv

load_dotenv()

gk.generate_app_keys()
gk.generate_user_keys(passphrase = 'secret')
message = input('Введите сообщение, которое хотите зашифровать:\t')
encryptedMessage = obj.encrypt_data(str(message), '../../app.pub')
print(obj.decrypt_data(encryptedMessage, gk.APP_PRIVATE_KEY))