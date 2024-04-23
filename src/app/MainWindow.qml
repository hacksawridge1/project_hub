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
    //property int user: index

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
        }
    }

    ListModel {
        id: users_list
        ListElement {
            name: "Artur"
            ip: "192.168.0.132"
        }
        ListElement {
            name: "Kemran"
            ip: "192.168.0.159"
        }
        ListElement {
            name: "Arsen"
            ip: "192.168.0.128"
        }
    }
}