__author__ = "MIDNIGHT"

import sys
from os import path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
from control import control

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()


class MainController(QObject):
    @Slot(str)
    def main_window(self, username):
        engine.rootObjects()[0].deleteLater()
        qml_file = path.dirname(path.abspath(__file__)) + "/MainWindow.qml"
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