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

    function print_func() {
        console.log("invoked function!")
    }

    property var add_user: sidebar.add_user
    property var delete_user: sidebar.delete_user

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
            property ListModel models: users_list
            property string name: "Hitler"
            property string ip: "192.168.0.139"
        }
        Chat {
            id: chat
            objectName: "chat"
            property bool connected: users_list.count != 0
            property var item: users_list.get(sidebar.index)
        }
    }

    ListModel {
        id: users_list
    }

    Connections {
        target: control

        function onAdd_user(name, ip) {
            main_window.add_user(name, ip)
        }

        function onDelete_user(index) {
            main_window.delete_user(index)
        }
    }
}