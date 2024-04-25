pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

// Прямоугольник боковой панели
Rectangle {
    id: sidebar
    Layout.preferredWidth: 304
    Layout.fillHeight: true
    color: "#D9D9D9"
    property int index: view.currentIndex
    property ListModel models
    property string name
    property string ip

    function add_user(username, userip) {
        models.append({name: username, ip: userip})
    }

    function delete_user(index) {
        if (view.currentIndex == index) {
            if (view.count > 1) {
                ++view.currentIndex
            } else {
                view.currentIndex = -1
            }
        }
        models.remove(index)
    }

    // Сетка боковой панели
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Поисковое поле
        Rectangle {
            Layout.preferredWidth: 288
            Layout.preferredHeight: 35
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            border.width: 1
            clip: true

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 }
            }

            TextInput {
                id: search
                anchors.fill: parent
                anchors.margins: 8
                font.pixelSize: 16
                color: "black"
                property string placeholderText: "Поиск..."
                Text {
                    text: parent.placeholderText
                    font.family: "Inter"
                    font.pixelSize: parent.font.pixelSize
                    color: "#aaa"
                    visible: !parent.text
                }
            }
        }

        // Кнопки меню (настройки, уведомления, общий чат, группы, папки, тема)
        RowLayout {
            Layout.preferredWidth: 288
            Layout.preferredHeight: 48
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            spacing: 9.6

            // Настройки
            Button {
                id: settings
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (settings_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
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

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            // Уведомления
            Button {
                id: notifications
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (notifications_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/notifications.svg"
                }

                MouseArea {
                    id: notifications_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            // Общий чат
            Button {
                id: public_chat
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (view.currentIndex == -1) ? (public_chat_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (public_chat_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/public-chat.svg"
                }

                MouseArea {
                    id: public_chat_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        view.currentIndex = -1
                    }

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            // Группы
            Button {
                id: groups
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (groups_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/group.svg"
                }

                MouseArea {
                    id: groups_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }
            
            // Папки
            Button {
                id: folders
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (folders_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/folder.svg"
                }

                MouseArea {
                    id: folders_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            // Тема
            Button {
                id: theme
                Layout.preferredWidth: 40
                Layout.preferredHeight: 48

                background: Rectangle {
                    border.width: 1
                    color: (theme_area.pressed) ? "#DDFFFF" : "white"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/theme.svg"
                }

                MouseArea {
                    id: theme_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        sidebar.add_user("Anton", "0.0.0.0")
                    }

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }
        }

        Rectangle {
            id: users
            Layout.columnSpan: 6
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 4
            color: "#D9D9D9"
            clip: true

            ListView {
                id: view
                anchors.fill: parent
                anchors.topMargin: 4
                spacing: 8
                model: sidebar.models
                property real dragY

                delegate: Button {
                    id: model_user
                    width: 288
                    height: 48
                    anchors.horizontalCenter: parent.horizontalCenter
                    parent: view
                    z: 1
                    required property var model
                    background: Rectangle {
                        border.width: 1
                        color: (view.currentIndex == model_user.model.index) ? (model_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (model_area.pressed) ? "#DDFFFF" : "white"
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
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

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4

                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true
                                Text {
                                    anchors.fill: parent
                                    text: model_user.model.name
                                    font.family: "Inter"
                                    font.pixelSize: 13
                                }
                            }
                            
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true
                                Text {
                                    anchors.fill: parent
                                    text: "IP: " + sidebar.ip
                                    font.family: "Inter"
                                    font.pixelSize: 11
                                    color: "#808080"
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
                            view.currentIndex = model_user.model.index
                        }

                        onPressed: {
                            parent.scale = 0.97
                            parent.z = 100
                            drag_timer.scroll = view.contentY
                            drag_timer.startY = parent.y
                            drag_timer.start()
                        }

                        onReleased: {
                            parent.scale = 1.03
                            parent.z = 1
                            drag_timer.stop()
                            back.start()
                        }

                        onEntered: {
                            parent.scale = 1.03
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
                        property real startY: 0
                        onTriggered: {
                            var endIndex = Math.round(parent.y / 56)
                            if (parent.model.index !== endIndex && endIndex > -1 && endIndex < models.count) {
                                var startIndex = model.index
                                view.dragY = parent.y
                                view.model.move(model.index, endIndex, 1)
                                if (view.currentIndex == startIndex) {
                                    view.currentIndex = model.index
                                }
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
                            if (parent.y != startY && parent.scale < 1) {
                                parent.scale = 1.03
                            }
                        }
                    }
                    NumberAnimation { id: back; target: model_user; property: "y"; to: 56 * model_user.model.index; duration: 150 }
                }

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
                move: Transition {
                    NumberAnimation { property: "y"; to: view.dragY; duration: 0 }
                }
                displaced: Transition {
                    NumberAnimation { property: "y"; duration: 250 }
                }
                remove: Transition {
                    NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 1.0; to: 0; duration: 400 }
                }

                ScrollBar.vertical: ScrollBar {
                    active: true
                    height: parent.height
                    policy: ScrollBar.AlwaysOff
                }
            }
        }

        Button {
            id: user
            Layout.preferredWidth: 304
            Layout.preferredHeight: 60
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignBottom
            background: Rectangle {
                border.width: 1
                color: (mouse_area.pressed) ? "#DDFFFF" : "white"
            }

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
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

                Item {
                    Layout.preferredWidth: 176
                    Layout.preferredHeight: 32
                    ColumnLayout {
                        anchors.fill: parent
                        Layout.preferredWidth: 176
                        Layout.preferredHeight: 32
                        spacing: 4
                        Item {
                            Layout.preferredWidth: 172
                            Layout.preferredHeight: 14
                            clip: true
                            Text {
                                anchors.fill: parent
                                text: sidebar.name
                                font.family: "Inter"
                                font.pixelSize: 13
                            }
                        }
                        
                        Item {
                            Layout.preferredWidth: 172
                            Layout.preferredHeight: 14
                            clip: true
                            Text {
                                anchors.fill: parent
                                text: "IP: " + sidebar.ip
                                font.family: "Inter"
                                font.pixelSize: 11
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
            }
        }
    }
}