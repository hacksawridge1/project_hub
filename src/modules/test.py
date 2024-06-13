import unittest
from unittest.mock import MagicMock, patch
from user import User
from app.control import Controller
from Crypto.PublicKey import RSA
from objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_object

# Генерация RSA ключей для тестов
private_key = RSA.generate(2048)
private_key_str = private_key.export_key().decode()
public_key = private_key.publickey().export_key().decode()

# Класс для тестирования функций пользователя
class TestUser(unittest.TestCase):
    
    ## Тесты для user.py

    # Тест на инициализацию пользователя
    @patch("user.set")
    @patch("user.RSA")
    @patch("user.requests")
    @patch("user.socket")
    def test_init(self, mock_socket, mock_requests, mock_rsa, mock_set):
        control = MagicMock(spec=Controller)
        name = "Test Name"
        user = User(name, control)
        
        self.assertEqual(user.__name, name)
        self.assertIsNotNone(user.__ip)
        self.assertEqual(mock_rsa.generate.call_count, 1)
        self.assertEqual(mock_set.user_info.call_count, 1)
        self.assertEqual(len(user.__user_info), 3)
        self.assertEqual(mock_set.path_to_self.call_count, 3)
        self.assertEqual(mock_rsa.export_key.call_count, 2)

    # Тест на получение локального IP
    @patch("user.requests")
    @patch("user.set")
    def test_get_local_ip(self, mock_set, mock_requests):
        user = User("Test Name", MagicMock())
        local_ip = user.__get_local_ip()
        self.assertIsNotNone(local_ip)

    # Тест на инициализацию пользователя
    @patch("user.requests")
    @patch("user.User.__get_local_ip", return_value="127.0.0.1")
    def test_initial(self, mock_get_local_ip, mock_requests):
        user = User("Test Name", MagicMock())
        user.control.add_user = MagicMock()
        mock_set = MagicMock()
        mock_requests.get.side_effect = [MagicMock(ok=True), MagicMock(text='{"user_name": "TestUser", "user_ip": "127.0.0.1", "user_pub_key": "public_key"}')]
        user.__initial()
        self.assertEqual(user.control.add_user.call_count, 1)
        self.assertEqual(mock_set.decrypt_object.call_count, 2)

    # Тест на отправку сообщения
    def test_send_message(self):
        mocked_set = MagicMock()
        user = User("Test Name", MagicMock())
        user.send_message("127.0.0.1", "Test Receiver", "Test Message")
        self.assertEqual(mocked_set.chat.call_count, 1)
        self.assertEqual(mocked_set.chat_object.call_count, 1)
        
        
    ## Тесты для objects.py
    
    
    # Тест на простое шифрование и дешифрование данных
    def test_simple_data_encryption(self):
        data = "Hello, World!"
        encrypted_data = encrypt_data(data, public_key)
        decrypted_data = decrypt_data(encrypted_data, private_key_str)
        self.assertEqual(data, decrypted_data)

    # Тест на шифрование и дешифрование списка
    def test_list_encryption_and_decryption(self):
        data = ["Hello", "World!"]
        encrypted_data = encrypt_data(data, public_key)
        decrypted_data = decrypt_data(encrypted_data, private_key_str)
        self.assertListEqual(data, decrypted_data)

    # Тест на шифрование и дешифрование словаря
    def test_dict_encryption_and_decryption(self):
        data = {
            "name": "Ivan",
            "id": 1337
        }
        encrypted_data = encrypt_object(data, public_key)
        decrypted_data = decrypt_object(encrypted_data, private_key_str)
        self.assertDictEqual(data, decrypted_data)

    # Тест на шифрование и дешифрование вложенных данных
    def test_nested_data_encryption_and_decryption(self):
        data = {
            "name": "Ivan",
            "details": ["admin", {"ip": "12.103.05.42"}]
        }
        encrypted_data = encrypt_object(data, public_key)
        decrypted_data = decrypt_object(encrypted_data, private_key_str)
        self.assertDictEqual(data, decrypted_data)

    # Тест на поиск в объекте без совпадения
    def test_non_matching_object_search(self):
        data = {"first": ["Hello", "World!"], "second": {"name": "Ivan", "id": 1337}}
        matching_object = find_in_object(data, {"name": "Ivan", "id": 1337})
        self.assertIsNone(matching_object)
    
    # Тест на поиск в объекте с совпадением
    def test_matching_object_search(self):
        data = {"first": ["Hello", "World!"], "second": {"name": "Ivan", "id": 1337}}
        matching_object = find_in_object(data, {"name": "Ivan", "id": 1337})
        self.assertDictEqual(data['second'], matching_object) 
        
if __name__ == '__main__':
    unittest.main()
