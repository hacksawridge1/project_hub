import unittest
from control import Controller
from unittest.mock import Mock
from PySide6.QtCore import QThread
import socket
 
def get_local_ip():
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)
    return local_ip


class Test(unittest.TestCase):
    #def test_UI(self):
        #self.assertEqual(contr.ip, get_local_ip())
        #self.assertEqual(contr.username, contr.readUsername(self))
    def setUp(self):
        self.controller = Controller()

    def test_send_message(self):
        # Create a mock of main_user
        self.controller.main_user = Mock(send_message=Mock())
        self.controller.send_message("Test Name", "127.0.0.1", "Test Message")
        
        self.controller.main_user.send_message.assert_called_once_with("127.0.0.1", "Test Name", "Test Message")

    def test_setUsername(self):
        self.controller.setUsername("Test Username")
        self.assertEqual(self.controller.__username, "Test Username")

    def test_setIp(self):
        self.controller.setIp("Test IP")
        self.assertEqual(self.controller.__ip, "Test IP")

    def test_setTheme(self):
        self.controller.setTheme(False)
        self.assertEqual(self.controller.__theme, False)

if __name__ == '__main__':
    unittest.main()