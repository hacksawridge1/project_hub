pragma ComponentBehavior: Bound
import QtQuick
<<<<<<< HEAD
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
=======
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Controller
>>>>>>> develop

// Прямоугольник боковой панели
Rectangle {
    id: sidebar
<<<<<<< HEAD
    Layout.leftMargin: -1
    Layout.preferredWidth: 305
    Layout.fillHeight: true
    color: "#D9D9D9"
    border.width: 1
=======
    Layout.preferredWidth: 500
    Layout.fillHeight: true
    color: get_theme("sidebar")
>>>>>>> develop
    property int index: users_view.currentIndex
    property ListModel users_list
    property string name
    property string ip
<<<<<<< HEAD
=======
    property bool theme
    function get_theme(name, theme = sidebar.theme) {
        var theme_name = {"sidebar": 0, "object": 1, "object(hovered)": 2, "object(pressed)": 3, "object_border": 4, 
        "text": 5, "second_text": 6, "placeholder": 7}
        var light_theme = ["#D9D9D9", "white", "#929292", "#585858", "black", "black", "#808080", "#AAAAAA"]
        var dark_theme = ["#262626", "#464646", "#262626", "#3f4343", "black", "white", "#AFAFAF", "#555555"]
        if (theme) {
            return dark_theme[theme_name[name]]
        } else {
            return light_theme[theme_name[name]]
        }
        return "transparent"
    }
>>>>>>> develop

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

<<<<<<< HEAD
    // Сетка боковой панели
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 1
=======
    property var costil

    // Сетка боковой панели
    ColumnLayout {
        anchors.fill: parent
>>>>>>> develop
        spacing: 0

        // Поисковое поле
        Rectangle {
<<<<<<< HEAD
            Layout.preferredWidth: 288
            Layout.preferredHeight: 35
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            radius: 8
            border.width: 1
=======
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            Layout.topMargin: 12
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.alignment: Qt.AlignHCenter
            radius: 8
            border.color: sidebar.get_theme("object_border")
            border.width: (sidebar.theme) ? 0 : 2
            color: sidebar.get_theme("object")
>>>>>>> develop
            clip: true

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 }
            }

            TextInput {
                id: search
                anchors.fill: parent
<<<<<<< HEAD
                anchors.margins: 8
                font.pixelSize: 16
                color: "black"
=======
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                font.pixelSize: 16
                color: sidebar.get_theme("text")
>>>>>>> develop
                property string placeholderText: "Поиск..."
                Text {
                    text: parent.placeholderText
                    font.family: "Inter"
<<<<<<< HEAD
                    font.pixelSize: parent.font.pixelSize
                    color: "#aaa"
                    visible: !parent.text
                }
            }
=======
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
>>>>>>> develop
        }

        // Кнопки меню (настройки, уведомления, общий чат, группы, папки, тема)
        RowLayout {
<<<<<<< HEAD
            Layout.preferredWidth: 288
            Layout.preferredHeight: 48
=======
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            Layout.leftMargin: 8
            Layout.rightMargin: 8
>>>>>>> develop
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            spacing: 4.8

            // Настройки
<<<<<<< HEAD
            Button {
                id: settings
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (settings_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: settings
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (settings_area.pressed) ? sidebar.get_theme("object(pressed)") : (settings_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/settings.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (settings_area.pressed || settings_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
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
<<<<<<< HEAD
            Button {
                id: notifications
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (notifications_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: notifications
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (notifications_area.pressed) ? sidebar.get_theme("object(pressed)") : (notifications_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/notifications.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (notifications_area.pressed || notifications_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
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
<<<<<<< HEAD
            Button {
                id: public_chat
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (users_view.currentIndex == -1) ? (public_chat_area.pressed) ? "#AAFFFF" : "#DDDDFF" :  (public_chat_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: public_chat
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (public_chat_area.pressed || users_view.currentIndex == -1) ? sidebar.get_theme("object(pressed)") : (public_chat_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/public-chat.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (public_chat_area.pressed || users_view.currentIndex == -1 || public_chat_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
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
<<<<<<< HEAD
            Button {
                id: groups
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (groups_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: groups
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (groups_area.pressed) ? sidebar.get_theme("object(pressed)") : (groups_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/group.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (groups_area.pressed || groups_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
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
<<<<<<< HEAD
            Button {
                id: folders
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (folders_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: folders
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (folders_area.pressed) ? sidebar.get_theme("object(pressed)") : (folders_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/folder.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (folders_area.pressed || folders_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
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
<<<<<<< HEAD
            Button {
                id: theme
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56

                background: Rectangle {
                    border.width: 1
                    color: (theme_area.pressed) ? "#DDFFFF" : "white"
                    radius: 8
                }
=======
            Rectangle {
                id: theme
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (theme_area.pressed) ? sidebar.get_theme("object(pressed)") : (theme_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8
>>>>>>> develop

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/theme.svg"
<<<<<<< HEAD
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (theme_area.pressed || theme_area.containsMouse || sidebar.theme) ? "white" : "black"
                    }
>>>>>>> develop
                }

                MouseArea {
                    id: theme_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
<<<<<<< HEAD
                        sidebar.add_user("Anton", "0.0.0.0")
=======
                        if (Control.theme) {
                            Control.theme = false
                        } else {
                            Control.theme = true
                        }
>>>>>>> develop
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
<<<<<<< HEAD
        }

        Item {
=======

            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            id: view_loc
>>>>>>> develop
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
<<<<<<< HEAD
=======
                boundsBehavior: Flickable.StopAtBounds
>>>>>>> develop
                property real dragY

                delegate: Item {
                    id: delegate
                    width: users_view.width
<<<<<<< HEAD
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
=======
                    height: 64
                    required property var model

                    Rectangle {
                        id: model_user
                        width: delegate.width - 16
                        height: delegate.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        z: 1
                        border.width: (sidebar.theme) ? 0 : 2
                        border.color: sidebar.get_theme("object_border")
                        color: (model_area.pressed || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("object(pressed)") : (model_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                        radius: 8
                        property real saved_y
>>>>>>> develop

                        Behavior on scale {
                            NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
<<<<<<< HEAD
=======
                            anchors.topMargin: 8
                            anchors.bottomMargin: 8
>>>>>>> develop
                            spacing: 8

                            Image {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                source: "icons/user.svg"
<<<<<<< HEAD
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
=======

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index || model_area.containsMouse || sidebar.theme) ? "#ABACAC" : "#545353"
                                }
                            }

                            ColumnLayout {
                                Layout.preferredWidth: 94
                                Layout.fillHeight: true
                                spacing: 3

                                Text {
                                    Layout.fillHeight: true
                                    verticalAlignment: Text.AlignBottom
                                    text: delegate.model.name
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index || model_area.containsMouse) ? sidebar.get_theme("text", true) : sidebar.get_theme("text")
                                    font.family: "Inter"
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                }
                                
                                Text {
                                    Layout.fillHeight: true
                                    verticalAlignment: Text.AlignTop
                                    text: "IP: " + delegate.model.ip
                                    font.family: "Inter"
                                    font.pixelSize: 12
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index || model_area.containsMouse) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: 1
                                Layout.fillHeight: true
                                color: sidebar.get_theme("sidebar")
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.topMargin: -4
                                Layout.bottomMargin: -4
                                wrapMode: Text.Wrap
                                text: (delegate.model.last_message) ? delegate.model.last_message : ""
                                font.family: "Inter"
                                font.pixelSize: 17
                                color: (model_area.pressed || users_view.currentIndex == delegate.model.index || model_area.containsMouse) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
                                lineHeight: 0.75
                                elide: Text.ElideRight
                            }
                        }

                        onYChanged: {
                            if (z == 100) {
                                var endIndex = Math.round((model_user.y + users_view.contentY - 6) / (delegate.height + users_view.spacing))
                                if (delegate.model.index !== endIndex && endIndex > -1 && endIndex < users_list.count) {
                                    var startIndex = delegate.model.index
                                    users_view.dragY = delegate.y
                                    users_view.model.move(delegate.model.index, endIndex, 1)
                                }
                                if (scale < 1) {
                                    scale = 1.03
                                }
                            }
                        }

                        Connections {
                            target: users_view
                            function onContentYChanged() {
                                if (model_user.z == 100) {
                                    var endIndex = Math.round((model_user.y + users_view.contentY - 6) / 72)
                                    if (delegate.model.index !== endIndex && endIndex > -1 && endIndex < users_list.count) {
                                        var startIndex = delegate.model.index
                                        users_view.dragY = delegate.y
                                        users_view.model.move(delegate.model.index, endIndex, 1)
                                    }
                                    if (model_user.scale < 1) {
                                        model_user.scale = 1.03
                                    }
>>>>>>> develop
                                }
                            }
                        }

                        MouseArea {
                            id: model_area
                            anchors.fill: parent
<<<<<<< HEAD
                            drag.target: delegate
                            drag.axis: Drag.YAxis
                            hoverEnabled: true
=======
                            drag.target: parent
                            drag.axis: Drag.YAxis
                            hoverEnabled: true
                            property bool entered: false
>>>>>>> develop

                            onClicked: {
                                users_view.currentIndex = delegate.model.index
                            }

                            onPressed: {
<<<<<<< HEAD
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
=======
                                back.stop()
                                parent.scale = 0.97
                                parent.z = 100
                                parent.parent = view_loc
                                parent.saved_y = delegate.y - users_view.contentY + 6
                                parent.y = parent.saved_y
                            }

                            onReleased: {
                                parent.z = 101
                                if (entered) {
                                    parent.scale = 1.03
                                } else {
                                    parent.scale = 1.0
                                }
                                parent.saved_y = delegate.mapToItem(view_loc, 0, 0).y
>>>>>>> develop
                                back.start()
                            }

                            onEntered: {
                                parent.scale = 1.03
<<<<<<< HEAD
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
                                    delegate.y = delegate.y - scroll + users_view.contentY
                                    scroll = users_view.contentY
                                }
                                if (!model_area.pressed) {
                                    delegate.y = 56 * delegate.model.index
                                    delegate.z = 1
                                    drag_timer.stop()
                                }
                                if (delegate.y != startY && parent.scale < 1) {
                                    parent.scale = 1.03
                                }
                            }
                        }
                        NumberAnimation { id: back; target: delegate; property: "y"; to: 56 * delegate.model.index; duration: 150 }
=======
                                entered = true
                            }

                            onExited: {
                                if (parent.z != 100) {
                                    parent.scale = 1.0
                                }
                                entered = false
                            }
                        }

                        SequentialAnimation {
                            id: back
                            NumberAnimation { target: model_user; property: "y"; to: model_user.saved_y; duration: 150 }
                            PropertyAction { target: model_user; property: "z"; value: 1 }
                            PropertyAction { target: model_user; property: "parent"; value: delegate }
                            PropertyAction { target: model_user; property: "y"; value: 0 }
                        }
>>>>>>> develop
                    }
                }

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
<<<<<<< HEAD
                move: Transition {
                    NumberAnimation { property: "y"; to: users_view.dragY; duration: 0 }
                }
=======
>>>>>>> develop
                displaced: Transition {
                    NumberAnimation { property: "y"; duration: 250 }
                }
                remove: Transition {
                    NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 1.0; to: 0; duration: 400 }
                }
<<<<<<< HEAD

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
=======
            }
        }

        Rectangle {
            id: user
            Layout.preferredWidth: 500 + 2
            Layout.preferredHeight: 64 + 2
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignBottom
            Layout.leftMargin: -2
            Layout.bottomMargin: -2
            border.width: (sidebar.theme) ? 0 : 2
            border.color: sidebar.get_theme("object_border")
            color: (mouse_area.pressed) ? sidebar.get_theme("object(pressed)") : (mouse_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
>>>>>>> develop

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
<<<<<<< HEAD
                anchors.bottomMargin: 8 + 10
=======
                anchors.bottomMargin: 8 + 2
                anchors.leftMargin: 8 + 2
>>>>>>> develop
                spacing: 8

                Image {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    source: "icons/user.svg"
<<<<<<< HEAD
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
=======

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (mouse_area.pressed || mouse_area.containsMouse || sidebar.theme) ? "#ABACAC" : "#545353"
                    }
                }
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 3

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        verticalAlignment: Text.AlignBottom
                        text: sidebar.name
                        color: (mouse_area.pressed || mouse_area.containsMouse) ? sidebar.get_theme("text", true) : sidebar.get_theme("text")
                        font.family: "Inter"
                        font.pixelSize: 14
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        verticalAlignment: Text.AlignTop
                        text: "IP: " + sidebar.ip
                        font.family: "Inter"
                        font.pixelSize: 12
                        color: (mouse_area.pressed || mouse_area.containsMouse) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
>>>>>>> develop
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