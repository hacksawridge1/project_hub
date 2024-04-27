from PySide6.QtCore import QObject, Signal, Property

class Controller(QObject):
    def __init__(self):
        super().__init__()

    add_user = Signal(str, str) # add_user.emit(<имя_пользователя>, <ip>) - создаст нового пользователя
    delete_user = Signal(int) # delete_user.emit(<индекс_в_списке>) - удалит пользователя по индексу

    # Для передачи в qml
    # username - start
    __username = ""
    usernameChanged = Signal()
    def readUsername(self):
        return self.__username
    
    def setUsername(self, value):
        self.__username = value
        self.usernameChanged.emit()

    username = Property(str, readUsername, setUsername, notify=usernameChanged) # type: ignore
    # username - end

# Основной класс, с помощью которого можно осуществлять доступ к свойствам объектов и функций qml.
# Инструкция:
# 1. from путь.к.control import control
# 2. control.window.property(<название_свойства>) - получить свойство главного окна
# 3. control.window.setProperty(<название_свойства>, <значение>) - установить значение свойства
# 4. control.<объект>.findChild(QObject, <имя_ребенка>) - найдет ребенка объекта <объект> при условии, что у ребенка присутствует свойство objectName
# С ребенком любого объекта можно делать все вышеперечисленное
# Чтобы вызвать объявленную функцию из qml - используйте: "control.<имя_функции>.emit(<параметр1>, <параметр2>, ...)"
control = Controller() # Управлять qml можно с помощью этой переменной