import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
<<<<<<< HEAD
=======
import Controller
>>>>>>> develop

ApplicationWindow {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"
<<<<<<< HEAD
    
    property string name: control ? control.username : ""
    property string ip: "192.168.0.139"
=======

    property bool theme: Control ? Control.theme : false
    property string name: Control ? Control.username : ""
    property string ip: Control ? Control.ip : ""
>>>>>>> develop

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
<<<<<<< HEAD
            users_list: users_list
            name: main_window.name
            ip: main_window.ip
        }
        Chat {
            id: chat
            objectName: "chat"
=======
            theme: main_window.theme
            users_list: users_list
            name: main_window.name
            ip: main_window.ip
            costil: main_window.costil
        }
        Chat {
            id: chat
            theme: main_window.theme
>>>>>>> develop
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
            name: main_window.name
            ip: main_window.ip
<<<<<<< HEAD
=======

            onUserChanged: {
                chat.costil()
                //messages_list.insert(0, {"name": "Ильяз", "ip": "192.168.3.152", "type": "file", "size": "120 Kb", "message": "file_name.zip", "time": "17:31"})
            }
>>>>>>> develop
        }
    }

    ListModel {
        id: users_list
<<<<<<< HEAD
=======

        ListElement {
            name: "Коля"
            ip: "192.168.3.152"
            last_message: "Привет, мне что-нибудь надо по проекту сделать?"
        }
        ListElement {
            name: "Артур"
            ip: "192.168.3.152"
            last_message: "Передаю привет своей маме!!!"
        }
        ListElement {
            name: "Иван"
            ip: "192.168.3.152"
            last_message: "Понял"
        }
        ListElement {
            name: "Дима"
            ip: "192.168.3.152"
            last_message: "Приложение не успевает реагировать так быстро"
        }
        ListElement {
            name: "Imaginer"
            ip: "192.168.3.152"
            last_message: "Надо подойти в 8 кабинет срочно."
        }
        ListElement {
            name: "Ильяз"
            ip: "192.168.3.152"
            last_message: "Файл."
        }
        ListElement {
            name: "Любитель..."
            ip: "192.168.3.152"
            last_message: "Блин, выпил кофе, теперь тревожность появилась."
        }
        ListElement {
            name: "Матвей"
            ip: "192.168.3.152"
            last_message: "Привет, мне что-нибудь надо по проекту сделать?"
        }
        ListElement {
            name: "Лера"
            ip: "192.168.3.152"
            last_message: "Может к Жене зайти?"
        }
        ListElement {
            name: "Лёша"
            ip: "192.168.3.152"
            last_message: "Тридцать пять часов в поезде"
        }
        ListElement {
            name: "Даня"
            ip: "192.168.3.152"
            last_message: "Не за что и удачи"
        }
        ListElement {
            name: "Максим"
            ip: "192.168.3.152"
            last_message: "Я не буду ничего делать."
        }
>>>>>>> develop
    }

    ListModel {
        id: messages_list
<<<<<<< HEAD

        ListElement {
            ip: "160.120.0.23"
            message: "Hello, Hitler"
        }

        ListElement {
            ip: "192.168.0.139"
            message: "I'm a Hitler"
        }

        ListElement {
            ip: "160.120.0.23"
            message: "and a commit"
        }

        ListElement {
            ip: "160.120.0.23"
            message: "I'm a lorem ipsum"
        }

        ListElement {
            ip: "160.120.0.23"
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sollicitudin tempor id eu nisl nunc mi. In nibh mauris cursus mattis molestie a. Nunc faucibus a pellentesque sit amet porttitor eget dolor. Blandit cursus risus at ultrices mi tempus imperdiet. Auctor elit sed vulputate mi sit amet. Sit amet mauris commodo quis imperdiet. Penatibus et magnis dis parturient montes nascetur. Adipiscing enim eu turpis egestas pretium aenean. Blandit turpis cursus in hac habitasse. Id faucibus nisl tincidunt eget nullam non nisi est. Quam pellentesque nec nam aliquam sem. Quis varius quam quisque id diam."
        }
    }

    Connections {
        target: control
=======
        //ListElement {
            //name: "Ильяз"
            //ip: "192.168.3.152"
            //type: "file"
            //size: "120 Kb"
            //message: "file_name.zip"
            //time: "17:31"
        //}
    }

    Connections {
        target: Control

        function onAdd_message(name, ip, message) {
            chat.add_message(name, ip, message)
        }
>>>>>>> develop

        function onAdd_user(name, ip) {
            sidebar.add_user(name, ip)
        }

        function onDelete_user(index) {
            sidebar.delete_user(index)
        }
    }
}