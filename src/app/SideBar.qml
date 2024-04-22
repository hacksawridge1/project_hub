import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

Rectangle {
    id: sidebar
    Layout.preferredWidth: 304
    Layout.fillHeight: true
    color: "#D9D9D9"

    property int count: 0

    function new_user(username, userip) {
        models.append({name: username, ip: userip})
    }

    function delete_user(index) {
        models.remove(index)
        --count
    }

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 12
        columnSpacing: 0
        rowSpacing: 0

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
            Layout.topMargin: 12
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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    sidebar.color = "white"
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        Button {
            id: laptop
            Layout.preferredWidth: 40
            Layout.preferredHeight: 48
            Layout.column: 0
            Layout.row: 2
            Layout.topMargin: 8
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        Button {
            id: settings
            Layout.preferredWidth: 40
            Layout.preferredHeight: 48
            Layout.column: 0
            Layout.row: 3
            Layout.topMargin: 8
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
                    sidebar.delete_user(0)
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        Button {
            id: theme
            Layout.preferredWidth: 40
            Layout.preferredHeight: 48
            Layout.column: 0
            Layout.row: 4
            Layout.topMargin: 8
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        Button {
            id: group
            Layout.preferredWidth: 40
            Layout.preferredHeight: 48
            Layout.column: 0
            Layout.row: 5
            Layout.topMargin: 8
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        ScrollView {
            id: scrl_users
            Layout.column: 1
            Layout.row: 1
            Layout.rowSpan: 6
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            Layout.topMargin: 6
            Layout.leftMargin: 4

            Rectangle {
                id: users
                anchors.fill: parent
                color: "#D9D9D9"
                ListView {
                    id: view
                    anchors.fill: parent
                    anchors.topMargin: 6
                    anchors.leftMargin: 4
                    visible: active
                    spacing: 8
                    model: models
                    delegate: Button {
                        width: 232
                        height: 48
                        parent: view
                        z: 1
                        background: Rectangle {
                            border.width: 1
                        }

                        transform: Scale {
                            id: resize
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
                                            text: model.name
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
                                            text: index
                                            font.family: "Inter"
                                            font.pointSize: 8
                                            color: "#808080"
                                        }
                                    }
                                }
                            }
                        }

                        MouseArea {
                            id: dragArea
                            anchors.fill: parent
                            drag.target: parent
                            drag.axis: Drag.YAxis
                            hoverEnabled: true
                            onReleased: {
                                var endIndex = Math.round(parent.y / 56)
                                if (endIndex <= -1) {
                                    view.model.move(model.index, 0, 1);
                                } else {
                                    if (endIndex >= models.count) {
                                        view.model.move(model.index, models.count - 1, 1);
                                    } else {
                                        view.model.move(model.index, endIndex, 1);
                                    }
                                }
                                parent.y = 56 * model.index
                                drag.stop()
                                parent.z = 1
                            }
                            onEntered: {
                                parent.scale = 1.03
                            }

                            onPressed: {
                                parent.z = 100
                                drag.start()
                            }

                            onExited: {
                                parent.scale = 1.0
                            }
                        }

                        Timer {
                            id: drag
                            interval: 1
                            running: false
                            repeat: true
                            property double y: -1
                            onTriggered: {
                                var endIndex = Math.round(parent.y / 56)

                                if (model.index !== endIndex && endIndex > -1 && endIndex < models.count) {
                                    y = parent.y
                                    view.model.move(model.index, endIndex, 1);
                                }
                                if (y !== parent.y && y !== -1) {
                                    parent.y = y
                                    y = -1
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