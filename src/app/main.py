import sys
from os import path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal
from control import control, func_control
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

@Slot()
def main_window():
    qml_file = path.dirname(path.abspath(__file__)) + "/MainWindow.qml"
    engine.rootContext().setContextProperty("control", func_control)
    engine.load(qml_file)
    control.change_window(engine.rootObjects()[1])

def authorization():
    qml_file = path.dirname(path.abspath(__file__)) + "/Authorization.qml"
    engine.load(qml_file)
    root = engine.rootObjects()[0]
    root.main_window.connect(main_window) # type: ignore

if __name__ == "__main__":
    authorization()
    app.exec()
    sys.exit(0)