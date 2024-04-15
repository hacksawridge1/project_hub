__author__ = "Maxim"

from PySide6.QtWidgets import QApplication, QMainWindow
 # Надо убрать в модель

class Control(QMainWindow):
    def __init__(self, model, view, parent=None):
        super(Control, self).__init__(parent)
        self.model = model
        self.view = view
        self.view.setupUi(self)
        
        self.view.nameButton.clicked.connect(self.nameButton) # Создать/изменить имя
        self.view.btn_1.clicked.connect(self.btn_1) # Кнопка 1 - ?
        self.view.btn_2.clicked.connect(self.btn_2) # Кнопка 2 - ?
        self.view.btn_3.clicked.connect(self.btn_3) # Кнопка 3 - ?
        self.view.btn_4.clicked.connect(self.btn_4) # Кнопка 4 - ?
        self.view.sendButton.clicked.connect(self.sendButton) # Отправка (надо еще поEnter)
        # nameEdit # Поле ввода имени
        # listUser # Список карточек пользователей
        # listMessages # Список сообщений
        # textEdit # Поле ввода сообщения

        self.model.json.createJSON() # Инициализация JSON (нужна проверка на имя)
        self.update()
    
    def update(self):
        pass
        # msg = "НАБРОСОК\n"
        # for i in self.model.chat:
        #     msg += (i + "\n")
        # self.view.listMessages.setText(msg)

    # Создать/изменить имя
    def nameButton(self):
        # Добавить проверку имени != "undefined"
        if self.view.nameButton.text() == 'name':
            text = self.view.nameEdit.text()
            self.model.json.editJSON(text)
            data = self.model.json.readJSON()
            name = data['name'] # В model имя должно пройти верификацию
            self.setWindowTitle(u"HUB messager - " + name)
            self.view.nameEdit.setEnabled(False)
            self.view.nameEdit.setText("Пользователь: " + name)
            self.view.nameButton.setText(u"edit")
        else:
            self.setWindowTitle(u"HUB messager - введите новое имя")
            self.view.nameEdit.setText("")
            self.view.nameEdit.setEnabled(True)
            self.view.nameButton.setText(u"name")
    
    # Кнопка 1 - ?
    def btn_1(self):
        pass

    # Кнопка 2 - ?
    def btn_2(self):
        pass

    # Кнопка 3 - ?
    def btn_3(self):
        pass

    # Кнопка 4 - ?
    def btn_4(self):
        pass

    # Отправка
    def sendButton(self): # Все доделать
        text = self.view.textEdit.text()
        self.model.chat.append(text)
        self.update()
