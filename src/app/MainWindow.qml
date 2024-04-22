import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
//import UserBlock

ApplicationWindow {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"

    GridLayout {
        id: main_grid
        anchors.fill: parent
        columns: 2
        rows: 1
        
        Rectangle {
            id: rect_sidebar
            Layout.preferredWidth: 304
            Layout.fillHeight: true
            color: "#D9D9D9"
            GridLayout {
                id: sidebar
                columns: 2
                anchors.fill: parent
                anchors.margins: 12
                columnSpacing: 8
                rowSpacing: 12

                function new_user(username, ip) {
                    var component = Qt.createComponent("UserBlock.qml")
                    //var new_user = component.createObject(users)
                    list_model.append({id: "user" + users.count++, component})
                    //component.id = "user" + users.count++
                    //list_model.append(new_user)
                    //new_user.btn_id = "user" + users.count++
                    //new_user.name.text = username
                    //new_user.ip.text = ip
                }

                function delete_user() {
                    //button.visible: false
                    //var index = parseInt(id.match(/\d+/))
                    //list_model.remove(index)
                }

                Rectangle {
                    id: rect_search
                    Layout.columnSpan: 2
                    Layout.preferredWidth: 280
                    Layout.preferredHeight: 35
                    Layout.alignment: Qt.AlignTop
                    border.width: 1
                    clip: true
                    TextInput {
                        id: search
                        anchors.fill: parent
                        anchors.margins: 8
                        font.pixelSize: 16
                        color: "black"
                        property string placeholderText: "Поиск..."
                        Text {
                            text: search.placeholderText
                            font.family: "Inter"
                            font.pixelSize: 16
                            color: "#aaa"
                            visible: !search.text
                        }
                    }
                }
                
                Button {
                    id: rect_notifications
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Qt.AlignTop
                    background: Rectangle {
                        border.width: 1
                    }

                    Image {
                        width: 32
                        height: 32
                        anchors.centerIn: parent
                        source: "icons\\notifications_active.svg"
                    }
                }

                Button {
                    id: rect_laptop
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Qt.AlignTop
                    background: Rectangle {
                        border.width: 1
                    }

                    Image {
                        width: 34
                        height: 21
                        anchors.centerIn: parent
                        source: "icons\\laptop.svg"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sidebar.new_user("Test", "120.138.0.159")
                        }
                    }
                }

                Button {
                    id: rect_settings
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Qt.AlignTop
                    background: Rectangle {
                        border.width: 1
                    }

                    Image {
                        width: 32
                        height: 32
                        anchors.centerIn: parent
                        source: "icons\\settings.svg"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sidebar.delete_user("user0")
                        }
                    }
                }

                Button {
                    id: rect_theme
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    Layout.column: 0
                    Layout.row: 4
                    Layout.alignment: Qt.AlignTop
                    background: Rectangle {
                        border.width: 1
                    }

                    Image {
                        width: 24
                        height: 24
                        anchors.centerIn: parent
                        source: "icons\\theme.png"
                    }
                }

                Button {
                    id: rect_group
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    Layout.column: 0
                    Layout.row: 5
                    Layout.alignment: Qt.AlignTop
                    background: Rectangle {
                        border.width: 1
                    }

                    Image {
                        width: 24
                        height: 24
                        anchors.centerIn: parent
                        source: "icons\\group.svg"
                    }
                }

                ScrollView {
                    id: scrl_users
                    Layout.column: 1
                    Layout.row: 1
                    Layout.rowSpan: 6
                    Layout.preferredWidth: 244
                    Layout.fillHeight: true

                    ColumnLayout {
                        id: users
                        ListView {
                            id: lst
                            Layout.fillHeight: true
                            model: list_model
                            delegate: Rectangle {
                                width: 100
                                height: 100
                                color: model.color
                            }
                        }
                        anchors.fill: parent
                        anchors.rightMargin: 12
                        property int count: 0
                        ListModel {
                            id: list_model
                            //anchors.fill: parent

                            ListElement {
                                //id: user0
                                color: "red"
                            }
                        }
                    }
                    ScrollBar.vertical: ScrollBar {
                        id: scrollbar
                        parent: scrl_users
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        policy: ScrollBar.AlwaysOff
                        x: scrl_users.mirrored ? 0 : scrl_users.width - width
                        y: scrl_users.topPadding
                        width: 3
                        height: scrl_users.availableHeight
                        active: scrl_users.ScrollBar.vertical.active
                        contentItem: Rectangle {
                            opacity: 0.0
                            radius: width/2
                            color: "#aaa"
                        }
                        background: Rectangle {
                            opacity: 0.5
                            radius: width/2
                            color: "#D9D9D9"
                        }
                    }
                }

                Item {
                    Layout.column: 0
                    Layout.row: 6
                    Layout.fillHeight: true 
                }
            }
        }
    }
}