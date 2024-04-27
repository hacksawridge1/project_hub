from PySide6.QtCore import QObject, Signal

class Controller(QObject):
    username = ""
    window = QObject() # Главный объект запущенного окна
    add_user = Signal(str, str) # add_user.emit(<имя_пользователя>, <ip>) - создаст нового пользователя
    delete_user = Signal(int) # delete_user.emit(<индекс_в_списке>) - удалит пользователя по индексу

    def test_control(self):
        self.add_user.emit("Artur", "192.168.0.132")
        self.add_user.emit("Kemran", "192.168.0.159")
        self.add_user.emit("Arsen", "192.168.0.128")

# Основной класс, с помощью которого можно осуществлять доступ к свойствам объектов и функций qml.
# Инструкция:
# 1. from путь.к.control import control
# 2. control.window.property(<название_свойства>) - получить свойство главного окна
# 3. control.window.setProperty(<название_свойства>, <значение>) - установить значение свойства
# 4. control.<объект>.findChild(QObject, <имя_ребенка>) - найдет ребенка объекта <объект> при условии, что у ребенка присутствует свойство objectName
# С ребенком любого объекта можно делать все вышеперечисленное
# Чтобы вызвать объявленную функцию из qml - используйте: "control.<имя_функции>.emit(<параметр1>, <параметр2>, ...)"
control = Controller() # Управлять qml можно с помощью этой переменной