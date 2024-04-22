pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Controls.Universal

Rectangle {
    id: sidebar
    Layout.preferredWidth: 304
    Layout.fillHeight: true
    color: "#D9D9D9"

    function new_user(username, userip) {
        list_model.append({name: username, ip: userip})
    }

    function delete_user(index) {
        list_model.remove(index)
    }

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 12
        columnSpacing: 8
        rowSpacing: 12

        Rectangle {
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
            id: notifications
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
            id: laptop
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
            id: settings
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
                    sidebar.delete_user(1)
                }
            }
        }

        Button {
            id: theme
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
            id: group
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

            Rectangle {
                id: users
                anchors.fill: parent
                anchors.rightMargin: 12
                color: "#D9D9D9"
                ListModel {
                    id: list_model

                    ListElement {
                        name: "Artur Kemran Antonovish"
                        ip: "192.168.0.132"
                    }
                    ListElement {
                        name: "Kemran"
                        ip: "192.168.0.159"
                    }
                }
                ListView {
                    id: view
                    anchors.fill: parent
                    spacing: 12
                    model: list_model
                    delegate: Button {
                        width: 232
                        height: 48
                        background: Rectangle {
                            border.width: 1
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 8

                            Image {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                source: "icons\\user.svg"
                            }

                            Rectangle {
                                Layout.preferredWidth: 176
                                Layout.preferredHeight: 32
                                ColumnLayout {
                                    anchors.fill: parent
                                    Layout.preferredWidth: 176
                                    Layout.preferredHeight: 32
                                    spacing: 4

                                    Rectangle {
                                        Layout.preferredWidth: 172
                                        Layout.preferredHeight: 14
                                        clip: true
                                        Text {
                                            anchors.fill: parent
                                            text: view.model.name
                                            font.family: "Inter"
                                            font.pointSize: 10
                                        }
                                    }
                                    
                                    Rectangle {
                                        Layout.preferredWidth: 172
                                        Layout.preferredHeight: 14
                                        clip: true
                                        Text {
                                            anchors.fill: parent
                                            text: view.model.ip
                                            font.family: "Inter"
                                            font.pointSize: 8
                                            color: "#808080"
                                        }
                                    }
                                }
                            }
                        }
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