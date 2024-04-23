import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

Rectangle {
    id: sidebar
    Layout.preferredWidth: 304
    Layout.fillHeight: true
    color: "#D9D9D9"
    property int index: view.currentIndex

    function select_group() {
        view.currentIndex = -1
    }

    function new_user(username, userip) {
        models.append({name: username, ip: userip})
    }

    function delete_user(index) {
        models.remove(index)
    }

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.topMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 12
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
                source: "icons/notifications_active.svg"
            }

            MouseArea {
                id: notifications_area
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
                source: "icons/laptop.svg"
            }

            MouseArea {
                id: laptop_area
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }

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
            Layout.topMargin: 8
            Layout.alignment: Qt.AlignTop
            background: Rectangle {
                border.width: 1
            }

            Image {
                width: 32
                height: 32
                anchors.centerIn: parent
                source: "icons/settings.svg"
            }

            MouseArea {
                id: settings_area
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.scale = 1.1
                }

                onExited: {
                    parent.scale = 1.0
                }

                onClicked: {
                    sidebar.delete_user(0)
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
                source: "icons/theme.png"
            }

            MouseArea {
                id: theme_area
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
                color: (view.currentIndex == -1) ? (group_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (group_area.pressed) ? "#DDFFFF" : "white"
            }

            Image {
                width: 24
                height: 24
                anchors.centerIn: parent
                source: "icons/group.svg"
            }

            MouseArea {
                id: group_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    sidebar.select_group()
                }

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
            Layout.fillWidth: true
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
                    spacing: 8
                    model: models
                    property Button dragItem

                    delegate: Button {
                        id: model_user
                        width: 232
                        height: 48
                        parent: view
                        z: 1
                        background: Rectangle {
                            border.width: 1
                            color: (view.currentIndex == model.index) ? (model_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (model_area.pressed) ? "#DDFFFF" : "white"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 8

                            Image {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                source: "icons/user.svg"
                            }

                            Rectangle {
                                Layout.preferredWidth: 176
                                Layout.preferredHeight: 32
                                color: model_user.background.color
                                ColumnLayout {
                                    anchors.fill: parent
                                    Layout.preferredWidth: 176
                                    Layout.preferredHeight: 32
                                    spacing: 4

                                    Rectangle {
                                        Layout.preferredWidth: 172
                                        Layout.preferredHeight: 14
                                        color: model_user.background.color
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
                                        color: model_user.background.color
                                        clip: true
                                        Text {
                                            anchors.fill: parent
                                            text: "IP: " + ip
                                            font.family: "Inter"
                                            font.pointSize: 8
                                            color: "#808080"
                                        }
                                    }
                                }
                            }
                        }

                        MouseArea {
                            id: model_area
                            anchors.fill: parent
                            drag.target: parent
                            drag.axis: Drag.YAxis
                            hoverEnabled: true

                            onClicked: {
                                view.currentIndex = model.index
                            }

                            onReleased: {
                                parent.y = 56 * model.index
                                parent.z = 1
                                drag_timer.stop()
                            }

                            onEntered: {
                                parent.scale = 1.03
                            }

                            onPressed: {
                                parent.z = 100
                                view.dragItem = parent
                                drag_timer.scroll = view.contentY
                                drag_timer.start()
                            }

                            onExited: {
                                parent.scale = 1.0
                            }
                        }

                        Timer {
                            id: drag_timer
                            interval: 1
                            running: false
                            repeat: true
                            property real scroll: 0
                            onTriggered: {
                                var endIndex = Math.round(parent.y / 56)
                                if (model.index !== endIndex && endIndex > -1 && endIndex < models.count) {
                                    var startIndex = model.index
                                    view.model.move(model.index, endIndex, 1)
                                    if (view.currentIndex == startIndex) {
                                        view.currentIndex = model.index
                                    }
                                    console.log("index: " + model.index)
                                    console.log("currentIndex: " + view.currentIndex)
                                }
                                if (scroll != view.contentY) {
                                    parent.y = parent.y - scroll + view.contentY
                                    scroll = view.contentY
                                }
                                if (!model_area.pressed) {
                                    parent.y = 56 * model.index
                                    parent.z = 1
                                    drag_timer.stop()
                                }
                            }
                        }
                    }

                    move: Transition {
                        NumberAnimation { properties: "y"; to: view.dragItem.y; duration: 0}
                    }
                    displaced: Transition {
                        NumberAnimation { properties: "y"; duration: 250 }
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

        Button {
            id: user
            Layout.preferredWidth: 280
            Layout.preferredHeight: 48
            Layout.columnSpan: 2
            Layout.row: 7
            Layout.alignment: Qt.AlignBottom
            background: Rectangle {
                border.width: 1
                color: (mouse_area.pressed) ? "#DDFFFF" : "white"
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                Image {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    source: "icons/user.svg"
                }

                Rectangle {
                    Layout.preferredWidth: 176
                    Layout.preferredHeight: 32
                    color: user.background.color
                    ColumnLayout {
                        anchors.fill: parent
                        Layout.preferredWidth: 176
                        Layout.preferredHeight: 32
                        spacing: 4

                        Rectangle {
                            Layout.preferredWidth: 172
                            Layout.preferredHeight: 14
                            color: user.background.color
                            clip: true
                            Text {
                                anchors.fill: parent
                                text: name
                                font.family: "Inter"
                                font.pointSize: 10
                            }
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 172
                            Layout.preferredHeight: 14
                            color: user.background.color
                            clip: true
                            Text {
                                anchors.fill: parent
                                text: "IP: " + ip
                                font.family: "Inter"
                                font.pointSize: 8
                                color: "#808080"
                            }
                        }
                    }
                }
            }

            MouseArea {
                id: mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    //Soon...
                }

                onEntered: {
                    parent.scale = 1.03
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }
    }
}