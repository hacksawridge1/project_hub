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

    //property var add_user: sidebar.add_user
    //property var delete_user: sidebar.delete_user

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
            users_list: users_list
            name: "Hitler"
            ip: "192.168.0.139"
        }
        Chat {
            id: chat
            objectName: "chat"
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
        }
    }

    ListModel {
        id: users_list
    }

    ListModel {
        id: messages_list
    }

    Connections {
        target: control

        function onAdd_user(name, ip) {
            sidebar.add_user(name, ip)
        }

        function onDelete_user(index) {
            sidebar.delete_user(index)
        }
    }
}