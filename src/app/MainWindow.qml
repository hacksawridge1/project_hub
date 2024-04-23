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
            property ListModel models: users_list
            property string name: "Hitler"
            property string ip: "192.168.0.139"
        }
        Chat {
            id: chat
            property ListModel models: users_list
            property var item: users_list.get(sidebar.index)
        }
    }

    ListModel {
        id: users_list
        ListElement {
            name: "Artur"
            ip: "192.168.0.132"
            last_time: 65
        }
        ListElement {
            name: "Kemran"
            ip: "192.168.0.159"
            last_time: 239
        }
        ListElement {
            name: "Arsen"
            ip: "192.168.0.128"
            last_time: 3
        }
    }
}