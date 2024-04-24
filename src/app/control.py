import sys
from os import path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal, QAbstractItemModel, QMetaObject, Q_ARG, QGenericArgument

class Func_controller(QObject):
    new_user = Signal()

class Controller:
    open_window = QObject()

    def change_window(self, window):
        self.open_window = window
        #print(self.open_window.property("title"))
        #self.open_window.setProperty("title", "NEW_HUB")
        #print(self.open_window.property("title"))
        #users_list = self.open_window.findChild(QAbstractItemModel, "users_list")
        #new_element = QObject()
        #print(users_list.property("count"))
        
        #QMetaObject.invokeMethod(self.open_window, b'new_user', QGenericArgument("Sanya"), QGenericArgument("190.160.0.23"))
        #self.open_window.property("new_user(\"Sanya\", \"190. 160.0.23\")")

    def get_window(self):
        return self.open_window

control = Controller()
func_control = Func_controller()