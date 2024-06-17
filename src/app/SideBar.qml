pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Controller

// Прямоугольник боковой панели
Rectangle {
    id: sidebar
    Layout.preferredWidth: 500
    Layout.fillHeight: true
    color: get_theme("sidebar")
    property int index: users_view.currentIndex
    property ListModel users_list
    property string name
    property string ip
    property bool theme
    function get_theme(name, theme = sidebar.theme) {
        var theme_name = {"sidebar": 0, "object": 1, "object(hovered)": 2, "object(pressed)": 3, "object_border": 4, 
        "text": 5, "second_text": 6, "placeholder": 7}
        var light_theme = ["#D9D9D9", "white", "#929292", "#585858", "black", "black", "#808080", "#AAAAAA"]
        var dark_theme = ["#262626", "#464646", "#929292", "#E2E2E2", "black", "white", "#E0E0E0", "#555555"]
        if (theme) {
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

    property var costil

    // Сетка боковой панели
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Поисковое поле
        Rectangle {
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
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.topMargin: 12
            Layout.alignment: Qt.AlignHCenter
            spacing: 4.8

            // Настройки
            Rectangle {
                id: settings
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (settings_area.pressed) ? sidebar.get_theme("object(pressed)") : (settings_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/settings.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (settings_area.pressed) ? "black" : "white" : (settings_area.pressed || settings_area.containsMouse) ? "white" : "black"
                    }
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
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (notifications_area.pressed) ? sidebar.get_theme("object(pressed)") : (notifications_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/notifications.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (notifications_area.pressed) ? "black" : "white" : (notifications_area.pressed || notifications_area.containsMouse) ? "white" : "black"
                    }
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
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (public_chat_area.pressed) ? sidebar.get_theme("object(pressed)") : (public_chat_area.containsMouse || users_view.currentIndex == -1) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/public-chat.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (public_chat_area.pressed) ? "black" : "white" : (public_chat_area.pressed || public_chat_area.containsMouse || users_view.currentIndex == -1) ? "white" : "black"
                    }
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
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (groups_area.pressed) ? sidebar.get_theme("object(pressed)") : (groups_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/group.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (groups_area.pressed) ? "black" : "white" : (groups_area.pressed || groups_area.containsMouse) ? "white" : "black"
                    }
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
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (folders_area.pressed) ? sidebar.get_theme("object(pressed)") : (folders_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/folder.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (folders_area.pressed) ? "black" : "white" : (folders_area.pressed || folders_area.containsMouse) ? "white" : "black"
                    }
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
                Layout.preferredWidth: 75
                Layout.preferredHeight: 56
                border.width: (sidebar.theme) ? 0 : 2
                border.color: sidebar.get_theme("object_border")
                color: (theme_area.pressed) ? sidebar.get_theme("object(pressed)") : (theme_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                radius: 8

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                Image {
                    width: 32
                    height: 32
                    anchors.centerIn: parent
                    source: "icons/theme.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (theme_area.pressed) ? "black" : "white" : (theme_area.pressed || theme_area.containsMouse) ? "white" : "black"
                    }
                }

                MouseArea {
                    id: theme_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if (Control.theme) {
                            Control.theme = false
                        } else {
                            Control.theme = true
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

            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            id: view_loc
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
                boundsBehavior: Flickable.StopAtBounds
                property real dragY

                delegate: Item {
                    id: delegate
                    width: users_view.width
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
                        color: (model_area.pressed) ? sidebar.get_theme("object(pressed)") : (model_area.containsMouse || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                        radius: 8
                        property real saved_y

                        Behavior on scale {
                            NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            anchors.topMargin: 8
                            anchors.bottomMargin: 8
                            spacing: 8

                            Image {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                source: "icons/user.svg"

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: (sidebar.theme) ? (model_area.pressed) ? "#545454" : "white" : (model_area.pressed || model_area.containsMouse || users_view.currentIndex == delegate.model.index) ? "white" : "#545454"
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
                                    color: (sidebar.theme) ? (model_area.pressed) ? sidebar.get_theme("text", false) : sidebar.get_theme("text") : (model_area.pressed || model_area.containsMouse || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("text", true) : sidebar.get_theme("text")
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
                                    color: (sidebar.theme) ? (model_area.pressed) ? sidebar.get_theme("second_text", false) : sidebar.get_theme("second_text") : (model_area.pressed || model_area.containsMouse || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: 1
                                Layout.fillHeight: true
                                color: (sidebar.theme && model_area.pressed) ? "#545454" : "#D9D9D9"
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
                                color: (sidebar.theme) ? (model_area.pressed) ? sidebar.get_theme("second_text", false) : sidebar.get_theme("second_text") : (model_area.pressed || model_area.containsMouse || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
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
                                }
                            }
                        }

                        MouseArea {
                            id: model_area
                            anchors.fill: parent
                            drag.target: parent
                            drag.axis: Drag.YAxis
                            hoverEnabled: true
                            property bool entered: false

                            onClicked: {
                                users_view.currentIndex = delegate.model.index
                            }

                            onPressed: {
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
                                back.start()
                            }

                            onEntered: {
                                parent.scale = 1.03
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
                    }
                }

                add: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
                displaced: Transition {
                    NumberAnimation { property: "y"; duration: 250 }
                }
                remove: Transition {
                    NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 1.0; to: 0; duration: 400 }
                }
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
            color: (user_card_area.pressed) ? sidebar.get_theme("object(pressed)") : (user_card_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                anchors.bottomMargin: 8 + 2
                anchors.leftMargin: 8 + 2
                spacing: 8

                Image {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    source: "icons/user.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? (user_card_area.pressed) ? "#545454" : "white" : (user_card_area.pressed || user_card_area.containsMouse) ? "white" : "#545454"
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
                        color: (sidebar.theme) ? (user_card_area.pressed) ? sidebar.get_theme("text", false) : sidebar.get_theme("text") : (user_card_area.pressed || user_card_area.containsMouse) ? sidebar.get_theme("text", true) : sidebar.get_theme("text")
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
                        color: (sidebar.theme) ? (user_card_area.pressed) ? sidebar.get_theme("second_text", false) : sidebar.get_theme("second_text") : (user_card_area.pressed || user_card_area.containsMouse) ? sidebar.get_theme("second_text", true) : sidebar.get_theme("second_text")
                    }
                }
            }

            MouseArea {
                id: user_card_area
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }
}