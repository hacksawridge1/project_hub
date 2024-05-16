__author__ = "MIDNIGHT"

import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
from control import control
from modules.user import User
from threading import Thread
from modules.server import start_server

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

def initialize(username):
    control.main_user = User(username)
    control.ip = control.main_user.ip
    server_thread = Thread(target=start_server, args=(control.main_user, control, ))
    server_thread.daemon = True
    server_thread.start()
    control.main_user.initial

class MainController(QObject):
    @Slot(str)
    def main_window(self, username):
        engine.rootObjects()[0].deleteLater()
        qml_file = path.dirname(path.abspath(__file__)) + "/MainWindow.qml"
        user_thread = Thread(target=initialize, args=(username, ))
        user_thread.daemon = True
        user_thread.start()
        control.username = username
        engine.load(qml_file)
main_control = MainController()

def authorization(main_control):
    qml_file = path.dirname(path.abspath(__file__)) + "/Authorization.qml"
    engine.rootContext().setContextProperty("main_control", main_control)
    engine.rootContext().setContextProperty("control", control)
    engine.load(qml_file)

if __name__ == "__main__":
    authorization(main_control)
    app.exec()
    sys.exit(0)