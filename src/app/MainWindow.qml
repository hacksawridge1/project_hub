import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import Controller

ApplicationWindow {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"

    property bool theme: Control ? Control.theme : false
    property string name: Control ? Control.username : ""
    property string ip: Control ? Control.ip : ""

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
            theme: main_window.theme
            users_list: users_list
            name: main_window.name
            ip: main_window.ip
            costil: main_window.costil
        }
        Chat {
            id: chat
            theme: main_window.theme
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
            name: main_window.name
            ip: main_window.ip

            onUserChanged: {
                chat.costil()
            }
        }
    }

    ListModel {
        id: users_list

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
    }

    ListModel {
        id: messages_list
    }

    Connections {
        target: Control

        function onAdd_message(name, ip, message) {
            chat.add_message(name, ip, message)
        }

        function onAdd_user(name, ip) {
            sidebar.add_user(name, ip)
        }

        function onDelete_user(index) {
            sidebar.delete_user(index)
        }
    }
}