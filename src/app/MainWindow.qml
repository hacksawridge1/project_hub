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
    
    property string name: "Hitler"
    property string ip: "192.168.0.139"

    RowLayout {
        id: main_grid
        anchors.fill: parent
        spacing: 0
        SideBar {
            id: sidebar
            users_list: users_list
            name: main_window.name
            ip: main_window.ip
        }
        Chat {
            id: chat
            objectName: "chat"
            connected: users_list.count != 0
            user: users_list.get(sidebar.index)
            messages_list: messages_list
            name: main_window.name
            ip: main_window.ip
        }
    }

    ListModel {
        id: users_list
    }

    ListModel {
        id: messages_list

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

        function onAdd_user(name, ip) {
            sidebar.add_user(name, ip)
        }

        function onDelete_user(index) {
            sidebar.delete_user(index)
        }
    }
}