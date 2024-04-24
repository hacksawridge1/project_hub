import sys
from os import path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = path.dirname(path.abspath(__file__)) + "/Authorization.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    app.exec()
    sys.exit()