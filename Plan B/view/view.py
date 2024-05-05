from os import path

class View():
    authorization = path.dirname(path.abspath(__file__)) + "/Authorization.qml"
    mainWindow = path.dirname(path.abspath(__file__)) + "/MainWindow.qml"
    sidebar = path.dirname(path.abspath(__file__)) + "/SideBar.qml"
    chat = path.dirname(path.abspath(__file__)) + "/Chat.qml"