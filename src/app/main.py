__author__ = "MIDNIGHT"

import sys
from os import path
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonInstance
from PySide6.QtCore import QObject, Slot
from control import control, Controller
from modules.user import User
from threading import Thread
from modules.server import start_server

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

def initialize(username):
    control.main_user = User(username, control)
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
    qmlRegisterSingletonInstance(MainController, "MainController", 1, 0, "MainControl", main_control) # type: ignore
    qmlRegisterSingletonInstance(Controller, "Controller", 1, 0, "Control", control) # type: ignore
    engine.load(qml_file)

if __name__ == "__main__":
    authorization(main_control)
    app.exec()
    if (control.main_user):
        control.main_user.call_to_remove_user()
    sys.exit(0)
