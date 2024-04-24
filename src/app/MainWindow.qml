import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

Window {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"

    property var new_user: sidebar.new_user
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
            property bool connected: users_list.count != 0
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
    //Component.onCompleted: {
        //new_user("Sanya", "190.160.0.23")
    //}

    //Connections{
        //target: control

        //onNew_User: {
            //console.log("new_user")
            //functions.open()
        //}
    //}
}