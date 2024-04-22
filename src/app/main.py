import sys
from os import getcwd
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
appPath = getcwd() + "\\src\\app\\"


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = appPath + "Testing.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    app.exec()
    sys.exit()