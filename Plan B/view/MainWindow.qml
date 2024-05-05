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

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
            users_list: users_list
            name: ""
            ip: ""
        }
        Chat {
            id: chat
            objectName: "chat"
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
            name: ""
            ip: ""
        }
    }

    ListModel {
        id: users_list

        // Удалить (добавляется из control)
        ListElement {
            name: "Тестовое имя в списке"
            ip: "111.222.333.444"
        }
    }

    ListModel {
        id: messages_list

        // Удалить (добавляется из control)
        ListElement {
            name : "Тестовое имя в чате"
            message: "Hello, World"
        }
    }

    Connections {
        target: control

        function onSetName(username) {
            sidebar.name = username
        }

        function onSetIP(ip) {
            sidebar.ip = ip
        }
    }
}