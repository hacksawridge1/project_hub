pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

// Прямоугольник боковой панели
Rectangle {
    id: sidebar
    Layout.leftMargin: -1
    Layout.preferredWidth: 305
    Layout.fillHeight: true
    color: get_theme("sidebar")
    border.width: 1
    property int index: users_view.currentIndex
    property ListModel users_list
    property string name
    property string ip
    property bool theme
    function get_theme(name) {
        var theme_name = {"sidebar": 0, "object": 1, "object(pressed)": 2, "object(active)": 3, "object_border": 4, 
        "text": 5, "second_text": 6, "placeholder": 7}
        var light_theme = ["#D9D9D9", "white", "#9999FF", "#DDFFFF", "black", "black", "#808080", "#AAAAAA"]
        var dark_theme = ["#262626", "black", "#222266", "#111133", "white", "white", "#7F7F7F", "#555555"]
        if (sidebar.theme) {
            return dark_theme[theme_name[name]]
        } else {
            return light_theme[theme_name[name]]
        }
        return "transparent"
    }

    function add_user(username, userip) {
        users_list.append({name: username, ip: userip})
    }

    function delete_user(index) {
        if (users_view.currentIndex == index) {
            if (users_view.count > 1) {
                ++users_view.currentIndex
            } else {
                users_view.currentIndex = -1
            }
        }
        users_list.remove(index)
    }

    // Сетка боковой панели
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 1
        spacing: 0

        // Поисковое поле
        Rectangle {
            Layout.preferredWidth: 288
            Layout.preferredHeight: 35
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            radius: 8
            border.color: sidebar.get_theme("object_border")
            border.width: 1
            color: sidebar.get_theme("object")
            clip: true

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 }
            }

            TextInput {
                id: search
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                font.pixelSize: 16
                color: sidebar.get_theme("text")
                property string placeholderText: "Поиск..."
                Text {
                    text: parent.placeholderText
                    font.family: "Inter"
                    anchors.fill: parent
                    font.pixelSize: parent.font.pixelSize
                    verticalAlignment: Text.AlignVCenter
                    color: sidebar.get_theme("placeholder")
                    visible: !parent.text
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                z: -1

                onEntered: {
                    parent.scale = 1.03
                }

                onExited: {
                    parent.scale = 1.0
                }
            }
        }

        // Кнопки меню (настройки, уведомления, общий чат, группы, папки, тема)
        RowLayout {
            Layout.preferredWidth: 288
            Layout.preferredHeight: 48
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            spacing: 4.8

            // Настройки
            Rectangle {
                id: settings
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (settings_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
                radius: 8

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
            Rectangle {
                id: notifications
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (notifications_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
                radius: 8

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
            Rectangle {
                id: public_chat
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (public_chat_area.pressed) ? sidebar.get_theme("object(pressed)") : (users_view.currentIndex == -1) ? sidebar.get_theme("object(active)") : sidebar.get_theme("object")
                radius: 8

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
                        users_view.currentIndex = -1
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
            Rectangle {
                id: groups
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (groups_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
                radius: 8

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
            Rectangle {
                id: folders
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (folders_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
                radius: 8

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
            Rectangle {
                id: theme
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: sidebar.get_theme("object_border")
                color: (theme_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
                radius: 8

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
                        if (control.theme) {
                            control.theme = false
                        } else {
                            control.theme = true
                        }
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

        Item {
            Layout.columnSpan: 6
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 6
            clip: true

            ListView {
                id: users_view
                anchors.fill: parent
                anchors.topMargin: 6
                spacing: 8
                model: sidebar.users_list
                property real dragY

                delegate: Item {
                    id: delegate
                    width: users_view.width
                    height: 48
                    required property var model
                    Rectangle {
                        id: model_user
                        width: 288
                        height: 48
                        anchors.horizontalCenter: parent.horizontalCenter
                        z: 1
                        border.width: 1
                        border.color: sidebar.get_theme("object_border")
                        color: (model_area.pressed) ? sidebar.get_theme("object(pressed)") : (users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("object(active)") : sidebar.get_theme("object")
                        radius: 8

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

                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: delegate.model.name
                                    color: sidebar.get_theme("text")
                                    font.family: "Inter"
                                    font.pixelSize: 13
                                }
                                
                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: "IP: " + delegate.model.ip
                                    font.family: "Inter"
                                    font.pixelSize: 11
                                    color: sidebar.get_theme("second_text")
                                }
                            }
                        }

                        MouseArea {
                            id: model_area
                            anchors.fill: parent
                            drag.target: delegate
                            drag.axis: Drag.YAxis + 0
                            hoverEnabled: true

                            onClicked: {
                                users_view.currentIndex = delegate.model.index
                            }

                            onPressed: {
                                parent.scale = 0.97
                                delegate.z = 100
                                drag_timer.scroll = users_view.contentY
                                drag_timer.startY = delegate.y
                                drag_timer.start()
                            }

                            onReleased: {
                                parent.scale = 1.03
                                delegate.z = 1
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
                                var endIndex = Math.round(delegate.y / 56)
                                if (delegate.model.index !== endIndex && endIndex > -1 && endIndex < users_list.count) {
                                    var startIndex = delegate.model.index
                                    users_view.dragY = delegate.y
                                    users_view.model.move(delegate.model.index, endIndex, 1)
                                    if (users_view.currentIndex == startIndex) {
                                        users_view.currentIndex = delegate.model.index
                                    }
                                }
                                if (scroll != users_view.contentY) {
                                    delegate.y = delegate.y - scroll
                                    scroll = users_view.contentY
                                }
                                if (!model_area.pressed) {
                                    delegate.y = 56 * delegate.model.index + users_view.contentY
                                    delegate.z = 1
                                    drag_timer.stop()
                                }
                                if (delegate.y != startY && parent.scale < 1) {
                                    parent.scale = 1.03
                                }
                            }
                        }
                        NumberAnimation { id: back; target: delegate; property: "y"; to: 56 * delegate.model.index; duration: 150 }
                    }
                }

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
                move: Transition {
                    NumberAnimation { property: "y"; to: users_view.dragY; duration: 0 }
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

        Rectangle {
            id: user
            Layout.preferredWidth: 304
            Layout.preferredHeight: 70
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: -10
            border.width: 1
            border.color: sidebar.get_theme("object_border")
            color: (mouse_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")
            radius:8

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                anchors.bottomMargin: 8 + 10
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
                                color: sidebar.get_theme("text")
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
                                color: sidebar.get_theme("second_text")
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