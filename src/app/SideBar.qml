pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects

// Прямоугольник боковой панели
Rectangle {
    id: sidebar
    Layout.preferredWidth: 304
    Layout.fillHeight: true
    color: get_theme("sidebar")
    property int index: users_view.currentIndex
    property ListModel users_list
    property string name
    property string ip
    property bool theme
    function get_theme(name) {
        var theme_name = {"sidebar": 0, "object": 1, "object(hovered)": 2, "object(pressed)": 3, "object_border": 4, 
        "text": 5, "second_text": 6, "placeholder": 7}
        var light_theme = ["#D9D9D9", "white", "#929292", "#585858", "black", "black", "#808080", "#AAAAAA"]
        var dark_theme = ["#262626", "#585858", "#262626", "#3f4343", "black", "white", "#7F7F7F", "#555555"]
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
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

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "white" : "black"
                    }
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
                    height: 56
                    required property var model

                    Rectangle {
                        id: model_user
                        width: 288
                        height: 56
                        anchors.horizontalCenter: parent.horizontalCenter
                        z: 1
                        border.width: 1
                        border.color: sidebar.get_theme("object_border")
                        color: (model_area.pressed || users_view.currentIndex == delegate.model.index) ? sidebar.get_theme("object(pressed)") : (model_area.containsMouse) ? sidebar.get_theme("object(hovered)") : sidebar.get_theme("object")
                        radius: 8
                        property real saved_y

                        Behavior on scale {
                            NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            anchors.topMargin: 12
                            anchors.bottomMargin: 12
                            spacing: 8

                            Image {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                source: "icons/user.svg"

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index || sidebar.theme) ? "#ABACAC" : "#545353"
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 4

                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.alignment: Qt.AlignBottom
                                    text: delegate.model.name
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index) ? "white" : sidebar.get_theme("text")
                                    font.family: "Inter"
                                    font.pixelSize: 14
                                }
                                
                                Text {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.alignment: Qt.AlignVCenter
                                    text: "IP: " + delegate.model.ip
                                    font.family: "Inter"
                                    font.pixelSize: 12
                                    color: (model_area.pressed || users_view.currentIndex == delegate.model.index) ? "#AFAFAF" : sidebar.get_theme("second_text")
                                }
                            }
                        }

                        onYChanged: {
                            if (z == 100) {
                                var endIndex = Math.round((model_user.y + users_view.contentY - 6) / 56)
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
                                    var endIndex = Math.round((model_user.y + users_view.contentY - 6) / 56)
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

                        Timer {
                            id: dragAct
                            interval: 1
                            repeat: true
                            onTriggered: {
                                if (parent.z == 100) {
                                    var endIndex = Math.round((model_user.y + users_view.contentY - 6) / 56)
                                    if (delegate.model.index !== endIndex && endIndex > -1 && endIndex < users_list.count) {
                                        var startIndex = delegate.model.index
                                        users_view.dragY = delegate.y
                                        users_view.model.move(delegate.model.index, endIndex, 1)
                                    }
                                    if (parent.scale < 1) {
                                        parent.scale = 1.03
                                    }
                                }
                            }
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
            Layout.preferredWidth: 304 + 1
            Layout.preferredHeight: 60 + 1
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignBottom
            Layout.leftMargin: -1
            Layout.bottomMargin: -1
            border.width: 1
            border.color: sidebar.get_theme("object_border")
            color: (mouse_area.pressed) ? sidebar.get_theme("object(pressed)") : sidebar.get_theme("object")

            Behavior on scale {
                NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                anchors.bottomMargin: 8 + 1
                anchors.leftMargin: 8 + 1
                spacing: 8

                Image {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    source: "icons/user.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (sidebar.theme) ? "#ABACAC" : "#545353"
                    }
                }

                ColumnLayout {
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
                            font.pixelSize: 14
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
                            font.pixelSize: 12
                            color: sidebar.get_theme("second_text")
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