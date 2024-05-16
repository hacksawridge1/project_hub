pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects

// Сетка чата
ColumnLayout {
    id: chat
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 0
    property bool connected
    property var user
    property ListModel messages_list
    property string name
    property string ip
    property bool theme
    function get_theme(name) {
        var theme_name = {"top_panel": 0, "chat": 1, "object": 2, "object(pressed)": 3, "object(active)": 4, "object_border": 5, 
        "chat_object": 6, "chat_object(pressed)": 7, "chat_object_border": 8, "text": 9, "second_text": 10, "title": 11, 
        "placeholder": 12, "message": 13, "message_shadow": 14}
        var light_theme = ["#D9D9D9", "white", "white", "#9999FF", "#DDFFFF", "black", "#D9D9D9", "#D9D9FF", "black", "black",  "#808080", "#545353", "#AAAAAA", "#E9E9E9", "#C0C0C0"]
        var dark_theme = ["#262626", "black", "black", "#222266", "#111133", "white", "#262626", "#26267A", "white", "white", "#7F7F7F", "#ABACAC", "#555555", "#161616", "#3F3F3F"]
        if (chat.theme) {
            return dark_theme[theme_name[name]]
        } else {
            return light_theme[theme_name[name]]
        }
        return "transparent"
    }

    function add_message(name, ip, message) {
        chat.messages_list.insert(0, {"name": name, "ip": ip, "message": message})
    }

    // Верхняя панель
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        Layout.leftMargin: -1
        Layout.rightMargin: -1
        color: chat.get_theme("top_panel")
        visible: (chat.connected) ? true : false
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12 + 1
            anchors.rightMargin: 12 + 1

            Rectangle {
                Layout.preferredWidth: 300
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: chat.get_theme("object")
                border.width: 1
                border.color: chat.get_theme("object_border")
                radius: 8
                visible: (typeof chat.user == "undefined") ? false : true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    anchors.topMargin: 10
                    anchors.bottomMargin: 12
                    spacing: 4

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: (typeof chat.user == "undefined") ? "" : chat.user.name
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: chat.get_theme("text")
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: (typeof chat.user == "undefined") ? "" : "был в сети " + (chat.user.last_time > 59 ? Math.round(chat.user.last_time / 60) + " часов назад" : chat.user.last_time + " минут назад")
                        font.family: "Inter"
                        font.pixelSize: 12
                        color: chat.get_theme("second_text")
                    }
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.03
                    }

                    onEntered: {
                        parent.scale = 1.03
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            Text {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "Общий чат"
                font.bold: true
                font.family: "Inter"
                font.pixelSize: 38
                color: chat.get_theme("title")
                visible: (typeof chat.user == "undefined") ? true : false
            }

            RowLayout {
                Layout.preferredWidth: 144
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: (typeof chat.user == "undefined") ? false : true
                spacing: 12

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    border.color: chat.get_theme("object_border")
                    color: chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/phone.svg"
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
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

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    border.color: chat.get_theme("object_border")
                    color: chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/search.svg"
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
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

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    border.color: chat.get_theme("object_border")
                    color: chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/more.svg"
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
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
            }
        }
    }

    // Блок чата
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: (chat.connected) ? chat.get_theme("chat") : chat.get_theme("top_panel")
        clip: true

        Text {
            anchors.centerIn: parent
            text: "Добро пожаловать в HUB."
            font.bold: true
            font.family: "Inter"
            font.pixelSize: 64
            color: chat.get_theme("title")
            visible: (chat.connected) ? false : true
        }

        ListView {
            id: messages_view
            anchors.fill: parent
            verticalLayoutDirection: ListView.BottomToTop
            model: chat.messages_list
            visible: (chat.connected) ? true : false
            delegate: Item {
                id: delegate
                width: messages_view.width
                implicitHeight: message.implicitHeight + 8
                required property var model
                RowLayout {
                    id: message
                    anchors.left: (chat.ip != delegate.model.ip) ? parent.left : undefined
                    anchors.right: (chat.ip == delegate.model.ip) ? parent.right : undefined
                    layoutDirection: (chat.ip == delegate.model.ip) ? Qt.RightToLeft : Qt.LeftToRight
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    spacing: 8
                    
                    Rectangle {
                        id: userbox
                        Layout.preferredWidth: 42
                        Layout.preferredHeight: 42
                        Layout.alignment: Qt.AlignBottom
                        border.width: 1
                        border.color: chat.get_theme("chat_object_border")
                        color: chat.get_theme("chat_object")
                        radius: 8
                        opacity: (delegate.model.index != 0 && chat.messages_list.get(delegate.model.index - 1).ip == delegate.model.ip) ? 0 : 1

                        Image {
                            anchors.centerIn: parent
                            width: 32
                            height: 32
                            source: "icons/user.svg"
                        }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: chat.get_theme("message_shadow")
                        }
                    }

                    Rectangle {
                        id: messagebox
                        implicitWidth: (messagebox_text.implicitWidth > 600) ? 600 : messagebox_text.implicitWidth
                        implicitHeight: messagebox_text.height
                        Layout.preferredWidth: implicitWidth + 32
                        Layout.preferredHeight: implicitHeight + 32
                        Layout.alignment: Qt.AlignBottom
                        border.width: 1
                        border.color: chat.get_theme("chat_object_border")
                        color: chat.get_theme("message")
                        radius: 8
                        clip: true
                        Text {
                            id: messagebox_text
                            width: parent.implicitWidth
                            wrapMode: Text.WordWrap
                            anchors.centerIn: parent
                            anchors.margins: 16
                            text: delegate.model.message
                            font.family: "Inter"
                            font.pixelSize: 16
                            color: chat.get_theme("text")
                        }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: chat.get_theme("message_shadow")
                        }
                    }
                }
            }
            add: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: "x"; from: (messages_view.width) / 2; to: 0; duration: 400 }
            }
            displaced: Transition {
                NumberAnimation { property: "opacity"; to: 1; duration: 0}
                NumberAnimation { property: "scale"; to: 1; duration: 0}
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

        LinearGradient {
            id: mask
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.98
                    color: "transparent"
                }
                GradientStop {
                    position: 1
                    color: chat.get_theme("chat")
                }
            }
            visible: (chat.connected) ? true : false
        }
    }
    
    // Блок отправки сообщений
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 78
        visible: (chat.connected) ? true : false
        color: chat.get_theme("chat")

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            anchors.topMargin: 6
            spacing: 10

            // Кнопка прикрепления файлов
            Rectangle {
                id: attach_file
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                border.color: chat.get_theme("chat_object_border")
                color: chat.get_theme("chat_object")
                radius: 8

                Image {
                    anchors.centerIn: parent
                    width: 32
                    height: 32
                    source: "icons/attach-file-add.svg"
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
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

            // Поле ввода сообщения
            Rectangle {
                id: message_field
                Layout.fillWidth: true
                Layout.preferredHeight: 56
                border.width: 1
                border.color: chat.get_theme("chat_object_border")
                color: chat.get_theme("chat_object")
                radius: 8
                clip: true

                TextInput {
                    id: message_input
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    font.pixelSize: 24
                    color: chat.get_theme("text")
                    property string placeholderText: "Введите ваше сообщение..."
                    Text {
                        text: parent.placeholderText
                        font.family: "Inter"
                        font.pixelSize: parent.font.pixelSize
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        color: chat.get_theme("placeholder")
                        visible: !parent.text
                    }
                    Keys.onReturnPressed: {
                        if(!!message_input.text && message_input.text.trim().length > 0) {
                            chat.add_message(chat.name, chat.ip, message_input.text)
                            message_input.text = ""
                        }
                    }
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    z: -1

                    onEntered: {
                        parent.scale = 1.01
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 143
                Layout.preferredHeight: 56
                border.width: 1
                border.color: chat.get_theme("chat_object_border")
                color: chat.get_theme("chat_object")
                radius: 8
                Text {
                    anchors.centerIn: parent
                    text: "Отправить"
                    font.family: "Inter"
                    font.pixelSize: 24
                    color: chat.get_theme("text")
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: send_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if(!!message_input.text && message_input.text.trim().length > 0) {
                            chat.add_message(chat.name, chat.ip, message_input.text)
                            message_input.text = ""
                            control.send_message(chat.name, chat.ip, message_input.text)
                        }
                    }

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.06
                    }

                    onEntered: {
                        parent.scale = 1.06
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }
        }
    }
}