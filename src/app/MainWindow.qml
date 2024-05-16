import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

ApplicationWindow {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"

    property bool theme: control ? control.theme : false
    property string name: control ? control.username : ""
    property string ip: control ? control.ip : ""

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
        }
        Chat {
            id: chat
            theme: main_window.theme
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
            name: main_window.name
            ip: main_window.ip
        }
    }

    ListModel {
        id: users_list

        ListElement {
            name: "HITLER"
            ip: "0.0.0.0"
        }
    }

    ListModel {
        id: messages_list
    }

    Connections {
        target: control

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