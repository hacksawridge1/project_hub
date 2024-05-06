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
    color: "#D9D9D9"
    border.width: 1
    property int index: users_view.currentIndex
    property ListModel users_list
    property string name
    property string ip

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
            spacing: 4.8

            // Настройки
            Button {
                id: settings
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (settings_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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

                    onClicked: {
                        let msg = "Нажата кнопка settingsButton"
                        control.settingsButton(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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

            // Уведомления
            Button {
                id: notifications
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (notifications_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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

                    onClicked: {
                        let msg = "Нажата кнопка notificationsButton"
                        control.notificationsButton(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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

            // Общий чат
            Button {
                id: public_chat
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (users_view.currentIndex == -1) ? (public_chat_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (public_chat_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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
                        users_view.currentIndex = -1

                        let msg = "Нажата кнопка chatsButton"
                        control.chatsButton(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (groups_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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

                    onClicked: {
                        let msg = "Нажата кнопка friendsButton"
                        control.friendsButton(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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
            
            // Папки
            Button {
                id: folders
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (folders_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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

                    onClicked: {
                        let msg = "Нажата кнопка folders"
                        control.folders(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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

            // Тема
            Button {
                id: theme
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (theme_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
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

                        let msg = "Нажата кнопка themeButton"
                        control.themeButton(msg)
                        chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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
                    Button {
                        id: model_user
                        width: 288
                        height: 48
                        anchors.horizontalCenter: parent.horizontalCenter
                        z: 1
                        
                        background: Rectangle {
                            border.width: 1
                            color: (users_view.currentIndex == delegate.model.index) ? (model_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (model_area.pressed) ? "#DDFFFF" : "white"
                            radius: 8
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

                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: delegate.model.name
                                    font.family: "Inter"
                                    font.pixelSize: 13
                                }
                                
                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: "IP: " + sidebar.ip
                                    font.family: "Inter"
                                    font.pixelSize: 11
                                    color: "#808080"
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
                                let msg = "Нажата кнопка listUsersButton"
                                control.listUsersButton(msg)
                                chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
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

        Button {
            id: user
            Layout.preferredWidth: 304
            Layout.preferredHeight: 70
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: -10
            background: Rectangle {
                border.width: 1
                color: (mouse_area.pressed) ? "#DDFFFF" : "white"
                radius:8
            }

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
                    let msg = "Нажата кнопка profileButton"
                    control.profileButton(msg)
                    chat.messages_list.insert(0, {"ip": chat.ip, "message": msg})
                }
            }
        }
    }
}